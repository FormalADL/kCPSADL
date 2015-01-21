require "CPSADL.K"

module CONFIGURATION
   import CPSADL

   configuration
     <system multiplicity="*">
       <systemid> .Map </systemid>
       
       <subcomponent > .List </subcomponent>
       <component multiplicity="*">
          <componentid> .Map </componentid>
          <k> $PGM:K </k>
          <control>
              <currentCall>
                  <function> .K </function>
                  <xstack> .List </xstack>
                  <xcontext> . <xcontext>
                  <lstack> .List </lstack>
                  <fstack> .List </fstack>
              </currentCall>
              <cstack> .List </cstack>
          </control>
          <prototype multiplicity="*">
          </prototype>
         
         // port:
		  <port multiplicity="*"> 
			  <portid> .Map </portid>  
			  <portdata> .Map </portdata>
			  <portitemcount> 0 |-> 0 </portitemcount> // head |-> tail , tail entry, head out
			  <portfresh> 0 </portfresh>
			  <portdest> .Map </portdest> // dest-com-id |-> dest-port-id
		  </port>
         
          <subcomponent multiplicity="*"> .Map </subcomponent>
         
          <call multiplicity="*"> .Map </call> 
         
          <connection multiplicity="*">
             <connectionDes> .Map <connectionDes>
             <conComponent> .Map </conComponent>
             <conPort> .Map </conPort>
          </connection>
         
          <flow multiplicity="*">
          </flow>
        
          <mode multiplicity="*"> .Map </mode>
        
          <property multiplicity="*"> .Map </property>
         
          <comclock> 0 </comclock> 
		  <comstate> 0 |-> 0 </comstate> // current state |-> time left
										// state: 0 idle, 1 maybe idle, 2 waiting, 3 running, 4 want to run
		  <executions> .Map </executions> // number executions: act |-> time
         
        
          <behavior multiplicity="*">
             <states> .Map </states>
             <statevariables> .Map </statevariables>
		     <store> .Map </store> 
		     <automata>
		        <automataid> NotInitialized </automataid>
			    <automataclock> 0 </automataclock>
			    <status> kidle </status>
			    <curstate> 0 </curstate>
			    <eventcount> 0 </eventcount> 
			    <processingevent> .Map </processingevent> // number |-> state
			    <event> .Map </event>
			    <action> .Map </action> 	// match action
		     </automata> 
          </behavior>
       </component>
       
       <property> .Map </property>      // Identifier |-> value
       
       <cpu> 
		  <id> 0 </id> 
		  <state> 0 |-> 0 </state> // running thread: thread name |-> current priority
		  <threads> 
			  SyncThreads |-> 0  // for sync [2]
			  ReadyThreads |-> 0 // for sync [1]
			  SchedulingThreads |-> 0 // Scheduling Threads.
			  PeriodicThreads |-> 0
			  AperiodicThreads |-> 0
			  SporadicThreads |-> 0
			  TotalThreads |-> 0
		  </threads> 
	   </cpu>
	          
       <globalclock> 
          <globaltime> 0 </globaltime> 
		  <subclockcount> 0 |-> 0 kclear |-> 0 </subclockcount> // Total number |-> Current number ; Clear number
		  <subclock> .Map </subclock> // serial number |-> subautomata id
	   </globalclock>
	  
	   <warnning>  
		  <timeout> .Map </timeout>  // thread id |-> Global time, state
	   </warnning>
       
     </system>
     
endmodule  