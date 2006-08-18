Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2006 15:19:29 +0100 (BST)
Received: from nz-out-0102.google.com ([64.233.162.204]:36297 "EHLO
	nz-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S20037794AbWHROSi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 Aug 2006 15:18:38 +0100
Received: by nz-out-0102.google.com with SMTP id s1so522645nze
        for <linux-mips@linux-mips.org>; Fri, 18 Aug 2006 07:18:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UVOwgA6KLKFsZbUjBM4OpHGoo+tS61M3bcL0i41BDaHVa94si7FMhzq+EBInCdTqCBcpfV/DMG00b8v4MoR9d5OD8yMIZ556TN5/cYNuxFT8EiT9yU0XJ/FeJVbp9/p2i5rb409NwWM2jlYlxuTK7rfuEriGKQPFaTjcb1TkWTA=
Received: by 10.65.59.20 with SMTP id m20mr3648851qbk;
        Fri, 18 Aug 2006 07:18:35 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id f12sm1825419qba.2006.08.18.07.18.33;
        Fri, 18 Aug 2006 07:18:34 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id DC89523F76F; Fri, 18 Aug 2006 16:18:09 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	anemo@mba.ocn.ne.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 3/3] get_wchan(): remove uses of mfinfo[64]
Date:	Fri, 18 Aug 2006 16:18:09 +0200
Message-Id: <11559106892970-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc4
In-Reply-To: <11559106892565-git-send-email-vagabon.xyz@gmail.com>
References: <11559106892428-git-send-email-vagabon.xyz@gmail.com> <11559106892565-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

This array was used to 'cache' some frame info about scheduler
functions to speed up get_wchan(). This array was 1Ko size and
was only used when CONFIG_KALLSYMS was set but declared for all
configs.

Rather than make the array statement conditional, this patches
removes this array and its uses. Indeed the common case doesn't
seem to use this array and get_wchan() is not a critical path
anyways.

It results in a smaller bss and a smaller/cleaner code:

   text    data     bss     dec     hex filename
2543808  254148  139296 2937252  2cd1a4 vmlinux-new-get-wchan
2544080  254148  143392 2941620  2ce2b4 vmlinux~old

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 arch/mips/kernel/process.c |  132 +++++++++++++++++---------------------------
 1 files changed, 50 insertions(+), 82 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index cc67bf7..1b1637d 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -273,13 +273,15 @@ #endif
 	return do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);
 }
 
-static struct mips_frame_info {
-	void *func;
-	unsigned long func_size;
-	int frame_size;
-	int pc_offset;
-} *schedule_frame, mfinfo[64];
-static int mfinfo_num;
+/*
+ *
+ */
+struct mips_frame_info {
+	void		*func;
+	unsigned long	func_size;
+	int		frame_size;
+	int		pc_offset;
+};
 
 static inline int is_ra_save_ins(union mips_instruction *ip)
 {
@@ -348,45 +350,30 @@ err:
 	return -1;
 }
 
+static struct mips_frame_info schedule_mfi __read_mostly;
+
 static int __init frame_info_init(void)
 {
-	int i;
+	unsigned long size = 0;
 #ifdef CONFIG_KALLSYMS
+	unsigned long ofs;
 	char *modname;
 	char namebuf[KSYM_NAME_LEN + 1];
-	unsigned long start, size, ofs;
-	extern char __sched_text_start[], __sched_text_end[];
-	extern char __lock_text_start[], __lock_text_end[];
-
-	start = (unsigned long)__sched_text_start;
-	for (i = 0; i < ARRAY_SIZE(mfinfo); i++) {
-		if (start == (unsigned long)schedule)
-			schedule_frame = &mfinfo[i];
-		if (!kallsyms_lookup(start, &size, &ofs, &modname, namebuf))
-			break;
-		mfinfo[i].func = (void *)(start + ofs);
-		mfinfo[i].func_size = size;
-		start += size - ofs;
-		if (start >= (unsigned long)__lock_text_end)
-			break;
-		if (start == (unsigned long)__sched_text_end)
-			start = (unsigned long)__lock_text_start;
-	}
-#else
-	mfinfo[0].func = schedule;
-	schedule_frame = &mfinfo[0];
+
+	kallsyms_lookup((unsigned long)schedule, &size, &ofs, &modname, namebuf);
 #endif
-	for (i = 0; i < ARRAY_SIZE(mfinfo) && mfinfo[i].func; i++)
-		get_frame_info(mfinfo + i);
+	schedule_mfi.func = schedule;
+	schedule_mfi.func_size = size;
+
+	get_frame_info(&schedule_mfi);
 
 	/*
 	 * Without schedule() frame info, result given by
 	 * thread_saved_pc() and get_wchan() are not reliable.
 	 */
-	if (schedule_frame->pc_offset < 0)
+	if (schedule_mfi.pc_offset < 0)
 		printk("Can't analyze schedule() prologue at %p\n", schedule);
 
-	mfinfo_num = i;
 	return 0;
 }
 
