Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2006 10:02:58 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:3594 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037878AbWI2JC4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Sep 2006 10:02:56 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 29 Sep 2006 18:02:54 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 2D58229995;
	Fri, 29 Sep 2006 18:02:52 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 196AC2423E;
	Fri, 29 Sep 2006 18:02:52 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k8T92pW0080014;
	Fri, 29 Sep 2006 18:02:52 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 29 Sep 2006 18:02:51 +0900 (JST)
Message-Id: <20060929.180251.108982150.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] make unwind_stack() can dig into interrupted context
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 12728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

If the PC was ret_from_irq or ret_from_exception, there will be no
more normal stackframe.  Instead of stopping the unwinding, use PC and
RA saved by an exception handler to continue unwinding into the
interrupted context.  This also simplifies CONFIG_STACKTRACE codes.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 arch/mips/kernel/process.c    |   36 +++++++++++++++++++++++++++++++-----
 arch/mips/kernel/stacktrace.c |   32 ++++++--------------------------
 arch/mips/kernel/traps.c      |    3 +--
 include/asm-mips/stacktrace.h |    2 +-
 4 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 6955380..045d987 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -399,7 +399,7 @@ unsigned long thread_saved_pc(struct tas
 #ifdef CONFIG_KALLSYMS
 /* used by show_backtrace() */
 unsigned long unwind_stack(struct task_struct *task, unsigned long *sp,
-			   unsigned long pc, unsigned long ra)
+			   unsigned long pc, unsigned long *ra)
 {
 	unsigned long stack_page;
 	struct mips_frame_info info;
@@ -407,18 +407,42 @@ unsigned long unwind_stack(struct task_s
 	char namebuf[KSYM_NAME_LEN + 1];
 	unsigned long size, ofs;
 	int leaf;
+	extern void ret_from_irq(void);
+	extern void ret_from_exception(void);
 
 	stack_page = (unsigned long)task_stack_page(task);
 	if (!stack_page)
 		return 0;
 
+	/*
+	 * If we reached the bottom of interrupt context,
+	 * return saved pc in pt_regs.
+	 */
+	if (pc == (unsigned long)ret_from_irq ||
+	    pc == (unsigned long)ret_from_exception) {
+		struct pt_regs *regs;
+		if (*sp >= stack_page &&
+		    *sp + sizeof(*regs) <= stack_page + THREAD_SIZE - 32) {
+			regs = (struct pt_regs *)*sp;
+			pc = regs->cp0_epc;
+			if (__kernel_text_address(pc)) {
+				*sp = regs->regs[29];
+				*ra = regs->regs[31];
+				return pc;
+			}
+		}
+		return 0;
+	}
 	if (!kallsyms_lookup(pc, &size, &ofs, &modname, namebuf))
 		return 0;
 	/*
 	 * Return ra if an exception occured at the first instruction
 	 */
-	if (unlikely(ofs == 0))
-		return ra;
+	if (unlikely(ofs == 0)) {
+		pc = *ra;
+		*ra = 0;
+		return pc;
+	}
 
 	info.func = (void *)(pc - ofs);
 	info.func_size = ofs;	/* analyze from start to ofs */
@@ -437,11 +461,12 @@ unsigned long unwind_stack(struct task_s
 		 * one. In that cases avoid to return always the
 		 * same value.
 		 */
-		pc = pc != ra ? ra : 0;
+		pc = pc != *ra ? *ra : 0;
 	else
 		pc = ((unsigned long *)(*sp))[info.pc_offset];
 
 	*sp += info.frame_size;
+	*ra = 0;
 	return __kernel_text_address(pc) ? pc : 0;
 }
 #endif
@@ -454,6 +479,7 @@ unsigned long get_wchan(struct task_stru
 	unsigned long pc = 0;
 #ifdef CONFIG_KALLSYMS
 	unsigned long sp;
+	unsigned long ra = 0;
 #endif
 
 	if (!task || task == current || task->state == TASK_RUNNING)
@@ -467,7 +493,7 @@ #ifdef CONFIG_KALLSYMS
 	sp = task->thread.reg29 + schedule_mfi.frame_size;
 
 	while (in_sched_functions(pc))
-		pc = unwind_stack(task, &sp, pc, 0);
+		pc = unwind_stack(task, &sp, pc, &ra);
 #endif
 
 out:
diff --git a/arch/mips/kernel/stacktrace.c b/arch/mips/kernel/stacktrace.c
index 676e6f6..4aabe52 100644
--- a/arch/mips/kernel/stacktrace.c
+++ b/arch/mips/kernel/stacktrace.c
@@ -31,23 +31,21 @@ static void save_raw_context_stack(struc
 	}
 }
 
-static struct pt_regs * save_context_stack(struct stack_trace *trace,
+static void save_context_stack(struct stack_trace *trace,
 	struct task_struct *task, struct pt_regs *regs)
 {
 	unsigned long sp = regs->regs[29];
 #ifdef CONFIG_KALLSYMS
 	unsigned long ra = regs->regs[31];
 	unsigned long pc = regs->cp0_epc;
-	unsigned long stack_page =
-		(unsigned long)task_stack_page(task);
-	extern void ret_from_irq(void);
-	extern void ret_from_exception(void);
 
 	if (raw_show_trace || !__kernel_text_address(pc)) {
+		unsigned long stack_page =
+			(unsigned long)task_stack_page(task);
 		if (stack_page && sp >= stack_page &&
 		    sp <= stack_page + THREAD_SIZE - 32)
 			save_raw_context_stack(trace, sp);
-		return NULL;
+		return;
 	}
 	do {
 		if (trace->skip > 0)
@@ -56,25 +54,11 @@ #ifdef CONFIG_KALLSYMS
 			trace->entries[trace->nr_entries++] = pc;
 		if (trace->nr_entries >= trace->max_entries)
 			break;
-		/*
-		 * If we reached the bottom of interrupt context,
-		 * return saved pt_regs.
-		 */
-		if (pc == (unsigned long)ret_from_irq ||
-		    pc == (unsigned long)ret_from_exception) {
-			if (stack_page && sp >= stack_page &&
-			    sp <= stack_page + THREAD_SIZE - 32)
-				return (struct pt_regs *)sp;
-			break;
-		}
-		pc = unwind_stack(task, &sp, pc, ra);
-		ra = 0;
+		pc = unwind_stack(task, &sp, pc, &ra);
 	} while (pc);
 #else
 	save_raw_context_stack(sp);
 #endif
-
-	return NULL;
 }
 
 /*
@@ -97,9 +81,5 @@ void save_stack_trace(struct stack_trace
 		prepare_frametrace(regs);
 	}
 
-	while (1) {
-		regs = save_context_stack(trace, task, regs);
-		if (!regs || trace->nr_entries >= trace->max_entries)
-			break;
-	}
+	save_context_stack(trace, task, regs);
 }
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index bd90db5..b417973 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -116,8 +116,7 @@ static void show_backtrace(struct task_s
 	printk("Call Trace:\n");
 	do {
 		print_ip_sym(pc);
-		pc = unwind_stack(task, &sp, pc, ra);
-		ra = 0;
+		pc = unwind_stack(task, &sp, pc, &ra);
 	} while (pc);
 	printk("\n");
 }
diff --git a/include/asm-mips/stacktrace.h b/include/asm-mips/stacktrace.h
index 231f6f8..07f8733 100644
--- a/include/asm-mips/stacktrace.h
+++ b/include/asm-mips/stacktrace.h
@@ -6,7 +6,7 @@ #include <asm/ptrace.h>
 #ifdef CONFIG_KALLSYMS
 extern int raw_show_trace;
 extern unsigned long unwind_stack(struct task_struct *task, unsigned long *sp,
-				  unsigned long pc, unsigned long ra);
+				  unsigned long pc, unsigned long *ra);
 #else
 #define raw_show_trace 1
 #define unwind_stack(task, sp, pc, ra)	0
