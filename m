Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Feb 2005 21:13:53 +0000 (GMT)
Received: from alg138.algor.co.uk ([IPv6:::ffff:62.254.210.138]:41176 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224988AbVBGVNa>; Mon, 7 Feb 2005 21:13:30 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j17L8TEC013864;
	Mon, 7 Feb 2005 21:08:29 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j17L8QmP013850;
	Mon, 7 Feb 2005 21:08:26 GMT
Date:	Mon, 7 Feb 2005 21:08:25 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	andreev <andreev@niisi.msk.ru>, linux-mips@linux-mips.org
Subject: Re: Strace doesn't work on linux-2.4.28 and later
Message-ID: <20050207210825.GA6703@linux-mips.org>
References: <41FF876B.3070407@niisi.msk.ru> <4207C142.6070804@avtrex.com> <4207C3E0.7070405@avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4207C3E0.7070405@avtrex.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 07, 2005 at 11:39:12AM -0800, David Daney wrote:

> >    offset("#define PT_SCRATCH0 ", struct pt_regs, pad0[4]);
> >    offset("#define PT_SCRATCH1 ", struct pt_regs, pad0[5]);
> >
> >I am thinking of testing a patch where I change them to:
> >
> >    offset("#define PT_SCRATCH0 ", struct pt_regs, pad0[0]);
> >    offset("#define PT_SCRATCH1 ", struct pt_regs, pad0[1]);
> >
> >Any needed argument registers are already saved in and restored from the 
> >regs array so overwriting the stack area reserved for them should be OK.
> >
> I now think that is bogus reasoning as the first four slots can be 
> clobbered by the compiler.
> 
> It seems that t2 must be saved somewhere in the regs list.  I am not 
> sure what the problem with PT_R1(sp) was, but it seems like a good 
> candidate.  Perhaps PT_R26 or PT_R27 (k0, k1) would be a better place to 
> store t2 as I don't think k0 or k1 are ever stored.

I was always planning to backport the newer fix from 2.6 which is simply
storing the value in a caller saved register.  You now reminded me of
that omission ;-)

Patch below,

  Ralf

Index: arch/mips/kernel/scall_o32.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/Attic/scall_o32.S,v
retrieving revision 1.18.2.14
diff -u -r1.18.2.14 scall_o32.S
--- arch/mips/kernel/scall_o32.S	25 Nov 2004 09:43:59 -0000	1.18.2.14
+++ arch/mips/kernel/scall_o32.S	7 Feb 2005 21:12:53 -0000
@@ -121,15 +121,14 @@
 
 trace_a_syscall:
 	SAVE_STATIC
-	sw	t2, PT_SCRATCH0(sp)
+	move	s0, sp
 	jal	syscall_trace
-	lw	t2, PT_SCRATCH0(sp)
 
 	lw	a0, PT_R4(sp)		# Restore argument registers
 	lw	a1, PT_R5(sp)
 	lw	a2, PT_R6(sp)
 	lw	a3, PT_R7(sp)
-	jalr	t2
+	jalr	s0
 
 	li	t0, -EMAXERRNO - 1	# error?
 	sltu	t0, t0, v0
Index: arch/mips/tools/offset.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/tools/Attic/offset.c,v
retrieving revision 1.16.4.12
diff -u -r1.16.4.12 offset.c
--- arch/mips/tools/offset.c	25 Nov 2004 09:43:59 -0000	1.16.4.12
+++ arch/mips/tools/offset.c	7 Feb 2005 21:12:53 -0000
@@ -12,7 +12,6 @@
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
-#include <linux/signal.h>
 
 #include <asm/ptrace.h>
 #include <asm/processor.h>
@@ -37,9 +36,6 @@
 void output_ptreg_defines(void)
 {
 	text("/* MIPS pt_regs offsets. */");
-	offset("#define PT_SCRATCH0 ", struct pt_regs, pad0[4]);
-	offset("#define PT_SCRATCH1 ", struct pt_regs, pad0[5]);
-
 	offset("#define PT_R0     ", struct pt_regs, regs[0]);
 	offset("#define PT_R1     ", struct pt_regs, regs[1]);
 	offset("#define PT_R2     ", struct pt_regs, regs[2]);
Index: arch/mips64/kernel/scall_64.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/Attic/scall_64.S,v
retrieving revision 1.20.2.20
diff -u -r1.20.2.20 scall_64.S
--- arch/mips64/kernel/scall_64.S	25 Nov 2004 09:43:59 -0000	1.20.2.20
+++ arch/mips64/kernel/scall_64.S	7 Feb 2005 21:12:53 -0000
@@ -102,15 +102,14 @@
 
 trace_a_syscall:
 	SAVE_STATIC
-	sd	t2, PT_SCRATCH0(sp)
+	move	s0, t2
 	jal	syscall_trace
-	ld	t2, PT_SCRATCH0(sp)
 
 	ld	a0, PT_R4(sp)		# Restore argument registers
 	ld	a1, PT_R5(sp)
 	ld	a2, PT_R6(sp)
 	ld	a3, PT_R7(sp)
-	jalr	t2
+	jalr	s0
 
 	li	t0, -EMAXERRNO - 1	# error?
 	sltu	t0, t0, v0
Index: arch/mips64/kernel/scall_n32.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/Attic/scall_n32.S,v
retrieving revision 1.2.2.17
diff -u -r1.2.2.17 scall_n32.S
--- arch/mips64/kernel/scall_n32.S	25 Nov 2004 09:43:59 -0000	1.2.2.17
+++ arch/mips64/kernel/scall_n32.S	7 Feb 2005 21:12:53 -0000
@@ -106,15 +106,14 @@
 
 trace_a_syscall:
 	SAVE_STATIC
-	sd	t2, PT_SCRATCH0(sp)
+	move	s0, t2
 	jal	syscall_trace
-	ld	t2, PT_SCRATCH0(sp)
 
 	ld	a0, PT_R4(sp)		# Restore argument registers
 	ld	a1, PT_R5(sp)
 	ld	a2, PT_R6(sp)
 	ld	a3, PT_R7(sp)
-	jalr	t2
+	jalr	s0
 
 	li	t0, -EMAXERRNO - 1	# error?
 	sltu	t0, t0, v0
Index: arch/mips64/kernel/scall_o32.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/Attic/scall_o32.S,v
retrieving revision 1.48.2.33
diff -u -r1.48.2.33 scall_o32.S
--- arch/mips64/kernel/scall_o32.S	25 Nov 2004 09:43:59 -0000	1.48.2.33
+++ arch/mips64/kernel/scall_o32.S	7 Feb 2005 21:12:53 -0000
@@ -118,9 +118,8 @@
 	sd	a6, PT_R10(sp)
 	sd	a7, PT_R11(sp)
 
-	sd	t2, PT_SCRATCH0(sp)
+	move	s0, t2
 	jal	syscall_trace
-	ld	t2, PT_SCRATCH0(sp)
 
 	ld	a0, PT_R4(sp)		# Restore argument registers
 	ld	a1, PT_R5(sp)
@@ -129,7 +128,7 @@
 	ld	a4, PT_R8(sp)
 	ld	a5, PT_R9(sp)
 
-	jalr	t2
+	jalr	s0
 
 	li	t0, -EMAXERRNO - 1	# error?
 	sltu	t0, t0, v0
