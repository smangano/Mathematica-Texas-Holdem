(* Mathematica Test File *)

worstHand = Deck[[{1, 6, 9, 14, 21}]];
worstHand2 = Deck[[{1, 6, 9, 14, 25}]];

Test[
	handRanking[worstHand] < handRanking[worstHand2]
	,
	True
	,
	TestID->"HandRankingTest-20110218-D3O0N5"
]


worstPair = Deck[[{1, 2, 6, 9, 14}]];
worstPair2 = Deck[[{1, 5, 6, 9, 14}]];
bestPair = Deck[[{50, 51, 48, 44, 40}]]
bestPair2 = Deck[[{50, 47, 48, 44, 40}]]
bestHighCard = {card[14,Spades], card[2,Clubs],card[3,Hearts],card[4,Hearts],card[6,Clubs]};

Test[
	handRanking[worstPair] < handRanking[worstPair2]
	,
	True
	,
	TestID->"HandRankingTest-20110218-U8L7Z0"
]

Test[
	handRanking[bestHighCard] < handRanking[worstPair]
	,
	True
	,
	TestID->"HandRankingTest-20110218-F7A5E4"
]

Test[
	handRanking[bestPair2] < handRanking[bestPair]
	,
	True
	,
	TestID->"HandRankingTest-20110218-D3A7O7"
]

worstTwoPair = Deck[[{1, 2, 5, 6, 9}]] ;
worstTwoPair2 = Deck[[{1, 5, 6, 9, 10}]] ;
bestTwoPair = Deck[[{50, 51, 48, 44, 47}]] ;

Test[
	handRanking[bestPair] < handRanking[worstTwoPair]
	,
	True
	,
	TestID->"HandRankingTest-20110218-H2A1B0"
]

Test[
	handRanking[worstTwoPair] < handRanking[worstTwoPair2]
	,
	True
	,
	TestID->"HandRankingTest-20110218-Y1H7M0"
]

Test[
	handRanking[worstTwoPair] < handRanking[bestTwoPair]
	,
	True
	,
	TestID->"HandRankingTest-20110218-D3O7Y9"
]

worstTrips = Deck[[{1, 2, 3, 5, 9}]] ;
worstTrips2 = Deck[[{1, 5, 6, 7, 9}]] ;
bestTrips = Deck[[{50, 51, 52, 48, 44}]];

Test[
	handRanking[worstTrips] < handRanking[worstTrips2]
	,
	True
	,
	TestID->"HandRankingTest-20110218-K2H3I9"
]

Test[
	handRanking[bestTwoPair] < handRanking[worstTrips]
	,
	True
	,
	TestID->"HandRankingTest-20110218-P7L9D1"
]

Test[
	handRanking[worstTrips2] < handRanking[bestTrips]
	,
	True
	,
	TestID->"HandRankingTest-20110218-F9X8F3"
]
worstStraight = Deck[[{50, 1, 5, 9, 13}]] ;
worstStraight2 = Deck[[{1, 5, 9, 13, 18}]] ;
bestStraight =  Deck[[{52, 48, 44, 40, 35}]];
Test[
	handRanking[bestTrips] < handRanking[worstStraight]
	,
	True
	,
	TestID->"HandRankingTest-20110218-H4D8S4"
]

Test[
	handRanking[worstStraight] < handRanking[worstStraight2]
	,
	True
	,
	TestID->"HandRankingTest-20110218-O4L6N0"
]

Test[
	handRanking[worstStraight2] < handRanking[bestStraight]
	,
	True
	,
	TestID->"HandRankingTest-20110218-Y4L3V4"
]

worstFlush = Deck[[{1, 5, 9, 13, 21}]] ;
worstFlush2 = Deck[[{1, 5, 9, 17, 21}]] ;
worstFlush3 = Deck[[{1, 5, 9, 13, 25}]] ;
bestFlush = Deck[[{52, 48, 44, 40, 32}]] ;

Test[
	handRanking[bestStraight] < handRanking[worstFlush]
	,
	True
	,
	TestID->"HandRankingTest-20110218-G4Q3I3"
]

Test[
	handRanking[worstFlush] < handRanking[worstFlush2]
	,
	True
	,
	TestID->"HandRankingTest-20110218-F1S0E4"
]

Test[
	handRanking[worstFlush2] < handRanking[bestFlush]
	,
	True
	,
	TestID->"HandRankingTest-20110218-L3M6Y3"
]


