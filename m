Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 23:23:19 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:34913 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041479AbcFIVTCcnW2E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 23:19:02 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1bB7Lx-0005Mh-IM; Thu, 09 Jun 2016 21:19:01 +0000
Received: from kamal by fourier with local (Exim 4.86_2)
        (envelope-from <kamal@whence.com>)
        id 1bB7Lu-0006Cf-RV; Thu, 09 Jun 2016 14:18:58 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 4.2.y-ckt 105/206] MIPS: Force CPUs to lose FP context during mode switches
Date:   Thu,  9 Jun 2016 14:15:14 -0700
Message-Id: <1465507015-23052-106-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1465507015-23052-1-git-send-email-kamal@canonical.com>
References: <1465507015-23052-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 4.2
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

4.2.8-ckt12 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

From: Paul Burton <paul.burton@imgtec.com>

commit 6b8322576e9d325b65c54fbef64e4e8690ad70ce upstream.

Commit 9791554b45a2 ("MIPS,prctl: add PR_[GS]ET_FP_MODE prctl options
for MIPS") added support for the PR_SET_FP_MODE prctl, which allows a
userland program to modify its FP mode at runtime. This is most notably
required if dynamic linking leads to the FP mode requirement changing at
runtime from that indicated in the initial executable's ELF header. In
order to avoid overhead in the general FP context restore code, it aimed
to have threads in the process become unable to enable the FPU during a
mode switch & have the thread calling the prctl syscall wait for all
other threads in the process to be context switched at least once. Once
that happens we can know that no thread in the process whose mode will
be switched has live FP context, and it's safe to perform the mode
switch. However in the (rare) case of modeswitches occurring in
multithreaded programs this can lead to indeterminate delays for the
thread invoking the prctl syscall, and the code monitoring for those
context switches was woefully inadequate for all but the simplest cases.

Fix this by broadcasting an IPI if other CPUs may have live FP context
for an affected thread, with a handler causing those CPUs to relinquish
their FPU ownership. Threads will then be allowed to continue running
but will stall on the wait_on_atomic_t in enable_restore_fp_context if
they attempt to use FP again whilst the mode switch is still in
progress. The end result is less fragile poking at scheduler context
switch counts & a more expedient completion of the mode switch.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 9791554b45a2 ("MIPS,prctl: add PR_[GS]ET_FP_MODE prctl options for MIPS")
Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: Adam Buchbinder <adam.buchbinder@gmail.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/13145/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/process.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 89847be..ac84ac8 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -582,11 +582,19 @@ int mips_get_process_fp_mode(struct task_struct *task)
 	return value;
 }
 
+static void prepare_for_fp_mode_switch(void *info)
+{
+	struct mm_struct *mm = info;
+
+	if (current->mm == mm)
+		lose_fpu(1);
+}
+
 int mips_set_process_fp_mode(struct task_struct *task, unsigned int value)
 {
 	const unsigned int known_bits = PR_FP_MODE_FR | PR_FP_MODE_FRE;
-	unsigned long switch_count;
 	struct task_struct *t;
+	int max_users;
 
 	/* Check the value is valid */
 	if (value & ~known_bits)
@@ -615,31 +623,17 @@ int mips_set_process_fp_mode(struct task_struct *task, unsigned int value)
 	smp_mb__after_atomic();
 
 	/*
-	 * If there are multiple online CPUs then wait until all threads whose
-	 * FP mode is about to change have been context switched. This approach
-	 * allows us to only worry about whether an FP mode switch is in
-	 * progress when FP is first used in a tasks time slice. Pretty much all
-	 * of the mode switch overhead can thus be confined to cases where mode
-	 * switches are actually occuring. That is, to here. However for the
-	 * thread performing the mode switch it may take a while...
+	 * If there are multiple online CPUs then force any which are running
+	 * threads in this process to lose their FPU context, which they can't
+	 * regain until fp_mode_switching is cleared later.
 	 */
 	if (num_online_cpus() > 1) {
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
+		/* No need to send an IPI for the local CPU */
+		max_users = (task->mm == current->mm) ? 1 : 0;
 
-		spin_unlock_irq(&task->sighand->siglock);
+		if (atomic_read(&current->mm->mm_users) > max_users)
+			smp_call_function(prepare_for_fp_mode_switch,
+					  (void *)current->mm, 1);
 	}
 
 	/*
-- 
2.7.4
