Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jun 2017 20:23:17 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25528 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992213AbdFESWuvwL4R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jun 2017 20:22:50 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 743086EA49A44;
        Mon,  5 Jun 2017 19:22:40 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 5 Jun 2017 19:22:44
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 3/5] MIPS: Move r2300 FP code from r2300_switch.S to r2300_fpu.S
Date:   Mon, 5 Jun 2017 11:21:29 -0700
Message-ID: <20170605182131.16853-4-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170605182131.16853-1-paul.burton@imgtec.com>
References: <20170605182131.16853-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58225
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

Move _save_fp(), _restore_fp() & _init_fpu() out of r2300_switch.S &
into r2300_fpu.S. This logically places all FP-related asm code into
r2300_fpu.S & provides consistency with R4K after the preceding commit.

Besides cleaning up this will be useful for later patches which disable
FP support.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/kernel/r2300_fpu.S    | 78 ++++++++++++++++++++++++++++++++++++++++-
 arch/mips/kernel/r2300_switch.S | 75 ---------------------------------------
 2 files changed, 77 insertions(+), 76 deletions(-)

diff --git a/arch/mips/kernel/r2300_fpu.S b/arch/mips/kernel/r2300_fpu.S
index 918f2f6d3861..5d65132d4bca 100644
--- a/arch/mips/kernel/r2300_fpu.S
+++ b/arch/mips/kernel/r2300_fpu.S
@@ -31,9 +31,85 @@
 	PTR	9b+4,bad_stack;					\
 	.previous
 
-	.set	noreorder
 	.set	mips1
 
+/*
+ * Save a thread's fp context.
+ */
+LEAF(_save_fp)
+EXPORT_SYMBOL(_save_fp)
+	fpu_save_single a0, t1			# clobbers t1
+	jr	ra
+	END(_save_fp)
+
+/*
+ * Restore a thread's fp context.
+ */
+LEAF(_restore_fp)
+	fpu_restore_single a0, t1		# clobbers t1
+	jr	ra
+	END(_restore_fp)
+
+/*
+ * Load the FPU with signalling NANS.  This bit pattern we're using has
+ * the property that no matter whether considered as single or as double
+ * precision represents signaling NANS.
+ *
+ * The value to initialize fcr31 to comes in $a0.
+ */
+
+	.set push
+	SET_HARDFLOAT
+
+LEAF(_init_fpu)
+	mfc0	t0, CP0_STATUS
+	li	t1, ST0_CU1
+	or	t0, t1
+	mtc0	t0, CP0_STATUS
+
+	ctc1	a0, fcr31
+
+	li	t0, -1
+
+	mtc1	t0, $f0
+	mtc1	t0, $f1
+	mtc1	t0, $f2
+	mtc1	t0, $f3
+	mtc1	t0, $f4
+	mtc1	t0, $f5
+	mtc1	t0, $f6
+	mtc1	t0, $f7
+	mtc1	t0, $f8
+	mtc1	t0, $f9
+	mtc1	t0, $f10
+	mtc1	t0, $f11
+	mtc1	t0, $f12
+	mtc1	t0, $f13
+	mtc1	t0, $f14
+	mtc1	t0, $f15
+	mtc1	t0, $f16
+	mtc1	t0, $f17
+	mtc1	t0, $f18
+	mtc1	t0, $f19
+	mtc1	t0, $f20
+	mtc1	t0, $f21
+	mtc1	t0, $f22
+	mtc1	t0, $f23
+	mtc1	t0, $f24
+	mtc1	t0, $f25
+	mtc1	t0, $f26
+	mtc1	t0, $f27
+	mtc1	t0, $f28
+	mtc1	t0, $f29
+	mtc1	t0, $f30
+	mtc1	t0, $f31
+	jr	ra
+	END(_init_fpu)
+
+	.set pop
+
+	.set	noreorder
+
 /**
  * _save_fp_context() - save FP context from the FPU
  * @a0 - pointer to fpregs field of sigcontext
diff --git a/arch/mips/kernel/r2300_switch.S b/arch/mips/kernel/r2300_switch.S
index 1049eeafd97d..887f836cfa5c 100644
--- a/arch/mips/kernel/r2300_switch.S
+++ b/arch/mips/kernel/r2300_switch.S
@@ -68,78 +68,3 @@ LEAF(resume)
 	move	v0, a0
 	jr	ra
 	END(resume)
-
-/*
- * Save a thread's fp context.
- */
-LEAF(_save_fp)
-EXPORT_SYMBOL(_save_fp)
-	fpu_save_single a0, t1			# clobbers t1
-	jr	ra
-	END(_save_fp)
-
-/*
- * Restore a thread's fp context.
- */
-LEAF(_restore_fp)
-	fpu_restore_single a0, t1		# clobbers t1
-	jr	ra
-	END(_restore_fp)
-
-/*
- * Load the FPU with signalling NANS.  This bit pattern we're using has
- * the property that no matter whether considered as single or as double
- * precision represents signaling NANS.
- *
- * The value to initialize fcr31 to comes in $a0.
- */
-
-	.set push
-	SET_HARDFLOAT
-
-LEAF(_init_fpu)
-	mfc0	t0, CP0_STATUS
-	li	t1, ST0_CU1
-	or	t0, t1
-	mtc0	t0, CP0_STATUS
-
-	ctc1	a0, fcr31
-
-	li	t0, -1
-
-	mtc1	t0, $f0
-	mtc1	t0, $f1
-	mtc1	t0, $f2
-	mtc1	t0, $f3
-	mtc1	t0, $f4
-	mtc1	t0, $f5
-	mtc1	t0, $f6
-	mtc1	t0, $f7
-	mtc1	t0, $f8
-	mtc1	t0, $f9
-	mtc1	t0, $f10
-	mtc1	t0, $f11
-	mtc1	t0, $f12
-	mtc1	t0, $f13
-	mtc1	t0, $f14
-	mtc1	t0, $f15
-	mtc1	t0, $f16
-	mtc1	t0, $f17
-	mtc1	t0, $f18
-	mtc1	t0, $f19
-	mtc1	t0, $f20
-	mtc1	t0, $f21
-	mtc1	t0, $f22
-	mtc1	t0, $f23
-	mtc1	t0, $f24
-	mtc1	t0, $f25
-	mtc1	t0, $f26
-	mtc1	t0, $f27
-	mtc1	t0, $f28
-	mtc1	t0, $f29
-	mtc1	t0, $f30
-	mtc1	t0, $f31
-	jr	ra
-	END(_init_fpu)
-
-	.set pop
-- 
2.13.0
