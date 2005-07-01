Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 03:44:37 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:38918
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8226124AbVGACoP>; Fri, 1 Jul 2005 03:44:15 +0100
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 1 Jul 2005 02:44:03 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id A4A041F472;
	Fri,  1 Jul 2005 11:43:59 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 8EB6318E4E;
	Fri,  1 Jul 2005 11:43:59 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j612hwoj014952;
	Fri, 1 Jul 2005 11:43:59 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 01 Jul 2005 11:43:58 +0900 (JST)
Message-Id: <20050701.114358.21591461.nemoto@toshiba-tops.co.jp>
To:	djohnson+linuxmips@sw.starentnetworks.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: preempt_schedule_irq missing from mfinfo[]?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <17092.5345.75666.403044@cortez.sw.starentnetworks.com>
References: <17092.5345.75666.403044@cortez.sw.starentnetworks.com>
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
X-archive-position: 8282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 30 Jun 2005 11:50:57 -0400, Dave Johnson <djohnson+linuxmips@sw.starentnetworks.com> said:
dave> The PC it was trying to lookup is in preempt_schedule_irq().
dave> Without preempt_schedule_irq in mfinfo[] it ended up with the
dave> wrong function and then dereferenced a NULL FP.

dave> Should this be in mfinfo or am I on the wrong track here?
...
dave> Also, __preempt_spin_lock and __preempt_write_lock are nowhere
dave> to be found so I had to remove those from the table.

Well, The current get_wchan implementation is still problematic
because:

* Some functions in __sched (and __lock) section are static.
* Functions in __lock are not handled.
* Maintenance of the struct mips_frame_info mfinfo[] is a pain.
* sleep_on*() is deprecated.  kernel-janitors people want to remove
  references for them.

I suppose searching a caller of scheduling functions in get_wchan is
not necessary.  Calling thread_saved_pc() will be enough for most
usage.

So I posted a patch to simplify things a while ago.

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20050126.120916.88699500.nemoto%40toshiba-tops.co.jp

And here is a revised patch.

diff -u linux-mips/arch/mips/kernel/process.c linux/arch/mips/kernel/process.c
--- linux-mips/arch/mips/kernel/process.c	2005-06-21 17:34:10.000000000 +0900
+++ linux/arch/mips/kernel/process.c	2005-07-01 11:15:26.000000000 +0900
@@ -270,47 +270,15 @@
 }
 
 static struct mips_frame_info {
-	void *func;
-	int omit_fp;	/* compiled without fno-omit-frame-pointer */
 	int frame_offset;
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
-
-static int mips_frame_info_initialized;
-static int __init get_frame_info(struct mips_frame_info *info)
+} schedule_frame;
+static int __init get_frame_info(struct mips_frame_info *info, void *func)
 {
 	int i;
-	void *func = info->func;
 	union mips_instruction *ip = (union mips_instruction *)func;
 	info->pc_offset = -1;
-	info->frame_offset = info->omit_fp ? 0 : -1;
+	info->frame_offset = -1;
 	for (i = 0; i < 128; i++, ip++) {
 		/* if jal, jalr, jr, stop. */
 		if (ip->j_format.opcode == jal_op ||
@@ -358,26 +326,7 @@
 
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
-	return 0;
+	return get_frame_info(&schedule_frame, schedule);
 }
 
 arch_initcall(frame_info_init);
@@ -398,39 +347,12 @@
 	return ((unsigned long *)t->reg29)[schedule_frame.pc_offset];
 }
 
-/* get_wchan - a maintenance nightmare^W^Wpain in the ass ...  */
 unsigned long get_wchan(struct task_struct *p)
 {
-	unsigned long frame, pc;
-
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
 
-	if (!mips_frame_info_initialized)
-		return 0;
-	pc = thread_saved_pc(p);
-
-	if (!in_sched_functions(pc))
-		goto out;
-
-	frame = ((unsigned long *)p->thread.reg30)[schedule_frame.frame_offset];
-	do {
-		int i;
-		for (i = ARRAY_SIZE(mfinfo) - 1; i >= 0; i--) {
-			if (pc >= (unsigned long) mfinfo[i].func)
-				break;
-		}
-		if (i < 0)
-			break;
-
-		if (mfinfo[i].omit_fp)
-			break;
-		pc = ((unsigned long *)frame)[mfinfo[i].pc_offset];
-		frame = ((unsigned long *)frame)[mfinfo[i].frame_offset];
-	} while (in_sched_functions(pc));
-
-out:
-	return pc;
+	return thread_saved_pc(p);
 }
 
 EXPORT_SYMBOL(get_wchan);


---
Atsushi Nemoto
