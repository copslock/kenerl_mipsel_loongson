Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Nov 2004 16:46:05 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:3087
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225322AbUKUQp6>; Sun, 21 Nov 2004 16:45:58 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CVuqb-0002ZF-00; Sun, 21 Nov 2004 17:45:57 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CVuqb-0006oC-00; Sun, 21 Nov 2004 17:45:57 +0100
Date: Sun, 21 Nov 2004 17:45:57 +0100
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH] Improve o32 syscall handling
Message-ID: <20041121164557.GQ20986@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Hello All,

this is a major cleanup for the o32 syscall handling.
For the 32bit kernel, it
 - uses a more efficient syscall table layout, and reduces its size
 - handles stack arguments also more efficiently, and allows for up
   to 8 arguments. This gives an indirect fadvise64_64 syscall a
   chance to work.
 - Fixes several flaws in the indirect syscall path, like duplicated
   user stack handling, and incomplete argument handling.

For the 64bit Kernel, it
 - checks for unaligned user stack
 - also allows now up to 8 arguments
 - removes unused stackhandling cruft from the indirect syscall path
   and does complete argument handling there.


Thiemo


Index: arch/mips/kernel/scall32-o32.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/scall32-o32.S,v
retrieving revision 1.15
diff -u -p -r1.15 scall32-o32.S
--- arch/mips/kernel/scall32-o32.S	15 Nov 2004 11:49:19 -0000	1.15
+++ arch/mips/kernel/scall32-o32.S	20 Nov 2004 16:46:39 -0000
@@ -5,6 +5,7 @@
  *
  * Copyright (C) 1995, 96, 97, 98, 99, 2000, 01, 02 by Ralf Baechle
  * Copyright (C) 2001 MIPS Technologies, Inc.
+ * Copyright (C) 2004 Thiemo Seufer
  */
 #include <linux/config.h>
 #include <linux/errno.h>
@@ -32,26 +33,30 @@ NESTED(handle_sys, PT_SIZE, sp)
 
 	lw	t1, PT_EPC(sp)		# skip syscall on return
 
+#if defined(CONFIG_BINFMT_IRIX)
 	sltiu	t0, v0, MAX_SYSCALL_NO + 1 # check syscall number
+#else
+	subu	v0, v0, __NR_O32_Linux	# check syscall number
+	sltiu	t0, v0, __NR_O32_Linux_syscalls + 1
+#endif
 	addiu	t1, 4			# skip to next instruction
 	sw	t1, PT_EPC(sp)
 	beqz	t0, illegal_syscall
 
-	/* XXX Put both in one cacheline, should save a bit. */
-	sll	t0, v0, 2
-	lw	t2, sys_call_table(t0)	# syscall routine
-	lbu	t3, sys_narg_table(v0)	# number of arguments
-	beqz	t2, illegal_syscall;
+	sll	t0, v0, 3
+	la	t1, sys_call_table
+	addu	t1, t0
+	lw	t2, (t1)		# syscall routine
+	lw	t3, 4(t1)		# >= 0 if we need stack arguments
+	beqz	t2, illegal_syscall
 
-	subu	t0, t3, 5		# 5 or more arguments?
 	sw	a3, PT_R26(sp)		# save a3 for syscall restarting
-	bgez	t0, stackargs
+	bgez	t3, stackargs
 
 stack_done:
-	sw	a3, PT_R26(sp)          # save for syscall restart
-	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
+	lw	t0, TI_FLAGS($28)	# syscall tracing enabled?
 	li	t1, _TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT
-	and	t0, t1, t0
+	and	t0, t1
 	bnez	t0, syscall_trace_entry	# -> yes
 
 	jalr	t2			# Do The Real Thing (TM)
@@ -70,9 +75,9 @@ o32_syscall_exit:
 	local_irq_disable		# make sure need_resched and
 					# signals dont change between
 					# sampling and return
-	LONG_L	a2, TI_FLAGS($28)	# current->work
+	lw	a2, TI_FLAGS($28)	# current->work
 	li	t0, _TIF_ALLWORK_MASK
-	and	t0, a2, t0
+	and	t0, a2
 	bnez	t0, o32_syscall_exit_work
 
 	j	restore_partial
@@ -117,49 +122,50 @@ syscall_trace_entry:
 	 */
 stackargs:
 	lw	t0, PT_R29(sp)		# get old user stack pointer
-	subu	t3, 4
-	sll	t1, t3, 2		# stack valid?
-
-	addu	t1, t0			# end address
-	or	t0, t1
-	bltz	t0, bad_stack		# -> sp is bad
-
-	lw	t0, PT_R29(sp)		# get old user stack pointer
-	PTR_LA	t1, 4f			# copy 1 to 3 arguments
-	sll	t3, t3, 4
-	subu	t1, t3
-	jr	t1
 
