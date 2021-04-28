#Inserisci 5 valori in area stack e stampa i valori pari e quelli dispari.

.data 
p1: .asciiz "\n Dammi il valore di arr [] : "
p2: .asciiz "\n I valori pari sono : "
p3: .asciiz "\n I valori dispari sono : "
.text
.globl main

main:
addi $sp,$sp,-20
move $a1,$sp

jal riempi_array

jal conta_par_dis

li $t1,5
sub $t1,$t1,$v0
move $t0,$v0
la $a0,p2
li $v0,4
syscall
move $a0,$t0
li $v0,1
syscall
la $a0,p3
li $v0,4
syscall
move $a0,$t1
li $v0,1
syscall
li $v0,10
syscall

riempi_array:
move $s0,$a1
li $t0,5
loop:
la $a0,p1
li $v0,4
syscall
li $v0,5
syscall
sw $v0,($s0)
addi $s0,$s0,4
addi $t0,$t0,-1
bne $t0,0,loop
jr $ra

conta_par_dis:
move $s0,$a1
move $v0,$zero
li $t2,5
li $t3,1
loop1:
beq $t2,0,a2
lw $t0,0($s0)
and $t1,$t0,$t3
bne $t1,0,a1
addi $v0,$v0,1
addi $s0,$s0,4
addi $t2,$t2,-1
j loop1

a1:
addi $s0,$s0,4
addi $t2,$t2,-1
j loop1

a2:
jr $ra
