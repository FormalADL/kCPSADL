require "CPSADL.k"
require "Configuration.k"

module CPSADL-SEMANTICS
   import CPSADL
   import CONFIGURATION

   syntax KResult ::= #Int | #Bool | StateKeyword
   
   rule ComPrev:CmpClassifierDecl ComNext:CmpClassifierDecl => ComPrev ~> ComNext  [structural]
   
   rule <system>
             ...
             <component>... <k> system Sysid : Id CmpAD : CmpAssocDef end Sysid ; => . ...</k> ...</component>
             ...
        </system>
        (. => <system> 
			<systemid> 
				id |-> Sysid 
				category |-> system
			</systemid>  
			... 
			<component>... <k> CmpAD </k>... </component>
			...
		</system> 
		)
   rule <system>
             ...
             <component>... <k> system Sysid : Id end Sysid ; => . ...</k> ...</component>
             ...
        </system>
        (. => <system> 
			<systemid> 
				id |-> Sysid 
				category |-> system
			</systemid>  
			... 
			<component>... <k> . </k>... </component>
			...
		</system> 
		)
   rule <system>
             ...
             <component>... <k>  ComponentType : CmpCategoryType ComponentCategory : CPSNewCmpCategory Componentid : Id CmpAD : CmpAssocDef end Componentid ; => . ...</k> ...</component>
             ...
        </system>
        (. => <system>
            ...
            <component>
               <componentid>
                   id |-> Componentid
                   type |-> CmpCategoryType
                   category |-> CPSNewCmpCategory
               </componentid>
               <k> CmpAD </k>
               ...
            </component>
            ...
        </system>
        )

   rule <system>
             ...
             <component>... <k>  thread Componentid : Id CmpAD : CmpAssocDef end Componentid ; => . ...</k> ...</component>
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
				   name |-> noname
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
             <component>... <k>  ComponentType : CmpCategoryType ComponentCategory : CPSNewCmpCategory Componentid : Id end Componentid ; => . ...</k> ...</component>
             ...
        </system>
        (. => <system>
            ...
            <component>
               <componentid>
                   id |-> Componentid
                   type |-> CmpCategoryType
                   category |-> CPSNewCmpCategory
               </componentid>
               <k> . </k>
               ...
            </component>
            ...
        </system>
        )
   rule <system> ...<component><componentid> .Map </componentid><k> . </k> ... </component> ... </system> 
           <system> ...<component><componentid> id |-> componentid : Id ... </componentid><k> . </k> ... </component> ... </system>
           <automata><automataid> componentid </automataid><status> kpending => kidle </status> ... </automata>
           <system>
              ...
              <globalclock>
                  <subclockcount> ... kclear |-> (C:Int => C +Int 1) </subclockcount> // Total number |-> Current number
				  <subclock> _ |-> componentid ... </subclock>
				  ...
              </globalclock>
           </system>
  
   rule CtPrev:CmpAssocDef CtNext:CmpAssocDef => CtPrev ~> CtNext [structural]
   rule PType:Mprototypes PT:ProtoTypeList => PT [structural]
   rule PType:Mfeatures PT:FeatureList => PT [structural]
   rule PType:Mflows PT:FlowSpecList => PT [structural]
   rule PType:Mproperties PT:PpeAssocList => PT [structural]
   rule PType:Msubcomponents PT:SubCmpList => PT [structural]
   rule PType:Mcalls PT:SubPgmCallSeqList => PT [structural]
   rule PType:Mconnections PT:ConnectionList => PT [structural] 
   
   rule PTPrev:ProtoTypeList PTNext:ProtoTypeList => PTPrev ~> PTNext [structural]
   rule PTPrev:FeatureList PTNext:FeatureList => PTPrev ~> PTNext [structural]
   rule PTPrev:FlowSpecList PTNext:FlowSpecList => PTPrev ~> PTNext [structural]
   rule PTPrev:PpeAssocList PTNext:PpeAssocList => PTPrev ~> PTNext [structural]
   rule PTPrev:SubCmpList PTNext:SubCmpList => PTPrev ~> PTNext [structural]
   rule PTPrev:SubPgmCallSeqList PTNext:SubPgmCallSeqList => PTPrev ~> PTNext [structural]
   rule PTPrev:ConnectionList PTNext:ConnectionList => PTPrev ~> PTNext [structural]

   rule <system>
            ...
            <component>... <k>  ComponentType : CmpCategoryType ComponentCategory : CPSNewCmpCategory Componentid : Id . ComponentImplSuffix : Id CmpAD : CmpImplAssocDef end Componentid  . ComponentImplSuffix ; => . ...</k> ...</component>
            ...
        </system>
        <system>
            ...
            <component> 
                <comid> id |-> Componentid ... </comid>
				<k>... . => ComType </k> 
			    ... 
			</component>
            ...
        </system> 
   rule <system>
            ...
            <component>... <k>  ComponentType : CmpCategoryType ComponentCategory : CPSNewCmpCategory Componentid : Id . ComponentImplSuffix : Id end Componentid  . ComponentImplSuffix ; => . ...</k> ...</component>
            ...
        </system> => .   
   //  connection
   rule <system>
            ...
            <component> ... <k> ConId:Id : Pt:PortType CidS:Id . PidS:Id
			Dir:ConnectionSymbol CidD:Id . PidD:Id; => . ... </k> 
			(. => <connection>
			         <connectionDes> id|->ConId type|-> Pt direction|->Dir </connectionDes>
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
            <component> ... <k> SubId:Id : ComponentType : CmpCategoryType ComponentCategory : CPSNewCmpCategory SubSystemId:id ; => . ...</k>
			(. => <subcomponent>
			         id |-> Subid
			         name|-> SubSystemId
                     type |-> CmpCategoryType
                     category |-> CPSNewCmpCategory
			      </subcomponent>
			)
            ...
            </component>
            ...
        </system>
   //  property
   rule <system>
            ...
            <component> ... <k>  Pk:UniPpeId Pa:MRoughArrow Pv:Assignment ; => . ...</k> 
			   <property> ... . => Pk |-> Pv </property>... </component>
            ...
        </system>
   rule <system>
            ...
            <component> ... <k>  Pk:UniPpeId Pa:MPlusRoughArrow Pv:Assignment ; => . ...</k> 
			   <property> ... . => Pk |-> Pv </property>... </component>
            ...
        </system>   
   //  port
   rule <system>
            ...
            <component> ... <k>  Pid:Id : Pd:Min Pt:PortType Dbp:Id; => . ...</k>  
            (. => <port>
                     <portid> id|->Pid type|->Pt direction|->Pd datatype|-> Dbp </portid>
                     <portdata> 0 |-> test </portdata>	
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




