require "CPSADL-semantics.k"

module CPSADLBA-SEMANTICS
   imports CPSADL-SEMANTICS
   // behavior
      rule <system>
             ...
             <component><componentid> id |-> Componentid:Id </componentid> <k> annex  Annextid:Id {** Aslc:AnnexSpecLangConstructs **} ; => . ...</k> ...</component>
             ...
        </system>
        (. => <system>
            ...
            <component>
               ...
               <k> Aslc </k>
               <behavior>
                  <states> .Map </states>
			      <statevariables> .Map </statevariables>	
			      <store> .Map </store>
			      <automata>
			      	 <automataid> Componentid </automataid>	
			      	 <automataclock> 0 </automataclock>
				     <states> kpending </states> 
				     <curstate> idles </curstate>	
				     <eventcount> 0 </eventcount> 
				     <processingevent> 0 |-> kclear </processingevent>	
				     <event> .Map </event>
				     <automatatable> .Map </automatatable>
			      </automata>
               </behavior>
               ...
            </component>
            <globalclock> 
				<subclockcount> (Tnum:Int => Tnum +Int 1) |-> 0 kclear|->_ </subclockcount>
				<subclock> ... . => Tnum |-> Comid </subclock> 
				...
			</globalclock>
            ...
        </system>
        )

	rule Aslc1:AnnexSpecLangConstructsElem Aslc2:AnnexSpecLangConstructsElem => Aslc1 ~> Aslc2 [structural] 
	
	rule BType1:Mstate BType2:Mvariables BT:BehaviorVariableDeclList => BT [structural]
	rule BType:Mstate BT:BehaviorStateList => BT [structural]
	rule BType:Minitially BT:EquationList => BT [structural]
	rule BType:Mtranstitions BT:BehaviorStateTransitionList => BT [structural]
	rule BType1:Mmode BType2:Mtranstitions BT:BehaviorStateTransitionList => BT [structural]
	
	rule BTPrev:BehaviorVariableDecl BTNext:BehaviorVariableDecl => PTPrev ~> PTNext [structural]
	rule BTPrev:BehaviorState BTNext:BehaviorState => PTPrev ~> PTNext [structural]
	rule BTPrev:Equations BTNext:Equations => PTPrev ~> PTNext [structural]
	rule BTPrev:BehaviorStateTransition BTNext:BehaviorStateTransition => PTPrev ~> PTNext [structural]
	rule BTPrev:CompositeDecl BTNext:CompositeDecl => PTPrev ~> PTNext [structural]
//----------------------------------------------------------------------------------------------------------------------------------------------------------------
	// behavior state variables
	rule <system>
          ...
            <component> ... <k> BVar:Id : Dt:DataType Df:Datafeature ; => . ...</k>
			   <behavior>
			      ...
			      <statevariables>... .=> BVar|-> Dt </statevariables>
			      <store>... . => BVar|->novalue </store>
			      ...
			   </behavior>
            ...
            </component>
            ...
        </system> 
//---------------------------------------------------------------------------------------------------------------------------------------------------------------- 		
	// behavior state
	rule <system>
          ...
            <component> ... <k> Sid:IdentifierList : Ss:StateKeywordList state ; => . ...</k>
			   <behavior>
			      ...
			      <states>... .=> Sid |-> Ss </states>
			      ...
			   </behavior>
            ...
            </component>
            ...
        </system> 	
//---------------------------------------------------------------------------------------------------------------------------------------------------------------        		
	// behavior initial
	rule <system>
          ...
            <component> ... <k> Variable:SimpleExpression = Value:Expression ; => . ...</k>... </component>
          ...
        </system>
        (. => <system> 
			<component>
			   ... 
			   <k> Value </k>
			   <behavior>
			      ...
			      <store>... Variable |-> (_=>Value)... </store>
			      ...
			   </behavior>
            ...		   
			</component>
			...
		</system> 
		) 	
