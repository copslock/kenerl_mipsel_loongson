Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 14:40:06 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:49448 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491818Ab1EMMjt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2011 14:39:49 +0200
Received: by mail-fx0-f49.google.com with SMTP id 14so2302504fxm.36
        for <linux-mips@linux-mips.org>; Fri, 13 May 2011 05:39:49 -0700 (PDT)
Received: by 10.223.94.129 with SMTP id z1mr1680501fam.144.1305290388946;
        Fri, 13 May 2011 05:39:48 -0700 (PDT)
Received: from localhost.localdomain (540371FD.catv.pool.telekom.hu [84.3.113.253])
        by mx.google.com with ESMTPS id 18sm568268fan.25.2011.05.13.05.39.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 13 May 2011 05:39:47 -0700 (PDT)
From:   Gergely Kis <gergely@homejinni.com>
To:     linux-mips@linux-mips.org
Cc:     oprofile-list@lists.sourceforge.net,
        Daniel Kalmar <kalmard@homejinni.com>,
        Gergely Kis <gergely@homejinni.com>
Subject: [PATCH 1/2] MIPS: Add new unwind_stack variant
Date:   Fri, 13 May 2011 12:38:04 +0000
Message-Id: <1305290285-13818-2-git-send-email-gergely@homejinni.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1305290285-13818-1-git-send-email-gergely@homejinni.com>
References: <1305290285-13818-1-git-send-email-gergely@homejinni.com>
Return-Path: <gergely@homejinni.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gergely@homejinni.com
Precedence: bulk
X-list: linux-mips

From: Daniel Kalmar <kalmard@homejinni.com>

The unwind_stack_by_address variant supports unwinding based
on any kernel code address.
This symbol is also exported so it can be called from modules.

Signed-off-by: Daniel Kalmar <kalmard@homejinni.com>
Signed-off-by: Gergely Kis <gergely@homejinni.com>
---
 arch/mips/include/asm/stacktrace.h |    4 ++++
 arch/mips/kernel/process.c         |   18 +++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/stacktrace.h b/arch/mips/include/asm/stacktrace.h
index 0bf8281..780ee2c 100644
--- a/arch/mips/include/asm/stacktrace.h
+++ b/arch/mips/include/asm/stacktrace.h
@@ -7,6 +7,10 @@
 extern int raw_show_trace;
 extern unsigned long unwind_stack(struct task_struct *task, unsigned long *sp,
 				  unsigned long pc, unsigned long *ra);
+extern unsigned long unwind_stack_by_address(unsigned long stack_page,
+					     unsigned long *sp,
+					     unsigned long pc,
+					     unsigned long *ra);
 #else
 #define raw_show_trace 1
 static inline unsigned long unwind_stack(struct task_struct *task,
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index d2112d3..0acb274 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -373,18 +373,18 @@ unsigned long thread_saved_pc(struct task_struct *tsk)
 
 
 #ifdef CONFIG_KALLSYMS
-/* used by show_backtrace() */
-unsigned long unwind_stack(struct task_struct *task, unsigned long *sp,
-			   unsigned long pc, unsigned long *ra)
+/* generic stack unwinding function */
+unsigned long notrace unwind_stack_by_address(unsigned long stack_page,
+					      unsigned long *sp,
+					      unsigned long pc,
+					      unsigned long *ra)
 {
-	unsigned long stack_page;
 	struct mips_frame_info info;
 	unsigned long size, ofs;
 	int leaf;
 	extern void ret_from_irq(void);
 	extern void ret_from_exception(void);
 
-	stack_page = (unsigned long)task_stack_page(task);
 	if (!stack_page)
 		return 0;
 
@@ -443,6 +443,14 @@ unsigned long unwind_stack(struct task_struct *task, unsigned long *sp,
 	*ra = 0;
 	return __kernel_text_address(pc) ? pc : 0;
 }
+EXPORT_SYMBOL(unwind_stack_by_address);
+
+/* used by show_backtrace() */
+unsigned long unwind_stack(struct task_struct *task, unsigned long *sp,
+			   unsigned long pc, unsigned long *ra) {
+	unsigned long stack_page = (unsigned long)task_stack_page(task);
+	return unwind_stack_by_address(stack_page, sp, pc, ra);
+}
 #endif
 
 /*
-- 
1.7.0.4
