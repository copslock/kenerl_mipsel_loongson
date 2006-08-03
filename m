Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Aug 2006 08:34:21 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.189]:59516 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133788AbWHCHaN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Aug 2006 08:30:13 +0100
Received: by nf-out-0910.google.com with SMTP id q29so939690nfc
        for <linux-mips@linux-mips.org>; Thu, 03 Aug 2006 00:30:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=g6Azc9dqZ0YZ2B0zdaDxvX8rOnH2Ox+V5leCmHTsBeOXLGdARMfT+C+zLjFCsRhwx3wyO78z+4T8pJSc7GE+us3fvBK2d0/ihUnh2FgB7P5ZI2BMhIiO66VJk3WEh+oSL3OuHRnLIPFK4nKzpok9ZtJ4fLKKQ11TOAIRs71v4AQ=
Received: by 10.49.93.13 with SMTP id v13mr2073808nfl;
        Thu, 03 Aug 2006 00:30:13 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id k9sm661790nfc.2006.08.03.00.30.12;
        Thu, 03 Aug 2006 00:30:13 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 8232A23F76E; Thu,  3 Aug 2006 09:29:21 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	anemo@mba.ocn.ne.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 3/7] Miscellaneous cleanup in prologue analysis code
Date:	Thu,  3 Aug 2006 09:29:17 +0200
Message-Id: <11545901613315-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
In-Reply-To: <11545901611096-git-send-email-vagabon.xyz@gmail.com>
References: <11545901611096-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

We usually use backtrace term for dumping a call tree during
debug. Therefore this patch renames show_frametrace() into
show_backtrace() and show_trace() into show_raw_backtrace().

It also uses the new function print_ip_sym().

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 arch/mips/kernel/traps.c |   33 ++++++++++++++-------------------
 1 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 4a11a3d..549cbb8 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -74,21 +74,18 @@ void (*board_ejtag_handler_setup)(void);
 void (*board_bind_eic_interrupt)(int irq, int regset);
 
 
-static void show_trace(unsigned long *stack)
+static void show_raw_backtrace(unsigned long *sp)
 {
-	const int field = 2 * sizeof(unsigned long);
 	unsigned long addr;
 
 	printk("Call Trace:");
 #ifdef CONFIG_KALLSYMS
 	printk("\n");
 #endif
-	while (!kstack_end(stack)) {
-		addr = *stack++;
-		if (__kernel_text_address(addr)) {
-			printk(" [<%0*lx>] ", field, addr);
-			print_symbol("%s\n", addr);
-		}
+	while (!kstack_end(sp)) {
+		addr = *sp++;
+		if (__kernel_text_address(addr))
+			print_ip_sym(addr);
 	}
 	printk("\n");
 }
@@ -104,22 +101,20 @@ __setup("raw_show_trace", set_raw_show_t
 
 extern unsigned long unwind_stack(struct task_struct *task,
 				  unsigned long **sp, unsigned long pc);
-static void show_frametrace(struct task_struct *task, struct pt_regs *regs)
+static void show_backtrace(struct task_struct *task, struct pt_regs *regs)
 {
-	const int field = 2 * sizeof(unsigned long);
-	unsigned long *stack = (long *)regs->regs[29];
+	unsigned long *sp = (long *)regs->regs[29];
 	unsigned long pc = regs->cp0_epc;
 	int top = 1;
 
 	if (raw_show_trace || !__kernel_text_address(pc)) {
-		show_trace(stack);
+		show_raw_backtrace(sp);
 		return;
 	}
 	printk("Call Trace:\n");
 	while (__kernel_text_address(pc)) {
-		printk(" [<%0*lx>] ", field, pc);
-		print_symbol("%s\n", pc);
-		pc = unwind_stack(task, &stack, pc);
+		print_ip_sym(pc);
+		pc = unwind_stack(task, &sp, pc);
 		if (top && pc == 0)
 			pc = regs->regs[31];	/* leaf? */
 		top = 0;
@@ -127,7 +122,7 @@ static void show_frametrace(struct task_
 	printk("\n");
 }
 #else
-#define show_frametrace(task, r) show_trace((long *)(r)->regs[29]);
+#define show_backtrace(task, r) show_raw_backtrace((long *)(r)->regs[29]);
 #endif
 
 /*
@@ -160,7 +155,7 @@ static void show_stacktrace(struct task_
 		i++;
 	}
 	printk("\n");
-	show_frametrace(task, regs);
+	show_backtrace(task, regs);
 }
 
 static noinline void prepare_frametrace(struct pt_regs *regs)
@@ -211,11 +206,11 @@ #ifdef CONFIG_KALLSYMS
 	if (!raw_show_trace) {
 		struct pt_regs regs;
 		prepare_frametrace(&regs);
-		show_frametrace(current, &regs);
+		show_backtrace(current, &regs);
 		return;
 	}
 #endif
-	show_trace(&stack);
+	show_raw_backtrace(&stack);
 }
 
 EXPORT_SYMBOL(dump_stack);
-- 
1.4.2.rc2
