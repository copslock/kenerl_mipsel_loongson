Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Aug 2006 10:34:03 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.190]:5656 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133629AbWHAJ2O (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 1 Aug 2006 10:28:14 +0100
Received: by nf-out-0910.google.com with SMTP id q29so210810nfc
        for <linux-mips@linux-mips.org>; Tue, 01 Aug 2006 02:28:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bK20ZVS+dvWUJO7MNprE21TP7cWoDPWCBpkfkqbN9fyZy5gnRYDtSWqXjy2hYGydRvNN5kmReAIP0jiB8qLYiYU5Lkuiv1ZNot00My/7mx7hWsEpXEdAOnqz0JWxedogm9/5MM471kc0eVAtKne03NBf6JsDJEcJH640WqEDn9g=
Received: by 10.49.29.3 with SMTP id g3mr416874nfj;
        Tue, 01 Aug 2006 02:28:14 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id x27sm628564nfb.2006.08.01.02.28.13;
        Tue, 01 Aug 2006 02:28:14 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 549AC23F775; Tue,  1 Aug 2006 11:27:19 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	anemo@mba.ocn.ne.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 7/7] Allow unwind_stack() to return ra for leaf function
Date:	Tue,  1 Aug 2006 11:27:17 +0200
Message-Id: <1154424439969-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
In-Reply-To: <11544244373398-git-send-email-vagabon.xyz@gmail.com>
References: <11544244373398-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Since get_frame_info() is more robust, unwind_stack() can
returns ra value for leaf functions.

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 arch/mips/kernel/process.c |   20 ++++++++++++--------
 arch/mips/kernel/traps.c   |   15 ++++++---------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 539b23b..6377b17 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -445,14 +445,15 @@ #endif
 
 #ifdef CONFIG_KALLSYMS
 /* used by show_frametrace() */
-unsigned long unwind_stack(struct task_struct *task,
-			   unsigned long **sp, unsigned long pc)
+unsigned long unwind_stack(struct task_struct *task, unsigned long **sp,
+			   unsigned long pc, struct pt_regs *regs)
 {
 	unsigned long stack_page;
 	struct mips_frame_info info;
 	char *modname;
 	char namebuf[KSYM_NAME_LEN + 1];
 	unsigned long size, ofs;
+	int leaf;
 
 	stack_page = (unsigned long)task_stack_page(task);
 	if (!stack_page)
@@ -465,18 +466,21 @@ unsigned long unwind_stack(struct task_s
 
 	info.func = (void *)(pc - ofs);
 	info.func_size = ofs;	/* analyze from start to ofs */
-	if (get_frame_info(&info)) {
-		/* leaf or unknown */
-		*sp += info.frame_size / sizeof(long);
+	leaf = get_frame_info(&info);
+	if (leaf < 0)
 		return 0;
-	}
+
 	if ((unsigned long)*sp < stack_page ||
 	    (unsigned long)*sp + info.frame_size / sizeof(long) >
 	    stack_page + THREAD_SIZE - 32)
 		return 0;
 
-	pc = (*sp)[info.pc_offset];
+	if (leaf)
+		pc = regs->regs[31];
+	else
+		pc = (*sp)[info.pc_offset];
+
 	*sp += info.frame_size / sizeof(long);
-	return pc;
+	return __kernel_text_address(pc) ? pc : 0;
 }
 #endif
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 07191a6..78aed61 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -101,8 +101,9 @@ static int __init set_raw_show_trace(cha
 }
 __setup("raw_show_trace", set_raw_show_trace);
 
-extern unsigned long unwind_stack(struct task_struct *task,
-				  unsigned long **sp, unsigned long pc);
+extern unsigned long unwind_stack(struct task_struct *task, unsigned long **sp,
+				  unsigned long pc, struct pt_regs *regs);
+
 static void show_backtrace(struct task_struct *task, struct pt_regs *regs)
 {
 	unsigned long *sp = (long *)regs->regs[29];
@@ -114,14 +115,10 @@ static void show_backtrace(struct task_s
 		return;
 	}
 	printk("Call Trace:\n");
-	while (__kernel_text_address(pc)) {
+	do {
 		printk(" [<%0*lx>] ", 2 * sizeof(unsigned long), pc);
-		print_symbol("%s\n", pc);
-		pc = unwind_stack(task, &sp, pc);
-		if (top && pc == 0)
-			pc = regs->regs[31];	/* leaf? */
-		top = 0;
-	}
+ 		print_symbol("%s\n", pc);
+	} while ((pc = unwind_stack(task, &sp, pc, regs)));
 	printk("\n");
 }
 #else
-- 
1.4.2.rc2
