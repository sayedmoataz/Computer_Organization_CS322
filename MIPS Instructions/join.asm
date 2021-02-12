#############################################
#data_Section
	.data 
		str1: .asciiz "sayed"
		str2: .asciiz "moataz"
	
	
	
#############################################
#instructions_section
	.text
		la $a0 ,str1 
		la $a1 ,str2
		
		li $v0,4
		la $a0,str1
		syscall 
		li $v0,4
		la $a0,str2
		syscall 
