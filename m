Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 15:45:13 +0200 (CEST)
Received: from mail-we0-f180.google.com ([74.125.82.180]:59865 "EHLO
        mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842512AbaGWNnKfXb5T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 15:43:10 +0200
Received: by mail-we0-f180.google.com with SMTP id w61so1218484wes.39
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 06:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zO5ki1zqvWF8lxWQtaPbnTt2zl+tTMDQeGh8TqqXRho=;
        b=CAl8S1IrLTB6YQl8USHgH/MKQ+EINW3mLlUIhLgH/9JBJW1F0aWZaiWPUbmTbi5hBh
         XVhvOLjVaKS0iB91qkMnGiOWgtW5mu64kS8IdGDbYyrT+l6/9xSAkZOB8c0PjcAaPGoy
         qV7kN9hrQwy58cEbQWRiidH8L6BtFKr/Rcx/wf0R4rfF60iFP32qN8VSbExD/7ZTGRmf
         VLqDi6rHLMFwrs/O64s26ecMze2nVT91tDBJc7RgK66l4eQP5Hi6Sc55Yl9xN2qZoWgV
         cDIDWDnzDavWPxtw8eomd+ZzwXKK5eCV1oGpE6YcVt0pwjrqzlwHe9Y4XOkan+MyyrB3
         CVXQ==
X-Gm-Message-State: ALoCoQkDuftWQupZFX8Odxtz9oq0gYOQJmBUkexwwdsdJJvOFPVburxlKCSBMVJ7bDW6lHRVINDq
X-Received: by 10.180.19.138 with SMTP id f10mr25659872wie.38.1406122985160;
        Wed, 23 Jul 2014 06:43:05 -0700 (PDT)
Received: from localhost.localdomain (host31-50-226-70.range31-50.btcentralplus.com. [31.50.226.70])
        by mx.google.com with ESMTPSA id w10sm9359341wie.22.2014.07.23.06.43.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 06:43:04 -0700 (PDT)
From:   Alex Smith <alex@alex-smith.me.uk>
To:     linux-mips@linux-mips.org
Cc:     Alex Smith <alex@alex-smith.me.uk>, <stable@vger.kernel.org>
Subject: [PATCH 04/11] MIPS: ptrace: Change GP regset to use correct core dump register layout
Date:   Wed, 23 Jul 2014 14:40:09 +0100
Message-Id: <1406122816-2424-5-git-send-email-alex@alex-smith.me.uk>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1406122816-2424-1-git-send-email-alex@alex-smith.me.uk>
References: <1406122816-2424-1-git-send-email-alex@alex-smith.me.uk>
Return-Path: <alex@alex-smith.me.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@alex-smith.me.uk
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

Commit 6a9c001b7ec3 ("MIPS: Switch ELF core dumper to use regsets.")
switched the core dumper to use regsets, however the GP regset code
simply makes a direct copy of the kernel's pt_regs, which does not
match the original core dump register layout as defined in asm/reg.h.
Furthermore, the definition of pt_regs can vary with certain Kconfig
variables, therefore the GP regset can never be relied upon to return
registers in the same layout.

Therefore, this patch changes the GP regset to match the original core
dump layout. The layout differs for 32- and 64-bit processes, so
separate implementations of the get/set functions are added for the
32- and 64-bit regsets.

Signed-off-by: Alex Smith <alex@alex-smith.me.uk>
Cc: <stable@vger.kernel.org> # v3.13+
---
 arch/mips/kernel/ptrace.c | 189 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 160 insertions(+), 29 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 8f2130a..8bd13ed 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -246,36 +246,160 @@ int ptrace_set_watch_regs(struct task_struct *child,
 
 /* regset get/set implementations */
 
-static int gpr_get(struct task_struct *target,
-		   const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
+#if defined(CONFIG_32BIT) || defined(CONFIG_MIPS32_O32)
+
+static int gpr32_get(struct task_struct *target,
+		     const struct user_regset *regset,
+		     unsigned int pos, unsigned int count,
+		     void *kbuf, void __user *ubuf)
 {
 	struct pt_regs *regs = task_pt_regs(target);
+	u32 uregs[ELF_NGREG] = {};
+	unsigned i;
+
+	for (i = MIPS32_EF_R1; i <= MIPS32_EF_R31; i++) {
+		/* k0/k1 are copied as zero. */
+		if (i == MIPS32_EF_R26 || i == MIPS32_EF_R27)
+			continue;
+
+		uregs[i] = regs->regs[i - MIPS32_EF_R0];
+	}
 
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   regs, 0, sizeof(*regs));
+	uregs[MIPS32_EF_LO] = regs->lo;
+	uregs[MIPS32_EF_HI] = regs->hi;
+	uregs[MIPS32_EF_CP0_EPC] = regs->cp0_epc;
+	uregs[MIPS32_EF_CP0_BADVADDR] = regs->cp0_badvaddr;
+	uregs[MIPS32_EF_CP0_STATUS] = regs->cp0_status;
+	uregs[MIPS32_EF_CP0_CAUSE] = regs->cp0_cause;
+
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, uregs, 0,
+				   sizeof(uregs));
 }
 
-static int gpr_set(struct task_struct *target,
-		   const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   const void *kbuf, const void __user *ubuf)
+static int gpr32_set(struct task_struct *target,
+		     const struct user_regset *regset,
+		     unsigned int pos, unsigned int count,
+		     const void *kbuf, const void __user *ubuf)
 {
-	struct pt_regs newregs;
-	int ret;
+	struct pt_regs *regs = task_pt_regs(target);
+	u32 uregs[ELF_NGREG];
+	unsigned start, num_regs, i;
+	int err;
+
+	start = pos / sizeof(u32);
+	num_regs = count / sizeof(u32);
+
+	if (start + num_regs > ELF_NGREG)
+		return -EIO;
+
+	err = user_regset_copyin(&pos, &count, &kbuf, &ubuf, uregs, 0,
+				 sizeof(uregs));
+	if (err)
+		return err;
+
+	for (i = start; i < num_regs; i++) {
+		/*
+		 * Cast all values to signed here so that if this is a 64-bit
+		 * kernel, the supplied 32-bit values will be sign extended.
+		 */
+		switch (i) {
+		case MIPS32_EF_R1 ... MIPS32_EF_R25:
+			/* k0/k1 are ignored. */
+		case MIPS32_EF_R28 ... MIPS32_EF_R31:
+			regs->regs[i - MIPS32_EF_R0] = (s32)uregs[i];
+			break;
+		case MIPS32_EF_LO:
+			regs->lo = (s32)uregs[i];
+			break;
+		case MIPS32_EF_HI:
+			regs->hi = (s32)uregs[i];
+			break;
+		case MIPS32_EF_CP0_EPC:
+			regs->cp0_epc = (s32)uregs[i];
+			break;
+		}
+	}
+
+	return 0;
+}
+
+#endif /* CONFIG_32BIT || CONFIG_MIPS32_O32 */
+
+#ifdef CONFIG_64BIT
+
+static int gpr64_get(struct task_struct *target,
+		     const struct user_regset *regset,
+		     unsigned int pos, unsigned int count,
+		     void *kbuf, void __user *ubuf)
+{
+	struct pt_regs *regs = task_pt_regs(target);
+	u64 uregs[ELF_NGREG] = {};
+	unsigned i;
+
+	for (i = MIPS64_EF_R1; i <= MIPS64_EF_R31; i++) {
+		/* k0/k1 are copied as zero. */
+		if (i == MIPS64_EF_R26 || i == MIPS64_EF_R27)
+			continue;
+
+		uregs[i] = regs->regs[i - MIPS64_EF_R0];
+	}
+
+	uregs[MIPS64_EF_LO] = regs->lo;
+	uregs[MIPS64_EF_HI] = regs->hi;
+	uregs[MIPS64_EF_CP0_EPC] = regs->cp0_epc;
+	uregs[MIPS64_EF_CP0_BADVADDR] = regs->cp0_badvaddr;
+	uregs[MIPS64_EF_CP0_STATUS] = regs->cp0_status;
+	uregs[MIPS64_EF_CP0_CAUSE] = regs->cp0_cause;
+
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, uregs, 0,
+				   sizeof(uregs));
+}
 
