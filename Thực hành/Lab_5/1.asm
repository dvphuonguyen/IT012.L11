	.data
	
array1:	.word	5, 6, 7, 8, 1, 2, 3, 9, 10, 4
size1:	.word	10

array2:	.byte	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
size2: 	.word	16
	
array3:	.space	8
size3:	.word	8

str1:	.asciiz	"Array 1: "
str2:	.asciiz	"\nArray 2: "
str3:	.asciiz	"\nArray 3: "
str4:	.asciiz	"\nNhap mang muon chon: "
str5:	.asciiz	"Nhap vi tri can chon: "
str6:	.asciiz	"Sai input: 1 <= Mang nhap vao <= 3 !!"
str7:	.asciiz	"Sai input: 0 <= Vi tri nhap vao < "
str8:	.asciiz	"Gia tri Array"
str9:	.asciiz " = "
step:	.asciiz	", "
char1:	.asciiz	" !!"
byte1:	.byte	'['
byte2:	.byte	']'

	.text
	
main:
	jal	print_array_1
	jal	print_array_2
	jal	create_array_3
	jal	chon_phan_tu
	j 	exit
	
print_array_1:
	la	$a0, str1
	li	$v0, 4
	syscall	
	la	$t0, array1
	lw	$t1, size1
	li	$t2, 0
	j	loop_1
		
loop_1:
	slt	$t3, $t2, $t1
	beq	$t3, $0, exit_loop
	addi	$t4, $t2, 0
	sll	$t4, $t4, 2
	add	$t4, $t4, $t0
	#In phan tu thu i
	lw	$a0, 0($t4)
	li	$v0, 1
	syscall
	#i++
	addi	$t2, $t2, 1
	#In khoang cach giua cac phan tu
	beq	$t2, $t1, exit_loop
	la	$a0, step
	li	$v0, 4
	syscall
	#Lap lai vong lap
	j	loop_1

print_array_2:
	la	$a0, str2
	li	$v0, 4
	syscall	
	la	$t0, array2
	lw	$t1, size2
	li	$t2, 0
	j	loop_2
		
loop_2:
	slt	$t3, $t2, $t1
	beq	$t3, $0, exit_loop
	addi	$t4, $t2, 0
	add	$t4, $t4, $t0
	#In phan tu thu i
	lb	$a0, 0($t4)
	li	$v0, 1
	syscall
	#i++
	addi	$t2, $t2, 1
	#In khoang cach giua cac phan tu
	beq	$t2, $t1, exit_loop
	la	$a0, step
	li	$v0, 4
	syscall
	#Lap lai vong lap
	j	loop_2
	
create_array_3:
	la	$a0, str3
	li	$v0, 4
	syscall	
	la	$s1, array1
	la	$s2, array2
	la	$s3, array3
	lw	$t0, size3
	li	$t1, 0
	j 	loop_3

loop_3:
	slt	$t2, $t1, $t0
	beq	$t2, $0, exit_loop
	#Array3[i]
	addi	$t2, $t1, 0
	add	$t2, $t2, $s3
	#Array2[i]
	addi	$t3, $t1, 0
	add	$t3, $t3, $s2
	lb	$t3, 0($t3)
	#Array2[size2 - 1 - i]
	lw	$t4, size2
	addi	$t4, $t4, -1
	sub	$t4, $t4, $t1
	add	$t4, $t4, $s2
	lb	$t4, 0($t4)
	#Array2[i] + Array2[size2 - 1 - i]
	add	$t3, $t3, $t4
	sb	$t3, 0($t2)
	#In array3[i]
	move	$a0, $t3
	li	$v0, 1
	syscall
	#i++
	addi	$t1, $t1, 1
	#In khoang cach
	beq	$t1, $t0, exit_loop
	la	$a0, step
	li	$v0, 4
	syscall
	#Lap lai
	j	loop_3

exit_loop:
	jr	$ra
	
chon_phan_tu:
	#Chon mang
	la	$a0, str4
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	move 	$t0, $v0
	#Check dieu kien mang
	li	$t3, 1
	li	$t4, 3
	slt	$t3, $t0, $t3
	slt	$t4, $t4, $t0
	bne	$t3, $t4, false_input_mang
	#Chon vi tri
	la	$a0, str5
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	move 	$t1, $v0
	jal	check_vi_tri
	move	$t7, $t4
	#Check dieu kien vi tri
	addi	$t4, $t4, -1
	li	$t3, 0
	slt	$t3, $t1, $t3
	slt	$t4, $t4, $t1
	bne	$t3, $t4, false_input_vitri
	addi	$t2, $t1, 0
	jal	get_gia_tri
	la	$a0, str8
	li	$v0, 4
	syscall
	move	$a0, $t0
	li	$v0, 1
	syscall
	lb	$a0, byte1
	li	$v0, 11
	syscall
	move	$a0, $t1
	li	$v0, 1
	syscall
	lb	$a0, byte2
	li	$v0, 11
	syscall
	la	$a0, str9
	li	$v0, 4
	syscall
	move	$a0, $t2
	li	$v0, 1
	syscall
	
	
	j	exit

get_gia_tri:
	li	$t4, 1
	beq	$t0, $t4, get_1
	add	$t2, $t2, $s0
	lb	$t2, 0($t2)
	jr	$ra

get_1:
	sll	$t2, $t2, 2
	add	$t2, $t2, $s0
	lw	$t2, 0($t2)
	jr	$ra

check_vi_tri:
	li	$t4, 1
	beq	$t0, $t4, true_1
	li	$t4, 2
	beq	$t0, $t4, true_2
	la	$s0, array3
	lw	$t4, size3
	jr	$ra
	
true_1:
	la	$s0, array1
	lw	$t4, size1
	jr	$ra
	
true_2:
	la	$s0, array2
	lw	$t4, size2
	jr	$ra
	
false_input_mang:
	la	$a0, str6
	li	$v0, 4
	syscall
	j	exit

false_input_vitri:
	la	$a0, str7
	li	$v0, 4
	syscall
	move	$a0, $t7
	li	$v0, 1
	syscall
	la	$a0, char1
	li	$v0, 4
	syscall
	j	exit
	
exit:
	li $v0, 10
	syscall