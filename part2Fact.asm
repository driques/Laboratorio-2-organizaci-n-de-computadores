main:	
	#agregamos el numero factorial
	addi $t0,$zero,10 #<- dato 1
	#Se guardan en variables externas para no perderlas
	#durante la multiplicación
	subi $t3,$t0,1 
	add $t1,$zero,$t3
	#se empieza la primera multiplicación
	j multi



	
factorial:
	#se guarda lo que está en $t2 y se
	#inicializa en 0 nuevamente.
	add $t0,$zero,$t2
	add $t2,$zero,$zero
	#se resta un 1 a la cantidad de veces que se
	#multiplica
	subi $t1,$t3,1
	subi $t3,$t3,1
	#add $t3,$t1,$zero
	bgtz $t3,multi
	#exit
	j exit

	
multi:
	#se suma lo que esté en $t2 con lo que está en $t0
	#$t1 veces.
	add $t2,$t2,$t0
	#Se quita 1 a $t1
	subi $t1,$t1,1
	# if $t1>0 then multip else exit
	bgtz $t1,multi
	#se salta a la creación del factorial
	j factorial
	
exit:
	#Exit
    	addi $v0, $zero, 10
    	syscall
   
 