-	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				 &newregs,
-				 0, sizeof(newregs));
-	if (ret)
-		return ret;
+static int gpr64_set(struct task_struct *target,
+		     const struct user_regset *regset,
+		     unsigned int pos, unsigned int count,
+		     const void *kbuf, const void __user *ubuf)
+{
+	struct pt_regs *regs = task_pt_regs(target);
+	u64 uregs[ELF_NGREG];
+	unsigned start, num_regs, i;
+	int err;
+
+	start = pos / sizeof(u64);
+	num_regs = count / sizeof(u64);
 
-	*task_pt_regs(target) = newregs;
+	if (start + num_regs > ELF_NGREG)
+		return -EIO;
+
+	err = user_regset_copyin(&pos, &count, &kbuf, &ubuf, uregs, 0,
+				 sizeof(uregs));
+	if (err)
+		return err;
+
+	for (i = start; i < num_regs; i++) {
+		switch (i) {
+		case MIPS64_EF_R1 ... MIPS64_EF_R25:
+			/* k0/k1 are ignored. */
+		case MIPS64_EF_R28 ... MIPS64_EF_R31:
+			regs->regs[i - MIPS64_EF_R0] = uregs[i];
+			break;
+		case MIPS64_EF_LO:
+			regs->lo = uregs[i];
+			break;
+		case MIPS64_EF_HI:
+			regs->hi = uregs[i];
+			break;
+		case MIPS64_EF_CP0_EPC:
+			regs->cp0_epc = uregs[i];
+			break;
+		}
+	}
 
 	return 0;
 }
 
