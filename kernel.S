.syntax unified
.cpu cortex-m4
.thumb
#define a #4
#define b #3
#define c #2

.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector
vtable_kernel:
	.word __stack_start
	.word __kernel_reset__+1
	.size vtable_kernel, .-vtable_kernel

.section .rodata
	data: .asciz "kernel started!\n"
	final: .asciz "(a-b)*3 + 2^c = "
.section .text
__kernel_reset__:
   	ldr r0, =data
	bl dbgput_line
    
	// calculate
	mov r0, #1
	mov r1, a
	mov r2, b
	mov r3, c
	mov r4, #3

	lsl r0, r0, r3
	sub r1, r2
	mla r0, r1, r4, r0
	mov r3, r0
        
	ldr r0, =final
	bl dbgput
	mov r0, r3
	bl dbgput_num
    
	end:
	b end


