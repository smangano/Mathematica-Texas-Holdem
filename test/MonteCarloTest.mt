Needs["TexasHoldem`"]
Needs["TexasHoldem`MonteCarlo`"]

Test[
	simulate[{{card[14, "\[ClubSuit]"], 
   card[14, "\[SpadeSuit]"]}, {card[13, "\[SpadeSuit]"], 
   card[13, "\[HeartSuit]"]}}, {card[random[]], card[random[]], 
  card[random[]]}, card[random[]], card[random[]], 10]
	,
	{80,20}
	,
	TestID->"MonteCarloTest-20110326-S0Q0N6"
]

  
Test[
	TexasHoldem`MonteCarlo`Private`randomToRealOriginal[{{card[Ace,Hearts],card[King,Diamonds]},{card[Queen,Hearts],card[10,Diamonds]}},
		{card[9,Clubs],card[7,Hearts],card[6,Hearts]},card[6,Spades],card[2,Clubs]] 
	,
	Evaluate[{{{card[Ace,Hearts],card[King,Diamonds]}, {card[Queen,Hearts],card[10,Diamonds]}},
		{card[9,Clubs],card[7,Hearts],card[6,Hearts]},card[6,Spades],card[2,Clubs]}]
	,
	TestID->"MonteCarloTest-20110311-F4F3O8"
]

testIn2 = {{{card[Ace,Hearts],card[King,Diamonds]},{card[Queen,Hearts],card[10,Diamonds]}},
		{card[random[]],card[7,Hearts],card[6,Hearts]},
		card[6,Spades],
		card[2,Clubs]} ;
testOut2 = TexasHoldem`MonteCarlo`Private`randomToRealOriginal@@testIn2 ;
Test[
	Drop[testOut2,{2}]
	,
	Evaluate[Drop[testIn2,{2}]]
	,
	TestID->"MonteCarloTest-20110311-F4F3O9"
]

Test[
	Drop[testOut2[[2]],1]
	,
	Evaluate[Drop[testIn2[[2]],1]]
	,
	TestID->"MonteCarloTest-20110311-X3F0H6"
]

testIn3 = {{{card[Ace,Hearts],card[King,Diamonds]},{card[Queen,Hearts],card[10,Diamonds]}},
		{card[random[],Hearts],card[7,Hearts],card[6,Hearts]},
		card[6,Spades],
		card[2,Clubs]} ;
testOut3 = TexasHoldem`MonteCarlo`Private`randomToRealOriginal@@testIn3 ;
Test[
	Drop[testOut3,{2}]
	,
	Evaluate[Drop[testIn3,{2}]]
	,
	TestID->"MonteCarloTest-20110311-U8Y7Z7"
]

Test[
	Drop[testOut3[[2]],1]
	,
	Evaluate[Drop[testIn3[[2]],1]]
	,
	TestID->"MonteCarloTest-20110311-W0M9X0"
]

Test[
	testOut3[[2,1,2]]
	,
	Evaluate[Hearts]
	,
	TestID->"MonteCarloTest-20110311-Q3Z3J0"
]

testIn4 = {{{card[Ace,Hearts],card[King,Diamonds]},{card[Queen,Hearts],card[10,Diamonds]}},
		{card[8,random[]],card[7,Hearts],card[6,Hearts]},
		card[6,Spades],
		card[2,Clubs]} ;
testOut4 = TexasHoldem`MonteCarlo`Private`randomToRealOriginal@@testIn4 ;
Test[
	Drop[testOut4,{2}]
	,
	Evaluate[Drop[testIn4,{2}]]
	,
	TestID->"MonteCarloTest-20110311-J7L6N3"
]

Test[
	Drop[testOut4[[2]],1]
	,
	Evaluate[Drop[testIn4[[2]],1]]
	,
	TestID->"MonteCarloTest-20110311-L5G0W2"
]

Test[
	testOut4[[2,1,1]]
	,
	8
	,
	TestID->"MonteCarloTest-20110311-I2F8Q5"
]

SeedRandom[18];
testIn5 = {{{card[Ace,Hearts],card[King,Diamonds]},{card[Queen,Hearts],card[10,Diamonds]}},
		{card[8,Spades[]],card[7,Hearts],card[6,Hearts]},
		card[random[]],
		card[random[]]} ;
testOut5 = TexasHoldem`MonteCarlo`Private`randomToRealOriginal@@testIn5 ;
Test[
	Drop[testOut5,-2]
	,
	Evaluate[Drop[testIn5,-2]]
	,
	TestID->"MonteCarloTest-20110312-X0R4V5"
]
Test[
	Take[testOut5,-2]
	,
	Evaluate[{card[8, Diamonds], card[5, Clubs]}]
	,
	TestID->"MonteCarloTest-20110312-J6Q0R1"
]


{cardPatterns, fixedCards, deck} = 
     TexasHoldem`MonteCarlo`Private`randomToRealPreproc[{{card[random[]],card[suited[]]},{card[random[]],card[offsuit[]]}}, 
	                                                   {card[2,Clubs],card[3,Clubs],card[4,Clubs]},
	                                                    card[random[]], card[random[]]];

Test[
	Length[deck]
	,
	49
	,
	TestID->"MonteCarloTest-20110313-R0Z4V8"
]

Test[
	Intersection[deck,fixedCards]
	,
	{}
	,
	TestID->"MonteCarloTest-20110313-P8D4S9"
]

Test[
	cardPatterns[[1]] === card[_,_]
	,
	True
	,
	TestID->"MonteCarloTest-20110313-I3Z4P8"
]

Test[
	cardPatterns[[2]] === card[_,TexasHoldem`MonteCarlo`Private`$LastSuit]
	,
	True
	,
	TestID->"MonteCarloTest-20110313-K7C0W0"
]

Test[
	cardPatterns[[4]] === card[_,Except[TexasHoldem`MonteCarlo`Private`$LastSuit]]
	,
	True
	,
	TestID->"MonteCarloTest-20110313-W6A3B5"
]


