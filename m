Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 14:43:19 +0200 (CEST)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:56914 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011148AbbJWMnSRgGTl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 14:43:18 +0200
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd001.nsn-inter.net (8.15.2/8.15.2) with ESMTPS id t9NChC7X021298
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 23 Oct 2015 12:43:12 GMT
Received: from localhost.localdomain ([10.144.37.191])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id t9NChBG7009939;
        Fri, 23 Oct 2015 14:43:12 +0200
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: add LATENCYTOP support
Date:   Fri, 23 Oct 2015 15:39:02 +0300
Message-Id: <1445603942-24574-1-git-send-email-aaro.koskinen@nokia.com>
X-Mailer: git-send-email 2.4.3
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 2865
X-purgate-ID: 151667::1445604192-0000047E-23467075/0/0
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@nokia.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Add LATENCYTOP support for MIPS. Tested on OCTEON.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/mips/Kconfig             |  4 ++++
 arch/mips/kernel/stacktrace.c | 27 +++++++++++++++------------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e3aa5b0..eed6614 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2739,6 +2739,10 @@ config STACKTRACE_SUPPORT
 	bool
 	default y
 
+config HAVE_LATENCYTOP_SUPPORT
+	bool
+	default y
+
 config PGTABLE_LEVELS
 	int
 	default 3 if 64BIT && !PAGE_SIZE_64KB
diff --git a/arch/mips/kernel/stacktrace.c b/arch/mips/kernel/stacktrace.c
index 1ba775d..506021f 100644
--- a/arch/mips/kernel/stacktrace.c
+++ b/arch/mips/kernel/stacktrace.c
@@ -12,14 +12,15 @@
  * Save stack-backtrace addresses into a stack_trace buffer:
  */
 static void save_raw_context_stack(struct stack_trace *trace,
-	unsigned long reg29)
+	unsigned long reg29, int savesched)
 {
 	unsigned long *sp = (unsigned long *)reg29;
 	unsigned long addr;
 
 	while (!kstack_end(sp)) {
 		addr = *sp++;
-		if (__kernel_text_address(addr)) {
+		if (__kernel_text_address(addr) &&
+		    (savesched || !in_sched_functions(addr))) {
 			if (trace->skip > 0)
 				trace->skip--;
 			else
@@ -31,7 +32,7 @@ static void save_raw_context_stack(struct stack_trace *trace,
 }
 
 static void save_context_stack(struct stack_trace *trace,
-	struct task_struct *tsk, struct pt_regs *regs)
+	struct task_struct *tsk, struct pt_regs *regs, int savesched)
 {
 	unsigned long sp = regs->regs[29];
 #ifdef CONFIG_KALLSYMS
@@ -43,20 +44,22 @@ static void save_context_stack(struct stack_trace *trace,
 			(unsigned long)task_stack_page(tsk);
 		if (stack_page && sp >= stack_page &&
 		    sp <= stack_page + THREAD_SIZE - 32)
-			save_raw_context_stack(trace, sp);
+			save_raw_context_stack(trace, sp, savesched);
 		return;
 	}
 	do {
-		if (trace->skip > 0)
-			trace->skip--;
-		else
-			trace->entries[trace->nr_entries++] = pc;
-		if (trace->nr_entries >= trace->max_entries)
-			break;
+		if (savesched || !in_sched_functions(pc)) {
+			if (trace->skip > 0)
+				trace->skip--;
+			else
+				trace->entries[trace->nr_entries++] = pc;
+			if (trace->nr_entries >= trace->max_entries)
+				break;
+		}
 		pc = unwind_stack(tsk, &sp, pc, &ra);
 	} while (pc);
 #else
-	save_raw_context_stack(trace, sp);
+	save_raw_context_stack(trace, sp, savesched);
 #endif
 }
 
@@ -82,6 +85,6 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 		regs->cp0_epc = tsk->thread.reg31;
 	} else
 		prepare_frametrace(regs);
-	save_context_stack(trace, tsk, regs);
+	save_context_stack(trace, tsk, regs, tsk == current);
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
-- 
2.4.3
