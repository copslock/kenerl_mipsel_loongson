Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Feb 2014 16:14:09 +0100 (CET)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:54725 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816642AbaBOPOGF4Rr8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Feb 2014 16:14:06 +0100
Received: by mail-pa0-f41.google.com with SMTP id fa1so13588584pad.28
        for <multiple recipients>; Sat, 15 Feb 2014 07:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=eACUeU9gMpPTUbtAVjoNp50UScI+m30lApamf9NTNjc=;
        b=z9TY93CYXgHq+CvDu8IMwldhHlk8DUPWm16uFzWK9azoR6lR9Rgq3sJZUqWHCKV2pN
         LS5g3XvcDgUwIMLKkkIDIfrAk8dcSX7LAbyLLSgz4X7Zn6y9UbqaVy4cfb70EK4g0qb0
         Yws2PadP2nKhrUnmALXQevf70BwWjNDfy06dQUTrfhqLkxgQtdADf7sXqLZwULrHcA+Q
         HnU4FVGzWb4SlQEBzxYrQzLbWEXq29wEok29lJzSiIM9P1cp4ijZjHV4Jak2aSLDXjQI
         ZS5TyCYOOZgKhfktEIf5p+GH/BDEw7Df1ywRpCtDdPKYQBF9NPnQsDRMALluRJoIkmvA
         ieCw==
X-Received: by 10.66.253.33 with SMTP id zx1mr15867346pac.28.1392477239217;
        Sat, 15 Feb 2014 07:13:59 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id si6sm69132798pab.19.2014.02.15.07.13.42
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 15 Feb 2014 07:13:58 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH 1/2] MIPS: Replace CONFIG_MIPS64 and CONFIG_MIPS32_R2
Date:   Sat, 15 Feb 2014 23:13:23 +0800
Message-Id: <1392477204-16238-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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
---
 arch/mips/include/asm/asmmacro.h |    4 ++--
 arch/mips/include/asm/fpu.h      |    2 +-
 arch/mips/kernel/r4k_fpu.S       |    8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index fe3b03c..562717f 100644
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
index 8a3d61f..4d86b72 100644
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
index 752b50a..3ab26a5 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -36,9 +36,9 @@
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
@@ -149,9 +149,9 @@ LEAF(_save_fp_context32)
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
1.7.7.3
