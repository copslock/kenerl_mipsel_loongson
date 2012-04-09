Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2012 17:23:34 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:39798 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903631Ab2DIPWZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2012 17:22:25 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SHGQ7-0005vf-5L; Mon, 09 Apr 2012 10:22:19 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 2/9] MIPS: Optimise core library functions for microMIPS.
Date:   Mon,  9 Apr 2012 10:21:56 -0500
Message-Id: <1333984923-445-3-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.6
In-Reply-To: <1333984923-445-1-git-send-email-sjhill@mips.com>
References: <1333984923-445-1-git-send-email-sjhill@mips.com>
X-archive-position: 32894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Optimise some of the core library functions to use microMIPS
instructions for binary size reduction. When the microMIPS ISA
is not being used, the library functions compiled to binary
are identical.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/page.h |    6 +++
 arch/mips/lib/memcpy.S       |   17 ++++++--
 arch/mips/lib/memset.S       |   90 ++++++++++++++++++++++++++++++------------
 arch/mips/lib/strlen_user.S  |   13 ++++--
 arch/mips/lib/strncpy_user.S |   39 +++++++++---------
 arch/mips/lib/strnlen_user.S |   24 ++++++++---
 arch/mips/mm/page.c          |   26 ++++++------
 7 files changed, 147 insertions(+), 68 deletions(-)

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index da9bd7d..5767678 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -45,6 +45,12 @@
 #define HUGETLB_PAGE_ORDER	({BUILD_BUG(); 0; })
 #endif /* CONFIG_HUGETLB_PAGE */
 
+/*
+ * Clear and copy array sizes for micro-assembly of clear_page/copy_page.
+ */
+#define CLEAR_PAGE_ARRAY_SIZE	288
+#define COPY_PAGE_ARRAY_SIZE	1344
+
 #ifndef __ASSEMBLY__
 
 #include <linux/pfn.h>
diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index 56a1f85..0fa4617 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -10,6 +10,7 @@
  * Copyright (C) 2002 Broadcom, Inc.
  *   memcpy/copy_user author: Mark Vandevoorde
  * Copyright (C) 2007  Maciej W. Rozycki
+ * Copyright (C) 2011  MIPS Technologies, Inc.
  *
  * Mnemonic names for arguments to memcpy/__copy_user
  */
@@ -21,16 +22,14 @@
  * end of memory on some systems.  It's also a seriously bad idea on non
  * dma-coherent systems.
  */
-#ifdef CONFIG_DMA_NONCOHERENT
-#undef CONFIG_CPU_HAS_PREFETCH
-#endif
-#ifdef CONFIG_MIPS_MALTA
+#if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_MIPS_MALTA)
 #undef CONFIG_CPU_HAS_PREFETCH
 #endif
 
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/regdef.h>
+#include <asm/page.h>
 
 #define dst a0
 #define src a1
@@ -564,3 +563,13 @@ LEAF(__rmemcpy)					/* a0=dst a1=src a2=len */
 	jr	ra
 	 move	a2, zero
 	END(__rmemcpy)
+
+LEAF(clear_page)
+1:	j	1b		/* Dummy, will be replaced. */
+	.space CLEAR_PAGE_ARRAY_SIZE
+	END(clear_page)
+
+LEAF(copy_page)
+1:	j	1b		/* Dummy, will be replaced. */
+	.space COPY_PAGE_ARRAY_SIZE
+	END(copy_page)
diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 606c8a9..a0df003 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -5,7 +5,8 @@
  *
  * Copyright (C) 1998, 1999, 2000 by Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
- * Copyright (C) 2007  Maciej W. Rozycki
+ * Copyright (C) 2007 by Maciej W. Rozycki
+ * Copyright (C) 2011 MIPS Technologies, Inc.
  */
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
@@ -19,6 +20,14 @@
 #define LONG_S_R sdr
 #endif
 
+#ifdef CONFIG_CPU_MICROMIPS
+#define STORSIZE (LONGSIZE * 2)
+#define STORMASK (STORSIZE - 1)
+#else
+#define STORSIZE LONGSIZE
+#define STORMASK LONGMASK
+#endif
+
 #define EX(insn,reg,addr,handler)			\
 9:	insn	reg, addr;				\
 	.section __ex_table,"a"; 			\
@@ -26,23 +35,36 @@
 	.previous
 
 	.macro	f_fill64 dst, offset, val, fixup
