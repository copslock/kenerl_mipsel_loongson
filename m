Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 12:00:26 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26240 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010671AbbAPKw7a6QUc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 11:52:59 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 85A9D94FFE904
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 10:52:51 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 10:52:53 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 10:52:52 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC v2 32/70] MIPS: kernel: r4k_switch: Add support for MIPS R6
Date:   Fri, 16 Jan 2015 10:49:11 +0000
Message-ID: <1421405389-15512-33-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

Add the MIPS R6 related preprocessor definitions for save/restore
FPU related functions. We also set the appropriate ISA level
so the final return instruction "jr ra" will produce the correct
opcode on R6.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/asmmacro.h | 12 +++++++-----
 arch/mips/kernel/r4k_switch.S    | 14 ++++++++------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 42b90c9fd756..628a6fbd5e20 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -104,7 +104,8 @@
 	.endm
 
 	.macro	fpu_save_double thread status tmp
-#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2)
+#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2) || \
+		defined(CONFIG_CPU_MIPS32_R6)
 	sll	\tmp, \status, 5
 	bgez	\tmp, 10f
 	fpu_save_16odd \thread
@@ -160,7 +161,8 @@
 	.endm
 
 	.macro	fpu_restore_double thread status tmp
-#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2)
+#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2) || \
+		defined(CONFIG_CPU_MIPS32_R6)
 	sll	\tmp, \status, 5
 	bgez	\tmp, 10f				# 16 register mode?
 
@@ -170,16 +172,16 @@
 	fpu_restore_16even \thread \tmp
 	.endm
 
-#ifdef CONFIG_CPU_MIPSR2
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	.macro	_EXT	rd, rs, p, s
 	ext	\rd, \rs, \p, \s
 	.endm
-#else /* !CONFIG_CPU_MIPSR2 */
+#else /* !CONFIG_CPU_MIPSR2 || !CONFIG_CPU_MIPSR6 */
 	.macro	_EXT	rd, rs, p, s
 	srl	\rd, \rs, \p
 	andi	\rd, \rd, (1 << \s) - 1
 	.endm
-#endif /* !CONFIG_CPU_MIPSR2 */
+#endif /* !CONFIG_CPU_MIPSR2 || !CONFIG_CPU_MIPSR6 */
 
 /*
  * Temporary until all gas have MT ASE support
diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index 64591e671878..3b1a36f13a7d 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -115,7 +115,8 @@
  * Save a thread's fp context.
  */
 LEAF(_save_fp)
-#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2)
+#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2) || \
+		defined(CONFIG_CPU_MIPS32_R6)
 	mfc0	t0, CP0_STATUS
 #endif
 	fpu_save_double a0 t0 t1		# clobbers t1
@@ -126,7 +127,8 @@ LEAF(_save_fp)
  * Restore a thread's fp context.
  */
 LEAF(_restore_fp)
-#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2)
+#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2) || \
+		defined(CONFIG_CPU_MIPS32_R6)
 	mfc0	t0, CP0_STATUS
 #endif
 	fpu_restore_double a0 t0 t1		# clobbers t1
@@ -240,9 +242,9 @@ LEAF(_init_fpu)
 	mtc1	t1, $f30
 	mtc1	t1, $f31
 
-#ifdef CONFIG_CPU_MIPS32_R2
+#if defined(CONFIG_CPU_MIPS32_R2) || defined(CONFIG_CPU_MIPS32_R6)
 	.set    push
-	.set    mips32r2
+	.set    MIPS_ISA_LEVEL_RAW
 	.set	fp=64
 	sll     t0, t0, 5			# is Status.FR set?
 	bgez    t0, 1f				# no: skip setting upper 32b
@@ -280,9 +282,9 @@ LEAF(_init_fpu)
 	mthc1   t1, $f30
 	mthc1   t1, $f31
 1:	.set    pop
-#endif /* CONFIG_CPU_MIPS32_R2 */
+#endif /* CONFIG_CPU_MIPS32_R2 || CONFIG_CPU_MIPS32_R6 */
 #else
-	.set	arch=r4000
+	.set	MIPS_ISA_ARCH_LEVEL_RAW
 	dmtc1	t1, $f0
 	dmtc1	t1, $f2
 	dmtc1	t1, $f4
-- 
2.2.1
