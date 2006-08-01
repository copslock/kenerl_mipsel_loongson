Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Aug 2006 10:32:20 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.185]:2584 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133621AbWHAJ2O (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 1 Aug 2006 10:28:14 +0100
Received: by nf-out-0910.google.com with SMTP id q29so210812nfc
        for <linux-mips@linux-mips.org>; Tue, 01 Aug 2006 02:28:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kMov9A5uPO7hXlariBgNoChz+tDes9/Zp0WBaKlyL3eavJ/TLZH3U86m4M0mj8T/geVDbbOOM+p3fJ8/c3Ys+TQYYKv8FU2hYNhADnRAY3EBkdSHLvAx7/w48H7W9EUGETlAfe8NtpZZ9DIrTTKRKyg/Fw3kkmS4Ty+8WrzRE9w=
Received: by 10.49.93.13 with SMTP id v13mr389577nfl;
        Tue, 01 Aug 2006 02:28:13 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id l21sm702657nfc.2006.08.01.02.28.13;
        Tue, 01 Aug 2006 02:28:13 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 151D623F76E; Tue,  1 Aug 2006 11:27:19 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	anemo@mba.ocn.ne.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 5/7] Miscellaneous cleanup in prologue analysis code
Date:	Tue,  1 Aug 2006 11:27:15 +0200
Message-Id: <1154424438145-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
In-Reply-To: <11544244373398-git-send-email-vagabon.xyz@gmail.com>
References: <11544244373398-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

We usually use backtrace term for dumping a call tree during
debug. Therefore this patch renames show_frametrace() into
show_backtrace().

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 arch/mips/kernel/traps.c |   26 ++++++++++++--------------
 1 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 4a11a3d..15fa445 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -74,19 +74,18 @@ void (*board_ejtag_handler_setup)(void);
 void (*board_bind_eic_interrupt)(int irq, int regset);
 
 
-static void show_trace(unsigned long *stack)
+static void show_trace(unsigned long *sp)
 {
-	const int field = 2 * sizeof(unsigned long);
 	unsigned long addr;
 
 	printk("Call Trace:");
 #ifdef CONFIG_KALLSYMS
 	printk("\n");
 #endif
-	while (!kstack_end(stack)) {
-		addr = *stack++;
+	while (!kstack_end(sp)) {
+		addr = *sp++;
 		if (__kernel_text_address(addr)) {
-			printk(" [<%0*lx>] ", field, addr);
+			printk(" [<%0*lx>] ", 2 * sizeof(unsigned long), addr);
 			print_symbol("%s\n", addr);
 		}
 	}
@@ -104,22 +103,21 @@ __setup("raw_show_trace", set_raw_show_t
 
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
+		show_trace(sp);
 		return;
 	}
 	printk("Call Trace:\n");
 	while (__kernel_text_address(pc)) {
-		printk(" [<%0*lx>] ", field, pc);
+		printk(" [<%0*lx>] ", 2 * sizeof(unsigned long), pc);
 		print_symbol("%s\n", pc);
-		pc = unwind_stack(task, &stack, pc);
+		pc = unwind_stack(task, &sp, pc);
 		if (top && pc == 0)
 			pc = regs->regs[31];	/* leaf? */
 		top = 0;
@@ -127,7 +125,7 @@ static void show_frametrace(struct task_
 	printk("\n");
 }
 #else
-#define show_frametrace(task, r) show_trace((long *)(r)->regs[29]);
+#define show_backtrace(task, r) show_trace((long *)(r)->regs[29]);
 #endif
 
 /*
@@ -160,7 +158,7 @@ static void show_stacktrace(struct task_
 		i++;
 	}
 	printk("\n");
-	show_frametrace(task, regs);
+	show_backtrace(task, regs);
 }
 
 static noinline void prepare_frametrace(struct pt_regs *regs)
@@ -211,7 +209,7 @@ #ifdef CONFIG_KALLSYMS
 	if (!raw_show_trace) {
 		struct pt_regs regs;
 		prepare_frametrace(&regs);
-		show_frametrace(current, &regs);
+		show_backtrace(current, &regs);
 		return;
 	}
 #endif
-- 
1.4.2.rc2
