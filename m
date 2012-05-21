Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2012 17:59:21 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:55509 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903646Ab2EUP7F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 May 2012 17:59:05 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SWV0d-0003TR-7z; Mon, 21 May 2012 10:58:59 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH v3,2/9] MIPS: Optimise core library functions for microMIPS.
Date:   Mon, 21 May 2012 10:58:55 -0500
Message-Id: <1337615935-30482-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
X-archive-position: 33405
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
 arch/mips/include/asm/asm.h          |    2 +
 arch/mips/include/asm/cpu-features.h |    3 ++
 arch/mips/include/asm/cpu.h          |    4 +-
 arch/mips/include/asm/page.h         |    6 +++
 arch/mips/kernel/cpu-probe.c         |   10 ++++
 arch/mips/lib/memcpy.S               |   17 +++++--
 arch/mips/lib/memset.S               |   84 ++++++++++++++++++++++------------
 arch/mips/lib/strlen_user.S          |    9 ++--
 arch/mips/lib/strncpy_user.S         |   28 ++++++------
 arch/mips/lib/strnlen_user.S         |    2 +-
 arch/mips/mm/c-r4k.c                 |    1 +
 arch/mips/mm/page.c                  |   26 ++++++-----
 arch/mips/mm/tlbex.c                 |    2 +
 arch/mips/oprofile/common.c          |    1 +
 arch/mips/oprofile/op_model_mipsxx.c |    4 ++
 15 files changed, 135 insertions(+), 64 deletions(-)

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
diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 556afa2..3b50744 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -98,6 +98,9 @@
 #ifndef kernel_uses_smartmips_rixi
 #define kernel_uses_smartmips_rixi 0
 #endif
+#ifndef cpu_has_mmips
+#define cpu_has_mmips		(cpu_data[0].options & MIPS_CPU_MICROMIPS)
+#endif
 #ifndef cpu_has_vtag_icache
 #define cpu_has_vtag_icache	(cpu_data[0].icache.flags & MIPS_CACHE_VTAG)
 #endif
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index fc937ef..0a619f8 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -96,6 +96,7 @@
 #define PRID_IMP_1004K		0x9900
 #define PRID_IMP_1074K		0x9a00
 #define PRID_IMP_M14KC		0x9c00
+#define PRID_IMP_M14KEC		0x9e00
 
 /*
  * These are the PRID's for when 23:16 == PRID_COMP_SIBYTE
@@ -262,7 +263,7 @@ enum cpu_type_enum {
 	 */
 	CPU_4KC, CPU_4KEC, CPU_4KSC, CPU_24K, CPU_34K, CPU_1004K, CPU_74K,
 	CPU_ALCHEMY, CPU_PR4450, CPU_BMIPS32, CPU_BMIPS3300, CPU_BMIPS4350,
-	CPU_BMIPS4380, CPU_BMIPS5000, CPU_JZRISC, CPU_M14KC,
+	CPU_BMIPS4380, CPU_BMIPS5000, CPU_JZRISC, CPU_M14KC, CPU_M14KEC,
 
 	/*
 	 * MIPS64 class processors
@@ -319,6 +320,7 @@ enum cpu_type_enum {
 #define MIPS_CPU_VINT		0x00080000 /* CPU supports MIPSR2 vectored interrupts */
 #define MIPS_CPU_VEIC		0x00100000 /* CPU supports MIPSR2 external interrupt controller mode */
 #define MIPS_CPU_ULRI		0x00200000 /* CPU has ULRI feature */