worstFullHouse = Deck[[{1, 2, 3, 5, 6}]] ;
worstFullHouse2 = Deck[[{5, 6, 7, 1, 2}]] ;
bestFullHouse = Deck[[{52, 51, 50, 48, 47}]] ;

Test[
	handRanking[bestFlush] < handRanking[worstFullHouse]
	,
	True
	,
	TestID->"HandRankingTest-20110218-X9V1J9"
]

Test[
	handRanking[worstFullHouse] < handRanking[worstFullHouse2]
	,
	True
	,
	TestID->"HandRankingTest-20110218-K9E0I4"
]

Test[
	handRanking[worstFullHouse2] < handRanking[bestFullHouse]
	,
	True
	,
	TestID->"HandRankingTest-20110218-N6C3J5"
]

worstQuads = Deck[[{1, 2, 3, 4, 5}]] ;
worstQuads2 = Deck[[{5, 6, 7, 8, 1}]] ;
bestQuads = Deck[[{52, 51, 50, 49, 48}]] ;

Test[
	handRanking[bestFullHouse] < handRanking[worstQuads]
	,
	True
	,
	TestID->"HandRankingTest-20110218-G4N3Q0"
]

Test[
	handRanking[worstQuads] < handRanking[worstQuads2]
	,
	True
	,
	TestID->"HandRankingTest-20110218-M0P2Y8"
]

Test[
	handRanking[worstQuads2] < handRanking[bestQuads]
	,
	True
	,
	TestID->"HandRankingTest-20110218-B5J9M5"
]

worstStraightFlush = Deck[[{1, 5, 9, 13, 17}]] ;
worstStraightFlush2 = Deck[[{5, 9, 13, 17, 21}]] ;
royalStraightFlush = Deck[[{52, 48, 44, 40, 36}]] ;
Test[
	handRanking[bestQuads] < handRanking[worstStraightFlush]
	,
	True
	,
	TestID->"HandRankingTest-20110218-L7E2E3"
]

Test[
	handRanking[worstStraightFlush] < handRanking[worstStraightFlush2]
	,
	True
	,
	TestID->"HandRankingTest-20110218-A1F4K1"
]

Test[
	handRanking[worstStraightFlush2] < handRanking[royalStraightFlush]
	,
	True
	,
	TestID->"HandRankingTest-20110218-P5V2G8"
]

(* Exhaustively Test non-straight flush rankings *)
allPossibleNonStraightFlushRanks = SortBy[DeleteCases[DeleteCases[
  Union[Sort /@ Permutations[Range[2, 14], {5}]], {a_, b_, c_, d_, 
    e_} /; a == b - 1 && b == c - 1 && c == d - 1 && 
    d == e - 1],{2,3,4,5,14}], TexasHoldem`Private`franker];
 
