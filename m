Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Mar 2007 08:26:40 +0100 (BST)
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:60362 "EHLO
	rwcrmhc11.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20021688AbXCYH0i (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 25 Mar 2007 08:26:38 +0100
Received: from [192.168.1.4] (c-69-251-93-234.hsd1.md.comcast.net[69.251.93.234])
          by comcast.net (rwcrmhc11) with ESMTP
          id <20070325072553m11004bp7ie>; Sun, 25 Mar 2007 07:25:53 +0000
Message-ID: <46062400.8080307@gentoo.org>
Date:	Sun, 25 Mar 2007 03:25:52 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0b2 (Windows/20070116)
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
CC:	Thiemo Seufer <ths@networkno.de>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
References: <4603DA74.70707@gentoo.org> <20070324.002440.93023010.anemo@mba.ocn.ne.jp> <46049BAD.1010705@gentoo.org> <20070324.234727.25910303.anemo@mba.ocn.ne.jp> <20070324231602.GP2311@networkno.de>
In-Reply-To: <20070324231602.GP2311@networkno.de>
Content-Type: multipart/mixed;
 boundary="------------080501090809020705040605"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------080501090809020705040605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Thiemo Seufer wrote:
>> The replacement is CONFIG_BUILD_ELF64=n (it adds -msym32 option) +
>> CONFIG_BOOT_ELF32=y (it adds vmlinux.32 to "all" target).  Not
>> CONFIG_BUILD_ELF64=y.
>>
>> CONFIG_BUILD_ELF64=n enables -msym32 option, which means the kernel
>> load address should be CKSEG0.
> 
> This sounds wrong to me, since CONFIG_BUILD_ELF64=n will build a
> ELF64 kernel (from compiler/linker POV). This tricks people into
> believing they need no ELF64 capable toolchain for a 64bit kernel.
> 
> IMO -msym32 should depend on:
>     ((Compiler can do -msym32)
>      && (load address is in ckseg0)
>      && CONFIG_64BIT)
> 
> which obsoletes the whole CONFIG_BUILD_ELF* stuff.
> 
> 
> Thiemo

Going on this, I propose the following patch to fix our lovely SGI/Cobalt 
systems, and eliminate a confusing Kconfig option whose time is likely long 
since passed.  The attached patch achieves the following:

* Introduces a new flag for IP22, IP32, and Cobalt called 'kernel_loads_in_ckseg0'.
* Introduces a new header, mem-layout.h, in include/asm-mips/mach-<platform>/ 
for this flag for these three systems, and a dummy entry for mach-generic, 
calling it in where appropriate.
* Removes CONFIG_BUILD_ELF64 from Kconfig, Makefile, and several defconfigs, and 
replaces its few references in header files with 'kernel_loads_in_ckseg0', with 
appropriate flips in logic (except in stackframe.h).
* Includes Frank's patch to eliminate the need for -mno-explicit-relocs.
* Moves -msym32 calling to the Makefile locations for the three machines that 
actually need it.


--Kumba


Signed-off-by: Joshua Kinard <kumba@gentoo.org>

  arch/mips/Kconfig                          |   15 ---------------
  arch/mips/Makefile                         |   11 +++++------
  arch/mips/configs/bigsur_defconfig         |    1 -
  arch/mips/configs/ip27_defconfig           |    1 -
  arch/mips/configs/ip32_defconfig           |    1 -
  arch/mips/configs/ocelot_c_defconfig       |    1 -
  arch/mips/configs/sb1250-swarm_defconfig   |    1 -
  include/asm-mips/mach-cobalt/mem-layout.h  |    7 +++++++
  include/asm-mips/mach-generic/mem-layout.h |    7 +++++++
  include/asm-mips/mach-ip22/mem-layout.h    |    7 +++++++
  include/asm-mips/mach-ip32/mem-layout.h    |    7 +++++++
  include/asm-mips/page.h                    |    3 ++-
  include/asm-mips/pgtable-64.h              |    4 +++-
  include/asm-mips/stackframe.h              |    6 ++++--
  14 files changed, 42 insertions(+), 30 deletions(-)


--------------080501090809020705040605
Content-Type: text/plain;
 name="mips-fix-ckseg0-stuff.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mips-fix-ckseg0-stuff.patch"

diff -Naurp mipslinux/arch/mips/Kconfig mipslinux.ckseg0/arch/mips/Kconfig
--- mipslinux/arch/mips/Kconfig	2007-03-17 21:12:06.000000000 -0400
+++ mipslinux.ckseg0/arch/mips/Kconfig	2007-03-25 02:03:06.000000000 -0400
@@ -2072,21 +2072,6 @@ source "fs/Kconfig.binfmt"
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
-
 config BINFMT_IRIX
 	bool "Include IRIX binary compatibility"
 	depends on CPU_BIG_ENDIAN && 32BIT && BROKEN
diff -Naurp mipslinux/arch/mips/Makefile mipslinux.ckseg0/arch/mips/Makefile
--- mipslinux/arch/mips/Makefile	2007-03-17 21:12:06.000000000 -0400
+++ mipslinux.ckseg0/arch/mips/Makefile	2007-03-25 02:15:22.000000000 -0400
@@ -60,11 +60,6 @@ vmlinux-32		= vmlinux.32
 vmlinux-64		= vmlinux
 
 cflags-y		+= -mabi=64
-ifdef CONFIG_BUILD_ELF64
-cflags-y		+= $(call cc-option,-mno-explicit-relocs)
-else
-cflags-y		+= $(call cc-option,-msym32)
-endif
 endif
 
 
@@ -271,6 +266,9 @@ load-$(CONFIG_MIPS_XXS1500)	+= 0xfffffff
 #
 core-$(CONFIG_MIPS_COBALT)	+= arch/mips/cobalt/
 cflags-$(CONFIG_MIPS_COBALT)	+= -Iinclude/asm-mips/mach-cobalt
+ifdef CONFIG_64BIT
+cflags-$(CONFIG_MIPS_COBALT)	+= $(call cc-option,-msym32)
+endif
 load-$(CONFIG_MIPS_COBALT)	+= 0xffffffff80080000
 
 #
@@ -494,6 +492,7 @@ ifdef CONFIG_32BIT
 load-$(CONFIG_SGI_IP22)		+= 0xffffffff88002000
 endif
 ifdef CONFIG_64BIT
+cflags-$(CONFIG_SGI_IP22)	+= $(call cc-option,-msym32)
 load-$(CONFIG_SGI_IP22)		+= 0xffffffff88004000
 endif
 
@@ -526,7 +525,7 @@ endif
 # will break.
 #
 core-$(CONFIG_SGI_IP32)		+= arch/mips/sgi-ip32/
-cflags-$(CONFIG_SGI_IP32)	+= -Iinclude/asm-mips/mach-ip32
+cflags-$(CONFIG_SGI_IP32)	+= -Iinclude/asm-mips/mach-ip32 $(call cc-option,-msym32)
 load-$(CONFIG_SGI_IP32)		+= 0xffffffff80004000
 
 #
diff -Naurp mipslinux/arch/mips/configs/bigsur_defconfig mipslinux.ckseg0/arch/mips/configs/bigsur_defconfig
--- mipslinux/arch/mips/configs/bigsur_defconfig	2007-03-17 21:12:06.000000000 -0400
+++ mipslinux.ckseg0/arch/mips/configs/bigsur_defconfig	2007-03-25 02:02:32.000000000 -0400
@@ -279,7 +279,6 @@ CONFIG_MMU=y
 #
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-# CONFIG_BUILD_ELF64 is not set
 CONFIG_MIPS32_COMPAT=y
 CONFIG_COMPAT=y
 CONFIG_SYSVIPC_COMPAT=y
diff -Naurp mipslinux/arch/mips/configs/ip27_defconfig mipslinux.ckseg0/arch/mips/configs/ip27_defconfig
--- mipslinux/arch/mips/configs/ip27_defconfig	2007-03-17 21:12:06.000000000 -0400
+++ mipslinux.ckseg0/arch/mips/configs/ip27_defconfig	2007-03-25 02:02:12.000000000 -0400
@@ -272,7 +272,6 @@ CONFIG_MMU=y
 #
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-# CONFIG_BUILD_ELF64 is not set
 CONFIG_MIPS32_COMPAT=y
 CONFIG_COMPAT=y
 CONFIG_SYSVIPC_COMPAT=y
diff -Naurp mipslinux/arch/mips/configs/ip32_defconfig mipslinux.ckseg0/arch/mips/configs/ip32_defconfig
--- mipslinux/arch/mips/configs/ip32_defconfig	2007-03-17 21:12:06.000000000 -0400
+++ mipslinux.ckseg0/arch/mips/configs/ip32_defconfig	2007-03-25 02:02:00.000000000 -0400
@@ -252,7 +252,6 @@ CONFIG_MMU=y
 #
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=y
-# CONFIG_BUILD_ELF64 is not set
 CONFIG_MIPS32_COMPAT=y
 CONFIG_COMPAT=y
 CONFIG_SYSVIPC_COMPAT=y
diff -Naurp mipslinux/arch/mips/configs/ocelot_c_defconfig mipslinux.ckseg0/arch/mips/configs/ocelot_c_defconfig
--- mipslinux/arch/mips/configs/ocelot_c_defconfig	2007-03-17 21:12:06.000000000 -0400
+++ mipslinux.ckseg0/arch/mips/configs/ocelot_c_defconfig	2007-03-25 02:01:50.000000000 -0400
@@ -250,7 +250,6 @@ CONFIG_MMU=y
 #
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-# CONFIG_BUILD_ELF64 is not set
 CONFIG_MIPS32_COMPAT=y
 CONFIG_COMPAT=y
 CONFIG_SYSVIPC_COMPAT=y
diff -Naurp mipslinux/arch/mips/configs/sb1250-swarm_defconfig mipslinux.ckseg0/arch/mips/configs/sb1250-swarm_defconfig
--- mipslinux/arch/mips/configs/sb1250-swarm_defconfig	2007-03-17 21:12:06.000000000 -0400
+++ mipslinux.ckseg0/arch/mips/configs/sb1250-swarm_defconfig	2007-03-25 02:02:22.000000000 -0400
@@ -281,7 +281,6 @@ CONFIG_MMU=y
 #
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-# CONFIG_BUILD_ELF64 is not set
 CONFIG_MIPS32_COMPAT=y
 CONFIG_COMPAT=y
 CONFIG_SYSVIPC_COMPAT=y
diff -Naurp mipslinux/include/asm-mips/mach-cobalt/mem-layout.h mipslinux.ckseg0/include/asm-mips/mach-cobalt/mem-layout.h
--- mipslinux/include/asm-mips/mach-cobalt/mem-layout.h	1969-12-31 19:00:00.000000000 -0500
+++ mipslinux.ckseg0/include/asm-mips/mach-cobalt/mem-layout.h	2007-03-25 03:13:13.000000000 -0400
@@ -0,0 +1,7 @@
+#ifndef __ASM_MACH_COBALT_MEM_LAYOUT_H
+#define __ASM_MACH_COBALT_MEM_LAYOUT_H
+
+
+#define kernel_loads_in_ckseg0		1
+
+#endif /* __ASM_MACH_COBALT_MEM_LAYOUT_H */
diff -Naurp mipslinux/include/asm-mips/mach-generic/mem-layout.h mipslinux.ckseg0/include/asm-mips/mach-generic/mem-layout.h
--- mipslinux/include/asm-mips/mach-generic/mem-layout.h	1969-12-31 19:00:00.000000000 -0500
+++ mipslinux.ckseg0/include/asm-mips/mach-generic/mem-layout.h	2007-03-25 03:20:05.000000000 -0400
@@ -0,0 +1,7 @@
+#ifndef __ASM_MACH_GENERIC_MEM_LAYOUT_H
+#define __ASM_MACH_GENERIC_MEM_LAYOUT_H
+
+
+#define kernel_loads_in_ckseg0		0
+
+#endif /* __ASM_MACH_GENERIC_MEM_LAYOUT_H */
diff -Naurp mipslinux/include/asm-mips/mach-ip22/mem-layout.h mipslinux.ckseg0/include/asm-mips/mach-ip22/mem-layout.h
--- mipslinux/include/asm-mips/mach-ip22/mem-layout.h	1969-12-31 19:00:00.000000000 -0500
+++ mipslinux.ckseg0/include/asm-mips/mach-ip22/mem-layout.h	2007-03-25 03:13:06.000000000 -0400
@@ -0,0 +1,7 @@
+#ifndef __ASM_MACH_IP22_MEM_LAYOUT_H
+#define __ASM_MACH_IP22_MEM_LAYOUT_H
+
+
+#define kernel_loads_in_ckseg0		1
+
+#endif /* __ASM_MACH_IP22_MEM_LAYOUT_H */
diff -Naurp mipslinux/include/asm-mips/mach-ip32/mem-layout.h mipslinux.ckseg0/include/asm-mips/mach-ip32/mem-layout.h
--- mipslinux/include/asm-mips/mach-ip32/mem-layout.h	1969-12-31 19:00:00.000000000 -0500
+++ mipslinux.ckseg0/include/asm-mips/mach-ip32/mem-layout.h	2007-03-25 03:13:01.000000000 -0400
@@ -0,0 +1,7 @@
+#ifndef __ASM_MACH_IP32_MEM_LAYOUT_H
+#define __ASM_MACH_IP32_MEM_LAYOUT_H
+
+
+#define kernel_loads_in_ckseg0		1
+
+#endif /* __ASM_MACH_IP32_MEM_LAYOUT_H */
diff -Naurp mipslinux/include/asm-mips/page.h mipslinux.ckseg0/include/asm-mips/page.h
--- mipslinux/include/asm-mips/page.h	2007-03-17 21:12:31.000000000 -0400
+++ mipslinux.ckseg0/include/asm-mips/page.h	2007-03-25 02:08:47.000000000 -0400
@@ -13,6 +13,7 @@
 #ifdef __KERNEL__
 
 #include <spaces.h>
+#include <mem-layout.h>
 
 /*
  * PAGE_SHIFT determines the page size
@@ -149,7 +150,7 @@ typedef struct { unsigned long pgprot; }
 /*
  * __pa()/__va() should be used only during mem init.
  */
-#if defined(CONFIG_64BIT) && !defined(CONFIG_BUILD_ELF64)
+#if defined(CONFIG_64BIT) && defined(kernel_loads_in_ckseg0)
 #define __pa_page_offset(x)	((unsigned long)(x) < CKSEG0 ? PAGE_OFFSET : CKSEG0)
 #else
 #define __pa_page_offset(x)	PAGE_OFFSET
diff -Naurp mipslinux/include/asm-mips/pgtable-64.h mipslinux.ckseg0/include/asm-mips/pgtable-64.h
--- mipslinux/include/asm-mips/pgtable-64.h	2007-03-25 01:16:58.000000000 -0400
+++ mipslinux.ckseg0/include/asm-mips/pgtable-64.h	2007-03-25 02:09:25.000000000 -0400
@@ -16,6 +16,8 @@
 #include <asm/cachectl.h>
 #include <asm/fixmap.h>
 
+#include <mem-layout.h>
+
 #include <asm-generic/pgtable-nopud.h>
 
 /*
@@ -104,7 +106,7 @@
 #define VMALLOC_START		MAP_BASE
 #define VMALLOC_END	\
 	(VMALLOC_START + PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE)
-#if defined(CONFIG_MODULES) && !defined(CONFIG_BUILD_ELF64) && \
+#if defined(CONFIG_MODULES) && defined(kernel_loads_in_ckseg0) && \
 	VMALLOC_START != CKSSEG
 /* Load modules into 32bit-compatible segment. */
 #define MODULE_START	CKSSEG
diff -Naurp mipslinux/include/asm-mips/stackframe.h mipslinux.ckseg0/include/asm-mips/stackframe.h
--- mipslinux/include/asm-mips/stackframe.h	2007-03-17 21:12:32.000000000 -0400
+++ mipslinux.ckseg0/include/asm-mips/stackframe.h	2007-03-25 03:00:25.000000000 -0400
@@ -17,6 +17,8 @@
 #include <asm/mipsregs.h>
 #include <asm/asm-offsets.h>
 
+#include <mem-layout.h>
+
 #ifdef CONFIG_MIPS_MT_SMTC
 #include <asm/mipsmtregs.h>
 #endif /* CONFIG_MIPS_MT_SMTC */
@@ -79,7 +81,7 @@
 #else
 		MFC0	k0, CP0_CONTEXT
 #endif
-#if defined(CONFIG_BUILD_ELF64) || (defined(CONFIG_64BIT) && __GNUC__ < 4)
+#if defined(kernel_loads_in_ckseg0) || (defined(CONFIG_64BIT) && __GNUC__ < 4)
 		lui	k1, %highest(kernelsp)
 		daddiu	k1, %higher(kernelsp)
 		dsll	k1, 16
@@ -104,7 +106,7 @@
 		.endm
 #else
 		.macro	get_saved_sp	/* Uniprocessor variation */
-#if defined(CONFIG_BUILD_ELF64) || (defined(CONFIG_64BIT) && __GNUC__ < 4)
+#if defined(kernel_loads_in_ckseg0) || (defined(CONFIG_64BIT) && __GNUC__ < 4)
 		lui	k1, %highest(kernelsp)
 		daddiu	k1, %higher(kernelsp)
 		dsll	k1, k1, 16

--------------080501090809020705040605--
