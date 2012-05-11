Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 07:30:58 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:34180 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903543Ab2EKFau (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2012 07:30:50 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SSiRA-0001oh-9b; Fri, 11 May 2012 00:30:44 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH v2,2/9] MIPS: Optimise core library functions for microMIPS.
Date:   Fri, 11 May 2012 00:30:39 -0500
Message-Id: <1336714239-31455-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
X-archive-position: 33244
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
 arch/mips/include/asm/asm.h  |    2 +
 arch/mips/include/asm/page.h |    6 +++
 arch/mips/lib/memcpy.S       |   17 +++++++--
 arch/mips/lib/memset.S       |   84 +++++++++++++++++++++++++++---------------
 arch/mips/lib/strlen_user.S  |    9 +++--
 arch/mips/lib/strncpy_user.S |   28 +++++++-------
 arch/mips/lib/strnlen_user.S |    2 +-
 7 files changed, 96 insertions(+), 52 deletions(-)

diff --git a/arch/mips/include/asm/asm.h b/arch/mips/include/asm/asm.h
index 608cfcf..604788f 100644
--- a/arch/mips/include/asm/asm.h
+++ b/arch/mips/include/asm/asm.h
@@ -296,6 +296,7 @@ symbol		=	value
 #define LONG_SUBU	subu
 #define LONG_L		lw
 #define LONG_S		sw
+#define LONG_SP		swp
 #define LONG_SLL	sll
 #define LONG_SLLV	sllv
 #define LONG_SRL	srl
@@ -318,6 +319,7 @@ symbol		=	value
 #define LONG_SUBU	dsubu
 #define LONG_L		ld
 #define LONG_S		sd
+#define LONG_SP		sdp
 #define LONG_SLL	dsll
 #define LONG_SLLV	dsllv
 #define LONG_SRL	dsrl
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
index 606c8a9..cf63df8 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -5,7 +5,8 @@
  *
  * Copyright (C) 1998, 1999, 2000 by Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
- * Copyright (C) 2007  Maciej W. Rozycki
+ * Copyright (C) 2007 by Maciej W. Rozycki
+ * Copyright (C) 2011, 2012 MIPS Technologies, Inc.
  */
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
@@ -19,6 +20,20 @@
 #define LONG_S_R sdr
 #endif
 
+#ifdef CONFIG_CPU_MICROMIPS
+#define STORSIZE (LONGSIZE * 2)
+#define STORMASK (STORSIZE - 1)
+#define FILL64RG t8
+#define FILLPTRG t7
+#undef  LONG_S
+#define LONG_S LONG_SP
+#else
+#define STORSIZE LONGSIZE
+#define STORMASK LONGMASK
+#define FILL64RG a1
+#define FILLPTRG t0
+#endif
+
 #define EX(insn,reg,addr,handler)			\
 9:	insn	reg, addr;				\
 	.section __ex_table,"a"; 			\
@@ -26,23 +41,25 @@
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
-#if LONGSIZE == 4
-	EX(LONG_S, \val, (\offset +  8 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset +  9 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset + 10 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset + 11 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset + 12 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset + 13 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset + 14 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset + 15 * LONGSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset +  0 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset +  1 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset +  2 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset +  3 * STORSIZE)(\dst), \fixup)
+#if ((defined(CONFIG_CPU_MICROMIPS) && (LONGSIZE == 4)) || !defined(CONFIG_CPU_MICROMIPS))
+	EX(LONG_S, \val, (\offset +  4 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset +  5 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset +  6 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset +  7 * STORSIZE)(\dst), \fixup)
+#endif
+#if (!defined(CONFIG_CPU_MICROMIPS) && (LONGSIZE == 4))
+	EX(LONG_S, \val, (\offset +  8 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset +  9 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset + 10 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset + 11 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset + 12 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset + 13 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset + 14 * STORSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset + 15 * STORSIZE)(\dst), \fixup)
 #endif
 	.endm
 
@@ -71,16 +88,20 @@ LEAF(memset)
 1:
 
 FEXPORT(__bzero)
-	sltiu		t0, a2, LONGSIZE	/* very small region? */
+	sltiu		t0, a2, STORSIZE	/* very small region? */
 	bnez		t0, .Lsmall_memset
-	 andi		t0, a0, LONGMASK	/* aligned? */
+	 andi		t0, a0, STORMASK	/* aligned? */
 
