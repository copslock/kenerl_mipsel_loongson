Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Oct 2004 09:09:17 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:40708
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225210AbUJVIJM>; Fri, 22 Oct 2004 09:09:12 +0100
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 22 Oct 2004 08:09:10 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id D28E0239E2C; Fri, 22 Oct 2004 17:09:06 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i9M8963i048449;
	Fri, 22 Oct 2004 17:09:06 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Fri, 22 Oct 2004 17:07:58 +0900 (JST)
Message-Id: <20041022.170758.48799763.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: kernel_thread creation bug?
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

I'm encountering strange kernel lockup recently.  I noticed that
sometimes an interrupt happend in middle of RESTORE_SOME code.

RESTORE_SOME restores CP0_STATUS from stack.  But the value in the
stack did not contains EXL bit when the problem happens.

With recent change in kernel_thread(), initial cp0_status value comes
from current C0_STATUS (which does not include EXL bit).  Is this
correct?  The initial value should contain EXL bit to start the thread
up safely, shouldn't it?

Now I'm testing this patch and it seems to fix the problem.

diff -u linux-mips/arch/mips/kernel/process.c linux/arch/mips/kernel/
--- linux-mips/arch/mips/kernel/process.c	Wed Sep 22 13:27:59 2004
+++ linux/arch/mips/kernel/process.c	Fri Oct 22 16:49:39 2004
@@ -171,6 +171,9 @@
 	regs.regs[5] = (unsigned long) fn;
 	regs.cp0_epc = (unsigned long) kernel_thread_helper;
 	regs.cp0_status = read_c0_status();
+#if !(defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX))
+	regs.cp0_status |= ST0_EXL;
+#endif
 
 	/* Ok, create the new process.. */
 	return do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);

---
Atsushi Nemoto
