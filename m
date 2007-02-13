Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2007 09:21:58 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.231]:46901 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20039097AbXBMJUC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Feb 2007 09:20:02 +0000
Received: by hu-out-0506.google.com with SMTP id 22so1062376hug
        for <linux-mips@linux-mips.org>; Tue, 13 Feb 2007 01:19:01 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=fGcbNk+aNmpK8bhr6h0o5JH5DBUUZJC5RnIMMHg6GjOBUWPTcyBJLeNuUmNyDIj4LUv0WKrj+d5kl/dGodiRykA/BAeD37Xle17B0JEGkM3GVbFUOULwnD5TRqa8bomo+5/5NVucXxRd5pG3jvArgcFsfcqdPv2Fmm8IaNu5jHc=
Received: by 10.48.162.15 with SMTP id k15mr537722nfe.1171358341350;
        Tue, 13 Feb 2007 01:19:01 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id l27sm1895034nfa.2007.02.13.01.18.59;
        Tue, 13 Feb 2007 01:19:00 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 7FF9023F76F; Tue, 13 Feb 2007 10:18:10 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, anemo@mba.ocn.ne.jp,
	macro@linux-mips.org
Subject: [PATCH 3/3] Rename CONFIG_BUILD_ELF64 into CONFIG_64BIT_BUILD_ELF32
Date:	Tue, 13 Feb 2007 10:18:09 +0100
Message-Id: <11713582901252-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
In-Reply-To: <1171358289786-git-send-email-fbuihuu@gmail.com>
References: <1171358289786-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/Makefile            |    6 ++----
 include/asm-mips/page.h       |    2 +-
 include/asm-mips/pgtable-64.h |    2 +-
 include/asm-mips/stackframe.h |   12 ++++++------
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 626771c..fa08d07 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -625,11 +625,9 @@ ifdef CONFIG_64BIT
   endif
 
   ifeq ("$(BUILD_ELF32)", "y")
-    cflags-y += -msym32
-  else
-    cflags-y += -DCONFIG_BUILD_ELF64
+    cflags-y += -msym32 -DCONFIG_64BIT_BUILD_ELF32
   endif
-endif # CONFIG_64BIT
+endif
 
 AFLAGS		+= $(cflags-y)
 CFLAGS		+= $(cflags-y)
diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index d3fbd83..d37a24c 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -149,7 +149,7 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 /*
  * __pa()/__va() should be used only during mem init.
  */
-#if defined(CONFIG_64BIT) && !defined(CONFIG_BUILD_ELF64)
+#ifdef CONFIG_64BIT_BUILD_ELF32
 #define __pa_page_offset(x)	((unsigned long)(x) < CKSEG0 ? PAGE_OFFSET : CKSEG0)
 #else
 #define __pa_page_offset(x)	PAGE_OFFSET
diff --git a/include/asm-mips/pgtable-64.h b/include/asm-mips/pgtable-64.h
index a5b1871..55be7b5 100644
--- a/include/asm-mips/pgtable-64.h
+++ b/include/asm-mips/pgtable-64.h
@@ -104,7 +104,7 @@
 #define VMALLOC_START		MAP_BASE
 #define VMALLOC_END	\
 	(VMALLOC_START + PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE)
-#if defined(CONFIG_MODULES) && !defined(CONFIG_BUILD_ELF64) && \
+#if defined(CONFIG_MODULES) && defined(CONFIG_64BIT_BUILD_ELF32) && \
 	VMALLOC_START != CKSSEG
 /* Load modules into 32bit-compatible segment. */
 #define MODULE_START	CKSSEG
diff --git a/include/asm-mips/stackframe.h b/include/asm-mips/stackframe.h
index 1fae5dc..917ffa5 100644
--- a/include/asm-mips/stackframe.h
+++ b/include/asm-mips/stackframe.h
@@ -70,14 +70,14 @@
 #else
 		MFC0	k0, CP0_CONTEXT
 #endif
-#if defined(CONFIG_BUILD_ELF64) || (defined(CONFIG_64BIT) && __GNUC__ < 4)
+#if defined(CONFIG_32BIT) || defined(CONFIG_64BIT_BUILD_ELF32)
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
+#if defined(CONFIG_32BIT) || defined(CONFIG_64BIT_BUILD_ELF32)
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
