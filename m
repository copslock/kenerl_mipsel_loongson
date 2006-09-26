Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2006 15:42:06 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:35540 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037584AbWIZOl5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Sep 2006 15:41:57 +0100
Received: from localhost (p5240-ipad201funabasi.chiba.ocn.ne.jp [222.146.68.240])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C29B661EC; Tue, 26 Sep 2006 23:41:52 +0900 (JST)
Date:	Tue, 26 Sep 2006 23:44:01 +0900 (JST)
Message-Id: <20060926.234401.08077257.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, mingo@redhat.com
Subject: [PATCH 2/3] [MIPS] lockdep: add STACKTRACE_SUPPORT and enable
 LOCKDEP_SUPPORT
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Implement stacktrace interface by using unwind_stack().
And enable lockdep support.

This is a patch againt linux-mips.org git tree.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 arch/mips/Kconfig             |    8 ++
 arch/mips/kernel/Makefile     |    1 
 arch/mips/kernel/process.c    |    1 
 arch/mips/kernel/stacktrace.c |  113 ++++++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/traps.c      |   37 +------------
 include/asm-mips/stacktrace.h |   44 ++++++++++++++++
 6 files changed, 170 insertions(+), 34 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 929b9b4..c8bcf0e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1836,6 +1836,14 @@ config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
 
+config LOCKDEP_SUPPORT
+	bool
+	default y
+
+config STACKTRACE_SUPPORT
+	bool
+	default y
+
 source "init/Kconfig"
 
 menu "Bus options (PCI, PCMCIA, EISA, ISA, TC)"
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 881c467..cd9cec9 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -11,6 +11,7 @@ obj-y		+= cpu-probe.o branch.o entry.o g
 binfmt_irix-objs	:= irixelf.o irixinv.o irixioctl.o irixsig.o	\
 			   irix5sys.o sysirix.o
 
+obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_MODULES)		+= mips_ksyms.o module.o
 
 obj-$(CONFIG_APM)		+= apm.o
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 951bf9c..277fdce 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -40,6 +40,7 @@ #include <asm/io.h>
 #include <asm/elf.h>
 #include <asm/isadep.h>
 #include <asm/inst.h>
+#include <asm/stacktrace.h>
 #ifdef CONFIG_MIPS_MT_SMTC
 #include <asm/mipsmtregs.h>
 extern void smtc_idle_loop_hook(void);
diff --git a/arch/mips/kernel/stacktrace.c b/arch/mips/kernel/stacktrace.c
new file mode 100644
index 0000000..c258088
--- /dev/null
+++ b/arch/mips/kernel/stacktrace.c
@@ -0,0 +1,113 @@
+/*
+ * arch/mips/kernel/stacktrace.c
+ *
+ * Stack trace management functions
+ *
+ *  Copyright (C) 2006 Atsushi Nemoto <anemo@mba.ocn.ne.jp>
+ */
+#include <linux/sched.h>
+#include <linux/stacktrace.h>
+#include <asm/stacktrace.h>
+
+/*
+ * Save stack-backtrace addresses into a stack_trace buffer:
+ */
+static inline void
+save_raw_context_stack(struct stack_trace *trace, unsigned int skip,
+		       unsigned long reg29)
+{
+	unsigned long *sp = (unsigned long *)reg29;
+	unsigned long addr;
+
+	while (!kstack_end(sp)) {
+		addr = *sp++;
+		if (__kernel_text_address(addr)) {
+			if (!skip)
+				trace->entries[trace->nr_entries++] = addr;
+			else
+				skip--;
+			if (trace->nr_entries >= trace->max_entries)
+				break;
+		}
+	}
+}
+
+static inline struct pt_regs *
+save_context_stack(struct stack_trace *trace, unsigned int skip,
+		   struct task_struct *task, struct pt_regs *regs)
+{
+	unsigned long sp = regs->regs[29];
+#ifdef CONFIG_KALLSYMS
+	unsigned long ra = regs->regs[31];
+	unsigned long pc = regs->cp0_epc;
+	extern void ret_from_irq(void);
+
+	if (raw_show_trace || !__kernel_text_address(pc)) {
+		save_raw_context_stack(trace, skip, sp);
+		return NULL;
+	}
+	do {
+		if (!skip)
+			trace->entries[trace->nr_entries++] = pc;
+		else
+			skip--;
+		if (trace->nr_entries >= trace->max_entries)
+			break;
+		/*
+		 * If we reached the bottom of interrupt context,
+		 * return saved pt_regs.
+		 */
+		if (pc == (unsigned long)ret_from_irq) {
+			unsigned long stack_page =
+				(unsigned long)task_stack_page(task);
+			if (!stack_page ||
+			    sp < stack_page ||
+			    sp > stack_page + THREAD_SIZE - 32)
+				break;
+			return (struct pt_regs *)sp;
+		}
+		pc = unwind_stack(task, &sp, pc, ra);
+		ra = 0;
+	} while (pc);
+#else
+	save_raw_context_stack(sp);
+#endif
+
+	return NULL;
+}
+
+/*
+ * Save stack-backtrace addresses into a stack_trace buffer.
+ * If all_contexts is set, all contexts (hardirq, softirq and process)
+ * are saved. If not set then only the current context is saved.
+ */
+void save_stack_trace(struct stack_trace *trace,
+		      struct task_struct *task, int all_contexts,
+		      unsigned int skip)
+{
+	struct pt_regs dummyregs;
+	struct pt_regs *regs = &dummyregs;
+
+	WARN_ON(trace->nr_entries || !trace->max_entries);
+
+	if (task && task != current) {
+		regs->regs[29] = task->thread.reg29;
+		regs->regs[31] = 0;
+		regs->cp0_epc = task->thread.reg31;
+	} else {
+		if (!task)
+			task = current;
+		prepare_frametrace(regs);
+	}
+
+	while (1) {
+		regs = save_context_stack(trace, skip, task, regs);
+		if (!all_contexts || !regs ||
+		    trace->nr_entries >= trace->max_entries)
+			break;
+		trace->entries[trace->nr_entries++] = ULONG_MAX;
+		if (trace->nr_entries >= trace->max_entries)
+			break;
+		skip = 0;
+	}
+}
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index e51d8fd..440b865 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -41,6 +41,7 @@ #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
 #include <asm/watch.h>
 #include <asm/types.h>
