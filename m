Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Sep 2004 11:07:55 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:51488
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224944AbUIXKHt>; Fri, 24 Sep 2004 11:07:49 +0100
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 24 Sep 2004 10:07:47 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 23C8D239E1D; Fri, 24 Sep 2004 19:10:22 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i8OA7e8G074458;
	Fri, 24 Sep 2004 19:07:40 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Fri, 24 Sep 2004 19:06:40 +0900 (JST)
Message-Id: <20040924.190640.09669815.nemoto@toshiba-tops.co.jp>
To: thomas.petazzoni@enix.org
Cc: linux-mips@linux-mips.org, mentre@tcl.ite.mee.com
Subject: Re: "Can't analyze prologue code ..." at boot time
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20040924085240.GP24730@enix.org>
References: <20040924085240.GP24730@enix.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 24 Sep 2004 10:52:40 +0200, Thomas Petazzoni <thomas.petazzoni@enix.org> said:
thomas> In arch/mips/kernel/process.c, the function frame_info_init()
thomas> called at boot time, calls the get_frame_info() to a analyze
thomas> the prologue of a few functions (I don't know why, does anyone
thomas> know ?).

Because thread_saved_pc(), get_wchan() needs those information.

The information of 'schedule' function is required, others are
optional ("ps -l" shows better output with those informations).

thomas> The get_frame_info() seems to search a sw or sd instruction,
thomas> but here is the beginning of the schedule_timeout() function :

This is because now schedule_timeout is in kernel/timer.c (not
kernel/sched.c) which is compiled without -fno-omit-frame-pointer
option.

I rewrote get_wchan() to handle this problem.  Please try this patch.

Note that this patch still depends on order of address of sched
functions, so not gcc-3.4 proof.  Sorting minfo[] array will make it
more robust.  If anyone interested in, I will implement it.

diff -u linux-mips/arch/mips/kernel/process.c linux/arch/mips/kernel/process.c
--- linux-mips/arch/mips/kernel/process.c	Wed Sep 22 13:27:59 2004
+++ linux/arch/mips/kernel/process.c	Wed Sep 22 17:03:10 2004
@@ -177,21 +177,41 @@
 }
 
 struct mips_frame_info {
+	void *func;
+	int omit_fp;	/* compiled without fno-omit-frame-pointer */
 	int frame_offset;
 	int pc_offset;
+} mfinfo [] = {
+	/* must be in address order */
+	{ __down_interruptible, 1 },
+	{ schedule, 0 },
+#define schedule_frame 1
+#ifdef CONFIG_PREEMPT
+	{ preempt_schedule, 0 },
+#endif
+	{ wait_for_completion, 0 },
+	{ interruptible_sleep_on, 0 },
+	{ interruptible_sleep_on_timeout, 0 },
+	{ sleep_on, 0 },
+	{ sleep_on_timeout, 0 },
+	{ __cond_resched, 0 },
+	{ yield, 0 },
+	{ io_schedule, 0 },
+	{ io_schedule_timeout, 0 },
+	{ schedule_timeout, 1 },
+/*	{ nanosleep_restart, 1 }, */
+	{ __down_read, 1 },
+	{ __down_write, 1 },
 };
-static struct mips_frame_info schedule_frame;
-static struct mips_frame_info schedule_timeout_frame;
-static struct mips_frame_info sleep_on_frame;
-static struct mips_frame_info sleep_on_timeout_frame;
-static struct mips_frame_info wait_for_completion_frame;
+
 static int mips_frame_info_initialized;
