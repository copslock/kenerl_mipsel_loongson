Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Mar 2009 00:12:46 +0000 (GMT)
Received: from mail.codesourcery.com ([65.74.133.4]:44168 "EHLO
	mail.codesourcery.com") by ftp.linux-mips.org with ESMTP
	id S20809047AbZCAAMn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 1 Mar 2009 00:12:43 +0000
Received: (qmail 15788 invoked from network); 1 Mar 2009 00:12:37 -0000
Received: from unknown (HELO pl.orcam.me.uk) (macro@127.0.0.2)
  by mail.codesourcery.com with ESMTPA; 1 Mar 2009 00:12:37 -0000
Date:	Sun, 1 Mar 2009 00:12:25 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@codesourcery.com>
To:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
cc:	libc-ports@sourceware.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH, RFC] MIPS: Implement the getcontext API
Message-ID: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@codesourcery.com
Precedence: bulk
X-list: linux-mips

Hello,

 Here is code to implement the getcontext API for MIPS.  This glibc patch 
is sent to the linux-mips mailing list, because it makes use of an 
internal syscall which has not been designated as a part of the public 
ABI.  I am writing to request this syscall to become fixed as a part of 
the ABI or to seek for an alternative.  See below for the rationale.

 The code should speak for itself. ;)  There are two points to note 
though.  The requirement to be able to call setcontext() or swapcontext() 
on a context obtained from a signal handler has the implication of the 
need to use the sigreturn(2) syscall (RT signal syscalls are actually used 
throughout to cover the full set of signals and I have chosen to use them 
unconditionally as any remotely modern Linux will have supported them).  
There are two reasons for doing this.

 First, the full set of registers has to be restored in this case as 
signals can arrive at random points (OTOH, contexts saved by getcontext(), 
swapcontext() or created with makecontext() only need to restore 
call-saved or argument registers as appropriate) and on MIPS it cannot be 
done in the userland.  This is because at least one register is required 
to perform the final jump to restore the PC and the register cannot be 
restored in the jump's delay slot because the ABI does not reserve a red 
zone on the stack below the SP (and space above the SP cannot be used for 
obvious reasons).

 Second, only the kernel may restore the DSP registers without a lot of 
hassle, i.e. fiddling with the SIGILL signal in case the ASE is not 
implemented.  Given the first reason above this is largely irrelevant, but 
even if a way was found to restore otherwise the full user state without a 
need to go through sigreturn(2), this problem would still remain.

 Given the above the implementation was written such that for contexts 
obtained from a signal handler sigreturn(2) is used and for all the other 
ones siprocmask(2) is used to restore the signal mask and appropriate 
registers are restored within setcontext() itself.  Again, this has to be 
done this way, because a full context required for sigreturn(2) cannot be 
easily reconstructed by user code.

 There are two potential issues with the use of sigreturn(2) however.  
First, a stack frame of a specific layout has to be created.  The frame is 
roughly described by the structure introduced in kernel_rt_sigframe.h 
(the structure is only used to calculate offsets in ucontext_i.sym).  The 
description has to be rough, because the exact layout of the structure 
depends on the cache line size specified in the kernel configuration.  
This is not much of the concern for setcontext(), because the variable 
part is beyond the area the function accesses.  The kernel only checks 
whether the whole span of the structure is accessible from sigreturn(2), 
so all that setcontext() has to do is to reserve enough space on the 
stack.  The maximum line size currently supported (which is 128 bytes) is 
used, anticipating it will not ever grow.

 The complication of the matter may sound alerting and rightfully so as 
sigreturn(2) currently is not the part of an official ABI.  It is normally 
only invoked from a signal return trampoline created by the kernel itself.  
There is apparently some knowledge of the layout of the signal stack frame 
in GDB already though and the way the layout of the signal stack frame 
evolved shows binary compatibility was a concern here in the past.  Also 
there is other data included in the frame beside the context.  It is 
currently not used by sigreturn(2) though.

 The other issue is setcontext(), etc. have to mark contexts created by 
themselves somehow so as to differentiate them from ones obtained from a 
signal handler.  I have chosen to reuse the slot for the $zero register, 
which is normally... zero. ;)  As the register is always zero, so will be 
a context passed to a signal handler.  The functions make use of this 
observation and store one instead.  Then setcontext() examines the 
contents of the slot and selects between sigreturn(2) (if zero) and manual 
restoration (if one).  The danger here is contents of a context are meant 
not to be really interpreted by user software and may potentially change 
in the future.

 The conclusion is what I am requesting is to get the structure of the 
stack frame used by sigreturn(2) fixed in its current form and make sure 
the syscall only ever uses data from the ucontext_t structure within.  A 
new syscall would have to be introduced if the kernel required a change in 
the way sigreturn(2) behaves in the future.  For the purpose of glibc the 
structure of the stack frame is defined in the kernel_rt_sigframe.h header 
provided with the patch.

 Furthermore I am requesting that the kernel recognises the special 
meaning of the value of one stored in the slot designated for the $zero 
register and never places such a value itself there.  A few other Linux 
ports already use sigreturn(2) as the underlying mechanism for their 
setcontext() implementation one way or another so such a use of the 
syscall for the MIPS port would follow an already established practice.

