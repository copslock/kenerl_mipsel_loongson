Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 15:45:34 +0200 (CEST)
Received: from mail-we0-f170.google.com ([74.125.82.170]:40561 "EHLO
        mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842513AbaGWNnRfXuLm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 15:43:17 +0200
Received: by mail-we0-f170.google.com with SMTP id w62so1185917wes.29
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 06:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bWn7/ZvmHWOKyO7rKaJPwmL+WBROFiNpzzB3xWe9Zv8=;
        b=djkkACwlvxxT7z4ZdY3kywDoUwEDVN6IX2Gu1t5Avw5x7ZzLWu2HD/5zNNAYX1bI0H
         ESR0WvPVvnwVG5yuZ3g4qQj3HlE5GsKBkN2LhZ+tOeWf9XnN9FN4I4ZLBqBtndsdaiAf
         m3vyzmlDME3GhKEy8jLvBrtmiCWCoXHQ1KcXGh5vdZT2/UwwD7mFwm78A4vFf3IhHB8D
         7odE3ED/XB0hKkUyVonDFjcmeNG564WeM2of0ovxyqG4UssR4hNFgIMBFXpWgmSgYKCQ
         2GWnKIbWGiWnzYURjr0yWOHrvZ437FKsvMnraivW6fpqS2tIvBlBYf9o4Z2+MgT2hzKO
         8iJg==
X-Gm-Message-State: ALoCoQlE3O8BuJiqbWMRjKX+f+ze2HQ3QFludapPEwm44nYrcO0hohyNkKa5PKXyrYKhivQlHj46
X-Received: by 10.180.12.38 with SMTP id v6mr3297099wib.31.1406122990344;
        Wed, 23 Jul 2014 06:43:10 -0700 (PDT)
Received: from localhost.localdomain (host31-50-226-70.range31-50.btcentralplus.com. [31.50.226.70])
        by mx.google.com with ESMTPSA id w10sm9359341wie.22.2014.07.23.06.43.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 06:43:09 -0700 (PDT)
From:   Alex Smith <alex@alex-smith.me.uk>
To:     linux-mips@linux-mips.org
Cc:     Alex Smith <alex@alex-smith.me.uk>,
        Paul Burton <paul.burton@imgtec.com>, <stable@vger.kernel.org>
Subject: [PATCH 05/11] MIPS: ptrace: Always copy FCSR in FP regset
Date:   Wed, 23 Jul 2014 14:40:10 +0100
Message-Id: <1406122816-2424-6-git-send-email-alex@alex-smith.me.uk>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1406122816-2424-1-git-send-email-alex@alex-smith.me.uk>
References: <1406122816-2424-1-git-send-email-alex@alex-smith.me.uk>
Return-Path: <alex@alex-smith.me.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41521
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

Copy FCSR in the FP regset to match the original pre-regset core dumper.
The code paths for where sizeof(union fpureg) == sizeof(elf_fpreg_t)
already do so, but they actually copy 4 bytes more than they should do
as FCSR is only 32 bits. The not equal code paths do not copy it at all.
Therefore change the copy to be done explicitly (with the correct size)
for both paths.

Additionally, clear the cause bits from FCSR when setting the FP regset
to avoid the possibility of causing an FP exception (and an oops) in the
kernel.

Signed-off-by: Alex Smith <alex@alex-smith.me.uk>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: <stable@vger.kernel.org> # v3.13+
---
This patch incorporates a fix for another instance of the bug fixed by
Paul Burton's patch "MIPS: prevent user from setting FCSR cause bits" -
the code path in fpr_set for sizeof(fpureg) == sizeof(elf_fpreg_t)
copied fcr31 without clearing cause bits. I've incorporated a fix for
it into this patch to so that it's easier to apply both patches without
conflicts.
---
 arch/mips/kernel/ptrace.c | 61 +++++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 8bd13ed..ffc2e37 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -409,23 +409,28 @@ static int fpr_get(struct task_struct *target,
 	int err;
 	u64 fpr_val;
 
-	/* XXX fcr31  */
-
-	if (sizeof(target->thread.fpu.fpr[i]) == sizeof(elf_fpreg_t))
-		return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					   &target->thread.fpu,
-					   0, sizeof(elf_fpregset_t));
-
-	for (i = 0; i < NUM_FPU_REGS; i++) {
-		fpr_val = get_fpr64(&target->thread.fpu.fpr[i], 0);
+	if (sizeof(target->thread.fpu.fpr[i]) == sizeof(elf_fpreg_t)) {
 		err = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  &fpr_val, i * sizeof(elf_fpreg_t),
-					  (i + 1) * sizeof(elf_fpreg_t));
+					  &target->thread.fpu.fpr,
+					  0, NUM_FPU_REGS * sizeof(elf_fpreg_t));
 		if (err)
 			return err;
+	} else {
+		for (i = 0; i < NUM_FPU_REGS; i++) {
+			fpr_val = get_fpr64(&target->thread.fpu.fpr[i], 0);
+			err = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+						  &fpr_val,
+						  i * sizeof(elf_fpreg_t),
+						  (i + 1) * sizeof(elf_fpreg_t));
+			if (err)
+				return err;
+		}
 	}
 
-	return 0;
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+			    &target->thread.fpu.fcr31,
+			    NUM_FPU_REGS * sizeof(elf_fpreg_t),
+			    (NUM_FPU_REGS * sizeof(elf_fpreg_t)) + sizeof(u32));
 }
 
 static int fpr_set(struct task_struct *target,
@@ -436,23 +441,33 @@ static int fpr_set(struct task_struct *target,
 	unsigned i;
 	int err;
 	u64 fpr_val;
+	u32 fcr31;
 
-	/* XXX fcr31  */
-
-	if (sizeof(target->thread.fpu.fpr[i]) == sizeof(elf_fpreg_t))
-		return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-					  &target->thread.fpu,
-					  0, sizeof(elf_fpregset_t));
-
-	for (i = 0; i < NUM_FPU_REGS; i++) {
+	if (sizeof(target->thread.fpu.fpr[i]) == sizeof(elf_fpreg_t)) {
 		err = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-					 &fpr_val, i * sizeof(elf_fpreg_t),
-					 (i + 1) * sizeof(elf_fpreg_t));
+					 &target->thread.fpu.fpr,
+					 0, NUM_FPU_REGS * sizeof(elf_fpreg_t));
 		if (err)
 			return err;
-		set_fpr64(&target->thread.fpu.fpr[i], 0, fpr_val);
+	} else {
+		for (i = 0; i < NUM_FPU_REGS; i++) {
+			err = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+						 &fpr_val,
+						 i * sizeof(elf_fpreg_t),
+						 (i + 1) * sizeof(elf_fpreg_t));
+			if (err)
+				return err;
+			set_fpr64(&target->thread.fpu.fpr[i], 0, fpr_val);
+		}
 	}
 
+	err = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &fcr31,
+			    NUM_FPU_REGS * sizeof(elf_fpreg_t),
+			    (NUM_FPU_REGS * sizeof(elf_fpreg_t)) + sizeof(u32));
+	if (err)
+		return err;
+
+	target->thread.fpu.fcr31 = fcr31 & ~FPU_CSR_ALL_X;
 	return 0;
 }
 
-- 
1.9.1
