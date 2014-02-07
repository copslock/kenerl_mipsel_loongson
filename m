Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Feb 2014 15:32:08 +0100 (CET)
Received: from mail-pd0-f175.google.com ([209.85.192.175]:50207 "EHLO
        mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817088AbaBGOcEPWlhP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Feb 2014 15:32:04 +0100
Received: by mail-pd0-f175.google.com with SMTP id w10so3208546pde.34
        for <multiple recipients>; Fri, 07 Feb 2014 06:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=ZYLVO3glMXAoolXiSCFNH2gOLW/0swRelBEAtXD+C4Q=;
        b=vK5HgCt6jTu8ZfoTaGvdH8dINzy3WXJRL6nMRQ/ERRpKaz/ubbEXFiQCpb8YGMsoSw
         Mwnehuxqopib71DtVNlctm//oPUASm+y7f4arvE7U0FK1zP3NwJG8fAzj4beUwLCruli
         NgILSrgwi/DHPn0vocTsQ1m1f6HD5T5eqytV6Xdl/I8LnYLPt9Sbn0x4O5fa+bmnody3
         999XRD0WVCTYmFolhBzRhRDpfFNmKUCQhW+U2PldY/eJ2VcrMcBTCQdRGdW3B2ZC49Gm
         ixykdELihv+R5zbkeQf+uYpE2H+0Ho1hkcd3c5VLSODmLkOyoe29yPdj/HKOH4ZW3FSA
         B4hg==
X-Received: by 10.66.154.169 with SMTP id vp9mr8176724pab.39.1391783517066;
        Fri, 07 Feb 2014 06:31:57 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id mo2sm14257612pbc.6.2014.02.07.06.31.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Feb 2014 06:31:56 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 1/2] MIPS: fix CONFIG_* error in fpu code
Date:   Fri,  7 Feb 2014 22:31:32 +0800
Message-Id: <1391783493-6806-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39230
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

Commit 597ce1723e0f (MIPS: Support for 64-bit FP with O32 binaries)
brings some CONFIG_MIPS64, but CONFIG_MIPS64 doesn't exist in any
Kconfig file. I guess the correct thing is CONFIG_64BIT, so fix it.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/asmmacro.h |    4 ++--
 arch/mips/include/asm/fpu.h      |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

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
-- 
1.7.7.3
