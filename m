Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 21:35:15 +0100 (BST)
Received: from pasta.sw.starentnetworks.com ([IPv6:::ffff:12.33.234.10]:27107
	"EHLO pasta.sw.starentnetworks.com") by linux-mips.org with ESMTP
	id <S8226101AbVF3Ue5>; Thu, 30 Jun 2005 21:34:57 +0100
Received: from cortez.sw.starentnetworks.com (cortez.sw.starentnetworks.com [12.33.233.12])
	by pasta.sw.starentnetworks.com (Postfix) with ESMTP id 0F88314B673
	for <linux-mips@linux-mips.org>; Thu, 30 Jun 2005 16:34:36 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17092.22363.933331.427299@cortez.sw.starentnetworks.com>
Date:	Thu, 30 Jun 2005 16:34:35 -0400
From:	Dave Johnson <djohnson+linuxmips@sw.starentnetworks.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] Re: preempt_schedule_irq missing from mfinfo[]?
In-Reply-To: <17092.14511.626777.981192@cortez.sw.starentnetworks.com>
References: <17092.5345.75666.403044@cortez.sw.starentnetworks.com>
	<17092.14511.626777.981192@cortez.sw.starentnetworks.com>
X-Mailer: VM 7.07 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Return-Path: <djohnson@sw.starentnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djohnson+linuxmips@sw.starentnetworks.com
Precedence: bulk
X-list: linux-mips

Dave Johnson writes:
> Looks like more than preempt_schedule_irq are missing.
> 
> I've got these in .sched.text:
> 
> ffffffff8031ea70 T __sched_text_start
> ffffffff8031eb88 T __down_interruptible
> ffffffff8031ed18 T schedule
> ffffffff8031f7e8 T preempt_schedule
> ffffffff8031f8a8 T preempt_schedule_irq
> ffffffff8031f9b0 T wait_for_completion
> ffffffff8031fae0 T wait_for_completion_timeout
> ffffffff8031fc58 T wait_for_completion_interruptible
> ffffffff8031fdf0 T wait_for_completion_interruptible_timeout
> ffffffff8031ff98 T interruptible_sleep_on
> ffffffff80320070 T interruptible_sleep_on_timeout
> ffffffff80320160 T sleep_on
> ffffffff80320238 T sleep_on_timeout
> ffffffff80320328 T cond_resched
> ffffffff803203c0 T cond_resched_softirq
> ffffffff80320478 T yield
> ffffffff803204b8 T io_schedule
> ffffffff80320548 T io_schedule_timeout
> ffffffff803205d8 T console_conditional_schedule
> ffffffff80320610 T schedule_timeout
> ffffffff803206f0 t nanosleep_restart
> ffffffff803207f0 T __wait_on_bit
> ffffffff80320910 T out_of_line_wait_on_bit
> ffffffff803209e0 T __wait_on_bit_lock
> ffffffff80320b28 T out_of_line_wait_on_bit_lock
> ffffffff80320bf8 T __down_read
> ffffffff80320d00 T __down_write
> ffffffff80320e10 T __lock_text_start
> ffffffff80320e10 T __sched_text_end
> 
> All of those should be in mfinfo[] with omit_fp 1 for those in
> kernel/sched.c and 0 for elsewhere.  Or am I missing something here?

make that 0 and 1 not 0 and 1.

Patch for these is below.

-- 
Dave Johnson
Starent Networks


diff -Nru a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
--- a/arch/mips/kernel/process.c	Thu Jun 30 16:11:58 2005
+++ b/arch/mips/kernel/process.c	Thu Jun 30 16:11:58 2005
@@ -24,6 +24,7 @@
 #include <linux/a.out.h>
 #include <linux/init.h>
 #include <linux/completion.h>
+#include <linux/console.h>
 
 #include <asm/abi.h>
 #include <asm/bootinfo.h>
@@ -279,28 +280,44 @@
 	/* arch/mips/kernel/semaphore.c */
 	{ __down, 1 },
 	{ __down_interruptible, 1 },
+	/* kernel/printk.c */
+	{ console_conditional_schedule, 1 },
 	/* kernel/sched.c */
 #ifdef CONFIG_PREEMPT
 	{ preempt_schedule, 0 },
+	{ preempt_schedule_irq, 0 },
 #endif
 	{ wait_for_completion, 0 },
+	{ wait_for_completion_timeout, 0 },
+	{ wait_for_completion_interruptible, 0 },
+	{ wait_for_completion_interruptible_timeout, 0 },
 	{ interruptible_sleep_on, 0 },
 	{ interruptible_sleep_on_timeout, 0 },
 	{ sleep_on, 0 },
 	{ sleep_on_timeout, 0 },
+	{ cond_resched, 0 },
+	{ cond_resched_softirq, 0 },
 	{ yield, 0 },
 	{ io_schedule, 0 },
 	{ io_schedule_timeout, 0 },
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
-	{ __preempt_spin_lock, 0 },
-	{ __preempt_write_lock, 0 },
-#endif
+	/* kernel/wait.c */
+	{ __wait_on_bit, 1 },
+	{ out_of_line_wait_on_bit, 1 },
+	{ __wait_on_bit_lock, 1 },
+	{ out_of_line_wait_on_bit_lock, 1 },
 	/* kernel/timer.c */
 	{ schedule_timeout, 1 },
-/*	{ nanosleep_restart, 1 }, */
+	{ nanosleep_restart, 1 },
+#ifdef CONFIG_RWSEM_XCHGADD_ALGORITHM
+	/* lib/rwsem.c */
+	{ rwsem_down_read_failed, 1 },
+	{ rwsem_down_write_failed, 1 },
+#endif
+#ifdef CONFIG_RWSEM_GENERIC_SPINLOCK
 	/* lib/rwsem-spinlock.c */
 	{ __down_read, 1 },
 	{ __down_write, 1 },
+#endif
 };
 
 static int mips_frame_info_initialized;
diff -Nru a/include/linux/preempt.h b/include/linux/preempt.h
--- a/include/linux/preempt.h	Thu Jun 30 16:11:58 2005
+++ b/include/linux/preempt.h	Thu Jun 30 16:11:58 2005
@@ -25,6 +25,7 @@
 #ifdef CONFIG_PREEMPT
 
 asmlinkage void preempt_schedule(void);
+asmlinkage void preempt_schedule_irq(void);
 
 #define preempt_disable() \
 do { \
diff -Nru a/include/linux/timer.h b/include/linux/timer.h
--- a/include/linux/timer.h	Thu Jun 30 16:11:58 2005
+++ b/include/linux/timer.h	Thu Jun 30 16:11:58 2005
@@ -99,4 +99,6 @@
 extern void run_local_timers(void);
 extern void it_real_fn(unsigned long);
 
+extern long nanosleep_restart(struct restart_block *restart);
+
 #endif
diff -Nru a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c	Thu Jun 30 16:11:58 2005
+++ b/kernel/timer.c	Thu Jun 30 16:11:58 2005
@@ -1135,7 +1135,7 @@
 	return current->pid;
 }
 
-static long __sched nanosleep_restart(struct restart_block *restart)
+long __sched nanosleep_restart(struct restart_block *restart)
 {
 	unsigned long expire = restart->arg0, now = jiffies;
 	struct timespec __user *rmtp = (struct timespec __user *) restart->arg1;
