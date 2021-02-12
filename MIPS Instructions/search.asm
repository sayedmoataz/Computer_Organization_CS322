#############################################
#data_Section
	.data 
Array_1: .asciiz "kerolos faie" # the full string 
lenght_1: .word 12 #the lenght of Array_1
Array_2: .asciiz "faie"  #the destination string 
lenght_2: .word 4 #the lenght of Array_2 
notfound: .asciiz "not found"
found1: .asciiz "dest of \""
found2 : .asciiz "\" is at index["
c: .asciiz ","
p: .asciiz "]"


#############################################
#instructions_section
.text
#arguments of search function 
la $a0 ,Array_1 #load the address of Array_1 at $s0 
la $a1 ,Array_2 #load the address of Array_2 at $s1
lw $s2 , lenght_1  #load the address of lenght_1 at $s3
lw $s3 , lenght_2  #load the address of lenght_2 at $s4
jal search_function   # store PC at $ra and jump to search function 

li $v0,10 #exit system 
syscall 
#############################################
search_function: #function to search for a substring in string
	li $t0 , 0 # for loop counter -> j  
	li $t1 , 0 # for loop counter -> i
	li $t2 ,-1 #endIndex variable 
	li $t3 ,-1 #startIndex Variable 
	
	search_for_loop:	#for loop 
		bge $t0,$s3,Exit_For_loop  #if the condition ( j < strlen(dest) ) increase the counter by 1 
		bge $t1,$s2,Exit_For_loop  #if the condition ( i < strlen(str) ) increase the counter by 1 
		bne $t2,-1,Exit_For_loop  #if the condition ( endIndex = = -1 ) increase the counter by 1
		start_if_conditon:
			#access the 1st char of string to reg
			add $t6,$t1,$a0 #$t6 = i+ $a0
			lb $t4 ,0($t6) # $t4 = Array_1[$t6]
			
			add $t7,$t0,$a1 #$t7 = j+ $a1
			lb $t5 ,0($t7) # $t5 = Array_2[$t7]
			
			bne $t4 , $t5 ,End_If_Condition  #if the 1st char for both string not equal then end if condition anf go to else section 
			
			Middel_If_Condition : 
				bne $t3 , -1,Last_if_condition #continue the Last if condition if startIndex $t3 ! = -1 
				# if startIndex = = -1 then set the startIndex to i
				add $t3,$zero,$t1  # if startIndex = = -1 then set the startIndex to i
				 
			Last_if_condition: 
				addi $t9 ,$s3 , -1 # store the instruction ( strlen(dest) -1 ) to temp reqister
				bne $t0,$t9,increase_j # if the counter j != the previous instruction at temp req  ($t9) then continue the increase_j 
				# if the counter j = = the temp reg ($t9) then set endIndex $t2 equal to the counter i $t1
				add $t2,$t1,$0 # if the counter j = = the temp reg ($t9)then set endIndex $t2 equal to the counter i $t1
			#increase j section
			increase_j:
				addi $t0 ,$t0,1 #increase th counter j by 1
				j increase_i #jump increase_i
			
		#else_section 
		End_If_Condition: 
			finally_if_loop : 
				beq  $t3 ,-1 ,increase_i
				addi $t1,$t3 ,1 #i = startIndex +1 # make the for loop next time start with the next char of the string to check
				and $t0 , $zero , $t0 # j = 0 make the for loop next time start with the next char of the destination string to check
				addi $t3 ,$zero,-1 #startIndex = -1 
				j increase_i #jump increase_i
		#increase i section
		increase_i:
			addi $t1,$t1,1 #increase th counter i by 1
			j search_for_loop 

Exit_For_loop:
	if : 
		beq $t2,-1,else #if startIndex == -1 then go to else 
		beq $t3,-1,else #if endIndex == -1 then go to else  
		##printf("dest of %s is at index[%d,%d]",dest,startIndex,endIndex);
		li $v0,4 #laod 4 in $v0 to print string
		la $a0,found1 #laod the found1("dest of \"") in $a0
		syscall 
		li $v0,4 #laod 4 in $v0 to print string
		la $a0,Array_2 #laod the Array_2 in $a0
		syscall 
		li $v0,4 #laod 4 in $v0 to print string
		la $a0,found2 #laod the found2("\" is at index[") in $a0
		syscall 
		li $v0,1 #laod 1 in $v0 to print integer
		add $a0,$0,$t3 #laod the $t3 in $a0
		syscall
		li $v0,4 #laod 4 in $v0 to print string
		la $a0,c #laod the c(",") in $a0
		syscall  
		li $v0,1 #laod 1 in $v0 to print integer
		add $a0,$0,$t2 #laod the $t2 in $a0
		syscall 
		li $v0,4 #laod 4 in $v0 to print string
		la $a0,p #laod the p("]") in $a0
		syscall
		jr $ra 
	else : 
		##printf("not found");
		li $v0,4 #laod 4 in $v0 to print string
		la $a0,notfound #laod the notfound("notfound") in $a0
		syscall 
		jr $ra
	


#############################################
#strlen: 
#	la $t0, Array_1
#	li $t1 ,0 #counter i 
##		lb $s1 ,0($s0)
#		beqz $s1 ,exit 
		 
