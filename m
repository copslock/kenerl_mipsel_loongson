Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2016 06:20:16 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30404 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009722AbcAVFUIECXAz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jan 2016 06:20:08 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 4C89C166329EF;
        Fri, 22 Jan 2016 05:19:59 +0000 (GMT)
Received: from [10.100.200.15] (10.100.200.15) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.235.1; Fri, 22 Jan 2016
 05:19:59 +0000
Date:   Fri, 22 Jan 2016 05:20:26 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Aurelien Jarno <aurelien@aurel32.net>, <linux-mips@linux-mips.org>
Subject: [PATCH 1/7] MIPS: math-emu: Correctly handle NOP emulation
In-Reply-To: <alpine.DEB.2.00.1601220227590.5958@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1601220249310.5958@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1601220227590.5958@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.15]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51292
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

Fix an issue introduced with commit 9ab4471c9f1b ("MIPS: math-emu: 
Correct delay-slot exception propagation") where the emulation of a NOP 
instruction signals the need to terminate the emulation loop.  This in 
turn, if the PC has not changed from the entry to the loop, will cause 
the kernel to terminate the program with SIGILL.

Consider this program:

static double div(double d)
{
	do
		d /= 2.0;
	while (d > .5);
	return d;
}

int main(int argc, char **argv)
{
	return div(argc);
}

which gets compiled to the following binary code:

00400490 <main>:
  400490:	44840000 	mtc1	a0,$f0
  400494:	3c020040 	lui	v0,0x40
  400498:	d44207f8 	ldc1	$f2,2040(v0)
  40049c:	46800021 	cvt.d.w	$f0,$f0
  4004a0:	46220002 	mul.d	$f0,$f0,$f2
  4004a4:	4620103c 	c.lt.d	$f2,$f0
  4004a8:	4501fffd 	bc1t	4004a0 <main+0x10>
  4004ac:	00000000 	nop
  4004b0:	4620000d 	trunc.w.d	$f0,$f0
  4004b4:	03e00008 	jr	ra
  4004b8:	44020000 	mfc1	v0,$f0
  4004bc:	00000000 	nop

Where the FPU emulator is used, depending on the number of command-line 
arguments this code will either run to completion or terminate with 
SIGILL.

If no arguments are specified, then BC1T will not be taken, NOP will not 
be emulated and code will complete successfully.

If one argument is specified, then BC1T will be taken once and NOP will 
be emulated.  At this point the entry PC value will be 0x400498 and the 
new PC value, set by `mips_dsemul' will be 0x4004a0, the target of BC1T. 
The emulation loop will terminate, but SIGILL will not be issued, 
because the PC has changed.  The FPU emulator will be entered again and 
on the second execution BC1T will not be taken, NOP will not be emulated 
and code will complete successfully.

If two or more arguments are specified, then the first execution of BC1T 
will proceed as above.  Upon reentering the FPU emulator the emulation 
loop will continue to BC1T, at which point the branch will be taken and
NOP emulated again.  At this point however the entry PC value will be 
0x4004a0, the same as the target of BC1T.  This will make the emulator
conclude that execution has not advanced and therefore an unsupported 
FPU instruction has been encountered, and SIGILL will be sent to the 
process.

Fix the problem by extending the internal API of `mips_dsemul', making 
it return -1 if no delay slot emulation frame has been made, the 
instruction has been handled and execution of the emulation loop needs 
to continue as if nothing happened.  Remove code from `mips_dsemul' to 
reproduce steps made by the emulation loop at the conclusion of each 
iteration, as those will be reached normally now.  Adjust call sites 
accordingly.  Document the API.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
Ralf,

 Please apply.  This has to be backported to stable branches.  NB I have 
deliberately left extraneous parentheses in the condition modified intact 
in `mips_dsemul', so as not to mix a semantic change with a syntactic one.  
They will go away altogether as the condition is refactored with a later
change in this series.

  Maciej

linux-mips-dsemul-nop.diff
Index: linux-sfr-test/arch/mips/math-emu/cp1emu.c
===================================================================
--- linux-sfr-test.orig/arch/mips/math-emu/cp1emu.c	2015-09-04 19:19:07.000000000 +0100
+++ linux-sfr-test/arch/mips/math-emu/cp1emu.c	2016-01-20 21:23:44.313505000 +0000
@@ -1266,6 +1266,8 @@ static int cop1Emulate(struct pt_regs *x
 						 */
 						sig = mips_dsemul(xcp, ir,
 								  contpc);
+						if (sig < 0)
+							break;
 						if (sig)
 							xcp->cp0_epc = bcpc;
 						/*
@@ -1319,6 +1321,8 @@ static int cop1Emulate(struct pt_regs *x
 				 * instruction in the dslot
 				 */
 				sig = mips_dsemul(xcp, ir, contpc);
+				if (sig < 0)
+					break;
 				if (sig)
 					xcp->cp0_epc = bcpc;
 				/* SIGILL forces out of the emulation loop.  */
Index: linux-sfr-test/arch/mips/math-emu/dsemul.c
===================================================================
--- linux-sfr-test.orig/arch/mips/math-emu/dsemul.c	2015-09-04 19:19:07.000000000 +0100
+++ linux-sfr-test/arch/mips/math-emu/dsemul.c	2016-01-21 00:19:50.241325000 +0000
@@ -31,18 +31,20 @@ struct emuframe {
 	unsigned long		epc;
 };
 
+/*
+ * Set up an emulation frame for instruction IR, from a delay slot of
+ * a branch jumping to CPC.  Return 0 if successful, -1 if no emulation
+ * required, otherwise a signal number causing a frame setup failure.
+ */
 int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
 {
 	struct emuframe __user *fr;
 	int err;
 
+	/* NOP is easy */
 	if ((get_isa16_mode(regs->cp0_epc) && ((ir >> 16) == MM_NOP16)) ||
-		(ir == 0)) {
-		/* NOP is easy */
-		regs->cp0_epc = cpc;
-		clear_delay_slot(regs);
-		return 0;
-	}
+	    (ir == 0))
+		return -1;
 
 	pr_debug("dsemul %lx %lx\n", regs->cp0_epc, cpc);
 
