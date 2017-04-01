Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Apr 2017 15:24:04 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45994 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990845AbdDANWjPIn0- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 1 Apr 2017 15:22:39 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1cuIzE-00042K-Qw; Sat, 01 Apr 2017 14:22:36 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1cuIzD-0004eL-Uf; Sat, 01 Apr 2017 14:22:35 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "Paul Burton" <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        "Arnd Bergmann" <arnd@arndb.de>
Date:   Sat, 01 Apr 2017 14:17:50 +0100
Message-ID: <lsq.1491052670.626844544@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 06/19] MIPS: init upper 64b of vector registers when
 MSA is first used
In-Reply-To: <lsq.1491052670.319419763@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57522
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

3.16.43-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit c9017757c532d48bf43d6e7d3b7282443ad4207b upstream.

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
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/7497/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/asmmacro.h | 20 ++++++++++++++++++++
 arch/mips/include/asm/msa.h      |  1 +
 arch/mips/kernel/r4k_switch.S    |  5 +++++
 arch/mips/kernel/traps.c         | 39 ++++++++++++++++++++++++++++++---------
 4 files changed, 56 insertions(+), 9 deletions(-)

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
--- a/arch/mips/include/asm/msa.h
+++ b/arch/mips/include/asm/msa.h
@@ -14,6 +14,7 @@
 
 extern void _save_msa(struct task_struct *);
 extern void _restore_msa(struct task_struct *);
+extern void _init_msa_upper(void);
 
 static inline void enable_msa(void)
 {
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
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1094,13 +1094,15 @@ static int default_cu2_call(struct notif
 
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
@@ -1152,18 +1154,37 @@ static int enable_restore_fp_context(int
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
-
-	/* Restore the scalar FP control & status register */
-	if (!was_fpu_owner)
-		asm volatile("ctc1 %0, $31" : : "r"(current->thread.fpu.fcr31));
-
+	if (!prior_msa) {
+		/*
+		 * Restore the least significant 64b of each vector register
+		 * from the existing scalar FP context.
+		 */
+		_restore_fp(current);
+
+		/*
+		 * The task has not formerly used MSA, so clear the upper 64b
+		 * of each vector register such that it cannot see data left
+		 * behind by another task.
+		 */
+		_init_msa_upper();
+	} else {
+		/* We need to restore the vector context. */
+		restore_msa(current);
+
+		/* Restore the scalar FP control & status register */
+		if (!was_fpu_owner)
+			asm volatile("ctc1 %0, $31" : : "r"(current->thread.fpu.fcr31));
+	}
 	return 0;
 }
 
