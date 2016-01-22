Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2016 06:20:51 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16173 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009770AbcAVFU0bzwnz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jan 2016 06:20:26 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 934A8A87647F2;
        Fri, 22 Jan 2016 05:20:19 +0000 (GMT)
Received: from [10.100.200.15] (10.100.200.15) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.235.1; Fri, 22 Jan 2016
 05:20:19 +0000
Date:   Fri, 22 Jan 2016 05:20:46 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Aurelien Jarno <aurelien@aurel32.net>, <linux-mips@linux-mips.org>
Subject: [PATCH 3/7] MIPS: math-emu: Make microMIPS branch delay slot emulation
 work
In-Reply-To: <alpine.DEB.2.00.1601220227590.5958@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1601220254060.5958@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1601220227590.5958@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.15]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Complement commit 102cedc32a6e ("MIPS: microMIPS: Floating point 
support.") which introduced microMIPS FPU emulation, but did not adjust 
the encoding of the BREAK instruction used to terminate the branch delay 
slot emulation frame.  Consequently the execution of any such frame is 
indeterminate and, depending on CPU configuration, will result in random 
code execution or an offending program being terminated with SIGILL.

This is because the regular MIPS BREAK instruction is encoded with the 0 
major and the 0xd minor opcode, however in the microMIPS instruction set 
this major/minor opcode pair denotes an encoding reserved for the DSP 
ASE.  Instead the microMIPS BREAK instruction is encoded with the 0 
major and the 0x7 minor opcode.

Use the correct BREAK encoding for microMIPS FPU emulation then.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
Ralf,

 Please apply and backport to stable branches.  This is the program I used 
to validate this change:

#include <stdio.h>

static int li(double x, double y, int i)
{
	asm(	
	"	.set	push		\n"
	"	.set	noreorder	\n"
	"	c.eq.d	%1, %2		\n"
	"	bc1t	0f		\n"
	"	 li	%0, %3		\n"
	"0:	.set	pop		"
		: "=r" (i)
		: "f" (x), "f" (y), "i" (i));

	return i;
}

int main(int argc, char **argv)
{
	printf("ne 16: %d\n", li(1.0, 2.0, 16));
	printf("eq 16: %d\n", li(0.0, 0.0, 16));

	return 0;
}

With the current state of our tree, where FPU emulation is involved this 
program, when compiled to microMIPS code, produces the following output 
(on a DSP-enabled processor):

ne 16: 16
Segmentation fault

whereas with the change applied it prints:

ne 16: 16
eq 16: 16

instead, as expected.

  Maciej

linux-umips-dsemul-break.diff
Index: linux-sfr-sead/arch/mips/include/asm/fpu_emulator.h
===================================================================
--- linux-sfr-sead.orig/arch/mips/include/asm/fpu_emulator.h	2016-01-22 01:56:44.281483000 +0000
+++ linux-sfr-sead/arch/mips/include/asm/fpu_emulator.h	2016-01-22 01:57:50.686025000 +0000
@@ -79,7 +79,7 @@ int mm_isBranchInstr(struct pt_regs *reg
 /*
  * Break instruction with special math emu break code set
  */
-#define BREAK_MATH (0x0000000d | (BRK_MEMU << 16))
+#define BREAK_MATH(micromips) (((micromips) ? 0x7 : 0xd) | (BRK_MEMU << 16))
 
 #define SIGNALLING_NAN 0x7ff800007ff80000LL
 
Index: linux-sfr-sead/arch/mips/include/asm/mips-r2-to-r6-emul.h
===================================================================
--- linux-sfr-sead.orig/arch/mips/include/asm/mips-r2-to-r6-emul.h	2016-01-22 01:56:44.283483000 +0000
+++ linux-sfr-sead/arch/mips/include/asm/mips-r2-to-r6-emul.h	2016-01-22 01:57:50.711027000 +0000
@@ -52,7 +52,7 @@ do {									\
 	__this_cpu_inc(mipsr2emustats.M);				\
 	err = __get_user(nir, (u32 __user *)regs->cp0_epc);		\
 	if (!err) {							\
-		if (nir == BREAK_MATH)					\
+		if (nir == BREAK_MATH(0))				\
 			__this_cpu_inc(mipsr2bdemustats.M);		\
 	}								\
 	preempt_enable();						\
Index: linux-sfr-sead/arch/mips/math-emu/dsemul.c
===================================================================
--- linux-sfr-sead.orig/arch/mips/math-emu/dsemul.c	2016-01-22 01:57:12.640605000 +0000
+++ linux-sfr-sead/arch/mips/math-emu/dsemul.c	2016-01-22 01:57:50.714027000 +0000
@@ -38,6 +38,7 @@ struct emuframe {
  */
 int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
 {
+	mips_instruction break_math;
 	struct emuframe __user *fr;
 	int err;
 
@@ -65,6 +66,7 @@ int mips_dsemul(struct pt_regs *regs, mi
 	 * branches, but gives us a cleaner interface to the exception
 	 * handler (single entry point).
 	 */
+	break_math = BREAK_MATH(get_isa16_mode(regs->cp0_epc));
 
 	/* Ensure that the two instructions are in the same cache line */
 	fr = (struct emuframe __user *)
@@ -79,13 +81,13 @@ int mips_dsemul(struct pt_regs *regs, mi
 				 (u16 __user *)(&fr->emul));
 		err |= __put_user(ir & 0xffff,
 				  (u16 __user *)((long)(&fr->emul) + 2));
-		err |= __put_user(BREAK_MATH >> 16,
+		err |= __put_user(break_math >> 16,
 				  (u16 __user *)(&fr->badinst));
-		err |= __put_user(BREAK_MATH & 0xffff,
+		err |= __put_user(break_math & 0xffff,
 				  (u16 __user *)((long)(&fr->badinst) + 2));
 	} else {
 		err = __put_user(ir, &fr->emul);
-		err |= __put_user((mips_instruction)BREAK_MATH, &fr->badinst);
+		err |= __put_user(break_math, &fr->badinst);
 	}
 
 	err |= __put_user((mips_instruction)BD_COOKIE, &fr->cookie);
@@ -139,7 +141,8 @@ int do_dsemulret(struct pt_regs *xcp)
 	}
 	err |= __get_user(cookie, &fr->cookie);
 
-	if (unlikely(err || (insn != BREAK_MATH) || (cookie != BD_COOKIE))) {
+	if (unlikely(err || insn != BREAK_MATH(get_isa16_mode(xcp->cp0_epc)) ||
+		     cookie != BD_COOKIE)) {
 		MIPS_FPU_EMU_INC_STATS(errors);
 		return 0;
 	}
