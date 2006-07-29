Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Jul 2006 15:26:04 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:28135 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133802AbWG2OZx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 29 Jul 2006 15:25:53 +0100
Received: from localhost (p6108-ipad213funabasi.chiba.ocn.ne.jp [124.85.71.108])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id EC04CA743; Sat, 29 Jul 2006 23:25:48 +0900 (JST)
Date:	Sat, 29 Jul 2006 23:27:20 +0900 (JST)
Message-Id: <20060729.232720.108740310.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, vagabon.xyz@gmail.com
Subject: [PATCH] dump_stack() based on prologue code analysis (take 2)
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
X-archive-position: 12120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Take 2.  Reflecting some advices from Franck Bui-Huu.


Subject: [PATCH] dump_stack() based on prologue code analysis

Instead of dump all possible address in the stack, unwind the stack
frame based on prologue code analysis, as like as get_wchan() does.
While the code analysis might fail for some reason, there is a new
kernel option "raw_show_trace" to disable this feature.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 7ab67f7..8709a46 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -281,7 +281,7 @@ static struct mips_frame_info {
 } *schedule_frame, mfinfo[64];
 static int mfinfo_num;
 
-static int __init get_frame_info(struct mips_frame_info *info)
+static int get_frame_info(struct mips_frame_info *info)
 {
 	int i;
 	void *func = info->func;
@@ -329,14 +329,12 @@ #endif
 				ip->i_format.simmediate / sizeof(long);
 		}
 	}
-	if (info->pc_offset == -1 || info->frame_size == 0) {
-		if (func == schedule)
-			printk("Can't analyze prologue code at %p\n", func);
-		info->pc_offset = -1;
-		info->frame_size = 0;
-	}
-
-	return 0;
+	if (info->frame_size && info->pc_offset >= 0) /* nested */
+		return 0;
+	if (info->pc_offset < 0) /* leaf */
+		return 1;
+	/* prologue seems boggus... */
+	return -1;
 }
 
 static int __init frame_info_init(void)
@@ -367,8 +365,15 @@ #else
 	mfinfo[0].func = schedule;
 	schedule_frame = &mfinfo[0];
 #endif
-	for (i = 0; i < ARRAY_SIZE(mfinfo) && mfinfo[i].func; i++)
-		get_frame_info(&mfinfo[i]);
+	for (i = 0; i < ARRAY_SIZE(mfinfo) && mfinfo[i].func; i++) {
+		struct mips_frame_info *info = &mfinfo[i];
+		if (get_frame_info(info)) {
+			/* leaf or unknown */
+			if (info->func == schedule)
+				printk("Can't analyze prologue code at %p\n",
+				       info->func);
+		}
+	}
 
 	mfinfo_num = i;
 	return 0;
@@ -427,6 +432,8 @@ #ifdef CONFIG_KALLSYMS
 		if (i < 0)
 			break;
 
+		if (mfinfo[i].pc_offset < 0)
+			break;
 		pc = ((unsigned long *)frame)[mfinfo[i].pc_offset];
 		if (!mfinfo[i].frame_size)
 			break;
@@ -437,3 +444,40 @@ #endif
 	return pc;
 }
 
+#ifdef CONFIG_KALLSYMS
+/* used by show_frametrace() */
+unsigned long unwind_stack(struct task_struct *task,
+			   unsigned long **sp, unsigned long pc)
+{
+	unsigned long stack_page;
+	struct mips_frame_info info;
+	char *modname;
+	char namebuf[KSYM_NAME_LEN + 1];
+	unsigned long size, ofs;
+
+	stack_page = (unsigned long)task_stack_page(task);
+	if (!stack_page)
+		return 0;
+
+	if (!kallsyms_lookup(pc, &size, &ofs, &modname, namebuf))
+		return 0;
+	if (ofs == 0)
+		return 0;
+
+	info.func = (void *)(pc - ofs);
+	info.func_size = ofs;	/* analyze from start to ofs */
+	if (get_frame_info(&info)) {
+		/* leaf or unknown */
+		*sp += info.frame_size / sizeof(long);
+		return 0;
+	}
+	if ((unsigned long)*sp < stack_page ||
+	    (unsigned long)*sp + info.frame_size / sizeof(long) >
+	    stack_page + THREAD_SIZE - 32)
+		return 0;
+
+	pc = (*sp)[info.pc_offset];
+	*sp += info.frame_size / sizeof(long);
+	return pc;
+}
+#endif
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index c6f7046..7aa9dfc 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -98,24 +98,53 @@ #endif
 	printk("\n");
 }
 