-	EX(LONG_S, \val, (\offset +  0 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset +  1 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset +  2 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset +  3 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset +  4 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset +  5 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset +  6 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset +  7 * LONGSIZE)(\dst), \fixup)
+#ifdef CONFIG_CPU_MICROMIPS
+	EX(swp, t8, (\offset + 0 * STORSIZE)(\dst), \fixup)
+	EX(swp, t8, (\offset + 1 * STORSIZE)(\dst), \fixup)
+	EX(swp, t8, (\offset + 2 * STORSIZE)(\dst), \fixup)
+	EX(swp, t8, (\offset + 3 * STORSIZE)(\dst), \fixup)
+#if LONGSIZE == 4
+	EX(swp, t8, (\offset + 4 * STORSIZE)(\dst), \fixup)
+	EX(swp, t8, (\offset + 5 * STORSIZE)(\dst), \fixup)
+	EX(swp, t8, (\offset + 6 * STORSIZE)(\dst), \fixup)
+	EX(swp, t8, (\offset + 7 * STORSIZE)(\dst), \fixup)
+#endif
+#else
+	EX(LONG_S, \val, (\offset +  0 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset +  1 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset +  2 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset +  3 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset +  4 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset +  5 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset +  6 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset +  7 * STORSIZE)(\dst), \fixup)
 #if LONGSIZE == 4
-	EX(LONG_S, \val, (\offset +  8 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset +  9 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset + 10 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset + 11 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset + 12 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset + 13 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset + 14 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset + 15 * LONGSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset +  8 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset +  9 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset + 10 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset + 11 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset + 12 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset + 13 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset + 14 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset + 15 * STORSIZE)(\dst), \fixup)
+#endif
 #endif
 	.endm
 
@@ -71,16 +93,20 @@ LEAF(memset)
 1:
 
 FEXPORT(__bzero)
-	sltiu		t0, a2, LONGSIZE	/* very small region? */
+	sltiu		t0, a2, STORSIZE	/* very small region? */
 	bnez		t0, .Lsmall_memset
-	 andi		t0, a0, LONGMASK	/* aligned? */
+	 andi		t0, a0, STORMASK	/* aligned? */
 
+#ifdef CONFIG_CPU_MICROMIPS
+	move		t8, a1
+	move		t9, a1
+#endif
 #ifndef CONFIG_CPU_DADDI_WORKAROUNDS
 	beqz		t0, 1f
-	 PTR_SUBU	t0, LONGSIZE		/* alignment in bytes */
+	 PTR_SUBU	t0, STORSIZE		/* alignment in bytes */
 #else
 	.set		noat
-	li		AT, LONGSIZE
+	li		AT, STORSIZE
 	beqz		t0, 1f
 	 PTR_SUBU	t0, AT			/* alignment in bytes */
 	.set		at
@@ -99,7 +125,7 @@ FEXPORT(__bzero)
 1:	ori		t1, a2, 0x3f		/* # of full blocks */
 	xori		t1, 0x3f
 	beqz		t1, .Lmemset_partial	/* no block to fill */
-	 andi		t0, a2, 0x40-LONGSIZE
+	 andi		t0, a2, 0x40-STORSIZE
 
 	PTR_ADDU	t1, a0			/* end address */
 	.set		reorder
@@ -112,14 +138,26 @@ FEXPORT(__bzero)
 .Lmemset_partial:
 	R10KCBARRIER(0(ra))
 	PTR_LA		t1, 2f			/* where to start */
+#ifdef CONFIG_CPU_MICROMIPS
+	LONG_SRL	t7, t0, 1
+#if LONGSIZE == 4
+	PTR_SUBU	t1, t7
+#else
+	.set		noat
+	LONG_SRL	AT, t7, 1
+	PTR_SUBU	t1, AT
+	.set		at
+#endif
+#else
 #if LONGSIZE == 4
 	PTR_SUBU	t1, t0
 #else
 	.set		noat
-	LONG_SRL		AT, t0, 1
+	LONG_SRL	AT, t0, 1
 	PTR_SUBU	t1, AT
 	.set		at
 #endif
+#endif
 	jr		t1
 	 PTR_ADDU	a0, t0			/* dest ptr */
 
@@ -128,7 +166,7 @@ FEXPORT(__bzero)
 	.set		nomacro
 	f_fill64 a0, -64, a1, .Lpartial_fixup	/* ... but first do longs ... */
 2:	.set		pop
-	andi		a2, LONGMASK		/* At most one long to go */
+	andi		a2, STORMASK		/* At most one long to go */
 
 	beqz		a2, 1f
 	 PTR_ADDU	a0, a2			/* What's left */
@@ -169,7 +207,7 @@ FEXPORT(__bzero)
 
 .Lpartial_fixup:
 	PTR_L		t0, TI_TASK($28)
