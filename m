Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Dec 2004 05:12:37 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:31001
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224770AbULJFMc>; Fri, 10 Dec 2004 05:12:32 +0000
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 10 Dec 2004 05:12:30 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 07674239E3D; Fri, 10 Dec 2004 14:12:27 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id iBA5CQdD084428;
	Fri, 10 Dec 2004 14:12:26 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Fri, 10 Dec 2004 14:12:26 +0900 (JST)
Message-Id: <20041210.141226.01918307.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: show_stack, show_trace does not work for other process
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On kernel 2.6, SysRq-T (show_task()) can not show correct stack dump
because show_stack() ignores an 'task' argument.  Here is a patch.  I
fixed show_trace too.

--- linux-mips/arch/mips/kernel/traps.c	2004-11-29 11:23:20.000000000 +0900
+++ linux/arch/mips/kernel/traps.c	2004-12-10 14:01:09.078969122 +0900
@@ -82,7 +82,12 @@
 	long stackdata;
 	int i;
 
-	sp = sp ? sp : (unsigned long *) &sp;
+	if (!sp) {
+		if (task && task != current)
+			sp = (unsigned long *) task->thread.reg29;
+		else
+			sp = (unsigned long *) &sp;
+	}
 
 	printk("Stack :");
 	i = 0;
@@ -110,8 +115,12 @@
 	const int field = 2 * sizeof(unsigned long);
 	unsigned long addr;
 
-	if (!stack)
-		stack = (unsigned long*)&stack;
+	if (!stack) {
+		if (task && task != current)
+			stack = (unsigned long *) task->thread.reg29;
+		else
+			stack = (unsigned long *) &stack;
+	}
 
 	printk("Call Trace:");
 #ifdef CONFIG_KALLSYMS
