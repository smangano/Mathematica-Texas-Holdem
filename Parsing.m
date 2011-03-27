BeginPackage["TexasHoldem`Parsing`"]

Needs["TexasHoldem`"];
parseHandsInit::usage = "parseHandsInit[] - Initializes a parsing session for a set of hands and remaining cards 
that could legally be dealt from a single 52 card deck" ;
parseHands::usage = "parseHands[spec_String, options] - parse a string using an extension of standard poker notation to produce cards for the hands.
You must call parseHandsInit[] to initialize parsing for a subsequent set of calls to parseHands that is inntended to produce 
cards from a single deck. 

The syntax regognized is a follows (Cn is one of A, K, Q, J, T or 9-2 (but see 6):

1)C1C2 - any two cards of rank C1 and C2. Examples: AA, AK, A2
2)C1C2o - any two cards of of rank C1 and C2 with differing suits (o means offsuit) . Example: AKo, A2o
3)C1C2s - any two suited cards of rank C1 and C2. Examples: AKs, T9s
4)C1xC2y - two specific cards with rank C1 suit x and rank C2 suit y. Here x and y are one 
of {c,d,h,s} standing for {clubs, hearts, diamonds, spades}. Examples: 9c7d.
5) Multiple hands can be separated by 'vs' or '-'. Examples: AAvsAKs or AA-AKs
6a)Random cards: R or Rx where x is one of {c,d,h,s or r} with c,d,h,s as in (4) and r for random suit
6b)Connector cards: ACs - suited Ace connector (i.e. 2 or K of same suit as Ace), 7Co - offsuit 7 connector
                     RCs - random suited connector, JsCd - specific connector to Jack of spades (Td or Qd)
6c)Pairs: RP - random pair, RPs - random suited pair, RPo - random pair suited, AP - same as AA     
NOTE: All white space is stripped prior to parsing so you may include it for readability.
NOTE: Null will be returned in place of a card when it is impossible to create specified
hand given stadard deck. 
Options: 

init->True - calls parseHandsInit[] for you (default False)
returnDeck->True - returns hands plus the remaining shuffled deck (default False)
"; 

ParseHandsDeck::usage ="The deck used by parseHands to constrain result."

parseHand::usage = "Parse a single hand";

parseBoard::usage ="Uses a simialr (but restricted) notation as parseHands to extract the board cards. Returns
{{flop},turn,river} where card[random] is produced if there are not enough cards in the input. 
The input is in the form (Cs?)+ where C is one of {A,K,Q,J,T,R} and s is one of {h,d,c,s,r}." ;

Begin["`Private`"]

ParseHandsDeck=Deck;

parseHandsInit[] := Module[{},
ParseHandsDeck= Deck;
]

Options[parseHands] = {init->False, returnDeck->False} ;
parseHands[spec_String, opts: OptionsPattern[]] := 
Module[{spec2,initOpt, deckOpt, result},
{initOpt, deckOpt} = {OptionValue[init],OptionValue[returnDeck]};
If[initOpt,parseHandsInit[]];
spec2 =StringReplace[spec, Whitespace -> ""];
result = parseHand /@ StringSplit[spec2,{"vs","--"}];
If[deckOpt, Join[result, {shuffle[ParseHandsDeck]}], result]
]

parseBoard[board_String] := Module[{},
Map[parseCard, First[StringCases[board,
   {
    RegularExpression["^([RAKQJT2-9][rhdcs]?)$"] :> 
    	{{"$1", card[random[]], card[random[]]}, card[random[]], card[random[]]},
    RegularExpression[
      "^([RAKQJT2-9][rhdcs]?)([RAKQJT2-9][rhdcs]?)$"] :> 
      	{{"$1", "$2", card[random[]]}, card[random[]], card[random[]]},
    RegularExpression[
      "^([RAKQJT2-9][rhdcs]?)([RAKQJT2-9][rhdcs]?)([RAKQJT2-9][rhdcs]?)$"] :> 
	{{"$1", "$2", "$3"}, card[random[]], card[random[]]},
    RegularExpression[
      "^([RAKQJT2-9][rhdcs]?)([RAKQJT2-9][rhdcs]?)([RAKQJT2-9][rhdcs]?)([RAKQJT2-9][rhdcs]?)$"] :> 
	{{"$1", "$2", "$3"}, "$4", card[random[]]},
    RegularExpression["^([RAKQJT2-9][rhdcs]?)([RAKQJT2-9][rhdcs]?)([RAKQJT2-9][rhdcs]?)([RAKQJT2-9][rhdcs]?)([RAKQJT2-9][rhdcs]?)$"] :> 
	{{"$1", "$2", "$3"}, "$4", "$5"},
	StringExpression[___] :> {{card[random[]], card[random[]], card[random[]]}, card[random[]], card[random[]]}
	}
   ]],
   	{-1}] (*map leaves *)
]

 parseCard[c_String/;StringLength[c]==2] := 
 card[
 	rankLetterToNum[StringTake[c,1]],
 	suitLetterToSym[StringTake[c,{2,2}]]
 ]
 
 parseCard[c_String/;StringLength[c]==1] := 
 card[
 	rankLetterToNum[StringTake[c,1]],
 	random[]
 ]
 
 parseCard[c_] := c
 	
 

