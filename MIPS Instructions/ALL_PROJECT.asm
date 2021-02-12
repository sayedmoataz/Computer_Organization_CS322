.data 
#main data
maxlim : .word 100
str1 : .space 100
str2 : .space 100

intro : .asciiz "Welcome at our project \nthis is a program that make some operation at strings \nlet's start...\n...very good...\nnow what's the operation do u need to do\n...please type number of this operation...\n"
menu : .asciiz "1 -Search on a specific word/character \n2- find substring \n3- Join 2 strings\n4- Capitalize first letter in each word\n5- Convert all characters in the paragraph to Lower/upper case\n"
joke :.asciiz "am i joke with u ! ! !\n"
#search data
enter_p: .asciiz "enter paragraph and pleas end the paragraph -!- : \n"
enter_d: .asciiz "enter destination word and pleas end the paragraph -!-  :  "

notfound: .asciiz "not found"
found1: .asciiz "dest of "
found2 : .asciiz " is at index["
c: .asciiz ","
p: .asciiz "]"

#substrin
msg1: .asciiz "Enter Main String: "
msg2: .asciiz "Enter The SubString: "

strMain: .space 100
strSub: .space 100
endline: .asciiz "\n"
 

#Join_String
enter_1:.asciiz "enter 1st string : "
enter_2:.asciiz "enter 2nd string : "

#capitalize data
enter_a : .asciiz  "Enter a string and pleas end the paragraph -!- : "
capi_s : .asciiz "Capitalize string is : "

#upper_lower data
enter_f : .asciiz  "enter full string : "

newline: .asciiz "\n"
message1: .asciiz "Paragraph in upper case is : " 
message2: .asciiz "Paragraph in lower case is : " 

.text 



