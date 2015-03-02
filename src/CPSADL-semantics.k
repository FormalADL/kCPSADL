require "AADL.k"
require "Configuration.k"

module CPSADL-SEMANTICS

   imports AADL
   imports CONFIGURATION


   syntax KResult ::= #Int | #Bool | StateKeyword
   
   rule ComPrev:CmpClassifierDecl ComNext:CmpClassifierDecl => ComPrev ~> ComNext  [structural]
   //syntax Mend ::= "end"
  // syntax MSemicolon ::= ";"
  // syntax CmpCategory ::= "system"
   //syntax CmpType ::= CmpCategory Id Mend Id MSemicolon 
//			| CmpCategory Id CmpAssocDef Mend Id MSemicolon
   syntax Id ::= "id"  
              | "category" 
              | "type" 
              | "TotalTheads" 
              | "name" 
              | "ScheduledTimes" 
              | "kpending" 
              | "kclear" 
              | "direction" 
              | "datatype" 
              | "idles"
              | "novalue"
              | "krunning"

   rule <system>
             ...
             <component>... <k> system Sysid:Id CmpAD:CmpAssocDef end Sysid ; => . ...</k> ...</component>
             ...
        </system>
        (. => <system> 
			<systemid> 
				id |-> Sysid 
				category |-> system
			</systemid>  
			<component>... <k> CmpAD </k>... </component>
			...
		</system> 
		)
   rule <system>
             ...
             <component>... <k> system Sysid:Id end Sysid ; => . ...</k> ...</component>
             ...
        </system>
        (. => <system> 
			<systemid> 
				id |-> Sysid 
				category |-> system
			</systemid> 
			<component>... <k> . </k>... </component>
			...
		</system> 
		)
   rule <system>
             ...
             <component>... <k>  ComponentType:CmpCategoryType ComponentCategory:CPSNewCmpCategory Componentid:Id CmpAD:CmpAssocDef end Componentid ; => . ...</k> ...</component>
             ...
        </system>
        (. => <system>
            ...
            <component>
               <componentid>
                   id |-> Componentid
                   type |-> ComponentType
                   category |-> ComponentCategory
               </componentid>
               <k> CmpAD </k>
               ...
            </component>
            ...
        </system>
        )

   rule <system>
             ...
             <component>... <k>  thread Componentid:Id CmpAD:CmpAssocDef end Componentid ; => . ...</k> ...</component>
             <cpu> 
			    <threads> TotalThreads |-> (I:Int => I +Int 1) ...</threads> 
			    ... 
		     </cpu>
             ...
        </system>
        (. => <system>
            ...
            <component>
               <componentid>
                   id |-> Componentid
		//		   name |-> noname
                   category |-> thread
                   ScheduledTimes |-> 0
               </componentid>
               <k> CmpAD </k>
               <comclock> 0 </comclock>
               ...
            </component>
            ...
        </system>
        )
   rule <system>
             ...
             <component>... <k>  ComponentType:CmpCategoryType ComponentCategory:CPSNewCmpCategory Componentid:Id end Componentid ; => . ...</k> ...</component>
             ...
        </system>
        (. => <system>
            ...
            <component>
               <componentid>
                   id |-> Componentid
                   type |-> ComponentType
                   category |-> ComponentCategory
               </componentid>
               <k> . </k>
               ...
            </component>
            ...
        </system>
        )
	syntax Kidle ::= "kidle"