-	andi		a2, LONGMASK
+	andi		a2, STORMASK
 	LONG_L		t0, THREAD_BUADDR(t0)
 	LONG_ADDU	a2, t1
 	jr		ra
@@ -177,4 +215,4 @@ FEXPORT(__bzero)
 
 .Llast_fixup:
 	jr		ra
-	 andi		v1, a2, LONGMASK
+	 andi		v1, a2, STORMASK
diff --git a/arch/mips/lib/strlen_user.S b/arch/mips/lib/strlen_user.S
index fdbb970..60fa23b 100644
--- a/arch/mips/lib/strlen_user.S
+++ b/arch/mips/lib/strlen_user.S
@@ -3,8 +3,9 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (c) 1996, 1998, 1999, 2004 by Ralf Baechle
- * Copyright (c) 1999 Silicon Graphics, Inc.
+ * Copyright (C) 1996, 1998, 1999, 2004 by Ralf Baechle
+ * Copyright (C) 1999 Silicon Graphics, Inc.
+ * Copyright (C) 2011 MIPS Technologies, Inc.
  */
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
@@ -28,9 +29,13 @@ LEAF(__strlen_user_asm)
 
 FEXPORT(__strlen_user_nocheck_asm)
 	move		v0, a0
-1:	EX(lb, t0, (v0), .Lfault)
+#ifdef CONFIG_CPU_MICROMIPS
+1:	EX(lbu16, v1, (v0), .Lfault)
+#else
+1:	EX(lb, v1, (v0), .Lfault)
+#endif
 	PTR_ADDIU	v0, 1
-	bnez		t0, 1b
+	bnez		v1, 1b
 	PTR_SUBU	v0, a0
 	jr		ra
 	END(__strlen_user_asm)
diff --git a/arch/mips/lib/strncpy_user.S b/arch/mips/lib/strncpy_user.S
index 7201b2f..bcbb9a0 100644
--- a/arch/mips/lib/strncpy_user.S
+++ b/arch/mips/lib/strncpy_user.S
@@ -3,7 +3,8 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (c) 1996, 1999 by Ralf Baechle
+ * Copyright (C) 1996, 1999 by Ralf Baechle
+ * Copyright (C) 2011 MIPS Technologies, Inc.
  */
 #include <linux/errno.h>
 #include <asm/asm.h>
@@ -30,30 +31,32 @@
 LEAF(__strncpy_from_user_asm)
 	LONG_L		v0, TI_ADDR_LIMIT($28)	# pointer ok?
 	and		v0, a1
+#ifdef CONFIG_CPU_MICROMIPS
+	bnezc		v0, .Lfault
+#else
 	bnez		v0, .Lfault
+#endif
 
 FEXPORT(__strncpy_from_user_nocheck_asm)
-	move		v0, zero
-	move		v1, a1
 	.set		noreorder
-1:	EX(lbu, t0, (v1), .Lfault)
+	move		t0, zero
+	move		v1, a1
+1:	EX(lbu, v0, (v1), .Lfault)
 	PTR_ADDIU	v1, 1
 	R10KCBARRIER(0(ra))
-	beqz		t0, 2f
-	 sb		t0, (a0)
-	PTR_ADDIU	v0, 1
-	.set		reorder
-	PTR_ADDIU	a0, 1
-	bne		v0, a2, 1b
-2:	PTR_ADDU	t0, a1, v0
-	xor		t0, a1
-	bltz		t0, .Lfault
+	beqz		v0, 2f
+	 sb		v0, (a0)
+	PTR_ADDIU	t0, 1
+	bne		t0, a2, 1b
+	 PTR_ADDIU	a0, 1
+2:	PTR_ADDU	v0, a1, t0
+	xor		v0, a1
+	bltz		v0, .Lfault
+	 nop
 	jr		ra			# return n
+	move		v0, t0
 	END(__strncpy_from_user_asm)
 
-.Lfault:	li		v0, -EFAULT
+.Lfault:
 	jr		ra
-
-	.section	__ex_table,"a"
-	PTR		1b, .Lfault
-	.previous
+	 li		v0, -EFAULT
diff --git a/arch/mips/lib/strnlen_user.S b/arch/mips/lib/strnlen_user.S
index 6445716..9090ced 100644
--- a/arch/mips/lib/strnlen_user.S
+++ b/arch/mips/lib/strnlen_user.S
@@ -5,6 +5,7 @@
  *
  * Copyright (c) 1996, 1998, 1999, 2004 by Ralf Baechle
  * Copyright (c) 1999 Silicon Graphics, Inc.
+ * Copyright (C) 2011 MIPS Technologies, Inc.
  */
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
@@ -26,21 +27,34 @@
  *       the maximum is a tad hairier ...
  */
 LEAF(__strnlen_user_asm)
