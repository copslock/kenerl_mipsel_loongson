Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2006 16:42:58 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:22470 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133389AbWBGQmo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 7 Feb 2006 16:42:44 +0000
Received: from localhost (p1079-ipad209funabasi.chiba.ocn.ne.jp [58.88.112.79])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A54DFA267; Wed,  8 Feb 2006 01:48:21 +0900 (JST)
Date:	Wed, 08 Feb 2006 01:48:03 +0900 (JST)
Message-Id: <20060208.014803.74752750.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] rewrite get_wchan and its helper functions
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20051115.011721.25910359.anemo@mba.ocn.ne.jp>
References: <20051115.011721.25910359.anemo@mba.ocn.ne.jp>
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
X-archive-position: 10361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 15 Nov 2005 01:17:21 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:

anemo> Implement get_wchan and frame_info_init using kallsyms_lookup.

Updated.

Implement get_wchan() and frame_info_init() using kallsyms_lookup().
This fixes problem with static sched/lock functions and mfinfo[]
maintenance issue.  If CONFIG_KALLSYMS was disabled, get_wchan() just
returns thread_saved_pc() value.

Also unwind stackframe based on "addiu sp,-imm" analysis instead of
frame pointer.  This fixes problem with functions compiled without
-fomit-frame-pointer.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index fa98f10..376dbc4 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -24,6 +24,7 @@
 #include <linux/a.out.h>
 #include <linux/init.h>
 #include <linux/completion.h>
+#include <linux/kallsyms.h>
 
 #include <asm/abi.h>
 #include <asm/bootinfo.h>
@@ -271,46 +272,19 @@ long kernel_thread(int (*fn)(void *), vo
 
 static struct mips_frame_info {
 	void *func;
-	int omit_fp;	/* compiled without fno-omit-frame-pointer */
-	int frame_offset;
+	unsigned long func_size;
+	int frame_size;
 	int pc_offset;
-} schedule_frame, mfinfo[] = {
-	{ schedule, 0 },	/* must be first */
-	/* arch/mips/kernel/semaphore.c */
-	{ __down, 1 },
-	{ __down_interruptible, 1 },
-	/* kernel/sched.c */
-#ifdef CONFIG_PREEMPT
-	{ preempt_schedule, 0 },
-#endif
-	{ wait_for_completion, 0 },
-	{ interruptible_sleep_on, 0 },
-	{ interruptible_sleep_on_timeout, 0 },
-	{ sleep_on, 0 },
-	{ sleep_on_timeout, 0 },
-	{ yield, 0 },
-	{ io_schedule, 0 },
-	{ io_schedule_timeout, 0 },
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
-	{ __preempt_spin_lock, 0 },
-	{ __preempt_write_lock, 0 },
-#endif
-	/* kernel/timer.c */
-	{ schedule_timeout, 1 },
-/*	{ nanosleep_restart, 1 }, */
-	/* lib/rwsem-spinlock.c */
-	{ __down_read, 1 },
-	{ __down_write, 1 },
-};
+} *schedule_frame, mfinfo[64];
+static int mfinfo_num;
 
