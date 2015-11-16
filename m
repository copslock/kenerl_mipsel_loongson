Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2015 15:34:57 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57413 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011673AbbKPOey4qcwR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Nov 2015 15:34:54 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 53AC5E15D40BD;
        Mon, 16 Nov 2015 14:34:46 +0000 (GMT)
Received: from [10.100.200.62] (10.100.200.62) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server id 14.3.235.1; Mon, 16 Nov 2015
 14:34:48 +0000
Date:   Mon, 16 Nov 2015 14:34:47 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Daniel Sanders <Daniel.Sanders@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 2/4] MIPS: Factor out FP context preemption
In-Reply-To: <alpine.DEB.2.00.1511161358211.7097@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1511161413270.7097@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1511161358211.7097@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.62]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
Following the discussion around commit 9791554b [MIPS,prctl: add 
PR_[GS]ET_FP_MODE prctl options for MIPS] or 
<http://patchwork.linux-mips.org/patch/8899/> and Leonid's observation 
<http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=54B02115.7090609%40imgtec.com> 
in particular, I agree this would best be done with an IPI, however such 
an improvement is independent of the changes made as a part of this series 
so I took the minimal approach and left the solution implemented so far 
unchanged.  Especially as Leonid says he's got a patch already available.

linux-mips-process-fp-context.diff
Index: linux-sfr-test/arch/mips/kernel/process.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/process.c	2015-11-13 00:36:09.885716000 +0000
+++ linux-sfr-test/arch/mips/kernel/process.c	2015-11-16 13:50:18.962058000 +0000
@@ -570,6 +570,60 @@ void arch_trigger_all_cpu_backtrace(bool
 	smp_call_function(arch_dump_stack, NULL, 1);
 }
 
+/*
+ * Make the FP context available for mode changes.
+ */
+static void mips_get_fp_context(struct task_struct *task)
+{
+	unsigned long switch_count;
+	struct task_struct *t;
+
+	/* Save FP & vector context, then disable FPU & MSA.  */
+	if (task->signal == current->signal)
+		lose_fpu(1);
+
+	/* Prevent any threads from obtaining live FP context.  */
+	atomic_set(&task->mm->context.fp_mode_switching, 1);
+	smp_mb__after_atomic();
+
+	/*
+	 * If there are multiple online CPUs then wait until all threads
+	 * whose FP mode is about to change have been context switched.
+	 * This approach allows us to only worry about whether an FP mode
+	 * switch is in progress when FP is first used in a tasks time
+	 * slice.  Pretty much all of the mode switch overhead can thus
+	 * be confined to cases where mode switches are actually occurring.
+	 * That is, to here.  However for the thread performing the mode
+	 * switch it may take a while...
+	 */
+	if (num_online_cpus() > 1) {
+		spin_lock_irq(&task->sighand->siglock);
+
+		for_each_thread(task, t) {
+			if (t == current)
+				continue;
+
+			switch_count = t->nvcsw + t->nivcsw;
+
+			do {
+				spin_unlock_irq(&task->sighand->siglock);
+				cond_resched();
+				spin_lock_irq(&task->sighand->siglock);
+			} while ((t->nvcsw + t->nivcsw) == switch_count);
+		}
+
+		spin_unlock_irq(&task->sighand->siglock);
+	}
+}
+
+/*
+ * Allow threads to use FP again.
+ */
+static void mips_put_fp_context(struct task_struct *task)
+{
+	atomic_set(&task->mm->context.fp_mode_switching, 0);
+}
+
 int mips_get_process_fp_mode(struct task_struct *task)
 {
 	int value = 0;
@@ -585,7 +639,6 @@ int mips_get_process_fp_mode(struct task
 int mips_set_process_fp_mode(struct task_struct *task, unsigned int value)
 {
 	const unsigned int known_bits = PR_FP_MODE_FR | PR_FP_MODE_FRE;
-	unsigned long switch_count;
 	struct task_struct *t;
 
 	/* Check the value is valid */
@@ -603,41 +656,7 @@ int mips_set_process_fp_mode(struct task
 	if (!(value & PR_FP_MODE_FR) && cpu_has_fpu && cpu_has_mips_r6)
 		return -EOPNOTSUPP;
 
-	/* Save FP & vector context, then disable FPU & MSA */
-	if (task->signal == current->signal)
-		lose_fpu(1);
-
-	/* Prevent any threads from obtaining live FP context */
-	atomic_set(&task->mm->context.fp_mode_switching, 1);
-	smp_mb__after_atomic();
-
-	/*
-	 * If there are multiple online CPUs then wait until all threads whose
-	 * FP mode is about to change have been context switched. This approach
-	 * allows us to only worry about whether an FP mode switch is in
-	 * progress when FP is first used in a tasks time slice. Pretty much all
-	 * of the mode switch overhead can thus be confined to cases where mode
-	 * switches are actually occuring. That is, to here. However for the
-	 * thread performing the mode switch it may take a while...
-	 */
-	if (num_online_cpus() > 1) {
-		spin_lock_irq(&task->sighand->siglock);
-
-		for_each_thread(task, t) {
-			if (t == current)
-				continue;
-
-			switch_count = t->nvcsw + t->nivcsw;
-
-			do {
-				spin_unlock_irq(&task->sighand->siglock);
-				cond_resched();
-				spin_lock_irq(&task->sighand->siglock);
-			} while ((t->nvcsw + t->nivcsw) == switch_count);
-		}
-
-		spin_unlock_irq(&task->sighand->siglock);
-	}
+	mips_get_fp_context(task);
 
 	/*
 	 * There are now no threads of the process with live FP context, so it
@@ -659,8 +678,7 @@ int mips_set_process_fp_mode(struct task
 			clear_tsk_thread_flag(t, TIF_HYBRID_FPREGS);
 	}
 
-	/* Allow threads to use FP again */
-	atomic_set(&task->mm->context.fp_mode_switching, 0);
+	mips_put_fp_context(task);
 
 	return 0;
 }
