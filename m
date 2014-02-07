Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Feb 2014 05:23:35 +0100 (CET)
Received: from mail-pd0-f174.google.com ([209.85.192.174]:63876 "EHLO
        mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817088AbaBGEXcC0TfF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Feb 2014 05:23:32 +0100
Received: by mail-pd0-f174.google.com with SMTP id z10so2601079pdj.5
        for <multiple recipients>; Thu, 06 Feb 2014 20:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=FxDS+Na4T6UzjWPzGVjPZZdN94kBQjZINhKy7FSar/w=;
        b=NhJ1Z2XTa1R66WM8tbsWImybTqTGTOhPtl3lcFekc6EQfrIqk/WyYQXhCmyJXX9w7l
         FA4AaZOz8tb0aVd6YSdHPVRa34J6Yw1s7xggerZsu53udNu79Qb6WyICIFqiN7fJr32G
         3PE+EC4N05UqANGzW9TKAhnBHzW6XiqloSEvXaXl9bZWfzzir0vNGIFJObUcfVqaF5lp
         qwTCD9PA5SdjLjZAgha0YEsisGEgE+xXGItzHPYX4bQ7gZ+bzKvDVhZsI3pCwEY+mVPN
         Jxy2pLUyK8WQ0TJtzdcpkyTiuL+rxslgofUKDCufDVfGGtbZdQU4fq6+N89t/zqq2X+1
         vWnw==
X-Received: by 10.68.197.66 with SMTP id is2mr17000866pbc.96.1391747004414;
        Thu, 06 Feb 2014 20:23:24 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id ug2sm22587174pac.21.2014.02.06.20.23.15
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 06 Feb 2014 20:23:22 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [RFC PATCH] MIPS: fix CONFIG_* error in fpu code
Date:   Fri,  7 Feb 2014 12:22:52 +0800
Message-Id: <1391746972-25277-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39227
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
-- 
1.7.7.3
