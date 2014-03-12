Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Mar 2014 23:40:47 +0100 (CET)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:40884 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6870549AbaCLWjufpxnu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Mar 2014 23:39:50 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id CE9BB56F8F5;
        Thu, 13 Mar 2014 00:39:49 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id t92XxmcQuySm; Thu, 13 Mar 2014 00:39:44 +0200 (EET)
Received: from cooljazz.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id B6FA85BC006;
        Thu, 13 Mar 2014 00:39:44 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Paul Bolle <pebolle@tiscali.nl>,
        Huacai Chen <chenhc@lemote.com>, Andreas Barth <aba@ayous.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH RESEND 1/2] MIPS: Replace CONFIG_MIPS64 and CONFIG_MIPS32_R2
Date:   Thu, 13 Mar 2014 00:41:06 +0200
Message-Id: <1394664067-17712-2-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394664067-17712-1-git-send-email-aaro.koskinen@iki.fi>
References: <1394664067-17712-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

From: Paul Bolle <pebolle@tiscali.nl>

Commit 597ce1723e0f ("MIPS: Support for 64-bit FP with O32 binaries")
introduced references to two undefined Kconfig macros. CONFIG_MIPS32_R2
should clearly be replaced with CONFIG_CPU_MIPS32_R2. And CONFIG_MIPS64
should apparently be replaced with CONFIG_64BIT.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
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
index 6b97495..58e50cb 100644
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
1.9.0
