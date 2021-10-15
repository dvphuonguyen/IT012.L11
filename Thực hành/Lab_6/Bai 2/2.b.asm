	.data
arr1:		.space 8
arr2:		.space 8
str1: 		.asciiz "=>	Tao thanh MSSV"
str2:		.asciiz	"=>	Khong tao thanh MSSV" 
str3: 		.asciiz "\nNhap MSSV: "
enter:		.asciiz "\n"
space:		.asciiz " "
	.text
main:
	li $s2, 0			# s2 = mssv = 0
	jal nhap_mssv
	la $s0, arr1			# s0 = & arr1
	jal nhap_mang_va_xu_ly	
	jal tach_mssv_thanh_mang
	jal xu_ly_mang
	jal exit
	
nhap_mssv:
	la $a0, str3
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s2, $v0
	jr $ra

nhap_mang_va_xu_ly:
	li $t0, 0 			# i = t0 = 0
	addi $t1,$0,8 			# n = t1 = 8
	j nhap_phan_tu_mang_va_xu_ly

nhap_phan_tu_mang_va_xu_ly:
	beq $t0, $t1, exit_nhap			# if (i == n) exit_nhap
	li $v0,5				# read(arr1[i])
	syscall
	add $t2,$s0,$t0				# nhap phan tu cho mang arr1
	sb $v0, ($t2) 				# luu vao mang
	addi $t0, $t0, 1			# i = i + 1
	j nhap_phan_tu_mang_va_xu_ly
	
exit_nhap:
	jr $ra
	
tach_mssv_thanh_mang:
	li $t0, 0 				# gan i=0
	addi $t5,$0,10
	la $s1,arr2				# s1 = & arr2
	j them_phan_tu_vao_mang
	
them_phan_tu_vao_mang:
	beq $s2,$0,exit_them			#neu s2 = mssv = 0 thi exit_them
	div $s2,$t5
	mflo $s2				# s2 = mssv = mssv // 10
	mfhi $t4 				# t4 = mssv % 10
	add $t2,$s1,$t0				# them gia tri vao mang arr2
	sb $t4,($t2)				# luu vao mang
	addi $t0, $t0, 1			# i = i + 1
	j them_phan_tu_vao_mang
	
exit_them:
	jr $ra

xu_ly_mang:
	li $t0, 0				# t0 = i = 0
	li $t1,8 				# t1 = n = 8
	li $t7,-1				# t7 = -1
	addi $s3,$s3,0 				# dem so giong nhau
	j kiem_tra
	
kiem_tra:
	beq $t0, $t1, exit_kiem_tra		# if (i == n) => ket thuc vong lap
	add $t2,$s0,$t0
	lb $t3, ($t2) 				# luu vao mang
	li $t4,0				# t4 = i = 0
	j so_sanh
	
exit_kiem_tra:
	beq $s3,$t1, true			# s3 = t1 thi nhay qua true
	li $v0,4
	la $a0,str2				# khong tao thanh mssv
	syscall
	jr $ra

true:						# tao thanh mssv
	li $v0,4
	la $a0,str1
	syscall
	jr $ra
		
so_sanh:
	beq $t4, $t1, exit_so_sanh		# if (i == n) thi nhay den exit_so_sanh		
	add $t5,$s1,$t4				# them gia tri vao arr2
	lb $s2,($t5)				# luu vao mang
	beq $s2,$t3, tiep_tuc			# neu s2 = t3 = mssv thi nhay den tiep_tuc
	addi $t4, $t4, 1			# i = i + 1
	j so_sanh				# quay lai vong lap
				
tiep_tuc:
	sb $t7,($t5) 				# neu bang nhau ta gan so trong mang  bang -1
	add $s3,$s3,1				# s3 = s3 + 1
	j exit_so_sanh
			
exit_so_sanh:
	addi $t0, $t0, 1			# t0 = t0 + 1
	j kiem_tra
	
exit:
	li $v0, 10
	syscall		
	
				
				
	
	
