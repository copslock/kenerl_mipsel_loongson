Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Oct 2002 17:57:17 +0200 (CEST)
Received: from mms2.broadcom.com ([63.70.210.59]:21520 "EHLO mms2.broadcom.com")
	by linux-mips.org with ESMTP id <S1122962AbSJRP5Q>;
	Fri, 18 Oct 2002 17:57:16 +0200
Received: from 63.70.210.1 by mms2.broadcom.com with ESMTP (Broadcom
 MMS2 SMTP Relay (MMS v5.0)); Fri, 18 Oct 2002 08:54:42 -0700
X-Server-Uuid: 59F48136-7074-4F4B-B709-D7F3B6466DB0
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id IAA28603 for <linux-mips@linux-mips.org>; Fri, 18 Oct 2002 08:57:02
 -0700 (PDT)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 g9IFv2ER028194 for <linux-mips@linux-mips.org>; Fri, 18 Oct 2002 08:57:
 02 -0700 (PDT)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id IAA26095 for
 <linux-mips@linux-mips.org>; Fri, 18 Oct 2002 08:57:02 -0700
Message-ID: <3DB02F4E.E4C5242A@broadcom.com>
Date: Fri, 18 Oct 2002 08:57:02 -0700
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: [patch] mips, mips64 signal trampoline
References: <3DB0266E.810D9D28@broadcom.com>
X-WSS-ID: 11AEF14856445-01-01
Content-Type: multipart/mixed;
 boundary=------------783AD2CEE61C3F4611CC8F09
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------783AD2CEE61C3F4611CC8F09
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit


OK, the patch was broken because it changed regs->regs[31] before the
setup_sigcontext.  I think this one actually fixes a problem instead of
introducing one.  :-)  Somebody sent the 32-bit part of the patch around
a long time ago, but it doesn't seem to have gotten into CVS yet.

Kip

Kip Walker wrote:
> 
> It looks like the RA setup by setup_frame and setup_rt_frame in
> arch/mips64/kernel/signal.c and signal32.c can be wrong.  Same for
> arch/mips/kernel/signal.c
> 
> signal32.c, 32-bit signal.c: sa_restorer is overriden
> signal.c: regs->regs[31] is pointed at the sigframe's code, even though
> there isn't code in the frame, and a comment says that sa_restorer is
> always used.
> 
> Patch for 2.4 attached.
>
--------------783AD2CEE61C3F4611CC8F09
Content-Type: text/plain;
 charset=us-ascii;
 name=signal.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=signal.patch

