	.data
str1:		.asciiz "\nNhap MSSV: "
arr1:		.space 8
str5:		.asciiz " =>	Tao thanh MSSV"
str6:		.asciiz " =>	Khong tao thanh MSSV"

	.text
main:
	li $s0, 0			# s0 = mssv = 0
	jal nhap_mssv
	la $s1, arr1			# s1 = & arr1
	jal nhap_mang_va_xu_ly	
	jal so_sanh
	j exit	
	
nhap_mssv:
	la $a0, str1
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s0, $v0
	jr $ra
	
nhap_mang_va_xu_ly:
	addi $t0, $0, 8			# n = 8
	li $t1, 0			# i = 0
	addi $t2, $0, 10000000		# t2 = 10000000
	addi $t3, $0, 10		# t3 = 10
	addi $t4, $0, 0			# sum = t4 = 0
	j nhap_phan_tu_mang_va_xu_ly

nhap_phan_tu_mang_va_xu_ly:
	beq $t1, $t0, exit_nhap 	# if (i == n) => nhay toi ham exit_nhap
	li	$v0, 5
	syscall
	add $t5,$s1,$t1			# nhap phan tu cho arr1
	sb $v0, ($t5) 			# luu vao mang	
	mult $v0,$t2			# v0 = v0 * t2 = t5 * t2
	mflo $v0			
	add $t4,$t4,$v0			# t3 = t3 + v0 
	div $t2,$t3			# giam mot so 0 trog t2			
	mflo $t2			# gan ket qua vao t2 => t2 = t2 // t3
	addi $t1, $t1, 1		# i = i + 1
	j nhap_phan_tu_mang_va_xu_ly	# quay lai vong lap
	
exit_nhap:
	jr $ra
	
so_sanh:
	beq $s0, $t4, true
	li $v0,4
	la $a0,str6
	syscall
	jr $ra
	
true:
	li $v0,4
	la $a0,str5
	syscall
	jr $ra
	
exit:
	li $v0, 10
	syscall	
			
	
	
	