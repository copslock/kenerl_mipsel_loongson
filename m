Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Aug 2006 08:36:25 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.186]:53373 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133801AbWHCHaO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Aug 2006 08:30:14 +0100
Received: by nf-out-0910.google.com with SMTP id q29so939686nfc
        for <linux-mips@linux-mips.org>; Thu, 03 Aug 2006 00:30:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NzQkUYf9YwnCKnSATBFUv8E8nW2IBx1bZF+OKiNNWn1pLlmx95Cwd5HKjGHK+01sY1s3rMd6/kZrxG9o+ISMy+DN0Gz156Fnd8WqgnOKZJD0xCO2tGFH72BXcBGtYTwgNYKsJodwdgUN7SrT7VnCsZA8pXS+1yq47sJg4Mql2IY=
Received: by 10.49.75.2 with SMTP id c2mr3355672nfl;
        Thu, 03 Aug 2006 00:30:14 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id g1sm655182nfe.2006.08.03.00.30.13;
        Thu, 03 Aug 2006 00:30:14 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 4439A23F775; Thu,  3 Aug 2006 09:29:22 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	anemo@mba.ocn.ne.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 7/7] Improve unwind_stack()
Date:	Thu,  3 Aug 2006 09:29:21 +0200
Message-Id: <11545901621525-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
In-Reply-To: <11545901611096-git-send-email-vagabon.xyz@gmail.com>
References: <11545901611096-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

This patch allows unwind_stack() to return ra for leaf function.
But it tries to detects cases where get_frame_info() wrongly
consider nested function as a leaf one.

It also pass 'unsinged long *sp' instead of 'unsigned long **sp'
as second parameter. The code looks cleaner.

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 arch/mips/kernel/process.c |   35 ++++++++++++++++++++++-------------
 arch/mips/kernel/traps.c   |   24 ++++++++++++------------
 2 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 309bfa4..951bf9c 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -448,15 +448,16 @@ #endif
 }
 
 #ifdef CONFIG_KALLSYMS
-/* used by show_frametrace() */
-unsigned long unwind_stack(struct task_struct *task,
-			   unsigned long **sp, unsigned long pc)
+/* used by show_backtrace() */
+unsigned long unwind_stack(struct task_struct *task, unsigned long *sp,
+			   unsigned long pc, unsigned long ra)
 {
 	unsigned long stack_page;
 	struct mips_frame_info info;
 	char *modname;
 	char namebuf[KSYM_NAME_LEN + 1];
 	unsigned long size, ofs;
+	int leaf;
 
 	stack_page = (unsigned long)task_stack_page(task);
 	if (!stack_page)
@@ -469,18 +470,26 @@ unsigned long unwind_stack(struct task_s
 
 	info.func = (void *)(pc - ofs);
 	info.func_size = ofs;	/* analyze from start to ofs */
-	if (get_frame_info(&info)) {
-		/* leaf or unknown */
-		*sp += info.frame_size / sizeof(long);
+	leaf = get_frame_info(&info);
+	if (leaf < 0)
 		return 0;
-	}
-	if ((unsigned long)*sp < stack_page ||
-	    (unsigned long)*sp + info.frame_size / sizeof(long) >
-	    stack_page + THREAD_SIZE - 32)
+
+	if (*sp < stack_page ||
+	    *sp + info.frame_size > stack_page + THREAD_SIZE - 32)
 		return 0;
 
-	pc = (*sp)[info.pc_offset];
-	*sp += info.frame_size / sizeof(long);
-	return pc;
+	if (leaf)
+		/*
+		 * For some extreme cases, get_frame_info() can
+		 * consider wrongly a nested function as a leaf
+		 * one. In that cases avoid to return always the
+		 * same value.
+		 */
+		pc = pc != ra ? ra : 0;
+	else
+		pc = ((unsigned long *)(*sp))[info.pc_offset];
+
+	*sp += info.frame_size;
+	return __kernel_text_address(pc) ? pc : 0;
 }
 #endif
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 303f008..ab77034 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -74,8 +74,9 @@ void (*board_ejtag_handler_setup)(void);
 void (*board_bind_eic_interrupt)(int irq, int regset);
 
 
-static void show_raw_backtrace(unsigned long *sp)
+static void show_raw_backtrace(unsigned long reg29)
 {
+	unsigned long *sp = (unsigned long *)reg29;
 	unsigned long addr;
 
 	printk("Call Trace:");
@@ -99,30 +100,29 @@ static int __init set_raw_show_trace(cha
 }
 __setup("raw_show_trace", set_raw_show_trace);
 
-extern unsigned long unwind_stack(struct task_struct *task,
-				  unsigned long **sp, unsigned long pc);
+extern unsigned long unwind_stack(struct task_struct *task, unsigned long *sp,
+				  unsigned long pc, unsigned long ra);
+
 static void show_backtrace(struct task_struct *task, struct pt_regs *regs)
 {
-	unsigned long *sp = (long *)regs->regs[29];
+	unsigned long sp = regs->regs[29];
+	unsigned long ra = regs->regs[31];
 	unsigned long pc = regs->cp0_epc;
-	int top = 1;
 
 	if (raw_show_trace || !__kernel_text_address(pc)) {
 		show_raw_backtrace(sp);
 		return;
 	}
 	printk("Call Trace:\n");
-	while (__kernel_text_address(pc)) {
+	do {
 		print_ip_sym(pc);
-		pc = unwind_stack(task, &sp, pc);
-		if (top && pc == 0)
-			pc = regs->regs[31];	/* leaf? */
-		top = 0;
-	}
+		pc = unwind_stack(task, &sp, pc, ra);
+		ra = 0;
+	} while (pc);
 	printk("\n");
 }
 #else
-#define show_backtrace(task, r) show_raw_backtrace((long *)(r)->regs[29]);
+#define show_backtrace(task, r) show_raw_backtrace((r)->regs[29]);
 #endif
 
 /*
-- 
1.4.2.rc2
