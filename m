Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Feb 2018 15:44:24 +0100 (CET)
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:45228 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992781AbeBQOoOKRw1C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Feb 2018 15:44:14 +0100
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id C8ABA3F4B8;
        Sat, 17 Feb 2018 15:44:10 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fIsw6J1yQNQF; Sat, 17 Feb 2018 15:44:01 +0100 (CET)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 177273F275;
        Sat, 17 Feb 2018 15:43:51 +0100 (CET)
Date:   Sat, 17 Feb 2018 15:43:49 +0100
From:   Fredrik Noring <noring@nocrew.org>
To:     =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>
Cc:     "Maciej W. Rozycki" <macro@mips.com>, linux-mips@linux-mips.org
Subject: [RFC] MIPS: R5900: Workaround for saving and restoring FPU registers
Message-ID: <20180217144346.GC2496@localhost.localdomain>
References: <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk>
 <20170927172107.GB2631@localhost.localdomain>
 <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk>
 <20170930065654.GA7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171029172016.GA2600@localhost.localdomain>
 <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk>
 <20171111160422.GA2332@localhost.localdomain>
 <20180129202715.GA4817@localhost.localdomain>
 <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Jürgen,

Would you be able to elaborate on the following change with a workaround for
saving and restoring R5900 FPU registers? Is this problem documented in your
copy of Sony's Linux Toolkit Restriction manual?
    
    Fixed saving and restoring of FPU registers. Odd FPU registers were
    lost on exceptions and when simulating 64 bit FPU. Debian 5.0 mipsel
    uses MOV.D to move FPU registers. This is not supported by R5900 and
    failed in the simulation because of the bug above.

Fredrik

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 8d1e30b94c2d..a67ef7964bc1 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -141,6 +141,52 @@
 	.set	pop
 	.endm
 
+#ifdef CONFIG_CPU_R5900
+	/*
+	 * Kernel expects that floating point registers are saved as 64-bit
+	 * with the sdc1 instruction, but this is not working with R5900.
+	 * The 64-bit write is simulated as two 32-bit writes.
+	 */
+	.macro fpu_save_double thread status tmp1=t0
+	.set push
+	SET_HARDFLOAT
+	cfc1	\tmp1,  fcr31
+	swc1	$f0,  THREAD_FPR0(\thread)
+	swc1	$f1,  (THREAD_FPR0 + 4)(\thread)
+	swc1	$f2,  THREAD_FPR2(\thread)
+	swc1	$f3,  (THREAD_FPR2 + 4)(\thread)
+	swc1	$f4,  THREAD_FPR4(\thread)
+	swc1	$f5,  (THREAD_FPR4 + 4)(\thread)
+	swc1	$f6,  THREAD_FPR6(\thread)
+	swc1	$f7,  (THREAD_FPR6 + 4)(\thread)
+	swc1	$f8,  THREAD_FPR8(\thread)
+	swc1	$f9,  (THREAD_FPR8 + 4)(\thread)
+	swc1	$f10, THREAD_FPR10(\thread)
+	swc1	$f11, (THREAD_FPR10 + 4)(\thread)
+	swc1	$f12, THREAD_FPR12(\thread)
+	swc1	$f13, (THREAD_FPR12 + 4)(\thread)
+	swc1	$f14, THREAD_FPR14(\thread)
+	swc1	$f15, (THREAD_FPR14 + 4)(\thread)
+	swc1	$f16, THREAD_FPR16(\thread)
+	swc1	$f17, (THREAD_FPR16 + 4)(\thread)
+	swc1	$f18, THREAD_FPR18(\thread)
+	swc1	$f19, (THREAD_FPR18 + 4)(\thread)
+	swc1	$f20, THREAD_FPR20(\thread)
+	swc1	$f21, (THREAD_FPR20 + 4)(\thread)
+	swc1	$f22, THREAD_FPR22(\thread)
+	swc1	$f23, (THREAD_FPR22 + 4)(\thread)
+	swc1	$f24, THREAD_FPR24(\thread)
+	swc1	$f25, (THREAD_FPR24 + 4)(\thread)
+	swc1	$f26, THREAD_FPR26(\thread)
+	swc1	$f27, (THREAD_FPR26 + 4)(\thread)
+	swc1	$f28, THREAD_FPR28(\thread)
+	swc1	$f29, (THREAD_FPR28 + 4)(\thread)
+	swc1	$f30, THREAD_FPR30(\thread)
+	swc1	$f31, (THREAD_FPR30 + 4)(\thread)
+	sw	\tmp1, THREAD_FCR31(\thread)
+	.set pop
+	.endm
+#else
 	.macro	fpu_save_double thread status tmp
 #if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPSR2) || \
 		defined(CONFIG_CPU_MIPSR6)
