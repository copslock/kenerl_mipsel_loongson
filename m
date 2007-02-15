Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2007 13:23:36 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.237]:56480 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038920AbXBONX1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Feb 2007 13:23:27 +0000
Received: by qb-out-0506.google.com with SMTP id e12so148878qba
        for <linux-mips@linux-mips.org>; Thu, 15 Feb 2007 05:22:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=NMSH1oyzpFV1UO4tz6U3N/H6ROZZCl+tDD2+Z3/AlJJFzsBrEYJ2jnlft7ztDmnPsRCXl1HUtQ8IvqOgBBtkDtYjDHLTZpAUvdc+K85ViZTP3/V6T2o0+nSpzW1BWZIA/5iKWgZFwk7JiIqdzz8D6WoHuLH4yWeZUrzGfssg35c=
Received: by 10.64.210.3 with SMTP id i3mr2802457qbg.1171545746773;
        Thu, 15 Feb 2007 05:22:26 -0800 (PST)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id h1sm1132653nfe.2007.02.15.05.22.25;
        Thu, 15 Feb 2007 05:22:26 -0800 (PST)
Message-ID: <45D45E60.40207@innova-card.com>
Date:	Thu, 15 Feb 2007 14:21:36 +0100
Reply-To: franck.bui-huu@innova-card.com
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH 3/3] Rename CONFIG_BUILD_ELF64 into KBUILD_64BIT_SYM32
References: <11715446603241-git-send-email-fbuihuu@gmail.com>	 <1171544660166-git-send-email-fbuihuu@gmail.com>	 <11715446611812-git-send-email-fbuihuu@gmail.com> <cda58cb80702150514w76653104h2000f6b2c53b712f@mail.gmail.com>
In-Reply-To: <cda58cb80702150514w76653104h2000f6b2c53b712f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14103
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
 arch/mips/Makefile            |   12 +++++-------
 include/asm-mips/page.h       |    2 +-
 include/asm-mips/pgtable-64.h |    2 +-
 include/asm-mips/stackframe.h |   12 ++++++------
 4 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 2e9ae19..dcd9acc 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -615,19 +615,17 @@ endif
 # Automatically detect the build format. By default we choose
 # the elf format according to the load address.
 # We can always force a build with a 64-bits symbol format by
-# passing 'BUILD_ELF32=no' option to the make's command line.
+# passing 'KBUILD_SYM32=no' option to the make's command line.
 #
 ifdef CONFIG_64BIT
-  ifndef BUILD_ELF32
+  ifndef KBUILD_SYM32
     ifeq ($(shell expr $(load-y) \< 0xffffffff80000000), 0)
-      BUILD_ELF32 = y
+      KBUILD_SYM32 = y
     endif
   endif
 
-  ifeq ($(BUILD_ELF32), y)
-    cflags-y += -msym32
-  else
-    cflags-y += -DCONFIG_BUILD_ELF64
+  ifeq ($(KBUILD_SYM32), y)
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
