Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 11:47:27 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35580 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992346AbdK1KpGN7Rz- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 11:45:06 +0100
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B4899AF3;
        Tue, 28 Nov 2017 10:44:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Subject: [PATCH 4.14 049/193] MIPS: Fix MIPS64 FP save/restore on 32-bit kernels
Date:   Tue, 28 Nov 2017 11:24:56 +0100
Message-Id: <20171128100615.647821523@linuxfoundation.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171128100613.638270407@linuxfoundation.org>
References: <20171128100613.638270407@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <jhogan@kernel.org>

commit 22b8ba765a726d90e9830ff6134c32b04f12c10f upstream.

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
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16739/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/asmmacro.h |    8 ++++----
 arch/mips/kernel/r4k_fpu.S       |   20 ++++++++++----------
 2 files changed, 14 insertions(+), 14 deletions(-)

--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -130,8 +130,8 @@
 	.endm
 
 	.macro	fpu_save_double thread status tmp
-#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2) || \
-		defined(CONFIG_CPU_MIPS32_R6)
+#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPSR2) || \
+		defined(CONFIG_CPU_MIPSR6)
 	sll	\tmp, \status, 5
 	bgez	\tmp, 10f
 	fpu_save_16odd \thread
@@ -189,8 +189,8 @@
 	.endm
 
 	.macro	fpu_restore_double thread status tmp
-#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2) || \
-		defined(CONFIG_CPU_MIPS32_R6)
+#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPSR2) || \
+		defined(CONFIG_CPU_MIPSR6)
 	sll	\tmp, \status, 5
 	bgez	\tmp, 10f				# 16 register mode?
 
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -40,8 +40,8 @@
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
@@ -52,8 +52,8 @@ EXPORT_SYMBOL(_save_fp)
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
@@ -246,11 +246,11 @@ LEAF(_save_fp_context)
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
@@ -314,11 +314,11 @@ LEAF(_save_fp_context)
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
