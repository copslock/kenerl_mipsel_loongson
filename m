Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Aug 2010 23:57:53 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:5589 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492182Ab0HCV5s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Aug 2010 23:57:48 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c5890f60000>; Tue, 03 Aug 2010 14:58:14 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 3 Aug 2010 14:57:45 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 3 Aug 2010 14:57:45 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o73Lvg6L027414;
        Tue, 3 Aug 2010 14:57:42 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o73LveMZ027413;
        Tue, 3 Aug 2010 14:57:40 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Remove unused task_struct.trap_no field.
Date:   Tue,  3 Aug 2010 14:57:39 -0700
Message-Id: <1280872659-27372-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
X-OriginalArrivalTime: 03 Aug 2010 21:57:45.0380 (UTC) FILETIME=[E7780E40:01CB3356]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

It is initialized to zero and only ever read.  Remove it, and pass
zero in its place.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/processor.h |    2 --
 arch/mips/kernel/asm-offsets.c    |    1 -
 arch/mips/kernel/traps.c          |    2 +-
 3 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 24d91f8..0d629bb 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -229,7 +229,6 @@ struct thread_struct {
 	unsigned long cp0_badvaddr;	/* Last user fault */
 	unsigned long cp0_baduaddr;	/* Last kernel fault accessing USEG */
 	unsigned long error_code;
-	unsigned long trap_no;
 	unsigned long irix_trampoline;  /* Wheee... */
 	unsigned long irix_oldctx;
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
@@ -301,7 +300,6 @@ struct thread_struct {
 	.cp0_badvaddr		= 0,				\
 	.cp0_baduaddr		= 0,				\
 	.error_code		= 0,				\
-	.trap_no		= 0,				\
 	.irix_trampoline	= 0,				\
 	.irix_oldctx		= 0,				\
 	/*							\
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index ca6c832..6b30fb2 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -126,7 +126,6 @@ void output_thread_defines(void)
 	       thread.cp0_baduaddr);
 	OFFSET(THREAD_ECODE, task_struct, \
 	       thread.error_code);
-	OFFSET(THREAD_TRAPNO, task_struct, thread.trap_no);
 	OFFSET(THREAD_TRAMP, task_struct, \
 	       thread.irix_trampoline);
 	OFFSET(THREAD_OLDCTX, task_struct, \
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index fb6e93b..9d71774 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -388,7 +388,7 @@ void __noreturn die(const char * str, struct pt_regs * regs)
 	mips_mt_regdump(dvpret);
 #endif /* CONFIG_MIPS_MT_SMTC */
 
-	if (notify_die(DIE_OOPS, str, regs, 0, current->thread.trap_no, SIGSEGV) == NOTIFY_STOP)
+	if (notify_die(DIE_OOPS, str, regs, 0, 0, SIGSEGV) == NOTIFY_STOP)
 		sig = 0;
 
 	printk("%s[#%d]:\n", str, ++die_counter);
-- 
1.7.1.1