+#define MIPS_CPU_MICROMIPS	0x01000000 /* CPU has microMIPS capability */
 
 /*
  * CPU ASE encodings
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
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 33c59e9..e5f0b27 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -200,6 +200,7 @@ void __init check_wait(void)
 		break;
 
 	case CPU_M14KC:
+	case CPU_M14KEC:
 	case CPU_24K:
 	case CPU_34K:
 	case CPU_1004K:
@@ -743,6 +744,11 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 		c->ases |= MIPS_ASE_MIPSMT;
 	if (config3 & MIPS_CONF3_ULRI)
 		c->options |= MIPS_CPU_ULRI;
+	if (config3 & MIPS_CONF3_ISA)
+		c->options |= MIPS_CPU_MICROMIPS;
+#ifdef CONFIG_CPU_MICROMIPS
+	write_c0_config3(read_c0_config3() | MIPS_CONF3_ISA_OE);
+#endif
 
 	return config3 & MIPS_CONF_M;
 }
@@ -836,6 +842,10 @@ static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 		c->cputype = CPU_M14KC;
 		__cpu_name[cpu] = "MIPS M14Kc";
 		break;
+	case PRID_IMP_M14KEC:
+		c->cputype = CPU_M14KEC;
+		__cpu_name[cpu] = "MIPS M14KEc";
+		break;
 	case PRID_IMP_1004K:
 		c->cputype = CPU_1004K;
 		__cpu_name[cpu] = "MIPS 1004Kc";
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
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 88cbc74..831d06e 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1070,6 +1070,7 @@ static void __cpuinit probe_pcache(void)
 		}
 		/* fall through */
 	case CPU_M14KC:
+	case CPU_M14KEC:
 	case CPU_24K:
 	case CPU_34K:
 	case CPU_1004K:
diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
index cc0b626..34f71b3 100644
--- a/arch/mips/mm/page.c
+++ b/arch/mips/mm/page.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2003, 04, 05 Ralf Baechle (ralf@linux-mips.org)
  * Copyright (C) 2007  Maciej W. Rozycki
  * Copyright (C) 2008  Thiemo Seufer
+ * Copyright (C) 2011, 2012  MIPS Technologies, Inc.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -79,17 +80,12 @@ static struct uasm_reloc __cpuinitdata relocs[5];
  * R4600 v2.0:				0x060 bytes
  * With prefetching, 16 word strides	0x120 bytes
  */
-
-static u32 clear_page_array[0x120 / 4];
+static u32 clear_page_array[CLEAR_PAGE_ARRAY_SIZE / 4];
 
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
+static u32 copy_page_array[COPY_PAGE_ARRAY_SIZE / 4];
 
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
+	buf = (u32 *)(((u8 *)clear_page) - 1);
+#else
+	buf = (u32 *)clear_page;
+#endif
+	memcpy(buf, clear_page_array, CLEAR_PAGE_ARRAY_SIZE);
 }
 
 static void __cpuinit build_copy_load(u32 **buf, int reg, int off)
@@ -607,6 +605,12 @@ void __cpuinit build_copy_page(void)
 	for (i = 0; i < (buf - copy_page_array); i++)
 		pr_debug("\t.word 0x%08x\n", copy_page_array[i]);
 	pr_debug("\t.set pop\n");
+#ifdef CONFIG_CPU_MICROMIPS
+	buf = (u32 *)(((u8 *)copy_page) - 1);
+#else
+	buf = (u32 *)copy_page;
+#endif
+	memcpy(buf, copy_page_array, COPY_PAGE_ARRAY_SIZE);
 }
 
 #ifdef CONFIG_SIBYTE_DMA_PAGEOPS
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index de7fe58..7155b59 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -458,6 +458,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 		 */
 		switch (current_cpu_type()) {
 		case CPU_M14KC:
+		case CPU_M14KEC:
 		case CPU_74K:
 			break;
 
@@ -510,6 +511,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_4KC:
 	case CPU_4KEC:
 	case CPU_M14KC:
+	case CPU_M14KEC:
 	case CPU_SB1:
 	case CPU_SB1A:
 	case CPU_4KSC:
diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index b6e3782..ccf629a 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -79,6 +79,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	switch (current_cpu_type()) {
 	case CPU_5KC:
 	case CPU_M14KC:
+	case CPU_M14KEC:
 	case CPU_20KC:
 	case CPU_24K:
 	case CPU_25KF:
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 813b636..ef4e87f 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -321,6 +321,10 @@ static int __init mipsxx_init(void)
 		op_model_mipsxx_ops.cpu_type = "mips/M14Kc";
 		break;
 
+	case CPU_M14KEC:
+		op_model_mipsxx_ops.cpu_type = "mips/M14KEc";
+		break;
+
 	case CPU_20KC:
 		op_model_mipsxx_ops.cpu_type = "mips/20K";
 		break;
-- 
1.7.10
