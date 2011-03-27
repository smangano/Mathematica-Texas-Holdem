(* Tests for Pot functions *)
(* Copyright 2011 Sal Mangano. All rights reserved *)

Test[
	pot[]
	,
	Pot[0]
	,
	TestID->"PotTest-20110221-D8L3B5"
]
Test[
	pot[100]
	,
	Pot[100]
	,
	TestID->"PotTest-20110221-V1V3L9"
]

Test[
	pot[Pot[100],50]
	,
	Pot[150]
	,
	TestID->"PotTest-20110221-J8X1N3"
]

Test[
	pot[Pot[1000,100],100]
	,
	Pot[1000,200]
	,
	TestID->"PotTest-20110221-I2C7K5"
]

Test[
	pot[Pot[1000,100], 500, 1]
	,
	Pot[1500,100]
	,
	TestID->"PotTest-20110221-K9H5U8"
]

Test[
	pot[Pot[1000,100], 100, 2]
	,
	Pot[1000,200]
	,
	TestID->"PotTest-20110221-O8W8M7"
]

Test[
	pot[Pot[1000], 100, 2]
	,
	Pot[1000,100]
	,
	TestID->"PotTest-20110221-O8W8M8"
]

Test[
	pot[Pot[1000,1000], 100, 3]
	,
	Pot[1000,1000,100]
	,
	TestID->"PotTest-20110221-O8W8M9"
]

Test[
	payout[Stacks[1000,1500], Pot[1000], {1}, 1]
	,
	Stacks[2000,1500]
	,
	TestID->"PotTest-20110221-O4Q4Z1"
]

Test[
	payout[Stacks[1000,1500], Pot[1000], {2}, 1]
	,
	Stacks[1000,2500]
	,
	TestID->"PotTest-20110221-O4Q4Z2"
]

Test[
	payout[Stacks[1000,1500], Pot[1000,200], {2}, 2]
	,
	Stacks[1000,1700]
	,
	TestID->"PotTest-20110221-O4Q4Z3"
]

Test[
	payout[Stacks[1000,1500, 100], Pot[1000], {1,3}, 1]
	,
	Stacks[1500,1500, 600]
	,
	TestID->"PotTest-20110221-O4Q4Z4"
]
