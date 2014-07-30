Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2014 09:53:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15874 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837604AbaG3HxmfnUJV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Jul 2014 09:53:42 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E762E6960B141
        for <linux-mips@linux-mips.org>; Wed, 30 Jul 2014 08:53:33 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 30 Jul 2014 08:53:35 +0100
Received: from pburton-laptop.home (192.168.79.176) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 30 Jul
 2014 08:53:34 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 05/13] MIPS: init upper 64b of vector registers when MSA is first used
Date:   Wed, 30 Jul 2014 08:53:20 +0100
Message-ID: <1406706800-8637-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.2
In-Reply-To: <1405093479-5123-6-git-send-email-paul.burton@imgtec.com>
References: <1405093479-5123-6-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.79.176]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41803
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

When a task first makes use of MSA we need to ensure that the upper
64b of the vector registers are set to some value such that no
information can be leaked to it from the previous task to use MSA
context on the CPU. The architecture formerly specified that these
bits would be cleared to 0 when a scalar FP instructions wrote to the
aliased FP registers, which would have implicitly handled this as the
kernel restored scalar FP context. However more recent versions of the
specification now state that the value of the bits in such cases is
unpredictable. Initialise them explictly to be sure, and set all the
bits to 1 rather than 0 for consistency with the least significant
64b.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
Changes in v2:
  - Handle the case of a task which has formerly used FP, but doesn't
    currently have live FP context & has not formerly used MSA.
  - Initialise to all-1s rather than all-0s for consistency with the
    64b scalar FP registers.
---
 arch/mips/include/asm/asmmacro.h | 20 ++++++++++++++++++++
 arch/mips/include/asm/msa.h      |  1 +
 arch/mips/kernel/r4k_switch.S    |  5 +++++
 arch/mips/kernel/traps.c         | 39 ++++++++++++++++++++++++++++++---------
 4 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 4986bf5..cd9a98b 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -426,4 +426,24 @@
 	ld_d	31, THREAD_FPR31, \thread
 	.endm
 
+	.macro	msa_init_upper wd
+#ifdef CONFIG_64BIT
+	insert_d \wd, 1
+#else
+	insert_w \wd, 2
+	insert_w \wd, 3
+#endif
+	.if	31-\wd
+	msa_init_upper	(\wd+1)
+	.endif
+	.endm
+
+	.macro	msa_init_all_upper
+	.set	push
+	.set	noat
+	not	$1, zero
+	msa_init_upper	0
+	.set	pop
+	.endm
+
 #endif /* _ASM_ASMMACRO_H */
diff --git a/arch/mips/include/asm/msa.h b/arch/mips/include/asm/msa.h
index e80e85c..fe25a17 100644
--- a/arch/mips/include/asm/msa.h
+++ b/arch/mips/include/asm/msa.h
@@ -16,6 +16,7 @@
 
 extern void _save_msa(struct task_struct *);
 extern void _restore_msa(struct task_struct *);
+extern void _init_msa_upper(void);
 
 static inline void enable_msa(void)
 {
diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index 1a1aef0..4c4ec18 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -144,6 +144,11 @@ LEAF(_restore_msa)
 	jr	ra
 	END(_restore_msa)
 
+LEAF(_init_msa_upper)
+	msa_init_all_upper
+	jr	ra
+	END(_init_msa_upper)
+
 #endif
 
 /*
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 4792fd7..4aca484 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1088,13 +1088,15 @@ static int default_cu2_call(struct notifier_block *nfb, unsigned long action,
 
 static int enable_restore_fp_context(int msa)
 {
-	int err, was_fpu_owner;
+	int err, was_fpu_owner, prior_msa;
 
 	if (!used_math()) {
 		/* First time FP context user. */
 		err = init_fpu();
-		if (msa && !err)
+		if (msa && !err) {
 			enable_msa();
+			_init_msa_upper();
+		}
 		if (!err)
 			set_used_math();
 		return err;
@@ -1146,18 +1148,37 @@ static int enable_restore_fp_context(int msa)
 	/*
 	 * If this is the first time that the task is using MSA and it has
 	 * previously used scalar FP in this time slice then we already nave
-	 * FP context which we shouldn't clobber.
+	 * FP context which we shouldn't clobber. We do however need to clear
+	 * the upper 64b of each vector register so that this task has no
+	 * opportunity to see data left behind by another.
 	 */
-	if (!test_and_set_thread_flag(TIF_MSA_CTX_LIVE) && was_fpu_owner)
+	prior_msa = test_and_set_thread_flag(TIF_MSA_CTX_LIVE);
+	if (!prior_msa && was_fpu_owner) {
+		_init_msa_upper();
 		return 0;
+	}
 
-	/* We need to restore the vector context. */
-	restore_msa(current);
+	if (!prior_msa) {
+		/*
+		 * Restore the least significant 64b of each vector register
+		 * from the existing scalar FP context.
+		 */
+		_restore_fp(current);
 
-	/* Restore the scalar FP control & status register */
-	if (!was_fpu_owner)
-		asm volatile("ctc1 %0, $31" : : "r"(current->thread.fpu.fcr31));
+		/*
+		 * The task has not formerly used MSA, so clear the upper 64b
+		 * of each vector register such that it cannot see data left
+		 * behind by another task.
+		 */
+		_init_msa_upper();
+	} else {
+		/* We need to restore the vector context. */
+		restore_msa(current);
 
+		/* Restore the scalar FP control & status register */
+		if (!was_fpu_owner)
+			asm volatile("ctc1 %0, $31" : : "r"(current->thread.fpu.fcr31));
+	}
 	return 0;
 }
 
-- 
2.0.2
