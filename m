Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2018 17:17:55 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53801 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992678AbeB1QRpAX47z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Feb 2018 17:17:45 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1er3Ys-0006XT-HP; Wed, 28 Feb 2018 15:22:30 +0000
Received: from ben by deadeye with local (Exim 4.90_1)
        (envelope-from <ben@decadent.org.uk>)
        id 1er3Yg-00005S-Gj; Wed, 28 Feb 2018 15:22:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Dave Martin" <Dave.Martin@arm.com>,
        "Paul Burton" <Paul.Burton@mips.com>,
        "Alex Smith" <alex@alex-smith.me.uk>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@mips.com>,
        "James Hogan" <james.hogan@mips.com>, linux-mips@linux-mips.org
Date:   Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.658464417@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 107/254] MIPS: Factor out NT_PRFPREG regset access
 helpers
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej W. Rozycki" <macro@mips.com>

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/ptrace.c | 108 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 83 insertions(+), 25 deletions(-)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -438,25 +438,36 @@ static int gpr64_set(struct task_struct
 
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
@@ -466,27 +477,54 @@ static int fpr_get(struct task_struct *t
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
@@ -497,6 +535,26 @@ static int fpr_set(struct task_struct *t
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
