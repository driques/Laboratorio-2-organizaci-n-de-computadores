##Datos para la ejecución del programa
.data
	coma: .asciiz","
	###################
	zeroFloat: .float 0.0
	oneFloat: .float 1.0
	tenFloat: .float 10.0
	firstDecimal: .float 0.1
	secondDecimal: .float 0.01
	error: .asciiz "ERROR DIVISION POR 0."
	
.text
	#Se agregan los numeros a operar
	addi $t0,$zero,23#dividendo
	addi $t1,$zero,2 #divisor
	 
	#######
	####
	#Se agregan los flotantes a utilizar
	lwc1 $f26,firstDecimal
	lwc1 $f27,secondDecimal
	####
	lwc1 $f29,tenFloat
	lwc1 $f30,zeroFloat
	lwc1 $f31,oneFloat
	#Se verifica que no se divida por 0
	beqz $t1,errorProgram
	#se verifica que el dividendo sea mayor que el divisor
	bgt $t1,$t0,inverso
	
	########
	j division
inverso:
	#Se agrega una flag
	addi $s5,$zero,1
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
	
#Funcion que multiplica los decimales.
multipDec:
	#se suma lo que esté en $f2 con lo que está en $f0
	#$f3 veces.
	add.s $f2,$f2,$f0
	#Se quita 1 a $f3
	sub.s $f3,$f3,$f31
	# if $t3>0 then multip else exit
	c.lt.s $f30,$f3
	bc1t multipDec
	add.s $f0, $f30,$f2
	add.s $f2,$f30,$f30
	addi $s1,$s1,1
	add $t5,$zero,$zero
	
	j exit	

#Funcion que multiplica los decimales.
multipDecCero:
	#se suma lo que esté en $f2 con lo que está en $f0
	#$f3 veces.
	add.s $f2,$f2,$f0
	#Se quita 1 a $f3
	sub.s $f3,$f3,$f31
	# if $t3>0 then multip else exit
	c.lt.s $f30,$f3
	bc1t multipDecCero
	add.s $f0, $f30,$f2
	add.s $f2,$f30,$f30
	addi $s1,$s1,1
	add $t9,$zero,$zero
	
	j exitConCero		
#En caso de que la division sea con el dividendo menor que el divisor
#se utiliza la siguiente función
exitConCero:
	add.s $f8,$f0,$f8
	
	###primer decimal####

	add.s $f0,$f26,$f30
	mtc1 $t9,$f3
	cvt.s.w $f3,$f3
	bgtz $t9,multipDecCero
	#######

	add.s $f0,$f27,$f30

	mtc1 $t5,$f3
	cvt.s.w $f3,$f3
	beq $s1,1,multipDecCero
	add.s $f15,$f30,$f0
	add.s $f8,$f9,$f8
	
	#se imprime por consola el resultado
	#############
	mov.s $f12,$f8
	li $v0,2
	syscall
	
	
	#Exit
    	addi $v0, $zero, 10
    	syscall
   
#Exit	
exit:	
	beq $s5,1,exitConCero #<-aqui
	add.s $f8,$f0,$f8
	
	###primer decimal####

	add.s $f0,$f26,$f30
	mtc1 $t5,$f3
	cvt.s.w $f3,$f3
	bgtz $t5,multipDec
	#######

	add.s $f0,$f27,$f30

	mtc1 $t7,$f3
	cvt.s.w $f3,$f3
	beq $s1,1,multipDec
	add.s $f15,$f30,$f0
	


	mtc1 $t9,$f9
	cvt.s.w $f9,$f9
	
	add.s $f8,$f9,$f8
	
	#se imprime por consola el resultado
	#############
	mov.s $f12,$f8
	li $v0,2
	syscall
	
	#Exit
    	addi $v0, $zero, 10
    	syscall
   
 #En caso de que se divida por 0.
errorProgram:
addi $v0,$zero,4
	la $a0, error
	syscall
	#############
	#Exit
    	addi $v0, $zero, 10
    	syscall
    	
    	   	
    	