Index: arch/mips/kernel/signal.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/signal.c,v
retrieving revision 1.39.2.9
diff -u -r1.39.2.9 signal.c
--- arch/mips/kernel/signal.c	5 Aug 2002 23:53:33 -0000	1.39.2.9
+++ arch/mips/kernel/signal.c	18 Oct 2002 15:52:26 -0000
@@ -461,6 +461,7 @@
 	int signr, sigset_t *set)
 {
 	struct sigframe *frame;
+	unsigned long ra;
 	int err = 0;
 
 	frame = get_sigframe(ka, regs, sizeof(*frame));
@@ -470,7 +471,7 @@
 	/* Set up to return from userspace.  If provided, use a stub already
 	   in userspace.  */
 	if (ka->sa.sa_flags & SA_RESTORER)
-		regs->regs[31] = (unsigned long) ka->sa.sa_restorer;
+		ra = (unsigned long) ka->sa.sa_restorer;
 	else {
 		/*
 		 * Set up the return code ...
@@ -483,6 +484,7 @@
 		err |= __put_user(0x0000000c                 ,
 		                  frame->sf_code + 1);
 		flush_cache_sigtramp((unsigned long) frame->sf_code);
+		ra = (unsigned long) frame->sf_code;
 	}
 
 	err |= setup_sigcontext(regs, &frame->sf_sc);
@@ -504,13 +506,13 @@
 	regs->regs[ 5] = 0;
 	regs->regs[ 6] = (unsigned long) &frame->sf_sc;
 	regs->regs[29] = (unsigned long) frame;
-	regs->regs[31] = (unsigned long) frame->sf_code;
+	regs->regs[31] = ra;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ka->sa.sa_handler;
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%p\n",
 	       current->comm, current->pid,
-	       frame, regs->cp0_epc, frame->sf_code);
+	       frame, regs->cp0_epc, regs->regs[31]);
 #endif
         return;
 
@@ -524,6 +526,7 @@
 	int signr, sigset_t *set, siginfo_t *info)
 {
 	struct rt_sigframe *frame;
+	unsigned long ra;
 	int err = 0;
 
 	frame = get_sigframe(ka, regs, sizeof(*frame));
@@ -533,7 +536,7 @@
 	/* Set up to return from userspace.  If provided, use a stub already
 	   in userspace.  */
 	if (ka->sa.sa_flags & SA_RESTORER)
-		regs->regs[31] = (unsigned long) ka->sa.sa_restorer;
+		ra = (unsigned long) ka->sa.sa_restorer;
 	else {
 		/*
 		 * Set up the return code ...
@@ -546,6 +549,7 @@
 		err |= __put_user(0x0000000c                 ,
 		                  frame->rs_code + 1);
 		flush_cache_sigtramp((unsigned long) frame->rs_code);
+		ra = (unsigned long) frame->rs_code;
 	}
 
 	/* Create siginfo.  */
@@ -580,13 +584,13 @@
 	regs->regs[ 5] = (unsigned long) &frame->rs_info;
 	regs->regs[ 6] = (unsigned long) &frame->rs_uc;
 	regs->regs[29] = (unsigned long) frame;
-	regs->regs[31] = (unsigned long) frame->rs_code;
+	regs->regs[31] = ra;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ka->sa.sa_handler;
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%p\n",
 	       current->comm, current->pid,
-	       frame, regs->cp0_epc, frame->rs_code);
+	       frame, regs->cp0_epc, regs->regs[31]);
 #endif
 	return;
 
Index: arch/mips64/kernel/signal.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/signal.c,v
retrieving revision 1.19.2.5
diff -u -r1.19.2.5 signal.c
--- arch/mips64/kernel/signal.c	18 Sep 2002 13:03:07 -0000	1.19.2.5
+++ arch/mips64/kernel/signal.c	18 Oct 2002 15:52:26 -0000
@@ -313,12 +313,6 @@
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		goto give_sigsegv;
 
-	/*
-	 * Set up to return from userspace.  On mips64 we always use a stub 
-	 * already provided by userspace and ignore SA_RESTORER.
-	 */
-	regs->regs[31] = (unsigned long) ka->sa.sa_restorer;
-
 	err |= setup_sigcontext(regs, &frame->sf_sc);
 	err |= __copy_to_user(&frame->sf_mask, set, sizeof(*set));
 	if (err)
@@ -331,20 +325,21 @@
 	 *   a1 = 0 (should be cause)
 	 *   a2 = pointer to struct sigcontext
 	 *
-	 * $25 and c0_epc point to the signal handler, $29 points to the
-	 * struct sigframe.
+	 * $25 and c0_epc point to the signal handler, $29 points to
+	 * the struct sigframe.  On mips64 we always use a stub
+	 * already provided by userspace and ignore SA_RESTORER.
 	 */
 	regs->regs[ 4] = signr;
 	regs->regs[ 5] = 0;
 	regs->regs[ 6] = (unsigned long) &frame->sf_sc;
 	regs->regs[29] = (unsigned long) frame;
-	regs->regs[31] = (unsigned long) frame->sf_code;
+	regs->regs[31] = (unsigned long) ka->sa.sa_restorer;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ka->sa.sa_handler;
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%p\n",
 	       current->comm, current->pid,
-	       frame, regs->cp0_epc, frame->sf_code);
+	       frame, regs->cp0_epc, regs->regs[31]);
 #endif
         return;
 
@@ -364,12 +359,6 @@
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		goto give_sigsegv;
 
-	/*
-	 * Set up to return from userspace.  On mips64 we always use a stub 
-	 * already provided by userspace and ignore SA_RESTORER.
-	 */
-	regs->regs[31] = (unsigned long) ka->sa.sa_restorer;
-
 	/* Create siginfo.  */
 	err |= copy_siginfo_to_user(&frame->rs_info, info);
 
@@ -396,19 +385,20 @@
 	 *   a2 = pointer to ucontext
 	 *
 	 * $25 and c0_epc point to the signal handler, $29 points to