main:
	li $v0,4 #laod 4 in $v0 to print string
	la $a0,intro #laod the intro in $a0
	syscall 
	
	li $v0,4 #laod 4 in $v0 to print string
	la $a0,menu #laod the menu in $a0
	syscall 
	
	li $v0, 5 #laod 5 in $v0 to read integer
	syscall
	move $t0, $v0 #set $t0(selectop) to cotanits of $v0
	
	selectop_1: 
		bne $t0,1,selectop_2
		li $v0,4 #laod 4 in $v0 to print string
		la $a0,enter_p #laod the enter_p in $a0
		syscall
		
		li $v0, 8 #laod 8 in $v0 to read string
    		lw $a1, maxlim #laod maxlim in $a1 (max number of char to read) 
    		la $a0, str1 ##set str1 to cotanits of $a0
    		syscall
    		
    		la $t9, str1 #laod strl in $t9 to calculate the length  
    		jal strlen
    		add $s2,$t8,$0 #set $s2 to $t8
    		
    		li $v0,4 #laod 4 in $v0 to print string
		la $a0,enter_d #laod the enter_d in $a0
		syscall
		
    		li $v0, 8 #laod 8 in $v0 to read string
    		lw $a1, maxlim #laod maxlim in $a1 (max number of char to read) 
    		la $a0, str2 #set str2 to cotanits of $a0
    		syscall
    		
    		la $t9, str2 #laod strl in $t9 to calculate the length  
    		jal strlen
    		add $s3,$t8,$0 #set $s3 to $t8
    		jal search_function
    		j end_system
	selectop_2: 
		bne $t0,2,selectop_3
		
		#moving the text from msg1 to a text
   		  li $v0, 4
  		  la $a0, msg1
  		  syscall

 	   	  li $v0, 8
   		  la $a0, strMain
  		  li $a1, 99
    		  syscall
    
  		  #moving the text from msg2 to a text
  		  li $v0, 4
   		  la $a0, msg2
 	 	  syscall
 
    		  li $v0, 8
     	 	  la $a0, strSub
   		  li $a1, 99
  		  syscall


    		  la $a0,strMain
  		  jal findLengthString #calling function
	  	  move $a2, $v0

  		  la $a0, strSub
  		  jal findLengthString #calling function
  		  move $a3, $v0 # M
  		  sub $a2, $a2, $a3 # N-M
    

  		  la $a0, strMain
  		  la $a1, strSub 

   		  jal subStringMatch
  		  move $t1, $v0


  		  li $v0, 1
  		  move $a0, $t1
  		  syscall
    
	exit:
  		  li $v0, 10
  		  syscall

  		  lb $t9, endline

	findLengthString:
   		 li $t0, -1
   		 move $s0, $a0

   	 loop_fls:
     	  	 lb $t1, 0($s0)
     	         beq $t1, $t9, foundLength

      		  addi $t0, $t0, 1
      		  addi $s0, $s0, 1
      		  j loop_fls

   	 foundLength:
          	 move $v0, $t0
       		 jr $ra
		jal subStringMatch
		j end_system
	selectop_3: 
		bne $t0,3,selectop_4

		li $v0,4 #laod 4 in $v0 to print string
		la $a0,enter_1 #laod the enter_a in $a0
		syscall
		
		li $v0, 8 #laod 8 in $v0 to read string
    		lw $a1, maxlim #laod maxlim in $a1 (max number of char to read) 
    		la $a0, str1 #set str1 to cotanits of $a0
    		syscall
    		
		li $v0,4 #laod 4 in $v0 to print string
		la $a0,enter_2 #laod the enter_a in $a0
		syscall
		
		li $v0, 8 #laod 8 in $v0 to read string
    		lw $a1, maxlim #laod maxlim in $a1 (max number of char to read) 
    		la $a0, str2 #set str2 to cotanits of $a0
    		syscall
    		
    		############################# use $a0 ans $a1 to load the address of str1
    		#make the load $a0 and $a1 into function
    		jal joinfun #Join_String(str1,str2);
    		j end_system
	selectop_4: 
		bne $t0,4,selectop_5
		
		li $v0,4 #laod 4 in $v0 to print string
		la $a0,enter_a #laod the enter_a in $a0
		syscall
		
		li $v0, 8 #laod 8 in $v0 to read string
    		lw $a1, maxlim #laod maxlim in $a1 (max number of char to read) 
    		la $a0, str1 #set str1 to cotanits of $a0
    		syscall
    		
    		la $t9, str1 #laod strl in $t9 to calculate the length  
    		jal strlen
    		add $s2,$t8,$0 #set $s2 to $t8
    		jal capitalize #capitalize(str1);
    		j end_system
    		############################# use $a0 or $a1 to load the address of str1
    		#make the load $a0 or $a1 into function
    		
    		li $v0,4 #laod 4 in $v0 to print string
		la $a0,capi_s #laod the enter_a in $a0
		syscall
		
		li $v0,4 #laod 4 in $v0 to print string
		la $a0,str1 #laod the Array_2 in $a0
		syscall 
		
		j end_system
	selectop_5:
		bne $t0,5,selectop_else
		li $v0,4 #laod 4 in $v0 to print string
		la $a0,enter_f #laod the enter_f in $a0
		syscall
		
		li $v0, 8 #laod 8 in $v0 to read string
    		lw $a1, maxlim #laod maxlim in $a1 (max number of char to read) 
    		la $a0, str1 #set str1 to cotanits of $a0
    		syscall
    		
    		############################# use $a0 or $a1 to load the address of str1
    		#make the load $a0 or $a1 into function
    		#upper_lower(str1);
    		jal lowerandupper
    		j end_system
	selectop_else:  
		li $v0,4 #laod 4 in $v0 to print string
		la $a0,joke #laod the joke in $a0
		syscall
	end_system:
		li $v0,10 #exit system 
		syscall 
#############################################
search_function: #function to search for a substring in string
	li $t0 , 0 # for loop counter -> j  
	li $t1 , 0 # for loop counter -> i
	li $t2 ,-1 #endIndex variable 
	li $t3 ,-1 #startIndex Variable 
	la $a0 ,str1 #load the address of Array_1 at $s0 
	la $a1 ,str2 #load the address of Array_2 at $s1
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
		la $a0,str2 #laod the Array_2 in $a0
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
#function substring
subStringMatch:
    li $t0, 0 #i
    loop1:
        bgt $t0,$a2, loop1done  
        li $t1, 0 #j
        loop2:
            bge $t1, $a3, loop2done
            add $t3, $t0, $t1
            add $t4, $a0, $t3
            lb $t3, 0($t4) # main[i+j] 

            add $t4, $a1, $t1
            lb $t4, 0($t4) # sub[j]
            # if a0[i + j] != a1[j]
            bne $t3, $t4, break1

            addi $t1, $t1, 1
            j loop2
        loop2done:
            beq $t1, $a3, yesReturn
            j break1
        yesReturn:
            move $v0, $t0
            jr $ra
    break1:
        addi $t0, $t0, 1
        j loop1
    loop1done:
        li $v0, -1
        jr $ra
        