parseHand[hand_String] :=
First[StringCases[hand, 
{	
RegularExpression["[-{]"] :> parseListOrRange[hand],
RegularExpression["^([RAKQJT2-9])([RAKQJT2-9])o$"]:>  offsuitHand["$1","$2"],
RegularExpression["^([RAKQJT2-9])Co$"]:>  offsuitConnector["$1"],
RegularExpression["^([RAKQJT2-9])([RAKQJT2-9])s$"] :>  suitedHand["$1","$2"],
RegularExpression["^([RAKQJT2-9])Cs$"] :>  suitedConnector["$1"],
RegularExpression["^([RAKQJT2-9])([rcsdh])([RAKQJT2-9])([rcsdh])$"] :>  specificHand["$1","$2","$3","$4"],
RegularExpression["^([RAKQJT2-9])([rcsdh])C([rcsdh])$"] :>  specificConnector["$1","$2","$3"],
RegularExpression["^([RAKQJT2-9])([RAKQJT2-9])$"] :>  someHand["$1","$2"],
RegularExpression["^([RAKQJT2-9])C$"] :>  someConnector["$1"],
RegularExpression["^([RAKQJT2-9])P$"] :>  somePair["$1"],
RegularExpression["^([RAKQJT2-9])([rcsdh])P$"] :>  somePair["$1","$2"],
StringExpression[__]:> parseHandERROR[hand]
}
]]