/*   rule <system> ...<component><componentid> .Map </componentid><k> . </k> ... </component> ... </system> 
           <system> ...<component><componentid> id |-> Componentid:Id ... </componentid><k> . </k> ... </component> ... </system>
           <automata><automataid> Componentid </automataid><status> kpending => Kidle </status> ... </automata>
           <system>
              ...
              <globalclock>
                  <subclockcount> ... kclear |-> (C:Int => C +Int 1) </subclockcount> // Total number |-> Current number
				  <subclock> _ |-> Componentid ... </subclock>
				  ...
              </globalclock>
           </system>*/
  
   rule CtPrev:CmpAssocDefElem CtNext:CmpAssocDefElem => CtPrev ~> CtNext [structural]
   rule PType:Mprototypes PT:ProtoTypeList => PT [structural]
   rule PType:Mfeatures PT:FeatureList => PT [structural]
   rule PType:Mflows PT:FlowSpecList => PT [structural]
   rule PType:Mproperties PT:PpeAssocList => PT [structural]
   rule PType:Msubcomponents PT:SubCmpList => PT [structural]
   rule PType:Mcalls PT:SubPgmCallSeqList => PT [structural]
   rule PType:Mconnections PT:ConnectionList => PT [structural] 
   
   rule PTPrev:ProtoType PTNext:ProtoType => PTPrev ~> PTNext [structural]
   rule PTPrev:Feature PTNext:Feature => PTPrev ~> PTNext [structural]
   rule PTPrev:FlowSpec PTNext:FlowSpec => PTPrev ~> PTNext [structural]
   rule PTPrev:PpeAssoc PTNext:PpeAssoc => PTPrev ~> PTNext [structural]
   rule PTPrev:SubCmp PTNext:SubCmp => PTPrev ~> PTNext [structural]
   rule PTPrev:SubPgmCallSeq PTNext:SubPgmCallSeq => PTPrev ~> PTNext [structural]
   rule PTPrev:Connection PTNext:Connection => PTPrev ~> PTNext [structural]

   rule <system>
            ...
            <component>... <k>  ComponentType:CmpCategoryType ComponentCategory:CPSNewCmpCategory implementation Componentid:Id . ComponentImplSuffix:Id CmpAD:CmpImplAssocDef end Componentid . ComponentImplSuffix ; => . ...</k> ...</component>
            ...
        </system>
        <system>
            ...
            <component> 
                <componentid> id |-> Componentid ... </componentid>
				<k>... . => CmpAD </k> 
			    ... 
			</component>
            ...
        </system> 
/*   rule <system>
            ...
          <component>... <k>  ComponentType:CmpCategoryType ComponentCategory:CPSNewCmpCategory implementation Componentid:Id . ComponentImplSuffix:Id end Componentid . ComponentImplSuffix ; => . ...</k> ...</component>
            ...
        </system>  
        (. => <system>
            ...
            <component> 
                <componentid> id |-> Componentid ... </componentid>
				<k> . </k> 
			    ... 
			</component>
            ...
        </system>)*/
   //  connection
   rule <system>
            ...
            <component> ... <k> ConId:Id : port CidS:Id . PidS:Id Dir:ConnectionSymbol CidD:Id . PidD:Id ; =>. ...</k> 
			(. => <connection>
			         <connectionDes> id |->ConId type|-> port direction|->Dir </connectionDes>
			         <conComponent> CidS|->CidD </conComponent>
			         <conPort> PidS|->PidD </conPort>
			      </connection>
			)
            ...
            </component>
            ...
        </system> 
   //  subcomponent
   rule <system>
            ...
            <component> ... <k> SubId:Id : ComponentType:CmpCategoryType ComponentCategory:CPSNewCmpCategory ; =>. ...</k>
			(. => <subcomponent>
			         id |-> SubId
                     type |-> ComponentType
                     category |-> ComponentCategory
			      </subcomponent>
			)
            ...
            </component>
            ...
        </system>
   //  property
   rule <system>
            ...
            <component> ... <k>  Pk:UniPpeId Pa:MRoughArrow Pv:Assignment ; =>. ...</k> 
			   <property> ... . => Pk |-> Pv </property>... </component>
            ...
        </system>
   rule <system>
            ...
            <component> ... <k>  Pk:UniPpeId Pa:MPlusRoughArrow Pv:Assignment ; =>. ...</k> 
			   <property> ... . => Pk |-> Pv </property>... </component>
            ...
        </system>   
   //  port
   syntax Test ::= "test" 
   rule <system>
            ...
            <component> ... <k>  Pid:Id : in data port Dbp:Id ; =>. ...</k>  
            (. => <port>
                     <portid> id|->Pid type|->data direction|->in datatype|-> Dbp </portid>
                     //<portdata> 0 |-> Test </portdata>	
                     <portitemcount> 0 |-> 1 </portitemcount> 
                     <portfresh> 0 </portfresh>
                     ...
                  </port>
            )
            ...
            </component>
            ...
        </system>
endmodule