-	/* Ok, copy the args from the luser stack to the kernel stack */
 	/*
-	 * I know Ralf doesn't like nops but this avoids code
-	 * duplication for R3000 targets (and this is the
-	 * only place where ".set reorder" doesn't help).
-	 * Harald.
+	 * We intentionally keep the kernel stack a little below the top of
+	 * userspace so we don't have to do a slower byte accurate check here.
 	 */
+	andi	t1, t0, 7
+	lw	t5, TI_ADDR_LIMIT($28)
+	bnez	t1, bad_stack
+	addu	t4, t0, 32
+	and	t5, t4
+	bltz	t5, bad_stack		# -> sp is bad
+
+	/* Ok, copy the args from the luser stack to the kernel stack.
+	 * t3 is the precomputed number of instruction bytes needed to
+	 * load or store arguments 6-8.
+	 */
+
+	la	t1, 5f			# load up to 3 arguments
+	subu	t1, t3
+1:	lw	t5, 16(t0)		# argument #5 from usp
 	.set    push
 	.set    noreorder
 	.set	nomacro
-1:	lw	t1, 24(t0)		# argument #7 from usp
-	nop
-	sw	t1, 24(sp)
-	nop
-2:	lw	t1, 20(t0)		# argument #5 from usp
-	nop
-	sw	t1, 20(sp)
-	nop
-3:	lw	t1, 16(t0)		# argument #5 from usp
-	nop
-	sw	t1, 16(sp)
-	nop
-4:	.set	pop
+	jr	t1
+	 addiu	t1, 6f - 5f
 
-	j	stack_done		# go back
+2:	lw	t8, 28(t0)		# argument #8 from usp
+3:	lw	t7, 24(t0)		# argument #7 from usp
+4:	lw	t6, 20(t0)		# argument #6 from usp
+5:	jr	t1
+	 sw	t5, 16(sp)		# argument #5 to ksp
+
+	sw	t8, 28(sp)		# argument #8 to ksp
+	sw	t7, 24(sp)		# argument #7 to ksp
+	sw	t6, 20(sp)		# argument #6 to ksp
+6:	j	stack_done		# go back
+	 nop
+	.set	pop
 
 	.section __ex_table,"a"
 	PTR	1b,bad_stack
 	PTR	2b,bad_stack
 	PTR	3b,bad_stack
+	PTR	4b,bad_stack
 	.previous
 
 	/*
@@ -239,12 +245,12 @@ illegal_syscall:
 	sw	v0, PT_R2(sp)		# result
 
 	/* Success, so skip usual error handling garbage.  */
-	LONG_L	a2, TI_FLAGS($28)	# syscall tracing enabled?
+	lw	a2, TI_FLAGS($28)	# syscall tracing enabled?
 	li	t0, _TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT
 	and	t0, a2, t0
 	bnez	t0, 1f
 
-	b	o32_syscall_exit
+	j	o32_syscall_exit
 
 1:	SAVE_STATIC
 	move	a0, sp
@@ -270,67 +276,47 @@ bad_alignment:
 	END(sys_sysmips)
 
 	LEAF(sys_syscall)
-	lw	t0, PT_R29(sp)			# user sp
-
-	sltu	v0, a0, __NR_O32_Linux + __NR_O32_Linux_syscalls + 1
+#if defined(CONFIG_BINFMT_IRIX)
+	sltiu	v0, a0, MAX_SYSCALL_NO + 1 # check syscall number
+#else
+	subu	v0, a0, __NR_O32_Linux	# check syscall number
+	sltiu	v0, v0, __NR_O32_Linux_syscalls + 1
+#endif
 	beqz	v0, enosys
 
-	sll	v0, a0, 2
-	la	v1, sys_syscall
-	lw	t2, sys_call_table(v0)		# function pointer
-	lbu	t4, sys_narg_table(a0)		# number of arguments
-
-	li	v0, -EINVAL
-	beq	t2, v1, out			# do not recurse
+	sll	t0, v0, 3
+	lw	t2, sys_call_table(t0)		# syscall routine
 
+	li	v1, 4000			# nr of sys_syscall
 	beqz	t2, enosys			# null function pointer?
 
-	andi	v0, t0, 0x3			# unaligned stack pointer?
-	bnez	v0, sigsegv
+	li	v0, -EINVAL
+	beq	a0, v1, out			# do not recurse
 
