Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA55613 for <linux-archive@neteng.engr.sgi.com>; Fri, 3 Jul 1998 16:17:14 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA21973
	for linux-list;
	Fri, 3 Jul 1998 16:16:38 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA22683
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 3 Jul 1998 16:16:35 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA23809
	for <linux@cthulhu.engr.sgi.com>; Fri, 3 Jul 1998 16:16:31 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@dali.uni-koblenz.de [141.26.5.1])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id BAA07445
	for <linux@cthulhu.engr.sgi.com>; Sat, 4 Jul 1998 01:16:30 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id BAA03015;
	Sat, 4 Jul 1998 01:14:58 +0200
Message-ID: <19980704011456.A3011@uni-koblenz.de>
Date: Sat, 4 Jul 1998 01:14:56 +0200
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: tcsh
References: <19980622110139.F418@uni-koblenz.de> <19980703005927.48187@alpha.franken.de> <19980703165855.C435@uni-koblenz.de> <19980704003729.14342@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19980704003729.14342@alpha.franken.de>; from Thomas Bogendoerfer on Sat, Jul 04, 1998 at 12:37:29AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, Jul 04, 1998 at 12:37:29AM +0200, Thomas Bogendoerfer wrote:

> On Fri, Jul 03, 1998 at 04:58:55PM +0200, ralf@uni-koblenz.de wrote:
> > Sigpause() is a libc routine in libc/sysdeps/posix/sigpause.c; it's either
> > using sigprocmask(2) or sigsuspend(2).
> 
> it's sigsuspend. And after looking at scall_o32.S and realizing that
> calling do_signal() needs to have the static registers saved/restored,
> the bug is obvious (I also had a look at the Alpha sys_sigsuspend). Below
> is a patch, which fixes tcsh and other programs, which use sigsupend.
> If everybody agrees with the patch, I'll check it in.

I've checked in a slightly different patch.  I already had to deal with
the problem of saving these registers for several other routines, so there
is an inline function named save_static to do that job.  Also it saves us
some cycles and looks a bit more beautyful.  Patch appended below.

  Ralf

Index: arch/mips/kernel/signal.c
===================================================================
RCS file: /src/ftp/cvs/linux/arch/mips/kernel/signal.c,v
retrieving revision 1.12
diff -u -r1.12 signal.c
--- signal.c	1998/04/05 11:23:53	1.12
+++ signal.c	1998/07/03 23:04:42
@@ -43,6 +43,7 @@
 {
 	sigset_t *uset, saveset, newset;
 
+	save_static(&regs);
 	uset = (sigset_t *) regs.regs[4];
 	if (copy_from_user(&newset, uset, sizeof(sigset_t)))
 		return -EFAULT;
@@ -67,6 +68,7 @@
 {
 	sigset_t *uset, saveset, newset;
 
+	save_static(&regs);
 	uset = (sigset_t *) regs.regs[4];
 	if (copy_from_user(&newset, uset, sizeof(sigset_t)))
 		return -EFAULT;
