Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 11:31:26 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54170 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010943AbbASKbZF8HKh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2015 11:31:25 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 54C80B0EBF783;
        Mon, 19 Jan 2015 10:31:16 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 19 Jan 2015 10:31:18 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 19 Jan 2015 10:31:17 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     Matthew Fortune <matthew.fortune@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        "Paul Burton" <paul.burton@imgtec.com>
Subject: [PATCH] MIPS: fork: Fix MSA/FPU/DSP context duplication race
Date:   Mon, 19 Jan 2015 10:30:54 +0000
Message-ID: <1421663454-8047-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

There is a race in the MIPS fork code which allows the child to get a
stale copy of parent MSA/FPU/DSP state that is active in hardware
registers when the fork() is called. This is because copy_thread() saves
the live register state into the child context only if the hardware is
currently in use, apparently on the assumption that the hardware state
cannot have been saved and disabled since the initial duplication of the
task_struct. However preemption is certainly possible during this
window.

An example sequence of events is as follows:

1) The parent userland process puts important data into saved floating
   point registers ($f20-$f31), which are then dirty compared to the
   process' stored context.

2) The parent process calls fork() which does a clone system call.

3) In the kernel, do_fork() -> copy_process() -> dup_task_struct() ->
   arch_dup_task_struct() (which uses the weakly defined default
   implementation). This duplicates the parent process' task context,
   which includes a stale version of its FP context from when it was
   last saved, probably some time before (1).

4) At some point before copy_process() calls copy_thread(), such as when
   duplicating the memory map, the process is desceduled. Perhaps it is
   preempted asynchronously, or perhaps it sleeps while blocked on a
   mutex. The dirty FP state in the FP registers is saved to the parent
   process' context and the FPU is disabled.

5) When the process is rescheduled again it continues copying state
   until it gets to copy_thread(), which checks whether the FPU is in
   use, so that it can copy that dirty state to the child process' task
   context. Because of the deschedule however the FPU is not in use, so
   the child process' context is left with stale FP context from the
   last time the parent saved it (some time before (1)).

6) When the new child process is scheduled it reads the important data
   from the saved floating point register, and ends up doing a NULL
   pointer dereference as a result of the stale data.

This use of saved floating point registers across function calls can be
triggered fairly easily by explicitly using inline asm with a current
(MIPS R2) compiler, but is far more likely to happen unintentionally
with a MIPS R6 compiler where the FP registers are more likely to get
used as scratch registers for storing non-fp data.

It is easily fixed, in the same way that other architectures do it, by
overriding the implementation of arch_dup_task_struct() to sync the
dirty hardware state to the parent process' task context *prior* to
duplicating it, rather than copying straight to the child process' task
context in copy_thread(). Note, the FPU hardware is not disabled so the
parent process may continue executing with the live register context,
but now the child process is guaranteed to have an identical copy of it
at that point.

Reported-by: Matthew Fortune <matthew.fortune@imgtec.com>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Tested-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
---
Here's my hacky test program:

int fork_fpu(float in_f)
{
	pid_t pid;
	int ret = EXIT_SUCCESS;
	register float f30 asm("$f30") = in_f;

	asm volatile("" : : "f" (f30)); /* kinda rather dodgy */
	pid = fork();
	if (pid < 0)
		return -1;
	asm volatile("" : "=f" (f30)); /* kinda rather dodgy */

	if (f30 != in_f) {
		fprintf(stderr, "%d FAIL f30=%g, in_f=%g\n", pid, f30, in_f);
		ret = EXIT_FAILURE;
	}

	if (pid == 0) /* child */
		exit(ret);
	else /* parent */
		wait(&ret);

	return ret;
}

int main(int argc, char **argv)
{
	float f;
	for (f = 0; f < 10.0f; f += 0.1f)
		if (fork_fpu(f))
			return EXIT_FAILURE;
	return EXIT_SUCCESS;
}
---
 arch/mips/kernel/process.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index eb76434828e8..85bff5d513e5 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -82,6 +82,30 @@ void flush_thread(void)
 {
 }
 
+int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
+{
+	/*
+	 * Save any process state which is live in hardware registers to the
+	 * parent context prior to duplication. This prevents the new child
+	 * state becoming stale if the parent is preempted before copy_thread()
+	 * gets a chance to save the parent's live hardware registers to the
+	 * child context.
+	 */
+	preempt_disable();
+
+	if (is_msa_enabled())
+		save_msa(current);
+	else if (is_fpu_owner())
+		_save_fp(current);
+
+	save_dsp(current);
+
+	preempt_enable();
+
+	*dst = *src;
+	return 0;
+}
+
 int copy_thread(unsigned long clone_flags, unsigned long usp,
 	unsigned long arg, struct task_struct *p)
 {
@@ -92,18 +116,6 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 
 	childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - 32;
 
-	preempt_disable();
-
-	if (is_msa_enabled())
-		save_msa(p);
-	else if (is_fpu_owner())
-		save_fp(p);
-
-	if (cpu_has_dsp)
-		save_dsp(p);
-
-	preempt_enable();
-
 	/* set up new TSS. */
 	childregs = (struct pt_regs *) childksp - 1;
 	/*  Put the stack after the struct pt_regs.  */
-- 
2.0.5
