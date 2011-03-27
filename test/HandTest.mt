(* Mathematica Tests for Hand Predicates *)
(* Copyright 2011 Sal Mangano. All rights reserved *)

Needs["TexasHoldem`"]

(* We use random numbers but want tests to be repeatable. Here 17 is arbitrary *)
SeedRandom[17];

(* Suit to Index Tests *)
Test[
	suitToIndex[Clubs]
	,
	1
	,
	TestID->"HandTest-20110217-N6O6Q5"
]

Test[
	suitToIndex[Diamonds]
	,
	2
	,
	TestID->"HandTest-20110217-B6B2O2"
]

Test[
	suitToIndex[Hearts]
	,
	3
	,
	TestID->"HandTest-20110217-N4O6C6"
]

Test[
	suitToIndex[Spades]
	,
	4
	,
	TestID->"HandTest-20110217-U5X3V9"
]

(*=========================================================================*)
(*                      Hand predicate Tests                               *)
(*=========================================================================*)

(****************************************************************************)
(*                              pairQ[]                                     *)
(****************************************************************************)

Test[
	pairQ[{}]
	,
	False
	,
	TestID->"HandTest-20110217-I1Y9B5"
]

Test[
	pairQ[{card[2,Spades]}]
	,
	False
	,
	TestID->"HandTest-20110217-H2K7T6"
]

Test[
	pairQ[{card[2,Spades],card[3,Spades]}]
	,
	False
	,
	TestID->"HandTest-20110217-B0Y4K6"
]

Test[
	pairQ[{card[7,Clubs],card[2,Spades],card[2,Hearts]}]
	,
	True
	,
	TestID->"HandTest-20110217-M5M7Q6"
]

Test[
	pairQ[{card[2,Spades],card[2,Hearts],card[7,Clubs]}]
	,
	True
	,
	TestID->"HandTest-20110217-R6B8O9"
]

Test[
	pairQ[Take[Deck,3]]
	,
	True
	,
	TestID->"HandTest-20110217-E2C7N9"
]

Test[
	pairQ[{card[2,Spades],card[3,Diamonds],card[2,Hearts]}]
	,
	True
	,
	TestID->"HandTest-20110217-U0K8Q7"
]

(****************************************************************************)
(*                              twoPairQ[]                                  *)
(****************************************************************************)
Test[
	twoPairQ[Take[Deck,4]]
	,
	True
	,
	TestID->"HandTest-20110217-I1L7I8"
]

Test[
	twoPairQ[Take[Deck,3]]
	,
	False
	,
	TestID->"HandTest-20110217-E6R6S4"
]

Test[
	twoPairQ[Deck[[{1,2,5}]]]
	,
	False
	,
	TestID->"HandTest-20110217-U6O5V5"
]


Test[
	twoPairQ[Deck[[{1,5,2,6}]]]
	,
	True
	,
	TestID->"HandTest-20110217-B2B4L0"
]

Test[
	twoPairQ[Deck[[{1,5,2,9}]]]
	,
	False
	,
	TestID->"HandTest-20110217-S6S8G3"
]


Test[
	twoPairQ[Deck[[{1,33,5,6,19,2}]]]
	,
	True
	,
	TestID->"HandTest-20110217-R3Z7P1"
]

(****************************************************************************)
(*                              tripsQ[]                                    *)
(****************************************************************************)

Test[
	tripsQ[Take[Deck,3]]
	,
	True
	,
	TestID->"HandTest-20110217-U0Y9V7"
]

Test[
	tripsQ[Take[Deck,4]]
	,
	True
	,
	TestID->"HandTest-20110217-Z6L0H7"
]

Test[
	tripsQ[Part[Deck,{1,2,5,6}]]
	,
	False
	,
	TestID->"HandTest-20110217-V2S6H1"
]

Test[
	tripsQ[Part[Deck,{1,2,5,6,7}]]
	,
	True
	,
	TestID->"HandTest-20110217-O1M7U5"
]

