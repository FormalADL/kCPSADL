module FEATURECONNECTION-SYNTAX

syntax FetConnection ::= Mfeature FetRef ConnectionSymbol FetRef 
//syntax SrcFetRef ::= FetRef 
//syntax DestFetRef ::= FetRef 
syntax ConnectionSymbol ::= DirecConnectSymb 
			| BidirectConnectSymb 
syntax DirecConnectSymb ::= MArrows 
syntax BidirectConnectSymb ::= MDoubleArrows 
syntax FetRef ::= Id 
			| Id MPoint Id 
syntax FetConnectionRefinement ::= Mfeature 
endmodule
