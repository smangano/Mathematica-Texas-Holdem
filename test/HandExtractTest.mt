(* Mathematica Tests for Hand Extractions *)
(* Copyright 2011 Sal Mangano. All rights reserved *)

Needs["TexasHoldem`"]

(****************************************************************************)
(*                              highCard[]                                  *)
(****************************************************************************)
Test[
	highCard[Take[Deck,5]]
	,
	Deck[[5]]
	,
	TestID->"HandExtractTest-20110217-V2D1F2"
]

Test[
	highCard[Reverse[Take[Deck,5]]]
	,
	Deck[[5]]
	,
	TestID->"HandExtractTest-20110217-L6W7M4"
]


Test[
	highCard[{}]
	,
	Null
	,
	TestID->"HandExtractTest-20110217-K1H3N5"
]

Test[
	highCard[{card[2,Spades]}]
	,
	card[2,Spades]
	,
	TestID->"HandExtractTest-20110217-L3F4F4"
]

Test[
	First@highCard[Deck]
	,
	14
	,
	TestID->"HandExtractTest-20110217-M4U3G9"
]

(*2nd highest*)
Test[
	First@highCard[Deck,2]
	,
	13
	,
	TestID->"HandExtractTest-20110217-W8Y0N2"
]





(****************************************************************************)
(*                                 trips[]                                  *)
(****************************************************************************)


Test[
	trips[{}]
	,
	{}
	,
	TestID->"HandExtractTest-20110218-I1U2V6"
]

Test[
	trips[{card[4,Hearts]}]
	,
	{}
	,
	TestID->"HandExtractTest-20110218-D2M8Y6"
]

Test[
	trips[{card[4,Hearts],card[4,Spades]}]
	,
	{}
	,
	TestID->"HandExtractTest-20110218-N9K2C4"
]

Test[
	First/@trips[{card[4,Hearts],card[4,Spades],card[4,Clubs]}]
	,
	{4,4,4}
	,
	TestID->"HandExtractTest-20110218-G0C5N4"
]

Test[
	First/@trips[{card[4,Hearts],card[4,Spades],card[4,Clubs],card[4,Diamonds]}]
	,
	{4,4,4}
	,
	TestID->"HandExtractTest-20110218-O4B7Z1"
]

Test[
	First/@ trips[{card[4,Hearts],card[14,Spades],card[4,Clubs],card[14,Diamonds],card[14,Hearts],card[4,Spades],card[14,Clubs],card[4,Diamonds]}]
	,
	{14,14,14}
	,
	TestID->"HandExtractTest-20110218-U7P5V0"
]

(****************************************************************************)
(*                                 twoPair[]                                *)
(****************************************************************************)

Test[
	twoPair[{}]
	,
	{}
	,
	TestID->"HandExtractTest-20110218-V3R8D2"
]

Test[
	twoPair[{card[4,Hearts]}]
	,
	{}
	,
	TestID->"HandExtractTest-20110218-P1V3L8"
]

Test[
	twoPair[{card[4,Hearts],card[4,Spades]}]
	,
	{}
	,
	TestID->"HandExtractTest-20110218-M3U6R5"
]

Test[
	twoPair[{card[4,Hearts],card[4,Spades],card[2,Clubs]}]
	,
	{}
	,
	TestID->"HandExtractTest-20110218-I3J4Z7"
]

Test[
	First/@twoPair[{card[4,Hearts],card[2,Hearts],card[4,Spades],card[2,Clubs]}]
	,
	{4,4,2,2}
	,
	TestID->"HandExtractTest-20110218-A0N4N6"
]

Test[
	First/@twoPair[{card[4,Hearts],card[2,Hearts],card[4,Spades],card[2,Clubs],card[14,Spades],card[14,Clubs]}]
	,
	{14,14,4,4}
	,
	TestID->"HandExtractTest-20110218-L3D1F9"
]


(****************************************************************************)
(*                                 pair[]                                *)
(****************************************************************************)

Test[
	pair[{}]
	,
	{}
	,
	TestID->"HandExtractTest-20110218-U3W3P8"
]

Test[
	pair[{card[4,Hearts]}]
	,
	{}
	,
	TestID->"HandExtractTest-20110218-R7Q6P1"
]

Test[
	First/@pair[{card[4,Hearts],card[4,Spades]}]
	,
	{4,4}
	,
	TestID->"HandExtractTest-20110218-G6F8H2"
]

Test[
	First/@pair[{card[4,Hearts],card[4,Spades],card[2,Clubs]}]
	,
	{4,4}
	,
	TestID->"HandExtractTest-20110218-A6V9M6"
]

Test[
	First/@pair[{card[4,Hearts],card[2,Hearts],card[4,Spades],card[2,Clubs]}]
	,
	{4,4}
	,
	TestID->"HandExtractTest-20110218-E7R3O1"
]

Test[
	First/@pair[{card[4,Hearts],card[2,Hearts],card[4,Spades],card[2,Clubs],card[14,Spades],card[14,Clubs]}]
	,
	{14,14}
	,
	TestID->"HandExtractTest-20110218-C8O3X7"
]

