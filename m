Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jul 2006 10:00:39 +0100 (BST)
Received: from nz-out-0102.google.com ([64.233.162.203]:23799 "EHLO
	nz-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S8133494AbWGaJA2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 31 Jul 2006 10:00:28 +0100
Received: by nz-out-0102.google.com with SMTP id l1so152246nzf
        for <linux-mips@linux-mips.org>; Mon, 31 Jul 2006 02:00:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=HMphpboCX87iwbGbyPvxOTmBW1JKe8c9Dxd0u7HzOYpiqU9XMKOz5B38hD/n2VmpG0znyqEEfOxUtERqevra1rXwSUBX9dSkTxvnrMSatFzb/lp7gSF3Q4LGREYEhMIQ/0+tb6oiUPcjKNKzpgnp7OuekTMej0e7t5US7rpy7+c=
Received: by 10.65.114.4 with SMTP id r4mr3114256qbm;
        Mon, 31 Jul 2006 02:00:16 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id 36sm3714524nza.2006.07.31.02.00.08;
        Mon, 31 Jul 2006 02:00:16 -0700 (PDT)
Message-ID: <44CDC657.9090403@innova-card.com>
Date:	Mon, 31 Jul 2006 10:59:03 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	vagabon.xyz@gmail.com
Subject: Re: [PATCH] dump_stack() based on prologue code analysis (take 2)
References: <20060729.232720.108740310.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060729.232720.108740310.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> 
> Subject: [PATCH] dump_stack() based on prologue code analysis
> 
> Instead of dump all possible address in the stack, unwind the stack
> frame based on prologue code analysis, as like as get_wchan() does.
> While the code analysis might fail for some reason, there is a new
> kernel option "raw_show_trace" to disable this feature.
> 

my comments included with this patch...(you can find the plain patch
at the end of this email)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 8709a46..3bb4d47 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -365,15 +365,15 @@ #else
 	mfinfo[0].func = schedule;
 	schedule_frame = &mfinfo[0];
 #endif
-	for (i = 0; i < ARRAY_SIZE(mfinfo) && mfinfo[i].func; i++) {
-		struct mips_frame_info *info = &mfinfo[i];
-		if (get_frame_info(info)) {
-			/* leaf or unknown */
-			if (info->func == schedule)
-				printk("Can't analyze prologue code at %p\n",
-				       info->func);
-		}
-	}
+	for (i = 0; i < ARRAY_SIZE(mfinfo) && mfinfo[i].func; i++)
+		get_frame_info(mfinfo + i);
+
+	/*
+	 * Without schedule() frame info, result given by
+	 * thread_saved_pc() and get_wchan() are not reliable.
+	 */
+	if (schedule_frame->pc_offset < 0)
+		printk("Can't analyze schedule() prologue at %p\n", schedule);

>>>>>>>>>>>>>
I just put the test out of the loop and add a comment.
<<<<<<<<<<<<<
 
 	mfinfo_num = i;
 	return 0;
@@ -446,14 +446,15 @@ #endif
 
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
+	int rv;
 
 	stack_page = (unsigned long)task_stack_page(task);
 	if (!stack_page)
@@ -466,18 +467,21 @@ unsigned long unwind_stack(struct task_s
 
 	info.func = (void *)(pc - ofs);
 	info.func_size = ofs;	/* analyze from start to ofs */
-	if (get_frame_info(&info)) {
-		/* leaf or unknown */
-		*sp += info.frame_size / sizeof(long);
+	rv = get_frame_info(&info);
+	if (rv < 0)
 		return 0;
-	}
+
 	if ((unsigned long)*sp < stack_page ||
 	    (unsigned long)*sp + info.frame_size / sizeof(long) >
 	    stack_page + THREAD_SIZE - 32)
 		return 0;
 
-	pc = (*sp)[info.pc_offset];
+	if (rv)		/* leaf */
+		pc = regs->regs[31];
+	else		/* nested */
+		pc = (*sp)[info.pc_offset];
+
 	*sp += info.frame_size / sizeof(long);
-	return pc;
+	return __kernel_text_address(pc) ? pc : 0;

>>>>>>>>>>>>>
I pass regs to unwind_stack(), that simplify the caller because
it needn't to deal with leaf or nested case. Simply test for pc
is 0.
<<<<<<<<<<<<<

 }
 #endif
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 7aa9dfc..bbd1cf9 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -73,13 +73,8 @@ void (*board_nmi_handler_setup)(void);
 void (*board_ejtag_handler_setup)(void);
 void (*board_bind_eic_interrupt)(int irq, int regset);
 
-/*
- * These constant is for searching for possible module text segments.
- * MODULE_RANGE is a guess of how much space is likely to be vmalloced.
- */
-#define MODULE_RANGE (8*1024*1024)

>>>>>>>>>>>>>
seems to be unused now...
<<<<<<<<<<<<<

-static void show_trace(unsigned long *stack)
+static void show_trace(unsigned long *sp)
 {
 	const int field = 2 * sizeof(unsigned long);
 	unsigned long addr;
@@ -88,8 +83,8 @@ static void show_trace(unsigned long *st
 #ifdef CONFIG_KALLSYMS
 	printk("\n");
 #endif
-	while (!kstack_end(stack)) {
-		addr = *stack++;
+	while (!kstack_end(sp)) {
+		addr = *sp++;

>>>>>>>>>>>>>
now show_trace calls sp sp. (nothing is too late)
<<<<<<<<<<<<<

 		if (__kernel_text_address(addr)) {
 			printk(" [<%0*lx>] ", field, addr);
 			print_symbol("%s\n", addr);
@@ -107,32 +102,27 @@ static int __init set_raw_show_trace(cha
 }
 __setup("raw_show_trace", set_raw_show_trace);
 
-extern unsigned long unwind_stack(struct task_struct *task,
-				  unsigned long **sp, unsigned long pc);
-static void show_frametrace(struct task_struct *task, struct pt_regs *regs)
+extern unsigned long unwind_stack(struct task_struct *task, unsigned long **sp,
+				  unsigned long pc, struct pt_regs *regs);
+
+static void show_backtrace(struct task_struct *task, struct pt_regs *regs)

>>>>>>>>>>>>>
Just renamed show_stacktrace() into show_backtrace(). I think we
usually use the latter no ?
<<<<<<<<<<<<<

 {
-	const int field = 2 * sizeof(unsigned long);
-	unsigned long *stack = (long *)regs->regs[29];
+	unsigned long *sp = (long *)regs->regs[29];
 	unsigned long pc = regs->cp0_epc;
-	int top = 1;
 
 	if (raw_show_trace || !__kernel_text_address(pc)) {
-		show_trace(stack);
+		show_trace(sp);
 		return;
 	}
 	printk("Call Trace:\n");
-	while (__kernel_text_address(pc)) {
-		printk(" [<%0*lx>] ", field, pc);
+	do {
+		printk(" [<%0*lx>] ", 2*sizeof(unsigned long), pc);
 		print_symbol("%s\n", pc);
-		pc = unwind_stack(task, &stack, pc);
-		if (top && pc == 0)
-			pc = regs->regs[31];	/* leaf? */
-		top = 0;
-	}
+	} while ((pc = unwind_stack(task, &sp, pc, regs)));

>>>>>>>>>>>>>
Now don't deal with leaf case since unwind_stack() does it for us.
<<<<<<<<<<<<<

 	printk("\n");
 }
 #else
-#define show_frametrace(task, r) show_trace((long *)(r)->regs[29]);
+#define show_backtrace(task, r) show_trace((long *)(r)->regs[29]);
 #endif
 
 /*
@@ -165,7 +155,7 @@ static void show_stacktrace(struct task_
 		i++;
 	}
 	printk("\n");
-	show_frametrace(task, regs);
+	show_backtrace(task, regs);
 }
 
 static noinline void prepare_frametrace(struct pt_regs *regs)
@@ -216,7 +206,7 @@ #ifdef CONFIG_KALLSYMS
 	if (!raw_show_trace) {
 		struct pt_regs regs;
 		prepare_frametrace(&regs);
-		show_frametrace(current, &regs);
+		show_backtrace(current, &regs);
 		return;
 	}
 #endif



Here is the plain patch.

-- >8 --

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 8709a46..3bb4d47 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -365,15 +365,15 @@ #else
 	mfinfo[0].func = schedule;
 	schedule_frame = &mfinfo[0];
 #endif
-	for (i = 0; i < ARRAY_SIZE(mfinfo) && mfinfo[i].func; i++) {
-		struct mips_frame_info *info = &mfinfo[i];
-		if (get_frame_info(info)) {
-			/* leaf or unknown */
-			if (info->func == schedule)
-				printk("Can't analyze prologue code at %p\n",
-				       info->func);
-		}
-	}
+	for (i = 0; i < ARRAY_SIZE(mfinfo) && mfinfo[i].func; i++)
+		get_frame_info(mfinfo + i);
+
+	/*
+	 * Without schedule() frame info, result given by
+	 * thread_saved_pc() and get_wchan() are not reliable.
+	 */
+	if (schedule_frame->pc_offset < 0)
+		printk("Can't analyze schedule() prologue at %p\n", schedule);
 
 	mfinfo_num = i;
 	return 0;
@@ -446,14 +446,15 @@ #endif
 
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
+	int rv;
 
 	stack_page = (unsigned long)task_stack_page(task);
 	if (!stack_page)
@@ -466,18 +467,21 @@ unsigned long unwind_stack(struct task_s
 
 	info.func = (void *)(pc - ofs);
 	info.func_size = ofs;	/* analyze from start to ofs */
-	if (get_frame_info(&info)) {
-		/* leaf or unknown */
-		*sp += info.frame_size / sizeof(long);
+	rv = get_frame_info(&info);
+	if (rv < 0)
 		return 0;
-	}
+
 	if ((unsigned long)*sp < stack_page ||
 	    (unsigned long)*sp + info.frame_size / sizeof(long) >
 	    stack_page + THREAD_SIZE - 32)
 		return 0;
 
-	pc = (*sp)[info.pc_offset];
+	if (rv)		/* leaf */
+		pc = regs->regs[31];
+	else		/* nested */
+		pc = (*sp)[info.pc_offset];
+
 	*sp += info.frame_size / sizeof(long);
-	return pc;
+	return __kernel_text_address(pc) ? pc : 0;
 }
 #endif
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 7aa9dfc..bbd1cf9 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -73,13 +73,8 @@ void (*board_nmi_handler_setup)(void);
 void (*board_ejtag_handler_setup)(void);
 void (*board_bind_eic_interrupt)(int irq, int regset);
 
-/*
- * These constant is for searching for possible module text segments.
- * MODULE_RANGE is a guess of how much space is likely to be vmalloced.
- */
-#define MODULE_RANGE (8*1024*1024)
 
-static void show_trace(unsigned long *stack)
+static void show_trace(unsigned long *sp)
 {
 	const int field = 2 * sizeof(unsigned long);
 	unsigned long addr;
@@ -88,8 +83,8 @@ static void show_trace(unsigned long *st
 #ifdef CONFIG_KALLSYMS
 	printk("\n");
 #endif
-	while (!kstack_end(stack)) {
-		addr = *stack++;
+	while (!kstack_end(sp)) {
+		addr = *sp++;
 		if (__kernel_text_address(addr)) {
 			printk(" [<%0*lx>] ", field, addr);
 			print_symbol("%s\n", addr);
@@ -107,32 +102,27 @@ static int __init set_raw_show_trace(cha
 }
 __setup("raw_show_trace", set_raw_show_trace);
 
-extern unsigned long unwind_stack(struct task_struct *task,
-				  unsigned long **sp, unsigned long pc);
-static void show_frametrace(struct task_struct *task, struct pt_regs *regs)
+extern unsigned long unwind_stack(struct task_struct *task, unsigned long **sp,
+				  unsigned long pc, struct pt_regs *regs);
+
+static void show_backtrace(struct task_struct *task, struct pt_regs *regs)
 {
-	const int field = 2 * sizeof(unsigned long);
-	unsigned long *stack = (long *)regs->regs[29];
+	unsigned long *sp = (long *)regs->regs[29];
 	unsigned long pc = regs->cp0_epc;
-	int top = 1;
 
 	if (raw_show_trace || !__kernel_text_address(pc)) {
-		show_trace(stack);
+		show_trace(sp);
 		return;
 	}
 	printk("Call Trace:\n");
-	while (__kernel_text_address(pc)) {
-		printk(" [<%0*lx>] ", field, pc);
+	do {
+		printk(" [<%0*lx>] ", 2*sizeof(unsigned long), pc);
 		print_symbol("%s\n", pc);
-		pc = unwind_stack(task, &stack, pc);
-		if (top && pc == 0)
-			pc = regs->regs[31];	/* leaf? */
-		top = 0;
-	}
+	} while ((pc = unwind_stack(task, &sp, pc, regs)));
 	printk("\n");
 }
 #else
-#define show_frametrace(task, r) show_trace((long *)(r)->regs[29]);
+#define show_backtrace(task, r) show_trace((long *)(r)->regs[29]);
 #endif
 
 /*
@@ -165,7 +155,7 @@ static void show_stacktrace(struct task_
 		i++;
 	}
 	printk("\n");
-	show_frametrace(task, regs);
+	show_backtrace(task, regs);
 }
 
 static noinline void prepare_frametrace(struct pt_regs *regs)
@@ -216,7 +206,7 @@ #ifdef CONFIG_KALLSYMS
 	if (!raw_show_trace) {
 		struct pt_regs regs;
 		prepare_frametrace(&regs);
-		show_frametrace(current, &regs);
+		show_backtrace(current, &regs);
 		return;
 	}
 #endif