-	addu	v0, t0, 16			# v0 = usp + 16
-	addu	t1, v0, 12			# 3 32-bit arguments
-	lw	v1, TI_ADDR_LIMIT($28)
-	or	v0, v0, t1
-	and	v1, v1, v0
-	bltz	v1, efault
+	/* Some syscalls like execve get their arguments from struct pt_regs
+	   and claim zero arguments in the syscall table. Thus we have to
+	   assume the worst case and shuffle around all potential arguments.
+	   If you want performance, don't use indirect syscalls. */
 
 	move	a0, a1				# shift argument registers
 	move	a1, a2
 	move	a2, a3
-
-1:	lw	a3, 16(t0)
-2:	lw	t3, 20(t0)
-3:	lw	t4, 24(t0)
-
-	.section	__ex_table, "a"
-	.word	1b, efault
-	.word	2b, efault
-	.word	3b, efault
-	.previous
-
-	sw	t3, 16(sp)			# put into new stackframe
-	sw	t4, 20(sp)
-
-	bnez	t4, 1f				# zero arguments?
-	addu	a0, sp, 32			# then pass sp in a0
-1:
-
-	sw	t3, 16(sp)
-	sw	v1, 20(sp)
+	lw	a3, 16(sp)
+	lw	t4, 20(sp)
+	lw	t5, 24(sp)
+	lw	t6, 28(sp)
+	sw	t4, 16(sp)
+	sw	t5, 20(sp)
+	sw	t6, 24(sp)
+	sw	a0, PT_R4(sp)			# .. and push back a0 - a3, some
+	sw	a1, PT_R5(sp)			# syscalls expect them there
+	sw	a2, PT_R6(sp)
+	sw	a3, PT_R7(sp)
+	sw	a3, PT_R26(sp)			# update a3 for syscall restarting
 	jr	t2
 	/* Unreached */
 
 enosys:	li	v0, -ENOSYS
-	b	out
-
-sigsegv:
-	li	a0, _SIGSEGV
-	move	a1, $28
-	jal	force_sig
-	/* Fall through */
-
-efault:	li	v0, -EFAULT
 
 out:	jr	ra
 	END(sys_syscall)
@@ -350,12 +336,14 @@ out:	jr	ra
 	.endm
 
 	.macro	syscalltable
+#if defined(CONFIG_BINFMT_IRIX)
 	mille	sys_ni_syscall		0	/*    0 -  999 SVR4 flavour */
-	#include "irix5sys.h"			/* 1000 - 1999 32-bit IRIX */
+# include "irix5sys.h"				/* 1000 - 1999 32-bit IRIX */
 	mille	sys_ni_syscall		0	/* 2000 - 2999 BSD43 flavour */
 	mille	sys_ni_syscall		0	/* 3000 - 3999 POSIX flavour */
+#endif
 
-	sys	sys_syscall		0	/* 4000 */
+	sys	sys_syscall		8	/* 4000 */
 	sys	sys_exit		1
 	sys	sys_fork		0
 	sys	sys_read		3
@@ -641,19 +629,16 @@ out:	jr	ra
 
 	.endm
 
+	/* We pre-compute the number of _instruction_ bytes needed to
+	   load or store the arguments 6-8. Negative values are ignored. */
+
 	.macro  sys function, nargs
 	PTR	\function
+	LONG	(\nargs << 2) - (5 << 2)
 	.endm
 
 	.align	3
+	.type	sys_call_table,@object
 sys_call_table:
 	syscalltable
 	.size	sys_call_table, . - sys_call_table
-
-	.macro	sys function, nargs
-	.byte	\nargs
-	.endm
-
-sys_narg_table:
-	syscalltable
-	.size	sys_narg_table, . - sys_narg_table
Index: arch/mips/kernel/scall64-o32.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/scall64-o32.S,v
retrieving revision 1.22
diff -u -p -r1.22 scall64-o32.S
--- arch/mips/kernel/scall64-o32.S	15 Nov 2004 11:49:19 -0000	1.22
+++ arch/mips/kernel/scall64-o32.S	20 Nov 2004 16:46:39 -0000
@@ -6,6 +6,7 @@
  * Copyright (C) 1995 - 2000, 2001 by Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  * Copyright (C) 2001 MIPS Technologies, Inc.
+ * Copyright (C) 2004 Thiemo Seufer
  *
  * Hairy, the userspace application uses a different argument passing
  * convention than the kernel, so we have to translate things from o32
@@ -43,6 +44,8 @@ NESTED(handle_sys, PT_SIZE, sp)
  RESTORE_ALL
 #endif
 
+	/* We don't want to stumble over broken sign extensions from
+	   userland. O32 does never use the upper half. */
 	sll	a0, a0, 0
 	sll	a1, a1, 0
 	sll	a2, a2, 0
