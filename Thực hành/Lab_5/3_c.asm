	.data
str1:	.asciiz	"Nhap n_1: "
str2:	.asciiz	"\nNhap n_2: "
str3:	.asciiz	"Nhap A["
str4:	.asciiz	"Nhap B["
str5:	.asciiz	"]= "
str6:	.asciiz "Loi: Sai input! n_1 >= 10 !!"
str7:	.asciiz "Loi: Sai input! n_2 > 0 !!"
str8:	.asciiz "\nArrA: "
str9:	.asciiz "\nArrB: "
str10:	.asciiz "\nBan dau: "
str11:	.asciiz "\n\nKet qua: "
sep:	.asciiz ", "
arrA:	.space	256
arrB:	.space	256

	.text
main:
	la	$s1, arrA				#$s1 = &arrA
	la	$s2, arrB				#$s2 = &arrB
	jal	nhap_arr_a				#Nhap arrA
	jal	nhap_arr_b				#Nhap arrB
	la	$a0, str10
	li	$v0, 4
	syscall
	jal	xuat_mang_a				#Xuat arrA
	jal	xuat_mang_b				#Xuat arrB
	jal	xuli					#Xu li
	la	$a0, str11
	li	$v0, 4
	syscall
	jal	xuat_mang_a				#Xuat arrA
	jal	xuat_mang_b				#Xuat arrB
	j 	exit

nhap_arr_a:
	la	$a0, str1
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	move	$s3, $v0
	li	$t0, 9
	slt	$t1, $t0, $s3
	beq	$t1, $0, exit_sai_input			#n_1 < 10
	move	$t0, $s1				#$t0 = &arr
	sll	$t1, $s3, 2				#$t1 = n * 4
	add	$t2, $s1, $t1				#$t2 = &arr[n]
	li	$t4, 0
	j	nhap_phan_tu_a
	
nhap_phan_tu_a:
	slt	$t3, $t0, $t2
	beq	$t3, $0, exit_nhap_phan_tu
	la	$a0, str3
	li	$v0, 4
	syscall
	move	$a0, $t4
	li	$v0, 1
	syscall
	la	$a0, str5
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	sb	$v0, 0($t0)
	addi	$t0, $t0, 4
	addi	$t4, $t4, 1
	j	nhap_phan_tu_a	
	
nhap_arr_b:
	la	$a0, str2
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	move	$s4, $v0
	slt	$t0, $0, $s4
	beq	$t0, $0, exit_sai_input_2		#n_2 < 0
	beq	$s4, $0, exit_sai_input_2		#n_2 = 0
	move	$t0, $s2				#$t0 = &arr
	sll	$t1, $s4, 2				#$t1 = n * 4
	add	$t2, $s2, $t1				#$t2 = &arr[n]
	li	$t4, 0
	j	nhap_phan_tu_b

nhap_phan_tu_b:
	slt	$t3, $t0, $t2
	beq	$t3, $0, exit_nhap_phan_tu
	la	$a0, str4
	li	$v0, 4
	syscall
	move	$a0, $t4
	li	$v0, 1
	syscall
	la	$a0, str5
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	sb	$v0, 0($t0)
	addi	$t0, $t0, 4
	addi	$t4, $t4, 1
	j	nhap_phan_tu_b	

xuat_mang_a:
	move	$t0, $s1			#$t0 = &arr
	sll	$t1, $s3, 2			#$t1 = n * 4
	add	$t2, $s1, $t1			#$t2 = &arr[n]
	la	$a0, str8
	li	$v0, 4
	syscall
	j	xuat_phan_tu_a
			
xuat_phan_tu_a:
	slt	$t3, $t0, $t2
	beq	$t3, $0, exit_xuat_phan_tu
	lb	$a0, 0($t0)
	li	$v0, 1
	syscall
	addi	$t0, $t0, 4
	beq	$t0, $t2, exit_xuat_phan_tu
	la	$a0, sep
	li	$v0, 4
	syscall
	j 	xuat_phan_tu_a
	
xuat_mang_b:
	move	$t0, $s2			#$t0 = &arr
	sll	$t1, $s4, 2			#$t1 = n * 4
	add	$t2, $s2, $t1			#$t2 = &arr[n]
	la	$a0, str9
	li	$v0, 4
	syscall
	j	xuat_phan_tu_b
			
xuat_phan_tu_b:
	slt	$t3, $t0, $t2
	beq	$t3, $0, exit_xuat_phan_tu
	lb	$a0, 0($t0)
	li	$v0, 1
	syscall
	addi	$t0, $t0, 4
	beq	$t0, $t2, exit_xuat_phan_tu
	la	$a0, sep
	li	$v0, 4
	syscall
	j 	xuat_phan_tu_b
	
xuli:
	li	$t0, 2				#$t0 = i = 2
	sll	$t0, $t0, 2			#$t0 = i * 4
	add	$t0, $t0, $s1			#$t0 = &arrA[2]
	li	$t1, 10				#$t1 = 10
	sll	$t1, $t1, 2			#$t1 = 10 * 4
	add	$t2, $s1, $t1			#$t2 = &arrA[10]
	j	xu_li_phan_tu
	
xu_li_phan_tu:
	slt	$t3, $t0, $t2
	beq	$t3, $0, exit_xu_li_phan_tu
	addi	$t4, $t0, -8			#&ArrA[i - 2]
	lb	$t4, 0($t4)			#ArrA[i - 2]	
	sll	$t4, $t4, 2			#ArrA[i - 2] * 4
	add	$t4, $t4, $s2			#&ArrB[ArrA[i - 2]]
	lb	$t4, 0($t4)			#ArrB[ArrA[i - 2]]
	sb	$t4, 0($t0)			#ArrA[i] = ArrB[ArrA[i - 2]]
	addi	$t0, $t0, 4
	j	xu_li_phan_tu

exit_sai_input:
	la	$a0, str6
	li	$v0, 4
	syscall
	j exit	
	
exit_sai_input_2:
	la	$a0, str7
	li	$v0, 4
	syscall
	j exit			

exit_nhap_phan_tu:
	jr	$ra
	
exit_xuat_phan_tu:
	jr	$ra
	
exit_xu_li_phan_tu:
	jr	$ra																	
																											
exit:
	li	$v0, 10
	syscall