parseListOrRange[hand_String] := Module[{c1,c2,so},
	{c1,c2,so} = First[StringCases[hand,
		{
		RegularExpression["^{([AKQJT2-9]+)}{([AKQJT2-9]+)}([os]?)$"] :> {parseList["$1"], parseList["$2"], "$3"},
		RegularExpression["^{([AKQJT2-9]+)}([csdh]){([AKQJT2-9]+)}$"] :> {parseList["$1","$2"], parseList["$3"], ""},
		RegularExpression["^{([AKQJT2-9]+)}([csdh]){([AKQJT2-9]+)}([csdh])$"] :> {parseList["$1","$2"], parseList["$3","$4"], ""},
		RegularExpression["^{([AKQJT2-9]+)}([AKQJT2-9])-([AKQJT2-9])([os])?$"] :> {parseList["$1"], parseRange["$2","$3"], "$4"},
		RegularExpression["^{([AKQJT2-9]+)}([RCAKQJT2-9])([os])?$"] :> {parseList["$1"], card[rankLetterToNum["$2"],random[]], "$3"},
		RegularExpression["^{([AKQJT2-9]+)}{([csdh]+)}{([AKQJT2-9]+)}([os]?)$"] :> {parseList["$1","$2"], parseList["$3"], "$4"},
		RegularExpression["^{([AKQJT2-9]+)}{([csdh]+)}([AKQJT2-9])-([AKQJT2-9])([os])?$"] :> {parseList["$1","$2"], parseRange["$3","$4"], "$5"},
		RegularExpression["^{([AKQJT2-9]+)}{([csdh]+)}([RCAKQJT2-9])([os]?)$"] :> {parseList["$1","$2"], card[rankLetterToNum["$3"],random[]], "$4"},
		RegularExpression["^{([AKQJT2-9]+)}([csdh])([RCAKQJT2-9])([csdh])$"] :> {parseList["$1","$2"], card[rankLetterToNum["$3"],suitLetterToSym["$4"]], ""},
		RegularExpression["^{([AKQJT2-9]+)}([csdh]){([AKQJT2-9]+)}{([csdh]+)}$"] :> {parseList["$1","$2"], parseList["$3","$4"], ""},
		RegularExpression["^{([AKQJT2-9]+)}([AKQJT2-9])-([AKQJT2-9]){([csdh]+)}$"] :> {parseList["$1"], parseRange["$2","$3","$4"], ""},
		RegularExpression["^{([AKQJT2-9]+)}{([csdh]+)}([AKQJT2-9])-([AKQJT2-9]){([csdh]+)}$"] :> {parseList["$1","$2"], parseRange["$3","$4","$5"], ""},
		RegularExpression["^([AKQJT2-9])-([AKQJT2-9]){([AKQJT2-9]+)}([os])?$"] :> {parseRange["$1","$2"], parseList["$3"], "$4"},
		RegularExpression["^([AKQJT2-9])-([AKQJT2-9]){([AKQJT2-9]+)}{([csdh]+)}([os])?$"] :> { parseRange["$1","$2"], parseList["$3","$4"],"$5"},
		RegularExpression["^([AKQJT2-9])-([AKQJT2-9]){([csdh]+)}{([AKQJT2-9]+)}$"] :> {parseRange["$1","$2","$3"], parseList["$4"], ""},
		RegularExpression["^([AKQJT2-9])-([AKQJT2-9]){([csdh]+)}{([AKQJT2-9]+)}([csdh])$"] :> {parseRange["$1","$2","$3"],parseList["$4","$5"], ""},
		RegularExpression["^([AKQJT2-9])-([AKQJT2-9]){([csdh]+)}{([AKQJT2-9]+)}{([csdh]+)}$"] :> {parseRange["$1","$2","$3"],parseList["$4","$5"], ""},
		RegularExpression["^([RAKQJT2-9]){([AKQJT2-9]+)}([os])?$"] :> {card[rankLetterToNum["$1"],random[]],parseList["$2"],  "$3"},
		RegularExpression["^([RAKQJT2-9]){([AKQJT2-9]+)}{([csdh]+)}$"] :> {card[rankLetterToNum["$1"],random[]],parseList["$2","$3"], ""},
		RegularExpression["^([RAKQJT2-9])([csdh]){([AKQJT2-9]+)}([os]?)$"] :> {card[rankLetterToNum["$1"],suitLetterToSym["$2"]],parseList["$3"],"$4"},
		RegularExpression["^([RAKQJT2-9])([csdh]){([AKQJT2-9]+)}{([csdh]+)}$"] :> {card[rankLetterToNum["$1"],suitLetterToSym["$2"]],parseList["$3","$4"], "$5"},
		StringExpression[__]:> {parseHandERROR[hand],"",""}
		}
		]];
		If[so === "s" || so === "o", {c1,card[c2[[1]],suitOrOffsuit[so]]}, {c1,c2}]
	]

parseList[rankList_String, suit_:"r"] := 
	Module[{suit2},
		suit2 = If[StringLength[suit]==1,suitLetterToSym[suit], suitLetterToSym /@ Characters[suit]];
		card[rankLetterToNum /@ Characters[rankList],suit2] 
	]
	
parseRange[r1_,r2_, suit_:"r"] :=
	Module[{rank1,rank2,suit2},
		suit2 = If[StringLength[suit]==1,suitLetterToSym[suit], suitLetterToSym /@ Characters[suit]];
		rank1 = rankLetterToNum[r1] ;
		rank2 = rankLetterToNum[r2] ;
		card[Range[rank1,rank2,Order[rank1,rank2]],suit2]
		
	]
	
suitOrOffsuit["s"] := suited[]
suitOrOffsuit["o"] := offsuit[]
	
rankLetterToNum["R"] := random[]
rankLetterToNum["C"] := connector[]
rankLetterToNum["A"] := Ace
rankLetterToNum["K"] := King
rankLetterToNum["Q"] := Queen
rankLetterToNum["J"] := Jack
rankLetterToNum["T"] := 10
rankLetterToNum[n_String] := ToExpression[n]

suitLetterToSym["r"] := random[]
suitLetterToSym["s"] := Spades
suitLetterToSym["h"] := Hearts
suitLetterToSym["d"] := Diamonds
suitLetterToSym["c"] := Clubs
offsuitPair[] := RandomSample[{Spades,Hearts, Diamonds,Clubs},2]
suitedPair[] := Module[{s},s=RandomSample[{Spades,Hearts, Diamonds,Clubs},1]; Flatten[{s,s}]]

