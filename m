Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Mar 2007 23:19:36 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:24195 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022972AbXCYWTe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 25 Mar 2007 23:19:34 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2PMJLZ6032269;
	Sun, 25 Mar 2007 23:19:21 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2PMJJwq032267;
	Sun, 25 Mar 2007 23:19:19 +0100
Date:	Sun, 25 Mar 2007 23:19:19 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kumba <kumba@gentoo.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	ths@networkno.de
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
Message-ID: <20070325221919.GA12088@linux-mips.org>
References: <20070324.234727.25910303.anemo@mba.ocn.ne.jp> <20070324231602.GP2311@networkno.de> <46062400.8080307@gentoo.org> <20070326.011000.75185255.anemo@mba.ocn.ne.jp> <4606AA74.3070907@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4606AA74.3070907@gentoo.org>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Mar 25, 2007 at 12:59:32PM -0400, Kumba wrote:

> Atsushi Nemoto wrote:
> >I can not see why you handle IP22, IP32, Cobalt as so "special".
> >There are many other platforms which supports 64-bit and uses CKSEG0
> >load address (well, actually all 64-bit platforms except for IP27).
> 
> Mainly because, to the best of my knowledge, these are the only three 
> systems where things get weird with ckseg0 and this specific Kconfig 
> option.  Afaik with other systems, they don't need weird hacks like 
> stuffing 64bit code into 32bit objects to work best (or at all).
> 
> 
> >So I think Franck's approach, which enables -msym32 and defines
> >KBUILD_64BIT_SYM32 automatically if load-y was CKSEG0, is better.  Are
> >there any problem with his patchset?
> 
> I missed the other two additions to this patch, which is probably why it 
> didn't work :)  Taken as a whole, they also boot my O2 now.

Well, how about this solution that solve the whole thing entirely with
Kconfig?

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 0253584..6283fd2 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2072,20 +2072,9 @@ source "fs/Kconfig.binfmt"
 config TRAD_SIGNALS
 	bool
 
-config BUILD_ELF64
-	bool "Use 64-bit ELF format for building"
-	depends on 64BIT
-	help
-	  A 64-bit kernel is usually built using the 64-bit ELF binary object
-	  format as it's one that allows arbitrary 64-bit constructs.  For
-	  kernels that are loaded within the KSEG compatibility segments the
-	  32-bit ELF format can optionally be used resulting in a somewhat
-	  smaller binary, but this option is not explicitly supported by the
-	  toolchain and since binutils 2.14 it does not even work at all.
-
-	  Say Y to use the 64-bit format or N to use the 32-bit one.
-
-	  If unsure say Y.
+config KERNEL_LOADS_IN_CKSEG0
+	bool
+	default y if (SYS_SUPPORTS_32BIT_KERNEL || SGI_IP32 || SGI_IP27) && 64BIT
 
 config BINFMT_IRIX
 	bool "Include IRIX binary compatibility"
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 92bca6a..d31f2d1 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -60,10 +60,10 @@ vmlinux-32		= vmlinux.32
 vmlinux-64		= vmlinux
 
 cflags-y		+= -mabi=64
-ifdef CONFIG_BUILD_ELF64
-cflags-y		+= $(call cc-option,-mno-explicit-relocs)
-else
+ifdef CONFIG_KERNEL_LOADS_IN_CKSEG0
 cflags-y		+= $(call cc-option,-msym32)
+else
+cflags-y		+= $(call cc-option,-mno-explicit-relocs)
 endif
 endif
 
diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
index 4713a13..abb0b48 100644
--- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -279,7 +279,7 @@ CONFIG_MMU=y
 #
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-# CONFIG_BUILD_ELF64 is not set
+CONFIG_KERNEL_LOADS_IN_CKSEG0=y
 CONFIG_MIPS32_COMPAT=y
 CONFIG_COMPAT=y
 CONFIG_SYSVIPC_COMPAT=y
diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index 9ddc3ef..ea625b7 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -272,7 +272,7 @@ CONFIG_MMU=y
 #
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-# CONFIG_BUILD_ELF64 is not set
+CONFIG_KERNEL_LOADS_IN_CKSEG0=y
 CONFIG_MIPS32_COMPAT=y
 CONFIG_COMPAT=y
 CONFIG_SYSVIPC_COMPAT=y
