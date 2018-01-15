Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jan 2018 13:48:12 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:52552 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994039AbeAOMsD4sgdK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Jan 2018 13:48:03 +0100
Received: from localhost (LFbn-1-12258-90.w90-92.abo.wanadoo.fr [90.92.71.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 59BC111ED;
        Mon, 15 Jan 2018 12:47:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@mips.com>,
        James Hogan <james.hogan@mips.com>,
        Paul Burton <Paul.Burton@mips.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Dave Martin <Dave.Martin@arm.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.14 008/118] MIPS: Factor out NT_PRFPREG regset access helpers
Date:   Mon, 15 Jan 2018 13:33:55 +0100
Message-Id: <20180115123415.795011983@linuxfoundation.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180115123415.325497625@linuxfoundation.org>
References: <20180115123415.325497625@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62130
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@mips.com>

commit a03fe72572c12e98f4173f8a535f32468e48b6ec upstream.

In preparation to fix a commit 72b22bbad1e7 ("MIPS: Don't assume 64-bit
FP registers for FP regset") FCSR access regression factor out
NT_PRFPREG regset access helpers for the non-MSA and the MSA variants
respectively, to avoid having to deal with excessive indentation in the
actual fix.

No functional change, however use `target->thread.fpu.fpr[0]' rather
than `target->thread.fpu.fpr[i]' for FGR holding type size determination
as there's no `i' variable to refer to anymore, and for the factored out
`i' variable declaration use `unsigned int' rather than `unsigned' as
its type, following the common style.

Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Fixes: 72b22bbad1e7 ("MIPS: Don't assume 64-bit FP registers for FP regset")
Cc: James Hogan <james.hogan@mips.com>
Cc: Paul Burton <Paul.Burton@mips.com>
Cc: Alex Smith <alex@alex-smith.me.uk>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/17925/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/ptrace.c |  108 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 83 insertions(+), 25 deletions(-)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -410,25 +410,36 @@ static int gpr64_set(struct task_struct
 
 #endif /* CONFIG_64BIT */
 
-static int fpr_get(struct task_struct *target,
-		   const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
+/*
+ * Copy the floating-point context to the supplied NT_PRFPREG buffer,
+ * !CONFIG_CPU_HAS_MSA variant.  FP context's general register slots
+ * correspond 1:1 to buffer slots.
+ */
+static int fpr_get_fpa(struct task_struct *target,
+		       unsigned int *pos, unsigned int *count,
+		       void **kbuf, void __user **ubuf)
 {
-	unsigned i;
-	int err;
-	u64 fpr_val;
-
-	/* XXX fcr31  */
+	return user_regset_copyout(pos, count, kbuf, ubuf,
+				   &target->thread.fpu,
+				   0, sizeof(elf_fpregset_t));
+}
 
-	if (sizeof(target->thread.fpu.fpr[i]) == sizeof(elf_fpreg_t))
-		return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					   &target->thread.fpu,
-					   0, sizeof(elf_fpregset_t));
+/*
+ * Copy the floating-point context to the supplied NT_PRFPREG buffer,
+ * CONFIG_CPU_HAS_MSA variant.  Only lower 64 bits of FP context's
+ * general register slots are copied to buffer slots.
+ */
+static int fpr_get_msa(struct task_struct *target,
+		       unsigned int *pos, unsigned int *count,
+		       void **kbuf, void __user **ubuf)
+{
+	unsigned int i;
+	u64 fpr_val;
+	int err;
 
 	for (i = 0; i < NUM_FPU_REGS; i++) {
 		fpr_val = get_fpr64(&target->thread.fpu.fpr[i], 0);
-		err = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+		err = user_regset_copyout(pos, count, kbuf, ubuf,
 					  &fpr_val, i * sizeof(elf_fpreg_t),
 					  (i + 1) * sizeof(elf_fpreg_t));
 		if (err)
@@ -438,27 +449,54 @@ static int fpr_get(struct task_struct *t
 	return 0;
 }
 
-static int fpr_set(struct task_struct *target,
+/* Copy the floating-point context to the supplied NT_PRFPREG buffer.  */
+static int fpr_get(struct task_struct *target,
 		   const struct user_regset *regset,
 		   unsigned int pos, unsigned int count,
-		   const void *kbuf, const void __user *ubuf)
+		   void *kbuf, void __user *ubuf)
 {
-	unsigned i;
 	int err;
-	u64 fpr_val;
 
 	/* XXX fcr31  */
 
-	init_fp_ctx(target);
+	if (sizeof(target->thread.fpu.fpr[0]) == sizeof(elf_fpreg_t))
+		err = fpr_get_fpa(target, &pos, &count, &kbuf, &ubuf);
+	else
+		err = fpr_get_msa(target, &pos, &count, &kbuf, &ubuf);
+
+	return err;
+}
 
-	if (sizeof(target->thread.fpu.fpr[i]) == sizeof(elf_fpreg_t))
-		return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-					  &target->thread.fpu,
-					  0, sizeof(elf_fpregset_t));
+/*
+ * Copy the supplied NT_PRFPREG buffer to the floating-point context,
+ * !CONFIG_CPU_HAS_MSA variant.   Buffer slots correspond 1:1 to FP
+ * context's general register slots.
+ */
+static int fpr_set_fpa(struct task_struct *target,
+		       unsigned int *pos, unsigned int *count,
+		       const void **kbuf, const void __user **ubuf)
+{
+	return user_regset_copyin(pos, count, kbuf, ubuf,
+				  &target->thread.fpu,
+				  0, sizeof(elf_fpregset_t));
+}
+
+/*
+ * Copy the supplied NT_PRFPREG buffer to the floating-point context,
+ * CONFIG_CPU_HAS_MSA variant.  Buffer slots are copied to lower 64
+ * bits only of FP context's general register slots.
+ */
+static int fpr_set_msa(struct task_struct *target,
+		       unsigned int *pos, unsigned int *count,
+		       const void **kbuf, const void __user **ubuf)
+{
+	unsigned int i;
+	u64 fpr_val;
+	int err;
 
 	BUILD_BUG_ON(sizeof(fpr_val) != sizeof(elf_fpreg_t));
-	for (i = 0; i < NUM_FPU_REGS && count >= sizeof(elf_fpreg_t); i++) {
-		err = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+	for (i = 0; i < NUM_FPU_REGS && *count >= sizeof(elf_fpreg_t); i++) {
+		err = user_regset_copyin(pos, count, kbuf, ubuf,
 					 &fpr_val, i * sizeof(elf_fpreg_t),
 					 (i + 1) * sizeof(elf_fpreg_t));
 		if (err)
@@ -469,6 +507,26 @@ static int fpr_set(struct task_struct *t
 	return 0;
 }
 
+/* Copy the supplied NT_PRFPREG buffer to the floating-point context.  */
+static int fpr_set(struct task_struct *target,
+		   const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   const void *kbuf, const void __user *ubuf)
+{
+	int err;
+
+	/* XXX fcr31  */
+
+	init_fp_ctx(target);
+
+	if (sizeof(target->thread.fpu.fpr[0]) == sizeof(elf_fpreg_t))
+		err = fpr_set_fpa(target, &pos, &count, &kbuf, &ubuf);
+	else
+		err = fpr_set_msa(target, &pos, &count, &kbuf, &ubuf);
+
+	return err;
+}
+
 enum mips_regset {
 	REGSET_GPR,
 	REGSET_FPR,
