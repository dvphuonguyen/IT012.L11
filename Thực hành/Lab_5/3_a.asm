	.data
str1:	.asciiz	"Nhap n: "
str2:	.asciiz	"Nhap phan tu thu "
str3:	.asciiz	": "
str4:	.asciiz	"Loi: Sai input! n > 0 !!"
str5:	.asciiz	"\nGia tri lon nhat: "
str6:	.asciiz	"\nGia tri nho nhat: "
str7:	.asciiz	"\n\nTong phan tu cua mang: "
str8:	.asciiz	"\n\nNhap chi so phan tu cua mang: "
str9:	.asciiz	"Gia tri Array"
str10:	.asciiz	" = "
str11:	.asciiz	"Loi: Sai input! 0 <= i < "
str12:	.asciiz	" !!"
byte1:	.byte	'['
byte2:	.byte	']'
arr:	.space	256

	.text
main:
	li	$s0, 0				#$s0 = n = 0
	la	$s1, arr			#$s1 = &arr	
	jal	nhap				#Nhay den ham nhap
	jal	min_max_sum			#Tim min, max, sum cua mang
	jal	phan_tu_thu_i			#Tim phan tu thu i
	j 	exit				#Thoat chuong trinh
	
nhap:	# nhap n va luu gia tri n vao $s0
	la	$a0, str1
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	move	$s0, $v0
	slt	$t0, $0, $s0
	beq	$t0, $0, exit_sai_input		#n < 0
	beq	$s0, $0, exit_sai_input		#n = 0
	move	$t0, $s1			#$t0 = &arr
	sll	$t1, $s0, 2			#$t1 = n * 4
	add	$t2, $s1, $t1			#$t2 = &arr[n]
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

min_max_sum:
	move	$t0, $s1			#$t0 = &arr
	sll	$t1, $s0, 2			#$t1 = n * 4
	add	$t2, $s1, $t1			#$t2 = &arr[n]
	lb	$t3, 0($t0)			#$t3 = min = arr[0]
	lb	$t4, 0($t0)			#$t4 = max = arr[0]
	li	$t7, 0				#$t7 = sum = 0
	j	tim_min_max_sum

tim_min_max_sum:
	slt	$t5, $t0, $t2
	beq	$t5, $0, exit_tim_min_max_sum
	lb	$t5, 0($t0)
	add	$t7, $t7, $t5			#Tinh tong mang
	slt	$t6, $t5, $t3
	bne	$t6, $0, thay_doi_min
	slt	$t6, $t4, $t5
	bne	$t6, $0, thay_doi_max
	addi	$t0, $t0, 4
	j	tim_min_max_sum

thay_doi_min:
	move	$t3, $t5
	addi	$t0, $t0, 4
	j	tim_min_max_sum

thay_doi_max:
	move	$t4, $t5
	addi	$t0, $t0, 4
	j	tim_min_max_sum

phan_tu_thu_i:
	la	$a0, str8
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	move	$t0, $v0
	slt	$t3, $t0, $0
	bne	$t3, $0, exit_sai_input_i
	slt	$t3, $t0, $s0
	beq	$t3, $0, exit_sai_input_i
	la	$a0, str9
	li	$v0, 4
	syscall
	lb	$a0, byte1
	li	$v0, 11
	syscall
	move	$a0, $t0
	li	$v0, 1
	syscall
	lb	$a0, byte2
	li	$v0, 11
	syscall
	la	$a0, str10
	li	$v0, 4
	syscall
	la	$t1, arr
	sll	$t0, $t0, 2
	add	$t0, $t1, $t0
	lb	$a0, 0($t0)
	li	$v0, 1
	syscall
	j 	exit
	
exit_sai_input:
	la	$a0, str4
	li	$v0, 4
	syscall
	j	exit
	
exit_sai_input_i:
	la	$a0, str11
	li	$v0, 4
	syscall
	move	$a0, $s0
	li	$v0, 1
	syscall
	la	$a0, str12
	li	$v0, 4
	syscall
	j	exit

exit_nhap_phan_tu:
	jr	$ra
	
exit_tim_min_max_sum:
	la	$a0, str5
	li	$v0, 4
	syscall
	move	$a0, $t4
	li	$v0, 1
	syscall
	la	$a0, str6
	li	$v0, 4
	syscall
	move	$a0, $t3
	li	$v0, 1
	syscall
	la	$a0, str7
	li	$v0, 4
	syscall
	move	$a0, $t7
	li	$v0, 1
	syscall
	jr	$ra

exit:
	li	$v0, 10
	syscall