offsuitPair[]
{Spades,Hearts}
suitedPair[]
{Clubs,Clubs}
rankLetterToNum["A"]
Ace
offsuitHand[c1_,c2_] := Module[{cases1,card1,cases2,card2},
cases1 =Cases[ParseHandsDeck,card[rankLetterToNum[c1],_]];
card1=If[Length[cases1]> 0,First[RandomSample[cases1,1]], card[random[],random[]]];
ParseHandsDeck = DeleteCases[ParseHandsDeck,card1];
cases2 = Cases[ParseHandsDeck,card[rankLetterToNum[c2],s1_]/; s1 =!= card1[[2]]] ;
card2=If[Length[cases2]> 0,First[RandomSample[cases2,1]], card[random[],offsuit[]]];
card2 = If[card1[[2]] === random[], card[card2[[1]],offsuit[]],card2];
ParseHandsDeck = DeleteCases[ParseHandsDeck,card2];
{card1, card2} 
]

offsuitConnector[c1_] := Module[{cases1,card1},
 cases1 =Cases[ParseHandsDeck,card[rankLetterToNum[c1],_]];
 card1=If[Length[cases1]> 0,First[RandomSample[cases1,1]], card[random[]]];
 ParseHandsDeck = DeleteCases[ParseHandsDeck,card1];
 {card1, card[connector[],offsuit[]]}
]
 	
suitedHand[c1_,c2_] := Module[{cases1,card1,cases2,card2},
cases1 =Cases[ParseHandsDeck,card[rankLetterToNum[c1],_]];
card1=If[Length[cases1]> 0,First[RandomSample[cases1,1]], card[random[],random[]]];
ParseHandsDeck = DeleteCases[ParseHandsDeck,card1];
cases2 = Cases[ParseHandsDeck,card[rankLetterToNum[c2],s1_] /; s1 == card1[[2]]||card1[[2]]==random[]];
card2=If[Length[cases2]> 0,First[RandomSample[cases2,1]], card[random[],suited[]]];
card2 = If[card1[[2]] === random[], card[card2[[1]],suited[]],card2];
ParseHandsDeck = DeleteCases[ParseHandsDeck,card2];
{card1, card2} 
]

suitedConnector[c1_] := 
Module[{cases1,card1},
cases1 =Cases[ParseHandsDeck,card[rankLetterToNum[c1],_]];
card1=If[Length[cases1]> 0,First[RandomSample[cases1,1]], card[random[]]];
ParseHandsDeck = DeleteCases[ParseHandsDeck,card1];
{card1,card[connector[],suited[]]}
]

 specificHand[c1_,s1_,c2_,s2_] := Module[{card1,card2},
card1= card[rankLetterToNum[c1],suitLetterToSym[s1]];
card1 = If[MemberQ[ParseHandsDeck,card1],card1,
	If[card1[[1]] === random[] || card1[[2]] == random[], card1,Null]];
ParseHandsDeck = DeleteCases[ParseHandsDeck,card1];
card2= card[rankLetterToNum[c2],suitLetterToSym[s2]];
card2 = If[MemberQ[ParseHandsDeck,card2],card2,
	If[card2[[1]] === random[] || card2[[2]] == random[], card2,Null]];
ParseHandsDeck = DeleteCases[ParseHandsDeck,card2];
{card1, card2}]

specificConnector[c1_,s1_,s2_] := Module[{card1},
card1= card[rankLetterToNum[c1],suitLetterToSym[s1]];
card1 = If[MemberQ[ParseHandsDeck,card1],card1,
	If[card1[[1]] === random[] || card1[[2]] == random[], card1,Null]];
ParseHandsDeck = DeleteCases[ParseHandsDeck,card1];
{card1, card[connector[],suitLetterToSym[s2]]}
]


someHand[c1_,c2_] :=  
If[c1==c2 ||RandomReal[]>0.5,
offsuitHand[c1,c2],
suitedHand[c1,c2]]

someConnector[c1_] :=
 If[RandomReal[]>0.5,
offsuitConnector[c1],
suitedConnector[c1]]

somePair[c1_,s_:"r"] := 
Module[{card1},
 card1= card[rankLetterToNum[c1],suitLetterToSym[s]];
 {card1,card[pair[]]}
]
	
End[]

EndPackage[]