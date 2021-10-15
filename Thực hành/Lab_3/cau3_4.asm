.data
number1: .asciiz "Nhap so nguyen thu nhat:"
number2: .asciiz "\nNhap so nguyen thu hai: "
sum: .asciiz "\nTong cua hai so nguyen la: "
.text

.globl main
main:
	la $a0, number1 #nhap
	li $v0, 4
	syscall
	
	li $v0, 5 # doc so number 1
	syscall
	
	sub $s0,$0,$v0
	
	la $a0, number2 # nhap
	li $v0, 4
	syscall
	
	li $v0, 5 # doc so number2
	syscall
	sub $s0, $v0, $s0
	
	
	li $v0, 4
	la $a0, sum
	syscall
	
	move $a0, $s0
	li $v0, 1
	syscall
	
	li $v0, 10 # ket thuc chuong trinh == return 0;
	syscall