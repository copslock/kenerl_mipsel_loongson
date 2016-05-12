From: "Maciej W. Rozycki" <macro@imgtec.com>
Date: Thu, 12 May 2016 10:19:08 +0100
Subject: MIPS: ptrace: Prevent writes to read-only FCSR bits
Message-ID: <20160512091908.lEZUpSeqYJ9V4LxyqOOCGuVU2QWZ3PMvz2P48PSQ4PM@z>

commit abf378be49f38c4d3e23581d3df3fa9f1b1b11d2 upstream.

Correct the cases missed with commit 9b26616c8d9d ("MIPS: Respect the
ISA level in FCSR handling") and prevent writes to read-only FCSR bits
there.

This in particular applies to FP context initialisation where any IEEE
754-2008 bits preset by `mips_set_personality_nan' are cleared before
the relevant ptrace(2) call takes effect and the PTRACE_POKEUSR request
addressing FPC_CSR where no masking of read-only FCSR bits is done.

Remove the FCSR clearing from FP context initialisation then and unify
PTRACE_POKEUSR/FPC_CSR and PTRACE_SETFPREGS handling, by factoring out
code from `ptrace_setfpregs' and calling it from both places.

This mostly matters to soft float configurations where the emulator can
be switched this way to a mode which should not be accessible and cannot
be set with the CTC1 instruction.  With hard float configurations any
effect is transient anyway as read-only bits will retain their values at
the time the FP context is restored.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13239/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/ptrace.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index d56642a..f7968b5 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -56,8 +56,7 @@ static void init_fp_ctx(struct task_struct *target)
 	/* Begin with data registers set to all 1s... */
 	memset(&target->thread.fpu.fpr, ~0, sizeof(target->thread.fpu.fpr));

-	/* ...and FCSR zeroed */
-	target->thread.fpu.fcr31 = 0;
+	/* FCSR has been preset by `mips_set_personality_nan'.  */

 	/*
 	 * Record that the target has "used" math, such that the context
@@ -79,6 +78,22 @@ void ptrace_disable(struct task_struct *child)
 }

 /*
+ * Poke at FCSR according to its mask.  Don't set the cause bits as
+ * this is currently not handled correctly in FP context restoration
+ * and will cause an oops if a corresponding enable bit is set.
+ */
+static void ptrace_setfcr31(struct task_struct *child, u32 value)
+{
+	u32 fcr31;
+	u32 mask;
+
+	value &= ~FPU_CSR_ALL_X;
+	fcr31 = child->thread.fpu.fcr31;
+	mask = boot_cpu_data.fpu_msk31;
+	child->thread.fpu.fcr31 = (value & ~mask) | (fcr31 & mask);
+}
+
+/*
  * Read a general register set.	 We always use the 64-bit format, even
  * for 32-bit kernels and for 32-bit processes on a 64-bit kernel.
  * Registers are sign extended to fill the available space.
@@ -158,9 +173,7 @@ int ptrace_setfpregs(struct task_struct *child, __u32 __user *data)
 {
 	union fpureg *fregs;
 	u64 fpr_val;
-	u32 fcr31;
 	u32 value;
-	u32 mask;
 	int i;

 	if (!access_ok(VERIFY_READ, data, 33 * 8))
@@ -175,10 +188,7 @@ int ptrace_setfpregs(struct task_struct *child, __u32 __user *data)
 	}

 	__get_user(value, data + 64);
-	value &= ~FPU_CSR_ALL_X;
-	fcr31 = child->thread.fpu.fcr31;
-	mask = boot_cpu_data.fpu_msk31;
-	child->thread.fpu.fcr31 = (value & ~mask) | (fcr31 & mask);
+	ptrace_setfcr31(child, value);

 	/* FIR may not be written.  */

@@ -721,7 +731,7 @@ long arch_ptrace(struct task_struct *child, long request,
 			break;
 #endif
 		case FPC_CSR:
-			child->thread.fpu.fcr31 = data & ~FPU_CSR_ALL_X;
+			ptrace_setfcr31(child, data);
 			break;
 		case DSP_BASE ... DSP_BASE + 5: {
 			dspreg_t *dregs;
--
2.7.4
