Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jan 2018 13:36:51 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:47496 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993588AbeAOMg0Z3yoK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Jan 2018 13:36:26 +0100
Received: from localhost (LFbn-1-12258-90.w90-92.abo.wanadoo.fr [90.92.71.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DA9F211EE;
        Mon, 15 Jan 2018 12:36:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Smith <alex@alex-smith.me.uk>,
        James Hogan <james.hogan@mips.com>,
        "Maciej W. Rozycki" <macro@mips.com>,
        Paul Burton <Paul.Burton@mips.com>,
        Dave Martin <Dave.Martin@arm.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.18 13/46] MIPS: Fix an FCSR access API regression with NT_PRFPREG and MSA
Date:   Mon, 15 Jan 2018 13:33:21 +0100
Message-Id: <20180115123328.844904774@linuxfoundation.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180115123327.303455538@linuxfoundation.org>
References: <20180115123327.303455538@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@mips.com>

commit be07a6a1188372b6d19a3307ec33211fc9c9439d upstream.

Fix a commit 72b22bbad1e7 ("MIPS: Don't assume 64-bit FP registers for
FP regset") public API regression, then activated by commit 1db1af84d6df
("MIPS: Basic MSA context switching support"), that caused the FCSR
register not to be read or written for CONFIG_CPU_HAS_MSA kernel
configurations (regardless of actual presence or absence of the MSA
feature in a given processor) with ptrace(2) PTRACE_GETREGSET and
PTRACE_SETREGSET requests nor recorded in core dumps.

This is because with !CONFIG_CPU_HAS_MSA configurations the whole of
`elf_fpregset_t' array is bulk-copied as it is, which includes the FCSR
in one half of the last, 33rd slot, whereas with CONFIG_CPU_HAS_MSA
configurations array elements are copied individually, and then only the
leading 32 FGR slots while the remaining slot is ignored.

Correct the code then such that only FGR slots are copied in the
respective !MSA and MSA helpers an then the FCSR slot is handled
separately in common code.  Use `ptrace_setfcr31' to update the FCSR
too, so that the read-only mask is respected.

Retrieving a correct value of FCSR is important in debugging not only
for the human to be able to get the right interpretation of the
situation, but for correct operation of GDB as well.  This is because
the condition code bits in FSCR are used by GDB to determine the
location to place a breakpoint at when single-stepping through an FPU
branch instruction.  If such a breakpoint is placed incorrectly (i.e.
with the condition reversed), then it will be missed, likely causing the
debuggee to run away from the control of GDB and consequently breaking
the process of investigation.

Fortunately GDB continues using the older PTRACE_GETFPREGS ptrace(2)
request which is unaffected, so the regression only really hits with
post-mortem debug sessions using a core dump file, in which case
execution, and consequently single-stepping through branches is not
possible.  Of course core files created by buggy kernels out there will
have the value of FCSR recorded clobbered, but such core files cannot be
corrected and the person using them simply will have to be aware that
the value of FCSR retrieved is not reliable.

Which also means we can likely get away without defining a replacement
API which would ensure a correct value of FSCR to be retrieved, or none
at all.

This is based on previous work by Alex Smith, extensively rewritten.

Signed-off-by: Alex Smith <alex@alex-smith.me.uk>
Signed-off-by: James Hogan <james.hogan@mips.com>
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Fixes: 72b22bbad1e7 ("MIPS: Don't assume 64-bit FP registers for FP regset")
Cc: Paul Burton <Paul.Burton@mips.com>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/17928/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/ptrace.c |   47 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 11 deletions(-)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -403,7 +403,7 @@ static int gpr64_set(struct task_struct
 /*
  * Copy the floating-point context to the supplied NT_PRFPREG buffer,
  * !CONFIG_CPU_HAS_MSA variant.  FP context's general register slots
- * correspond 1:1 to buffer slots.
+ * correspond 1:1 to buffer slots.  Only general registers are copied.
  */
 static int fpr_get_fpa(struct task_struct *target,
 		       unsigned int *pos, unsigned int *count,
@@ -411,13 +411,14 @@ static int fpr_get_fpa(struct task_struc
 {
 	return user_regset_copyout(pos, count, kbuf, ubuf,
 				   &target->thread.fpu,
-				   0, sizeof(elf_fpregset_t));
+				   0, NUM_FPU_REGS * sizeof(elf_fpreg_t));
 }
 
 /*
  * Copy the floating-point context to the supplied NT_PRFPREG buffer,
  * CONFIG_CPU_HAS_MSA variant.  Only lower 64 bits of FP context's
- * general register slots are copied to buffer slots.
+ * general register slots are copied to buffer slots.  Only general
+ * registers are copied.
  */
 static int fpr_get_msa(struct task_struct *target,
 		       unsigned int *pos, unsigned int *count,
@@ -439,20 +440,29 @@ static int fpr_get_msa(struct task_struc
 	return 0;
 }
 
-/* Copy the floating-point context to the supplied NT_PRFPREG buffer.  */
+/*
+ * Copy the floating-point context to the supplied NT_PRFPREG buffer.
+ * Choose the appropriate helper for general registers, and then copy
+ * the FCSR register separately.
+ */
 static int fpr_get(struct task_struct *target,
 		   const struct user_regset *regset,
 		   unsigned int pos, unsigned int count,
 		   void *kbuf, void __user *ubuf)
 {
+	const int fcr31_pos = NUM_FPU_REGS * sizeof(elf_fpreg_t);
 	int err;
 
-	/* XXX fcr31  */
-
 	if (sizeof(target->thread.fpu.fpr[0]) == sizeof(elf_fpreg_t))
 		err = fpr_get_fpa(target, &pos, &count, &kbuf, &ubuf);
 	else
 		err = fpr_get_msa(target, &pos, &count, &kbuf, &ubuf);
+	if (err)
+		return err;
+
+	err = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				  &target->thread.fpu.fcr31,
+				  fcr31_pos, fcr31_pos + sizeof(u32));
 
 	return err;
 }
@@ -460,7 +470,7 @@ static int fpr_get(struct task_struct *t
 /*
  * Copy the supplied NT_PRFPREG buffer to the floating-point context,
  * !CONFIG_CPU_HAS_MSA variant.   Buffer slots correspond 1:1 to FP
- * context's general register slots.
+ * context's general register slots.  Only general registers are copied.
  */
 static int fpr_set_fpa(struct task_struct *target,
 		       unsigned int *pos, unsigned int *count,
@@ -468,13 +478,14 @@ static int fpr_set_fpa(struct task_struc
 {
 	return user_regset_copyin(pos, count, kbuf, ubuf,
 				  &target->thread.fpu,
-				  0, sizeof(elf_fpregset_t));
+				  0, NUM_FPU_REGS * sizeof(elf_fpreg_t));
 }
 
 /*
  * Copy the supplied NT_PRFPREG buffer to the floating-point context,
  * CONFIG_CPU_HAS_MSA variant.  Buffer slots are copied to lower 64
- * bits only of FP context's general register slots.
+ * bits only of FP context's general register slots.  Only general
+ * registers are copied.
  */
 static int fpr_set_msa(struct task_struct *target,
 		       unsigned int *pos, unsigned int *count,
@@ -499,6 +510,8 @@ static int fpr_set_msa(struct task_struc
 
 /*
  * Copy the supplied NT_PRFPREG buffer to the floating-point context.
+ * Choose the appropriate helper for general registers, and then copy
+ * the FCSR register separately.
  *
  * We optimize for the case where `count % sizeof(elf_fpreg_t) == 0',
  * which is supposed to have been guaranteed by the kernel before
@@ -511,16 +524,28 @@ static int fpr_set(struct task_struct *t
 		   unsigned int pos, unsigned int count,
 		   const void *kbuf, const void __user *ubuf)
 {
+	const int fcr31_pos = NUM_FPU_REGS * sizeof(elf_fpreg_t);
+	u32 fcr31;
 	int err;
 
 	BUG_ON(count % sizeof(elf_fpreg_t));
 
-	/* XXX fcr31  */
-
 	if (sizeof(target->thread.fpu.fpr[0]) == sizeof(elf_fpreg_t))
 		err = fpr_set_fpa(target, &pos, &count, &kbuf, &ubuf);
 	else
 		err = fpr_set_msa(target, &pos, &count, &kbuf, &ubuf);
+	if (err)
+		return err;
+
+	if (count > 0) {
+		err = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+					 &fcr31,
+					 fcr31_pos, fcr31_pos + sizeof(u32));
+		if (err)
+			return err;
+
+		target->thread.fpu.fcr31 = fcr31 & ~FPU_CSR_ALL_X;
+	}
 
 	return err;
 }
