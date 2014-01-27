Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 16:28:06 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:4441 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823977AbaA0P1RAAE4B (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 16:27:17 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 08/15] mips: don't assume 64-bit FP registers for FP regset
Date:   Mon, 27 Jan 2014 15:23:07 +0000
Message-ID: <1390836194-26286-9-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1390836194-26286-1-git-send-email-paul.burton@imgtec.com>
References: <1390836194-26286-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_27_15_27_10
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

When we want to access 64-bit FP register values we can only treat
consecutive registers as being consecutive in memory when the width of
an FP register equals 64 bits. This assumption will not remain true once
MSA support is introduced, so provide a code path which copies each 64
bit FP register value in turn when the width of an FP register differs
from 64 bits.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/kernel/ptrace.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 624773e..7bff8d3 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -304,10 +304,27 @@ static int fpr_get(struct task_struct *target,
 		   unsigned int pos, unsigned int count,
 		   void *kbuf, void __user *ubuf)
 {
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   &target->thread.fpu,
-				   0, sizeof(elf_fpregset_t));
+	unsigned i;
+	int err;
+	u64 fpr_val;
+
 	/* XXX fcr31  */
+
+	if (sizeof(target->thread.fpu.fpr[i]) == sizeof(elf_fpreg_t))
+		return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+					   &target->thread.fpu,
+					   0, sizeof(elf_fpregset_t));
+
+	for (i = 0; i < NUM_FPU_REGS; i++) {
+		fpr_val = get_fpr64(&target->thread.fpu.fpr[i], 0);
+		err = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+					  &fpr_val, i * sizeof(elf_fpreg_t),
+					  (i + 1) * sizeof(elf_fpreg_t));
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
 
 static int fpr_set(struct task_struct *target,
@@ -315,10 +332,27 @@ static int fpr_set(struct task_struct *target,
 		   unsigned int pos, unsigned int count,
 		   const void *kbuf, const void __user *ubuf)
 {
-	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				  &target->thread.fpu,
-				  0, sizeof(elf_fpregset_t));
+	unsigned i;
+	int err;
+	u64 fpr_val;
+
 	/* XXX fcr31  */
+
+	if (sizeof(target->thread.fpu.fpr[i]) == sizeof(elf_fpreg_t))
+		return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+					  &target->thread.fpu,
+					  0, sizeof(elf_fpregset_t));
+
+	for (i = 0; i < NUM_FPU_REGS; i++) {
+		err = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+					 &fpr_val, i * sizeof(elf_fpreg_t),
+					 (i + 1) * sizeof(elf_fpreg_t));
+		if (err)
+			return err;
+		set_fpr64(&target->thread.fpu.fpr[i], 0, fpr_val);
+	}
+
+	return 0;
 }
 
 enum mips_regset {
-- 
1.8.5.3