2009-03-01  Maciej W. Rozycki  <macro@codesourcery.com>

	* sysdeps/unix/sysv/linux/mips/getcontext.S: New file.
	* sysdeps/unix/sysv/linux/mips/makecontext.S: New file.
	* sysdeps/unix/sysv/linux/mips/setcontext.S: New file.
	* sysdeps/unix/sysv/linux/mips/swapcontext.S: New file.
	* sysdeps/unix/sysv/linux/mips/sys/ucontext.h (mcontext_t):
	Update comment.
	* sysdeps/unix/sysv/linux/mips/kernel_rt_sigframe.h: New file.
	* sysdeps/unix/sysv/linux/mips/ucontext_i.sym: New file.
	* sysdeps/unix/sysv/linux/mips/Makefile (gen-as-const-headers): 
	Add ucontext_i.sym.

 The changes themselves were tested with an almost current head of glibc 
(recent changes to introduce psiginfo broke compilation), specifically a 
snapshot from Feb 3rd, and the current head of glibc-ports.  Testing was 
done by running the glibc testsuite for the n64, n32 and o32 ABIs in the 
little-endian configuration.  All the included getcontext tests passed as 
did two new ones I prepared myself to cover cases not already tested.  I 
will submit the new test cases separately.

 A separate patch to provide cooked FP register names is required to build 
this code for the new ABIs.  I will send it shortly.

  Maciej

glibc-ports-2.9.90-20090226-mips-ucontext-14.patch
diff -up --recursive --new-file glibc-ports-2.9.90-20090226.macro/sysdeps/unix/sysv/linux/mips/Makefile glibc-ports-2.9.90-20090226/sysdeps/unix/sysv/linux/mips/Makefile
--- glibc-ports-2.9.90-20090226.macro/sysdeps/unix/sysv/linux/mips/Makefile	2009-01-27 15:32:55.000000000 +0000
+++ glibc-ports-2.9.90-20090226/sysdeps/unix/sysv/linux/mips/Makefile	2009-02-26 18:58:49.000000000 +0000
@@ -135,3 +135,7 @@ sysdep_routines += dl-static
 sysdep-rtld-routines += dl-static
 endif
 endif