@@ -151,6 +197,7 @@
 #endif
 	fpu_save_16even \thread \tmp
 	.endm
+#endif
 
 	.macro	fpu_restore_16even thread tmp=t0
 	.set	push
@@ -200,6 +247,52 @@
 	.set	pop
 	.endm
 
+#ifdef CONFIG_CPU_R5900
+	/*
+	 * Kernel expects that floating point registers are read as 64-bit
+	 * with the ldc1 instruction, but this is not working with R5900.
+	 * The 64-bit read is simulated as two 32-bit reads.
+	 */
+	.macro	fpu_restore_double thread status tmp=t0
+	.set push
+	SET_HARDFLOAT
+	lw	\tmp, THREAD_FCR31(\thread)
+	lwc1	$f0,  THREAD_FPR0(\thread)
+	lwc1	$f1,  (THREAD_FPR0 + 4)(\thread)
+	lwc1	$f2,  THREAD_FPR2(\thread)
+	lwc1	$f3,  (THREAD_FPR2 + 4)(\thread)
+	lwc1	$f4,  THREAD_FPR4(\thread)
+	lwc1	$f5,  (THREAD_FPR4 + 4)(\thread)
+	lwc1	$f6,  THREAD_FPR6(\thread)
+	lwc1	$f7,  (THREAD_FPR6 + 4)(\thread)
+	lwc1	$f8,  THREAD_FPR8(\thread)
+	lwc1	$f9,  (THREAD_FPR8 + 4)(\thread)
+	lwc1	$f10, THREAD_FPR10(\thread)
+	lwc1	$f11, (THREAD_FPR10 + 4)(\thread)
+	lwc1	$f12, THREAD_FPR12(\thread)
+	lwc1	$f13, (THREAD_FPR12 + 4)(\thread)
+	lwc1	$f14, THREAD_FPR14(\thread)
+	lwc1	$f15, (THREAD_FPR14 + 4)(\thread)
+	lwc1	$f16, THREAD_FPR16(\thread)
+	lwc1	$f17, (THREAD_FPR16 + 4)(\thread)
+	lwc1	$f18, THREAD_FPR18(\thread)
+	lwc1	$f19, (THREAD_FPR18 + 4)(\thread)
+	lwc1	$f20, THREAD_FPR20(\thread)
+	lwc1	$f21, (THREAD_FPR20 + 4)(\thread)
+	lwc1	$f22, THREAD_FPR22(\thread)
+	lwc1	$f23, (THREAD_FPR22 + 4)(\thread)
+	lwc1	$f24, THREAD_FPR24(\thread)
+	lwc1	$f25, (THREAD_FPR24 + 4)(\thread)
+	lwc1	$f26, THREAD_FPR26(\thread)
+	lwc1	$f27, (THREAD_FPR26 + 4)(\thread)
+	lwc1	$f28, THREAD_FPR28(\thread)
+	lwc1	$f29, (THREAD_FPR28 + 4)(\thread)
+	lwc1	$f30, THREAD_FPR30(\thread)
+	lwc1	$f31, (THREAD_FPR30 + 4)(\thread)
+	ctc1	\tmp, fcr31
+	.set	pop
+	.endm
+#else
 	.macro	fpu_restore_double thread status tmp
 #if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPSR2) || \
 		defined(CONFIG_CPU_MIPSR6)
@@ -211,6 +304,7 @@
 #endif
 	fpu_restore_16even \thread \tmp
 	.endm
+#endif
 
 #if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	.macro	_EXT	rd, rs, p, s
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index f10e1e15e1c6..bf192fc9957a 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -44,6 +44,7 @@ obj-y				+= $(sw-y)
 
 obj-$(CONFIG_CPU_R4K_FPU)	+= r4k_fpu.o
 obj-$(CONFIG_CPU_R3000)		+= r2300_fpu.o
+obj-$(CONFIG_CPU_R5900)		+= r5900_fpu.o
 obj-$(CONFIG_CPU_TX39XX)	+= r2300_fpu.o
 
 obj-$(CONFIG_SMP)		+= smp.o
