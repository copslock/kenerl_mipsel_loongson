Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Dec 2017 23:52:07 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:56780 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990793AbdLKWv6Xj1ut (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Dec 2017 23:51:58 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 11 Dec 2017 22:51:48 +0000
Received: from [10.20.78.70] (10.20.78.70) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Mon, 11 Dec 2017 14:51:46 -0800
Date:   Mon, 11 Dec 2017 22:51:35 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>
CC:     Paul Burton <Paul.Burton@mips.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Dave Martin <Dave.Martin@arm.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH v2 1/6] MIPS: Factor out NT_PRFPREG regset access helpers
In-Reply-To: <alpine.DEB.2.00.1712111833360.4584@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1712111836260.4584@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1712111833360.4584@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1513032694-321458-30901-13112-2
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187879
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

Cc: stable@vger.kernel.org # v3.15+
Fixes: 72b22bbad1e7 ("MIPS: Don't assume 64-bit FP registers for FP regset")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
---

No changes from v1.

---
 arch/mips/kernel/ptrace.c |  108 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 83 insertions(+), 25 deletions(-)

linux-mips-nt-prfpreg-factor-out.diff
Index: linux-sfr-test/arch/mips/kernel/ptrace.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/ptrace.c	2017-11-23 19:18:08.831530000 +0000
+++ linux-sfr-test/arch/mips/kernel/ptrace.c	2017-11-28 22:44:11.537151000 +0000
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
 
-	if (sizeof(target->thread.fpu.fpr[i]) == sizeof(elf_fpreg_t))
-		return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-					  &target->thread.fpu,
-					  0, sizeof(elf_fpregset_t));
+	return err;
+}
+
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
