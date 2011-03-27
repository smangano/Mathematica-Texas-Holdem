(* Mathematica Package *)

(*Mathematica Code for Texas Hold'em *)
(* Copyright 2011 Sal Mangano. All rights reserved *)

BeginPackage["TexasHoldem`"]
ClearAll["TexasHoldem`*"] ;

(* Useful constants *) 

FOLD::usage = "The value to return from the bet[] function when a player wants to fold his hand." ;
CHECK::usage = 
  "The value to return from the bet[] function when a player wants to check (assuming checking is a valid option at that time)" ;
Jack::usage = "Numerical value of a jack (11)"
Queen::usage = "Numerical value of a queen (12)";
King::usage = "Numerical value of a king (13)" ;
Ace::usage = "Numerical value of a ace (14)"
Clubs::usage = "A club symbol" ;
Diamonds::usage = "A diamond symbol" ;
Hearts::usage = "A heart symbol" ;
Spades::usage = "A spade symbol" ;
Deck::usage = "A list of {card[rank, suit], ...} for a standard deck" ;
random::usage = "card placeholder for a random rank, suit or both. Examples: card[random[]], card[random[],Clubs]" ;
suited::usage = "card placeholder for a card whose suit matches previous card. Examples: card[suited[]], card[10,suited[]]" ;
offsuit::usage = "card placeholder for a card whose suit does not match previous card. Examples: card[offsuit[]], card[10,offsuit[]]" ;
connector::usage = "card placeholder for a card whose rank is consecutive to previous card. Examples: card[connector[]], card[connector[],suited[]]" ;
pair::usage = "card placeholder for a card whose rank is the same as previous card." ;

(*Symbols used for stages of the game. Also known as streets.*)
Hands::usage = "The stage when hands are delt. (preflop)";
Preflop::usage = "Alias for Hands" ;
Flop::usage = "The stage when first three community cards are layed down";
Turn::usage = "The stage when the fourth community card is layed down";
River::usage = "The stage when the fifth (last) community card is layed down";
Showdown::usage = "The stage when all beeting is done and at least two players have not folded";

suitToIndex::usage = "Convert from suit symbol to an index:
Clubs    -> 1
Diamonds -> 2
Hearts   -> 3
Spades   -> 4
" ;

suitQ::usage = "Test if input is a suit sysmbol" ;

(* Stage testing predicates *)
handsQ::usage ="handsQ[symbol] returns True when symbol == Hands (or Preflop)";
flopQ::usage = "flopQ[symbol] returns True when symbol == Flop" ;
turnQ::usage = "turnQ[symbol] returns True when symbol == Turn" ;
riverQ::usage = "riverQ[symbol] returns True when symbol == River" ;
showdownQ::usage = "showdownQ[symbol] returns True when symbol == Showdown" ;

card::usage = "card[rank, suit] represents a card in the deck" ;

(*Hand Predicates *)
pairQ::usage = "pairQ[{card[_,_]...] returns true if there are at least two cards with same rank" ;
twoPairQ::usage = "twoPairQ[{card[_,_]...] returns true if there are at least two cards of one rank and two cards of another rank" ;
tripsQ::usage = "" ;
quadsQ::usage = "" ;
flushQ::usage = "" ;
fullHouseQ::usage = "" ;
straightQ::usage = "" ;
aceLowStraightQ::usage = "";
straightFlushQ::usage = "" ;
aceLowStraightFlushQ::usage="";
royalFlushQ::usage = "" ;
possiblePairQ::usage = "" ;

(*Hand Extractions *)
highCard::usage = "" ;
straightFlush::usage = "";
quads::usage = "" ;
fullHouse::usage = "fullHouse[c_List] - extract full house if it exist" ;
flush::usage = "" ;
straight::usage = "straight[c_List] -" 

trips::usage = "" ;
twoPair::usage = "" ;
pair::usage = "" ;

highCardRank::usage = "";
handRanking::usage = "" ;

winners::usage="";
winnerPos::usage="winnerPos[g_Game] - returns list of positions of winners in Game g at River" ;

shuffle::usage = "" ;
fixedShuffle::usage="fixedShuffle[c__card,deck_List] - shuffle the deck but fix it by ensuring c cards are in front. Useful for testing"
deal::usage = "deal[p_Integer] - shuffle the Deck and deal out cards to p players" ;
fixedDeal::usage = "fixedDeal[p_Integer, deck_List] - deal out the supplied deck to n players without shuffling" ;



(* Game *) 

Game::usage = "Game[Hands[{{p1c1,p2c2},...}],Flop[{p1c3,...}}],Turn[{p1,c4,...}],River[{p1c5]]";

game::usage = "game[p_Integer] - create a game of p players using shuffled Deck" ;

fixedGame::usage = "fixedGame[p_Integer, deck_List] - crate a game of p players 
 using supplied deck with no shuffling";

hand::usage = "hand[g_Game, p_Integer, stage_Symbol] - get the hand p has at stage" ;
hands::usage= "hand[g_Game, stage_Symbol] - get all the hands at stage" ;
holeCards::usage ="holeCards[g_Game, p_Integer] - extract hole cards for player p";
flop::usage = "
 flop[g_Game] - extract the flop from the game.
 flop[deck_List] - deal the flop from deck returning {flop, remaining}" ;
 
turn::usage = "
 turn[g_Game] - extract the turn from the game.
 turn[deck_List] - deal the turn from deck returning {turn, remaining}" ;
 
river::usage = "
 river[g_Game] - extract the river from the game.
 river[deck_List] - deal the river from deck returning {river, remaining}" ;

outs::usage = "" ;

outPercents::usage = "" ;


(* Money Game *)
Dealer::usage="Dealer[p_Integer] - player on the button";
Blinds::usage = "Blinds[big_Integer, small_Integer, antes_Integer] - keeps track of blinds";
MoneyGame::usage = "MoneyGame[Game[...], Dealer[i],Blinds[big,small,ante]]";
Stacks::usage = "Stacks[\[InvisiblePrefixScriptBase]\[InvisiblePrefixScriptBase]\!\(\*SubscriptBox[\(pChips\), \(1\)]\), ..., \!\(\*SubscriptBox[\(pChips\), \(n\)]\)] - track the chip stacks of each player";
Pot::usage = "Pot[\!\(\*SubscriptBox[\(c\), \(1\)]\),\!\(\*SubscriptBox[\(c\), \(2\)]\), ...] - represents the money up for grabs in a round of play. When players go all in it can result in multiway pots. In this case, \!\(\*SubscriptBox[\(c\), \(1\)]\) is the main pot, \!\(\*SubscriptBox[\(c\), \(2\)]\) is the first side pot and so on"
Bets::usage = "Bets[pb1,pb2,...] contatains a list of player bets, \!\(\*SubscriptBox[\(pb\), \(n\)]\). Each \!\(\*SubscriptBox[\(pb\), \(i\)]\) is a list of length 4 of integer bets that oocured  {preflop,flop,turn,river}. Zero means no bet was made and -1 means player folded. " ;
Strategies::usage = "Strategies[\!\(\*SubscriptBox[\(strategy\), \(1\)]\), ..., \!\(\*SubscriptBox[\(Strategy\), \(n\)]\)] - track the current strategy employed by each player";
Strategy::usage = "Strategy[style,state___] - represents the current strategy used by a player. A strategy will typically consist of a style and optional state info associated with that style. The strategy is passed to the betting function and a new strategy can be returned by the function along with the bet. This allows for sophisticated strategies that dynamically update as the game progresses. The state info frees the betting function from having to keep private state externally from the game";
Action::usage = "Action[initiator_Integer, lastToAct_Integer, inAction_List, nextToAct_List] - 
	initiator - player who initiated the current lelel of betting (big blind at start of betting)
	lastToAct - player who last put money into the pot (big blind, initator or last to call initator)
	inAction - list of all players (in order) who called the initiator (includes initiator)
	nextToAct - list of players who are left to act on the initiator (have not folded and not inclding current player)
	";
	
moneyGame::usage= "
moneyGame[players_Integer, button_Integer, bigBlind_Integer, smallBlind_Integer, antes_Integer] - 
 Construct a new MoneyGame
moneyGame[game_Game, button_Integer, bigBlind_Integer, smallBlind_Integer, antes_Integer] -
 Construct a MoneyGame from an exiting game" ;

game::usage= "game[m_MoneyGame] - extract the game component" ;
button::usage = "button[m_MoneyGame] - extract the player on the button (dealer)" ;
smallBlind::usage = "smallBlind[m_MoneyGame] - extract the small blind amt" ;
bigBlind::usage = "bigBlind[m_MoneyGame] - extract the big blind amt" ;
antes::usage = "antes[m_MoneyGame] - extract the ante amt" ;
numPlayers::usage = "numPlayers[m_MoneyGame] or numPlayers[g_Game] - extract the number of players";


stacks::usage = "stacks[p_Integer, c_Integer] - construct chip stacks for p players each with c chips" ;
stack::usage = "stack[s_Stacks, player_Integer]" ;
updateStacks::usage = "updateStacks[s_Stacks, bet_Integer, player_Integer]" ;
allInPlayers::usage = "allInPlayers[s_Stacks]" ;
nonAllInPlayers::usage = "nonAllInPlayers[s_Stacks]" ;
allInQ::usage = "
 allInQ[s_Stacks] - is any stack all in
 allInQ[s_Stacks,player_Integer] - is the player's stack all in
";

pot::usage = "
  	pot[] - cretae a pot with no chips
  	pot[p] - create a pot with p chips
  	pot[Pot[p__],bet] - create a pot by adding a bet to most recent pot
  	pot[Pot[p1,p2,...],bet,which] - create a pot by adding bet to a \
multiway pot at position which. If which is greater than number of \
side pots then a new side pot is started.
pot[h_Holdem] - extract pot from a Holdem" ; 

payout::usage="payout[stacks_Stacks, pot_Pot, winners_List, whichPot_Integer]";

actionInit::usage ="actionInit[game_MoneyGame] - Initialize action at start of game";

actionCall::usage ="actionCall[action_Action, player_Integer] - 
 Action when player calls" ;

actionFold::usage ="actionFold[action_Action, player_Integer] - 
 Action when player folds" ;

actionCheck::usage ="actionFold[action_Action, player_Integer] -
Action when player checks" ;

actionRaise::usage ="actionRaise[action_Action, player_Integer] -
 Action when player raises" ;

actionBet::usage ="actionBet[a_Action, player_Integer] -
 Action after a bet";
 
actionReset::usage = "
  actionReset[action_Action, button_Integer] - After flop make sure action has button last to act.
  actionReset[action_Action] - After flop, turn and river move in action to next to act. actionReset[action_Action, button_Integer]
  invokes actionReset[action_Action] after adjusting for the button.
  ";
  
nextToAct::usage ="actionNextToPlay[action_Action] - 
  return the plaer who is next to act";

initiator::usage = "initiator[action_Action]- Extract initiator from action" ;
lastToAct::usage = "lastToAct[action_Action] - Extract last player to act from action" ; 
inAction::usage = "inAction[action_Action] - Exatract all players in the action" ;
nextToActList::usage = "nextToActList[action_Action] - Exatract players who still must act"  ;
nextToAct::usage = "nextToAct[action_Action] - Exatract player who must act next"  ; 

potsGoodQ::usage = "True if the round of betting is done for the current stage (there is no one left to act)";
handDoneQ::usage = "True if the hand is done due to only one player being in the action. NOTE: The hand could also end by reaching the showdown stage. This predicate does not test that.";

isFoldQ::usage = "isFoldQ[betAmt_]" ;
isCheckQ::usage = "isCheckQ[betAmt_]" ;
isRaiseQ::usage = "isRaiseQ[betAmt_, game_Holdem]" ;
isCallQ::usage = "isCallQ[betAmt_, game_Holdem, player_Integer] " ;
isValidCheckQ::usage = "isValidCheckQ[game_Holdem,player_]";
isValidBetAmtQ::usage = "isValidBetAmtQ[game_Holdem, betAmt_, player_Integer]";
isValidRaiseQ::usage = "isValidRaiseQ[game_Holdem, betAmt_]";
isValidCallQ::usage = "isValidCallQ[betAmt_, game_Holdem, player_Integer]" ;

makeBets::usage = "makeBets[players_Integer]" ;
updateBets::usage = "updateBets[bets_List, stage_Symbol,bet_Integer]" ;
updateBets::usage = "updateBets[bets_Bets, player_Integer, stage_Symbol,bet_Integer]" ;
getBet::usage = "getBet[bets_Bets,player_Integer,stage_Symbol] ";
foldedQ::usage = "foldedQ[bets_Bets,player_Integer,stage_Symbol]" ; 


(**)
Holdem::usage = "Holdem[MoneyGame[...], minBet_Integer,maxBet_Integer,Pot[...],Bets[...],Action[...],Stacks[...],Strategies[...],stage]";
moneyGame::usage = "moneyGame[Holdem[g_MoneyGame,___]]" ;

minMaxBet::usage = "minMaxBet[h_Holdem]" ;
minBet::usage = "minBet[h_Holdem] " ;
maxBet::usage = "maxBet[h_Holdem] " ;

bets::usage = "bets[h_Holdem]" ;
playerBets::usage = "playerBets[h_Holdem, player_Integer]" ;
stacks::usage = "stacks[h_Holdem]" ;
action::usage = "action[h_Holdem]" ;
strategies::usage = "strategies[h_Holdem]" ;
strategy::usage ="strategy[h_Holdem, player_Integer]" ;
stage::usage ="stage[Holdem[___,stage_Symbol]]" ;
holdemStart::usage ="holdemStart[moneyGame_MoneyGame,stacks_Stacks, strategies_Strategies]" ;
newHoldem::usage =
 "newHoldem[h_Holdem, newPot_Pot, newBets_Bets, newAction_Action, newStacks_Stacks, newStrategies_Strategies,stage_Stage]" ;
gameOverQ::usage ="
gameOverQ[action_action] -
gameOverQ[holdem_Holdem] -"

bet::unknownStrategy = "The strategy `1` is not known. Using Strategy[\"random\"] instead" ;
bet::invalidBet = "The amount `1` is an invalid bet for player `2`" ;
bet::usage = "The bet function takes a holdem game and a strategy and returns a list {bet, strategy} where bet is how much this stratgy wants to bet and stratgey is the state it wants to tranistion to for future bets";

Begin["`Private`"]

(* CONSTANTS *)
FOLD = -1 ;
CHECK = 0 ;
{Jack,Queen,King,Ace} = {11,12,13,14};
{Clubs,Diamonds,Hearts,Spades} = SymbolName/@{\[ClubSuit],\[DiamondSuit],\[HeartSuit],\[SpadeSuit]};
Deck = Flatten[Outer[card,{2,3,4,5,6,7,8,9,10,Jack,Queen,King,Ace},{Clubs,Diamonds,Hearts,Spades} ]];
N[Hands] ^= 1 ;
N[Flop] ^= 2 ;
N[Turn] ^= 3;
N[River] ^= 4 ;
N[Showdown] ^= 5;
Preflop = Hands; (*Alias for Hands*)

suitToIndex["\[ClubSuit]"] = 1;
suitToIndex["\[DiamondSuit]"] = 2;
suitToIndex["\[HeartSuit]"] = 3;
suitToIndex["\[SpadeSuit]"] = 4;

suitQ[Hearts|Diamonds|Clubs|Spades] := True
suitQ[_] := False

handsQ[Hands] := True
handsQ[_] := False
flopQ[Flop] := True
flopQ[_] := False
turnQ[Turn] := True
turnQ[_] := False
riverQ[River] := True
riverQ[_] := False
showdownQ[Showdown] := True
showdownQ[_] := False

(* HAND PREDICATES *)

(*pairQ - At least a pair*)

pairQ[c_List] := MatchQ[c,{___,card[a_,_],___,card[a_,_],___}]

possiblePairQ[c_List,rem_Integer] := pairQ[c] || rem > 0 

(*twoPairQ - At least two pair*)
twoPairQ[c_List] := MatchQ[SortBy[c,First],{___,card[a1_,_],card[a1_,_],___,card[a2_,_],card[a2_,_],___}]

tripsQ[c__List] := MatchQ[c,{___,card[a_,_],___,card[a_,_],___,card[a_,_],___}]


quadsQ[c__List] := MatchQ[c,{___,card[a_,_],___,card[a_,_],___,card[a_,_],___,card[a_,_],___}]


flushQ[c_List] :=MatchQ[Tally[c, #1[[2]] ==  #2[[2]]&],{___,{card[__],x_/;x>4},___}]

fullHouseQ[c_List] := MatchQ[SortBy[Tally[c, #1[[1]] ==  #2[[1]]&],-Last[#]&],{___,{___,card[__],x_/;x>2},{___,card[__],y_/;y>1},___}]

straightQ[c_List] := 
Module[{ranks =Union[First/@ c]},
(*An ace can be low or high card so add 1 if ace exists *)
PrependTo[ranks,If[MemberQ[ranks,Ace],1,Sequence[]]];
MatchQ[ranks ,{___,h_,s__,___}/; NestList[#+1&,h,4] ==  {h,s}]
]

(*Detecting an Ace Low straight is important when ranking strights*)
aceLowStraightQ[c_List] := If[Count[c,card[Ace,_]]>0,
straightQ[c //. card[Ace,s_] :>  card[1,s]],
False]

straightFlushQ[c_List] := MatchQ[SortBy[c,First],
	{___,card[v_,s1_],___,card[w_,s1_],___,card[x_,s1_],___,card[y_,s1_],___,card[z_,s1_],___}/; w== v+1&& x== v+2 && y== v+3 && z== v+4] ||
	aceLowStraightFlushQ[c]
	
aceLowStraightFlushQ[c_List] := MatchQ[SortBy[c,First],
	{___,card[2,s1_],___,card[3,s1_],___,card[4,s1_],___,card[5,s1_],___,card[14,s1_],___}]
	
royalFlushQ[c_List] := MatchQ[SortBy[c,First],{___,card[10,s1_],___,card[11,s1_],___,card[12,s1_],___,card[13,s1_],___,card[14,s1_],___}]

highCard[{},_Integer:1] := Null
highCard[c_List,n_Integer:1] :=With[{c2 = Union[c,SameTest-> (First[#1] ==  First[#2]&)]},If[Length[c2] < 2,First[c2],Part[c2, First[Ordering[c2,-n,(#1[[1]]< #2[[1]]&)]]]]]

straightFlush[c_List] := If[straightFlushQ[c],
 SortBy[c, 
   First] /. {Longest[___], card[v_, s1_], ___, card[w_, s1_], ___, 
     card[x_, s1_], ___, card[y_, s1_], ___, card[z_, s1_], ___} /; 
    w == v + 1 && x == v + 2 && y == v + 3 && (z == v + 4 || (v == 2 && z == 14)) :> {card[v, 
     s1], card[w, s1], card[x, s1], card[y, s1], card[z, s1]},
     {}]
     
quads[c_List] := 
 Flatten[Cases[{SortBy[c,-First[#]&]},{___,card[a1_,s1_],card[a1_,s2_],card[a1_,s3_],card[a1_,s4_],___} :>  {card[a1,s1],card[a1,s2],card[a1,s3],card[a1,s4]},1,1]]

fullHouse[c_List] := 
 Flatten[Cases[{SortBy[
     c, -First[#] &]}, {___, card[a1_, s1_], card[a1_, s2_], ___, 
      card[a2_, s3_], ___, card[a3_, s4_], card[a3_, s5_], ___} /; 
     a1 == a2 || a2 == a3 :> {card[a1, s1], card[a1, s2], 
     card[a2, s3], card[a3, s4], card[a3, s5]}, 1, 1]]

flush[c_List] := If[flushQ[c],
 SortBy[c, 
   First] /. {Longest[___], card[v_, s1_], ___, card[w_, s1_], ___, 
     card[x_, s1_], ___, card[y_, s1_], ___, card[z_, s1_], ___} :> {card[v, 
     s1], card[w, s1], card[x, s1], card[y, s1], card[z, s1]}, 
     {}]
        
straight[c_List] := If[straightQ[c],
 SortBy[c, 
   First] /. {Longest[___], card[v_, s1_], ___, card[w_, s2_], ___, 
     card[x_, s3_], ___, card[y_, s4_], ___, card[z_, s5_], ___} /; 
    w == v + 1 && x == v + 2 && y == v + 3 && (z == v + 4 || (v == 2 && z == 14)) :> {card[v, 
     s1], card[w, s2], card[x, s3], card[y, s4], card[z, s5]}, 
        {}]
     
trips[c_List] := Flatten[Cases[{SortBy[c,-First[#]&]},{___,card[a1_,s1_],card[a1_,s2_],card[a1_,s3_],___} :>  {card[a1,s1],card[a1,s2],card[a1,s3]},1,1]]

twoPair[c_List] := Flatten[Cases[{SortBy[c,-First[#]&]}, {___,card[a1_,s1_],card[a1_,s2_],___,card[a2_,s3_],card[a2_,s4_],___} :>  {card[a1,s1],card[a1,s2],card[a2,s3],card[a2,s4]},1,1]]

pair[c_List] :=Flatten[Cases[{SortBy[c,-First[#]&]}, {b1___,card[a1_,s1_],card[a1_,s2_],b2___} :>  {card[a1,s1],card[a1,s2]},1,1]]

highCardRank[{}] := 0
highCardRank[c_List] :=First[highCard[c]]
highCardRank[{},n_Integer] := 0
highCardRank[c_List,n_Integer] :=First[highCard[c,n]]

bestOf[c_List] := Which[
  straightFlushQ[c], straightFlush[c],
  quadsQ[c], quads[c],
  fullHouseQ[c], fullHouse[c],
  flushQ[c], flush[c],
  straightQ[c], straight[c],
  tripsQ[c], trips[c],
  twoPairQ[c], twoPair[c],
  pairQ[c], pair[c],
  True, highCard[c]
  ]
  
  
(*franker - helps to rank flushs by treating the descending ranks as a base 15 number and normalizing
to a value between 1 and 3*)
franker[x_List] := 2*N[ FromDigits[SortBy[x, -# &], 15]/(13^Length[x])]
kickerRank[c_List, h_List] := highCardRank[Complement[c,h]]
kickerRank[c_List, h_List,n_Integer] := highCardRank[Complement[c,h],n]

handRanking[c_List] := Which[
straightFlushQ[c],Floor[15^9*If[aceLowStraightFlushQ[c],1,franker[First /@ c]]],
quadsQ[c],15^8 * highCardRank[quads[c]]+kickerRank[c,quads[c]],
fullHouseQ[c], With[{h=trips[c]},15^7 * highCardRank[h] + kickerRank[c,h]],
flushQ[c], Floor[15^6*franker[First /@ c]],
straightQ[c], 15^5*If[aceLowStraightQ[c],1,highCardRank[c]] ,
tripsQ[c],With[{h=trips[c]},15^4 *highCardRank[h]+kickerRank[c,h]],
twoPairQ[c], With[{h=twoPair[c]},15^3 * (highCardRank[h]+highCardRank[h,2])],
pairQ[c], With[{h=pair[c]},15^2 * highCardRank[h] +kickerRank[c,h]+kickerRank[c,h,2]],
True,Floor[100*franker[First /@ c]]
]

winners[hands_List] := Module[{},
First[GatherBy[SortBy[hands,-handRanking[#]&],-handRanking[#]&]]]

winnerPos[g_Game] := Module[{w,h},
	h = Table[hand[g, p, River], {p, 1, numPlayers[g]}];
	w = winners[h];
	Flatten[Position[h,#]& /@ w]
	]
	
shuffle[deck_]:=RandomSample[deck,Length[deck]]

fixedShuffle[c__card, deck_] := 
	Join[{c},DeleteCases[shuffle[deck], Alternatives[c]]]

deal[players_Integer] := fixedDeal[players,shuffle[Deck]]

fixedDeal[players_Integer,deck_List] :=
	{Transpose[Partition[Take[deck,players*2],players]],Drop[deck,players*2]}
	
flop[deck_List] := {deck[[{2,3,4}]],Drop[deck,4]}

turn[deck_List] := {deck[[2]],Drop[deck,2]}

river[deck_List] := {deck[[2]],Drop[deck,2]}

game[players_Integer] := gameImpl[deal[players]]


fixedGame[players_Integer, deck_Deck] := 
	gameImpl[fixedDeal[players,deck]]

gameImpl[deal_] :=
 Module[{d2,h,f,t,r},
{h,d2} = deal;
{f,d2} = flop[d2];
{t,d2} = turn[d2];
{r,d2} = river[d2];
Game[Hands[h],Flop[f],Turn[{t}],River[{r}]]
]

numPlayers[g_Game] := Length[g[[1, 1]]] 

hand[g_Game,player_Integer,stage_Symbol] := Module[{s},
s=Apply[List,g /. Game[a___,stage[b_],___] :>  {a,stage[b]},2];
Flatten[Join[s[[1,1,player]],Rest[s]]]]

hands[g_Game, stage_Symbol] := 
 Module[{s},
  s = Apply[List, g /. Game[a___, stage[b_], ___] :> {a, stage[b]}, 2];
  Flatten[Join[s[[1, 1]], Rest[s]]]]

holeCards[g_Game, p_Integer] := g[[1,1,p]]
flop[g_Game] := g[[2]]
turn[g_Game] := g[[3]]
river[g_Game] := g[[4]]


outs[hands_List,communityCards_List] := Module[{possSets,w},
(*Every possible set of cards that can be dealt from remaining deck*)
possSets = Subsets[Complement[Deck, Join[communityCards,Flatten[hands]]], {5 - Length[communityCards]}];
(*List the winners for each possible game that remains to be dealt*)
w = winners/@Transpose[Outer[Union[#1,communityCards,#2]&,hands, possSets,1]];
(*Count how often each hand is a winner and return list of counts*)
Length /@ Table[Select[Flatten /@ w,(Length[Intersection[h,#]]>0&)],{h, hands}]
]

outPercents[hands_List,communityCards_List] := Module[{o},
o = outs[hands,communityCards] ;
N[#/Total[o]]& /@ o
]

(*Money Game  *)

moneyGame[players_Integer, button_Integer, bigBlind_Integer, smallBlind_Integer, antes_Integer] :=
MoneyGame[game[players], Dealer[button],Blinds[bigBlind, smallBlind, antes]]
moneyGame[game_Game, button_Integer, bigBlind_Integer, smallBlind_Integer, antes_Integer] :=
MoneyGame[game, Dealer[button],Blinds[bigBlind, smallBlind, antes]]

(*moneyGame accessors*)
game[MoneyGame[g_Game,___]] := g
button[MoneyGame[__,Dealer[btn_],___]] := btn
smallBlind[MoneyGame[__,Blinds[_,sb_,_],___]] := sb
bigBlind[MoneyGame[__,Blinds[bb_,_,_],___]] := bb
antes[MoneyGame[__,Blinds[_,_,a_],___]] := a

numPlayers[g_MoneyGame] := numPlayers[g[[1]]]

stacks[players_Integer, chips_Integer] := Stacks@@Table[chips,{players}]
stack[s_Stacks, player_Integer] := s[[player]]
updateStacks[s_Stacks, bet_Integer, player_Integer] := MapAt[#1-bet&,s, player]
allInPlayers[s_Stacks] := Flatten[Position[s,0]]
nonAllInPlayers[s_Stacks] := Flatten[Position[s,c_Integer/; c> 0]]
allInQ[s_Stacks] := Length[allInPlayers[s]] > 0
allInQ[s_Stacks,player_Integer] := s[[player]] == 0

pot[] := Pot[0]
pot[p_Integer] := Pot[p]
(* Update last pot *)
pot[Pot[p1___Integer, p2_Integer], bet_Integer] := Pot[p1, p2 + bet]
(* update a specific side pot *)
pot[Pot[p__Integer], bet_Integer, which_Integer] /; 
  which <= Length[{p}] :=  MapAt[# + bet &, Pot[p], which]
(* start a new side pot *)
pot[Pot[p__Integer], bet_Integer, which_Integer] :=  Pot[p, bet]

payout[stacks_Stacks, pot_Pot, winners_List, whichPot_Integer] := 
 Module[{winnings},
  winnings = Part[pot, whichPot]/Length[winners];
  MapAt[# + winnings &, stacks, List /@ winners]
  ]

(***************************************************************************)
(*    ACTION  - maintains players state wrt to current betting             *)
(***************************************************************************)
  

(*Action at the start of game *)

actionInit[game_MoneyGame] := 
Module[{nPlayers,players,btn,bb},
nPlayers = numPlayers[game];
btn = button[game];(* first to act is first in list *)
players=RotateLeft[Range[nPlayers],btn+2];
bb = Last[players];
Action[bb,bb,{bb},Drop[players,-1]]
]

(*Action when player calls *)
actionCall[Action[init_,_,inAction_,nextToAct_], player_Integer] :=
Module[{},
Assert[player == First[nextToAct]];
Action[init, player,Append[inAction,player],Drop[nextToAct,1]]
]

(*Action when player folds *)
actionFold[Action[init_,last_,inAction_,nextToAct_], player_Integer] :=
Module[{},
Assert[player == First[nextToAct]];
Action[init, last,inAction,Drop[nextToAct,1]]
]

(*Action when player checks *)
actionCheck[Action[init_,last_,inAction_,nextToAct_], player_Integer] :=
Module[{},
Assert[player == First[nextToAct]];
Action[init, last,inAction,RotateLeft[nextToAct,1]]
]

(*Action when player raises *)
actionRaise[Action[init_,last_,inAction_,nextToAct_], player_Integer] :=
Module[{},
Assert[player == First[nextToAct]];
Action[player, player,{player},Join[Drop[nextToAct,1],inAction]]
]

(*An initial bet acts the same as a raise *)
actionBet[a_Action, player_Integer] := actionRaise[a,player] 

initiator[action_Action] := First[action]
lastToAct[action_Action] := action[[2]]
inAction[action_Action] := action[[3]]
nextToActList[action_Action] := action[[4]]
nextToAct[action_Action] := 
Module[{nta},nta=nextToActList[action];If[Length[nta] > 0,nta[[1]],Null]]

potsGoodQ[action_Action] := Length[nextToActList[action]] == 0
handDoneQ[action_Action] := Length[inAction[action]] == 1 && potsGoodQ[action]
isFoldQ[betAmt_] := betAmt == FOLD 
isCheckQ[betAmt_] := betAmt == CHECK

actionReset[Action[init_,last_,inAction_,{}], button_Integer, nPlayers_Integer] := 
Module[{nta,n=nPlayers+1},
	(*normalize player numbers wrt the button as origin, sort. then restore to original values*)
	nta = Mod[Sort[Mod[inAction - button, n]] + button, n];
	(*At this point the players are in the right order except for the button, if present. So check and rotate
	button to last to act if he is still in the hand*)
    nta = If[First[nta] == button, RotateLeft[nta], nta];
    (*Return the reset action remembering initiator and last from prior round *)
	Action[init,last,{},nta] 
	]


isValidCheckQ[game_Holdem,player_] := 
Module[{curAction,curStage, ia, lastPlayer },
curAction = action[game] ;
ia = inAction[curAction] ;
(* If no one in action, check is valid *)
If[Length[ia] == 0, Return[True]];
curStage = stage[game] ;
lastPlayer = Last[ia] ;
(*if last in action checked then check is valid *)
Return[playerBet[game,lastPlayer,curStage] == CHECK]
]

isValidBetAmtQ[game_Holdem, betAmt_, player_Integer] :=
Module[{},
	betAmt == Floor[betAmt] && (*whole number*)
	betAmt >=  minBet[game]  && (* meets min *)
	betAmt <= maxBet[game] && (* meets max *)
	betAmt <= stack[game, player] (* not more than players chips *)
]

isValidRaiseQ[game_Holdem, betAmt_] := 
Module[{curAction,curStage, ia, lastPlayer, player},
curAction = action[game] ;
ia = inAction[curAction] ;
player = nextToAct[curAction];
(* If no one in action, raise is valid (its a bet)*)
If[Length[ia] == 0, Return[True]];
curStage = stage[game] ;
lastPlayer = Last[ia] ;
(*if valid amt and last in action bet less than betAmt then this is a raise *)
Return[isValidBetAmtQ[game,betAmt,player] && 
	playerBet[game,lastPlayer,curStage] < betAmt]
]

isValidCallQ[betAmt_, game_Holdem, player_Integer] := 
Module[{curAction,curStage, ia, lastPlayer},
curAction = action[game] ;
ia = inAction[curAction] ;
(* If no one in action, then thsi is not a calling situation*)
If[Length[ia] == 0, Return[False]];
curStage = stage[game] ;
lastPlayer = Last[ia] ;
(*if valid amt and last in action bet less than betAmt then this is a raise *)
Return[isValidBetAmtQ[game,betAmt,player] && 
	playerBet[game,lastPlayer,curStage] == betAmt]
]





(*Holdem - The State of a Holdem game in play *)
moneyGame[Holdem[g_MoneyGame,___]] := g
minMaxBet[Holdem[_MoneyGame,min_Integer,max_Integer,___]] := {min,max}
minBet[h_Holdem] := First[minMaxBet[h]]
maxBet[h_Holdem] := Part[minMaxBet[h],2]
pot[Holdem[___,pot_Pot,___]] := pot
bets[Holdem[___,bets_Bets,___]] := bets
playerBets[h_Holdem, player_Integer] := bets[h][[player]] 
playerBet[h_Holdem, player_Integer,stage_Symbol] := bets[h][[player]][[Floor[N[stage]]]] 
stacks[Holdem[___,stacks_Stacks,___]] := stacks
stack[h_Holdem,player_Integer] := stacks[h][[player]]
action[Holdem[___,action_Action,___]] := action
strategies[Holdem[___,strategies_Strategies,___]] := strategies
strategy[h_Holdem, player_Integer] := strategies[h][[player]]
stage[Holdem[___,stage_Symbol]] := stage

holdemStart[moneyGame_MoneyGame,stacks_Stacks, strategies_Strategies] :=
Holdem[moneyGame, 
	bigBlind[moneyGame],
	Max@@stacks,
	pot[],
	makeBets[numPlayers[moneyGame]],
	actionInit[moneyGame],
	stacks,
	strategies,
	Hands]
	
newHoldem[h_Holdem, newPot_Pot, newBets_Bets, newAction_Action, newStacks_Stacks, newStrategies_Strategies,stage_Stage] :=
Holdem[moneyGame[h], 
	minBet[h],
	maxBet[h],
	newPot,
	newBets,
	newAction,
	newStacks,
	newStrategies,
	stage]
gameOverQ[action_action]:=Length[nextToActList[action]] == 0 && Length[inAction[action]] == 1
gameOverQ[holdem_Holdem] := 
Module[{},showdownQ[stage[holdem]] || gameOverQ[action[holdem]]]




makeBets[players_Integer] := Bets@@Table[{0,0,0,0},{players}]
updateBets[bets_List, stage_Symbol,bet_Integer] :=
MapAt[#+bet&,bets,Floor[N[stage]]]
updateBets[bets_Bets, player_Integer, stage_Symbol,bet_Integer] := 
Module[{},
MapAt[updateBets[#,stage,bet]&, bets, player]
]

getBet[bets_Bets,player_Integer,stage_Symbol] := 
Module[{},
 bets[[player]][[ Floor[N[stage]] ]]
]

foldedQ[bets_Bets,player_Integer,stage_Symbol] := 
getBet[bets, player,stage] == FOLD



bet[holdem_Holdem, player_Integer,Strategy["random", foldRate_]] := 
Module[{},
{ 
	If[foldRate >= RandomReal[], -1,
	RandomInteger[{minBet[holdem],Min[stack[holdem,player],maxBet[holdem]]}]], 
	Strategy["random",foldRate]
}
]

bet[holdem_Holdem, player_Integer,strategy_Strategy] := 
Module[{},
Message[bet::unknownStrategy, strategy];
bet[holdem, player,Strategy["random"]] 
]

processNextAction[game_Holdem] := Module[{curAction, newAction,
curStrategy, newStrategy, newStrategies,
curBets, newBets,
curStage,
curStacks, newStacks,
curPot, newPot,
betAmt, player},
curAction = action[game] ;
curBets = bets[game] ;
curStage = stage[game] ;
player = nextToAct[curAction] ;
curStrategy = strategy[game, player] ;
{betAmt, newStrategy} = bet[game, player, curStrategy] ;
newStrategies = strategies[game];
newStrategies[[player]] = newStrategy;
betAmt = Floor[betAmt] ;(* no fractional bets allowed! *)
newAction =Which[
isFoldQ[betAmt], actionFold[curAction,player],
isCheckQ[betAmt] && isValidCheckQ[game,player], actionCheck[curAction,player],
isRaiseQ[betAmt, game]&& isValidCheckQ[game,betAmt, player], actionBet[curAction,player],
isCallQ[betAmt, game, player] && isValidCallQ[game,betAmt, player], actionCall[curAction,player],
isRaiseQ[betAmt, game, player] && isValidRaiseQ[game,betAmt, player], actionRaise[curAction, player],
True, Message[bet::invalidBet, betAmt, player]; actionFold[curAction,player]
];
curStacks = stacks[game] ;
newStacks = updateStacks[curStacks, betAmt, player] ;
newBets=updateBets[curBets, player, curStage,betAmt] ;
curPot = pot[game] ;
(* We only update pot here if player folds *)
newPot = pot[curPot,If[foldedQ[newBets,player,curStage],getBet[curBets,player,curStage],0]];
newHoldem[game, newPot, newBets, newAction, newStacks, newStrategies,curStage] 
]
	

play[game_Holdem] := Module[{curAction},
WorkingGame = game;
curAction = action[WorkingGame] ;
FinishDynamic[] ;
While[! gameOverQ[WorkingGame],
While[! potsGoodQ[curAction],
WorkingGame = processNextAction[WorkingGame];
curAction = action[WorkingGame] ;
];
transferBets[game];
Pause[0.5];
FinishDynamic[] ;
];
]
  
End[]

EndPackage[]

