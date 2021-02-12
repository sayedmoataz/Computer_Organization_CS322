.data
input: .space 100
newline: .asciiz "\n"
message1: .asciiz "Paragraph in upper case is : " 
message2: .asciiz "Paragraph in lower case is : " 

.text
main:
    li $v0, 8
    li $a1, 20
    la $a0, input
    syscall 

    
    jal uppercase
    li $v0, 4
    la $a0, input
    syscall
    
    jal lowarcase
    li $v0, 4
    la $a0, input
    syscall
    
    li $v0, 10
    syscall
    
    
uppercase:
    li $v0,4        # to print message1
    la $a0,message1
    syscall 
    li $t0, 0

loop1:
    lb $t1, input($t0) # load the value of register t0 in register t1 to do operation
    beq $t1, 0, exit1
    blt $t1, 'a', case1 # check if register t1 is less than a branch to counter
    bgt $t1, 'z', case1 # check if register t1 is greater than a branch to counter
    sub $t1, $t1, 32   # subtract 32 from the value of old register t1 and add to new register t1
    sb $t1, input($t0)

case1: 
    addi $t0, $t0, 1
    j loop1  #jump to loop
exit1:
    jr $ra
			
lowarcase:
li $v0,4        # to print message2
la $a0,message2
syscall
li $t0, 0

loop2:
    lb $t1, input($t0) # load the value of register t0 in register t1 to do operation
    beq $t1, 0, exit2
    blt $t1, 'A', case2 # check if register t1 is less than a branch to counter
    bgt $t1, 'Z', case2 # check if register t1 is greater than a branch to counter
    addi $t1, $t1, 32     #adding 32 from the value of old register t1 and add to new register t1
    sb $t1, input($t0)  #store the value of register t0 in register t1 to do operation

case2: 
    addi $t0, $t0, 1 # regiter t0 ++
    j loop2 #jump to loop
    
exit2:
    jr $ra
