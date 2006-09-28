Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2006 11:15:39 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:9230 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20038570AbWI1KPh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Sep 2006 11:15:37 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 28 Sep 2006 19:15:36 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 7764F417CB;
	Thu, 28 Sep 2006 19:15:34 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 64890416FC;
	Thu, 28 Sep 2006 19:15:34 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k8SAFYW0075377;
	Thu, 28 Sep 2006 19:15:34 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 28 Sep 2006 19:15:33 +0900 (JST)
Message-Id: <20060928.191533.87997956.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] stacktrace build-fix and improvement
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
X-archive-position: 12710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Fix build error due to stacktrace API change.  Now save_stack_trace()
tries to save all kernel context, including interrupts and exception.
Also some asm code are changed a bit so that we can detect the end of
current context easily.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 kernel/genex.S      |    8 ++++----
 kernel/stacktrace.c |   52 +++++++++++++++++++++++-----------------------------
 mm/tlbex-fault.S    |    4 ++--
 3 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 37fda3d..af6ef2f 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -220,8 +220,8 @@ #endif /* CONFIG_MIPS_MT_SMTC */
 	CLI
 	TRACE_IRQS_OFF
 	move	a0, sp
-	jalr	v0
-	j	ret_from_irq
+	PTR_LA	ra, ret_from_irq
+	jr	v0
 	END(except_vec_vi_handler)
 
 /*
@@ -349,8 +349,8 @@ #endif
 	.set	at
 	__BUILD_\verbose \exception
 	move	a0, sp
-	jal	do_\handler
-	j	ret_from_exception
+	PTR_LA	ra, ret_from_exception
+	j	do_\handler
 	END(handle_\exception)
 	.endm
 
diff --git a/arch/mips/kernel/stacktrace.c b/arch/mips/kernel/stacktrace.c
index f851d0c..676e6f6 100644
--- a/arch/mips/kernel/stacktrace.c
+++ b/arch/mips/kernel/stacktrace.c
@@ -13,7 +13,7 @@ #include <asm/stacktrace.h>
  * Save stack-backtrace addresses into a stack_trace buffer:
  */
 static void save_raw_context_stack(struct stack_trace *trace,
-	unsigned int skip, unsigned long reg29)
+	unsigned long reg29)
 {
 	unsigned long *sp = (unsigned long *)reg29;
 	unsigned long addr;
@@ -21,10 +21,10 @@ static void save_raw_context_stack(struc
 	while (!kstack_end(sp)) {
 		addr = *sp++;
 		if (__kernel_text_address(addr)) {
-			if (!skip)
-				trace->entries[trace->nr_entries++] = addr;
+			if (trace->skip > 0)
+				trace->skip--;
 			else
-				skip--;
+				trace->entries[trace->nr_entries++] = addr;
 			if (trace->nr_entries >= trace->max_entries)
 				break;
 		}
@@ -32,37 +32,40 @@ static void save_raw_context_stack(struc
 }
 
 static struct pt_regs * save_context_stack(struct stack_trace *trace,
-	unsigned int skip, struct task_struct *task, struct pt_regs *regs)
+	struct task_struct *task, struct pt_regs *regs)
 {
 	unsigned long sp = regs->regs[29];
 #ifdef CONFIG_KALLSYMS
 	unsigned long ra = regs->regs[31];
 	unsigned long pc = regs->cp0_epc;
+	unsigned long stack_page =
+		(unsigned long)task_stack_page(task);
 	extern void ret_from_irq(void);
+	extern void ret_from_exception(void);
 
 	if (raw_show_trace || !__kernel_text_address(pc)) {
-		save_raw_context_stack(trace, skip, sp);
+		if (stack_page && sp >= stack_page &&
+		    sp <= stack_page + THREAD_SIZE - 32)
+			save_raw_context_stack(trace, sp);
 		return NULL;
 	}
 	do {
-		if (!skip)
-			trace->entries[trace->nr_entries++] = pc;
+		if (trace->skip > 0)
+			trace->skip--;
 		else
-			skip--;
+			trace->entries[trace->nr_entries++] = pc;
 		if (trace->nr_entries >= trace->max_entries)
 			break;
 		/*
 		 * If we reached the bottom of interrupt context,
 		 * return saved pt_regs.
 		 */
-		if (pc == (unsigned long)ret_from_irq) {
-			unsigned long stack_page =
-				(unsigned long)task_stack_page(task);
-			if (!stack_page ||
-			    sp < stack_page ||
-			    sp > stack_page + THREAD_SIZE - 32)
-				break;
-			return (struct pt_regs *)sp;
+		if (pc == (unsigned long)ret_from_irq ||
+		    pc == (unsigned long)ret_from_exception) {
+			if (stack_page && sp >= stack_page &&
+			    sp <= stack_page + THREAD_SIZE - 32)
+				return (struct pt_regs *)sp;
+			break;
 		}
 		pc = unwind_stack(task, &sp, pc, ra);
 		ra = 0;
@@ -76,12 +79,8 @@ #endif
 
 /*
  * Save stack-backtrace addresses into a stack_trace buffer.
- * If all_contexts is set, all contexts (hardirq, softirq and process)
- * are saved. If not set then only the current context is saved.
  */
-void save_stack_trace(struct stack_trace *trace,
-		      struct task_struct *task, int all_contexts,
-		      unsigned int skip)
+void save_stack_trace(struct stack_trace *trace, struct task_struct *task)
 {
 	struct pt_regs dummyregs;
 	struct pt_regs *regs = &dummyregs;
@@ -99,13 +98,8 @@ void save_stack_trace(struct stack_trace
 	}
 
 	while (1) {
-		regs = save_context_stack(trace, skip, task, regs);
-		if (!all_contexts || !regs ||
-		    trace->nr_entries >= trace->max_entries)
-			break;
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
-		if (trace->nr_entries >= trace->max_entries)
+		regs = save_context_stack(trace, task, regs);
+		if (!regs || trace->nr_entries >= trace->max_entries)
 			break;
-		skip = 0;
 	}
 }
diff --git a/arch/mips/mm/tlbex-fault.S b/arch/mips/mm/tlbex-fault.S
index 9e7f417..e99eaa1 100644
--- a/arch/mips/mm/tlbex-fault.S
+++ b/arch/mips/mm/tlbex-fault.S
@@ -19,8 +19,8 @@ #include <asm/stackframe.h>
 	move	a0, sp
 	REG_S	a2, PT_BVADDR(sp)
 	li	a1, \write
-	jal	do_page_fault
-	j	ret_from_exception
+	PTR_LA	ra, ret_from_exception
+	j	do_page_fault
 	END(tlb_do_page_fault_\write)
 	.endm
 