+#ifdef CONFIG_CPU_MICROMIPS
+	move		t8, a1			/* used by 'swp' instruction */
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
@@ -99,24 +120,27 @@ FEXPORT(__bzero)
 1:	ori		t1, a2, 0x3f		/* # of full blocks */
 	xori		t1, 0x3f
 	beqz		t1, .Lmemset_partial	/* no block to fill */
-	 andi		t0, a2, 0x40-LONGSIZE
+	 andi		t0, a2, 0x40-STORSIZE
 
 	PTR_ADDU	t1, a0			/* end address */
 	.set		reorder
 1:	PTR_ADDIU	a0, 64
 	R10KCBARRIER(0(ra))
-	f_fill64 a0, -64, a1, .Lfwd_fixup
+	f_fill64 a0, -64, FILL64RG, .Lfwd_fixup
 	bne		t1, a0, 1b
 	.set		noreorder
 
 .Lmemset_partial:
 	R10KCBARRIER(0(ra))
 	PTR_LA		t1, 2f			/* where to start */
+#ifdef CONFIG_CPU_MICROMIPS
+	LONG_SRL	t7, t0, 1
+#endif
 #if LONGSIZE == 4
-	PTR_SUBU	t1, t0
+	PTR_SUBU	t1, FILLPTRG
 #else
 	.set		noat
-	LONG_SRL		AT, t0, 1
+	LONG_SRL	AT, FILLPTRG, 1
 	PTR_SUBU	t1, AT
 	.set		at
 #endif
@@ -126,9 +150,9 @@ FEXPORT(__bzero)
 	.set		push
 	.set		noreorder
 	.set		nomacro
-	f_fill64 a0, -64, a1, .Lpartial_fixup	/* ... but first do longs ... */
+	f_fill64 a0, -64, FILL64RG, .Lpartial_fixup	/* ... but first do longs ... */
 2:	.set		pop
-	andi		a2, LONGMASK		/* At most one long to go */
+	andi		a2, STORMASK		/* At most one long to go */
 
 	beqz		a2, 1f
 	 PTR_ADDU	a0, a2			/* What's left */
@@ -169,7 +193,7 @@ FEXPORT(__bzero)
 
 .Lpartial_fixup:
 	PTR_L		t0, TI_TASK($28)
-	andi		a2, LONGMASK
+	andi		a2, STORMASK
 	LONG_L		t0, THREAD_BUADDR(t0)
 	LONG_ADDU	a2, t1
 	jr		ra
@@ -177,4 +201,4 @@ FEXPORT(__bzero)
 
 .Llast_fixup:
 	jr		ra
-	 andi		v1, a2, LONGMASK
+	 andi		v1, a2, STORMASK
diff --git a/arch/mips/lib/strlen_user.S b/arch/mips/lib/strlen_user.S
index fdbb970..e362dcd 100644
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
@@ -28,9 +29,9 @@ LEAF(__strlen_user_asm)
 
 FEXPORT(__strlen_user_nocheck_asm)
 	move		v0, a0
-1:	EX(lb, t0, (v0), .Lfault)
+1:	EX(lbu, v1, (v0), .Lfault)
 	PTR_ADDIU	v0, 1
-	bnez		t0, 1b
+	bnez		v1, 1b
 	PTR_SUBU	v0, a0
 	jr		ra
 	END(__strlen_user_asm)
diff --git a/arch/mips/lib/strncpy_user.S b/arch/mips/lib/strncpy_user.S
index 7201b2f..dea9304 100644
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
@@ -33,22 +34,23 @@ LEAF(__strncpy_from_user_asm)
 	bnez		v0, .Lfault
 
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
 
 .Lfault:	li		v0, -EFAULT
diff --git a/arch/mips/lib/strnlen_user.S b/arch/mips/lib/strnlen_user.S
index 6445716..c5bdf8b 100644
--- a/arch/mips/lib/strnlen_user.S
+++ b/arch/mips/lib/strnlen_user.S
@@ -35,7 +35,7 @@ FEXPORT(__strnlen_user_nocheck_asm)
 	PTR_ADDU	a1, a0			# stop pointer
 1:	beq		v0, a1, 1f		# limit reached?
 	EX(lb, t0, (v0), .Lfault)
-	PTR_ADDU	v0, 1
+	PTR_ADDIU	v0, 1
 	bnez		t0, 1b
 1:	PTR_SUBU	v0, a0
 	jr		ra
-- 
1.7.10
