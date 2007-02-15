Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2007 13:06:42 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.230]:65135 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038862AbXBONGK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Feb 2007 13:06:10 +0000
Received: by qb-out-0506.google.com with SMTP id e12so146823qba
        for <linux-mips@linux-mips.org>; Thu, 15 Feb 2007 05:05:09 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=EB/bAcGpbTGeD2bBvODRkgnOet45t2Rc5xZTT7BIu9wmB3am7wgn/679WyuNN/a1hpUgAgleeo0JoZi2FgQidpkk5RZR0yAwRipb1G0hwWhZ+uej34jWdedu3fMwaVvISJD78KrefJ9MP16JSpcrZddRvhH7SYpL4e1bA43NTvc=
Received: by 10.64.208.20 with SMTP id f20mr2788926qbg.1171544709173;
        Thu, 15 Feb 2007 05:05:09 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id g1sm10495192nfe.2007.02.15.05.05.07;
        Thu, 15 Feb 2007 05:05:07 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 2206423F770; Thu, 15 Feb 2007 14:04:21 +0100 (CET)
To:	linux-mips@linux-mips.org
Subject: [PATCH 3/3] Rename CONFIG_BUILD_ELF64 into KBUILD_64BIT_SYM32
Date:	Thu, 15 Feb 2007 14:04:20 +0100
Message-Id: <11715446611812-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
In-Reply-To: <1171544660166-git-send-email-fbuihuu@gmail.com>
References: <11715446603241-git-send-email-fbuihuu@gmail.com> <1171544660166-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

This patch renames it for 3 reasons:

    - "CONFIG" pattern is used by Kconfig. Now this macro is
      no more defined by Kconfig but by Kbuild itself make this
      clear by translating "CONFIG" into "KBUILD".

    - "ELF32" word is improper because it is irrelevant to ELF
      format and it makes confusion with CONFIG_BOOT_ELF32. So
      translate it with SYM32.

    - Add "64BIT" part to make clear that this macro implies a
      64 bits kernel.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/Makefile            |    4 +---
 include/asm-mips/page.h       |    2 +-
 include/asm-mips/pgtable-64.h |    2 +-
 include/asm-mips/stackframe.h |   12 ++++++------
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 2e9ae19..e61c73f 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -625,9 +625,7 @@ ifdef CONFIG_64BIT
   endif
 
   ifeq ($(BUILD_ELF32), y)
-    cflags-y += -msym32
-  else
-    cflags-y += -DCONFIG_BUILD_ELF64
+    cflags-y += -msym32 -DKBUILD_64BIT_SYM32
   endif
 endif
 
diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index d3fbd83..23006f8 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -149,7 +149,7 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 /*
  * __pa()/__va() should be used only during mem init.
  */
-#if defined(CONFIG_64BIT) && !defined(CONFIG_BUILD_ELF64)
+#ifdef KBUILD_64BIT_SYM32
 #define __pa_page_offset(x)	((unsigned long)(x) < CKSEG0 ? PAGE_OFFSET : CKSEG0)
 #else
 #define __pa_page_offset(x)	PAGE_OFFSET
diff --git a/include/asm-mips/pgtable-64.h b/include/asm-mips/pgtable-64.h
index a5b1871..0b603ee 100644
--- a/include/asm-mips/pgtable-64.h
+++ b/include/asm-mips/pgtable-64.h
@@ -104,7 +104,7 @@
 #define VMALLOC_START		MAP_BASE
 #define VMALLOC_END	\
 	(VMALLOC_START + PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE)
-#if defined(CONFIG_MODULES) && !defined(CONFIG_BUILD_ELF64) && \
+#if defined(CONFIG_MODULES) && defined(KBUILD_64BIT_SYM32) && \
 	VMALLOC_START != CKSSEG
 /* Load modules into 32bit-compatible segment. */
 #define MODULE_START	CKSSEG
diff --git a/include/asm-mips/stackframe.h b/include/asm-mips/stackframe.h
index 1fae5dc..bfde702 100644
--- a/include/asm-mips/stackframe.h
+++ b/include/asm-mips/stackframe.h
@@ -70,14 +70,14 @@
 #else
 		MFC0	k0, CP0_CONTEXT
 #endif
-#if defined(CONFIG_BUILD_ELF64) || (defined(CONFIG_64BIT) && __GNUC__ < 4)
+#if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
+		lui	k1, %hi(kernelsp)
+#else
 		lui	k1, %highest(kernelsp)
 		daddiu	k1, %higher(kernelsp)
 		dsll	k1, 16
 		daddiu	k1, %hi(kernelsp)
 		dsll	k1, 16
-#else
-		lui	k1, %hi(kernelsp)
 #endif
 		LONG_SRL	k0, PTEBASE_SHIFT
 		LONG_ADDU	k1, k0
@@ -95,14 +95,14 @@
 		.endm
 #else
 		.macro	get_saved_sp	/* Uniprocessor variation */
-#if defined(CONFIG_BUILD_ELF64) || (defined(CONFIG_64BIT) && __GNUC__ < 4)
+#if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
+		lui	k1, %hi(kernelsp)
+#else
 		lui	k1, %highest(kernelsp)
 		daddiu	k1, %higher(kernelsp)
 		dsll	k1, k1, 16
 		daddiu	k1, %hi(kernelsp)
 		dsll	k1, k1, 16
-#else
-		lui	k1, %hi(kernelsp)
 #endif
 		LONG_L	k1, %lo(kernelsp)(k1)
 		.endm
-- 
1.4.4.3.ge6d4
