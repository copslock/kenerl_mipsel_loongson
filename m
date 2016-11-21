Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2016 11:24:27 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63112 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992160AbcKUKXvupwo8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Nov 2016 11:23:51 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9CB96589CFB4E;
        Mon, 21 Nov 2016 10:23:42 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 21 Nov 2016 10:23:44 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH 1/2] MIPS: move register dump routines out of ptrace code
Date:   Mon, 21 Nov 2016 11:23:38 +0100
Message-ID: <1479723819-14557-1-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

Current register dump methods for MIPS are implemented inside ptrace
methods, but there will be other uses in the kernel for them, so keep
them separately in process.c and use those definitions for ptrace
instead.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/include/asm/elf.h |  3 +++
 arch/mips/kernel/process.c  | 44 ++++++++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/ptrace.c   | 34 ++--------------------------------
 3 files changed, 49 insertions(+), 32 deletions(-)

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index 2b3dc29..f61a4a1 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -210,6 +210,9 @@ typedef elf_greg_t elf_gregset_t[ELF_NGREG];
 typedef double elf_fpreg_t;
 typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
 
+void mips_dump_regs32(u32 *uregs, const struct pt_regs *regs);
+void mips_dump_regs64(u64 *uregs, const struct pt_regs *regs);
+
 #ifdef CONFIG_32BIT
 /*
  * This is used to ensure we don't load something for the wrong architecture.
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index b7a1c45..68641ff 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -716,3 +716,47 @@ int mips_set_process_fp_mode(struct task_struct *task, unsigned int value)
 
 	return 0;
 }
+
+#if defined(CONFIG_32BIT) || defined(CONFIG_MIPS32_O32)
+void mips_dump_regs32(u32 *uregs, const struct pt_regs *regs)
+{
+	unsigned int i;
+
+	for (i = MIPS32_EF_R1; i <= MIPS32_EF_R31; i++) {
+		/* k0/k1 are copied as zero. */
+		if (i == MIPS32_EF_R26 || i == MIPS32_EF_R27)
+			uregs[i] = 0;
+		else
+			uregs[i] = regs->regs[i - MIPS32_EF_R0];
+	}
+
+	uregs[MIPS32_EF_LO] = regs->lo;
+	uregs[MIPS32_EF_HI] = regs->hi;
+	uregs[MIPS32_EF_CP0_EPC] = regs->cp0_epc;
+	uregs[MIPS32_EF_CP0_BADVADDR] = regs->cp0_badvaddr;
+	uregs[MIPS32_EF_CP0_STATUS] = regs->cp0_status;
+	uregs[MIPS32_EF_CP0_CAUSE] = regs->cp0_cause;
+}
+#endif /* CONFIG_32BIT || CONFIG_MIPS32_O32 */
+
+#ifdef CONFIG_64BIT
+void mips_dump_regs64(u64 *uregs, const struct pt_regs *regs)
+{
+	unsigned int i;
+
+	for (i = MIPS64_EF_R1; i <= MIPS64_EF_R31; i++) {
+		/* k0/k1 are copied as zero. */
+		if (i == MIPS64_EF_R26 || i == MIPS64_EF_R27)
+			uregs[i] = 0;
+		else
+			uregs[i] = regs->regs[i - MIPS64_EF_R0];
+	}
+
+	uregs[MIPS64_EF_LO] = regs->lo;
+	uregs[MIPS64_EF_HI] = regs->hi;
+	uregs[MIPS64_EF_CP0_EPC] = regs->cp0_epc;
+	uregs[MIPS64_EF_CP0_BADVADDR] = regs->cp0_badvaddr;
+	uregs[MIPS64_EF_CP0_STATUS] = regs->cp0_status;
+	uregs[MIPS64_EF_CP0_CAUSE] = regs->cp0_cause;
+}
+#endif /* CONFIG_64BIT */
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index a92994d..751f69d 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -294,23 +294,8 @@ static int gpr32_get(struct task_struct *target,
 {
 	struct pt_regs *regs = task_pt_regs(target);
 	u32 uregs[ELF_NGREG] = {};
-	unsigned i;
-
-	for (i = MIPS32_EF_R1; i <= MIPS32_EF_R31; i++) {
-		/* k0/k1 are copied as zero. */
-		if (i == MIPS32_EF_R26 || i == MIPS32_EF_R27)
-			continue;
-
-		uregs[i] = regs->regs[i - MIPS32_EF_R0];
-	}
-
-	uregs[MIPS32_EF_LO] = regs->lo;
-	uregs[MIPS32_EF_HI] = regs->hi;
-	uregs[MIPS32_EF_CP0_EPC] = regs->cp0_epc;
-	uregs[MIPS32_EF_CP0_BADVADDR] = regs->cp0_badvaddr;
-	uregs[MIPS32_EF_CP0_STATUS] = regs->cp0_status;
-	uregs[MIPS32_EF_CP0_CAUSE] = regs->cp0_cause;
 
+	mips_dump_regs32(uregs, regs);
 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, uregs, 0,
 				   sizeof(uregs));
 }
@@ -373,23 +358,8 @@ static int gpr64_get(struct task_struct *target,
 {
 	struct pt_regs *regs = task_pt_regs(target);
 	u64 uregs[ELF_NGREG] = {};
-	unsigned i;
-
-	for (i = MIPS64_EF_R1; i <= MIPS64_EF_R31; i++) {
-		/* k0/k1 are copied as zero. */
-		if (i == MIPS64_EF_R26 || i == MIPS64_EF_R27)
-			continue;
-
-		uregs[i] = regs->regs[i - MIPS64_EF_R0];
-	}
-
-	uregs[MIPS64_EF_LO] = regs->lo;
-	uregs[MIPS64_EF_HI] = regs->hi;
-	uregs[MIPS64_EF_CP0_EPC] = regs->cp0_epc;
-	uregs[MIPS64_EF_CP0_BADVADDR] = regs->cp0_badvaddr;
-	uregs[MIPS64_EF_CP0_STATUS] = regs->cp0_status;
-	uregs[MIPS64_EF_CP0_CAUSE] = regs->cp0_cause;
 
+	mips_dump_regs64(uregs, regs);
 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, uregs, 0,
 				   sizeof(uregs));
 }
-- 
2.7.4