(****************************************************************************)
(*                                 straight[]                                  *)
(****************************************************************************)
Test[
	straight[{}]
	,
	{}
	,
	TestID->"MoneyGameTest-20110220-T4C5K4"
]

Test[
	straight[{card[5,Hearts]}]
	,
	{}
	,
	TestID->"MoneyGameTest-20110220-Y9C4R6"
]

Test[
	straight[{card[5,Hearts],card[4,Spades]}]
	,
	{}
	,
	TestID->"MoneyGameTest-20110220-R7R0G8"
]

Test[
	straight[{card[5,Hearts],card[4,Spades],card[3,Clubs]}]
	,
	{}
	,
	TestID->"MoneyGameTest-20110220-S4Y1G7"
]

Test[
	straight[{card[5,Hearts],card[4,Spades],card[3,Clubs],card[2,Diamonds]}]
	,
	{}
	,
	TestID->"MoneyGameTest-20110220-Z6I2O5"
]

Test[
	First/@straight[{card[5,Hearts],card[4,Spades],card[3,Clubs],card[2,Diamonds],card[14,Diamonds]}]
	,
	{2,3,4,5,14}
	,
	TestID->"MoneyGameTest-20110220-J9A2A6"
]

Test[
	First/@ straight[{card[6,Hearts],card[5,Spades],card[4,Clubs],card[3,Diamonds],card[2,Hearts],card[14,Spades]}]
	,
	{2,3,4,5,6}
	,
	TestID->"MoneyGameTest-20110220-F0X7S6"
]

Test[
	First/@ straight[{card[6,Hearts],card[7,Hearts],card[4,Spades],card[5,Clubs],card[3,Diamonds],card[2,Hearts],card[14,Spades]}]
	,
	{3,4,5,6,7}
	,
	TestID->"MoneyGameTest-20110220-J1H8R5"
]


(****************************************************************************)
(*                                 flush[]                                  *)
(****************************************************************************)
Test[
	flush[{}]
	,
	{}
	,
	TestID->"MoneyGameTest-20110220-O4C2V1"
]

Test[
	flush[{card[5,Hearts]}]
	,
	{}
	,
	TestID->"MoneyGameTest-20110220-C4V5I0"
]

Test[
	flush[{card[5,Hearts],card[4,Hearts]}]
	,
	{}
	,
	TestID->"MoneyGameTest-20110220-T6C4C6"
]

Test[
	flush[{card[5,Hearts],card[4,Hearts],card[3,Hearts]}]
	,
	{}
	,
	TestID->"MoneyGameTest-20110220-P7N9Z4"
]

Test[
	flush[{card[5,Hearts],card[4,Hearts],card[3,Hearts],card[2,Hearts]}]
	,
	{}
	,
	TestID->"MoneyGameTest-20110220-H2L7D4"
]

Test[
	First/@flush[{card[5,Hearts],card[4,Hearts],card[3,Hearts],card[2,Hearts],card[8,Hearts]}]
	,
	{2,3,4,5,8}
	,
	TestID->"MoneyGameTest-20110220-T4C0M1"
]

Test[
	flush[{card[5,Hearts],card[4,Hearts],card[3,Hearts],card[2,Hearts],card[8,Spades]}]
	,
	{}
	,
	TestID->"MoneyGameTest-20110220-C0X6P4"
]

Test[
	First/@ flush[{card[7,Spades],card[5,Spades],card[4,Spades],card[3,Spades],card[2,Spades],card[13,Spades]}]
	,
	{3,4,5,7,13}
	,
	TestID->"MoneyGameTest-20110220-F8O1C7"
]

Test[
	First/@ flush[{card[14,Diamonds],card[12,Diamonds],card[4,Spades],card[5,Diamonds],card[3,Diamonds],card[2,Hearts],card[10,Diamonds]}]
	,
	{3,5,10,12,14}
	,
	TestID->"MoneyGameTest-20110220-M2P4S2"
]

(****************************************************************************)
(*                                 fullHouse[]                                  *)
(****************************************************************************)
Test[
	fullHouse[{}]
	,
	{}
	,
	TestID->"MoneyGameTest-20110220-F4S4C7"
]

Test[
	fullHouse[{card[5,Hearts]}]
	,
	{}
	,
	TestID->"MoneyGameTest-20110220-V9U2I8"
]

Test[
	fullHouse[{card[5,Hearts],card[5,Diamonds]}]
	,
	{}
	,
	TestID->"MoneyGameTest-20110220-O6V8C9"
]

Test[
	fullHouse[{card[5,Hearts],card[5,Diamonds],card[5,Spades]}]
	,
	{}
	,
	TestID->"MoneyGameTest-20110220-S4L6N5"
]

Test[
	fullHouse[{card[5,Hearts],card[5,Diamonds],card[5,Spades],card[7,Clubs]}]
	,
	{}
	,
	TestID->"MoneyGameTest-20110220-L6T0A8"
]

