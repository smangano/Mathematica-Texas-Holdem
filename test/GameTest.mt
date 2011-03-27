(* Mathematica Tests for Game Play *)
(* Copyright 2011 Sal Mangano. All rights reserved *)

SeedRandom[13];

Test[
	Length[shuffle[Deck]]
	,
	52
	,
	TestID->"GameTest-20110219-B1R7T9"
]

Test[
	shuffle[Deck] === Deck
	,
	False
	,
	TestID->"GameTest-20110219-Y7R0L2"
]

Test[
	shuffle[Deck] === shuffle[Deck]
	,
	False
	,
	TestID->"GameTest-20110219-K8H2J9"
]

Test[
	First[fixedShuffle[card[Ace,Diamonds], Deck]]
	,
	card[Ace,Diamonds]
	,
	TestID->"GameTest-20110309-U6T7X7"
]

Test[
	MemberQ[Rest[fixedShuffle[card[Ace,Diamonds], Deck]],card[Ace,Diamonds]]
	,
	False
	,
	TestID->"GameTest-20110309-U6T7X8"
]

testFixed1 = fixedShuffle[card[Ace,Diamonds],card[2,Clubs], Deck];
Test[
	First[testFixed1]
	,
	card[Ace,Diamonds]
	,
	TestID->"GameTest-20110309-Y5B4O0"
]

Test[
	Part[testFixed1,2]
	,
	card[2,Clubs]
	,
	TestID->"GameTest-20110309-P1B9U7"
]

Test[
	MemberQ[Drop[testFixed1,2],card[2,Clubs]]
	,
	False
	,
	TestID->"GameTest-20110309-L8Y3V7"
]

testDeal = deal[9];
Test[
	Length[First[testDeal]]
	,
	9
	,
	TestID->"GameTest-20110219-Y6P8O4"
]

Test[
	And@@(Greater[#,0]& /@ handRanking /@ First[testDeal])
	,
	True
	,
	TestID->"GameTest-20110219-G1W4H9"
]	
	
Test[
	Length[Part[testDeal,2]]
	,
	Evaluate[52 - 9*2] (*Remaining cards*)
	,
	TestID->"GameTest-20110219-M3Z9Z4"
]

testFlop = flop[Part[testDeal,2]] ;

Test[
	Length[First[testFlop]]
	,
	3
	,
	TestID->"GameTest-20110219-N2A8E7"
]

Test[
	Length[Part[testFlop,2]]
	,
	Evaluate[52-9*2-1-3] (*full deck - players hands - burn - flop *)
	,
	TestID->"GameTest-20110219-B1L6U2"
]

testTurn = turn[Part[testFlop,2]] ;


(* turn card*)
Test[
	MatchQ[Part[testTurn,1],card[_Integer,_]]
	,
	True 
	,
	TestID->"GameTest-20110219-C9S8B4"
]

(*Remaining cards after turn*)
Test[
	Length[Part[testTurn,2]]
	,
	Evaluate[52-9*2-1-3-1-1] (*full deck - players hands - burn - flop - burn - turn*) 
	,
	TestID->"GameTest-20110219-B4K3T8"
]

testRiver = turn[Part[testTurn,2]] ;

(*river card*)
Test[
	MatchQ[Part[testRiver,1],card[_Integer,_]]
	,
	True 
	,
	TestID->"GameTest-20110219-H2Q3X6"
]

(*Left over cards after river*)
Test[
	Length[Part[testRiver,2]]
	,
	Evaluate[52-9*2-1-3-1-1-1-1] (*full deck - players hands - burn - flop - burn - turn- burn - river*) 
	,
	TestID->"GameTest-20110219-R6M8V9"
]

testGame = game[9];

Test[
	Head[testGame]
	,
	Game
	,
	TestID->"GameTest-20110219-T8E6X2"
]

Test[
	Length[testGame]
	,
	4
	,
	TestID->"GameTest-20110219-M2N3A3"
]

Test[
	numPlayers[testGame]
	,
	9
	,
	TestID->"GameTest-20110219-Q2M5I3"
]

Test[
	MatchQ[Part[testGame,1],Hands[{{__card}..}]]
	,
	True
	,
	TestID->"GameTest-20110219-Y1J4S5"
]

Do[Test[
	MatchQ[holeCards[testGame,p],{Repeated[card[_Integer,_String], {2,2}]}]
	,
	True
	,
	TestID->"GameTest-20110220-V9J2X6" <> "-" <> ToString[p]
],
{p, 9}
]

Test[
	MatchQ[Part[testGame,2],Flop[{__card}]]
	,
	True
	,
	TestID->"GameTest-20110219-J9Y4I6"
]

Test[
	flop[testGame]
	,
	Evaluate[Part[testGame,2]]
	,
	TestID->"GameTest-20110220-Y0E7F5"
]

Test[
	MatchQ[Part[testGame,3],Turn[{_card}]]
	,
	True
	,
	TestID->"GameTest-20110219-X1M0U0"
]

Test[
	turn[testGame]
	,
	Evaluate[Part[testGame,3]]
	,
	TestID->"GameTest-20110220-C1L1Q9"
]

Test[
	MatchQ[Part[testGame,4],River[{_card}]]
	,
	True
	,
	TestID->"GameTest-20110219-B9Z0R3"
]

Test[
	river[testGame]
	,
	Evaluate[Part[testGame,4]]
	,
	TestID->"GameTest-20110220-F7Q5U3"
]

hand[testGame,1,Hands]

Do[Test[
	MatchQ[hand[testGame,i,Hands], {Repeated[_card,{2,2}]}]
	,
	True
	,
	TestID->"GameTest-20110219-W5M3G6" <> "-" <> ToString[i]
],{i,1,9}]

Do[Test[
	MatchQ[hand[testGame,i,Flop], {Repeated[_card,{5,5}]}]
	,
	True
	,
	TestID->"GameTest-20110219-N1V6K2" <> "-" <> ToString[i]
],{i,1,9}]

Do[Test[
	MatchQ[hand[testGame,i,Turn], {Repeated[_card,{6,6}]}]
	,
	True
	,
	TestID->"GameTest-20110219-D4B7X1" <> "-" <> ToString[i]
],{i,1,9}]

Do[Test[
	MatchQ[hand[testGame,i,River], {Repeated[_card,{7,7}]}]
	,
	True
	,
	TestID->"GameTest-20110219-C5E3H8" <> "-" <> ToString[i]
],{i,1,9}]