#############################################
#function Join_String
joinfun: 
	
	la $a0,str1
	li $v0,4
	syscall 
	
	la $a0,str2
	li $v0,4
	syscall 
	jr $ra
#############################################
#functioncapitalize
capitalize:             # function capitalize
caploop:                   # loop
    lb  $a1, str1($t1) # store index of arrary in register t1
    beq $t1,0,firstletter   # if condiction check if register t0 is equal zero index branch to first letter
    beq $a1,32,space         # if condiction check if register t1 is equal space branch to space
    beq $a1, 0, capexit     # if register t1 is equal null go to exit
   j counter          # jump to counter++
firstletter:
    blt  $a1, 'a', counter  # check if register t1 is less than a branch to exit
    bgt  $a1, 'z', counter # check if register t1 is more than a branch to exit
    sub  $a1, $a1, 32    # subtract 32 from the value of old register t1 and add to new register t1
    sb   $a1, str1($t1) # store the value of register t0 in register t1 to do operation
    addi $t1, $t1,1      # regiter t0 ++
    j caploop            # jump to loop
    
space:
    addi $t1, $t1,1      # regiter t0 ++
    lb   $a1, str1($t1) # load the value of register t0 in register t1 to do operation
    blt  $a1, 'a', counter  # check if register t1 is less than a branch to exit
    bgt  $a1, 'z', counter  # check if register t1 is more than a branch to exit
    sub  $a1, $a1, 32    # subtract 32 from the value of old register t1 and add to new register t1
    sb   $a1, str1($t1) # store the value of register t0 in register t1 to do operation
    j caploop            # jump to loop
    
counter:
addi $t1, $t1,1          # regiter t0 ++
j caploop                #jump to loop

capexit:
    li $v0, 4            # print string
    la $a0, str1        # print the string that store in array input
    syscall
    jr $ra
#############################################
#function upper_lower
lowerandupper: 
	uppercase:
	    li $v0,4        # to print message1
	    la $a0,message1
	    syscall 
	    li $t0, 0

	loopuper:
	    lb $t1,str1($t0) # load the value of register t0 in register t1 to do operation
	    beq $t1, 0, exit1
	    blt $t1, 'a', case1 # check if register t1 is less than a branch to counter
	    bgt $t1, 'z', case1 # check if register t1 is greater than a branch to counter
	    sub $t1, $t1, 32   # subtract 32 from the value of old register t1 and add to new register t1
	    sb $t1, str1($t0)

	case1: 
	    addi $t0, $t0, 1
	    j loopuper  #jump to loop
	exit1:
	    li $v0,4        # to print str1 upercase 
	    la $a0,str1
	    syscall
	    
			
	lowarcase:
	li $v0,4        # to print message2
	la $a0,message2
	syscall
	li $t0, 0
	
	looplower:
	    lb $t1, str1($t0) # load the value of register t0 in register t1 to do operation
	    beq $t1, 0, exit2
	    blt $t1, 'A', case2 # check if register t1 is less than a branch to counter
	    bgt $t1, 'Z', case2 # check if register t1 is greater than a branch to counter
	    addi $t1, $t1, 32     #adding 32 from the value of old register t1 and add to new register t1
	    sb $t1, str1($t0)  #store the value of register t0 in register t1 to do operation
	
	case2: 
	    addi $t0, $t0, 1 # regiter t0 ++
	    j looplower #jump to loop
	    
	exit2:
	    li $v0,4        # to print str1 lowarcase 
	    la $a0,str1
	    syscall
	    jr $ra

#############################################
strlen :
li $t8, 0    #counter i
loop : add $s0, $t9, $t8 #$s0 = i+ $t9
         lb $s1, 0($s0)# $s1 = Array_1[$s0]
         beq $s1,33, strlenexit #if $s1 == 33(!) go to else and if $s1 != 33(!) increes i
         add $t8,$t8,1
         j loop
strlenexit:
	jr $ra 