Test[
	First/@fullHouse[{card[5,Hearts],card[5,Diamonds],card[5,Spades],card[7,Clubs],card[7,Diamonds]}]
	,
	{7,7,5,5,5}
	,
	TestID->"MoneyGameTest-20110220-A1Z3T2"
]

Test[
	First/@fullHouse[{card[5,Hearts],card[5,Diamonds],card[5,Spades],card[7,Clubs],card[7,Diamonds],card[7,Hearts]}]
	,
	{7,7,7,5,5}
	,
	TestID->"MoneyGameTest-20110220-B5C2U3"
]

Test[
	First/@ fullHouse[{card[14,Spades],card[5,Spades],card[14,Hearts],card[5,Hearts],card[14,Clubs],card[7,Clubs]}]
	,
	{14,14,14,5,5}
	,
	TestID->"MoneyGameTest-20110220-B2E5N6"
]

Test[
	First/@ fullHouse[{card[14,Spades],card[5,Spades],card[14,Hearts],card[5,Hearts],card[14,Clubs],card[2,Clubs]}]
	,
	{14,14,14,5,5}
	,
	TestID->"MoneyGameTest-20110220-U5Q2C3"
]

Test[
	First/@ fullHouse[{card[13,Spades],card[5,Spades],card[13,Hearts],card[5,Hearts],card[13,Clubs],card[14,Clubs]}]
	,
	{13,13,13,5,5}
	,
	TestID->"MoneyGameTest-20110220-P6S3N1"
]

(****************************************************************************)
(*                                 quads[]                                  *)
(****************************************************************************)
Test[
	quads[{}]
	,
	{}
	,
	TestID->"HandExtractTest-20110217-P7Y1I7"
]

Test[
	quads[{card[4,Hearts]}]
	,
	{}
	,
	TestID->"HandExtractTest-20110217-U6N7N8"
]

Test[
	quads[{card[4,Hearts],card[4,Spades]}]
	,
	{}
	,
	TestID->"HandExtractTest-20110217-J6M1D7"
]

Test[
	quads[{card[4,Hearts],card[4,Spades],card[4,Clubs]}]
	,
	{}
	,
	TestID->"HandExtractTest-20110217-X9P9R0"
]

Test[
	First/@ quads[{card[4,Hearts],card[4,Spades],card[4,Clubs],card[4,Diamonds]}]
	,
	{4,4,4,4}
	,
	TestID->"HandExtractTest-20110217-J9W8Z5"
]

Test[
	quads[{card[4,Hearts],card[4,Spades],card[4,Clubs],card[5,Diamonds]}]
	,
	{}
	,
	TestID->"HandExtractTest-20110217-Y6W9X2"
]

Test[
	First/@ quads[{card[4,Hearts],card[14,Spades],card[4,Clubs],card[14,Diamonds],card[14,Hearts],card[4,Spades],card[14,Clubs],card[4,Diamonds]}]
	,
	{14,14,14,14}
	,
	TestID->"HandExtractTest-20110217-S7D0H2"
]

(****************************************************************************)
(*                               straightFlush[]                            *)
(****************************************************************************)
Test[
	straightFlush[{}]
	,
	{}
	,
	TestID->"MoneyGameTest-20110220-L5P8Z4"
]

Test[
	straightFlush[{card[5,Hearts]}]
	,
	{}
	,
	TestID->"MoneyGameTest-20110220-F0G4L2"
]

Test[
	straightFlush[{card[5,Hearts],card[4,Hearts]}]
	,
	{}
	,
	TestID->"MoneyGameTest-20110220-Z3H6M5"
]

Test[
	straightFlush[{card[5,Hearts],card[4,Hearts],card[3,Hearts]}]
	,
	{}
	,
	TestID->"MoneyGameTest-20110220-G9V1M8"
]

Test[
	straightFlush[{card[5,Hearts],card[4,Spades],card[3,Hearts],card[2,Hearts]}]
	,
	{}
	,
	TestID->"MoneyGameTest-20110220-Q1L2I5"
]

Test[
	First/@straightFlush[{card[5,Hearts],card[4,Hearts],card[3,Hearts],card[2,Hearts],card[14,Hearts]}]
	,
	{2,3,4,5,14}
	,
	TestID->"MoneyGameTest-20110220-N3B8O1"
]

Test[
	First/@ straightFlush[{card[6,Hearts],card[5,Hearts],card[4,Hearts],card[3,Hearts],card[2,Hearts],card[14,Hearts]}]
	,
	{2,3,4,5,6}
	,
	TestID->"MoneyGameTest-20110220-B0D6Z8"
]

Test[
	First/@ straightFlush[{card[6,Hearts],card[7,Hearts],card[4,Hearts],card[5,Hearts],card[3,Hearts],card[2,Hearts],card[14,Hearts]}]
	,
	{3,4,5,6,7}
	,
	TestID->"MoneyGameTest-20110220-I1X2D8"
]



