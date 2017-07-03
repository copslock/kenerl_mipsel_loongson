Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jul 2017 00:42:13 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53535 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993904AbdGCWmGriBUk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jul 2017 00:42:06 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5820037FAD514;
        Mon,  3 Jul 2017 23:41:55 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 3 Jul 2017 23:42:00 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: [PATCH] MIPS: Fix MIPS64 FP save/restore on 32-bit kernels
Date:   Mon, 3 Jul 2017 23:41:47 +0100
Message-ID: <9a0f24583ac74fd8da19e3edb1739dc6bb6d6d5d.1499121677.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.13.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

32-bit kernels can be configured to support MIPS64, in which case
neither CONFIG_64BIT or CONFIG_CPU_MIPS32_R* will be set. This causes
the CP0_Status.FR checks at the point of floating point register save
and restore to be compiled out, which results in odd FP registers not
being saved or restored to the task or signal context even when
CP0_Status.FR is set.

Fix the ifdefs to use CONFIG_CPU_MIPSR2 and CONFIG_CPU_MIPSR6, which are
enabled for the relevant revisions of either MIPS32 or MIPS64, along
with some other CPUs such as Octeon (r2), Loongson1 (r2), XLP (r2),
Loongson 3A R2.

The suspect code originates from commit 597ce1723e0f ("MIPS: Support for
64-bit FP with O32 binaries") in v3.14, however the code in
__enable_fpu() was consistent and refused to set FR=1, falling back to
software FPU emulation. This was suboptimal but should be functionally
correct.

Commit fcc53b5f6c38 ("MIPS: fpu.h: Allow 64-bit FPU on a 64-bit MIPS R6
CPU") in v4.2 (and stable tagged back to 4.0) later introduced the bug
by updating __enable_fpu() to set FR=1 but failing to update the other
similar ifdefs to enable FR=1 state handling.

Fixes: fcc53b5f6c38 ("MIPS: fpu.h: Allow 64-bit FPU on a 64-bit MIPS R6 CPU")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.0+
---
 arch/mips/include/asm/asmmacro.h |  8 ++++----
 arch/mips/kernel/r4k_fpu.S       | 12 ++++++------
 arch/mips/kernel/r4k_switch.S    |  8 ++++----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 83054f79f72a..b815d7b3bd27 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -126,8 +126,8 @@
 	.endm
 
 	.macro	fpu_save_double thread status tmp
-#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2) || \
-		defined(CONFIG_CPU_MIPS32_R6)
+#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPSR2) || \
+		defined(CONFIG_CPU_MIPSR6)
 	sll	\tmp, \status, 5
 	bgez	\tmp, 10f
 	fpu_save_16odd \thread
@@ -184,8 +184,8 @@
 	.endm
 
 	.macro	fpu_restore_double thread status tmp
-#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2) || \
-		defined(CONFIG_CPU_MIPS32_R6)
+#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPSR2) || \
+		defined(CONFIG_CPU_MIPSR6)
 	sll	\tmp, \status, 5
 	bgez	\tmp, 10f				# 16 register mode?
 
diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
index 56d86b09c917..93b1745def16 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -50,11 +50,11 @@ LEAF(_save_fp_context)
 	cfc1	t1, fcr31
 	.set	pop
 
-#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2) || \
-		defined(CONFIG_CPU_MIPS32_R6)
+#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPSR2) || \
+		defined(CONFIG_CPU_MIPSR6)
 	.set	push
 	SET_HARDFLOAT
-#ifdef CONFIG_CPU_MIPS32_R2
+#ifdef CONFIG_CPU_MIPSR2
 	.set	mips32r2
 	.set	fp=64
 	mfc0	t0, CP0_STATUS
@@ -118,11 +118,11 @@ LEAF(_save_fp_context)
 LEAF(_restore_fp_context)
 	EX	lw t1, 0(a1)
 
-#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2)  || \
-		defined(CONFIG_CPU_MIPS32_R6)
+#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPSR2)  || \
+		defined(CONFIG_CPU_MIPSR6)
 	.set	push
 	SET_HARDFLOAT
-#ifdef CONFIG_CPU_MIPS32_R2
+#ifdef CONFIG_CPU_MIPSR2
 	.set	mips32r2
 	.set	fp=64
 	mfc0	t0, CP0_STATUS
diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index 7b386d54fd65..5508d3a03dbf 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -71,8 +71,8 @@
  */
 LEAF(_save_fp)
 EXPORT_SYMBOL(_save_fp)
-#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2) || \
-		defined(CONFIG_CPU_MIPS32_R6)
+#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPSR2) || \
+		defined(CONFIG_CPU_MIPSR6)
 	mfc0	t0, CP0_STATUS
 #endif
 	fpu_save_double a0 t0 t1		# clobbers t1
@@ -83,8 +83,8 @@ EXPORT_SYMBOL(_save_fp)
  * Restore a thread's fp context.
  */
 LEAF(_restore_fp)
-#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2) || \
-		defined(CONFIG_CPU_MIPS32_R6)
+#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPSR2) || \
+		defined(CONFIG_CPU_MIPSR6)
 	mfc0	t0, CP0_STATUS
 #endif
 	fpu_restore_double a0 t0 t1		# clobbers t1
-- 
git-series 0.8.10