{cardPatterns, fixedCards, deck} = 
     TexasHoldem`MonteCarlo`Private`randomToRealPreproc[{{card[random[]],card[connector[]]},{card[random[]],card[connector[],suited[]]}}, 
	                                                   {card[2,Clubs],card[3,Clubs],card[4,Diamonds]},
	                                                    card[10, random[]], card[7,Clubs]];
	   
Test[
	Length[deck]
	,
	48
	,
	TestID->"MonteCarloTest-20110313-T3N2T4"
]

Test[
	Intersection[deck,fixedCards]
	,
	{}
	,
	TestID->"MonteCarloTest-20110313-E3S6R5"
]

Test[
	cardPatterns[[1]] === card[_,_]
	,
	True
	,
	TestID->"MonteCarloTest-20110313-H7A6S4"
]

Test[
	cardPatterns[[2]]
	,
	card[TexasHoldem`MonteCarlo`Private`connectorNorm[1+TexasHoldem`MonteCarlo`Private`$LastRank]|TexasHoldem`MonteCarlo`Private`connectorNorm[-1+TexasHoldem`MonteCarlo`Private`$LastRank],_]
	,
	TestID->"MonteCarloTest-20110313-U2X2C3"
]

Test[
	cardPatterns[[4]]
	,
	card[TexasHoldem`MonteCarlo`Private`connectorNorm[1+TexasHoldem`MonteCarlo`Private`$LastRank]|TexasHoldem`MonteCarlo`Private`connectorNorm[-1+TexasHoldem`MonteCarlo`Private`$LastRank],TexasHoldem`MonteCarlo`Private`$LastSuit]
	,
	TestID->"MonteCarloTest-20110313-X9D5K1"
]
	  
SeedRandom[33]	                                                    
{hands,flop,turn,river} = simulationSample[{{card[random[]],card[connector[]]},{card[random[]],card[connector[],suited[]]}}, 
	                                                   {card[2,Clubs],card[3,Clubs],card[4,Diamonds]},
	                                                    card[10, random[]], card[7,Clubs]] ;
Test[
	Abs[hands[[1,1,1]] - hands[[1,2,1]]]
	,
	1
	,
	TestID->"MonteCarloTest-20110313-M6O7X3"
]	                                                    

Test[
	Abs[hands[[2,1,1]] - hands[[2,2,1]]]
	,
	1
	,
	TestID->"MonteCarloTest-20110313-M6O7X4"
]	  
	
Test[
	hands[[2,1,2]] === hands[[2,2,2]]
	,
	True
	,
	TestID->"MonteCarloTest-20110313-C2A4P7"
]	 
    
SeedRandom[35]	                                                    
{hands,flop,turn,river} = simulationSample[{{card[{Ace,King,Queen}],card[connector[]]},{card[Range[2,8]],card[connector[],suited[]]}}, 
	                                                   {card[2,Clubs],card[3,Clubs],card[4,Diamonds]},
	                                                    card[10, random[]], card[7,Clubs]] ;

Test[
	Queen <= hands[[1,1,1]] <= Ace
	,
	True
	,
	TestID->"MonteCarloTest-20110313-B6F3C4"
]	
	                                                        
Test[
	Abs[hands[[1,1,1]] - hands[[1,2,1]]]
	,
	1
	,
	TestID->"MonteCarloTest-20110313-W3L3H3"
]	                                                    

Test[
	2<= hands[[2,1,1]] <= 8
	,
	True
	,
	TestID->"MonteCarloTest-20110313-E4N2E0"
]	 

Test[
	Abs[hands[[2,1,1]] - hands[[2,2,1]]]
	,
	1
	,
	TestID->"MonteCarloTest-20110313-E4N2E0"
]	  
	
Test[
	hands[[2,1,2]] === hands[[2,2,2]]
	,
	True
	,
	TestID->"MonteCarloTest-20110313-L4L1I7"
]	 


SeedRandom[1]	                                                    
{winAAPct, winAKsPct} = simulate[{{card[Ace,Diamonds],card[Ace,Spades]},{card[Ace,Clubs],card[King,Clubs]}}, 100];

Test[
	winAAPct > winAKsPct
	,
	True
	,
	TestID->"MonteCarloTest-20110312-J5W1M2"
]

Test[
	80.0 < winAAPct < 95.0
	,
	True
	,
	TestID->"MonteCarloTest-20110312-B6T3D9"
]


	                                                    
(*AA vs AKs - first flop cards K*)
SeedRandom[17]
{winAAPct, winAKsPct} = simulate[{{card[Ace,Diamonds],card[Ace,Spades]},{card[Ace,Clubs],card[King,Clubs]}},
	{card[King,Hearts]}
	, 100];
Test[
	Round[{winAAPct, winAKsPct}]
	,
	{82,18}
	,
	TestID->"MonteCarloTest-20110312-G0M5M8"
]	

(*AA vs AKs - first 2 flop cards K*)
SeedRandom[19]
{winAAPct, winAKsPct} = simulate[{{card[Ace,Diamonds],card[Ace,Spades]},{card[Ace,Clubs],card[King,Clubs]}},
	{card[King,Hearts],card[King,Diamonds]}
	, 100];
Test[
	Round[{winAAPct, winAKsPct}]
	,
	{9,91}
	,
	TestID->"MonteCarloTest-20110312-X0I1Y8"
]	

(*AA vs AKs - first 2 flop cards match AK suit*)
SeedRandom[21]
{winAAPct, winAKsPct} = simulate[{{card[Ace,Diamonds],card[Ace,Spades]},{card[Ace,Clubs],card[King,Clubs]}},
	{card[2,Clubs],card[3,Clubs]}
	, 100];
Test[
	Round[{winAAPct, winAKsPct}]
	,
	{52,48}
	,
	TestID->"MonteCarloTest-20110312-C0P8U9"
]	

(*
SeedRandom[21]
{winAAPct, winAKsPct} = simulate[{{card[Ace,Diamonds],card[Ace,Spades]},{card[Ace,Clubs],card[King,Clubs]}},
	{card[2,Clubs],card[3,Clubs]}
	, 10000]
Print[{winAAPct, winAKsPct}]


SeedRandom[99]
{winSCPct, win22Pct} = simulate[{{card[random[]],card[connector[],suited[]]},{card[2,random[]],card[2,random[]]}}, 100]
Print[{winSCPct, win22Pct}]

*)
SeedRandom[99]
{winA6Pct, winAKsPct} = simulate[{{card[Ace,Hearts],card[6,Hearts]},{card[Ace,Diamonds],card[King,Diamonds]}},{card[6,Diamonds],card[10,Clubs],card[Ace,Spades]}, 1000]
Print[{winA6Pct, winAKsPct}]
SeedRandom[91]
{winA6Pct, winAKsPct} = simulate[{{card[Ace,Hearts],card[6,Hearts]},{card[Ace,Diamonds],card[King,Diamonds]}},{card[6,Diamonds],card[10,Clubs],card[Ace,Spades]}, 1000]
Print[{winA6Pct, winAKsPct}]



