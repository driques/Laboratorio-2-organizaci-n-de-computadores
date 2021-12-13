
main:
	#ingreso de los dos numeros
	addi $v0,$zero,4
	la $a0, num1
	syscall
	addi $v0, $zero, 5    # recibe el entero
        syscall
        add $t0,$v0,$zero
        ##### Numero 2
        addi $v0,$zero,4
	la $a0, num2
	syscall
	addi $v0, $zero, 5    # recibe el entero
        syscall
        add $t1,$v0,$zero
        ### Calculo diferencia
        
        sub $t3,$t0,$t1
 
    	
    	
calculoDiv:
	addi $t4,$zero,2
	div $t3,$t4
	mfhi $t0
	beq $t0,$zero,par
	j imp
	
	
	
par:	
	addi $v0,$zero,4
	la $a0, dif
	syscall
	#############
	addi $v0,$zero,1
	la $a0, ($t3)
	syscall
	#############
	addi $v0,$zero,4
	la $a0, parr
	syscall
	#Exit
    	addi $v0, $zero, 10
    	syscall
imp:	
	addi $v0,$zero,4
	la $a0, dif
	syscall
	#############
	addi $v0,$zero,1
	la $a0, ($t3)
	syscall
	################
	addi $v0,$zero,4
	la $a0, impar
	syscall
	#Exit
    	addi $v0, $zero, 10
    	syscall
	
	
.data 
num1: .asciiz "Ingresa el primer numero: "
num2: .asciiz "Ingresa el segundo numero: "
dif: .asciiz "La diferencia es: "

parr: .asciiz " (par)"
impar: .asciiz " (impar)"
