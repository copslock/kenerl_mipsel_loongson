Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2003 18:09:14 +0100 (BST)
Received: from mail.convergence.de ([IPv6:::ffff:212.84.236.4]:28342 "EHLO
	mail.convergence.de") by linux-mips.org with ESMTP
	id <S8225211AbTEORJL>; Thu, 15 May 2003 18:09:11 +0100
Received: from [10.1.1.152] (helo=hell)
	by mail.convergence.de with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.14)
	id 19GME5-0003CI-Ub
	for linux-mips@linux-mips.org; Thu, 15 May 2003 19:09:06 +0200
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 19GMEF-0003jP-00
	for <linux-mips@linux-mips.org>; Thu, 15 May 2003 19:09:15 +0200
Date: Thu, 15 May 2003 19:09:15 +0200
From: Johannes Stezenbach <js@convergence.de>
To: linux-mips@linux-mips.org
Subject: [PATCH] implement dump_stack()
Message-ID: <20030515170915.GB14246@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips

Hi,

dump_stack() is declared in linux/kernel.h, and exported in
kernel/ksyms.c, but there is no implementation for mips.
It is useful for debugging.

Patch below is for linux_2_4 branch of arch/mips, but
maybe also applies for 2.5 and arch/mips64. The comment
is copied from arch/i386. It is debatable whether the
show_stack(0) is useful or show_trace(0) would be enough.
Adjust to your liking.

Regards,
Johannes


Index: linux/arch/mips/kernel/traps.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/traps.c,v
retrieving revision 1.99.2.54
diff -u -p -r1.99.2.54 traps.c
--- linux/arch/mips/kernel/traps.c	27 Apr 2003 23:34:46 -0000	1.99.2.54
+++ linux/arch/mips/kernel/traps.c	15 May 2003 15:51:38 -0000
@@ -190,6 +190,15 @@ void show_trace(long *sp)
 	printk("\n");
 }
 
+/*
+ * The architecture-independent backtrace generator
+ */
+void dump_stack(void)
+{
+        show_stack(0);
+        show_trace(0);
+}
+
 void show_trace_task(struct task_struct *tsk)
 {
 	show_trace((long *)tsk->thread.reg29);
