Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2007 15:51:13 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:51920 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023692AbXGMOuz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Jul 2007 15:50:55 +0100
Received: from localhost (p3184-ipad31funabasi.chiba.ocn.ne.jp [221.189.127.184])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 75A8F94E9; Fri, 13 Jul 2007 23:50:51 +0900 (JST)
Date:	Fri, 13 Jul 2007 23:51:46 +0900 (JST)
Message-Id: <20070713.235146.75426959.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Make show_code static and add __user tag
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/kernel/traps.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 6f3e5c1..37c562c 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -187,7 +187,7 @@ void dump_stack(void)
 
 EXPORT_SYMBOL(dump_stack);
 
-void show_code(unsigned int *pc)
+static void show_code(unsigned int __user *pc)
 {
 	long i;
 
@@ -305,7 +305,7 @@ void show_registers(struct pt_regs *regs)
 	printk("Process %s (pid: %d, threadinfo=%p, task=%p)\n",
 	        current->comm, current->pid, current_thread_info(), current);
 	show_stacktrace(current, regs);
-	show_code((unsigned int *) regs->cp0_epc);
+	show_code((unsigned int __user *) regs->cp0_epc);
 	printk("\n");
 }
 
@@ -865,7 +865,7 @@ asmlinkage void do_mcheck(struct pt_regs *regs)
 		dump_tlb_all();
 	}
 
-	show_code((unsigned int *) regs->cp0_epc);
+	show_code((unsigned int __user *) regs->cp0_epc);
 
 	/*
 	 * Some chips may have other causes of machine check (e.g. SB1
