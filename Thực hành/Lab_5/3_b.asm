	.data
str1:	.asciiz	"Nhap n: "
str2:	.asciiz	"Nhap phan tu thu "
str3:	.asciiz	": "
str4:	.asciiz "Loi: Sai input! n > 0 !!"
str5:	.asciiz "\n\nNhap i: "
str6:	.asciiz "Nhap j: "
str7:	.asciiz "Loi: Sai input! 0 <= i, j < "
str8:	.asciiz " !!"
str9:	.asciiz ": "
str10:	.asciiz "\nArr ban dau: "
str11:	.asciiz "\nArr ket qua: "
sep:	.asciiz ", "
arr:	.space	256

	.text
main:
	li	$s2, 0	#$s2 = n = 0
	la	$s3, arr #$s3 = &arr	
	jal	nhap #Nhay den ham nhap
	la	$a0, str10
	li	$v0, 4
	syscall
	jal	xuat_mang			#Xuat mang
	jal	xuli				#Nhay den ham xu li
	la	$a0, str11
	li	$v0, 4
	syscall
	jal	xuat_mang			#Xuat mang
	j 	exit				#Thoat chuong trinh
	
nhap:
	la	$a0, str1
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	move	$s2, $v0
	slt	$t0, $0, $s2
	beq	$t0, $0, exit_sai_input		#n < 0
	beq	$s2, $0, exit_sai_input		#n = 0
	move	$t0, $s3			#$t0 = &arr
	sll	$t1, $s2, 2			#$t1 = n * 4
	add	$t2, $s3, $t1			#$t2 = &arr[n]
	li	$t4, 0
	j	nhap_phan_tu

nhap_phan_tu:
	slt	$t3, $t0, $t2
	beq	$t3, $0, exit_nhap_phan_tu
	la	$a0, str2
	li	$v0, 4
	syscall
	move	$a0, $t4
	li	$v0, 1
	syscall
	la	$a0, str3
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	sb	$v0, 0($t0)
	addi	$t0, $t0, 4
	addi	$t4, $t4, 1
	j	nhap_phan_tu

xuli:
	#Nhap i
	la	$a0, str5
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	move	$s0, $v0
	#Kiem tra i
	slt	$t3, $s0, $0
	bne	$t3, $0, exit_sai_input_i
	slt	$t3, $s0, $s2
	beq	$t3, $0, exit_sai_input_i
	#Nhap j
	la	$a0, str6
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	move	$s1, $v0
	#Kiem tra j
	slt	$t3, $s1, $0
	bne	$t3, $0, exit_sai_input_i
	slt	$t3, $s1, $s2
	beq	$t3, $0, exit_sai_input_i
	#Yeu cau de bai
	la	$t3, arr
	li	$t0, 1
	slt	$t1, $s0, $s1
	sll	$t2, $s0, 2
	add	$t2, $t2, $s3
	beq	$t0, $t1, true_if
	sb	$s1, 0($t2)
	jr	$ra
	
true_if:
	sb	$s0, 0($t2)
	jr	$ra
				
xuat_mang:
	move	$t0, $s3			#$t0 = &arr
	sll	$t1, $s2, 2			#$t1 = n * 4
	add	$t2, $s3, $t1			#$t2 = &arr[n]
	j	xuat_phan_tu
			
xuat_phan_tu:
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
	j 	xuat_phan_tu
									
exit_sai_input:
	la	$a0, str4
	li	$v0, 4
	syscall
	j	exit
	
exit_sai_input_i:
	la	$a0, str7
	li	$v0, 4
	syscall
	move	$a0, $s2
	li	$v0, 1
	syscall
	la	$a0, str8
	li	$v0, 4
	syscall
	j	exit

exit_nhap_phan_tu:
	jr	$ra
	
exit_xuat_phan_tu:
	jr	$ra

exit:
	li	$v0, 10
	syscall
