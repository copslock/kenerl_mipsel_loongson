Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Oct 2002 17:19:36 +0200 (CEST)
Received: from mms2.broadcom.com ([63.70.210.59]:5894 "EHLO mms2.broadcom.com")
	by linux-mips.org with ESMTP id <S1123396AbSJRPTf>;
	Fri, 18 Oct 2002 17:19:35 +0200
Received: from 63.70.210.1 by mms2.broadcom.com with ESMTP (Broadcom
 MMS2 SMTP Relay (MMS v5.0)); Fri, 18 Oct 2002 08:16:50 -0700
X-Server-Uuid: 59F48136-7074-4F4B-B709-D7F3B6466DB0
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id IAA23973 for <linux-mips@linux-mips.org>; Fri, 18 Oct 2002 08:19:11
 -0700 (PDT)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 g9IFJAER027796 for <linux-mips@linux-mips.org>; Fri, 18 Oct 2002 08:19:
 11 -0700 (PDT)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id IAA25964 for
 <linux-mips@linux-mips.org>; Fri, 18 Oct 2002 08:19:10 -0700
Message-ID: <3DB0266E.810D9D28@broadcom.com>
Date: Fri, 18 Oct 2002 08:19:10 -0700
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: [patch] mips, mips64 signal trampoline
X-WSS-ID: 11AEFA6854601-01-01
Content-Type: multipart/mixed;
 boundary=------------F593A8437330795766F1454A
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------F593A8437330795766F1454A
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit

It looks like the RA setup by setup_frame and setup_rt_frame in
arch/mips64/kernel/signal.c and signal32.c can be wrong.  Same for
arch/mips/kernel/signal.c

signal32.c, 32-bit signal.c: sa_restorer is overriden
signal.c: regs->regs[31] is pointed at the sigframe's code, even though
there isn't code in the frame, and a comment says that sa_restorer is
always used.

Patch for 2.4 attached.

Kip
--------------F593A8437330795766F1454A
Content-Type: text/plain;
 charset=us-ascii;
 name=signal.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=signal.patch

Index: arch/mips64/kernel/signal.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/signal.c,v
retrieving revision 1.19.2.5
diff -u -r1.19.2.5 signal.c
--- arch/mips64/kernel/signal.c	18 Sep 2002 13:03:07 -0000	1.19.2.5
+++ arch/mips64/kernel/signal.c	18 Oct 2002 15:11:25 -0000
@@ -338,13 +338,12 @@
 	regs->regs[ 5] = 0;
 	regs->regs[ 6] = (unsigned long) &frame->sf_sc;
 	regs->regs[29] = (unsigned long) frame;
-	regs->regs[31] = (unsigned long) frame->sf_code;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ka->sa.sa_handler;
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%p\n",
 	       current->comm, current->pid,
-	       frame, regs->cp0_epc, frame->sf_code);
+	       frame, regs->cp0_epc, regs->regs[31]);
 #endif
         return;
 
@@ -402,13 +401,12 @@
 	regs->regs[ 5] = (unsigned long) &frame->rs_info;
 	regs->regs[ 6] = (unsigned long) &frame->rs_uc;
 	regs->regs[29] = (unsigned long) frame;
-	regs->regs[31] = (unsigned long) frame->rs_code;
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
+++ arch/mips64/kernel/signal32.c	18 Oct 2002 15:11:25 -0000
@@ -589,6 +589,7 @@
 		err |= __put_user(0x0000000c                 ,
 		                  frame->sf_code + 1);
 		flush_cache_sigtramp((unsigned long) frame->sf_code);
+		regs->regs[31] = (unsigned long) frame->sf_code;
 	}
 
 	err |= setup_sigcontext(regs, &frame->sf_sc);
@@ -610,7 +611,6 @@
 	regs->regs[ 5] = 0;
 	regs->regs[ 6] = (unsigned long) &frame->sf_sc;
 	regs->regs[29] = (unsigned long) frame;
-	regs->regs[31] = (unsigned long) frame->sf_code;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ka->sa.sa_handler;
 
 #if DEBUG_SIG
@@ -653,6 +653,7 @@
 		err |= __put_user(0x0000000c                 ,
 		                  frame->rs_code + 1);
 		flush_cache_sigtramp((unsigned long) frame->rs_code);
+		regs->regs[31] = (unsigned long) frame->rs_code;
 	}
 
 	/* Convert (siginfo_t -> siginfo_t32) and copy to user. */
@@ -687,7 +688,6 @@
 	regs->regs[ 5] = (unsigned long) &frame->rs_info;
 	regs->regs[ 6] = (unsigned long) &frame->rs_uc;
 	regs->regs[29] = (unsigned long) frame;
-	regs->regs[31] = (unsigned long) frame->rs_code;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ka->sa.sa_handler;
 
 #if DEBUG_SIG

--------------F593A8437330795766F1454A--