-static int __init get_frame_info(struct mips_frame_info *info, void *func)
+static int __init get_frame_info(struct mips_frame_info *info)
 {
 	int i;
+	void *func = info->func;
 	union mips_instruction *ip = (union mips_instruction *)func;
 	info->pc_offset = -1;
-	info->frame_offset = -1;
+	info->frame_offset = info->omit_fp ? 0 : -1;
 	for (i = 0; i < 128; i++, ip++) {
 		/* if jal, jalr, jr, stop. */
 		if (ip->j_format.opcode == jal_op ||
@@ -237,13 +257,11 @@
 
 static int __init frame_info_init(void)
 {
-	mips_frame_info_initialized =
-		!get_frame_info(&schedule_frame, schedule) &&
-		!get_frame_info(&schedule_timeout_frame, schedule_timeout) &&
-		!get_frame_info(&sleep_on_frame, sleep_on) &&
-		!get_frame_info(&sleep_on_timeout_frame, sleep_on_timeout) &&
-		!get_frame_info(&wait_for_completion_frame, wait_for_completion);
-
+	int i;
+	for (i = 0; i < ARRAY_SIZE(mfinfo); i++)
+		if (get_frame_info(&mfinfo[i]))
+			return -1;
+	mips_frame_info_initialized = 1;
 	return 0;
 }
 
@@ -261,9 +279,9 @@
 	if (t->reg31 == (unsigned long) ret_from_fork)
 		return t->reg31;
 
-	if (schedule_frame.pc_offset < 0)
+	if (mfinfo[schedule_frame].pc_offset < 0)
 		return 0;
-	return ((unsigned long *)t->reg29)[schedule_frame.pc_offset];
+	return ((unsigned long *)t->reg29)[mfinfo[schedule_frame].pc_offset];
 }
 
 /* get_wchan - a maintenance nightmare^W^Wpain in the ass ...  */
@@ -277,48 +295,27 @@
 	if (!mips_frame_info_initialized)
 		return 0;
 	pc = thread_saved_pc(p);
+
 	if (!in_sched_functions(pc))
 		goto out;
 
-	if (pc >= (unsigned long) sleep_on_timeout)
-		goto schedule_timeout_caller;
-	if (pc >= (unsigned long) sleep_on)
-		goto schedule_caller;
-	if (pc >= (unsigned long) interruptible_sleep_on_timeout)
-		goto schedule_timeout_caller;
-	if (pc >= (unsigned long)interruptible_sleep_on)
-		goto schedule_caller;
-	if (pc >= (unsigned long)wait_for_completion)
-		goto schedule_caller;
-	goto schedule_timeout_caller;
-
-schedule_caller:
-	frame = ((unsigned long *)p->thread.reg30)[schedule_frame.frame_offset];
-	if (pc >= (unsigned long) sleep_on)
-		pc = ((unsigned long *)frame)[sleep_on_frame.pc_offset];
-	else
-		pc = ((unsigned long *)frame)[wait_for_completion_frame.pc_offset];
-	goto out;
-
-schedule_timeout_caller:
-	/*
-	 * The schedule_timeout frame
-	 */
-	frame = ((unsigned long *)p->thread.reg30)[schedule_frame.frame_offset];
-
-	/*
-	 * frame now points to sleep_on_timeout's frame
-	 */
-	pc    = ((unsigned long *)frame)[schedule_timeout_frame.pc_offset];
-
-	if (in_sched_functions(pc)) {
-		/* schedule_timeout called by [interruptible_]sleep_on_timeout */
-		frame = ((unsigned long *)frame)[schedule_timeout_frame.frame_offset];
-		pc    = ((unsigned long *)frame)[sleep_on_timeout_frame.pc_offset];
-	}
+	frame = ((unsigned long *)p->thread.reg30)[mfinfo[schedule_frame].frame_offset];
+	do {
+		int i;
+		for (i = ARRAY_SIZE(mfinfo) - 1; i >= 0; i--) {
+			if (pc >= (unsigned long) mfinfo[i].func)
+				break;
+		}
+		if (i < 0)
+			break;
 
-out:
+		if (mfinfo[i].omit_fp)
+			break;
+		pc = ((unsigned long *)frame)[mfinfo[i].pc_offset];
+		frame = ((unsigned long *)frame)[mfinfo[i].frame_offset];
+	} while (in_sched_functions(pc));
 
+out:
 #ifdef CONFIG_MIPS64
 	if (current->thread.mflags & MF_32BIT_REGS) /* Kludge for 32-bit ps  */
 		pc &= 0xffffffffUL;


---
Atsushi Nemoto