+
+ifeq ($(subdir),stdlib)
+gen-as-const-headers += ucontext_i.sym
+endif
diff -up --recursive --new-file glibc-ports-2.9.90-20090226.macro/sysdeps/unix/sysv/linux/mips/getcontext.S glibc-ports-2.9.90-20090226/sysdeps/unix/sysv/linux/mips/getcontext.S
--- glibc-ports-2.9.90-20090226.macro/sysdeps/unix/sysv/linux/mips/getcontext.S	1970-01-01 00:00:00.000000000 +0000
+++ glibc-ports-2.9.90-20090226/sysdeps/unix/sysv/linux/mips/getcontext.S	2009-02-26 19:00:33.000000000 +0000
@@ -0,0 +1,149 @@
+/* Save current context.
+   Copyright (C) 2009 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+   Contributed by Maciej W. Rozycki <macro@codesourcery.com>.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, 51 Franklin Street - Fifth Floor, Boston, MA
+   02110-1301, USA.  */
+
+#include <sysdep.h>
+#include <sys/asm.h>
+#include <sys/fpregdef.h>
+#include <sys/regdef.h>
+
+#include "ucontext_i.h"
+
+/* int getcontext (ucontext_t *ucp) */
+
+	.text
+LOCALSZ = 0
+MASK = 0x00000000
+#ifdef __PIC__
+LOCALSZ = 1						/* save gp */
+# if _MIPS_SIM != _ABIO32
+MASK = 0x10000000
+# endif
+#endif
+FRAMESZ = ((LOCALSZ * SZREG) + ALSZ) & ALMASK
+GPOFF = FRAMESZ - (1 * SZREG)
+
+NESTED (__getcontext, FRAMESZ, ra)
+	.mask	MASK, 0
+	.fmask	0x00000000, 0
+
+#ifdef __PIC__
+	SETUP_GP
+
+	move	a2, sp
+# define _SP a2
+
+# if _MIPS_SIM != _ABIO32
+	move	a3, gp
+#  define _GP a3
+# endif
+
+	PTR_ADDIU sp, -FRAMESZ
+	SETUP_GP64 (GPOFF, __getcontext)
+	SAVE_GP (GPOFF)
+
+#else  /* ! __PIC__ */
+# define _SP sp
+# define _GP gp
+
+#endif /* ! __PIC__ */
+
+#ifdef PROF
+	.set	noat
+	move	AT, ra
+	jal	_mcount
+	.set	at
+#endif
+
+	/* Store a magic flag.	*/
+	li	v1, 1
+	REG_S	v1, (0 * SZREG + MCONTEXT_GREGS)(a0)	/* zero */
+
+	REG_S	s0, (16 * SZREG + MCONTEXT_GREGS)(a0)
+	REG_S	s1, (17 * SZREG + MCONTEXT_GREGS)(a0)
+	REG_S	s2, (18 * SZREG + MCONTEXT_GREGS)(a0)
+	REG_S	s3, (19 * SZREG + MCONTEXT_GREGS)(a0)
+	REG_S	s4, (20 * SZREG + MCONTEXT_GREGS)(a0)
+	REG_S	s5, (21 * SZREG + MCONTEXT_GREGS)(a0)
+	REG_S	s6, (22 * SZREG + MCONTEXT_GREGS)(a0)
+	REG_S	s7, (23 * SZREG + MCONTEXT_GREGS)(a0)
+#if ! defined (__PIC__) || _MIPS_SIM != _ABIO32
+	REG_S	_GP, (28 * SZREG + MCONTEXT_GREGS)(a0)
+#endif
+	REG_S	_SP, (29 * SZREG + MCONTEXT_GREGS)(a0)
+	REG_S	fp, (30 * SZREG + MCONTEXT_GREGS)(a0)
+	REG_S	ra, (31 * SZREG + MCONTEXT_GREGS)(a0)
+	REG_S	ra, MCONTEXT_PC(a0)
+
+#ifdef __mips_hard_float
+# if _MIPS_SIM == _ABI64
+	s.d	fs0, (24 * SZREG + MCONTEXT_FPREGS)(a0)
+	s.d	fs1, (25 * SZREG + MCONTEXT_FPREGS)(a0)
+	s.d	fs2, (26 * SZREG + MCONTEXT_FPREGS)(a0)
+	s.d	fs3, (27 * SZREG + MCONTEXT_FPREGS)(a0)
+	s.d	fs4, (28 * SZREG + MCONTEXT_FPREGS)(a0)
+	s.d	fs5, (29 * SZREG + MCONTEXT_FPREGS)(a0)
+	s.d	fs6, (30 * SZREG + MCONTEXT_FPREGS)(a0)
+	s.d	fs7, (31 * SZREG + MCONTEXT_FPREGS)(a0)
+
+# else  /* _MIPS_SIM != _ABI64 */
+	s.d	fs0, (20 * SZREG + MCONTEXT_FPREGS)(a0)
+	s.d	fs1, (22 * SZREG + MCONTEXT_FPREGS)(a0)
+	s.d	fs2, (24 * SZREG + MCONTEXT_FPREGS)(a0)
+	s.d	fs3, (26 * SZREG + MCONTEXT_FPREGS)(a0)
+	s.d	fs4, (28 * SZREG + MCONTEXT_FPREGS)(a0)
+	s.d	fs5, (30 * SZREG + MCONTEXT_FPREGS)(a0)
+
+# endif /* _MIPS_SIM != _ABI64 */
+
+	cfc1	v1, fcr31
+	sw	v1, MCONTEXT_FPC_CSR(a0)
+#endif /* __mips_hard_float */
+
+/* rt_sigprocmask (SIG_BLOCK, NULL, &ucp->uc_sigmask, _NSIG8) */
+	li	a3, _NSIG8
+	PTR_ADDU a2, a0, UCONTEXT_SIGMASK
+	move	a1, zero
+	li	a0, SIG_BLOCK
+
+	li	v0, SYS_ify (rt_sigprocmask)
+	syscall
+	bnez	a3, 99f
+
+#ifdef __PIC__
+	RESTORE_GP64
+	PTR_ADDIU sp, FRAMESZ
+#endif
+	move	v0, zero
+	jr	ra
+
+99:
+#ifdef __PIC__
+	PTR_LA	t9, JUMPTARGET (__syscall_error)
+	RESTORE_GP64
+	PTR_ADDIU sp, FRAMESZ
+	jr	t9
+
+#else  /* ! __PIC__ */
+
+	j	JUMPTARGET (__syscall_error)
+#endif /* ! __PIC__ */
+PSEUDO_END (__getcontext)
+
+weak_alias (__getcontext, getcontext)
diff -up --recursive --new-file glibc-ports-2.9.90-20090226.macro/sysdeps/unix/sysv/linux/mips/kernel_rt_sigframe.h glibc-ports-2.9.90-20090226/sysdeps/unix/sysv/linux/mips/kernel_rt_sigframe.h
--- glibc-ports-2.9.90-20090226.macro/sysdeps/unix/sysv/linux/mips/kernel_rt_sigframe.h	1970-01-01 00:00:00.000000000 +0000
+++ glibc-ports-2.9.90-20090226/sysdeps/unix/sysv/linux/mips/kernel_rt_sigframe.h	2009-02-26 00:00:00.000000000 +0000
@@ -0,0 +1,10 @@
+/* Linux kernel RT signal frame. */
+typedef struct kernel_rt_sigframe
+  {
+    uint32_t rs_ass[4];
+    uint32_t rs_code[2];
+    struct siginfo rs_info;
+    struct ucontext rs_uc;
+    uint32_t rs_altcode[8] __attribute__ ((__aligned__ (1 << 7)));
+  }
+kernel_rt_sigframe_t;
diff -up --recursive --new-file glibc-ports-2.9.90-20090226.macro/sysdeps/unix/sysv/linux/mips/makecontext.S glibc-ports-2.9.90-20090226/sysdeps/unix/sysv/linux/mips/makecontext.S
--- glibc-ports-2.9.90-20090226.macro/sysdeps/unix/sysv/linux/mips/makecontext.S	1970-01-01 00:00:00.000000000 +0000
+++ glibc-ports-2.9.90-20090226/sysdeps/unix/sysv/linux/mips/makecontext.S	2009-02-26 00:00:00.000000000 +0000
@@ -0,0 +1,189 @@
+/* Modify saved context.
+   Copyright (C) 2009 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+   Contributed by Maciej W. Rozycki <macro@codesourcery.com>.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, 51 Franklin Street - Fifth Floor, Boston, MA
+   02110-1301, USA.  */
+
+#include <sysdep.h>
+#include <sys/asm.h>
+#include <sys/fpregdef.h>
+#include <sys/regdef.h>
+
+#include "ucontext_i.h"
+
+/* int makecontext (ucontext_t *ucp, (void *func) (), int argc, ...) */
+
+	.text
+LOCALSZ = 0
+ARGSZ = 0
+MASK = 0x00000000
+#ifdef __PIC__
+LOCALSZ = 1						/* save gp */
+#endif
+#if _MIPS_SIM != _ABIO32
+ARGSZ = 5						/* save a3-a7 */
+# ifdef __PIC__
+MASK = 0x10000000
+# endif
+#endif
+FRAMESZ = (((ARGSZ + LOCALSZ) * SZREG) + ALSZ) & ALMASK
+GPOFF = FRAMESZ - ((ARGSZ + 1) * SZREG)
+#if _MIPS_SIM != _ABIO32
+A3OFF = FRAMESZ - (5 * SZREG)				/* callee-allocated */
+A4OFF = FRAMESZ - (4 * SZREG)
+A5OFF = FRAMESZ - (3 * SZREG)
+A6OFF = FRAMESZ - (2 * SZREG)
+A7OFF = FRAMESZ - (1 * SZREG)
+NARGREGS = 8
+#else
+A3OFF = FRAMESZ + (3 * SZREG)				/* caller-allocated */
+NARGREGS = 4
+#endif
+
+NESTED (__makecontext, FRAMESZ, ra)
+	.mask	MASK, -(ARGSZ * SZREG)
+	.fmask	0x00000000, 0
+
+98:
+#ifdef __PIC__
+	SETUP_GP
+#endif
+
+	PTR_ADDIU sp, -FRAMESZ
+
+#ifdef __PIC__
+	SETUP_GP64 (GPOFF, __makecontext)
+	SAVE_GP (GPOFF)
+#endif
+
+#ifdef PROF
+	.set	noat
+	move	AT, ra
+	jal	_mcount
+	.set	at
+#endif
+
+	/* Store args to be passed.  */
+	REG_S	a3, A3OFF(sp)
+#if _MIPS_SIM != _ABIO32
+	REG_S	a4, A4OFF(sp)
+	REG_S	a5, A5OFF(sp)
+	REG_S	a6, A6OFF(sp)
+	REG_S	a7, A7OFF(sp)
+#endif
+
+	/* Store a magic flag.  */
+	li	v1, 1
+	REG_S	v1, (0 * SZREG + MCONTEXT_GREGS)(a0)	/* zero */
+
+	/* Set up the stack.  */
+	PTR_L	t0, STACK_SP(a0)
+	PTR_L	t2, STACK_SIZE(a0)
+	PTR_ADDIU t1, sp, A3OFF
+	PTR_ADDU t0, t2
+	and	t0, ALMASK
+	blez	a2, 2f					/* no arguments */
+
+	/* Store register arguments.  */
+	PTR_ADDIU t2, a0, MCONTEXT_GREGS + 4 * SZREG
+	move	t3, zero
+0:
+	addiu	t3, 1
+	REG_L	v1, (t1)
+	PTR_ADDIU t1, SZREG
+	REG_S	v1, (t2)
+	PTR_ADDIU t2, SZREG
+	bgeu	t3, a2, 2f				/* all done */
+	bltu	t3, NARGREGS, 0b			/* next */
+
+	/* Make room for stack arguments.  */
+	PTR_SUBU t2, a2, t3
+	PTR_SLL	t2, 3
+	PTR_SUBU t0, t2
+	and	t0, ALMASK
+
+	/* Store stack arguments.  */
+	move	t2, t0
+1:
+	addiu	t3, 1
+	REG_L	v1, (t1)
+	PTR_ADDIU t1, SZREG
+	REG_S	v1, (t2)
+	PTR_ADDIU t2, SZREG
+	bltu	t3, a2, 1b				/* next */
+
+2:
+#if _MIPS_SIM == _ABIO32
+	/* Make room for a0-a3 storage.  */
+	PTR_ADDIU t0, -(NARGSAVE * SZREG)
+#endif
+	PTR_L	v1, UCONTEXT_LINK(a0)
+#ifdef __PIC__
+	PTR_ADDIU t9, 99f - 98b
+#else
+	PTR_LA	t9, 99f
+#endif
+	REG_S	t0, (29 * SZREG + MCONTEXT_GREGS)(a0)	/* sp */
+	REG_S	v1, (16 * SZREG + MCONTEXT_GREGS)(a0)	/* s0 */
+#ifdef __PIC__
+	REG_S	gp, (17 * SZREG + MCONTEXT_GREGS)(a0)	/* s1 */
+#endif
+	REG_S	t9, (31 * SZREG + MCONTEXT_GREGS)(a0)	/* ra */
+	REG_S	a1, MCONTEXT_PC(a0)
+
+#ifdef __PIC__
+	RESTORE_GP64
+	PTR_ADDIU sp, FRAMESZ
+#endif
+	jr	ra
+
+99:
+#ifdef __PIC__
+	move	gp, s1
+#endif
+	move	a0, zero
+	beqz	s0, 0f
+
+	/* setcontext (ucp) */
+	move	a0, s0
+#ifdef __PIC__
+	PTR_LA	t9, JUMPTARGET (__setcontext)
+	jalr	t9
+# if _MIPS_SIM == _ABIO32
+	move	gp, s1
+# endif
+#else
+	jal	JUMPTARGET (__setcontext)
+#endif
+	move	a0, v0
+
+0:
+	/* exit (a0) */
+#ifdef __PIC__
+	PTR_LA	t9, HIDDEN_JUMPTARGET (exit)
+	jalr	t9
+#else
+	jal	HIDDEN_JUMPTARGET (exit)
+#endif
+
+	/* You don't exist, you won't feel anything.  */
+1:
+	lb	zero, (zero)
+	b	1b
+PSEUDO_END (__makecontext)
+
+weak_alias (__makecontext, makecontext)
diff -up --recursive --new-file glibc-ports-2.9.90-20090226.macro/sysdeps/unix/sysv/linux/mips/setcontext.S glibc-ports-2.9.90-20090226/sysdeps/unix/sysv/linux/mips/setcontext.S
--- glibc-ports-2.9.90-20090226.macro/sysdeps/unix/sysv/linux/mips/setcontext.S	1970-01-01 00:00:00.000000000 +0000
+++ glibc-ports-2.9.90-20090226/sysdeps/unix/sysv/linux/mips/setcontext.S	2009-02-28 13:43:46.000000000 +0000
@@ -0,0 +1,192 @@
+/* Set current context.
+   Copyright (C) 2009 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+   Contributed by Maciej W. Rozycki <macro@codesourcery.com>.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, 51 Franklin Street - Fifth Floor, Boston, MA
+   02110-1301, USA.  */
+
+#include <sysdep.h>
+#include <sys/asm.h>
+#include <sys/fpregdef.h>
+#include <sys/regdef.h>
+
+#include "ucontext_i.h"
+
+/* int setcontext (const ucontext_t *ucp) */
+
+	.text
+LOCALSZ = 0
+ARGSZ = 0
+MASK = 0x00000000
+#ifdef __PIC__
+LOCALSZ = 1						/* save gp */
+#endif
+#if _MIPS_SIM != _ABIO32
+ARGSZ = 1						/* save a0 */
+# ifdef __PIC__
+MASK = 0x10000000
+# endif
+#endif
+FRAMESZ = (((ARGSZ + LOCALSZ) * SZREG) + ALSZ) & ALMASK
+GPOFF = FRAMESZ - ((ARGSZ + 1) * SZREG)
+#if _MIPS_SIM != _ABIO32
+A0OFF = FRAMESZ - (1 * SZREG)				/* callee-allocated */
+#else
+A0OFF = FRAMESZ + (0 * SZREG)				/* caller-allocated */
+#endif
+
+NESTED (__setcontext, FRAMESZ, ra)
+	.mask	MASK, -(ARGSZ * SZREG)
+	.fmask	0x00000000, 0
+
+#ifdef __PIC__
+	SETUP_GP
+#endif
+
+	PTR_ADDIU sp, -FRAMESZ
+
+#ifdef __PIC__
+	SETUP_GP64 (GPOFF, __setcontext)
+	SAVE_GP (GPOFF)
+#endif
+
+#ifdef PROF
+	.set	noat
+	move	AT, ra
+	jal	_mcount
+	.set	at
+#endif
+
+	/* Check for the magic flag.  */
+	li	v0, 1
+	REG_L	v1, (0 * SZREG + MCONTEXT_GREGS)(a0)	/* zero */
+	bne	v0, v1, 98f
+
+	REG_S	a0, A0OFF(sp)
+
+/* rt_sigprocmask (SIG_SETMASK, &ucp->uc_sigmask, NULL, _NSIG8) */
+	li	a3, _NSIG8
+	move	a2, zero
+	PTR_ADDU a1, a0, UCONTEXT_SIGMASK
+	li	a0, SIG_SETMASK
+
+	li	v0, SYS_ify (rt_sigprocmask)
+	syscall
+	bnez	a3, 99f
+
+	REG_L	v0, A0OFF(sp)
+
+#ifdef __mips_hard_float
+# if _MIPS_SIM == _ABI64
+	l.d	fs0, (24 * SZREG + MCONTEXT_FPREGS)(v0)
+	l.d	fs1, (25 * SZREG + MCONTEXT_FPREGS)(v0)
+	l.d	fs2, (26 * SZREG + MCONTEXT_FPREGS)(v0)
+	l.d	fs3, (27 * SZREG + MCONTEXT_FPREGS)(v0)
+	l.d	fs4, (28 * SZREG + MCONTEXT_FPREGS)(v0)
+	l.d	fs5, (29 * SZREG + MCONTEXT_FPREGS)(v0)
+	l.d	fs6, (30 * SZREG + MCONTEXT_FPREGS)(v0)
+	l.d	fs7, (31 * SZREG + MCONTEXT_FPREGS)(v0)
+
+# else  /* _MIPS_SIM != _ABI64 */
+	l.d	fs0, (20 * SZREG + MCONTEXT_FPREGS)(v0)
+	l.d	fs1, (22 * SZREG + MCONTEXT_FPREGS)(v0)
+	l.d	fs2, (24 * SZREG + MCONTEXT_FPREGS)(v0)
+	l.d	fs3, (26 * SZREG + MCONTEXT_FPREGS)(v0)
+	l.d	fs4, (28 * SZREG + MCONTEXT_FPREGS)(v0)
+	l.d	fs5, (30 * SZREG + MCONTEXT_FPREGS)(v0)
+
+# endif /* _MIPS_SIM != _ABI64 */
+
+	lw	v1, MCONTEXT_FPC_CSR(v0)
+	ctc1	v1, fcr31
+#endif /* __mips_hard_float */
+
+	/* Note the contents of argument registers will be random
+	   unless makecontext() has been called.  */
+	REG_L	a0, (4 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	a1, (5 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	a2, (6 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	a3, (7 * SZREG + MCONTEXT_GREGS)(v0)
+#if _MIPS_SIM != _ABIO32
+	REG_L	a4, (8 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	a5, (9 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	a6, (10 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	a7, (11 * SZREG + MCONTEXT_GREGS)(v0)
+#endif
+
+	REG_L	s0, (16 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	s1, (17 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	s2, (18 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	s3, (19 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	s4, (20 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	s5, (21 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	s6, (22 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	s7, (23 * SZREG + MCONTEXT_GREGS)(v0)
+#if ! defined (__PIC__) || _MIPS_SIM != _ABIO32
+	REG_L	gp, (28 * SZREG + MCONTEXT_GREGS)(v0)
+#endif
+	REG_L	sp, (29 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	fp, (30 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	ra, (31 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	t9, MCONTEXT_PC(v0)
+
+	move	v0, zero
+	jr	t9
+
+98:
+	/* This is a context obtained from a signal handler.
+	   Perform a full restore by pushing the context
+	   passed onto a simulated signal frame on the stack
+	   and call the signal return syscall as if a signal
+	   handler exited normally.  */
+	PTR_ADDIU sp, -((RT_SIGFRAME_SIZE + ALSZ) & ALMASK)
+
+	/* Only ucontext is referred to from rt_sigreturn,
+	   copy it.  */
+	PTR_ADDIU t1, sp, RT_SIGFRAME_UCONTEXT
+	li	t3, ((UCONTEXT_SIZE + SZREG - 1) / SZREG) - 1
+0:
+	REG_L	t2, (a0)
+	PTR_ADDIU a0, SZREG
+	REG_S	t2, (t1)
+	PTR_ADDIU t1, SZREG
+	.set	noreorder
+	bgtz	t3, 0b
+	 addiu	t3, -1
+	.set	reorder
+
+/* rt_sigreturn () -- no arguments, sp points to struct rt_sigframe.  */
+	li	v0, SYS_ify (rt_sigreturn)
+	syscall
+
+	/* Restore the stack and fall through to the error
+	   path.  Successful rt_sigreturn never returns to
+	   its calling place.  */
+	PTR_ADDIU sp, ((RT_SIGFRAME_SIZE + ALSZ) & ALMASK)
+99:
+#ifdef __PIC__
+	PTR_LA	t9, JUMPTARGET (__syscall_error)
+	RESTORE_GP64
+	PTR_ADDIU sp, FRAMESZ
+	jr	t9
+
+#else  /* ! __PIC__ */
+
+	j	JUMPTARGET (__syscall_error)
+#endif /* ! __PIC__ */
+PSEUDO_END (__setcontext)
+
+weak_alias (__setcontext, setcontext)
diff -up --recursive --new-file glibc-ports-2.9.90-20090226.macro/sysdeps/unix/sysv/linux/mips/swapcontext.S glibc-ports-2.9.90-20090226/sysdeps/unix/sysv/linux/mips/swapcontext.S
--- glibc-ports-2.9.90-20090226.macro/sysdeps/unix/sysv/linux/mips/swapcontext.S	1970-01-01 00:00:00.000000000 +0000
+++ glibc-ports-2.9.90-20090226/sysdeps/unix/sysv/linux/mips/swapcontext.S	2009-02-26 19:00:07.000000000 +0000
@@ -0,0 +1,212 @@
+/* Save and set current context.
+   Copyright (C) 2009 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+   Contributed by Maciej W. Rozycki <macro@codesourcery.com>.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, 51 Franklin Street - Fifth Floor, Boston, MA
+   02110-1301, USA.  */
+
+#include <sysdep.h>
+#include <sys/asm.h>
+#include <sys/fpregdef.h>
+#include <sys/regdef.h>
+
+#include "ucontext_i.h"
+
+/* int swapcontext (ucontext_t *oucp, const ucontext_t *ucp) */
+
+	.text
+LOCALSZ = 0
+ARGSZ = 0
+MASK = 0x00000000
+#ifdef __PIC__
+LOCALSZ = 1						/* save gp */
+#endif
+#if _MIPS_SIM != _ABIO32
+ARGSZ = 1						/* save a1 */
+# ifdef __PIC__
+MASK = 0x10000000
+# endif
+#endif
+FRAMESZ = (((ARGSZ + LOCALSZ) * SZREG) + ALSZ) & ALMASK
+GPOFF = FRAMESZ - ((ARGSZ + 1) * SZREG)
+#if _MIPS_SIM != _ABIO32
+A1OFF = FRAMESZ - (1 * SZREG)				/* callee-allocated */
+#else
+A1OFF = FRAMESZ + (1 * SZREG)				/* caller-allocated */
+#endif
+
+NESTED (__swapcontext, FRAMESZ, ra)
+	.mask	MASK, -(ARGSZ * SZREG)
+	.fmask	0x00000000, 0
+
+#ifdef __PIC__
+	SETUP_GP
+
+	move	a2, sp
+# define _SP a2
+
+# if _MIPS_SIM != _ABIO32
+	move	a3, gp
+#  define _GP a3
+# endif
+
+	PTR_ADDIU sp, -FRAMESZ
+	SETUP_GP64 (GPOFF, __swapcontext)
+	SAVE_GP (GPOFF)
+
+#else  /* ! __PIC__ */
+# define _SP sp
+# define _GP gp
+
+#endif /* ! __PIC__ */
+
+#ifdef PROF
+	.set	noat
+	move	AT, ra
+	jal	_mcount
+	.set	at
+#endif
+
+	/* Store a magic flag.	*/
+	li	v1, 1
+	REG_S	v1, (0 * SZREG + MCONTEXT_GREGS)(a0)	/* zero */
+
+	REG_S	s0, (16 * SZREG + MCONTEXT_GREGS)(a0)
+	REG_S	s1, (17 * SZREG + MCONTEXT_GREGS)(a0)
+	REG_S	s2, (18 * SZREG + MCONTEXT_GREGS)(a0)
+	REG_S	s3, (19 * SZREG + MCONTEXT_GREGS)(a0)
+	REG_S	s4, (20 * SZREG + MCONTEXT_GREGS)(a0)
+	REG_S	s5, (21 * SZREG + MCONTEXT_GREGS)(a0)
+	REG_S	s6, (22 * SZREG + MCONTEXT_GREGS)(a0)
+	REG_S	s7, (23 * SZREG + MCONTEXT_GREGS)(a0)
+#if ! defined (__PIC__) || _MIPS_SIM != _ABIO32
+	REG_S	_GP, (28 * SZREG + MCONTEXT_GREGS)(a0)
+#endif
+	REG_S	_SP, (29 * SZREG + MCONTEXT_GREGS)(a0)
+	REG_S	fp, (30 * SZREG + MCONTEXT_GREGS)(a0)
+	REG_S	ra, (31 * SZREG + MCONTEXT_GREGS)(a0)
+	REG_S	ra, MCONTEXT_PC(a0)
+
+#ifdef __mips_hard_float
+# if _MIPS_SIM == _ABI64
+	s.d	fs0, (24 * SZREG + MCONTEXT_FPREGS)(a0)
+	s.d	fs1, (25 * SZREG + MCONTEXT_FPREGS)(a0)
+	s.d	fs2, (26 * SZREG + MCONTEXT_FPREGS)(a0)
+	s.d	fs3, (27 * SZREG + MCONTEXT_FPREGS)(a0)
+	s.d	fs4, (28 * SZREG + MCONTEXT_FPREGS)(a0)
+	s.d	fs5, (29 * SZREG + MCONTEXT_FPREGS)(a0)
+	s.d	fs6, (30 * SZREG + MCONTEXT_FPREGS)(a0)
+	s.d	fs7, (31 * SZREG + MCONTEXT_FPREGS)(a0)
+
+# else  /* _MIPS_SIM != _ABI64 */
+	s.d	fs0, (20 * SZREG + MCONTEXT_FPREGS)(a0)
+	s.d	fs1, (22 * SZREG + MCONTEXT_FPREGS)(a0)
+	s.d	fs2, (24 * SZREG + MCONTEXT_FPREGS)(a0)
+	s.d	fs3, (26 * SZREG + MCONTEXT_FPREGS)(a0)
+	s.d	fs4, (28 * SZREG + MCONTEXT_FPREGS)(a0)
+	s.d	fs5, (30 * SZREG + MCONTEXT_FPREGS)(a0)
+
+# endif /* _MIPS_SIM != _ABI64 */
+
+	cfc1	v1, fcr31
+	sw	v1, MCONTEXT_FPC_CSR(a0)
+#endif /* __mips_hard_float */
+
+	REG_S	a1, A1OFF(sp)
+
+/* rt_sigprocmask (SIG_SETMASK, &ucp->uc_sigmask, &oucp->uc_sigmask, _NSIG8) */
+	li	a3, _NSIG8
+	PTR_ADDU a2, a0, UCONTEXT_SIGMASK
+	PTR_ADDU a1, a1, UCONTEXT_SIGMASK
+	li	a0, SIG_SETMASK
+
+	li	v0, SYS_ify (rt_sigprocmask)
+	syscall
+	bnez	a3, 99f
+
+	REG_L	v0, A1OFF(sp)
+
+#ifdef __mips_hard_float
+# if _MIPS_SIM == _ABI64
+	l.d	fs0, (24 * SZREG + MCONTEXT_FPREGS)(v0)
+	l.d	fs1, (25 * SZREG + MCONTEXT_FPREGS)(v0)
+	l.d	fs2, (26 * SZREG + MCONTEXT_FPREGS)(v0)
+	l.d	fs3, (27 * SZREG + MCONTEXT_FPREGS)(v0)
+	l.d	fs4, (28 * SZREG + MCONTEXT_FPREGS)(v0)
+	l.d	fs5, (29 * SZREG + MCONTEXT_FPREGS)(v0)
+	l.d	fs6, (30 * SZREG + MCONTEXT_FPREGS)(v0)
+	l.d	fs7, (31 * SZREG + MCONTEXT_FPREGS)(v0)
+
+# else  /* _MIPS_SIM != _ABI64 */
+	l.d	fs0, (20 * SZREG + MCONTEXT_FPREGS)(v0)
+	l.d	fs1, (22 * SZREG + MCONTEXT_FPREGS)(v0)
+	l.d	fs2, (24 * SZREG + MCONTEXT_FPREGS)(v0)
+	l.d	fs3, (26 * SZREG + MCONTEXT_FPREGS)(v0)
+	l.d	fs4, (28 * SZREG + MCONTEXT_FPREGS)(v0)
+	l.d	fs5, (30 * SZREG + MCONTEXT_FPREGS)(v0)
+
+# endif /* _MIPS_SIM != _ABI64 */
+
+	lw	v1, MCONTEXT_FPC_CSR(v0)
+	ctc1	v1, fcr31
+#endif /* __mips_hard_float */
+
+	/* Note the contents of argument registers will be random
+	   unless makecontext() has been called.  */
+	REG_L	a0, (4 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	a1, (5 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	a2, (6 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	a3, (7 * SZREG + MCONTEXT_GREGS)(v0)
+#if _MIPS_SIM != _ABIO32
+	REG_L	a4, (8 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	a5, (9 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	a6, (10 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	a7, (11 * SZREG + MCONTEXT_GREGS)(v0)
+#endif
+
+	REG_L	s0, (16 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	s1, (17 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	s2, (18 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	s3, (19 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	s4, (20 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	s5, (21 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	s6, (22 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	s7, (23 * SZREG + MCONTEXT_GREGS)(v0)
+#if ! defined (__PIC__) || _MIPS_SIM != _ABIO32
+	REG_L	gp, (28 * SZREG + MCONTEXT_GREGS)(v0)
+#endif
+	REG_L	sp, (29 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	fp, (30 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	ra, (31 * SZREG + MCONTEXT_GREGS)(v0)
+	REG_L	t9, MCONTEXT_PC(v0)
+
+	move	v0, zero
+	jr	t9
+
+99:
+#ifdef __PIC__
+	PTR_LA	t9, JUMPTARGET (__syscall_error)
+	RESTORE_GP64
+	PTR_ADDIU sp, FRAMESZ
+	jr	t9
+
+#else  /* ! __PIC__ */
+
+	j	JUMPTARGET (__syscall_error)
+#endif /* ! __PIC__ */
+PSEUDO_END (__swapcontext)
+
+weak_alias (__swapcontext, swapcontext)
diff -up --recursive --new-file glibc-ports-2.9.90-20090226.macro/sysdeps/unix/sysv/linux/mips/sys/ucontext.h glibc-ports-2.9.90-20090226/sysdeps/unix/sysv/linux/mips/sys/ucontext.h
--- glibc-ports-2.9.90-20090226.macro/sysdeps/unix/sysv/linux/mips/sys/ucontext.h	2006-05-10 18:57:03.000000000 +0000
+++ glibc-ports-2.9.90-20090226/sysdeps/unix/sysv/linux/mips/sys/ucontext.h	2009-02-26 18:58:49.000000000 +0000
@@ -56,12 +56,9 @@ typedef struct fpregset {
 #if _MIPS_SIM == _ABIO32
 /* Earlier versions of glibc for mips had an entirely different
    definition of mcontext_t, that didn't even resemble the
-   corresponding kernel data structure.  Since all legitimate uses of
-   ucontext_t in glibc mustn't have accessed anything beyond
-   uc_mcontext and, even then, taking a pointer to it, casting it to
-   sigcontext_t, and accessing it as such, which is what it has always
-   been, this can still be rectified.  Fortunately, makecontext,
-   [gs]etcontext et all have never been implemented.  */
+   corresponding kernel data structure.  Fortunately, makecontext,
+   [gs]etcontext et all were not implemented back then, so this can
+   still be rectified.  */
 typedef struct
   {
     unsigned int regmask;
diff -up --recursive --new-file glibc-ports-2.9.90-20090226.macro/sysdeps/unix/sysv/linux/mips/ucontext_i.sym glibc-ports-2.9.90-20090226/sysdeps/unix/sysv/linux/mips/ucontext_i.sym
--- glibc-ports-2.9.90-20090226.macro/sysdeps/unix/sysv/linux/mips/ucontext_i.sym	1970-01-01 00:00:00.000000000 +0000
+++ glibc-ports-2.9.90-20090226/sysdeps/unix/sysv/linux/mips/ucontext_i.sym	2009-02-26 00:00:00.000000000 +0000
@@ -0,0 +1,52 @@
+#include <inttypes.h>
+#include <signal.h>
+#include <stddef.h>
+#include <sys/ucontext.h>
+
+#include <kernel_rt_sigframe.h>
+
+-- Constants used by the rt_sigprocmask call.
+
+SIG_BLOCK
+SIG_SETMASK
+
+_NSIG8				(_NSIG / 8)
+
+-- Offsets of the fields in the kernel rt_sigframe_t structure.
+#define rt_sigframe(member)	offsetof (kernel_rt_sigframe_t, member)
+
+RT_SIGFRAME_UCONTEXT		rt_sigframe (rs_uc)
+
+RT_SIGFRAME_SIZE		sizeof (kernel_rt_sigframe_t)
+
+-- Offsets of the fields in the ucontext_t structure.
+#define ucontext(member)	offsetof (ucontext_t, member)
+#define stack(member)		ucontext (uc_stack.member)
+#define mcontext(member)	ucontext (uc_mcontext.member)
+
+UCONTEXT_FLAGS			ucontext (uc_flags)
+UCONTEXT_LINK			ucontext (uc_link)
+UCONTEXT_STACK			ucontext (uc_stack)
+UCONTEXT_MCONTEXT		ucontext (uc_mcontext)
+UCONTEXT_SIGMASK		ucontext (uc_sigmask)
+
+STACK_SP			stack (ss_sp)
+STACK_SIZE			stack (ss_size)
+STACK_FLAGS			stack (ss_flags)
+
+MCONTEXT_GREGS			mcontext (gregs)
+MCONTEXT_FPREGS			mcontext (fpregs)
+MCONTEXT_MDHI			mcontext (mdhi)
+MCONTEXT_HI1			mcontext (hi1)
+MCONTEXT_HI2			mcontext (hi2)
+MCONTEXT_HI3			mcontext (hi3)
+MCONTEXT_MDLO			mcontext (mdlo)
+MCONTEXT_LO1			mcontext (lo1)
+MCONTEXT_LO2			mcontext (lo2)
+MCONTEXT_LO3			mcontext (lo3)
+MCONTEXT_PC			mcontext (pc)
+MCONTEXT_FPC_CSR		mcontext (fpc_csr)
+MCONTEXT_USED_MATH		mcontext (used_math)
+MCONTEXT_DSP			mcontext (dsp)
+
+UCONTEXT_SIZE			sizeof (ucontext_t)
