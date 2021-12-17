main:	
	#agregamos el numero a ser multiplicado
	addi $t0,$zero,14 #<- dato 1
	#agregamos la multiplicación
	add $t1,$zero,8 #<-dato 2

	
	
multip:
	#se suma lo que esté en $t2 con lo que está en $t0
	#$t1 veces.
	add $t2,$t2,$t0
	#Se quita 1 a $t1
	subi $t1,$t1,1
	# if $t1>0 then multip else exit
	bgtz $t1,multip
	j exit
	
exit:
	#Exit
    	addi $v0, $zero, 10
    	syscall
   
 