+#include <asm/stacktrace.h>
 
 extern asmlinkage void handle_int(void);
 extern asmlinkage void handle_tlbm(void);
@@ -92,16 +93,14 @@ #endif
 }
 
 #ifdef CONFIG_KALLSYMS
-static int raw_show_trace;
+int raw_show_trace;
 static int __init set_raw_show_trace(char *str)
 {
 	raw_show_trace = 1;
 	return 1;
 }
 __setup("raw_show_trace", set_raw_show_trace);
-
-extern unsigned long unwind_stack(struct task_struct *task, unsigned long *sp,
-				  unsigned long pc, unsigned long ra);
+#endif
 
 static void show_backtrace(struct task_struct *task, struct pt_regs *regs)
 {
@@ -121,9 +120,6 @@ static void show_backtrace(struct task_s
 	} while (pc);
 	printk("\n");
 }
-#else
-#define show_backtrace(task, r) show_raw_backtrace((r)->regs[29]);
-#endif
 
 /*
  * This routine abuses get_user()/put_user() to reference pointers
@@ -158,28 +154,6 @@ static void show_stacktrace(struct task_
 	show_backtrace(task, regs);
 }
 
-static __always_inline void prepare_frametrace(struct pt_regs *regs)
-{
-	__asm__ __volatile__(
-		".set push\n\t"
-		".set noat\n\t"
-#ifdef CONFIG_64BIT
-		"1: dla $1, 1b\n\t"
-		"sd $1, %0\n\t"
-		"sd $29, %1\n\t"
-		"sd $31, %2\n\t"
-#else
-		"1: la $1, 1b\n\t"
-		"sw $1, %0\n\t"
-		"sw $29, %1\n\t"
-		"sw $31, %2\n\t"
-#endif
-		".set pop\n\t"
-		: "=m" (regs->cp0_epc),
-		"=m" (regs->regs[29]), "=m" (regs->regs[31])
-		: : "memory");
-}
-
 void show_stack(struct task_struct *task, unsigned long *sp)
 {
 	struct pt_regs regs;
@@ -206,11 +180,6 @@ void dump_stack(void)
 {
 	struct pt_regs regs;
 
-	/*
-	 * Remove any garbage that may be in regs (specially func
-	 * addresses) to avoid show_raw_backtrace() to report them
-	 */
-	memset(&regs, 0, sizeof(regs));
 	prepare_frametrace(&regs);
 	show_backtrace(current, &regs);
 }
diff --git a/include/asm-mips/stacktrace.h b/include/asm-mips/stacktrace.h
new file mode 100644
index 0000000..231f6f8
--- /dev/null
+++ b/include/asm-mips/stacktrace.h
@@ -0,0 +1,44 @@
+#ifndef _ASM_STACKTRACE_H
+#define _ASM_STACKTRACE_H
+
+#include <asm/ptrace.h>
+
+#ifdef CONFIG_KALLSYMS
+extern int raw_show_trace;
+extern unsigned long unwind_stack(struct task_struct *task, unsigned long *sp,
+				  unsigned long pc, unsigned long ra);
+#else
+#define raw_show_trace 1
+#define unwind_stack(task, sp, pc, ra)	0
+#endif
+
+static __always_inline void prepare_frametrace(struct pt_regs *regs)
+{
+#ifndef CONFIG_KALLSYMS
+	/*
+	 * Remove any garbage that may be in regs (specially func
+	 * addresses) to avoid show_raw_backtrace() to report them
+	 */
+	memset(regs, 0, sizeof(*regs));
+#endif
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set noat\n\t"
+#ifdef CONFIG_64BIT
+		"1: dla $1, 1b\n\t"
+		"sd $1, %0\n\t"
+		"sd $29, %1\n\t"
+		"sd $31, %2\n\t"
+#else
+		"1: la $1, 1b\n\t"
+		"sw $1, %0\n\t"
+		"sw $29, %1\n\t"
+		"sw $31, %2\n\t"
+#endif
+		".set pop\n\t"
+		: "=m" (regs->cp0_epc),
+		"=m" (regs->regs[29]), "=m" (regs->regs[31])
+		: : "memory");
+}
+
+#endif /* _ASM_STACKTRACE_H */
