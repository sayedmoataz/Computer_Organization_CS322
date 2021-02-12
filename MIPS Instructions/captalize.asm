.data
input: .space 2000 #declare array called input
Enter: .asciiz "Enter your string\n"
finish: .asciiz "your captalize string is:\n"

.text
main:              # main function
    li $v0,4       # print string
    la $a0,Enter   # print the string that store in variable Enter
    syscall 
    li $v0, 8      # read string
    li $a1, 2000   # strore 2000 in register a1 
    la $a0, input  # load array in regester a0
    syscall 
    jal capitalize # call function capitalize
    
capitalize:             # function capitalize
loop:                   # loop
    lb  $t1, input($t0) # store index of arrary in register t1
    beq $t0,0,firstletter   # if condiction check if register t0 is equal zero index branch to first letter
    beq $t1,32,space         # if condiction check if register t1 is equal space branch to space
    beq $t1, 0, exit    # if register t1 is equal null go to exit
   j counter          # jump to counter++
firstletter:
    blt  $t1, 'a', exit  # check if register t1 is less than a branch to exit
    bgt  $t1, 'z', exit  # check if register t1 is more than a branch to exit
    sub  $t1, $t1, 32    # subtract 32 from the value of old register t1 and add to new register t1
    sb   $t1, input($t0) # store the value of register t0 in register t1 to do operation
    addi $t0, $t0,1      # regiter t0 ++
    j loop               # jump to loop
    
space:
    addi $t0, $t0,1      # regiter t0 ++
    lb   $t1, input($t0) # load the value of register t0 in register t1 to do operation
    blt  $t1, 'a', exit  # check if register t1 is less than a branch to exit
    bgt  $t1, 'z', exit  # check if register t1 is more than a branch to exit
    sub  $t1, $t1, 32    # subtract 32 from the value of old register t1 and add to new register t1
    sb   $t1, input($t0) # store the value of register t0 in register t1 to do operation
    j loop               # jump to loop
    
counter:
addi $t0, $t0,1          # regiter t0 ++
j loop                   #jump to loop

exit:
    li $v0, 4            # print string
    la $a0, input        # print the string that store in array input
    syscall
    li $v0, 10           # end the program
    syscall
