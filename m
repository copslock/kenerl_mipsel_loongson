Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jun 2017 01:15:31 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11571 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993870AbdFEXPTP2YzM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jun 2017 01:15:19 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id A2F99326C3346;
        Tue,  6 Jun 2017 00:15:07 +0100 (IST)
Received: from [10.20.78.130] (10.20.78.130) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 6 Jun 2017
 00:15:11 +0100
Date:   Tue, 6 Jun 2017 00:15:03 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: [PATCH 1/9] MIPS: math-emu: Prevent wrong ISA mode instruction
 emulation
In-Reply-To: <alpine.DEB.2.00.1706040314270.10864@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1706042053000.10864@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1706040314270.10864@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.130]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58233
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

Terminate FPU emulation immediately whenever an ISA mode switch has been 
observed.  This is so that we do not interpret machine code in the wrong
mode, for example when a regular MIPS FPU instruction has been placed in 
a delay slot of a jump that switches into the MIPS16 mode, as with the
following code (taken from a GCC test suite case):

00400650 <set_fast_math>:
  400650:	3c020100 	lui	v0,0x100
  400654:	03e00008 	jr	ra
  400658:	44c2f800 	ctc1	v0,c1_fcsr
  40065c:	00000000 	nop

[...]

004012d0 <__libc_csu_init>:
  4012d0:	f000 6a02 	li	v0,2
  4012d4:	f150 0b1c 	la	v1,3f9430 <_DYNAMIC-0x6df0>
  4012d8:	f400 3240 	sll	v0,16
  4012dc:	e269      	addu	v0,v1
  4012de:	659a      	move	gp,v0
  4012e0:	f00c 64f6 	save	a0-a2,48,ra,s0-s1
  4012e4:	673c      	move	s1,gp
  4012e6:	f010 9978 	lw	v1,-32744(s1)
  4012ea:	d204      	sw	v0,16(sp)
  4012ec:	eb40      	jalr	v1
  4012ee:	653b      	move	t9,v1
  4012f0:	f010 997c 	lw	v1,-32740(s1)
  4012f4:	f030 9920 	lw	s1,-32736(s1)
  4012f8:	e32f      	subu	v1,s1
  4012fa:	326b      	sra	v0,v1,2
  4012fc:	d206      	sw	v0,24(sp)
  4012fe:	220c      	beqz	v0,401318 <__libc_csu_init+0x48>
  401300:	6800      	li	s0,0
  401302:	99e0      	lw	a3,0(s1)
  401304:	4801      	addiu	s0,1
  401306:	960e      	lw	a2,56(sp)
  401308:	4904      	addiu	s1,4
  40130a:	950d      	lw	a1,52(sp)
  40130c:	940c      	lw	a0,48(sp)
  40130e:	ef40      	jalr	a3
  401310:	653f      	move	t9,a3
  401312:	9206      	lw	v0,24(sp)
  401314:	ea0a      	cmp	v0,s0
  401316:	61f5      	btnez	401302 <__libc_csu_init+0x32>
  401318:	6476      	restore	48,ra,s0-s1
  40131a:	e8a0      	jrc	ra

Here `set_fast_math' is called from `40130e' (`40130f' with the ISA bit) 
and emulation triggers for the CTC1 instruction.  As it is in a jump 
delay slot emulation continues from `401312' (`401313' with the ISA 
bit).  However we have no path to handle MIPS16 FPU code emulation, 
because there are no MIPS16 FPU instructions.  So the default emulation 
path is taken, interpreting a 32-bit word fetched by `get_user' from 
`401313' as a regular MIPS instruction, which is:

  401313:	f5ea0a92	sdc1	$f10,2706(t7)

This makes the FPU emulator proceed with the supposed SDC1 instruction 
and consequently makes the program considered here terminate with 
SIGSEGV.

A similar although less severe issue exists with pure-microMIPS 
processors in the case where similarly an FPU instruction is emulated in 
a delay slot of a register jump that (incorrectly) switches into the 
regular MIPS mode.  A subsequent instruction fetch from the jump's 
target is supposed to cause an Address Error exception, however instead 
we proceed with regular MIPS FPU emulation.

For simplicity then, always terminate the emulation loop whenever a mode 
change is detected, denoted by an ISA mode bit flip.  As from commit 
377cb1b6c16a ("MIPS: Disable MIPS16/microMIPS crap for platforms not 
supporting these ASEs.") the result of `get_isa16_mode' can be hardcoded 
to 0, so we need to examine the ISA mode bit by hand.

This complements commit 102cedc32a6e ("MIPS: microMIPS: Floating point 
support.") which added JALX decoding to FPU emulation.

Cc: stable@vger.kernel.org # 3.9+
Fixes: 102cedc32a6e ("MIPS: microMIPS: Floating point support.")
Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
linux-mips-fpemu-xmode.diff
Index: linux-sfr-test/arch/mips/math-emu/cp1emu.c
===================================================================
--- linux-sfr-test.orig/arch/mips/math-emu/cp1emu.c	2017-06-01 06:29:01.919137000 +0100
+++ linux-sfr-test/arch/mips/math-emu/cp1emu.c	2017-06-05 19:01:39.088201000 +0100
@@ -2524,6 +2524,35 @@ static int fpu_emu(struct pt_regs *xcp, 
 	return 0;
 }
 
+/*
+ * Emulate FPU instructions.
+ *
+ * If we use FPU hardware, then we have been typically called to handle
+ * an unimplemented operation, such as where an operand is a NaN or
+ * denormalized.  In that case exit the emulation loop after a single
+ * iteration so as to let hardware execute any subsequent instructions.
+ *
+ * If we have no FPU hardware or it has been disabled, then continue
+ * emulating floating-point instructions until one of these conditions
+ * has occurred:
+ *
+ * - a non-FPU instruction has been encountered,
+ *
+ * - an attempt to emulate has ended with a signal,
+ *
+ * - the ISA mode has been switched.
+ *
+ * We need to terminate the emulation loop if we got switched to the
+ * MIPS16 mode, whether supported or not, so that we do not attempt
+ * to emulate a MIPS16 instruction as a regular MIPS FPU instruction.
+ * Similarly if we got switched to the microMIPS mode and only the
+ * regular MIPS mode is supported, so that we do not attempt to emulate
+ * a microMIPS instruction as a regular MIPS FPU instruction.  Or if
+ * we got switched to the regular MIPS mode and only the microMIPS mode
+ * is supported, so that we do not attempt to emulate a regular MIPS
+ * instruction that should cause an Address Error exception instead.
+ * For simplicity we always terminate upon an ISA mode switch.
+ */
 int fpu_emulator_cop1Handler(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 	int has_fpu, void *__user *fault_addr)
 {
@@ -2609,6 +2638,15 @@ int fpu_emulator_cop1Handler(struct pt_r
 			break;
 		if (sig)
 			break;
+		/*
+		 * We have to check for the ISA bit explicitly here,
+		 * because `get_isa16_mode' may return 0 if support
+		 * for code compression has been globally disabled,
+		 * or otherwise we may produce the wrong signal or
+		 * even proceed successfully where we must not.
+		 */
+		if ((xcp->cp0_epc ^ prevepc) & 0x1)
+			break;
 
 		cond_resched();
 	} while (xcp->cp0_epc > prevepc);
