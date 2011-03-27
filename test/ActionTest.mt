(*  Action Test File *)
(* Copyright 2011 Sal Mangano. All rights reserved *)

SeedRandom[11] ;
onButton = 3;
nPlayers = 9 ;
testGame = moneyGame[nPlayers,onButton,100, 50, 10] ;
testAction = actionInit[testGame] ;

Test[
	potsGoodQ[testAction]
	,
	False
	,
	TestID->"ActionTest-20110223-B8Z1R5"
]

Test[
	initiator[testAction]
	,
	5 (*3 is on button so 5 is BB *) 
	,
	TestID->"ActionTest-20110222-A6Z2B6"
]

Test[
	lastToAct[testAction]
	,
	5 (*BB is also last to act at start of game*) 
	,
	TestID->"ActionTest-20110222-A6Z2B7"
]

Test[
	inAction[testAction]
	,
	{5} (*BB is also the only player in the action at start of game*) 
	,
	TestID->"ActionTest-20110222-A4K0C1"
]

Test[
	nextToActList[testAction]
	,
	{6,7,8,9,1,2,3,4}
	,
	TestID->"ActionTest-20110222-A6Z2B8"
]

Test[
	nextToAct[testAction]
	,
	6
	,
	TestID->"ActionTest-20110222-O8J5D5"
]

(*Player 6 folds *)
testAction2 = actionFold[testAction, 6] ;

Test[
	potsGoodQ[testAction2]
	,
	False
	,
	TestID->"ActionTest-20110223-K8T6B6"
]

Test[
	initiator[testAction2]
	,
	5 (*3 is on button so 5 is BB *) 
	,
	TestID->"ActionTest-20110222-R5R3O8"
]

Test[
	lastToAct[testAction2]
	,
	5 (*BB is also last to act at start of game*) 
	,
	TestID->"ActionTest-20110222-A5L4R5"
]

Test[
	inAction[testAction2]
	,
	{5} (*BB is also the only player in the action at start of game*) 
	,
	TestID->"ActionTest-20110222-Y2U3T7"
]

Test[
	nextToActList[testAction2]
	,
	{7,8,9,1,2,3,4}
	,
	TestID->"ActionTest-20110222-U8G8Q3"
]

Test[
	nextToAct[testAction2]
	,
	7
	,
	TestID->"ActionTest-20110222-J3H4H2"
]


(*Player 7 bets *)
testAction3 = actionBet[testAction2, 7] ;
Test[
	potsGoodQ[testAction3]
	,
	False
	,
	TestID->"ActionTest-20110223-T0P0X8"
]

Test[
	initiator[testAction3]
	,
	7 (*3 is on button so 5 is BB *) 
	,
	TestID->"ActionTest-20110222-Z4Z4J0"
]

Test[
	lastToAct[testAction3]
	,
	7 (*7 just bet*) 
	,
	TestID->"ActionTest-20110222-W6U1R8"
]

Test[
	inAction[testAction3]
	,
	{7} (*7 is now  the only player in the action. bb needs to call.*) 
	,
	TestID->"ActionTest-20110222-O3O7T0"
]

Test[
	nextToActList[testAction3]
	,
	{8,9,1,2,3,4,5}
	,
	TestID->"ActionTest-20110222-T2P3N1"
]

Test[
	nextToAct[testAction3]
	,
	8
	,
	TestID->"ActionTest-20110222-U7J0P5"
]

(*Player 8 folds *)
testAction4 = actionFold[testAction3, 8] ;
Test[
	potsGoodQ[testAction4]
	,
	False
	,
	TestID->"ActionTest-20110223-H7N4S1"
]
Test[
	initiator[testAction4]
	,
	7 (*3 is on button so 5 is BB *) 
	,
	TestID->"ActionTest-20110222-Y9U2Q8"
]

Test[
	lastToAct[testAction4]
	,
	7 (*7 just bet*) 
	,
	TestID->"ActionTest-20110222-P5L3A1"
]

