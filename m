Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jul 2014 14:53:14 +0200 (CEST)
Received: from mail-we0-f182.google.com ([74.125.82.182]:41627 "EHLO
        mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816615AbaGXMxGDCNTP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Jul 2014 14:53:06 +0200
Received: by mail-we0-f182.google.com with SMTP id k48so2711623wev.41
        for <linux-mips@linux-mips.org>; Thu, 24 Jul 2014 05:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=skdQs2PiyZnDPROl+ym3EYTuhBNmmWSCHyrRVZ+NkKs=;
        b=cThK3xqX1je9dQw9zVlMupQH4mE7xOa4WU2mlgG9QNJq9Ud/nddPd+cquiPiO8jq8f
         XQstAZldAlG2ZjNkoG68MlkZBa3ZLvc8OaSQM2wkqCCU8bkr0PChc12597R9W9JOoYBi
         WIzG9/HRLSVrBgCF16q1sqvkZOrHOjCi3HpyLcTgMAwDgGrNz44JJ2xzNTi+UduUPXuF
         G+mj6dTLNHtyn9VzBoKUfqNf7ZWcdD3km88UoKIPxHgphGSpCRgku+67JnejXnMelyNB
         VbM52jiAWPD5F27yx3REnFkLhQBof4c6swzKTzgrGFAOpXwBpOE4nMrFaTPfv5+eK3F8
         0/XQ==
X-Gm-Message-State: ALoCoQmtGpoOaPjNW2upiM2CZqiZXD0XRKeKykQNt8Sy2AymvoCHJyi1cxarxI4Ugg6Jm0RMtukX
X-Received: by 10.194.89.168 with SMTP id bp8mr11970080wjb.73.1406206380444;
        Thu, 24 Jul 2014 05:53:00 -0700 (PDT)
Received: from localhost.localdomain (host86-138-160-164.range86-138.btcentralplus.com. [86.138.160.164])
        by mx.google.com with ESMTPSA id sa4sm15651787wjb.45.2014.07.24.05.52.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jul 2014 05:52:59 -0700 (PDT)
From:   Alex Smith <alex@alex-smith.me.uk>
To:     linux-mips@linux-mips.org
Cc:     Alex Smith <alex@alex-smith.me.uk>,
        Paul Burton <paul.burton@imgtec.com>, <stable@vger.kernel.org>
Subject: [PATCH v2 05/11] MIPS: ptrace: Always copy FCSR in FP regset
Date:   Thu, 24 Jul 2014 13:50:38 +0100
Message-Id: <1406206238-28512-1-git-send-email-alex@alex-smith.me.uk>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1406122816-2424-6-git-send-email-alex@alex-smith.me.uk>
References: <1406122816-2424-6-git-send-email-alex@alex-smith.me.uk>
Return-Path: <alex@alex-smith.me.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41564
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
Changes in v2:
 - Zero fill the last 4 bytes in the FP regset.
---
 arch/mips/kernel/ptrace.c | 73 +++++++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 24 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 8bd13ed..e082079 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -409,23 +409,35 @@ static int fpr_get(struct task_struct *target,
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
+	err = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+			   &target->thread.fpu.fcr31,
+			   NUM_FPU_REGS * sizeof(elf_fpreg_t),
+			   (NUM_FPU_REGS * sizeof(elf_fpreg_t)) + sizeof(u32));
+	if (err)
+		return err;
+
+	/* Zero fill the remaining 4 bytes. */
+	return user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
+			    (NUM_FPU_REGS * sizeof(elf_fpreg_t)) + sizeof(u32),
+			    sizeof(elf_fpregset_t));
 }
 
 static int fpr_set(struct task_struct *target,
@@ -436,24 +448,37 @@ static int fpr_set(struct task_struct *target,
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
 
-	return 0;
+	err = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &fcr31,
+			    NUM_FPU_REGS * sizeof(elf_fpreg_t),
+			    (NUM_FPU_REGS * sizeof(elf_fpreg_t)) + sizeof(u32));
+	if (err)
+		return err;
+
+	target->thread.fpu.fcr31 = fcr31 & ~FPU_CSR_ALL_X;
+
+	return user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
+			    (NUM_FPU_REGS * sizeof(elf_fpreg_t)) + sizeof(u32),
+			    sizeof(elf_fpregset_t));
 }
 
 enum mips_regset {
-- 
1.9.1