diff --git a/arch/mips/configs/ip32_defconfig b/arch/mips/configs/ip32_defconfig
index 8fc1880..d8b8c8f 100644
--- a/arch/mips/configs/ip32_defconfig
+++ b/arch/mips/configs/ip32_defconfig
@@ -252,7 +252,7 @@ CONFIG_MMU=y
 #
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=y
-# CONFIG_BUILD_ELF64 is not set
+CONFIG_KERNEL_LOADS_IN_CKSEG0=y
 CONFIG_MIPS32_COMPAT=y
 CONFIG_COMPAT=y
 CONFIG_SYSVIPC_COMPAT=y
diff --git a/arch/mips/configs/ocelot_c_defconfig b/arch/mips/configs/ocelot_c_defconfig
index 82ff6fc..16b4b63 100644
--- a/arch/mips/configs/ocelot_c_defconfig
+++ b/arch/mips/configs/ocelot_c_defconfig
@@ -250,7 +250,7 @@ CONFIG_MMU=y
 #
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-# CONFIG_BUILD_ELF64 is not set
+CONFIG_KERNEL_LOADS_IN_CKSEG0=y
 CONFIG_MIPS32_COMPAT=y
 CONFIG_COMPAT=y
 CONFIG_SYSVIPC_COMPAT=y
diff --git a/arch/mips/configs/sb1250-swarm_defconfig b/arch/mips/configs/sb1250-swarm_defconfig
index 6c4f09a..0664e3f 100644
--- a/arch/mips/configs/sb1250-swarm_defconfig
+++ b/arch/mips/configs/sb1250-swarm_defconfig
@@ -281,7 +281,7 @@ CONFIG_MMU=y
 #
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-# CONFIG_BUILD_ELF64 is not set
+CONFIG_KERNEL_LOADS_IN_CKSEG0=y
 CONFIG_MIPS32_COMPAT=y
 CONFIG_COMPAT=y
 CONFIG_SYSVIPC_COMPAT=y
diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index d3fbd83..266542a 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -149,7 +149,7 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 /*
  * __pa()/__va() should be used only during mem init.
  */
-#if defined(CONFIG_64BIT) && !defined(CONFIG_BUILD_ELF64)
+#if defined(CONFIG_64BIT) && defined(CONFIG_KERNEL_LOADS_IN_CKSEG0)
 #define __pa_page_offset(x)	((unsigned long)(x) < CKSEG0 ? PAGE_OFFSET : CKSEG0)
 #else
 #define __pa_page_offset(x)	PAGE_OFFSET
diff --git a/include/asm-mips/pgtable-64.h b/include/asm-mips/pgtable-64.h
index 49f5a1a..96c8927 100644
--- a/include/asm-mips/pgtable-64.h
+++ b/include/asm-mips/pgtable-64.h
@@ -104,7 +104,7 @@
 #define VMALLOC_START		MAP_BASE
 #define VMALLOC_END	\
 	(VMALLOC_START + PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE)
-#if defined(CONFIG_MODULES) && !defined(CONFIG_BUILD_ELF64) && \
+#if defined(CONFIG_MODULES) && defined(CONFIG_KERNEL_LOADS_IN_CKSEG0) && \
 	VMALLOC_START != CKSSEG
 /* Load modules into 32bit-compatible segment. */
 #define MODULE_START	CKSSEG
diff --git a/include/asm-mips/stackframe.h b/include/asm-mips/stackframe.h
index 7afa1fd..9ea32c9 100644
--- a/include/asm-mips/stackframe.h
+++ b/include/asm-mips/stackframe.h
@@ -79,7 +79,7 @@
 #else
 		MFC0	k0, CP0_CONTEXT
 #endif
-#if defined(CONFIG_BUILD_ELF64) || (defined(CONFIG_64BIT) && __GNUC__ < 4)
+#if !defined(CONFIG_KERNEL_LOADS_IN_CKSEG0) || (defined(CONFIG_64BIT) && __GNUC__ < 4)
 		lui	k1, %highest(kernelsp)
 		daddiu	k1, %higher(kernelsp)
 		dsll	k1, 16
@@ -104,7 +104,7 @@
 		.endm
 #else
 		.macro	get_saved_sp	/* Uniprocessor variation */
-#if defined(CONFIG_BUILD_ELF64) || (defined(CONFIG_64BIT) && __GNUC__ < 4)
+#if !defined(CONFIG_KERNEL_LOADS_IN_CKSEG0) || (defined(CONFIG_64BIT) && __GNUC__ < 4)
 		lui	k1, %highest(kernelsp)
 		daddiu	k1, %higher(kernelsp)
 		dsll	k1, k1, 16