+	.set	noreorder
 	LONG_L		v0, TI_ADDR_LIMIT($28)	# pointer ok?
 	and		v0, a0
+#ifdef CONFIG_CPU_MICROMIPS
+	bnezc		v0, .Lfault
+#else
 	bnez		v0, .Lfault
+#endif
 
 FEXPORT(__strnlen_user_nocheck_asm)
-	move		v0, a0
 	PTR_ADDU	a1, a0			# stop pointer
+	move		v0, a0
 1:	beq		v0, a1, 1f		# limit reached?
+	 nop
 	EX(lb, t0, (v0), .Lfault)
-	PTR_ADDU	v0, 1
+#ifdef CONFIG_CPU_MICROMIPS
+	addius5		v0, 1
+	bnezc		t0, 1b
+1:	jr		ra
+	PTR_SUBU	v0, a0
+#else
 	bnez		t0, 1b
-1:	PTR_SUBU	v0, a0
-	jr		ra
+	PTR_ADDU	v0, 1
+1:      jr              ra
+	PTR_SUBU        v0, a0
+#endif
 	END(__strnlen_user_asm)
 
 .Lfault:
-	move		v0, zero
 	jr		ra
+	move		v0, zero
diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
index cc0b626..be71d38 100644
--- a/arch/mips/mm/page.c
+++ b/arch/mips/mm/page.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2003, 04, 05 Ralf Baechle (ralf@linux-mips.org)
  * Copyright (C) 2007  Maciej W. Rozycki
  * Copyright (C) 2008  Thiemo Seufer
+ * Copyright (C) 2011  MIPS Technologies, Inc.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -79,17 +80,12 @@ static struct uasm_reloc __cpuinitdata relocs[5];
  * R4600 v2.0:				0x060 bytes
  * With prefetching, 16 word strides	0x120 bytes
  */
-
-static u32 clear_page_array[0x120 / 4];
+u32 clear_page_array[CLEAR_PAGE_ARRAY_SIZE / 4];
 
 #ifdef CONFIG_SIBYTE_DMA_PAGEOPS
 void clear_page_cpu(void *page) __attribute__((alias("clear_page_array")));
-#else
-void clear_page(void *page) __attribute__((alias("clear_page_array")));
 #endif
 
-EXPORT_SYMBOL(clear_page);
-
 /*
  * Maximum sizes:
  *
@@ -98,17 +94,13 @@ EXPORT_SYMBOL(clear_page);
  * R4600 v2.0:				0x07c bytes
  * With prefetching, 16 word strides	0x540 bytes
  */
-static u32 copy_page_array[0x540 / 4];
+u32 copy_page_array[COPY_PAGE_ARRAY_SIZE / 4];
 
 #ifdef CONFIG_SIBYTE_DMA_PAGEOPS
 void
 copy_page_cpu(void *to, void *from) __attribute__((alias("copy_page_array")));
-#else
-void copy_page(void *to, void *from) __attribute__((alias("copy_page_array")));
 #endif
 
-EXPORT_SYMBOL(copy_page);
-
 
 static int pref_bias_clear_store __cpuinitdata;
 static int pref_bias_copy_load __cpuinitdata;
@@ -368,6 +360,12 @@ void __cpuinit build_clear_page(void)
 	for (i = 0; i < (buf - clear_page_array); i++)
 		pr_debug("\t.word 0x%08x\n", clear_page_array[i]);
 	pr_debug("\t.set pop\n");
+#ifdef CONFIG_CPU_MICROMIPS
+	memcpy(((u8 *)clear_page) - 1, clear_page_array,
+		ARRAY_SIZE(clear_page_array) * 4);
+#else
+	memcpy(clear_page, clear_page_array, ARRAY_SIZE(clear_page_array) * 4);
+#endif
 }
 
 static void __cpuinit build_copy_load(u32 **buf, int reg, int off)
@@ -607,6 +605,12 @@ void __cpuinit build_copy_page(void)
 	for (i = 0; i < (buf - copy_page_array); i++)
 		pr_debug("\t.word 0x%08x\n", copy_page_array[i]);
 	pr_debug("\t.set pop\n");
+#ifdef CONFIG_CPU_MICROMIPS
+	memcpy(((u8 *)copy_page) - 1, copy_page_array,
+		ARRAY_SIZE(copy_page_array) * 4);
+#else
+	memcpy(copy_page, copy_page_array, ARRAY_SIZE(copy_page_array) * 4);
+#endif
 }
 
 #ifdef CONFIG_SIBYTE_DMA_PAGEOPS
-- 
1.7.9.6
