(*Mathematica Code for Texas Hold'em Monte Calos Simulations*)
(* Copyright 2011 Sal Mangano. All rights reserved *)

BeginPackage["TexasHoldem`MonteCarlo`"]
ClearAll["TexasHoldem`MonteCarlo`*"]

Needs["TexasHoldem`"];
simulate::usage = "run a monte carlo simulation" ;
simulationSample::usage = "return the actual cards given an input that uses random[], suited[], etc." ; 

Begin["`Private`"]
$LastSuit = Null;
$LastRank = Null ;
simulate[hands:{{_card,_card}..}, n_Integer] := 
Module[{hands2},
(*A single hand is specified it will play a random hand heads up *)
hands2= If[Length[hands] < 2, Append[hands,{card[random[]], card[random[]]}],hands];
simulate2[hands2,{card[random[]],card[random[]],card[random[]]},card[random[]],card[random[]],n]
]

simulate[hands:{{_card,_card}..}, flop:{Repeated[_card,{1,3}]}, n_Integer] :=
Module[{hands2, flop2},
(*A single hand is specified it will play a random hand heads up *)
hands2= If [Length[hands] < 2, Append[hands,{card[random[]], card[random[]]}],hands];
flop2 = If[Length[flop] < 3, Join[flop,Table[card[random[]],{3-Length[flop]}]],flop];
simulate2[hands2,flop2,card[random[]],card[random[]],n]
]

simulate[hands:{{_card,_card}..}, flop:{Repeated[_card,{1,3}]}, turn_card, n_Integer] :=
Module[{hands2, flop2},
(*A single hand is specified it will play a random hand heads up *)
hands2= If [Length[hands] < 2, Append[hands,{card[random[]], card[random[]]}],hands];
flop2 = If[Length[flop] < 3, Join[flop,Table[card[random[]],{3-Length[flop]}]],flop];
simulate2[hands2,flop2,turn,card[random[]],n]
]

simulate[hands:{{_card,_card}..}, flop:{Repeated[_card,{1,3}]}, turn_card, river_card, n_Integer] :=
Module[{hands2, flop2},
(*A single hand is specified it will play a random hand heads up *)
hands2= If [Length[hands] < 2, Append[hands,{card[random[]], card[random[]]}],hands];
flop2 = If[Length[flop] < 3, Join[flop,Table[card[random[]],{3-Length[flop]}]],flop];
simulate2[hands2,flop2,turn,river,n]
]

simulate2[hands_, flop_, turn_, river_, n_] := 
Module[{winners,hands2, flop2, turn2, river2,g,w,preProc },
	winners = Table[0,{Length[hands]}];
	preProc = randomToRealPreproc[hands,flop,turn,river] ;
	Do[
		{hands2, flop2, turn2, river2} = randomToReal[hands,preProc] ;
		g = Game[Hands[hands2],Flop[flop2],Turn[{turn2}],River[{river2}]];
		w = winnerPos[g] ;
		winners[[w]]+= 1
		,
		{n}];
	100.00 * N[winners/Total[winners],MachinePrecision]
]

simulationSample[hands_, flop_, turn_, river_] := 
Module[{},
	randomToReal[hands,randomToRealPreproc[hands,flop,turn,river]] 
]

connectorNorm[1] := Ace
connectorNorm[15] := 2
connectorNorm[r_Integer] := r

randomToRealPreproc[hands_, flop_, turn_, river_] :=
	Module[{all,fixed,deck},
	Clear[$LastRank,$LastSuit];
	all = Flatten[{hands, flop, turn, river}];
	fixed = DeleteCases[all, 
		card[___,__random,___]|card[___,__suited,___]|card[___,__offsuit,___]|
			card[___,__connector,___]|card[___,__pair,___]];
	
	all = all //. 
		{
		 card[ranks_List] :> card[Alternatives@@ranks,_],
		 card[ranks_List,random[]] :> card[Alternatives@@ranks,_],
		 card[ranks_List,suits_List] :> card[Alternatives@@ranks,Alternatives@@suits],
		 card[ranks_List,suited[]] :> card[Alternatives@@ranks,$LastSuit],
		 card[ranks_List,offsuit[]] :> card[Alternatives@@ranks,Except[$LastSuit]],
		 card[ranks_List,x_] :> card[Alternatives@@ranks,x],
		 card[connector[],suited[]] :> card[Alternatives[connectorNorm[$LastRank+1],connectorNorm[$LastRank-1]],$LastSuit], 
		 card[connector[],offsuit[]] :> card[Alternatives[connectorNorm[$LastRank+1],connectorNorm[$LastRank-1]],Except[$LastSuit]],
		 card[connector[],random[]] :> card[Alternatives[connectorNorm[$LastRank+1],connectorNorm[$LastRank-1]],_],
		 card[connector[],x_] :> card[Alternatives[connectorNorm[$LastRank+1],connectorNorm[$LastRank-1]],x],
		 card[connector[]] :> card[Alternatives[connectorNorm[$LastRank+1],connectorNorm[$LastRank-1]],_],
		 card[pair[]] :> card[$LastRank,Except[$LastSuit]],
		 card[suited[]] :> card[_,$LastSuit],
		 card[offsuit[]] :> card[_,Except[$LastSuit]],
		 card[random[]] :> card[_,_], 
		 card[random[],suited[]] :> card[_,$LastSuit], 
		 card[random[],offsuit[]] :> card[_,Except[$LastSuit]],
		 card[random[],x_] :> card[_,x],
		 card[y_,random[]] :> card[y,_]
		} ;
	deck = Complement[Deck, fixed] ;
	{all,fixed,deck}
	]
	


randomToReal[hands_, {all_,fixed_,deck_}] := 
Module[{c, temp,pos,real,m,deck2},
	deck2 = shuffle[deck] ;
	real = {};
	Do[
		c = all[[i]];
		c= If[NumericQ[c[[1]]] && suitQ[c[[2]]],c,
		 		pos = Position[deck2,c,{1},1][[1,1]];
		 		temp = deck2[[pos]];
		 		deck2 = Drop[deck2,{pos}];
		 		temp];
		{$LastRank,$LastSuit} = List@@c;
		AppendTo[real,c],
	  {i,Length[all]}];
	m = 2*Length[hands];
	{Partition[Take[real,m],2],Take[real,{m+1,m+3}],real[[m+4]],real[[m+5]]}
]

(*Original algo before optimization that broke out preprocessing *)
randomToRealOriginal[hands_, flop_, turn_, river_] := 
Module[{all,fixed,c, temp,deck,pos,real,m, hands2,flop2,turn2,river2},
	all = Flatten[{hands, flop, turn, river}];
	fixed = DeleteCases[all, card[___,__random,___]];
	all = all //. 
		{
		 card[random[]] :> card[_,_], 
		 card[random[],x_] :> card[_,x],
		 card[y_,random[]] :> card[y,_]
		} ;
	real = {};
	deck = shuffle[Complement[Deck, fixed]] ;
	Do[
		c = all[[i]];
		AppendTo[real,
			If[c[[1]] =!= Blank[] && c[[2]] =!= Blank[],c,
		 		pos = First[Flatten[Position[deck,c]]];
		 		temp = deck[[pos]];
		 		deck = Drop[deck,{pos}];
		 		temp]],
	  {i,Length[all]}];
	m = 2*Length[hands];
	hands2 = Partition[Take[real,m],2] ;
	flop2 = Take[real,{m+1,m+3}];
	turn2 = real[[m+4]] ;
	river2 = real[[m+5]];
	{hands2,flop2,turn2,river2}	
]
End[]
EndPackage[]