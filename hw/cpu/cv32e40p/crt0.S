.global vector_table

/* Entry point for bare metal programs */
.section .text.start
.global _start
.type _start, @function

_start:
/* initialize stack pointer */
	la sp, __stack_top

	# 启用浮点单元 (FPU)
    # 设置 mstatus.FS 为 01 (初始状态)
    li t0, 0x00002000     # MSTATUS_FS_INITIAL (0x2000 = FS bits set to 01)
    csrrs t0, mstatus, t0 # 设置 mstatus 寄存器中的 FS 位

/* set vector table address */
	la a0, __vector_start
	ori a0, a0, 1 /*vector mode = vectored */
	csrw mtvec, a0

/* clear the bss segment */
	la a0, __bss_start
	la a2, __bss_end
	sub a2, a2, a0
	li a1, 0
	call memset

	call main
	j .

.size  _start, .-_start
