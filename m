Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA00083 for <linux-archive@neteng.engr.sgi.com>; Fri, 3 Jul 1998 15:41:18 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA16027
	for linux-list;
	Fri, 3 Jul 1998 15:40:40 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA48949
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 3 Jul 1998 15:40:34 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA17120
	for <linux@cthulhu.engr.sgi.com>; Fri, 3 Jul 1998 15:40:29 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0ysEVD-0027oLC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sat, 4 Jul 1998 00:40:23 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0ysEV5-002PUqC; Sat, 4 Jul 98 00:40 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id AAA02740;
	Sat, 4 Jul 1998 00:37:29 +0200
Message-ID: <19980704003729.14342@alpha.franken.de>
Date: Sat, 4 Jul 1998 00:37:29 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: ralf@uni-koblenz.de
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: tcsh
References: <19980622110139.F418@uni-koblenz.de> <19980703005927.48187@alpha.franken.de> <19980703165855.C435@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <19980703165855.C435@uni-koblenz.de>; from ralf@uni-koblenz.de on Fri, Jul 03, 1998 at 04:58:55PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Jul 03, 1998 at 04:58:55PM +0200, ralf@uni-koblenz.de wrote:
> Sigpause() is a libc routine in libc/sysdeps/posix/sigpause.c; it's either
> using sigprocmask(2) or sigsuspend(2).

it's sigsuspend. And after looking at scall_o32.S and realizing that
calling do_signal() needs to have the static registers saved/restored,
the bug is obvious (I also had a look at the Alpha sys_sigsuspend). Below
is a patch, which fixes tcsh and other programs, which use sigsupend.
If everybody agrees with the patch, I'll check it in.

Thomas.

Index: scall_o32.S
===================================================================
RCS file: /var/mips/linus/cvs/linux/arch/mips/kernel/scall_o32.S,v
retrieving revision 1.3
diff -u -r1.3 scall_o32.S
--- scall_o32.S	1998/03/27 04:47:55	1.3
+++ scall_o32.S	1998/07/03 22:32:56
@@ -98,6 +98,18 @@
 	jal	schedule
 	b	o32_ret_from_sys_call
 
+EXPORT(sys_sigsuspend)
+	SAVE_STATIC
+	jal	do_sigsuspend
+	RESTORE_STATIC
+	b	o32_ret_from_sys_call
+
+EXPORT(sys_rt_sigsuspend)
+	SAVE_STATIC
+	jal	do_rt_sigsuspend
+	RESTORE_STATIC
+	b	o32_ret_from_sys_call
+
 /* ------------------------------------------------------------------------ */
 
 trace_a_syscall:
Index: signal.c
===================================================================
RCS file: /var/mips/linus/cvs/linux/arch/mips/kernel/signal.c,v
retrieving revision 1.12
diff -u -r1.12 signal.c
--- signal.c	1998/04/05 11:23:53	1.12
+++ signal.c	1998/07/03 22:31:58
@@ -38,8 +38,8 @@
 /*
  * Atomically swap in the new signal mask, and wait for a signal.
  */
-asmlinkage inline int
-sys_sigsuspend(struct pt_regs regs)
+int
+do_sigsuspend(struct pt_regs regs)
 {
 	sigset_t *uset, saveset, newset;
 
@@ -62,8 +62,8 @@
 	}
 }
 
-asmlinkage int
-sys_rt_sigsuspend(struct pt_regs regs)
+int
+do_rt_sigsuspend(struct pt_regs regs)
 {
 	sigset_t *uset, saveset, newset;
 

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