@@ -62,17 +65,21 @@ NESTED(handle_sys, PT_SIZE, sp)
 	 * userspace so we don't have to do a slower byte accurate check here.
 	 */
 	ld	t0, PT_R29(sp)		# get old user stack pointer
+	andi	t3, t0, 7
+	bnez	t3, bad_stack
 	daddu	t1, t0, 32
 	bltz	t1, bad_stack
 
 1:	lw	a4, 16(t0)		# argument #5 from usp
 2:	lw	a5, 20(t0)		# argument #6 from usp
 3:	lw	a6, 24(t0)		# argument #7 from usp
+4:	lw	a7, 28(t0)		# argument #8 from usp (for indirect syscalls)
 
 	.section __ex_table,"a"
 	PTR	1b, bad_stack
 	PTR	2b, bad_stack
 	PTR	3b, bad_stack
+	PTR	4b, bad_stack
 	.previous
 
 	li	t1, _TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT
@@ -91,7 +98,7 @@ NESTED(handle_sys, PT_SIZE, sp)
 	sd	v0, PT_R0(sp)		# flag for syscall restarting
 1:	sd	v0, PT_R2(sp)		# result
 
-FEXPORT(o32_syscall_exit)
+o32_syscall_exit:
 	local_irq_disable		# make need_resched and
 					# signals dont change between
 					# sampling and return
@@ -109,12 +116,11 @@ o32_syscall_exit_work:
 
 trace_a_syscall:
 	SAVE_STATIC
-	sd	a4, PT_R8(sp)
+	sd	t2, PT_R1(sp)
+	sd	a4, PT_R8(sp)		# Save argument registers
 	sd	a5, PT_R9(sp)
 	sd	a6, PT_R10(sp)
-	sd	a7, PT_R11(sp)
-
-	sd	t2,PT_R1(sp)
+	sd	a7, PT_R11(sp)		# For indirect syscalls
 	move	a0, sp
 	li	a1, 0
 	jal	do_syscall_trace
@@ -126,7 +132,8 @@ trace_a_syscall:
 	ld	a3, PT_R7(sp)
 	ld	a4, PT_R8(sp)
 	ld	a5, PT_R9(sp)
-	ld	a6, PT_R10(sp)		# For indirect syscalls
+	ld	a6, PT_R10(sp)
+	ld	a7, PT_R11(sp)		# For indirect syscalls
 	jalr	t2
 
 	li	t0, -EMAXERRNO - 1	# error?
@@ -174,55 +181,40 @@ illegal_syscall:
 	END(handle_sys)
 
 LEAF(sys32_syscall)
-	ld	t0, PT_R29(sp)		# user sp
-
 	sltu	v0, a0, __NR_O32_Linux + __NR_O32_Linux_syscalls + 1
 	beqz	v0, enosys
 
 	dsll	v0, a0, 3
-	dla	v1, sys32_syscall
 	ld	t2, (sys_call_table - (__NR_O32_Linux * 8))(v0)
 
+	li	v1, 4000		# indirect syscall number
 	li	v0, -EINVAL
-	beq	t2, v1, out		# do not recurse
+	beq	a0, v1, out		# do not recurse
 
 	beqz	t2, enosys		# null function pointer?
 
-	andi	v0, t0, 0x3		# unaligned stack pointer?
-	bnez	v0, sigsegv
-
-	daddiu	v0, t0, 16		# v0 = usp + 16
-	daddu	t1, v0, 12		# 3 32-bit arguments
-	ld	v1, TI_ADDR_LIMIT($28)
-	or	v0, v0, t1
-	and	v1, v1, v0
-	bnez	v1, efault
-
 	move	a0, a1			# shift argument registers
 	move	a1, a2
 	move	a2, a3
 	move	a3, a4
 	move	a4, a5
 	move	a5, a6
+	move	a6, a7
+	sd	a0, PT_R4(sp)		# ... and push back a0 - a3, some
+	sd	a1, PT_R5(sp)		# syscalls expect them there
+	sd	a2, PT_R6(sp)
+	sd	a3, PT_R7(sp)
+	sd	a3, PT_R26(sp)		# update a3 for syscall restarting
 	jr	t2
 	/* Unreached */
 
 enosys:	li	v0, -ENOSYS
-	b	out
-
-sigsegv:
-	li	a0, _SIGSEGV
-	move	a1, $28
-	jal	force_sig
-	/* Fall through */
-
-efault:	li	v0, -EFAULT
 
 out:	jr	ra
 	END(sys32_syscall)
 
 	.align	3
-	.type	sys_call_table,@object;
+	.type	sys_call_table,@object
 sys_call_table:
 	PTR	sys32_syscall			/* 4000 */
 	PTR	sys_exit	
