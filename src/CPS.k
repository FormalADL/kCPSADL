require "NetComponentAccess.k"


module CPS

  imports NETCOMPONENTACCESS-SYNTAX

	syntax Mtype ::= "type"
	syntax Msensor ::= "sensor"
	syntax Mactuator ::= "actuator"
	syntax Mnet ::= "net"
	syntax Mcontext ::= "context"
	syntax Mcontrolled ::= "controlled"
	syntax Mcomentity ::= "comentity"
	syntax Mphyentity ::= "phyentity"
	syntax Meffort ::= "effort"
	syntax Mmonitor ::= "monitor"
	syntax Mnet ::= "net"
	syntax Mstate ::= "state"
	syntax Mvariables ::= "variables"
	syntax Mstates ::= "states"
	syntax Minitially ::= "initially"
	syntax Mmode ::= "mode"
	syntax Mtranstitions ::= "transtitions"
	syntax Mif ::= "if"
	syntax Melse ::= "else"
	syntax Melseif ::= "elseif"
	syntax Mfor ::= "for"
	syntax Mwhen ::= "when"
	syntax Melsewhen ::= "elsewhen"	
	syntax Mfunction ::= "function"
	syntax Minitial ::= "initial"
	syntax Mcomplete ::= "complete"
	syntax Mreturn ::= "return"
	syntax Murgent ::= "urgent"
	syntax Mcomposite ::= "composite"
	syntax Mexit ::= "exit"
	syntax Mon ::= "on"
	syntax Mexists ::= "exists"
	syntax Mcomputation ::= "computation"
	syntax Mdelay ::= "delay"
	syntax Mdiscrete ::= "discrete"
	syntax Mcontinuous ::= "continuous"
	syntax Mhybrid ::= "hybrid"
	syntax Mhistory ::= "history"
	syntax MPlus ::= "+"
	syntax MBrace ::= "*"
	syntax MMinus ::= "-"
	syntax MEqual ::= "="
	syntax MDoubleEqual ::= "=="
	syntax MLessThanEqual ::= "<="
	syntax MGreaterThanEqual ::= ">="
	syntax MNotEqual ::= "<>"
	syntax MLessThan ::= "<"
	syntax MGreaterThan ::= ">"
	syntax MAdd ::= "+"
	syntax MSub ::= "-"
	syntax MMul ::= "*"
	syntax MDiv ::= "/"
	syntax MPointAdd ::= ".+"
	syntax MPointSub ::= ".-"
	syntax MPointMul ::= ".*"
	syntax MPointDiv ::= "./"
	syntax MExp ::= "^"
	syntax MPointExp ::= ".^"
        syntax MDArrows ::= "-->"
        syntax MSigh ::= "!"
        syntax MQuestion ::= "?"  	

  syntax CmpCategory ::=  CmpCategoryType CPSNewCmpCategory

  syntax CmpCategoryType ::= Mdiscrete | Mcontinuous | Mhybrid

  syntax CPSNewCmpCategory ::= InteEntityCmpCategory
                             | ComEntityCmpCategory
                             | PhyEntityCmpCategory

  
  syntax ComEntityCmpCategory ::= SoftwareCategory
                                | ExecPlateformCategory	
  
  syntax InteEntityCmpCategory ::= Msensor | Mactuator | Mnet
  syntax PhyEntityCmpCategory ::= Mcontext | Mcontrolled
  
  syntax SubCmpAccessSpec ::= NetAccessSpec
  syntax SubCmpAccessRefinement ::= NetAccessRefinement

endmodule
