From: Paul Burton <paul.burton@imgtec.com>
Date: Thu, 21 Apr 2016 12:43:57 +0100
Subject: MIPS: Disable preemption during prctl(PR_SET_FP_MODE, ...)
Message-ID: <20160421114357.ZenWleHjzKnhu0m5u9Qx8UyL_qgLOvTbkSbjYpWbYFY@z>

commit bd239f1e1429e7781096bf3884bdb1b2b1bb4f28 upstream.

Whilst a PR_SET_FP_MODE prctl is performed there are decisions made
based upon whether the task is executing on the current CPU. This may
change if we're preempted, so disable preemption to avoid such changes
for the lifetime of the mode switch.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 9791554b45a2 ("MIPS,prctl: add PR_[GS]ET_FP_MODE prctl options for MIPS")
Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>
Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Cc: Adam Buchbinder <adam.buchbinder@gmail.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/13144/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/process.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 6b3ae73..89847be 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -603,6 +603,9 @@ int mips_set_process_fp_mode(struct task_struct *task, unsigned int value)
 	if (!(value & PR_FP_MODE_FR) && cpu_has_fpu && cpu_has_mips_r6)
 		return -EOPNOTSUPP;

+	/* Proceed with the mode switch */
+	preempt_disable();
+
 	/* Save FP & vector context, then disable FPU & MSA */
 	if (task->signal == current->signal)
 		lose_fpu(1);
@@ -661,6 +664,7 @@ int mips_set_process_fp_mode(struct task_struct *task, unsigned int value)

 	/* Allow threads to use FP again */
 	atomic_set(&task->mm->context.fp_mode_switching, 0);
+	preempt_enable();

 	return 0;
 }
--
2.7.4