+#ifdef CONFIG_KALLSYMS
+static int raw_show_trace;
+static int __init set_raw_show_trace(char *str)
+{
+	raw_show_trace = 1;
+	return 1;
+}
+__setup("raw_show_trace", set_raw_show_trace);
+
+extern unsigned long unwind_stack(struct task_struct *task,
+				  unsigned long **sp, unsigned long pc);
+static void show_frametrace(struct task_struct *task, struct pt_regs *regs)
+{
+	const int field = 2 * sizeof(unsigned long);
+	unsigned long *stack = (long *)regs->regs[29];
+	unsigned long pc = regs->cp0_epc;
+	int top = 1;
+
+	if (raw_show_trace || !__kernel_text_address(pc)) {
+		show_trace(stack);
+		return;
+	}
+	printk("Call Trace:\n");
+	while (__kernel_text_address(pc)) {
+		printk(" [<%0*lx>] ", field, pc);
+		print_symbol("%s\n", pc);
+		pc = unwind_stack(task, &stack, pc);
+		if (top && pc == 0)
+			pc = regs->regs[31];	/* leaf? */
+		top = 0;
+	}
+	printk("\n");
+}
+#else
+#define show_frametrace(task, r) show_trace((long *)(r)->regs[29]);
+#endif
+
 /*
  * This routine abuses get_user()/put_user() to reference pointers
  * with at least a bit of error checking ...
  */
-void show_stack(struct task_struct *task, unsigned long *sp)
+static void show_stacktrace(struct task_struct *task, struct pt_regs *regs)
 {
 	const int field = 2 * sizeof(unsigned long);
 	long stackdata;
 	int i;
-	unsigned long *stack;
-
-	if (!sp) {
-		if (task && task != current)
-			sp = (unsigned long *) task->thread.reg29;
-		else
-			sp = (unsigned long *) &sp;
-	}
-	stack = sp;
+	unsigned long *sp = (unsigned long *)regs->regs[29];
 
 	printk("Stack :");
 	i = 0;
@@ -136,7 +165,44 @@ void show_stack(struct task_struct *task
 		i++;
 	}
 	printk("\n");
-	show_trace(stack);
+	show_frametrace(task, regs);
+}
+
+static noinline void prepare_frametrace(struct pt_regs *regs)
+{
+	__asm__ __volatile__(
+		"1: la $2, 1b\n\t"
+#ifdef CONFIG_64BIT
+		"sd $2, %0\n\t"
+		"sd $29, %1\n\t"
+		"sd $31, %2\n\t"
+#else
+		"sw $2, %0\n\t"
+		"sw $29, %1\n\t"
+		"sw $31, %2\n\t"
+#endif
+		: "=m" (regs->cp0_epc),
+		"=m" (regs->regs[29]), "=m" (regs->regs[31])
+		: : "memory");
+}
+
+void show_stack(struct task_struct *task, unsigned long *sp)
+{
+	struct pt_regs regs;
+	if (sp) {
+		regs.regs[29] = (unsigned long)sp;
+		regs.regs[31] = 0;
+		regs.cp0_epc = 0;
+	} else {
+		if (task && task != current) {
+			regs.regs[29] = task->thread.reg29;
+			regs.regs[31] = 0;
+			regs.cp0_epc = task->thread.reg31;
+		} else {
+			prepare_frametrace(&regs);
+		}
+	}
+	show_stacktrace(task, &regs);
 }
 
 /*
@@ -146,6 +212,14 @@ void dump_stack(void)
 {
 	unsigned long stack;
 
+#ifdef CONFIG_KALLSYMS
+	if (!raw_show_trace) {
+		struct pt_regs regs;
+		prepare_frametrace(&regs);
+		show_frametrace(current, &regs);
+		return;
+	}
+#endif
 	show_trace(&stack);
 }
 
@@ -265,7 +339,7 @@ void show_registers(struct pt_regs *regs
 	print_modules();
 	printk("Process %s (pid: %d, threadinfo=%p, task=%p)\n",
 	        current->comm, current->pid, current_thread_info(), current);
-	show_stack(current, (long *) regs->regs[29]);
+	show_stacktrace(current, regs);
 	show_code((unsigned int *) regs->cp0_epc);
 	printk("\n");
 }
