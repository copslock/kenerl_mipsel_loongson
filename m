Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2012 22:56:32 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:42846 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903736Ab2EXU4A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 May 2012 22:56:00 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SXf4c-0003sB-5V; Thu, 24 May 2012 15:55:54 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 1/4] MIPS: Optimise core library function 'memset' for microMIPS.
Date:   Thu, 24 May 2012 15:55:39 -0500
Message-Id: <1337892942-24492-2-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1337892942-24492-1-git-send-email-sjhill@mips.com>
References: <1337892942-24492-1-git-send-email-sjhill@mips.com>
X-archive-position: 33461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Optimise 'memset' to use microMIPS instructions and/or optimisations
for binary size reduction. When the microMIPS ISA is not being used,
the library function compiles to the original binary code.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/asm.h |    2 ++
 arch/mips/lib/memset.S      |   84 +++++++++++++++++++++++++++----------------
 2 files changed, 56 insertions(+), 30 deletions(-)

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
-- 
1.7.10