//---------------------------------------------------------------------------------------------------------------------------------------------------------------		
	// transitions
	rule <system>
          ...
            <component><componentid>id|->Comid ...</componentid><k>CurState:Id -[ BG:BehaviorGuard ]-> NextState:Id { Act:ActionList } ; => . ...</k>... </component>
          ...
        </system>
        (. => <system> 
			<component>
			   ... 
			   <k> BG </k>
			   <behavior>
			      ...
			      <automata>
			          <automataid>Comid:Id</automataid>	
			          <eventcount> EvSn:Int => (EvSn +Int 1) </eventcount>
				      <event> ...  EvSn |-> BG </event>
				      <automatatable> ...  EvSn |-> (CurState, NextState, Act)...  </automatatable>
				      ...
			      </automata>  
			      ...
			   </behavior>
            ...		   
			</component>
			...
		</system> 
		) 

	rule <system>
          ...
            <component><componentid> id|->Comid ...</componentid><k>CurState:Id -[]-> NextState:Id { Act:ActionList } ; => . ...</k>... </component>
          ...
        </system>
        (. => <system> 
			<component>
			   ... 
			   <k> . </k>
			   <behavior>
			      ...
			      <automata>
			          <automataid>Comid:Id</automataid>	
			          <eventcount> EvSn:Int => (EvSn +Int 1) </eventcount>
				      <event> ...  EvSn |-> True </event>
				      <automatatable> ...  EvSn |-> (CurState, NextState, Act)...  </automatatable>
				      ...
			      </automata>  
			      ...
			   </behavior>
            ...		   
			</component>
			...
		</system> 
		) 			
