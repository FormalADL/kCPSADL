

module CONFIGURATION
 
   configuration 
     <system multiplicity="*">
       <systemid> .Map </systemid>
       <component multiplicity="*"> 
          <componentid> .Map </componentid>
          <k>  $PGM:K </k>
          <control>
              <currentCall>
                  <function> .K </function>
                  <xstack> .List </xstack>
                  <xcontext> . </xcontext>
                  <lstack> .List </lstack>
                  <fstack> .List </fstack>
              </currentCall>
              <cstack> .List </cstack>
          </control>
         <prototype multiplicity="*"> .Map </prototype>
         
         // port:
		  <port multiplicity="*"> 
			  <portid> .Map </portid>  
			  <portdata> .Map </portdata>
			  <portitemcount> .Map </portitemcount> // head |-> tail , tail entry, head out
			  <portfresh> 0 </portfresh>
			  <portdest> .Map </portdest> // dest-com-id |-> dest-port-id
		  </port>
         
          <subcomponent multiplicity="*"> .Map </subcomponent>
        //  <subcomponent > .List </subcomponent>
          <call multiplicity="*"> .Map </call> 
         
          <connection multiplicity="*">
             <connectionDes> .Map </connectionDes>
             <conComponent> .Map </conComponent>
             <conPort> .Map </conPort>
          </connection>
         
           <flow multiplicity="*"> .Map </flow>
        
          <mode multiplicity="*"> .Map </mode>
        
          <property multiplicity="*"> .Map </property>  // Identifier |-> value
   
         
          <comclock> 0 </comclock> 
		  <comstate> .Map  </comstate> // current state |-> time left
										// state: 0 idle, 1 maybe idle, 2 waiting, 3 running, 4 want to run
		  <executions> .Map </executions> // number executions: act |-> time
         
        
          <behavior multiplicity="*">
             <states> .Map </states>
             <statevariables> .Map </statevariables>
		     <store> .Map </store> 
		     <automata>
		        <automataid> .Map </automataid>
			    <automataclock> 0 </automataclock>
			    <status> .Map </status>
			    <curstate> .Map </curstate>
			    <eventcount> 0 </eventcount> 
			    <processingevent> .Map </processingevent> // number |-> state
			    <event> .Map </event>
                            <automatatable> .Map </automatatable>
			    <action> .Map </action> 	// match action
		     </automata> 
          </behavior>  
       </component>

      
       <cpu> 
		  <id> 0 </id> 
		  <state> .Map  </state> // running thread: thread name |-> current priority
		  <threads> 
			//   $SyncThreads |-> 0  // for sync [2]
			//   $RadyThreadse |-> 0 // for sync [1]
			//   $SchedulingThreads |-> 0 // Scheduling Threads.
			//   $PeriodicThreads |-> 0
			//   $AperiodicThreads |-> 0
			//   $SporadicThreads |-> 0
			//   $TotalThreads |-> 0
                        .Map

		  </threads> 
	   </cpu>
	          
       <globalclock> 
          <globaltime> 0 </globaltime> 
		  <subclockcount> .Map   </subclockcount> // Total number |-> Current number ; Clear number
		  <subclock> .Map </subclock> // serial number |-> subautomata id
       </globalclock>
	  
	   <warnning>  
		  <timeout> .Map </timeout>  // thread id |-> Global time, state
	   </warnning> 
	
      
     </system>
 

  syntax KBEGIN ::= "none"
  syntax Id ::= "SyncThreads"
  syntax Id ::= "RadyThreadse "
  syntax Id ::= "PeriodicThreads"
  syntax Id ::= "AperiodicThreads"
  syntax Id ::= "TotalThreads"
  
     
endmodule  
