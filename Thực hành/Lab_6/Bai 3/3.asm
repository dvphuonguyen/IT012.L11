	.data
str1: 	.asciiz "Nhap so nguyen duong: "
str2: 	.asciiz "\nKet qua: "
str3:	.asciiz "invalid Entry"
n0:	.asciiz "Zero "
n1:	.asciiz "One " 
n2:	.asciiz "Two "
n3:	.asciiz "Three " 
n4:	.asciiz "Four " 
n5:	.asciiz "Five " 
n6:	.asciiz "Six "
n7:	.asciiz "Seven " 
n8:	.asciiz "Eight "
n9:	.asciiz "Nine "
input:	.space	4

	.text
main:
	#Xuat "Nhap so nguyen duong: "
	la	$a0, str1
    	li 	$v0, 4
    	syscall
    	
    	#Nhap so
	la 	$a0, input
	li 	$a1, 4
	li 	$v0, 8
	syscall
	
	#Xuat "Ket qua: "
	la	$a0, str2
    	li 	$v0, 4
    	syscall
	
	#Check dieu kien va xu li
	la	$s0, input
	li	$t4, 0
	li	$t5, 3
	jal	check_dieu_kien

check_dieu_kien:
	lb	$t0, 0($s0)		#Lay ki tu $t0 trong &($s0)
	beqz	$t0, exit_check		#$t0 = '\0' 	-> Thoat check
	addi	$t1, $t0, -10		#$t1 = $t0 - 10 -> $t1 = '\n'
	beqz	$t1, exit_check		#$t1 = '\n' 	-> Thoat check	
	addi	$t4, $t4, 1		#demkitu = demkitu + 1
	addi	$s0, $s0, 1		#&($s0)++
	li	$t2, 47
	slt	$t6, $t2, $t0
	li	$t2, 58
	slt	$t7, $t0, $t2
	bne	$t6, $t7, exit_sai_input
	j 	check_dieu_kien
	
in_chu_so:
	bne	$t4, $t5, exit_sai_input	#Kiem tra du 3 ki tu hay khong
	lb	$t0, 0($s0)		#Lay ki tu $t0 trong &($s0)
	beqz	$t0, exit		#$t0 = '\0' 	-> Thoat
	addi	$t1, $t0, -10		#$t1 = $t0 - 10 -> $t1 = '\n'
	beqz	$t1, exit		#$t1 = '\n' 	-> Thoat
	move	$s1, $t0		#Di chuyen sang $s1 de check
	addi	$s0, $s0, 1		#&($s0)++
	jal	in_tung_so	
			   	  	  	
in_tung_so:
	li	$t0, '0'
	beq	$s1, $t0, true_0
	li	$t0, '1'	 
	beq	$s1, $t0, true_1     
	li	$t0, '2' 
	beq	$s1, $t0, true_2    
	li	$t0, '3'	 
	beq	$s1, $t0, true_3    
	li	$t0, '4'	 
	beq	$s1, $t0, true_4    
	li	$t0, '5'	 
	beq	$s1, $t0, true_5    
	li	$t0, '6'	 
	beq	$s1, $t0, true_6    
	li	$t0, '7'	 
	beq	$s1, $t0, true_7    
	li	$t0, '8'	 
	beq	$s1, $t0, true_8    
	li	$t0, '9'	 
	beq	$s1, $t0, true_9    
 
true_0:
	la	$a0, n0
	li 	$v0, 4
    	syscall
    	j 	in_chu_so   
   
true_1:
	la	$a0, n1
	li 	$v0, 4
    	syscall 
    	j 	in_chu_so
    
true_2:
	la	$a0, n2
	li 	$v0, 4
    	syscall 
    	j 	in_chu_so
       	
true_3:
	la	$a0, n3
	li 	$v0, 4
    	syscall	  
    	j 	in_chu_so  
    			  		  		  	
true_4:
	la	$a0, n4
	li 	$v0, 4
    	syscall  
    	j 	in_chu_so
    	
true_5:
	la	$a0, n5
	li 	$v0, 4
    	syscall
    	j 	in_chu_so
    
true_6:
	la	$a0, n6
	li 	$v0, 4
    	syscall
    	j 	in_chu_so
    	  	
true_7:
	la	$a0, n7
	li 	$v0, 4
    	syscall
    	j 	in_chu_so
    	  	
true_8:
	la	$a0, n8
	li 	$v0, 4
    	syscall
    	j 	in_chu_so
   	
true_9:
	la	$a0, n9
	li 	$v0, 4
    	syscall
    	j 	in_chu_so
  
exit_check:
	la	$s0, input
	jal	in_chu_so	    	
    	  	  	
exit_sai_input:
	la	$a0, str3
    	li 	$v0, 4
    	syscall 
    	
exit:
    	#Thoat
    	li 	$v0, 10
    	syscall