@@ -402,58 +389,11 @@ unsigned long thread_saved_pc(struct tas
 	/* New born processes are a special case */
 	if (t->reg31 == (unsigned long) ret_from_fork)
 		return t->reg31;
-
-	if (!schedule_frame || schedule_frame->pc_offset < 0)
+	if (schedule_mfi.pc_offset < 0)
 		return 0;
-	return ((unsigned long *)t->reg29)[schedule_frame->pc_offset];
+	return ((unsigned long *)t->reg29)[schedule_mfi.pc_offset];
 }
 
-/* get_wchan - a maintenance nightmare^W^Wpain in the ass ...  */
-unsigned long get_wchan(struct task_struct *p)
-{
-	unsigned long stack_page;
-	unsigned long pc;
-#ifdef CONFIG_KALLSYMS
-	unsigned long frame;
-#endif
-
-	if (!p || p == current || p->state == TASK_RUNNING)
-		return 0;
-
-	stack_page = (unsigned long)task_stack_page(p);
-	if (!stack_page || !mfinfo_num)
-		return 0;
-
-	pc = thread_saved_pc(p);
-#ifdef CONFIG_KALLSYMS
-	if (!in_sched_functions(pc))
-		return pc;
-
-	frame = p->thread.reg29 + schedule_frame->frame_size;
-	do {
-		int i;
-
-		if (frame < stack_page || frame > stack_page + THREAD_SIZE - 32)
-			return 0;
-
-		for (i = mfinfo_num - 1; i >= 0; i--) {
-			if (pc >= (unsigned long) mfinfo[i].func)
-				break;
-		}
-		if (i < 0)
-			break;
-
-		if (mfinfo[i].pc_offset < 0)
-			break;
-		pc = ((unsigned long *)frame)[mfinfo[i].pc_offset];
-		if (!mfinfo[i].frame_size)
-			break;
-		frame += mfinfo[i].frame_size;
-	} while (in_sched_functions(pc));
-#endif
-
-	return pc;
-}
 
 #ifdef CONFIG_KALLSYMS
 /* used by show_backtrace() */
@@ -504,3 +444,31 @@ unsigned long unwind_stack(struct task_s
 	return __kernel_text_address(pc) ? pc : 0;
 }
 #endif
+
+/*
+ * get_wchan - a maintenance nightmare^W^Wpain in the ass ...
+ */
+unsigned long get_wchan(struct task_struct *task)
+{
+	unsigned long pc = 0;
+#ifdef CONFIG_KALLSYMS
+	unsigned long sp;
+#endif
+
+	if (!task || task == current || task->state == TASK_RUNNING)
+		goto out;
+	if (!task_stack_page(task))
+		goto out;
+
+	pc = thread_saved_pc(task);
+
+#ifdef CONFIG_KALLSYMS
+	sp = task->thread.reg29 + schedule_mfi.frame_size;
+
+	while (in_sched_functions(pc))
+		pc = unwind_stack(task, &sp, pc, 0);
+#endif
+
+out:
+	return pc;
+}
-- 
1.4.2.rc4