//----------------------------------------------------------------------------------------------------------------------------------------------------------------	
    //从自动机中取出当前执行的判定事件
	rule <system>
          ...
            <component><componentid>id|->Comid ...</componentid> <k>. => BG  ...</k>
			   <behavior>
			      ...
			      <automata>
                     <automataid>Comid:Id</automataid>
                     <processingevent> EvSn:Int |-> (kclear=>kpending) </processingevent>
			         <status> krunning </status>
			         <event> EvSn|-> BG:BehaviorGuard </event>
			         ... 
			      </automata> //when (EvSn >=Int 0)
			     ...
			   </behavior>
            ...		   
			</component>
			...
		</system> 	
	// 如果当前判定事件失败，从自动机中删除该事件
	rule <system>
          ...
            <component><componentid>id|->Comid ...</componentid> false => . ...</k>
			   <behavior>
			      ...
			      <automata>
                     <automataid>Comid:Id</automataid>
                     <processingevent> (EvSn:Int => EvSn -Int 1  |-> (kpending=>kclear) </processingevent>
			         <status> krunning </status>
			         ... 
			      </automata> //when (EvSn >=Int 0)
			     ...
			   </behavior>
            ...		   
			</component>
			...
		</system> 	
	//判定事件成功，则执行相应的动作
	rule <system>
          ...
            <component><componentid>id|->Comid ...</componentid><k> true => Act ...</k>... </component>
          ...
        </system>
        (Act => <system> 
			<component>
			   <comid> .Map </comid>...</component> 
			   <k> _ => reenter_clock </k>
			   <behavior>
			      ...
			      <automata>
			          <automataid>Comid:Id</automataid>	
			          <status> krunning </status>
			          <processingevent> Cur:Int |-> (kpending=>krunning) </processingevent>
			          <curstate> CurState => NextState </curstate>
			          <automatatable> Cur|->(CurState:Id, NextState:Id, Act:ActionList) </automatatable>
			                                    ...
			      </automata>  
			      ...
			   </behavior>
            ...		   
			</component>
			...
		</system> 
		) 

    //动作执行完
	rule <system>
          ...
            <component><componentid>id|->Comid ...</componentid><k> 。</k>... </component>
          ...
        </system>
        (Act => <system> 
			<component>
			   <comid> .Map </comid> 
			   <k> _ => reenter_clock </k>
			   <behavior>
			      ...
			      <automata>
			          <automataid>Comid:Id</automataid>	
			          <status> krunning => kidle </status>
			          <processingevent> Cur:Int |-> (krunning=>kclear) </processingevent>
			          <curstate> CurState => NextState </curstate>
			          <automatatable> Cur|->(CurState:Id, NextState:Id, Act:ActionList) </automatatable>
			         ...
			      </automata>  
			      ...
			   </behavior>
            ...		   
			</component>
			...
		</system> 
		) 
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
    //p?(e) , transfer to true or false
	rule <system>
          ...
            <component>
               <componentid> id|->Comid ...</componentid>            
               <k> Portid:Id?( Var:Expression) => true </k>
               <port> 
                  <portid> id |-> Portid ... </portid> 
                  <portitemcount> (Head:Int => Head +Int 1) |-> Tail:Int </portitemcount>
                  <portdata> Head |-> Val:Id => . ...</portdata>... 
                </port>
			   <behavior>
			      <componentid> Comid </componentid> 
			      <store> Var |-> (_ => Val) ...</store> 
			      ...
			   </behavior>//when(Head <Int Tail) 
            ...		   
			</component>
			...
		</system>
	rule <system>
          ...
            <component>
               <componentid>id|->Comid ...</componentid>            
               <k> Portid:Id?( Var:Expression) => false </k>
               <port> 
                  <portid> id |-> Portid ... </portid> 
                  <portitemcount> Head:Int |-> Tail:Int </portitemcount>
                  ... 
                </port>
            ...		   
			</component>>//when (Head <Int Tail)
			...
		</system>     

	rule <system>
          ...
            <component>
               <componentid>id|->Comid ...</componentid>            
               <k> Portid:Id ! ( Var:Expression) => . </k>
               <port> 
                  <portid> id |-> Portid ... </portid> 
                  <portdest> DComid:Identifier |-> DPortid:Identifier </portdest>	
                  ... 
                </port>
            ...		   
			</component>//when (Head <Int Tail)
			...
		</system> 
		 
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
	// 启动全局时钟。 条件：1、当初始component中的k cell中已经清空；2、全局时钟为0。
	rule <system>
          ...
            <component>
                <comid> .Map </comid>            
                <k>. => run_globalclock</k>
                ...
            </component>
            <globalclock> 
                <globaltime> Clock:Int </globaltime> 
			    <subclockcount> Tc:Int |-> _ (kclear |-> Cc:Int => . )</subclockcount>
			    ...	
			</globalclock> //when (Clock =Int 0 andBool Tc >Int 0 andBool Tc =Int Cc)
			...
		</system>	
		
	// advance global clock, prepare advance subclock: 
	// set subclockcount cell (Current clock) to total number subtract 1, it is sequence number of last clock
	rule <system>
          ...
            <component>
                <comid> .Map </comid>            
                <k>run_globalclock => run_subclock </k>
                ...
            </component>
            <globalclock> 
                <globaltime> Clock:Int => Clock +Int 1 </globaltime> 
			    <subclockcount> Tc:Int |-> (_=>Tc -Int 1) </subclockcount>
			    ...	
			</globalclock>  
			...
		</system>
		
	// reentry subclock
	rule <system>
          ...
            <component>
                <comid> .Map </comid>            
                <k>reenter_clock => run_subclock</k>
                ...
            </component>
            <globalclock>  
			    <subclockcount> Tc:Int |-> (_=>Tc -Int 1) </subclockcount>
			    ...	
			</globalclock> 
			...
		</system>
 		
	// advance sub clock. status: kidle to krunning
	rule <system>
          ...
            <component>
               <comid> .Map </comid>            
               <k>run_subclock</k>
			   <behavior>
			      ...
			      <automata>
                     <automataid> Scid </automataid> 
                     <automataclock> Cv:Int => Cv +Int 1 </automataclock> 
			         <eventcount> EvSn:Int </eventcount> 
			         <processingevent> (_ => EvSn -Int 1) |-> kclear </processingevent>
			         <status> kidle => krunning </status>
			                                    。。。
			      </automata>  
			      ...
			   </behavior>
            ...		   
			</component>
            <globalclock>  
			    <subclockcount> _ |-> CurClock:Int </subclockcount> 
		        <subclock> CurClock |-> Scid:Id ...</subclock>
			    ...	
			</globalclock> 
			...
		</system>
	// end one sub clock advance, start next clock
	rule <system>
          ...
            <component>
               <comid> .Map </comid>            
               <k>run_subclock</k>
			   <behavior>
			      ...
			      <automata>
                     <automataid> Scid </automataid> 
			         <eventcount> EvSn:Int </eventcount> 
			         <processingevent> EvSnP:Int |-> kclear </processingevent>
			         <status> krunning => kidle </status>
			         ...
			      </automata>//when (EvSnP <Int 0)  
			      ...
			   </behavior>
            ...		   
			</component>
            <globalclock>  
			    <subclockcount> _ |-> (CurClock:Int => CurClock -Int 1) </subclockcount> 
		        <subclock> CurClock |-> Scid:Id ...</subclock>
			    ...	
			</globalclock> 
			...
		</system>
//----------------------------------------------------------------------------------------------------------------------------------------------------------------
    //SimpleExpression
    
    rule  SE1:Int < SE2:Int => (SE1 <Int SE2)   [structural]
    rule  SE1:Int > SE2:Int => (SE1 >Int SE2)   [structural]
    rule  SE1:Int == SE2:Int => (SE1 ==Int SE2) [structural]
    
    rule  SE1:Int Add SE2:Int => SE1 +Int SE2 [structural]
    rule  SE1:Int Sub SE2:Int => SE1 -Int SE2 [structural]
    rule  SE1:Int Mul SE2:Int => SE1 *Int SE2 [structural]
    rule  SE1:Int Div SE2:Int => SE1 /Int SE2 [structural]
    
	rule true or _ => true					            [structural]
	rule false or E:LogicalExpression => E				[structural]
	rule true and E:LogicalExpression => E				[structural]
	rule false and _ => false				            [structural]
	rule not true => false					            [structural]
	rule not false => true					            [structural]

	rule if (true) {S:EquationList} => S											[structural]
	rule if (false) {S:EquationList} => .											[structural]
	rule if (true) {S1:EquationList} else {S2:EquationList} => S1					[structural]
	rule if (false) {S1:EquationList} else {S2:EquationList} => S2					[structural]
	rule if (true) {S1:EquationList} else {S2:EquationList} => S1					[structural]
	rule if (false) {S1:EquationList} else {S2:EquationList} => S2					[structural] 
	
	//FunctionCall
	syntax Id ::= "sqtr"
	syntax Id ::= "log"
	syntax Id ::= "exp"
	syntax Id ::= "atan"
	syntax Id ::= "asin"
	syntax Id ::= "tan"
	syntax Id ::= "floor"
	syntax Id ::= "cos"
	syntax Id ::= "mod"
	syntax Id ::= "sin"
	rule [sqtr] : sqtr(F:Float) => sqrtFloat(F:Float)
	rule [log] : log(F:Float ) => logFloat(F:Float)
	rule [exp] : exp(F:Float ) => expFloat(F:Float)
	rule [atan] :  atan(F:Float ) => atanFloat(F:Float)
	rule [asin] : asin(F:Float ) => asinFloat(F:Float)
	rule [tan] : tan(F:Float ) => tanFloat(F:Float)
	rule [floor] : floor(F:Float ) => floorFloat(F:Float)
	rule [cos] : cos(F:Float ) => cosFloat(F:Float)
	rule [mod] : mod(F1:Float , F2:Float ) =>  F1:Float % F2:Float
	rule [sin] : sin(F:Float ) => sinFloat(F:Float)
	       
//---------------------------------------------------------------------------------------------------------------------------------------------------------------    
        
endmodule