Test[
	inAction[testAction4]
	,
	{7} (*7 is now  the only player in the action. bb needs to call.*) 
	,
	TestID->"ActionTest-20110222-S9Y4R2"
]

Test[
	nextToActList[testAction4]
	,
	{9,1,2,3,4,5}
	,
	TestID->"ActionTest-20110222-O3Y4C2"
]

Test[
	nextToAct[testAction4]
	,
	9
	,
	TestID->"ActionTest-20110222-I2G6H1"
]

(*Player 9 calls *)
testAction5 = actionCall[testAction4, 9] ;
Test[
	potsGoodQ[testAction5]
	,
	False
	,
	TestID->"ActionTest-20110223-L1G3X3"
]
Test[
	initiator[testAction5]
	,
	7  
	,
	TestID->"ActionTest-20110222-T0Z1O6"
]

Test[
	lastToAct[testAction5]
	,
	9 
	,
	TestID->"ActionTest-20110222-P4D7A3"
]

Test[
	inAction[testAction5]
	,
	{7,9}  
	,
	TestID->"ActionTest-20110222-K5O5N7"
]

Test[
	nextToActList[testAction5]
	,
	{1,2,3,4,5}
	,
	TestID->"ActionTest-20110222-B6R4S4"
]

Test[
	nextToAct[testAction5]
	,
	1
	,
	TestID->"ActionTest-20110222-E0A5O3"
]

(*Player 1 calls *)
testAction6 = actionCall[testAction5, 1] ;
Test[
	potsGoodQ[testAction6]
	,
	False
	,
	TestID->"ActionTest-20110223-X3Y3V4"
]
Test[
	initiator[testAction6]
	,
	7  
	,
	TestID->"ActionTest-20110222-A7N1X0"
]

Test[
	lastToAct[testAction6]
	,
	1 
	,
	TestID->"ActionTest-20110222-V5D7Y0"
]

Test[
	inAction[testAction6]
	,
	{7,9,1}  
	,
	TestID->"ActionTest-20110222-L4H2S3"
]

Test[
	nextToActList[testAction6]
	,
	{2,3,4,5}
	,
	TestID->"ActionTest-20110222-O1G0A5"
]

Test[
	nextToAct[testAction6]
	,
	2
	,
	TestID->"ActionTest-20110222-Y9T4R3"
]

