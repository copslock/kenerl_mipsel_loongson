Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2006 14:58:00 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.187]:13714 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037471AbWHQN56 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 17 Aug 2006 14:57:58 +0100
Received: by nf-out-0910.google.com with SMTP id l23so1112988nfc
        for <linux-mips@linux-mips.org>; Thu, 17 Aug 2006 06:57:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=gcEg98Fz+rG79E4/NRRZLWvQ5RrxyIbXzxwM+yWhFqmPDZNVmY+ZdflDw4Y+0uK1RqYlSKBGh3Ra1LkvgrdbZlT96+oX8I1pGSQgz9auksFqt1UQc06OXPtEYg3JzMe8JtcFtP8JPsLKbDQduKXqfgyYE5BoKY69KAoVurnRRkI=
Received: by 10.49.10.3 with SMTP id n3mr2304504nfi;
        Thu, 17 Aug 2006 06:57:57 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id g1sm5683857nfe.2006.08.17.06.57.55;
        Thu, 17 Aug 2006 06:57:56 -0700 (PDT)
Message-ID: <44E475C8.5000105@innova-card.com>
Date:	Thu, 17 Aug 2006 15:57:28 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Franck <vagabon.xyz@gmail.com>
Subject: [PATCH] Remove mfinfo[64] used by get_wchan()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12350
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

It results in a smaller bss and a better code:

   text    data     bss     dec     hex filename
2543808  254148  139296 2937252  2cd1a4 vmlinux-new-get-wchan
2544080  254148  143392 2941620  2ce2b4 vmlinux~old

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 arch/mips/kernel/process.c |  132 +++++++++++++++++---------------------------
 1 files changed, 50 insertions(+), 82 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 951bf9c..6d050fa 100644
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
@@ -340,45 +342,31 @@ static int get_frame_info(struct mips_fr
 	return -1;
 }
 
+static struct mips_frame_info schedule_mfi __read_mostly;
+
 static int __init frame_info_init(void)
 {
-	int i;
+	unsigned long size = 0;
+
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
 
@@ -394,58 +382,11 @@ unsigned long thread_saved_pc(struct tas
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
@@ -493,3 +434,30 @@ unsigned long unwind_stack(struct task_s
 	return __kernel_text_address(pc) ? pc : 0;
 }
 #endif
+
+/*
+ * get_wchan - a maintenance nightmare^W^Wpain in the ass ...
+ */
+unsigned long get_wchan(struct task_struct *task)
+{
+	unsigned long stack_page = (unsigned long)task_stack_page(task);
+	unsigned long pc = 0;
+#ifdef CONFIG_KALLSYMS
+	unsigned long sp = task->thread.reg29;
+#endif
+
+	if (!task || task == current || task->state == TASK_RUNNING)
+		goto out;
+	if (!stack_page)
+		goto out;
+
+	pc = thread_saved_pc(task);
+
+#ifdef CONFIG_KALLSYMS
+	while (in_sched_functions(pc))
+		pc = unwind_stack(task, &sp, pc, 0);
+#endif
+
+out:
+	return pc;
+}
-- 
1.4.2.rc4
