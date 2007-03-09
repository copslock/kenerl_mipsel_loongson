Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2007 16:20:13 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:27869 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021495AbXCIQUI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2007 16:20:08 +0000
Received: from localhost (p4160-ipad211funabasi.chiba.ocn.ne.jp [58.91.160.160])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 1AFE0BB9A; Sat, 10 Mar 2007 01:18:46 +0900 (JST)
Date:	Sat, 10 Mar 2007 01:18:45 +0900 (JST)
Message-Id: <20070310.011845.85420915.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] rewrite restore_fp_context/save_fp_context
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The setup_sigcontect()/restore_sigcontext() might sleep on
put_user()/get_user() with preemption disabled (i.e. atomic context).
Sleeping in atomic context is not allowed.  This patch fixes this
problem by rewriting restore_fp_context()/save_fp_context().

A path to save fp context was:
	(current.thread.fpu -> ) real FPU -> sigcontext on userstack

And with this patch it is:
	(real FPU -> ) current.thread.fpu -> sigcontext on userstack

While transfer between real FPU and current.thread.fpu can be done by
usual context save/restore routines, all arch/mips/kernel/*_fpu.S,
SMP-variant of {save,restore}_fp_context and SC_ symbols in
asm-offset.h can be removed.

There is an another approach: enabling CpU exception in kernel.  But
that is somewhat tricky and fragile (and add an additional instruction
in resume() code).  This patch is simpler and would not add additional
overhead for most cases.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This is an update of:
http://www.linux-mips.org/archives/linux-mips/2006-08/msg00287.html

This patch depends on:
> Subject: [PATCH] Check FCSR for pending interrupts, alternative version
> Message-Id: <20070310.010348.72708233.anemo@mba.ocn.ne.jp>

This patch conflicts with:
> Subject: [PATCH] Allow CpU exception in kernel partially

 arch/mips/kernel/Makefile           |   36 +++---
 arch/mips/kernel/asm-offsets.c      |   47 --------
 arch/mips/kernel/r2300_fpu.S        |  126 ----------------------
 arch/mips/kernel/r4k_fpu.S          |  188 ----------------------------------
 arch/mips/kernel/r6000_fpu.S        |   87 ---------------
 arch/mips/kernel/signal.c           |   52 +++++++--
 arch/mips/kernel/signal32.c         |   45 +++++---
 arch/mips/kernel/traps.c            |   76 -------------
 arch/mips/math-emu/kernel_linkage.c |   69 ------------
 include/asm-mips/fpu.h              |    9 -
 10 files changed, 90 insertions(+), 645 deletions(-)

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 4924626..8377760 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -14,24 +14,24 @@ binfmt_irix-objs	:= irixelf.o irixinv.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_MODULES)		+= mips_ksyms.o module.o
 
-obj-$(CONFIG_CPU_R3000)		+= r2300_fpu.o r2300_switch.o
-obj-$(CONFIG_CPU_TX39XX)	+= r2300_fpu.o r2300_switch.o
-obj-$(CONFIG_CPU_TX49XX)	+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_R4000)		+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_VR41XX)	+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_R4300)		+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_R4X00)		+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_R5000)		+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_R5432)		+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_R8000)		+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_RM7000)	+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_RM9000)	+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_NEVADA)	+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_R10000)	+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_SB1)		+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_MIPS32)	+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_MIPS64)	+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_R6000)		+= r6000_fpu.o r4k_switch.o
+obj-$(CONFIG_CPU_R3000)		+= r2300_switch.o
+obj-$(CONFIG_CPU_TX39XX)	+= r2300_switch.o
+obj-$(CONFIG_CPU_TX49XX)	+= r4k_switch.o
+obj-$(CONFIG_CPU_R4000)		+= r4k_switch.o
+obj-$(CONFIG_CPU_VR41XX)	+= r4k_switch.o
+obj-$(CONFIG_CPU_R4300)		+= r4k_switch.o
+obj-$(CONFIG_CPU_R4X00)		+= r4k_switch.o
+obj-$(CONFIG_CPU_R5000)		+= r4k_switch.o
+obj-$(CONFIG_CPU_R5432)		+= r4k_switch.o
+obj-$(CONFIG_CPU_R8000)		+= r4k_switch.o
+obj-$(CONFIG_CPU_RM7000)	+= r4k_switch.o
+obj-$(CONFIG_CPU_RM9000)	+= r4k_switch.o
+obj-$(CONFIG_CPU_NEVADA)	+= r4k_switch.o
+obj-$(CONFIG_CPU_R10000)	+= r4k_switch.o
+obj-$(CONFIG_CPU_SB1)		+= r4k_switch.o
+obj-$(CONFIG_CPU_MIPS32)	+= r4k_switch.o
+obj-$(CONFIG_CPU_MIPS64)	+= r4k_switch.o
+obj-$(CONFIG_CPU_R6000)		+= r4k_switch.o
 
 obj-$(CONFIG_SMP)		+= smp.o
 
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 222de46..e312ed8 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -243,53 +243,6 @@ void output_mm_defines(void)
 	linefeed;
 }
 
-#ifdef CONFIG_32BIT
-void output_sc_defines(void)
-{
-	text("/* Linux sigcontext offsets. */");
-	offset("#define SC_REGS       ", struct sigcontext, sc_regs);
-	offset("#define SC_FPREGS     ", struct sigcontext, sc_fpregs);
-	offset("#define SC_ACX        ", struct sigcontext, sc_acx);
-	offset("#define SC_MDHI       ", struct sigcontext, sc_mdhi);
-	offset("#define SC_MDLO       ", struct sigcontext, sc_mdlo);
-	offset("#define SC_PC         ", struct sigcontext, sc_pc);
-	offset("#define SC_FPC_CSR    ", struct sigcontext, sc_fpc_csr);
-	offset("#define SC_FPC_EIR    ", struct sigcontext, sc_fpc_eir);
-	offset("#define SC_HI1        ", struct sigcontext, sc_hi1);
-	offset("#define SC_LO1        ", struct sigcontext, sc_lo1);
-	offset("#define SC_HI2        ", struct sigcontext, sc_hi2);
-	offset("#define SC_LO2        ", struct sigcontext, sc_lo2);
-	offset("#define SC_HI3        ", struct sigcontext, sc_hi3);
-	offset("#define SC_LO3        ", struct sigcontext, sc_lo3);
-	linefeed;
-}
-#endif
-
-#ifdef CONFIG_64BIT
-void output_sc_defines(void)
-{
-	text("/* Linux sigcontext offsets. */");
-	offset("#define SC_REGS       ", struct sigcontext, sc_regs);
-	offset("#define SC_FPREGS     ", struct sigcontext, sc_fpregs);
-	offset("#define SC_MDHI       ", struct sigcontext, sc_mdhi);
-	offset("#define SC_MDLO       ", struct sigcontext, sc_mdlo);
-	offset("#define SC_PC         ", struct sigcontext, sc_pc);
-	offset("#define SC_FPC_CSR    ", struct sigcontext, sc_fpc_csr);
-	linefeed;
-}
-#endif
-
-#ifdef CONFIG_MIPS32_COMPAT
-void output_sc32_defines(void)
-{
-	text("/* Linux 32-bit sigcontext offsets. */");
-	offset("#define SC32_FPREGS     ", struct sigcontext32, sc_fpregs);
-	offset("#define SC32_FPC_CSR    ", struct sigcontext32, sc_fpc_csr);
-	offset("#define SC32_FPC_EIR    ", struct sigcontext32, sc_fpc_eir);
-	linefeed;
-}
-#endif
-
 void output_signal_defined(void)
 {
 	text("/* Linux signal numbers. */");
diff --git a/arch/mips/kernel/r2300_fpu.S b/arch/mips/kernel/r2300_fpu.S
deleted file mode 100644
index ac68e68..0000000
--- a/arch/mips/kernel/r2300_fpu.S
+++ /dev/null
@@ -1,126 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1996, 1998 by Ralf Baechle
- *
- * Multi-arch abstraction and asm macros for easier reading:
- * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
- *
- * Further modifications to make this work:
- * Copyright (c) 1998 Harald Koerfgen
- */
-#include <asm/asm.h>
-#include <asm/errno.h>
-#include <asm/fpregdef.h>
-#include <asm/mipsregs.h>
-#include <asm/asm-offsets.h>
-#include <asm/regdef.h>
-
-#define EX(a,b)							\
-9:	a,##b;							\
-	.section __ex_table,"a";				\
-	PTR	9b,bad_stack;					\
-	.previous
-
-	.set	noreorder
-	.set	mips1
-	/* Save floating point context */
-LEAF(_save_fp_context)
-	li	v0, 0					# assume success
-	cfc1	t1,fcr31
-	EX(swc1	$f0,(SC_FPREGS+0)(a0))
-	EX(swc1	$f1,(SC_FPREGS+8)(a0))
-	EX(swc1	$f2,(SC_FPREGS+16)(a0))
-	EX(swc1	$f3,(SC_FPREGS+24)(a0))
-	EX(swc1	$f4,(SC_FPREGS+32)(a0))
-	EX(swc1	$f5,(SC_FPREGS+40)(a0))
-	EX(swc1	$f6,(SC_FPREGS+48)(a0))
-	EX(swc1	$f7,(SC_FPREGS+56)(a0))
-	EX(swc1	$f8,(SC_FPREGS+64)(a0))
-	EX(swc1	$f9,(SC_FPREGS+72)(a0))
-	EX(swc1	$f10,(SC_FPREGS+80)(a0))
-	EX(swc1	$f11,(SC_FPREGS+88)(a0))
-	EX(swc1	$f12,(SC_FPREGS+96)(a0))
-	EX(swc1	$f13,(SC_FPREGS+104)(a0))
-	EX(swc1	$f14,(SC_FPREGS+112)(a0))
-	EX(swc1	$f15,(SC_FPREGS+120)(a0))
-	EX(swc1	$f16,(SC_FPREGS+128)(a0))
-	EX(swc1	$f17,(SC_FPREGS+136)(a0))
-	EX(swc1	$f18,(SC_FPREGS+144)(a0))
-	EX(swc1	$f19,(SC_FPREGS+152)(a0))
-	EX(swc1	$f20,(SC_FPREGS+160)(a0))
-	EX(swc1	$f21,(SC_FPREGS+168)(a0))
-	EX(swc1	$f22,(SC_FPREGS+176)(a0))
-	EX(swc1	$f23,(SC_FPREGS+184)(a0))
-	EX(swc1	$f24,(SC_FPREGS+192)(a0))
-	EX(swc1	$f25,(SC_FPREGS+200)(a0))
-	EX(swc1	$f26,(SC_FPREGS+208)(a0))
-	EX(swc1	$f27,(SC_FPREGS+216)(a0))
-	EX(swc1	$f28,(SC_FPREGS+224)(a0))
-	EX(swc1	$f29,(SC_FPREGS+232)(a0))
-	EX(swc1	$f30,(SC_FPREGS+240)(a0))
-	EX(swc1	$f31,(SC_FPREGS+248)(a0))
-	EX(sw	t1,(SC_FPC_CSR)(a0))
-	cfc1	t0,$0				# implementation/version
-	jr	ra
-	.set	nomacro
-	 EX(sw	t0,(SC_FPC_EIR)(a0))
-	.set	macro
-	END(_save_fp_context)
-
-/*
- * Restore FPU state:
- *  - fp gp registers
- *  - cp1 status/control register
- *
- * We base the decision which registers to restore from the signal stack
- * frame on the current content of c0_status, not on the content of the
- * stack frame which might have been changed by the user.
- */
-LEAF(_restore_fp_context)
-	li	v0, 0					# assume success
-	EX(lw t0,(SC_FPC_CSR)(a0))
-	EX(lwc1	$f0,(SC_FPREGS+0)(a0))
-	EX(lwc1	$f1,(SC_FPREGS+8)(a0))
-	EX(lwc1	$f2,(SC_FPREGS+16)(a0))
-	EX(lwc1	$f3,(SC_FPREGS+24)(a0))
-	EX(lwc1	$f4,(SC_FPREGS+32)(a0))
-	EX(lwc1	$f5,(SC_FPREGS+40)(a0))
-	EX(lwc1	$f6,(SC_FPREGS+48)(a0))
-	EX(lwc1	$f7,(SC_FPREGS+56)(a0))
-	EX(lwc1	$f8,(SC_FPREGS+64)(a0))
-	EX(lwc1	$f9,(SC_FPREGS+72)(a0))
-	EX(lwc1	$f10,(SC_FPREGS+80)(a0))
-	EX(lwc1	$f11,(SC_FPREGS+88)(a0))
-	EX(lwc1	$f12,(SC_FPREGS+96)(a0))
-	EX(lwc1	$f13,(SC_FPREGS+104)(a0))
-	EX(lwc1	$f14,(SC_FPREGS+112)(a0))
-	EX(lwc1	$f15,(SC_FPREGS+120)(a0))
-	EX(lwc1	$f16,(SC_FPREGS+128)(a0))
-	EX(lwc1	$f17,(SC_FPREGS+136)(a0))
-	EX(lwc1	$f18,(SC_FPREGS+144)(a0))
-	EX(lwc1	$f19,(SC_FPREGS+152)(a0))
-	EX(lwc1	$f20,(SC_FPREGS+160)(a0))
-	EX(lwc1	$f21,(SC_FPREGS+168)(a0))
-	EX(lwc1	$f22,(SC_FPREGS+176)(a0))
-	EX(lwc1	$f23,(SC_FPREGS+184)(a0))
-	EX(lwc1	$f24,(SC_FPREGS+192)(a0))
-	EX(lwc1	$f25,(SC_FPREGS+200)(a0))
-	EX(lwc1	$f26,(SC_FPREGS+208)(a0))
-	EX(lwc1	$f27,(SC_FPREGS+216)(a0))
-	EX(lwc1	$f28,(SC_FPREGS+224)(a0))
-	EX(lwc1	$f29,(SC_FPREGS+232)(a0))
-	EX(lwc1	$f30,(SC_FPREGS+240)(a0))
-	EX(lwc1	$f31,(SC_FPREGS+248)(a0))
-	jr	ra
-	 ctc1	t0,fcr31
-	END(_restore_fp_context)
-	.set	reorder
-
-	.type	fault@function
-	.ent	fault
-fault:	li	v0, -EFAULT
-	jr	ra
-	.end	fault
diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
deleted file mode 100644
index dbd42ad..0000000
--- a/arch/mips/kernel/r4k_fpu.S
+++ /dev/null
@@ -1,188 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1996, 98, 99, 2000, 01 Ralf Baechle
- *
- * Multi-arch abstraction and asm macros for easier reading:
- * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
- *
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 2000 MIPS Technologies, Inc.
- * Copyright (C) 1999, 2001 Silicon Graphics, Inc.
- */
-#include <asm/asm.h>
-#include <asm/errno.h>
-#include <asm/fpregdef.h>
-#include <asm/mipsregs.h>
-#include <asm/asm-offsets.h>
-#include <asm/regdef.h>
-
-	.macro	EX insn, reg, src
-	.set	push
-	.set	nomacro
-.ex\@:	\insn	\reg, \src
-	.set	pop
-	.section __ex_table,"a"
-	PTR	.ex\@, fault
-	.previous
-	.endm
-
-	.set	noreorder
-	.set	mips3
-
-LEAF(_save_fp_context)
-	cfc1	t1, fcr31
-
-#ifdef CONFIG_64BIT
-	/* Store the 16 odd double precision registers */
-	EX	sdc1 $f1, SC_FPREGS+8(a0)
-	EX	sdc1 $f3, SC_FPREGS+24(a0)
-	EX	sdc1 $f5, SC_FPREGS+40(a0)
-	EX	sdc1 $f7, SC_FPREGS+56(a0)
-	EX	sdc1 $f9, SC_FPREGS+72(a0)
-	EX	sdc1 $f11, SC_FPREGS+88(a0)
-	EX	sdc1 $f13, SC_FPREGS+104(a0)
-	EX	sdc1 $f15, SC_FPREGS+120(a0)
-	EX	sdc1 $f17, SC_FPREGS+136(a0)
-	EX	sdc1 $f19, SC_FPREGS+152(a0)
-	EX	sdc1 $f21, SC_FPREGS+168(a0)
-	EX	sdc1 $f23, SC_FPREGS+184(a0)
-	EX	sdc1 $f25, SC_FPREGS+200(a0)
-	EX	sdc1 $f27, SC_FPREGS+216(a0)
-	EX	sdc1 $f29, SC_FPREGS+232(a0)
-	EX	sdc1 $f31, SC_FPREGS+248(a0)
-#endif
-
-	/* Store the 16 even double precision registers */
-	EX	sdc1 $f0, SC_FPREGS+0(a0)
-	EX	sdc1 $f2, SC_FPREGS+16(a0)
-	EX	sdc1 $f4, SC_FPREGS+32(a0)
-	EX	sdc1 $f6, SC_FPREGS+48(a0)
-	EX	sdc1 $f8, SC_FPREGS+64(a0)
-	EX	sdc1 $f10, SC_FPREGS+80(a0)
-	EX	sdc1 $f12, SC_FPREGS+96(a0)
-	EX	sdc1 $f14, SC_FPREGS+112(a0)
-	EX	sdc1 $f16, SC_FPREGS+128(a0)
-	EX	sdc1 $f18, SC_FPREGS+144(a0)
-	EX	sdc1 $f20, SC_FPREGS+160(a0)
-	EX	sdc1 $f22, SC_FPREGS+176(a0)
-	EX	sdc1 $f24, SC_FPREGS+192(a0)
-	EX	sdc1 $f26, SC_FPREGS+208(a0)
-	EX	sdc1 $f28, SC_FPREGS+224(a0)
-	EX	sdc1 $f30, SC_FPREGS+240(a0)
-	EX	sw t1, SC_FPC_CSR(a0)
-	jr	ra
-	 li	v0, 0					# success
-	END(_save_fp_context)
-
-#ifdef CONFIG_MIPS32_COMPAT
-	/* Save 32-bit process floating point context */
-LEAF(_save_fp_context32)
-	cfc1	t1, fcr31
-
-	EX	sdc1 $f0, SC32_FPREGS+0(a0)
-	EX	sdc1 $f2, SC32_FPREGS+16(a0)
-	EX	sdc1 $f4, SC32_FPREGS+32(a0)
-	EX	sdc1 $f6, SC32_FPREGS+48(a0)
-	EX	sdc1 $f8, SC32_FPREGS+64(a0)
-	EX	sdc1 $f10, SC32_FPREGS+80(a0)
-	EX	sdc1 $f12, SC32_FPREGS+96(a0)
-	EX	sdc1 $f14, SC32_FPREGS+112(a0)
-	EX	sdc1 $f16, SC32_FPREGS+128(a0)
-	EX	sdc1 $f18, SC32_FPREGS+144(a0)
-	EX	sdc1 $f20, SC32_FPREGS+160(a0)
-	EX	sdc1 $f22, SC32_FPREGS+176(a0)
-	EX	sdc1 $f24, SC32_FPREGS+192(a0)
-	EX	sdc1 $f26, SC32_FPREGS+208(a0)
-	EX	sdc1 $f28, SC32_FPREGS+224(a0)
-	EX	sdc1 $f30, SC32_FPREGS+240(a0)
-	EX	sw t1, SC32_FPC_CSR(a0)
-	cfc1	t0, $0				# implementation/version
-	EX	sw t0, SC32_FPC_EIR(a0)
-
-	jr	ra
-	 li	v0, 0					# success
-	END(_save_fp_context32)
-#endif
-
-/*
- * Restore FPU state:
- *  - fp gp registers
- *  - cp1 status/control register
- */
-LEAF(_restore_fp_context)
-	EX	lw t0, SC_FPC_CSR(a0)
-#ifdef CONFIG_64BIT
-	EX	ldc1 $f1, SC_FPREGS+8(a0)
-	EX	ldc1 $f3, SC_FPREGS+24(a0)
-	EX	ldc1 $f5, SC_FPREGS+40(a0)
-	EX	ldc1 $f7, SC_FPREGS+56(a0)
-	EX	ldc1 $f9, SC_FPREGS+72(a0)
-	EX	ldc1 $f11, SC_FPREGS+88(a0)
-	EX	ldc1 $f13, SC_FPREGS+104(a0)
-	EX	ldc1 $f15, SC_FPREGS+120(a0)
-	EX	ldc1 $f17, SC_FPREGS+136(a0)
-	EX	ldc1 $f19, SC_FPREGS+152(a0)
-	EX	ldc1 $f21, SC_FPREGS+168(a0)
-	EX	ldc1 $f23, SC_FPREGS+184(a0)
-	EX	ldc1 $f25, SC_FPREGS+200(a0)
-	EX	ldc1 $f27, SC_FPREGS+216(a0)
-	EX	ldc1 $f29, SC_FPREGS+232(a0)
-	EX	ldc1 $f31, SC_FPREGS+248(a0)
-#endif
-	EX	ldc1 $f0, SC_FPREGS+0(a0)
-	EX	ldc1 $f2, SC_FPREGS+16(a0)
-	EX	ldc1 $f4, SC_FPREGS+32(a0)
-	EX	ldc1 $f6, SC_FPREGS+48(a0)
-	EX	ldc1 $f8, SC_FPREGS+64(a0)
-	EX	ldc1 $f10, SC_FPREGS+80(a0)
-	EX	ldc1 $f12, SC_FPREGS+96(a0)
-	EX	ldc1 $f14, SC_FPREGS+112(a0)
-	EX	ldc1 $f16, SC_FPREGS+128(a0)
-	EX	ldc1 $f18, SC_FPREGS+144(a0)
-	EX	ldc1 $f20, SC_FPREGS+160(a0)
-	EX	ldc1 $f22, SC_FPREGS+176(a0)
-	EX	ldc1 $f24, SC_FPREGS+192(a0)
-	EX	ldc1 $f26, SC_FPREGS+208(a0)
-	EX	ldc1 $f28, SC_FPREGS+224(a0)
-	EX	ldc1 $f30, SC_FPREGS+240(a0)
-	ctc1	t0, fcr31
-	jr	ra
-	 li	v0, 0					# success
-	END(_restore_fp_context)
-
-#ifdef CONFIG_MIPS32_COMPAT
-LEAF(_restore_fp_context32)
-	/* Restore an o32 sigcontext.  */
-	EX	lw t0, SC32_FPC_CSR(a0)
-	EX	ldc1 $f0, SC32_FPREGS+0(a0)
-	EX	ldc1 $f2, SC32_FPREGS+16(a0)
-	EX	ldc1 $f4, SC32_FPREGS+32(a0)
-	EX	ldc1 $f6, SC32_FPREGS+48(a0)
-	EX	ldc1 $f8, SC32_FPREGS+64(a0)
-	EX	ldc1 $f10, SC32_FPREGS+80(a0)
-	EX	ldc1 $f12, SC32_FPREGS+96(a0)
-	EX	ldc1 $f14, SC32_FPREGS+112(a0)
-	EX	ldc1 $f16, SC32_FPREGS+128(a0)
-	EX	ldc1 $f18, SC32_FPREGS+144(a0)
-	EX	ldc1 $f20, SC32_FPREGS+160(a0)
-	EX	ldc1 $f22, SC32_FPREGS+176(a0)
-	EX	ldc1 $f24, SC32_FPREGS+192(a0)
-	EX	ldc1 $f26, SC32_FPREGS+208(a0)
-	EX	ldc1 $f28, SC32_FPREGS+224(a0)
-	EX	ldc1 $f30, SC32_FPREGS+240(a0)
-	ctc1	t0, fcr31
-	jr	ra
-	 li	v0, 0					# success
-	END(_restore_fp_context32)
-#endif
-
-	.set	reorder
-
-	.type	fault@function
-	.ent	fault
-fault:	li	v0, -EFAULT				# failure
-	jr	ra
-	.end	fault
diff --git a/arch/mips/kernel/r6000_fpu.S b/arch/mips/kernel/r6000_fpu.S
deleted file mode 100644
index 43cda53..0000000
--- a/arch/mips/kernel/r6000_fpu.S
+++ /dev/null
@@ -1,87 +0,0 @@
-/*
- * r6000_fpu.S: Save/restore floating point context for signal handlers.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1996 by Ralf Baechle
- *
- * Multi-arch abstraction and asm macros for easier reading:
- * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
- */
-#include <asm/asm.h>
-#include <asm/fpregdef.h>
-#include <asm/mipsregs.h>
-#include <asm/asm-offsets.h>
-#include <asm/regdef.h>
-
-	.set	noreorder
-	.set	mips2
-	/* Save floating point context */
-	LEAF(_save_fp_context)
-	mfc0	t0,CP0_STATUS
-	sll	t0,t0,2
-	bgez	t0,1f
-	 nop
-
-	cfc1	t1,fcr31
-	/* Store the 16 double precision registers */
-	sdc1	$f0,(SC_FPREGS+0)(a0)
-	sdc1	$f2,(SC_FPREGS+16)(a0)
-	sdc1	$f4,(SC_FPREGS+32)(a0)
-	sdc1	$f6,(SC_FPREGS+48)(a0)
-	sdc1	$f8,(SC_FPREGS+64)(a0)
-	sdc1	$f10,(SC_FPREGS+80)(a0)
-	sdc1	$f12,(SC_FPREGS+96)(a0)
-	sdc1	$f14,(SC_FPREGS+112)(a0)
-	sdc1	$f16,(SC_FPREGS+128)(a0)
-	sdc1	$f18,(SC_FPREGS+144)(a0)
-	sdc1	$f20,(SC_FPREGS+160)(a0)
-	sdc1	$f22,(SC_FPREGS+176)(a0)
-	sdc1	$f24,(SC_FPREGS+192)(a0)
-	sdc1	$f26,(SC_FPREGS+208)(a0)
-	sdc1	$f28,(SC_FPREGS+224)(a0)
-	sdc1	$f30,(SC_FPREGS+240)(a0)
-	jr	ra
-	 sw	t0,SC_FPC_CSR(a0)
-1:	jr	ra
-	 nop
-	END(_save_fp_context)
-
-/* Restore FPU state:
- *  - fp gp registers
- *  - cp1 status/control register
- *
- * We base the decision which registers to restore from the signal stack
- * frame on the current content of c0_status, not on the content of the
- * stack frame which might have been changed by the user.
- */
-	LEAF(_restore_fp_context)
-	mfc0	t0,CP0_STATUS
-	sll	t0,t0,2
-
-	bgez	t0,1f
-	 lw	t0,SC_FPC_CSR(a0)
-	/* Restore the 16 double precision registers */
-	ldc1	$f0,(SC_FPREGS+0)(a0)
-	ldc1	$f2,(SC_FPREGS+16)(a0)
-	ldc1	$f4,(SC_FPREGS+32)(a0)
-	ldc1	$f6,(SC_FPREGS+48)(a0)
-	ldc1	$f8,(SC_FPREGS+64)(a0)
-	ldc1	$f10,(SC_FPREGS+80)(a0)
-	ldc1	$f12,(SC_FPREGS+96)(a0)
-	ldc1	$f14,(SC_FPREGS+112)(a0)
-	ldc1	$f16,(SC_FPREGS+128)(a0)
-	ldc1	$f18,(SC_FPREGS+144)(a0)
-	ldc1	$f20,(SC_FPREGS+160)(a0)
-	ldc1	$f22,(SC_FPREGS+176)(a0)
-	ldc1	$f24,(SC_FPREGS+192)(a0)
-	ldc1	$f26,(SC_FPREGS+208)(a0)
-	ldc1	$f28,(SC_FPREGS+224)(a0)
-	ldc1	$f30,(SC_FPREGS+240)(a0)
-	jr	ra
-	 ctc1	t0,fcr31
-1:	jr	ra
-	 nop
-	END(_restore_fp_context)
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index bf094fc..d2e6c50 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -78,6 +78,38 @@ struct rt_sigframe {
 /*
  * Helper routines
  */
+static int save_fp_context(struct sigcontext __user *sc)
+{
+	int i;
+	int err = 0;
+
+	for (i = 0; i < 32; i++) {
+		err |=
+		    __put_user(current->thread.fpu.fpr[i], &sc->sc_fpregs[i]);
+#ifdef CONFIG_32BIT
+		i++;	/* skip odd registers */
+#endif
+	}
+	err |= __put_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
+	return err;
+}
+
+static int restore_fp_context(struct sigcontext __user *sc)
+{
+	int i;
+	int err = 0;
+
+	for (i = 0; i < 32; i++) {
+		err |=
+		    __get_user(current->thread.fpu.fpr[i], &sc->sc_fpregs[i]);
+#ifdef CONFIG_32BIT
+		i++;	/* skip odd registers */
+#endif
+	}
+	err |= __get_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
+	return err;
+}
+
 int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 {
 	int err = 0;
@@ -112,14 +144,13 @@ int setup_sigcontext(struct pt_regs *reg
 		 * will "inherit" current FPU state.
 		 */
 		preempt_disable();
-
-		if (!is_fpu_owner()) {
-			own_fpu();
-			restore_fp(current);
+		if (is_fpu_owner()) {
+			/* save current context to task_struct */
+			save_fp(current);
+			lose_fpu();
 		}
-		err |= save_fp_context(sc);
-
 		preempt_enable();
+		err |= save_fp_context(sc);
 	}
 	return err;
 }
@@ -188,20 +219,17 @@ int restore_sigcontext(struct pt_regs *r
 	err |= __get_user(used_math, &sc->sc_used_math);
 	conditional_used_math(used_math);
 
+	/* signal handler may have used FPU.  Give it up. */
 	preempt_disable();
+	lose_fpu();
+	preempt_enable();
 
 	if (used_math()) {
 		/* restore fpu context if we have used it before */
-		own_fpu();
 		if (!err)
 			err = check_and_restore_fp_context(sc);
-	} else {
-		/* signal handler may have used FPU.  Give it up. */
-		lose_fpu();
 	}
 
-	preempt_enable();
-
 	return err;
 }
 
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 20013b6..f966fc4 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -176,6 +176,30 @@ struct rt_sigframe32 {
 /*
  * sigcontext handlers
  */
+static int save_fp_context32(struct sigcontext32 __user *sc)
+{
+	int i;
+	int err = 0;
+
+	for (i = 0; i < 32; i += 2)
+		err |=
+		    __put_user(current->thread.fpu.fpr[i], &sc->sc_fpregs[i]);
+	err |= __put_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
+	return err;
+}
+
+static int restore_fp_context32(struct sigcontext32 __user *sc)
+{
+	int i;
+	int err = 0;
+
+	for (i = 0; i < 32; i += 2)
+		err |=
+		    __get_user(current->thread.fpu.fpr[i], &sc->sc_fpregs[i]);
+	err |= __get_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
+	return err;
+}
+
 static int setup_sigcontext32(struct pt_regs *regs,
 			      struct sigcontext32 __user *sc)
 {
@@ -208,14 +232,13 @@ static int setup_sigcontext32(struct pt_
 		 * will "inherit" current FPU state.
 		 */
 		preempt_disable();
-
-		if (!is_fpu_owner()) {
-			own_fpu();
-			restore_fp(current);
+		if (is_fpu_owner()) {
+			/* save current context to task_struct */
+			save_fp(current);
+			lose_fpu();
 		}
-		err |= save_fp_context32(sc);
-
 		preempt_enable();
+		err |= save_fp_context32(sc);
 	}
 	return err;
 }
@@ -262,20 +285,16 @@ static int restore_sigcontext32(struct p
 	err |= __get_user(used_math, &sc->sc_used_math);
 	conditional_used_math(used_math);
 
+	/* signal handler may have used FPU.  Give it up. */
 	preempt_disable();
+	lose_fpu();
+	preempt_enable();
 
 	if (used_math()) {
 		/* restore fpu context if we have used it before */
-		own_fpu();
 		if (!err)
 			err = check_and_restore_fp_context32(sc);
-	} else {
-		/* signal handler may have used FPU.  Give it up. */
-		lose_fpu();
 	}
-
-	preempt_enable();
-
 	return err;
 }
 
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 18f56a9..b691786 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1256,77 +1256,6 @@ static inline void mips_srs_init(void)
 
 #endif /* CONFIG_CPU_MIPSR2_SRS */
 
-/*
- * This is used by native signal handling
- */
-asmlinkage int (*save_fp_context)(struct sigcontext *sc);
-asmlinkage int (*restore_fp_context)(struct sigcontext *sc);
-
-extern asmlinkage int _save_fp_context(struct sigcontext *sc);
-extern asmlinkage int _restore_fp_context(struct sigcontext *sc);
-
-extern asmlinkage int fpu_emulator_save_context(struct sigcontext *sc);
-extern asmlinkage int fpu_emulator_restore_context(struct sigcontext *sc);
-
-#ifdef CONFIG_SMP
-static int smp_save_fp_context(struct sigcontext *sc)
-{
-	return cpu_has_fpu
-	       ? _save_fp_context(sc)
-	       : fpu_emulator_save_context(sc);
-}
-
-static int smp_restore_fp_context(struct sigcontext *sc)
-{
-	return cpu_has_fpu
-	       ? _restore_fp_context(sc)
-	       : fpu_emulator_restore_context(sc);
-}
-#endif
-
-static inline void signal_init(void)
-{
-#ifdef CONFIG_SMP
-	/* For now just do the cpu_has_fpu check when the functions are invoked */
-	save_fp_context = smp_save_fp_context;
-	restore_fp_context = smp_restore_fp_context;
-#else
-	if (cpu_has_fpu) {
-		save_fp_context = _save_fp_context;
-		restore_fp_context = _restore_fp_context;
-	} else {
-		save_fp_context = fpu_emulator_save_context;
-		restore_fp_context = fpu_emulator_restore_context;
-	}
-#endif
-}
-
-#ifdef CONFIG_MIPS32_COMPAT
-
-/*
- * This is used by 32-bit signal stuff on the 64-bit kernel
- */
-asmlinkage int (*save_fp_context32)(struct sigcontext32 *sc);
-asmlinkage int (*restore_fp_context32)(struct sigcontext32 *sc);
-
-extern asmlinkage int _save_fp_context32(struct sigcontext32 *sc);
-extern asmlinkage int _restore_fp_context32(struct sigcontext32 *sc);
-
-extern asmlinkage int fpu_emulator_save_context32(struct sigcontext32 *sc);
-extern asmlinkage int fpu_emulator_restore_context32(struct sigcontext32 *sc);
-
-static inline void signal32_init(void)
-{
-	if (cpu_has_fpu) {
-		save_fp_context32 = _save_fp_context32;
-		restore_fp_context32 = _restore_fp_context32;
-	} else {
-		save_fp_context32 = fpu_emulator_save_context32;
-		restore_fp_context32 = fpu_emulator_restore_context32;
-	}
-}
-#endif
-
 extern void cpu_cache_init(void);
 extern void tlb_init(void);
 extern void flush_tlb_handlers(void);
@@ -1568,11 +1497,6 @@ void __init trap_init(void)
 	else
 		memcpy((void *)(CAC_BASE + 0x080), &except_vec3_generic, 0x80);
 
-	signal_init();
-#ifdef CONFIG_MIPS32_COMPAT
-	signal32_init();
-#endif
-
 	flush_icache_range(ebase, ebase + 0x400);
 	flush_tlb_handlers();
 }
diff --git a/arch/mips/math-emu/kernel_linkage.c b/arch/mips/math-emu/kernel_linkage.c
index 5b3390f..4408848 100644
--- a/arch/mips/math-emu/kernel_linkage.c
+++ b/arch/mips/math-emu/kernel_linkage.c
@@ -43,72 +43,3 @@ void fpu_emulator_init_fpu(void)
 		current->thread.fpu.fpr[i] = SIGNALLING_NAN;
 	}
 }
-
-
-/*
- * Emulator context save/restore to/from a signal context
- * presumed to be on the user stack, and therefore accessed
- * with appropriate macros from uaccess.h
- */
-
-int fpu_emulator_save_context(struct sigcontext *sc)
-{
-	int i;
-	int err = 0;
-
-	for (i = 0; i < 32; i++) {
-		err |=
-		    __put_user(current->thread.fpu.fpr[i], &sc->sc_fpregs[i]);
-	}
-	err |= __put_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
-
-	return err;
-}
-
-int fpu_emulator_restore_context(struct sigcontext *sc)
-{
-	int i;
-	int err = 0;
-
-	for (i = 0; i < 32; i++) {
-		err |=
-		    __get_user(current->thread.fpu.fpr[i], &sc->sc_fpregs[i]);
-	}
-	err |= __get_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
-
-	return err;
-}
-
-#ifdef CONFIG_64BIT
-/*
- * This is the o32 version
- */
-
-int fpu_emulator_save_context32(struct sigcontext32 *sc)
-{
-	int i;
-	int err = 0;
-
-	for (i = 0; i < 32; i+=2) {
-		err |=
-		    __put_user(current->thread.fpu.fpr[i], &sc->sc_fpregs[i]);
-	}
-	err |= __put_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
-
-	return err;
-}
-
-int fpu_emulator_restore_context32(struct sigcontext32 *sc)
-{
-	int i;
-	int err = 0;
-
-	for (i = 0; i < 32; i+=2) {
-		err |=
-		    __get_user(current->thread.fpu.fpr[i], &sc->sc_fpregs[i]);
-	}
-	err |= __get_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
-
-	return err;
-}
-#endif
diff --git a/include/asm-mips/fpu.h b/include/asm-mips/fpu.h
index efef843..979839c 100644
--- a/include/asm-mips/fpu.h
+++ b/include/asm-mips/fpu.h
@@ -24,15 +24,6 @@
 #include <asm/mips_mt.h>
 #endif
 
-struct sigcontext;
-struct sigcontext32;
-
-extern asmlinkage int (*save_fp_context)(struct sigcontext *sc);
-extern asmlinkage int (*restore_fp_context)(struct sigcontext *sc);
-
-extern asmlinkage int (*save_fp_context32)(struct sigcontext32 *sc);
-extern asmlinkage int (*restore_fp_context32)(struct sigcontext32 *sc);
-
 extern void fpu_emulator_init_fpu(void);
 extern void _init_fpu(void);
 extern void _save_fp(struct task_struct *);
