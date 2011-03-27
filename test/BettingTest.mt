(*Mathematica Tests for Betting functions *)
(* Copyright 2011 Sal Mangano. All rights reserved *)

Needs["TexasHoldem`"];

plusAbs[x__] := Plus@@Abs/@{x} 

nPlayers = 9 ;
onButton = 1;
bb = 100 ;
sb = 50;
an = 10 ;
testStacks = stacks[nPlayers,1500] ;
testMoneyGame = moneyGame[nPlayers, onButton, bb, sb, an] ;
testStrategies = Strategies@@Table[Strategy["random",i/100.0],{i,nPlayers}];
testHoldem1 = holdemStart[testMoneyGame, testStacks, testStrategies] ;
bets1 = makeBets[nPlayers] ;

(*initial bets are zero for every stage*)
Test[
	Apply[plusAbs,bets1,{0,1}]
	,
	0
	,
	TestID->"BettingTest-20110303-Z4R3V7"
]

Do[
Test[
	getBet[bets1,p,stage]
	,
	0
	,
	TestID->"BettingTest-20110303-F3F6J0"
],
{p,1,nPlayers},{stage, {Preflop,Flop, Turn,River}}]

bets2 = updateBets[bets1, 1, Preflop,100] ;

Test[
	getBet[bets2,1,Preflop]
	,
	100
	,
	TestID->"BettingTest-20110303-O2O2Z0"
]

Test[
	Apply[Plus[Abs[#1]]&,bets2,{0,1}]
	,
	100
	,
	TestID->"BettingTest-20110303-Y6J7H4"
]

bets3 = updateBets[bets2, 4, Preflop,200] ;

Test[
	getBet[bets3,4,Preflop]
	,
	200
	,
	TestID->"BettingTest-20110303-B2G5A3"
]


Test[
	Apply[plusAbs,bets3,{0,1}]
	,
	300
	,
	TestID->"BettingTest-20110303-F0V4C6"
]

bets4 = updateBets[bets3, 4, Flop,300] ;

Test[
	getBet[bets4,4,Flop]
	,
	300
	,
	TestID->"BettingTest-20110303-F4V0Z5"
]


Test[
	Apply[plusAbs,bets4,{0,1}]
	,
	600
	,
	TestID->"BettingTest-20110303-Y2X1J7"
]

bets5 = updateBets[bets4, 4, Turn,400] ;

Test[
	getBet[bets5,4,Turn]
	,
	400
	,
	TestID->"BettingTest-20110303-B4O6V5"
]


Test[
	Apply[plusAbs,bets5,{0,1}]
	,
	1000
	,
	TestID->"BettingTest-20110303-S8W9G6"
]

bets6 = updateBets[bets5, 4, River,600] ;

Test[
	getBet[bets6,4,River]
	,
	600
	,
	TestID->"BettingTest-20110303-I1B5D1"
]


Test[
	Apply[plusAbs,bets6,{0,1}]
	,
	1600
	,
	TestID->"BettingTest-20110303-R2L7B7"
]

Test[
	foldedQ[bets6,4, River]
	,
	False
	,
	TestID->"BettingTest-20110303-O7X7X5"
]


Test[
	foldedQ[bets6,5, River]
	,
	False
	,
	TestID->"BettingTest-20110303-O7X7X5"
]

bets7 = updateBets[bets6, 5, River,FOLD] ;

Test[
	foldedQ[bets7,5, River]
	,
	True
	,
	TestID->"BettingTest-20110303-O7X7X5"
]

Test[
	bet[testHoldem1, 1, Strategy["random", 1]]
	,
	{-1,Strategy["random", 1]}
	,
	TestID->"BettingTest-20110304-G6I5T6"
]

Test[
	First@bet[testHoldem1, 1, Strategy["random", 0]]>0
	,
	True
	,
	TestID->"BettingTest-20110304-G6I5T7"
]