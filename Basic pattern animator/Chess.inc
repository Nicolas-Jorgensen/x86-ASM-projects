;Primary inc file 

INCLUDE Irvine32.inc

WriteColorBlock PROTO,
	char:BYTE, 
	backcolor:BYTE

PrintRow PROTO,
	color1:BYTE, 
	color2:BYTE

PrintBoard PROTO,
	color1:BYTE