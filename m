Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jan 2005 03:09:45 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:5395
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225294AbVAZDJZ>; Wed, 26 Jan 2005 03:09:25 +0000
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 26 Jan 2005 03:09:22 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id A9E07239E55; Wed, 26 Jan 2005 12:09:17 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j0Q39GRm094840;
	Wed, 26 Jan 2005 12:09:17 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 26 Jan 2005 12:09:16 +0900 (JST)
Message-Id: <20050126.120916.88699500.nemoto@toshiba-tops.co.jp>
To:	nacc@us.ibm.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	kernel-janitors@lists.osdl.org
Subject: Re: MIPS still uses sleep_on*()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050125214701.GA2689@us.ibm.com>
References: <20050125214701.GA2689@us.ibm.com>
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
X-archive-position: 7040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 25 Jan 2005 13:47:01 -0800, Nishanth Aravamudan <nacc@us.ibm.com> said:
nacc> The only file I'm not comfortable with changing myself (since I
nacc> am not a MIPS user/expert) is arch/mips/kernel/process.c. This
nacc> file references sleep_on(), sleep_on_timeout(),
nacc> interruptible_sleep_on() and interruptible_sleep_on_timeout().

Those references are just to implement get_wchan.  And anyway current
MIPS get_wchan is broken for a long time.

I suppose searching a caller of scheduling functions is not necessary.
Calling thread_saved_pc() will be enough for most usage.

Ralf, how about this patch?

diff -u linux-mips/arch/mips/kernel/process.c linux/arch/mips/kernel/process.c
--- linux-mips/arch/mips/kernel/process.c	2005-01-11 10:00:07.000000000 +0900
+++ linux/arch/mips/kernel/process.c	2005-01-26 10:23:21.000000000 +0900
@@ -186,11 +186,6 @@
 	int pc_offset;
 };
 static struct mips_frame_info schedule_frame;
-static struct mips_frame_info schedule_timeout_frame;
-static struct mips_frame_info sleep_on_frame;
-static struct mips_frame_info sleep_on_timeout_frame;
-static struct mips_frame_info wait_for_completion_frame;
-static int mips_frame_info_initialized;
 static int __init get_frame_info(struct mips_frame_info *info, void *func)
 {
 	int i;
@@ -242,14 +237,7 @@
 
 static int __init frame_info_init(void)
 {
-	mips_frame_info_initialized =
-		!get_frame_info(&schedule_frame, schedule) &&
-		!get_frame_info(&schedule_timeout_frame, schedule_timeout) &&
-		!get_frame_info(&sleep_on_frame, sleep_on) &&
-		!get_frame_info(&sleep_on_timeout_frame, sleep_on_timeout) &&
-		!get_frame_info(&wait_for_completion_frame, wait_for_completion);
-
-	return 0;
+	return get_frame_info(&schedule_frame, schedule);
 }
 
 arch_initcall(frame_info_init);
@@ -270,59 +258,14 @@
 	return ((unsigned long *)t->reg29)[schedule_frame.pc_offset];
 }
 
-/* get_wchan - a maintenance nightmare^W^Wpain in the ass ...  */
 unsigned long get_wchan(struct task_struct *p)
 {
-	unsigned long frame, pc;
+	unsigned long pc;
 
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
 
-	if (!mips_frame_info_initialized)
-		return 0;
 	pc = thread_saved_pc(p);
-	if (!in_sched_functions(pc))
-		goto out;
-
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
-
-out:
-
 #ifdef CONFIG_MIPS64
 	if (current->thread.mflags & MF_32BIT_REGS) /* Kludge for 32-bit ps  */
 		pc &= 0xffffffffUL;
