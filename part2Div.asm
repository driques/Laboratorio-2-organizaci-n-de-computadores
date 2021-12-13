main:
	addi $t0,$zero,23443#dividendo
	addi $t1,$zero,43 #divisor
	j division
	
multip:
	#se suma lo que esté en $t2 con lo que está en $t0
	#$t1 veces.
	add $t2,$t2,$t0
	#Se quita 1 a $t3
	subi $t3,$t3,1
	# if $t3>0 then multip else exit
	bgtz $t3,multip
	add $t0, $zero,$t2
	add $t2,$zero,$zero
	j division
	
	
division:
	#se genera la division
	add $t6,$t0,$zero #resto
	sub $t0,$t0,$t1 
	bltz $t0,toZero
	addi $t4,$t4,1 #div entera
	bgtz $t0,division
	add $t6,$zero,$zero
	j toZero
toZero:	
	#se reinician todos los valores utilizados a 0
	add $t7, $t4, $zero #resultado entero div
	add $t0,$zero,$zero
	add $t4,$zero,$zero
	#si hay resto en $t5 sale
	bgtz $t5,exit
	#si hay entero en $t9 se procede en resto2
	bnez $t9,resto2
	#si hay entero en $t6 se procede en resto
	bnez $t6,resto
	#se pasa a $t9 el registro t7
	add $t9,$t7,$zero
	add $t7,$zero,$zero
	j exit
resto:
	#se reinician para utilzar en la multiplicacion
	#se multiplica por 10 para dividir el resto
	add $t0,$t6,$zero
	addi $t3,$zero,10
	add $t9,$t7,$zero
	j multip
resto2:
	
	add $t0,$t6,$zero
	addi $t3,$zero,10
	add $t5,$t7,$zero
	j multip
	
	
exit:	
	#se imprime por consola el resultado
	#############
	addi $v0,$zero,1
	la $a0, ($t9)
	syscall
	#############
	addi $v0,$zero,4
	la $a0, coma
	syscall
	#############
	addi $v0,$zero,1
	la $a0, ($t5)
	syscall	
	#############
	addi $v0,$zero,1
	la $a0, ($t7)
	syscall
	#Exit
    	addi $v0, $zero, 10
    	syscall
	
.data
coma: .asciiz","