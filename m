Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Oct 2004 12:42:46 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:47622
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224774AbUJ2Lmj>; Fri, 29 Oct 2004 12:42:39 +0100
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 29 Oct 2004 11:42:37 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id E2B8D239E3B; Fri, 29 Oct 2004 20:20:05 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i9TBK2dD001125;
	Fri, 29 Oct 2004 20:20:02 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Fri, 29 Oct 2004 20:18:52 +0900 (JST)
Message-Id: <20041029.201852.124282105.nemoto@toshiba-tops.co.jp>
To: thomas.petazzoni@enix.org
Cc: linux-mips@linux-mips.org, mentre@tcl.ite.mee.com,
	ralf@linux-mips.org
Subject: Re: "Can't analyze prologue code ..." at boot time
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20041029.000757.74756533.anemo@mba.ocn.ne.jp>
References: <20040924085240.GP24730@enix.org>
	<20040924.190640.09669815.nemoto@toshiba-tops.co.jp>
	<20041029.000757.74756533.anemo@mba.ocn.ne.jp>
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
X-archive-position: 6229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 29 Oct 2004 00:07:57 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
anemo> Here is a revised patch which can work with gcc 3.4.

anemo> Ralf, how about this patch?  No more maintenance nightmare :-)

I found that still "Can't analyze" message displayed with gcc 3.4.
Revised again.

diff -u linux-mips-cvs/arch/mips/kernel/process.c linux-mips/arch/mips/kernel/process.c
--- linux-mips-cvs/arch/mips/kernel/process.c	Fri Oct 29 20:14:01 2004
+++ linux-mips/arch/mips/kernel/process.c	Fri Oct 29 20:13:18 2004
@@ -185,22 +185,49 @@
 	return do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);
 }
 
-struct mips_frame_info {
+static struct mips_frame_info {
+	void *func;
+	int omit_fp;	/* compiled without fno-omit-frame-pointer */
 	int frame_offset;
 	int pc_offset;
+} schedule_frame, mfinfo[] = {
+	{ schedule, 0 },	/* must be first */
+	/* arch/mips/kernel/semaphore.c */
+	{ __down, 1 },
+	{ __down_interruptible, 1 },
+	/* kernel/sched.c */
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
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
+	{ __preempt_spin_lock, 0 },
+	{ __preempt_write_lock, 0 },
+#endif
+	/* kernel/timer.c */
+	{ schedule_timeout, 1 },
+/*	{ nanosleep_restart, 1 }, */
+	/* lib/rwsem-spinlock.c */
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
@@ -227,8 +254,10 @@
 			}
 			/* sw / sd $s8, offset($sp) */
 			if (ip->i_format.rt == 30) {
+#if 0	/* gcc 3.4 does aggressive optimization... */
 				if (info->frame_offset != -1)
 					break;
+#endif
 				info->frame_offset =
 					ip->i_format.simmediate / sizeof(long);
 			}
@@ -246,13 +275,25 @@
 
 static int __init frame_info_init(void)
 {
-	mips_frame_info_initialized =
-		!get_frame_info(&schedule_frame, schedule) &&
-		!get_frame_info(&schedule_timeout_frame, schedule_timeout) &&
-		!get_frame_info(&sleep_on_frame, sleep_on) &&
-		!get_frame_info(&sleep_on_timeout_frame, sleep_on_timeout) &&
-		!get_frame_info(&wait_for_completion_frame, wait_for_completion);
-
+	int i, found;
+	for (i = 0; i < ARRAY_SIZE(mfinfo); i++)
+		if (get_frame_info(&mfinfo[i]))
+			return -1;
+	schedule_frame = mfinfo[0];
+	/* bubble sort */
+	do {
+		struct mips_frame_info tmp;
+		found = 0;
+		for (i = 1; i < ARRAY_SIZE(mfinfo); i++) {
+			if (mfinfo[i-1].func > mfinfo[i].func) {
+				tmp = mfinfo[i];
+				mfinfo[i] = mfinfo[i-1];
+				mfinfo[i-1] = tmp;
+				found = 1;
+			}
+		}
+	} while (found);
+	mips_frame_info_initialized = 1;
 	return 0;
 }
 
@@ -286,45 +327,25 @@
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
 	frame = ((unsigned long *)p->thread.reg30)[schedule_frame.frame_offset];
+	do {
+		int i;
+		for (i = ARRAY_SIZE(mfinfo) - 1; i >= 0; i--) {
+			if (pc >= (unsigned long) mfinfo[i].func)
+				break;
+		}
+		if (i < 0)
+			break;
 
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
+		if (mfinfo[i].omit_fp)
+			break;
+		pc = ((unsigned long *)frame)[mfinfo[i].pc_offset];
+		frame = ((unsigned long *)frame)[mfinfo[i].frame_offset];
+	} while (in_sched_functions(pc));
 
 out:
 

---
Atsushi Nemoto
