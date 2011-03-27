(* Mathematica Tests for MoneyGame functions *)
(* Copyright 2011 Sal Mangano. All rights reserved *)

Needs["TexasHoldem`"]

testMoneyGame = moneyGame[9, 1, 100, 50, 10] ;

Test[
	numPlayers[testMoneyGame]
	,
	9
	,
	TestID->"MoneyGameTest-20110220-H2P9L6"
]

Test[
	bigBlind[testMoneyGame]
	,
	100
	,
	TestID->"MoneyGameTest-20110220-I3N2C2"
]

Test[
	smallBlind[testMoneyGame]
	,
	50
	,
	TestID->"MoneyGameTest-20110220-N9I7J3"
]

Test[
	antes[testMoneyGame]
	,
	10
	,
	TestID->"MoneyGameTest-20110220-L5G8U8"
]

Test[
	button[testMoneyGame]
	,
	1
	,
	TestID->"MoneyGameTest-20110220-Y8H9Q3"
]