allPossibleNonStraightFlushHandRankings = handRanking[Flatten[Outer[card, #, {Clubs}]]] & /@ allPossibleNonStraightFlushRanks ;  

Test[
	Sort[allPossibleNonStraightFlushHandRankings]
	,
	Evaluate[allPossibleNonStraightFlushHandRankings]
	,
	TestID->"HandRankingTest-20110218-D6M7L0"
]    

nextIdx = 1;
next[l_List] := 
 Module[{c}, c = l[[nextIdx]]; nextIdx = Mod[nextIdx, Length[l]] + 1; 
  c]

allPossibleQuads =  ReleaseHold[
 Flatten[Outer[
     card, #, {Hold[next[{Clubs, Spades, Hearts, Diamonds}]]}]] & /@ 
  Select[Flatten[
    Outer[Append, Table[i, {i, 2, 14}, {4}], Range[2, 14], 1], 1], 
   Not[Equal @@ #] &]] ;
   
   
allPossibleQuadRankings  = handRanking /@ allPossibleQuads ;

Test[
	OrderedQ[allPossibleQuadRankings,Less]
	,
	True
	,
	TestID->"HandRankingTest-20110219-Y4L6K6"
]

allPossibleTrips = ReleaseHold[
 Flatten[Outer[
     card, #, {Hold[next[{Clubs, Spades, Hearts, Diamonds}]]}]] & /@ 
  Select[Flatten[
    Outer[Append, Table[i, {i, 2, 14}, {3}], Range[2, 14], 1], 1], 
   Not[Equal @@ #] &]]
   
   
allPossibleTripsRankings  = handRanking /@ allPossibleTrips ;

Test[
	OrderedQ[allPossibleTripsRankings,Less]
	,
	True
	,
	TestID->"HandRankingTest-20110219-N4G4F5"
]

allPossiblePair = ReleaseHold[
 Flatten[Outer[
     card, #, {Hold[next[{Clubs, Spades, Hearts, Diamonds}]]}]] & /@ 
  Flatten[Table[{i, i, j, j + 1, j + 2}, {i, 2, 14}, {j, i + 1, 12}], 
   1]];
   
allPossiblePairRankings = handRanking /@ allPossiblePair ;

Test[
	OrderedQ[allPossiblePairRankings,Less]
	,
	True
	,
	TestID->"HandRankingTest-20110219-M3F0V3"
]  
   
allPossibleTwoPair = ReleaseHold[
 Flatten[Outer[
     card, #, {Hold[next[{Clubs, Spades, Hearts, Diamonds}]]}]] & /@ 
  Select[Flatten[
    Outer[Append, Table[i, {i, 2, 14}, {4}], Range[2, 14], 1], 1], 
   Not[Equal @@ #] &]] ;
   
allPossibleTwoPairRankings  = handRanking /@ allPossibleTwoPair ;

Test[
	OrderedQ[allPossibleTwoPairRankings,Less]
	,
	True
	,
	TestID->"HandRankingTest-20110219-U3W3F7"
]

allPossibleFullHouse = ReleaseHold[
 Flatten[Outer[
     card, #, {Hold[next[{Clubs, Spades, Hearts, Diamonds}]]}]] & /@ 
  Select[Flatten[
    Table[If[i != j, {i, i, i, j, j}, {}], {i, 2, 14}, {j, 2, 14}], 
    1], Length[#] > 0 &]];
    
allPossibleFullHouseRankings  = handRanking /@ allPossibleFullHouse ;

Test[
	OrderedQ[allPossibleFullHouseRankings,Less]
	,
	True
	,
	TestID->"HandRankingTest-20110219-J1I0T6"
]

straightRanks = 
 Join[{{14, 2, 3, 4, 5}}, Table[Range[i, i + 4], {i, 2, 10}]];
 
allPossibleStraights =ReleaseHold[
 Flatten[Outer[
     card, #, {Hold[next[{Clubs, Spades, Hearts, Diamonds}]]}]] & /@ 
  straightRanks];
  
allPossibleStraightRankings = handRanking /@   allPossibleStraights ;

Test[
	OrderedQ[allPossibleStraightRankings,Less]
	,
	True
	,
	TestID->"HandRankingTest-20110219-A2N7S1"
]

allPossibleStraightFlushes = Flatten[Outer[card, #, {Clubs}]] & /@ straightRanks

allPossibleStraightFlushRankings = handRanking /@ allPossibleStraightFlushes ;

Test[
	OrderedQ[allPossibleStraightFlushRankings,Less]
	,
	True
	,
	TestID->"HandRankingTest-20110219-K5U6M6"
]

allPossibleHighCardHands = ReleaseHold[
 Flatten[Outer[
     card, #, {Hold[next[{Clubs, Spades, Hearts, Diamonds}]]}]] & /@ 
  Select[Flatten[
    Table[{i, j, j - 1, j - 2, j - 4}, {i, 14, 2, -1}, {j, i - 1, 
      2, -1}], 1],
   Greater @@ Append[#, 1] &]];
   
 allPossibleHighCardHandRankings = handRanking /@  allPossibleHighCardHands ;
 
 Test[
	OrderedQ[allPossibleHighCardHandRankings,Greater]
	,
	True
	,
	TestID->"HandRankingTest-20110219-S5M4F4"
]

Test[
	winners[allPossibleHighCardHands]
	,
	Evaluate[{First[allPossibleHighCardHands]}]
	,
	TestID->"HandRankingTest-20110219-P3L4V2"
]

Print[{First[allPossibleHighCardHands],First[allPossibleStraightFlushes], First[allPossibleQuads]}]

Test[
	winners[{First[allPossibleHighCardHands],First[allPossibleStraightFlushes], First[allPossibleQuads]}]
	,
	Evaluate[{First[allPossibleStraightFlushes]}]
	,
	TestID->"HandRankingTest-20110219-C6M3E8"
]

Test[
	winners[{First[allPossibleHighCardHands],First[allPossibleHighCardHands], First[allPossibleHighCardHands]}]
	,
	Evaluate[{First[allPossibleHighCardHands],First[allPossibleHighCardHands], First[allPossibleHighCardHands]}]
	,
	TestID->"HandRankingTest-20110219-M8I5A7"
]

  