(*Remaing players fold - note use of mathematica's Fold here is a coincidence!*)
testAction7 = 
Fold[(actionFold[#1, #2])&, testAction6, nextToActList[testAction6]];
Test[
	potsGoodQ[testAction7]
	,
	True
	,
	TestID->"ActionTest-20110223-P4B6V5"
]

Test[
	handDoneQ[testAction7]
	,
	False
	,
	TestID->"ActionTest-20110223-P4B6V6"
]

Test[
	initiator[testAction7]
	,
	7  
	,
	TestID->"ActionTest-20110222-K6N7G9"
]

Test[
	lastToAct[testAction7]
	,
	1 
	,
	TestID->"ActionTest-20110222-W5Q0Q4"
]

Test[
	inAction[testAction7]
	,
	{7,9,1}  
	,
	TestID->"ActionTest-20110222-V9B7A4"
]

Test[
	nextToActList[testAction7]
	,
	{}
	,
	TestID->"ActionTest-20110222-E3D5L7"
]

Test[
	nextToAct[testAction7]
	,
	Null
	,
	TestID->"ActionTest-20110222-I5B6X6"
]


(*Ready for another round of betting after flop *)
testAction8 = actionReset[testAction7,onButton,nPlayers] ;
Test[
	potsGoodQ[testAction8]
	,
	False
	,
	TestID->"ActionTest-20110223-X1X1B0"
]
Test[
	initiator[testAction8]
	,
	7  
	,
	TestID->"ActionTest-20110223-T3S4H2"
]

Test[
	lastToAct[testAction8]
	,
	1 
	,
	TestID->"ActionTest-20110223-P8U0L8"
]

Test[
	inAction[testAction8]
	,
	{} 
	,
	TestID->"ActionTest-20110223-P1H4I9"
]

Test[
	nextToActList[testAction8]
	,
	{7,9,1}
	,
	TestID->"ActionTest-20110223-O1O0T0"
]

Test[
	nextToAct[testAction8]
	,
	7
	,
	TestID->"ActionTest-20110223-M1D2A5"
]
(*
7 checks
9  bets
1 calls
7 folds
*)

testAction9 = actionFold[actionCall[actionBet[actionCheck[testAction8,7],9],1],7];
Print[action9]
Test[
	potsGoodQ[testAction9]
	,
	True
	,
	TestID->"ActionTest-20110223-P1M1O6"
]
Test[
	initiator[testAction9]
	,
	9  
	,
	TestID->"ActionTest-20110223-W1X8V0"
]

Test[
	lastToAct[testAction9]
	,
	1 
	,
	TestID->"ActionTest-20110223-V5C8H3"
]

Test[
	inAction[testAction9]
	,
	{9,1} 
	,
	TestID->"ActionTest-20110223-G4K0E7"
]

Test[
	nextToActList[testAction9]
	,
	{}
	,
	TestID->"ActionTest-20110223-I0C3Y5"
]

Test[
	nextToAct[testAction9]
	,
	Null
	,
	TestID->"ActionTest-20110223-E3O4G1"
]
(*
9 bets
1 raises
9 re-raises
1 calls
*)
testAction10 = actionCall[actionRaise[actionRaise[actionBet[actionReset[testAction9,onButton,nPlayers],9],1],9],1];
Test[
	potsGoodQ[testAction10]
	,
	True
	,
	TestID->"ActionTest-20110224-Q9M2B3"
]

(*
9 Checks
1 raises
9 Folds
Hand over - 1 wins
*)
testAction11 = actionFold[actionRaise[actionCheck[actionReset[testAction9,onButton,nPlayers],9],1],9];
Test[
	handDoneQ[testAction11]
	,
	True
	,
	TestID->"ActionTest-20110224-W0S2U6"
]

(*Different scenario starting from action5*)
(*Player 1 raises *)
testActionAlt1 = actionRaise[testAction5, 1] ;

Test[
	initiator[testActionAlt1]
	,
	1  
	,
	TestID->"ActionTest-20110223-Q4S3K4"
]


Test[
	lastToAct[testActionAlt1]
	,
	1 
	,
	TestID->"ActionTest-20110223-K3J4P9"
]

Test[
	inAction[testActionAlt1]
	,
	{1}  
	,
	TestID->"ActionTest-20110223-X6T5P2"
]

Test[
	nextToActList[testActionAlt1]
	,
	{2,3,4,5,7,9}
	,
	TestID->"ActionTest-20110223-R8U4Y6"
]

Test[
	nextToAct[testActionAlt1]
	,
	2
	,
	TestID->"ActionTest-20110223-B7B2J7"
]

(*Every one calls raise *)
testActionAlt2 = Fold[actionCall[#1,#2]&, testActionAlt1, nextToActList[testActionAlt1]] ;
Test[
	potsGoodQ[testActionAlt2]
	,
	True
	,
	TestID->"ActionTest-20110224-Y3Q8B1"
]

testActionAlt3 = actionReset[testActionAlt2,onButton,nPlayers];
Test[
	nextToAct[testActionAlt3]
	,
	4
	,
	TestID->"ActionTest-20110224-H5P2J2"
]
(* 4 raise and everyone else folds *)
testActionAlt3 = Fold[actionFold[#1,#2]&, actionRaise[testActionAlt3, 4], Drop[nextToActList[testActionAlt3],1]];
Test[
	handDoneQ[testActionAlt3]
	,
	True
	,
	TestID->"ActionTest-20110224-P7C1H0"
]

