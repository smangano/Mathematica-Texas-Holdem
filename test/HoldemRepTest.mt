(*Mathematica Tests for Holdem representation functions *)
(* Copyright 2011 Sal Mangano. All rights reserved *)

Needs["TexasHoldem`"];

(*moneyGame_MoneyGame,stacks_Stacks, strategies_Strategies*)
nPlayers = 9;
onButton = 1;
bb = 100 ;
sb = 50;
an = 10 ;
testStacks = stacks[nPlayers,1500] ;
testMoneyGame = moneyGame[nPlayers, onButton, bb, sb, an] ;
testStrategies = Strategies@@Table[Strategy["random",i/100.0],{i,nPlayers}];
testHoldem1 = holdemStart[testMoneyGame, testStacks, testStrategies] ;
Test[
	minMaxBet[testHoldem1]
	,
	{100,1500}
	,
	TestID->"HoldemRepTest-20110302-H5Y8K2"
]

Test[
	minBet[testHoldem1]
	,
	100
	,
	TestID->"HoldemRepTest-20110302-W8K6G6"
]

Test[
	maxBet[testHoldem1]
	,
	1500
	,
	TestID->"HoldemRepTest-20110302-F6U9U9"
]

Test[
	moneyGame[testHoldem1]
	,
	testMoneyGame
	,
	TestID->"HoldemRepTest-20110302-Y6Q4H0"
]

Test[
	pot[testHoldem1]
	,
	Pot[0]
	,
	TestID->"HoldemRepTest-20110302-Y6Q4H1"
]

Test[
	Apply[Plus,bets[testHoldem1],{0,1}]
	,
	0
	,
	TestID->"HoldemRepTest-20110302-Y6Q4H2"
]

Do[
	Test[
	Apply[Plus,playerBets[testHoldem1,i]]
	,
	0
	,
	TestID->"HoldemRepTest-20110302-Y6Q4H3-" <> ToString[i]
],
{i,nPlayers}]

Test[
	stacks[testHoldem1]
	,
	stacks[nPlayers,1500]
	,
	TestID->"HoldemRepTest-20110302-N0X0A3"
]

Do[
Test[
	stack[testHoldem1,i]
	,
	1500
	,
	TestID->"HoldemRepTest-20110302-N0X0A4"
],
{i,nPlayers}]

Test[
	action[testHoldem1]
	,
	actionInit[testMoneyGame]
	,
	TestID->"HoldemRepTest-20110302-S2K3N9"
]
Test[
	strategies[testHoldem1]
	,
	testStrategies
	,
	TestID->"HoldemRepTest-20110302-H2Z9X4"
]


Do[
Test[
	strategy[testHoldem1,i]
	,
	testStrategies[[i]]
	,
	TestID->"HoldemRepTest-20110302-A1A1X7"
],
{i,nPlayers}]

Test[
	stage[testHoldem1]
	,
	Hands
	,
	TestID->"HoldemRepTest-20110302-B3L8V6"
]