Scan[Test[
	tripsQ[Part[Deck,#]]
	,
	True
	,
	TestID->"HandTest-20110217-I2C8D2" <> ToString[#]
]&,
RandomChoice[Permutations[{1,2,5,6,7,12}],50]]

Scan[Test[
	tripsQ[Part[Deck,#]]
	,
	False
	,
	TestID->"HandTest-20110217-H9B1K7" <> ToString[#]
]&,
Permutations[{1,2,5,6}]]

(****************************************************************************)
(*                              quadsQ[]                                    *)
(****************************************************************************)
Test[
	quadsQ[{}]
	,
	False
	,
	TestID->"HandTest-20110217-Q5A2L8"
]

Test[
	quadsQ[Take[Deck,1]]
	,
	False
	,
	TestID->"HandTest-20110217-X9K4U1"
]

Test[
	quadsQ[Take[Deck,2]]
	,
	False
	,
	TestID->"HandTest-20110217-Y5Q1P1"
]

Test[
	quadsQ[Take[Deck,3]]
	,
	False
	,
	TestID->"HandTest-20110217-I4M5R9"
]

Test[
	quadsQ[Take[Deck,4]]
	,
	True
	,
	TestID->"HandTest-20110217-L8D4E9"
]

Scan[Test[
	quadsQ[Part[Deck,#]]
	,
	True
	,
	TestID->"HandTest-20110217-N2H9D3" <> ToString[#]
]&,
RandomChoice[Permutations[{1,2,5,6,7,8}],50]]

Scan[Test[
	quadsQ[Part[Deck,#]]
	,
	False
	,
	TestID->"HandTest-20110217-Z1X4K3" <> ToString[#]
]&,
RandomChoice[Permutations[{1,2,5,6,7,9}],50]]

(****************************************************************************)
(*                              flushQ[]                                    *)
(****************************************************************************)
Test[
	flushQ[{}]
	,
	False
	,
	TestID->"HandTest-20110217-Q0D7L7"
]

Test[
	flushQ[Take[Deck,1]]
	,
	False
	,
	TestID->"HandTest-20110217-V8I0F0"
]

Test[
	flushQ[Part[Deck,{1,1+4}]]
	,
	False
	,
	TestID->"HandTest-20110217-T6Q6H2"
]

Test[
	flushQ[Part[Deck,{1,1+4,1+8}]]
	,
	False
	,
	TestID->"HandTest-20110217-V6K1Z4"
]

Test[
	flushQ[Part[Deck,{1,1+4,1+8,1+12}]]
	,
	False
	,
	TestID->"HandTest-20110217-K9G2R3"
]

Test[
	flushQ[Part[Deck,{1,1+4,1+8,1+12,1+20}]]
	,
	True
	,
	TestID->"HandTest-20110217-B0Q3Z1"
]

(*Straight Flush is a flush*)
Test[
	flushQ[Part[Deck,{1,1+4,1+8,1+12,1+16}]]
	,
	True
	,
	TestID->"HandTest-20110217-M5H3B3"
]

Scan[Test[
	flushQ[Part[Deck,#]]
	,
	False
	,
	TestID->"HandTest-20110217-X7R0W6" <> ToString[#]
]&,
RandomChoice[Permutations[{1,1+4,1+8,1+12,1+13,1+14}],50]]

Scan[Test[
	flushQ[Part[Deck,#]]
	,
	True
	,
	TestID->"HandTest-20110217-I2O4I4" <> ToString[#]
]&,
RandomChoice[Permutations[{1,1+4,1+8,1+12,1+20,1+21}],50]]

(****************************************************************************)
(*                              fullHouseQ[]                                *)
(****************************************************************************)
Test[
	fullHouseQ[{}]
	,
	False
	,
	TestID->"HandTest-20110217-U4Y8Q5"
]

Test[
	fullHouseQ[Take[Deck,1]]
	,
	False
	,
	TestID->"HandTest-20110217-D6N4O2"
]

Test[
	fullHouseQ[Part[Deck,{1,2}]]
	,
	False
	,
	TestID->"HandTest-20110217-U7Q6I4"
]

Test[
	fullHouseQ[Part[Deck,{1,2,3}]]
	,
	False
	,
	TestID->"HandTest-20110217-M4L4M0"
]

Test[
	fullHouseQ[Part[Deck,{1,2,3,4}]]
	,
	False
	,
	TestID->"HandTest-20110217-W6A4G4"
]

Test[
	fullHouseQ[Part[Deck,{1,2,3,4,5}]]
	,
	False
	,
	TestID->"HandTest-20110217-A9E0V8"
]

Test[
	fullHouseQ[Part[Deck,{1,2,3,5,6}]]
	,
	True
	,
	TestID->"HandTest-20110217-V7T3O6"
]

Scan[Test[
	fullHouseQ[Part[Deck,#]]
	,
	False
	,
	TestID->"HandTest-20110217-B0V7I6" <> ToString[#]
]&,
RandomChoice[Permutations[{1,2,3,4,5}],50]]

Scan[Test[
	fullHouseQ[Part[Deck,#]]
	,
	True
	,
	TestID->"HandTest-20110217-A9V3W5" <> ToString[#]
]&,
RandomChoice[Permutations[{1,2,3,5,6}],50]]

(****************************************************************************)
(*                              straightQ[]                                 *)
(****************************************************************************)
Test[
	straightQ[{}]
	,
	False
	,
	TestID->"HandTest-20110217-N6U1U2"
]

Test[
	straightQ[Part[Deck,{1}]]
	,
	False
	,
	TestID->"HandTest-20110217-A4S4U3"
]

Test[
	straightQ[Part[Deck,{1,1+4}]]
	,
	False
	,
	TestID->"HandTest-20110217-X6W6L0"
]

Test[
	straightQ[Part[Deck,{1,1+4,1+8}]]
	,
	False
	,
	TestID->"HandTest-20110217-D8D5Q1"
]

Test[
	straightQ[Part[Deck,{1,1+4,1+8, 1+12}]]
	,
	False
	,
	TestID->"HandTest-20110217-S3E6H9"
]

Test[
	straightQ[Part[Deck,{1,1+4,1+8, 1+12,1+16}]]
	,
	True
	,
	TestID->"HandTest-20110217-C3P8S0"
]

Test[
	straightQ[Part[Deck,{1,1+4,1+8, 1+12,1+17}]]
	,
	True
	,
	TestID->"HandTest-20110217-D0B5N4"
]

Scan[Test[
	straightQ[Part[Deck,#]]
	,
	True
	,
	TestID->"HandTest-20110217-Z9G6Y6" <> ToString[#]
]&,
RandomChoice[Permutations[{1,1+4,1+8, 1+12,1+17}],50]]


Test[
	straightQ[Part[Deck,{1,1+4,1+8, 1+12,1+17,1+21}]]
	,
	True
	,
	TestID->"HandTest-20110217-O0Y9Y3"
]

Test[
	straightQ[Part[Deck,{1, 1 + 4, 1 + 8, 1 + 13, 1 + 4*12}]]
	,
	True
	,
	TestID->"HandTest-20110217-H0C1N8"
]



(****************************************************************************)
(*                          aceLowStraightQ[]                               *)
(****************************************************************************)
Test[
	aceLowStraightQ[{}]
	,
	False
	,
	TestID->"HandTest-20110217-B9T6J6"
]

Test[
	aceLowStraightQ[Part[Deck,{1}]]
	,
	False
	,
	TestID->"HandTest-20110217-I7R3R1"
]

Test[
	aceLowStraightQ[Part[Deck,{1,1+4}]]
	,
	False
	,
	TestID->"HandTest-20110217-N2C5W1"
]

Test[
	aceLowStraightQ[Part[Deck,{1,1+4,1+8}]]
	,
	False
	,
	TestID->"HandTest-20110217-R1S0F5"
]

Test[
	aceLowStraightQ[Part[Deck,{1,1+4,1+8, 1+12}]]
	,
	False
	,
	TestID->"HandTest-20110217-D1J3T0"
]

Test[
	aceLowStraightQ[Part[Deck,{1,1+4,1+8, 1+12,1+16}]]
	,
	False
	,
	TestID->"HandTest-20110217-P7Q1A1"
]


Scan[Test[
	aceLowStraightQ[Part[Deck,#]]
	,
	True
	,
	TestID->"HandTest-20110217-U8X3S8" <> ToString[#]
]&,
RandomChoice[Permutations[{1, 1 + 4, 1 + 8, 1 + 13, 1 + 4*12}],50]]

(****************************************************************************)
(*                          straightFlushQ[]                                *)
(****************************************************************************)

Test[
	straightFlushQ[{}]
	,
	False
	,
	TestID->"HandTest-20110217-G6A5K9"
]

Test[
	straightFlushQ[Part[Deck,{1}]]
	,
	False
	,
	TestID->"HandTest-20110217-S2G8B8"
]

Test[
	straightFlushQ[Part[Deck,{1,1+4}]]
	,
	False
	,
	TestID->"HandTest-20110217-J0E4N1"
]

Test[
	straightFlushQ[Part[Deck,{1,1+4,1+8}]]
	,
	False
	,
	TestID->"HandTest-20110217-H5Z9P6"
]

Test[
	straightFlushQ[Part[Deck,{1,1+4,1+8, 1+12}]]
	,
	False
	,
	TestID->"HandTest-20110217-J6K5E9"
]

Test[
	straightFlushQ[Part[Deck,{1,1+4,1+8, 1+12,1+17}]]
	,
	False
	,
	TestID->"HandTest-20110217-Z0F8A5"
]

Test[
	straightFlushQ[Part[Deck,{1,1+4,1+8, 1+12,1+16}]]
	,
	True
	,
	TestID->"HandTest-20110217-E0O1A0"
]

(*ace low*)
Test[
	straightFlushQ[Part[Deck,{1, 1 + 4, 1 + 8, 1 + 12, 1 + 4*12}]]
	,
	True
	,
	TestID->"HandTest-20110217-Z2L2Y0"
]


Scan[Test[
	straightFlushQ[Part[Deck,#]]
	,
	True
	,
	TestID->"HandTest-20110217-T1W9F4" <> ToString[#]
]&,
RandomChoice[Permutations[{1,1+4,1+8, 1+12,1+16}],50]]

(****************************************************************************)
(*                          royalFlushQ[]                                   *)
(****************************************************************************)
Test[
	straightFlushQ[Part[Deck, {1 + 4*8, 2 + 4*9, 3 + 4*10, 4 + 4*11, 1 + 4*12}]]
	,
	False
	,
	TestID->"HandTest-20110217-A2W5A5"
]


Scan[Test[
	straightFlushQ[Part[Deck, #]]
	,
	True
	,
	TestID->"HandTest-20110217-N7L3Z2"
]&,
RandomChoice[Permutations[{1 + 4*8, 1 + 4*9, 1 + 4*10, 1 + 4*11, 1 + 4*12}],50]]


Test[
	straightFlushQ[Part[Deck, {2 + 4*8, 2 + 4*9, 2 + 4*10, 2 + 4*11, 2 + 4*12}]]
	,
	True
	,
	TestID->"HandTest-20110217-A2W5A5"
]

Test[
	straightFlushQ[Part[Deck, Reverse[{3 + 4*8, 3 + 4*9, 3 + 4*10, 3 + 4*11, 3 + 4*12}]]]
	,
	True
	,
	TestID->"HandTest-20110217-S0A2N3"
]
