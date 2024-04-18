1.Please change all the paths used in the files according to your computer.

2.User can get his own stildpv libary by installing VCS software.

3.Home directory includes:
 3.1 src
 ---inc.h: Includes parameters definition.
 ---uart*: Source code
 3.2 Spec.doc
 ---Specification
 3.3 RS232-T901.pdf
 ---Evaluation results

4.Trojan
  Trojan Description
	Trojan trigger is a state machine inserted in the transmitter part of micro-UART core. The state machine seeks the sequence of 8’hAA, 8’h00, 8’h55, and 8’hFF. After Trojan activation, Trojan payload blocks any transmission afterward. 

  Trojan Taxonomy
	Insertion phase: Design
	Abstraction level: Register-transfer level (RTL)
	Activation mechanism: Internally conditionally triggered
	Effects: Denial of service
	Physical characteristics: Functional 





