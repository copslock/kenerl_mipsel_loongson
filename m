Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2014 17:46:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20564 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860040AbaGKPqByOtBE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2014 17:46:01 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 93033FADBBBEE
        for <linux-mips@linux-mips.org>; Fri, 11 Jul 2014 16:45:51 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 11 Jul 2014 16:45:54 +0100
Received: from pburton-laptop.home (192.168.79.172) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 11 Jul
 2014 16:45:54 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 05/13] MIPS: clear upper 64b of vector registers when MSA is first used
Date:   Fri, 11 Jul 2014 16:44:31 +0100
Message-ID: <1405093479-5123-6-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1405093479-5123-1-git-send-email-paul.burton@imgtec.com>
References: <1405093479-5123-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.79.172]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41140
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
64b of the vector registers are cleared, so that no information can be
leaked to it from the previous task to use MSA context on the CPU. The
architecture specification formerly specified that these bits would be
cleared to 0 when a scalar FP instructions wrote to the aliased FP
registers but more recent versions of the specification now state that
the bits are unpredictable. Clear then explicitly to be sure.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/asmmacro.h | 20 ++++++++++++++++++++
 arch/mips/include/asm/msa.h      |  1 +
 arch/mips/kernel/r4k_switch.S    |  5 +++++
 arch/mips/kernel/traps.c         | 12 +++++++++---
 4 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 4986bf5..2d601e7 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -426,4 +426,24 @@
 	ld_d	31, THREAD_FPR31, \thread
 	.endm
 
+	.macro	msa_clear_upper wd
+#ifdef CONFIG_64BIT
+	insert_d \wd, 1
+#else
+	insert_w \wd, 2
+	insert_w \wd, 3
+#endif
+	.if	31-\wd
+	msa_clear_upper	(\wd+1)
+	.endif
+	.endm
+
+	.macro	msa_clear_all_upper
+	.set	push
+	.set	noat
+	move	$1, zero
+	msa_clear_upper	0
+	.set	pop
+	.endm
+
 #endif /* _ASM_ASMMACRO_H */
diff --git a/arch/mips/include/asm/msa.h b/arch/mips/include/asm/msa.h
index e80e85c..f32aa06 100644
--- a/arch/mips/include/asm/msa.h
+++ b/arch/mips/include/asm/msa.h
@@ -16,6 +16,7 @@
 
 extern void _save_msa(struct task_struct *);
 extern void _restore_msa(struct task_struct *);
+extern void _clear_msa_upper(void);
 
 static inline void enable_msa(void)
 {
diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index 1a1aef0..e459c04 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -144,6 +144,11 @@ LEAF(_restore_msa)
 	jr	ra
 	END(_restore_msa)
 
+LEAF(_clear_msa_upper)
+	msa_clear_all_upper
+	jr	ra
+	END(_clear_msa_upper)
+
 #endif
 
 /*
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 4792fd7..9359907 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1093,8 +1093,10 @@ static int enable_restore_fp_context(int msa)
 	if (!used_math()) {
 		/* First time FP context user. */
 		err = init_fpu();
-		if (msa && !err)
+		if (msa && !err) {
 			enable_msa();
+			_clear_msa_upper();
+		}
 		if (!err)
 			set_used_math();
 		return err;
@@ -1146,10 +1148,14 @@ static int enable_restore_fp_context(int msa)
 	/*
 	 * If this is the first time that the task is using MSA and it has
 	 * previously used scalar FP in this time slice then we already nave
-	 * FP context which we shouldn't clobber.
+	 * FP context which we shouldn't clobber. We do however need to clear
+	 * the upper 64b of each vector register so that this task has no
+	 * opportunity to see data left behind by another.
 	 */
-	if (!test_and_set_thread_flag(TIF_MSA_CTX_LIVE) && was_fpu_owner)
+	if (!test_and_set_thread_flag(TIF_MSA_CTX_LIVE) && was_fpu_owner) {
+		_clear_msa_upper();
 		return 0;
+	}
 
 	/* We need to restore the vector context. */
 	restore_msa(current);
-- 
2.0.1
