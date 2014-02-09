Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Feb 2014 14:32:44 +0100 (CET)
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:55237 "EHLO
        cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822672AbaBINcbl6r5J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 9 Feb 2014 14:32:31 +0100
Received: from cpsps-ews15.kpnxchange.com ([10.94.84.182]) by cpsmtpb-ews05.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sun, 9 Feb 2014 14:32:25 +0100
Received: from CPSMTPM-TLF101.kpnxchange.com ([195.121.3.4]) by cpsps-ews15.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sun, 9 Feb 2014 14:32:25 +0100
Received: from [192.168.1.104] ([82.169.24.127]) by CPSMTPM-TLF101.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sun, 9 Feb 2014 14:32:25 +0100
Message-ID: <1391952745.25424.6.camel@x220>
Subject: [PATCH] MIPS: Replace CONFIG_MIPS64 and CONFIG_MIPS32_R2
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:   Sun, 09 Feb 2014 14:32:25 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.3 (3.10.3-1.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Feb 2014 13:32:25.0570 (UTC) FILETIME=[5EAEB420:01CF259B]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
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

Commit 597ce1723e0f ("MIPS: Support for 64-bit FP with O32 binaries")
introduced references to two undefined Kconfig macros. CONFIG_MIPS32_R2
should clearly be replaced with CONFIG_CPU_MIPS32_R2. And CONFIG_MIPS64
should apparently be replaced with CONFIG_64BIT.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested!

 arch/mips/include/asm/asmmacro.h | 4 ++--
 arch/mips/include/asm/fpu.h      | 2 +-
 arch/mips/kernel/r4k_fpu.S       | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 3220c93..69a9a22 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -106,7 +106,7 @@
 	.endm
 
 	.macro	fpu_save_double thread status tmp
-#if defined(CONFIG_MIPS64) || defined(CONFIG_CPU_MIPS32_R2)
+#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2)
 	sll	\tmp, \status, 5
 	bgez	\tmp, 10f
 	fpu_save_16odd \thread
@@ -159,7 +159,7 @@
 	.endm
 
 	.macro	fpu_restore_double thread status tmp
-#if defined(CONFIG_MIPS64) || defined(CONFIG_CPU_MIPS32_R2)
+#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2)
 	sll	\tmp, \status, 5
 	bgez	\tmp, 10f				# 16 register mode?
 
diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index cfe092f..f80a07e 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -57,7 +57,7 @@ static inline int __enable_fpu(enum fpu_mode mode)
 		return 0;
 
 	case FPU_64BIT:
-#if !(defined(CONFIG_CPU_MIPS32_R2) || defined(CONFIG_MIPS64))
+#if !(defined(CONFIG_CPU_MIPS32_R2) || defined(CONFIG_64BIT))
 		/* we only have a 32-bit FPU */
 		return SIGFPE;
 #endif
diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
index 253b2fb..841ffc2 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -35,9 +35,9 @@
 LEAF(_save_fp_context)
 	cfc1	t1, fcr31
 
-#if defined(CONFIG_64BIT) || defined(CONFIG_MIPS32_R2)
+#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2)
 	.set	push
-#ifdef CONFIG_MIPS32_R2
+#ifdef CONFIG_CPU_MIPS32_R2
 	.set	mips64r2
 	mfc0	t0, CP0_STATUS
 	sll	t0, t0, 5
@@ -148,9 +148,9 @@ LEAF(_save_fp_context32)
 LEAF(_restore_fp_context)
 	EX	lw t0, SC_FPC_CSR(a0)
 
-#if defined(CONFIG_64BIT) || defined(CONFIG_MIPS32_R2)
+#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2)
 	.set	push
-#ifdef CONFIG_MIPS32_R2
+#ifdef CONFIG_CPU_MIPS32_R2
 	.set	mips64r2
 	mfc0	t0, CP0_STATUS
 	sll	t0, t0, 5
-- 
1.8.5.3
