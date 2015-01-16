Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 12:00:42 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50689 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010677AbbAPKxCixYRO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 11:53:02 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D2B097CE0EDA3
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 10:52:54 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 10:52:56 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 10:52:56 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC v2 33/70] MIPS: kernel: r4k_fpu: Add support for MIPS R6
Date:   Fri, 16 Jan 2015 10:49:12 +0000
Message-ID: <1421405389-15512-34-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 45177
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

Add the MIPS R6 related preprocessor definitions for FPU signal
related functions. MIPS R6 only has FR=1 so avoid checking that
bit on the C0/Status register.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/r4k_fpu.S | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
index 6c160c67984c..676c5030a953 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -34,7 +34,7 @@
 	.endm
 
 	.set	noreorder
-	.set	arch=r4000
+	.set	MIPS_ISA_ARCH_LEVEL_RAW
 
 LEAF(_save_fp_context)
 	.set	push
@@ -42,7 +42,8 @@ LEAF(_save_fp_context)
 	cfc1	t1, fcr31
 	.set	pop
 
-#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2)
+#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2) || \
+		defined(CONFIG_CPU_MIPS32_R6)
 	.set	push
 	SET_HARDFLOAT
 #ifdef CONFIG_CPU_MIPS32_R2
@@ -105,10 +106,12 @@ LEAF(_save_fp_context32)
 	SET_HARDFLOAT
 	cfc1	t1, fcr31
 
+#ifndef CONFIG_CPU_MIPS64_R6
 	mfc0	t0, CP0_STATUS
 	sll	t0, t0, 5
 	bgez	t0, 1f			# skip storing odd if FR=0
 	 nop
+#endif
 
 	/* Store the 16 odd double precision registers */
 	EX      sdc1 $f1, SC32_FPREGS+8(a0)
@@ -163,7 +166,8 @@ LEAF(_save_fp_context32)
 LEAF(_restore_fp_context)
 	EX	lw t1, SC_FPC_CSR(a0)
 
-#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2)
+#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2)  || \
+		defined(CONFIG_CPU_MIPS32_R6)
 	.set	push
 	SET_HARDFLOAT
 #ifdef CONFIG_CPU_MIPS32_R2
@@ -223,10 +227,12 @@ LEAF(_restore_fp_context32)
 	SET_HARDFLOAT
 	EX	lw t1, SC32_FPC_CSR(a0)
 
+#ifndef CONFIG_CPU_MIPS64_R6
 	mfc0	t0, CP0_STATUS
 	sll	t0, t0, 5
 	bgez	t0, 1f			# skip loading odd if FR=0
 	 nop
+#endif
 
 	EX      ldc1 $f1, SC32_FPREGS+8(a0)
 	EX      ldc1 $f3, SC32_FPREGS+24(a0)
-- 
2.2.1