+#endif /* CONFIG_64BIT */
+
 static int fpr_get(struct task_struct *target,
 		   const struct user_regset *regset,
 		   unsigned int pos, unsigned int count,
@@ -337,14 +461,16 @@ enum mips_regset {
 	REGSET_FPR,
 };
 
+#if defined(CONFIG_32BIT) || defined(CONFIG_MIPS32_O32)
+
 static const struct user_regset mips_regsets[] = {
 	[REGSET_GPR] = {
 		.core_note_type	= NT_PRSTATUS,
 		.n		= ELF_NGREG,
 		.size		= sizeof(unsigned int),
 		.align		= sizeof(unsigned int),
-		.get		= gpr_get,
-		.set		= gpr_set,
+		.get		= gpr32_get,
+		.set		= gpr32_set,
 	},
 	[REGSET_FPR] = {
 		.core_note_type	= NT_PRFPREG,
@@ -364,14 +490,18 @@ static const struct user_regset_view user_mips_view = {
 	.n		= ARRAY_SIZE(mips_regsets),
 };
 
+#endif /* CONFIG_32BIT || CONFIG_MIPS32_O32 */
+
+#ifdef CONFIG_64BIT
+
 static const struct user_regset mips64_regsets[] = {
 	[REGSET_GPR] = {
 		.core_note_type	= NT_PRSTATUS,
 		.n		= ELF_NGREG,
 		.size		= sizeof(unsigned long),
 		.align		= sizeof(unsigned long),
-		.get		= gpr_get,
-		.set		= gpr_set,
+		.get		= gpr64_get,
+		.set		= gpr64_set,
 	},
 	[REGSET_FPR] = {
 		.core_note_type	= NT_PRFPREG,
@@ -384,25 +514,26 @@ static const struct user_regset mips64_regsets[] = {
 };
 
 static const struct user_regset_view user_mips64_view = {
-	.name		= "mips",
+	.name		= "mips64",
 	.e_machine	= ELF_ARCH,
 	.ei_osabi	= ELF_OSABI,
 	.regsets	= mips64_regsets,
-	.n		= ARRAY_SIZE(mips_regsets),
+	.n		= ARRAY_SIZE(mips64_regsets),
 };
 
+#endif /* CONFIG_64BIT */
+
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 {
 #ifdef CONFIG_32BIT
 	return &user_mips_view;
-#endif
-
+#else
 #ifdef CONFIG_MIPS32_O32
-		if (test_tsk_thread_flag(task, TIF_32BIT_REGS))
-			return &user_mips_view;
+	if (test_tsk_thread_flag(task, TIF_32BIT_REGS))
+		return &user_mips_view;
 #endif
-
 	return &user_mips64_view;
+#endif
 }
 
 long arch_ptrace(struct task_struct *child, long request,
-- 
1.9.1
