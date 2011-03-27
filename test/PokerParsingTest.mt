(*Mathematica Tests for Betting functions *)
(* Copyright 2011 Sal Mangano. All rights reserved *)

Needs["TexasHoldem`"];
Needs["TexasHoldem`Parsing`"];

Test[
	TexasHoldem`Parsing`Private`rankLetterToNum /@ Characters["AKQJT98765432"]
	,
	Evaluate[Range[14,2,-1]]
	,
	TestID->"PokerParsingTest-20110317-W5L6O5"
]

Test[
	TexasHoldem`Parsing`Private`rankLetterToNum["R"]
	,
	random[]
	,
	TestID->"PokerParsingTest-20110317-K4G1W1"
]

Test[
	TexasHoldem`Parsing`Private`suitLetterToSym /@ Characters["hdcs"]
	,
	{Hearts,Diamonds,Clubs,Spades}
	,
	TestID->"PokerParsingTest-20110317-W5L6O6"
]

Do[
	Test[
	SameQ@@TexasHoldem`Parsing`Private`offsuitPair[] 
	,
	False
	,
	TestID->"PokerParsingTest-20110317-I0D2K8"
],
{10}]

Do[
	Test[
	SameQ@@TexasHoldem`Parsing`Private`suitedPair[] 
	,
	True
	,
	TestID->"PokerParsingTest-20110317-K5X8D6"
],
{10}]

 Test[
	parseHandsInit[];First/@parseHand["AKo"]
	,
	{Ace,King}
	,
	TestID->"PokerParsingTest-20110317-N5Z2J7"
]

Test[
	parseHandsInit[];SameQ@@(Part[#,2]&/@parseHand["AKo"])
	,
	False
	,
	TestID->"PokerParsingTest-20110317-X6O0D9"
]

Test[
	parseHandsInit[];First/@parseHand["AKs"]
	,
	{Ace,King}
	,
	TestID->"PokerParsingTest-20110317-H1Z7O2"
]

Test[
	parseHandsInit[];SameQ@@(Part[#,2]&/@parseHand["AKs"])
	,
	True
	,
	TestID->"PokerParsingTest-20110317-C2Z3N6"
]

Test[
	parseHandsInit[];First/@parseHand["AA"]
	,
	{Ace,Ace}
	,
	TestID->"PokerParsingTest-20110318-H4S4U5"
]

Test[
	parseHandsInit[];UnsameQ@@(Part[#,2]&/@parseHand["AA"])
	,
	True
	,
	TestID->"PokerParsingTest-20110318-C6R3C9"
]
Test[
	parseHandsInit[];parseHand["7Cs"][[1,1]]
	,
	7
	,
	TestID->"PokerParsingTest-20110317-W6J4X3"
]

Test[
	parseHandsInit[];parseHand["7Cs"][[2,1]]
	,
	connector[]
	,
	TestID->"PokerParsingTest-20110317-V4Q4L5"
]

Test[
	parseHandsInit[];parseHand["7Cs"][[2,2]]
	,
	suited[]
	,
	TestID->"PokerParsingTest-20110317-O7M7M5"
]

Test[
	parseHandsInit[];parseHand["7Co"][[2,2]]
	,
	offsuit[]
	,
	TestID->"PokerParsingTest-20110317-C7H6K2"
]


Test[
	parseHandsInit[];parseHand["RCs"][[1,1]]
	,
	random[]
	,
	TestID->"PokerParsingTest-20110317-Y2F8Q1"
]

Test[
	parseHandsInit[];parseHand["RCs"][[2,1]]
	,
	connector[]
	,
	TestID->"PokerParsingTest-20110317-L9U7I4"
]

Test[
	parseHandsInit[];parseHand["RCs"][[2,2]]
	,
	suited[]
	,
	TestID->"PokerParsingTest-20110317-A6I4S2"
]

Test[
	parseHandsInit[];parseHand["RCo"][[2,2]]
	,
	offsuit[]
	,
	TestID->"PokerParsingTest-20110317-F4J3C9"
]

Test[
	parseHandsInit[];First/@parseHand["RKs"]
	,
	{random[],King}
	,
	TestID->"PokerParsingTest-20110317-J6L4C2"
]

Test[
	parseHandsInit[];parseHand["RKs"][[1]]
	,
	card[random[],random[]]
	,
	TestID->"PokerParsingTest-20110317-J2D2M4"
]

Test[
	parseHandsInit[];parseHand["RKs"][[2]]
	,
	Evaluate[card[King,suited[]]]
	,
	TestID->"PokerParsingTest-20110317-J2D2M5"
]



Test[
	parseHandsInit[];First/@parseHand["RKo"]
	,
	{random[],King}
	,
	TestID->"PokerParsingTest-20110317-U8U2V7"
]

Test[
	parseHandsInit[];parseHand["RKo"][[1]]
	,
	card[random[],random[]]
	,
	TestID->"PokerParsingTest-20110317-A4P2F7"
]

Test[
	parseHandsInit[];parseHand["RKo"][[2]]
	,
	Evaluate[card[King,offsuit[]]]
	,
	TestID->"PokerParsingTest-20110317-W9X5G0"
]

Test[
	parseHandsInit[];First/@parseHand["KRs"]
	,
	{King,random[]}
	,
	TestID->"PokerParsingTest-20110317-O2I2F8"
]

Test[
	parseHandsInit[];parseHand["KRs"][[2]]
	,
	card[random[],suited[]]
	,
	TestID->"PokerParsingTest-20110317-R6E9Y0"
]

Test[
	MatchQ[parseHandsInit[];parseHand["KRs"][[1]],card[King,Spades|Hearts|Clubs|Diamonds]]
	,
	True
	,
	TestID->"PokerParsingTest-20110317-C4Z2Q2"
]



Test[
	parseHandsInit[];First/@parseHand["KRo"]
	,
	{King,random[]}
	,
	TestID->"PokerParsingTest-20110317-J8B3K2"
]

Test[
	parseHandsInit[];parseHand["KRo"][[2]]
	,
	card[random[],offsuit[]]
	,
	TestID->"PokerParsingTest-20110317-K9P6S3"
]

Test[
	MatchQ[parseHandsInit[];parseHand["KRo"][[1]],card[King,Spades|Hearts|Clubs|Diamonds]]
	,
	True
	,
	TestID->"PokerParsingTest-20110317-P3M8T7"
]


 Test[
	parseHandsInit[];parseHand["8d2s"]
	,
	Evaluate[{card[8,Diamonds],card[2,Spades]}]
	,
	TestID->"PokerParsingTest-20110318-H9D3P0"
]

Test[
	parseHandsInit[];parseHand["Rd2s"]
	,
	Evaluate[{card[random[],Diamonds],card[2,Spades]}]
	,
	TestID->"PokerParsingTest-20110318-T5G6X5"
]

Test[
	parseHandsInit[];parseHand["8r2s"]
	,
	Evaluate[{card[8,random[]],card[2,Spades]}]
	,
	TestID->"PokerParsingTest-20110318-A9A6U9"
]

Test[
	parseHandsInit[];parseHand["8dRs"]
	,
	Evaluate[{card[8,Diamonds],card[random[],Spades]}]
	,
	TestID->"PokerParsingTest-20110318-X5F8Y1"
]

Test[
	parseHandsInit[];parseHand["8d2r"]
	,
	Evaluate[{card[8,Diamonds],card[2,random[]]}]
	,
	TestID->"PokerParsingTest-20110318-A5M0C3"
]

Test[
	parseHandsInit[];parseHand["Rd2r"]
	,
	Evaluate[{card[random[],Diamonds],card[2,random[]]}]
	,
	TestID->"PokerParsingTest-20110318-P3D2G3"
]

AceConnector = (parseHandsInit[];parseHand["AC"]) ;
Test[
	AceConnector[[1,1]]
	,
	Ace
	,
	TestID->"PokerParsingTest-20110318-E2L4K7"
]

Test[
	AceConnector[[2,1]]
	,
	connector[]
	,
	TestID->"PokerParsingTest-20110318-P3D2G4"
]



Test[
	TexasHoldem`Parsing`Private`parseList["AJ"]
	,
	Evaluate[card[{Ace, Jack}, random[]]]
	,
	TestID->"PokerParsingTest-20110318-W8S0M5"
]

Test[
	TexasHoldem`Parsing`Private`parseList["AJ","cs"]
	,
	Evaluate[card[{Ace, Jack},{Clubs,Spades}]]
	,
	TestID->"PokerParsingTest-20110318-H9W9I3"
]

Test[
	TexasHoldem`Parsing`Private`parseList["AJ","c"]
	,
	Evaluate[card[{Ace, Jack}, Clubs]]
	,
	TestID->"PokerParsingTest-20110318-M2P9A1"
]
		


Test[
	StringMatchQ["{AJ3}{K9}",RegularExpression["^{([AKQJT2-9]+)}{([AKQJT2-9]+)}([os]?)$"]]
	,
	True
	,
	TestID->"PokerParsingTest-20110318-O3U5A7"
]

Test[
	TexasHoldem`Parsing`Private`parseListOrRange["{AJ3}{K9}"]
	,
	Evaluate[{card[{Ace, Jack, 3}, random[]], card[{King, 9}, random[]]}]
	,
	TestID->"PokerParsingTest-20110318-Y2A2F2"
]	

Test[
	StringMatchQ["{AJ3}c{K9}",RegularExpression["^{([AKQJT2-9]+)}([csdh]){([AKQJT2-9]+)}$"]]
	,
	True
	,
	TestID->"PokerParsingTest-20110318-D5J3I2"
]
		
Test[
	TexasHoldem`Parsing`Private`parseListOrRange["{AJ3}c{K9}"]
	,
	Evaluate[{card[{Ace, Jack, 3}, Clubs], card[{King, 9}, random[]]}]
	,
	TestID->"PokerParsingTest-20110318-Y2A2F3"
]

Test[
	StringMatchQ["{AJ3}c{K9}s",RegularExpression["^{([AKQJT2-9]+)}([csdh]){([AKQJT2-9]+)}([csdh])$"]]
	,
	True
	,
	TestID->"PokerParsingTest-20110318-U2N4B3"
]        

Test[
	TexasHoldem`Parsing`Private`parseListOrRange["{AJ3}c{K9}s"]
	,
	Evaluate[{card[{Ace, Jack, 3}, Clubs], card[{King, 9}, Spades]}]
	,
	TestID->"PokerParsingTest-20110318-Y2A2F4"
]

Test[
	StringMatchQ["{AJ3}{K9}s",RegularExpression["^{([AKQJT2-9]+)}{([AKQJT2-9]+)}([os]?)$"]]
	,
	True
	,
	TestID->"PokerParsingTest-20110318-Z6X7H4"
]

Test[
	TexasHoldem`Parsing`Private`parseListOrRange["{AJ3}{K9}s"]
	,
	Evaluate[{card[{Ace, Jack, 3}, random[]], card[{King, 9}, suited[]]}]
	,
	TestID->"PokerParsingTest-20110318-J2F0U6"
]

Test[
	StringMatchQ["{AJ3}{K9}o",RegularExpression["^{([AKQJT2-9]+)}{([AKQJT2-9]+)}([os]?)$"]]
	,
	True
	,
	TestID->"PokerParsingTest-20110318-A5N4H7"
]
Test[
	TexasHoldem`Parsing`Private`parseListOrRange["{AJ3}{K9}o"]
	,
	Evaluate[{card[{Ace, Jack, 3}, random[]], card[{King, 9}, offsuit[]]}]
	,
	TestID->"PokerParsingTest-20110318-W2W5R4"
]

Test[
	StringMatchQ["{AJ3}K",RegularExpression["^{([AKQJT2-9]+)}([RCAKQJT2-9])([os])?$"]] 
	,
	True
	,
	TestID->"PokerParsingTest-20110318-Y2C5F5"
]

Test[
	TexasHoldem`Parsing`Private`parseListOrRange["{AJ3}K"]
	,
	Evaluate[{card[{Ace, Jack, 3}, random[]], card[King, random[]]}]
	,
	TestID->"PokerParsingTest-20110318-H4S5M6"
]

Test[
	StringMatchQ["{AJ3}Ks",RegularExpression["^{([AKQJT2-9]+)}([RCAKQJT2-9])([os])?$"]] 
	,
	True
	,
	TestID->"PokerParsingTest-20110318-W4V4H4"
]

Test[
	TexasHoldem`Parsing`Private`parseListOrRange["{AJ3}Ks"]
	,
	Evaluate[{card[{Ace, Jack, 3}, random[]], card[King, suited[]]}]
	,
	TestID->"PokerParsingTest-20110318-M1G8P2"
]

Test[
	StringMatchQ["{AJ3}Ko",RegularExpression["^{([AKQJT2-9]+)}([RCAKQJT2-9])([os])?$"]] 
	,
	True
	,
	TestID->"PokerParsingTest-20110318-R9K0U1"
]

Test[
	TexasHoldem`Parsing`Private`parseListOrRange["{AJ3}Ko"]
	,
	Evaluate[{card[{Ace, Jack, 3}, random[]], card[King, offsuit[]]}]
	,
	TestID->"PokerParsingTest-20110318-N3I1F6"
]


Test[
	StringMatchQ["{AJ3}C",RegularExpression["^{([AKQJT2-9]+)}([RCAKQJT2-9])([os])?$"]]
	,
	True
	,
	TestID->"PokerParsingTest-20110318-T4K3N6"
]

Test[
	TexasHoldem`Parsing`Private`parseListOrRange["{AJ3}C"]
	,
	Evaluate[{card[{Ace, Jack, 3}, random[]], card[connector[], random[]]}]
	,
	TestID->"PokerParsingTest-20110318-N3I1F7"
]

Test[
	StringMatchQ["{AJ3}Cs",RegularExpression["^{([AKQJT2-9]+)}([RCAKQJT2-9])([os])?$"]]
	,
	True
	,
	TestID->"PokerParsingTest-20110318-T6L7Y6"
]
Test[
	TexasHoldem`Parsing`Private`parseListOrRange["{AJ3}Cs"]
	,
	Evaluate[{card[{Ace, Jack, 3}, random[]], card[connector[], suited[]]}]
	,
	TestID->"PokerParsingTest-20110318-N3I1F8"
]

Test[
	StringMatchQ["{AJ3}Co",RegularExpression["^{([AKQJT2-9]+)}([RCAKQJT2-9])([os])?$"]]
	,
	True
	,
	TestID->"PokerParsingTest-20110318-S1H6T6"
]

Test[
	TexasHoldem`Parsing`Private`parseListOrRange["{AJ3}Co"]
	,
	Evaluate[{card[{Ace, Jack, 3}, random[]], card[connector[], offsuit[]]}]
	,
	TestID->"PokerParsingTest-20110318-I1P5M0"
]

		

Test[
	StringMatchQ["{AJ3}9-2",RegularExpression["^{([AKQJT2-9]+)}([AKQJT2-9])-([AKQJT2-9])([os])?$"]]
	,
	True
	,
	TestID->"PokerParsingTest-20110319-Y0D6X8"
]

Test[
	TexasHoldem`Parsing`Private`parseListOrRange["{AJ3}9-2"]
	,
	Evaluate[{card[{Ace, Jack, 3}, random[]], card[{9,8,7,6,5,4,3,2}, random[]]}]
	,
	TestID->"PokerParsingTest-20110318-E8X9J3"
]

Test[
	TexasHoldem`Parsing`Private`parseListOrRange["{AJ3}9-2s"]
	,
	Evaluate[{card[{Ace, Jack, 3}, random[]], card[{9,8,7,6,5,4,3,2}, suited[]]}]
	,
	TestID->"PokerParsingTest-20110318-I1P5M1"
]

Test[
	TexasHoldem`Parsing`Private`parseListOrRange["{AJ3}9-2o"]
	,
	Evaluate[{card[{Ace, Jack, 3}, random[]], card[{9,8,7,6,5,4,3,2}, offsuit[]]}]
	,
	TestID->"PokerParsingTest-20110318-I1P5M2"
]


Test[
	StringMatchQ["{952}{cd}K",RegularExpression["^{([AKQJT2-9]+)}{([csdh]+)}([RCAKQJT2-9])([os]?)$"]]
	,
	True
	,
	TestID->"PokerParsingTest-20110319-F1O7R0"
]

Test[
	TexasHoldem`Parsing`Private`parseListOrRange["{952}{cd}K"]
	,
	Evaluate[{card[{9, 5, 2}, {Clubs,Diamonds}], card[King, random[]]}]
	,
	TestID->"PokerParsingTest-20110319-Q7B6O2"
]
  
 Test[
	TexasHoldem`Parsing`Private`parseListOrRange["{952}{cd}Ks"]
	,
	Evaluate[{card[{9, 5, 2}, {Clubs,Diamonds}], card[King, suited[]]}]
	,
	TestID->"PokerParsingTest-20110319-G1C4O9"
]     

Test[
	TexasHoldem`Parsing`Private`parseListOrRange["{952}{cd}Ko"]
	,
	Evaluate[{card[{9, 5, 2}, {Clubs,Diamonds}], card[King, offsuit[]]}]
	,
	TestID->"PokerParsingTest-20110319-L5I4S0"
] 
   
Test[
	StringMatchQ["{952}{cd}{KQ}s",RegularExpression["^{([AKQJT2-9]+)}{([csdh]+)}{([AKQJT2-9]+)}([os]?)$"]]
	,
	True
	,
	TestID->"PokerParsingTest-20110319-U6G2H5"
]

Test[
	TexasHoldem`Parsing`Private`parseListOrRange["{952}{cd}{KQ}s"]
	,
	Evaluate[{card[{9, 5, 2}, {Clubs,Diamonds}], card[{King,Queen}, suited[]]}]
	,
	TestID->"PokerParsingTest-20110319-L5I4S1"
]    
        
Test[
	StringMatchQ["{952}{cd}A-Jo",RegularExpression["^{([AKQJT2-9]+)}{([csdh]+)}([AKQJT2-9])-([AKQJT2-9])([os])?$"]]
	,
	True
	,
	TestID->"PokerParsingTest-20110319-G3N9A4"
]
		 
Test[
	TexasHoldem`Parsing`Private`parseListOrRange["{952}{cd}A-Jo"]
	,
	Evaluate[{card[{9, 5, 2}, {Clubs,Diamonds}], card[{Ace, King,Queen,Jack }, offsuit[]]}]
	,
	TestID->"PokerParsingTest-20110319-P4K8T4"
]  

Test[
	StringMatchQ["{952}cQh",RegularExpression["^{([AKQJT2-9]+)}([csdh])([RCAKQJT2-9])([csdh])$"]]
	,
	True
	,
	TestID->"PokerParsingTest-20110319-U1C7D8"
]

Test[
	TexasHoldem`Parsing`Private`parseListOrRange["{952}cQh"]
	,
	Evaluate[{card[{9, 5, 2}, Clubs], card[Queen, Hearts]}]
	,
	TestID->"PokerParsingTest-20110319-M9S8Z0"
]

Test[                             
	StringMatchQ["{952}c{Q3}{hs}",RegularExpression["^{([AKQJT2-9]+)}([csdh]){([AKQJT2-9]+)}{([csdh]+)}$"]]
	,
	True
	,
	TestID->"PokerParsingTest-20110319-U6G2H6"
]

Test[
	TexasHoldem`Parsing`Private`parseListOrRange["{952}c{Q3}{hs}"]
	,
	Evaluate[{card[{9, 5, 2}, Clubs], card[{Queen,3}, {Hearts,Spades}]}]
	,
	TestID->"PokerParsingTest-20110319-W8A2F4"
]	 

Test[                           
	StringMatchQ["{952}2-4{hs}",RegularExpression["^{([AKQJT2-9]+)}([AKQJT2-9])-([AKQJT2-9]){([csdh]+)}$"]]
	,
	True
	,
	TestID->"PokerParsingTest-20110319-X2B0P2"
]

Test[
	TexasHoldem`Parsing`Private`parseListOrRange["{952}2-4{hs}"]
	,
	Evaluate[{card[{9, 5, 2}, random[]], card[{2,3,4}, {Hearts,Spades}]}]
	,
	TestID->"PokerParsingTest-20110319-N8W7L2"
]	

Test[                           
	StringMatchQ["{952}{dhs}2-4{hs}",RegularExpression["^{([AKQJT2-9]+)}{([csdh]+)}([AKQJT2-9])-([AKQJT2-9]){([csdh]+)}$"]]
	,
	True
	,
	TestID->"PokerParsingTest-20110319-D2I0N7"
]
		 
Test[
	TexasHoldem`Parsing`Private`parseListOrRange["{975}{dhs}2-4{hs}"]
	,
	Evaluate[{card[{9, 7, 5}, {Diamonds,Hearts,Spades}], card[{2,3,4}, {Hearts,Spades}]}]
	,
	TestID->"PokerParsingTest-20110319-B5N7D2"
]
		 
Test[                           
	StringMatchQ["A-Q{T7}o",RegularExpression["^([AKQJT2-9])-([AKQJT2-9]){([AKQJT2-9]+)}([os])?$"]]
	,
	True
	,
	TestID->"PokerParsingTest-20110319-H3X0R4"
]

Test[
	TexasHoldem`Parsing`Private`parseListOrRange["A-Q{T7}o"]
	,
	Evaluate[{card[{Ace, King, Queen}, random[]], card[{10,7}, offsuit[]]}]
	,
	TestID->"PokerParsingTest-20110319-B5N7D3"
]		 

Test[                           
	StringMatchQ["A-Q{T7}{sh}",RegularExpression["^([AKQJT2-9])-([AKQJT2-9]){([AKQJT2-9]+)}{([csdh]+)}([os])?$"]]
	,
	True
	,
	TestID->"PokerParsingTest-20110319-O3T7V5"
]		 

Test[
	TexasHoldem`Parsing`Private`parseListOrRange["A-Q{T7}{sh}"]
	,
	Evaluate[{card[{Ace, King, Queen}, random[]], card[{10,7}, {Spades,Hearts}]}]
	,
	TestID->"PokerParsingTest-20110320-N1M6F4"
]

Test[                           
	StringMatchQ["A-Q{ds}{T7}",RegularExpression["^([AKQJT2-9])-([AKQJT2-9]){([csdh]+)}{([AKQJT2-9]+)}$"]]
	,
	True
	,
	TestID->"PokerParsingTest-20110320-V6U1D3"
]
		 
Test[
	TexasHoldem`Parsing`Private`parseListOrRange["A-Q{ds}{T7}"]
	,
	Evaluate[{card[{Ace, King, Queen}, {Diamonds,Spades}], card[{10,7}, random[]]}]
	,
	TestID->"PokerParsingTest-20110320-B3B6F3"
]
		 
Test[                           
	StringMatchQ["A-Q{ds}{T7}d",RegularExpression["^([AKQJT2-9])-([AKQJT2-9]){([csdh]+)}{([AKQJT2-9]+)}([csdh])$"]]
	,
	True
	,
	TestID->"PokerParsingTest-20110320-K3X0R9"
]

Test[
	TexasHoldem`Parsing`Private`parseListOrRange["A-Q{ds}{T7}d"]
	,
	Evaluate[{card[{Ace, King, Queen}, {Diamonds,Spades}], card[{10,7}, Diamonds]}]
	,
	TestID->"PokerParsingTest-20110320-J9J2R2"
]
Test[                           
	StringMatchQ["A-Q{ds}{T7}{ds}",RegularExpression["^([AKQJT2-9])-([AKQJT2-9]){([csdh]+)}{([AKQJT2-9]+)}{([csdh]+)}$"]]
	,
	True
	,
	TestID->"PokerParsingTest-20110320-G5J2S0"
]

Test[
	TexasHoldem`Parsing`Private`parseListOrRange["A-Q{ds}{T7}{ds}"]
	,
	Evaluate[{card[{Ace, King, Queen}, {Diamonds,Spades}], card[{10,7}, {Diamonds,Spades}]}]
	,
	TestID->"PokerParsingTest-20110320-F6K6Y7"
]	 

Test[                           
	StringMatchQ["A{T7}o",RegularExpression["^([RAKQJT2-9]){([AKQJT2-9]+)}([os])?$"]]
	,
	True
	,
	TestID->"PokerParsingTest-20110320-R1K3K9"
]

Test[
	TexasHoldem`Parsing`Private`parseListOrRange["A{T7}o"]
	,
	Evaluate[{card[Ace, random[]], card[{10,7}, offsuit[]]}]
	,
	TestID->"PokerParsingTest-20110320-F6K6Y8"
]

Test[                           
	StringMatchQ["A{T7}{dh}",RegularExpression["^([RAKQJT2-9]){([AKQJT2-9]+)}{([csdh]+)}$"]]
	,
	True
	,
	TestID->"PokerParsingTest-20110320-N8A6E7"
]
		
Test[
	TexasHoldem`Parsing`Private`parseListOrRange["A{T7}{dh}"]
	,
	Evaluate[{card[Ace, random[]], card[{10,7},{Diamonds,Hearts}]}]
	,
	TestID->"PokerParsingTest-20110320-P4Y9E6"
]
		
Test[                           
	StringMatchQ["As{T7}o",RegularExpression["^([RAKQJT2-9])([csdh]){([AKQJT2-9]+)}([os]?)$"]]
	,
	True
	,
	TestID->"PokerParsingTest-20110320-I1D9K5"
]
		
Test[
	TexasHoldem`Parsing`Private`parseListOrRange["As{T7}o"]
	,
	Evaluate[{card[Ace, Spades], card[{10,7},offsuit[]]}]
	,
	TestID->"PokerParsingTest-20110320-G0E3Z9"
]

Test[                           
	StringMatchQ["As{T7}{hd}",RegularExpression["^([RAKQJT2-9])([csdh]){([AKQJT2-9]+)}{([csdh]+)}$"]]
	,
	True
	,
	TestID->"PokerParsingTest-20110320-H5J6I2"
]		 
		 
Test[
	TexasHoldem`Parsing`Private`parseListOrRange["As{T7}{hd}"]
	,
	Evaluate[{card[Ace, Spades], card[{10,7},{Hearts,Diamonds}]}]
	,
	TestID->"PokerParsingTest-20110320-V9E0F1"
]		
		
		