-static int mips_frame_info_initialized;
 static int __init get_frame_info(struct mips_frame_info *info)
 {
 	int i;
 	void *func = info->func;
 	union mips_instruction *ip = (union mips_instruction *)func;
 	info->pc_offset = -1;
-	info->frame_offset = info->omit_fp ? 0 : -1;
+	info->frame_size = 0;
 	for (i = 0; i < 128; i++, ip++) {
 		/* if jal, jalr, jr, stop. */
 		if (ip->j_format.opcode == jal_op ||
@@ -319,6 +293,23 @@ static int __init get_frame_info(struct 
 		      ip->r_format.func == jr_op)))
 			break;
 
+		if (info->func_size && i >= info->func_size / 4)
+			break;
+		if (
+#ifdef CONFIG_32BIT
+		    ip->i_format.opcode == addiu_op &&
+#endif
+#ifdef CONFIG_64BIT
+		    ip->i_format.opcode == daddiu_op &&
+#endif
+		    ip->i_format.rs == 29 &&
+		    ip->i_format.rt == 29) {
+			/* addiu/daddiu sp,sp,-imm */
+			if (info->frame_size)
+				continue;
+			info->frame_size = - ip->i_format.simmediate;
+		}
+
 		if (
 #ifdef CONFIG_32BIT
 		    ip->i_format.opcode == sw_op &&
@@ -326,31 +317,20 @@ static int __init get_frame_info(struct 
 #ifdef CONFIG_64BIT
 		    ip->i_format.opcode == sd_op &&
 #endif
-		    ip->i_format.rs == 29)
-		{
+		    ip->i_format.rs == 29 &&
+		    ip->i_format.rt == 31) {
 			/* sw / sd $ra, offset($sp) */
-			if (ip->i_format.rt == 31) {
-				if (info->pc_offset != -1)
-					continue;
-				info->pc_offset =
-					ip->i_format.simmediate / sizeof(long);
-			}
-			/* sw / sd $s8, offset($sp) */
-			if (ip->i_format.rt == 30) {
-//#if 0	/* gcc 3.4 does aggressive optimization... */
-				if (info->frame_offset != -1)
-					continue;
-//#endif
-				info->frame_offset =
-					ip->i_format.simmediate / sizeof(long);
-			}
+			if (info->pc_offset != -1)
+				continue;
+			info->pc_offset =
+				ip->i_format.simmediate / sizeof(long);
 		}
 	}
-	if (info->pc_offset == -1 || info->frame_offset == -1) {
-		printk("Can't analyze prologue code at %p\n", func);
+	if (info->pc_offset == -1 || info->frame_size == 0) {
+		if (func == schedule)
+			printk("Can't analyze prologue code at %p\n", func);
 		info->pc_offset = -1;
-		info->frame_offset = -1;
-		return -1;
+		info->frame_size = 0;
 	}
 
 	return 0;
@@ -358,25 +338,36 @@ static int __init get_frame_info(struct 
 
 static int __init frame_info_init(void)
 {
-	int i, found;
-	for (i = 0; i < ARRAY_SIZE(mfinfo); i++)
-		if (get_frame_info(&mfinfo[i]))
-			return -1;
-	schedule_frame = mfinfo[0];
-	/* bubble sort */
-	do {
-		struct mips_frame_info tmp;
-		found = 0;
-		for (i = 1; i < ARRAY_SIZE(mfinfo); i++) {
-			if (mfinfo[i-1].func > mfinfo[i].func) {
-				tmp = mfinfo[i];
-				mfinfo[i] = mfinfo[i-1];
-				mfinfo[i-1] = tmp;
-				found = 1;
-			}
-		}
-	} while (found);
-	mips_frame_info_initialized = 1;
+	int i;
+#ifdef CONFIG_KALLSYMS
+	char *modname;
+	char namebuf[KSYM_NAME_LEN + 1];
+	unsigned long start, size, ofs;
+	extern char __sched_text_start[], __sched_text_end[];
+	extern char __lock_text_start[], __lock_text_end[];
+
+	start = (unsigned long)__sched_text_start;
+	for (i = 0; i < ARRAY_SIZE(mfinfo); i++) {
+		if (start == (unsigned long)schedule)
+			schedule_frame = &mfinfo[i];
+		if (!kallsyms_lookup(start, &size, &ofs, &modname, namebuf))
+			break;
+		mfinfo[i].func = (void *)(start + ofs);
+		mfinfo[i].func_size = size;
+		start += size - ofs;
+		if (start >= (unsigned long)__lock_text_end)
+			break;
+		if (start == (unsigned long)__sched_text_end)
+			start = (unsigned long)__lock_text_start;
+	}
+#else
+	mfinfo[0].func = schedule;
+	schedule_frame = &mfinfo[0];
+#endif
+	for (i = 0; i < ARRAY_SIZE(mfinfo) && mfinfo[i].func; i++)
+		get_frame_info(&mfinfo[i]);
+	
+	mfinfo_num = i;
 	return 0;
 }
 
@@ -393,47 +384,52 @@ unsigned long thread_saved_pc(struct tas
 	if (t->reg31 == (unsigned long) ret_from_fork)
 		return t->reg31;
 
-	if (schedule_frame.pc_offset < 0)
+	if (!schedule_frame || schedule_frame->pc_offset < 0)
 		return 0;
-	return ((unsigned long *)t->reg29)[schedule_frame.pc_offset];
+	return ((unsigned long *)t->reg29)[schedule_frame->pc_offset];
 }
 
 /* get_wchan - a maintenance nightmare^W^Wpain in the ass ...  */
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long stack_page;
-	unsigned long frame, pc;
+	unsigned long pc;
+#ifdef CONFIG_KALLSYMS
+	unsigned long frame;
+#endif
 
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
 
 	stack_page = (unsigned long)task_stack_page(p);
-	if (!stack_page || !mips_frame_info_initialized)
+	if (!stack_page || !mfinfo_num)
 		return 0;
 
 	pc = thread_saved_pc(p);
+#ifdef CONFIG_KALLSYMS
 	if (!in_sched_functions(pc))
 		return pc;
 
-	frame = ((unsigned long *)p->thread.reg30)[schedule_frame.frame_offset];
+	frame = p->thread.reg29 + schedule_frame->frame_size;
 	do {
 		int i;
 
 		if (frame < stack_page || frame > stack_page + THREAD_SIZE - 32)
 			return 0;
 
-		for (i = ARRAY_SIZE(mfinfo) - 1; i >= 0; i--) {
+		for (i = mfinfo_num - 1; i >= 0; i--) {
 			if (pc >= (unsigned long) mfinfo[i].func)
 				break;
 		}
 		if (i < 0)
 			break;
 
-		if (mfinfo[i].omit_fp)
-			break;
 		pc = ((unsigned long *)frame)[mfinfo[i].pc_offset];
-		frame = ((unsigned long *)frame)[mfinfo[i].frame_offset];
+		if (!mfinfo[i].frame_size)
+			break;
+		frame += mfinfo[i].frame_size;
 	} while (in_sched_functions(pc));
+#endif
 
 	return pc;
 }
