Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2014 17:48:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17504 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860088AbaGKPq2UzjQ6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2014 17:46:28 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 39247E5C231B1
        for <linux-mips@linux-mips.org>; Fri, 11 Jul 2014 16:46:18 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 11 Jul 2014 16:46:21 +0100
Received: from pburton-laptop.home (192.168.79.172) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 11 Jul
 2014 16:46:20 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 09/13] MIPS: disable preemption whilst initialising MSA
Date:   Fri, 11 Jul 2014 16:44:35 +0100
Message-ID: <1405093479-5123-10-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 41144
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

Preemption must be disabled throughout the process of enabling the FPU,
enabling MSA & initialising the vector registers. Without doing so it
is possible to lose the FPU or MSA whilst initialising them causing
that initialisation to fail.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/fpu.h |  4 ----
 arch/mips/kernel/traps.c    | 12 ++++++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index 71d97eb..4d0aeda 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -164,8 +164,6 @@ static inline int init_fpu(void)
 {
 	int ret = 0;
 
-	preempt_disable();
-
 	if (cpu_has_fpu) {
 		ret = __own_fpu();
 		if (!ret)
@@ -173,8 +171,6 @@ static inline int init_fpu(void)
 	} else
 		fpu_emulator_init_fpu();
 
-	preempt_enable();
-
 	return ret;
 }
 
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 58a067f..0528246 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1092,6 +1092,7 @@ static int enable_restore_fp_context(int msa)
 
 	if (!used_math()) {
 		/* First time FP context user. */
+		preempt_disable();
 		err = init_fpu();
 		if (msa && !err) {
 			enable_msa();
@@ -1099,6 +1100,7 @@ static int enable_restore_fp_context(int msa)
 			set_thread_flag(TIF_USEDMSA);
 			set_thread_flag(TIF_MSA_CTX_LIVE);
 		}
+		preempt_enable();
 		if (!err)
 			set_used_math();
 		return err;
@@ -1138,10 +1140,11 @@ static int enable_restore_fp_context(int msa)
 	 * This task is using or has previously used MSA. Thus we require
 	 * that Status.FR == 1.
 	 */
+	preempt_disable();
 	was_fpu_owner = is_fpu_owner();
-	err = own_fpu(0);
+	err = own_fpu_inatomic(0);
 	if (err)
-		return err;
+		goto out;
 
 	enable_msa();
 	write_msa_csr(current->thread.fpu.msacsr);
@@ -1156,7 +1159,7 @@ static int enable_restore_fp_context(int msa)
 	 */
 	if (!test_and_set_thread_flag(TIF_MSA_CTX_LIVE) && was_fpu_owner) {
 		_clear_msa_upper();
-		return 0;
+		goto out;
 	}
 
 	/* We need to restore the vector context. */
@@ -1165,7 +1168,8 @@ static int enable_restore_fp_context(int msa)
 	/* Restore the scalar FP control & status register */
 	if (!was_fpu_owner)
 		asm volatile("ctc1 %0, $31" : : "r"(current->thread.fpu.fcr31));
-
+out:
+	preempt_enable();
 	return 0;
 }
 
-- 
2.0.1