-	 * the struct rt_sigframe.
+	 * the struct rt_sigframe.  On mips64 we always use a stub
+	 * already provided by userspace and ignore SA_RESTORER.
 	 */
 	regs->regs[ 4] = signr;
 	regs->regs[ 5] = (unsigned long) &frame->rs_info;
 	regs->regs[ 6] = (unsigned long) &frame->rs_uc;
 	regs->regs[29] = (unsigned long) frame;
-	regs->regs[31] = (unsigned long) frame->rs_code;
+	regs->regs[31] = (unsigned long) ka->sa.sa_restorer;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ka->sa.sa_handler;
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%p\n",
 	       current->comm, current->pid,
-	       frame, regs->cp0_epc, frame->rs_code);
+	       frame, regs->cp0_epc, regs->regs[31]);
 #endif
 	return;
 
Index: arch/mips64/kernel/signal32.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/signal32.c,v
retrieving revision 1.20.2.9
diff -u -r1.20.2.9 signal32.c
--- arch/mips64/kernel/signal32.c	2 Oct 2002 12:21:45 -0000	1.20.2.9
+++ arch/mips64/kernel/signal32.c	18 Oct 2002 15:52:26 -0000
@@ -567,6 +567,7 @@
 			       int signr, sigset_t *set)
 {
 	struct sigframe *frame;
+	unsigned long ra;
 	int err = 0;
 
 	frame = get_sigframe(ka, regs, sizeof(*frame));
@@ -576,7 +577,7 @@
 	/* Set up to return from userspace.  If provided, use a stub already
 	   in userspace.  */
 	if (ka->sa.sa_flags & SA_RESTORER)
-		regs->regs[31] = (unsigned long) ka->sa.sa_restorer;
+		ra = (unsigned long) ka->sa.sa_restorer;
 	else {
 		/*
 		 * Set up the return code ...
@@ -589,6 +590,7 @@
 		err |= __put_user(0x0000000c                 ,
 		                  frame->sf_code + 1);
 		flush_cache_sigtramp((unsigned long) frame->sf_code);
+		ra = (unsigned long) frame->sf_code;
 	}
 
 	err |= setup_sigcontext(regs, &frame->sf_sc);
@@ -610,13 +612,13 @@
 	regs->regs[ 5] = 0;
 	regs->regs[ 6] = (unsigned long) &frame->sf_sc;
 	regs->regs[29] = (unsigned long) frame;
-	regs->regs[31] = (unsigned long) frame->sf_code;
+	regs->regs[31] = ra;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ka->sa.sa_handler;
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%p\n",
 	       current->comm, current->pid,
-	       frame, regs->cp0_epc, frame->sf_code);
+	       frame, regs->cp0_epc, regs->regs[31]);
 #endif
         return;
 
@@ -631,6 +633,7 @@
 				  sigset_t *set, siginfo_t *info)
 {
 	struct rt_sigframe32 *frame;
+	unsigned long ra;
 	int err = 0;
 
 	frame = get_sigframe(ka, regs, sizeof(*frame));
@@ -640,7 +643,7 @@
 	/* Set up to return from userspace.  If provided, use a stub already
 	   in userspace.  */
 	if (ka->sa.sa_flags & SA_RESTORER)
-		regs->regs[31] = (unsigned long) ka->sa.sa_restorer;
+		ra = (unsigned long) ka->sa.sa_restorer;
 	else {
 		/*
 		 * Set up the return code ...
@@ -653,6 +656,7 @@
 		err |= __put_user(0x0000000c                 ,
 		                  frame->rs_code + 1);
 		flush_cache_sigtramp((unsigned long) frame->rs_code);
+		ra = (unsigned long) frame->rs_code;
 	}
 
 	/* Convert (siginfo_t -> siginfo_t32) and copy to user. */
@@ -687,13 +691,13 @@
 	regs->regs[ 5] = (unsigned long) &frame->rs_info;
 	regs->regs[ 6] = (unsigned long) &frame->rs_uc;
 	regs->regs[29] = (unsigned long) frame;
-	regs->regs[31] = (unsigned long) frame->rs_code;
+	regs->regs[31] = ra;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ka->sa.sa_handler;
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%p\n",
 	       current->comm, current->pid,
-	       frame, regs->cp0_epc, frame->rs_code);
+	       frame, regs->cp0_epc, regs->regs[31]);
 #endif
 	return;
 

--------------783AD2CEE61C3F4611CC8F09--
