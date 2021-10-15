.data 

string1: .asciiz "Chao ban! Ban la sinh vien nam thu may?"
string2: .asciiz "\nHihi, mih la sinh vien nam thu 1 ^-^\n"

.globl main
.text
main:	
	li $v0, 4 # xuat
	la $a0, string1 # goi cai muon xuat
	syscall
	
	li $v0, 4 # xuat
	la $a0, string2 #goi cai muon xuat
	syscall
	
	li $v0, 34
	syscall
	
	li $v0, 10 # ket thuc chuong trinh == return 0;
	syscall
	