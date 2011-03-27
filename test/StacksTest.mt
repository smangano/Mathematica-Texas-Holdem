(* Mathematica Tests Stacks functions *)
(* Copyright 2011 Sal Mangano. All rights reserved *)(* Mathematica Test File *)

Test[
	Plus@@stacks[9,1500]
	,
	9*1500
	,
	TestID->"StacksTest-20110221-C5V7I9"
]

Do[Test[
	stack[stacks[9,1500],i]
	,
	1500
	,
	TestID->"StacksTest-20110221-X5D6R8"
],
{i,9}]

Test[
	updateStacks[stacks[5,1500], 500, 1]
	,
	Stacks[1000,1500,1500,1500,1500]
	,
	TestID->"StacksTest-20110221-M3G5K3"
]

Test[
	updateStacks[stacks[5,1500], 500, 5]
	,
	Stacks[1500,1500,1500,1500,1000]
	,
	TestID->"StacksTest-20110221-I2E2A2"
]

Test[
	allInPlayers[stacks[5,1500]]
	,
	{}
	,
	TestID->"StacksTest-20110221-Y4F3Y9"
]

Test[
	allInPlayers[updateStacks[stacks[5,1500],1500,3]]
	,
	{3}
	,
	TestID->"StacksTest-20110221-F2W8S5"
]

Test[
	allInPlayers[updateStacks[updateStacks[stacks[5,1500],1500,3],1500,5]]
	,
	{3,5}
	,
	TestID->"StacksTest-20110221-R8J9W7"
]

Test[
	nonAllInPlayers[stacks[5,1500]]
	,
	{1,2,3,4,5}
	,
	TestID->"StacksTest-20110221-J5A5I3"
]

Test[
	nonAllInPlayers[updateStacks[stacks[5,1500],1500,3]]
	,
	{1,2,4,5}
	,
	TestID->"StacksTest-20110221-N7J1I9"
]

Test[
	nonAllInPlayers[updateStacks[updateStacks[stacks[5,1500],1500,3],1500,5]]
	,
	{1,2,4}
	,
	TestID->"StacksTest-20110221-V0Q0O2"
]


Test[
	allInQ[stacks[5,1500]]
	,
	False
	,
	TestID->"StacksTest-20110221-I4N4V1"
]

Test[
	allInQ[updateStacks[stacks[5,1500],1500,3]]
	,
	True
	,
	TestID->"StacksTest-20110221-E4Z6Y1"
]

Test[
	allInQ[updateStacks[updateStacks[stacks[5,1500],1500,3],1500,5]]
	,
	True
	,
	TestID->"StacksTest-20110221-W0N4B2"
]




Test[
	allInQ[stacks[5,1500],1]
	,
	False
	,
	TestID->"StacksTest-20110221-N9V6E5"
]

Test[
	allInQ[updateStacks[stacks[5,1500],1500,3],3]
	,
	True
	,
	TestID->"StacksTest-20110221-W1Y5U6"
]

Do[Test[
	allInQ[updateStacks[updateStacks[stacks[5,1500],1500,3],1500,5],i]
	,
	Evaluate[i == 3 || i == 5]
	,
	TestID->"StacksTest-20110221-K2W5S1"
],
{i,5}]