diff --git a/arch/mips/kernel/r5900_fpu.S b/arch/mips/kernel/r5900_fpu.S
new file mode 100644
index 000000000000..d4fdc823444d
--- /dev/null
+++ b/arch/mips/kernel/r5900_fpu.S
@@ -0,0 +1,389 @@
+/*
+ * FPU handling on MIPS r5900. Copied from r4k_fpu.c.
+ *
+ * Copyright (C) 2010-2013 Jürgen Urban
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <asm/asm.h>
+#include <asm/asmmacro.h>
+#include <asm/errno.h>
+#include <asm/fpregdef.h>
+#include <asm/mipsregs.h>
+#include <asm/asm-offsets.h>
+#include <asm/regdef.h>
+
+	.macro	EX insn, reg, src
+	.set	push
+	SET_HARDFLOAT
+	.set	nomacro
+	/* In an error exception handler the user space could be uncached. */
+	sync.l
+.ex\@:	\insn	\reg, \src
+	.set	pop
+	.section __ex_table,"a"
+	PTR	.ex\@, fault
+	.previous
+	.endm
+
+	.set	noreorder
+	.set	arch=r5900
+
+/*
+ * Save a thread's fp context.
+ */
+LEAF(_save_fp)
+	fpu_save_double a0 t0 t1		# clobbers t1
+	jr	ra
+	END(_save_fp)
+
+/*
+ * Restore a thread's fp context.
+ */
+LEAF(_restore_fp)
+	fpu_restore_double a0 t0 t1		# clobbers t1
+	jr	ra
+	END(_restore_fp)
+
+LEAF(_save_fp_context)
+	.set	push
+	SET_HARDFLOAT
+	cfc1	t1, fcr31
+	.set	pop
+
+	/* Store the 32 32-bit registers */
+	EX	swc1 $f0, SC_FPREGS+0(a0)
+	EX	swc1 $f1, SC_FPREGS+4(a0)
+	EX	swc1 $f2, SC_FPREGS+16(a0)
+	EX	swc1 $f3, SC_FPREGS+20(a0)
+	EX	swc1 $f4, SC_FPREGS+32(a0)
+	EX	swc1 $f5, SC_FPREGS+36(a0)
+	EX	swc1 $f6, SC_FPREGS+48(a0)
+	EX	swc1 $f7, SC_FPREGS+52(a0)
+	EX	swc1 $f8, SC_FPREGS+64(a0)
+	EX	swc1 $f9, SC_FPREGS+68(a0)
+	EX	swc1 $f10, SC_FPREGS+80(a0)
+	EX	swc1 $f11, SC_FPREGS+84(a0)
+	EX	swc1 $f12, SC_FPREGS+96(a0)
+	EX	swc1 $f13, SC_FPREGS+100(a0)
+	EX	swc1 $f14, SC_FPREGS+112(a0)
+	EX	swc1 $f15, SC_FPREGS+116(a0)
+	EX	swc1 $f16, SC_FPREGS+128(a0)
+	EX	swc1 $f17, SC_FPREGS+132(a0)
+	EX	swc1 $f18, SC_FPREGS+144(a0)
+	EX	swc1 $f19, SC_FPREGS+148(a0)
+	EX	swc1 $f20, SC_FPREGS+160(a0)
+	EX	swc1 $f21, SC_FPREGS+164(a0)
+	EX	swc1 $f22, SC_FPREGS+176(a0)
+	EX	swc1 $f23, SC_FPREGS+180(a0)
+	EX	swc1 $f24, SC_FPREGS+192(a0)
+	EX	swc1 $f25, SC_FPREGS+196(a0)
+	EX	swc1 $f26, SC_FPREGS+208(a0)
+	EX	swc1 $f27, SC_FPREGS+212(a0)
+	EX	swc1 $f28, SC_FPREGS+224(a0)
+	EX	swc1 $f29, SC_FPREGS+228(a0)
+	EX	swc1 $f30, SC_FPREGS+240(a0)
+	EX	swc1 $f31, SC_FPREGS+244(a0)
+	EX	sw t1, SC_FPC_CSR(a0)
+	jr	ra
+	 li	v0, 0					# success
+	END(_save_fp_context)
+
+#ifdef CONFIG_MIPS32_COMPAT
+	/* Save 32-bit process floating point context */
+LEAF(_save_fp_context32)
+	.set	push
+	SET_HARDFLOAT
+	cfc1	t1, fcr31
+	.set	pop
+
+	EX	swc1 $f0, SC32_FPREGS+0(a0)
+	EX	swc1 $f1, SC32_FPREGS+4(a0)
+	EX	swc1 $f2, SC32_FPREGS+16(a0)
+	EX	swc1 $f3, SC32_FPREGS+20(a0)
+	EX	swc1 $f4, SC32_FPREGS+32(a0)
+	EX	swc1 $f5, SC32_FPREGS+36(a0)
+	EX	swc1 $f6, SC32_FPREGS+48(a0)
+	EX	swc1 $f7, SC32_FPREGS+52(a0)
+	EX	swc1 $f8, SC32_FPREGS+64(a0)
+	EX	swc1 $f9, SC32_FPREGS+68(a0)
+	EX	swc1 $f10, SC32_FPREGS+80(a0)
+	EX	swc1 $f11, SC32_FPREGS+84(a0)
+	EX	swc1 $f12, SC32_FPREGS+96(a0)
+	EX	swc1 $f13, SC32_FPREGS+100(a0)
+	EX	swc1 $f14, SC32_FPREGS+112(a0)
+	EX	swc1 $f15, SC32_FPREGS+116(a0)
+	EX	swc1 $f16, SC32_FPREGS+128(a0)
+	EX	swc1 $f17, SC32_FPREGS+132(a0)
+	EX	swc1 $f18, SC32_FPREGS+144(a0)
+	EX	swc1 $f19, SC32_FPREGS+148(a0)
+	EX	swc1 $f20, SC32_FPREGS+160(a0)
+	EX	swc1 $f21, SC32_FPREGS+164(a0)
+	EX	swc1 $f22, SC32_FPREGS+176(a0)
+	EX	swc1 $f23, SC32_FPREGS+180(a0)
+	EX	swc1 $f24, SC32_FPREGS+192(a0)
+	EX	swc1 $f25, SC32_FPREGS+196(a0)
+	EX	swc1 $f26, SC32_FPREGS+208(a0)
+	EX	swc1 $f27, SC32_FPREGS+212(a0)
+	EX	swc1 $f28, SC32_FPREGS+224(a0)
+	EX	swc1 $f29, SC32_FPREGS+228(a0)
+	EX	swc1 $f30, SC32_FPREGS+240(a0)
+	EX	swc1 $f31, SC32_FPREGS+244(a0)
+	EX	sw t1, SC32_FPC_CSR(a0)
+	cfc1	t0, $0				# implementation/version
+	EX	sw t0, SC32_FPC_EIR(a0)
+
+	jr	ra
+	 li	v0, 0					# success
+	END(_save_fp_context32)
+#endif
+
+/*
+ * Restore FPU state:
+ *  - fp gp registers
+ *  - cp1 status/control register
+ */
+LEAF(_restore_fp_context)
+	EX	lw t0, SC_FPC_CSR(a0)
+	EX	lwc1 $f0, SC_FPREGS+0(a0)
+	EX	lwc1 $f1, SC_FPREGS+4(a0)
+	EX	lwc1 $f2, SC_FPREGS+16(a0)
+	EX	lwc1 $f3, SC_FPREGS+20(a0)
+	EX	lwc1 $f4, SC_FPREGS+32(a0)
+	EX	lwc1 $f5, SC_FPREGS+36(a0)
+	EX	lwc1 $f6, SC_FPREGS+48(a0)
+	EX	lwc1 $f7, SC_FPREGS+52(a0)
+	EX	lwc1 $f8, SC_FPREGS+64(a0)
+	EX	lwc1 $f9, SC_FPREGS+68(a0)
+	EX	lwc1 $f10, SC_FPREGS+80(a0)
+	EX	lwc1 $f11, SC_FPREGS+84(a0)
+	EX	lwc1 $f12, SC_FPREGS+96(a0)
+	EX	lwc1 $f13, SC_FPREGS+100(a0)
+	EX	lwc1 $f14, SC_FPREGS+112(a0)
+	EX	lwc1 $f15, SC_FPREGS+116(a0)
+	EX	lwc1 $f16, SC_FPREGS+128(a0)
+	EX	lwc1 $f17, SC_FPREGS+132(a0)
+	EX	lwc1 $f18, SC_FPREGS+144(a0)
+	EX	lwc1 $f19, SC_FPREGS+148(a0)
+	EX	lwc1 $f20, SC_FPREGS+160(a0)
+	EX	lwc1 $f21, SC_FPREGS+164(a0)
+	EX	lwc1 $f22, SC_FPREGS+176(a0)
+	EX	lwc1 $f23, SC_FPREGS+180(a0)
+	EX	lwc1 $f24, SC_FPREGS+192(a0)
+	EX	lwc1 $f25, SC_FPREGS+196(a0)
+	EX	lwc1 $f26, SC_FPREGS+208(a0)
+	EX	lwc1 $f27, SC_FPREGS+212(a0)
+	EX	lwc1 $f28, SC_FPREGS+224(a0)
+	EX	lwc1 $f29, SC_FPREGS+228(a0)
+	EX	lwc1 $f30, SC_FPREGS+240(a0)
+	EX	lwc1 $f31, SC_FPREGS+244(a0)
+	.set	push
+	SET_HARDFLOAT
+	ctc1	t0, fcr31
+	.set	pop
+	jr	ra
+	 li	v0, 0					# success
+	END(_restore_fp_context)
+
+#ifdef CONFIG_MIPS32_COMPAT
+LEAF(_restore_fp_context32)
+	/* Restore an o32 sigcontext.  */
+	EX	lw t0, SC32_FPC_CSR(a0)
+	EX	lwc1 $f0, SC32_FPREGS+0(a0)
+	EX	lwc1 $f1, SC32_FPREGS+4(a0)
+	EX	lwc1 $f2, SC32_FPREGS+16(a0)
+	EX	lwc1 $f3, SC32_FPREGS+20(a0)
+	EX	lwc1 $f4, SC32_FPREGS+32(a0)
+	EX	lwc1 $f5, SC32_FPREGS+36(a0)
+	EX	lwc1 $f6, SC32_FPREGS+48(a0)
+	EX	lwc1 $f7, SC32_FPREGS+52(a0)
+	EX	lwc1 $f8, SC32_FPREGS+64(a0)
+	EX	lwc1 $f9, SC32_FPREGS+68(a0)
+	EX	lwc1 $f10, SC32_FPREGS+80(a0)
+	EX	lwc1 $f11, SC32_FPREGS+84(a0)
+	EX	lwc1 $f12, SC32_FPREGS+96(a0)
+	EX	lwc1 $f13, SC32_FPREGS+100(a0)
+	EX	lwc1 $f14, SC32_FPREGS+112(a0)
+	EX	lwc1 $f15, SC32_FPREGS+116(a0)
+	EX	lwc1 $f16, SC32_FPREGS+128(a0)
+	EX	lwc1 $f17, SC32_FPREGS+132(a0)
+	EX	lwc1 $f18, SC32_FPREGS+144(a0)
+	EX	lwc1 $f19, SC32_FPREGS+148(a0)
+	EX	lwc1 $f20, SC32_FPREGS+160(a0)
+	EX	lwc1 $f21, SC32_FPREGS+164(a0)
+	EX	lwc1 $f22, SC32_FPREGS+176(a0)
+	EX	lwc1 $f23, SC32_FPREGS+180(a0)
+	EX	lwc1 $f24, SC32_FPREGS+192(a0)
+	EX	lwc1 $f25, SC32_FPREGS+196(a0)
+	EX	lwc1 $f26, SC32_FPREGS+208(a0)
+	EX	lwc1 $f27, SC32_FPREGS+212(a0)
+	EX	lwc1 $f28, SC32_FPREGS+224(a0)
+	EX	lwc1 $f29, SC32_FPREGS+228(a0)
+	EX	lwc1 $f30, SC32_FPREGS+240(a0)
+	EX	lwc1 $f31, SC32_FPREGS+244(a0)
+	.set	push
+	SET_HARDFLOAT
+	ctc1	t0, fcr31
+	.set	pop
+	jr	ra
+	 li	v0, 0					# success
+	END(_restore_fp_context32)
+#endif
+
+/*
+ * Load the FPU with signalling NANS.  This bit pattern we're using has
+ * the property that no matter whether considered as single or as double
+ * precision represents signaling NANS.
+ *
+ * The value to initialize fcr31 to comes in $a0.
+ */
+
+	.set push
+	SET_HARDFLOAT
+
+LEAF(_init_fpu)
+#ifdef CONFIG_CPU_R5900
+	sync.p
+#endif
+	mfc0	t0, CP0_STATUS
+	li	t1, ST0_CU1
+	or	t0, t1
+	mtc0	t0, CP0_STATUS
+#ifdef CONFIG_CPU_R5900
+	sync.p
+#endif
+	enable_fpu_hazard
+
+	ctc1	a0, fcr31
+
+	li	t1, -1				# SNaN
+
+#ifdef CONFIG_64BIT
+	sll	t0, t0, 5
+	bgez	t0, 1f				# 16 / 32 register mode?
+
+	dmtc1	t1, $f1
+	dmtc1	t1, $f3
+	dmtc1	t1, $f5
+	dmtc1	t1, $f7
+	dmtc1	t1, $f9
+	dmtc1	t1, $f11
+	dmtc1	t1, $f13
+	dmtc1	t1, $f15
+	dmtc1	t1, $f17
+	dmtc1	t1, $f19
+	dmtc1	t1, $f21
+	dmtc1	t1, $f23
+	dmtc1	t1, $f25
+	dmtc1	t1, $f27
+	dmtc1	t1, $f29
+	dmtc1	t1, $f31
+1:
+#endif
+
+#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_R5900)
+	mtc1	t1, $f0
+	mtc1	t1, $f1
+	mtc1	t1, $f2
+	mtc1	t1, $f3
+	mtc1	t1, $f4
+	mtc1	t1, $f5
+	mtc1	t1, $f6
+	mtc1	t1, $f7
+	mtc1	t1, $f8
+	mtc1	t1, $f9
+	mtc1	t1, $f10
+	mtc1	t1, $f11
+	mtc1	t1, $f12
+	mtc1	t1, $f13
+	mtc1	t1, $f14
+	mtc1	t1, $f15
+	mtc1	t1, $f16
+	mtc1	t1, $f17
+	mtc1	t1, $f18
+	mtc1	t1, $f19
+	mtc1	t1, $f20
+	mtc1	t1, $f21
+	mtc1	t1, $f22
+	mtc1	t1, $f23
+	mtc1	t1, $f24
+	mtc1	t1, $f25
+	mtc1	t1, $f26
+	mtc1	t1, $f27
+	mtc1	t1, $f28
+	mtc1	t1, $f29
+	mtc1	t1, $f30
+	mtc1	t1, $f31
+
+#if defined(CONFIG_CPU_MIPS32_R2) || defined(CONFIG_CPU_MIPS32_R6)
+	.set    push
+	.set    MIPS_ISA_LEVEL_RAW
+	.set	fp=64
+	sll     t0, t0, 5			# is Status.FR set?
+	bgez    t0, 1f				# no: skip setting upper 32b
+
+	mthc1   t1, $f0
+	mthc1   t1, $f1
+	mthc1   t1, $f2
+	mthc1   t1, $f3
+	mthc1   t1, $f4
+	mthc1   t1, $f5
+	mthc1   t1, $f6
+	mthc1   t1, $f7
+	mthc1   t1, $f8
+	mthc1   t1, $f9
+	mthc1   t1, $f10
+	mthc1   t1, $f11
+	mthc1   t1, $f12
+	mthc1   t1, $f13
+	mthc1   t1, $f14
+	mthc1   t1, $f15
+	mthc1   t1, $f16
+	mthc1   t1, $f17
+	mthc1   t1, $f18
+	mthc1   t1, $f19
+	mthc1   t1, $f20
+	mthc1   t1, $f21
+	mthc1   t1, $f22
+	mthc1   t1, $f23
+	mthc1   t1, $f24
+	mthc1   t1, $f25
+	mthc1   t1, $f26
+	mthc1   t1, $f27
+	mthc1   t1, $f28
+	mthc1   t1, $f29
+	mthc1   t1, $f30
+	mthc1   t1, $f31
+1:	.set    pop
+#endif /* CONFIG_CPU_MIPS32_R2 || CONFIG_CPU_MIPS32_R6 */
+#else
+	.set	MIPS_ISA_ARCH_LEVEL_RAW
+	dmtc1	t1, $f0
+	dmtc1	t1, $f2
+	dmtc1	t1, $f4
+	dmtc1	t1, $f6
+	dmtc1	t1, $f8
+	dmtc1	t1, $f10
+	dmtc1	t1, $f12
+	dmtc1	t1, $f14
+	dmtc1	t1, $f16
+	dmtc1	t1, $f18
+	dmtc1	t1, $f20
+	dmtc1	t1, $f22
+	dmtc1	t1, $f24
+	dmtc1	t1, $f26
+	dmtc1	t1, $f28
+	dmtc1	t1, $f30
+#endif
+	jr	ra
+	END(_init_fpu)
+
+	.set pop	/* SET_HARDFLOAT */
+	.set	reorder
+
+	.type	fault@function
+	.ent	fault
+fault:	li	v0, -EFAULT				# failure
+	jr	ra
+	.end	fault
