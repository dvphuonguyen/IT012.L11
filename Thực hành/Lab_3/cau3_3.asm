.data 

inputstr: .space 1000000
enterstr: .asciiz "Nhap chuoi : "
outputstr: .asciiz "\nXuat chuoi: "

.text 

.globl main
main:	
	li $v0, 4 # doc chuoi
	la $a0, enterstr # goi enterstr la cai muon xuat
	syscall
	
	li $v0, 8 # doc chuoi : gan $v0 = 8
	la $a0, inputstr # gan $a0 = dia chi chuoi o nho chua chuoi => dua dia chi bien $a0 de nhap chuoi
	li $a1,5000  #chieu dai cua bien luu chuoi inputstr => xin 5000 o nho tu hdh
	move $t0, $a0 # luu tam vao bien tam de lat nua in ra
	syscall
	
	li $v0, 4
	la $a0, outputstr
	syscall
	
	la $a0, inputstr
	move $a0, $t0
	li $v0, 4
	syscall
	
	li $v0, 10 # ket thuc chuong trinh == return 0;
	syscall