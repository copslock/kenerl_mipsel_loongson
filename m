Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Dec 2006 15:07:52 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:60128 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20042189AbWLQPHq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 17 Dec 2006 15:07:46 +0000
Received: from localhost (p3079-ipad02funabasi.chiba.ocn.ne.jp [61.214.23.79])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 32A99BCBA; Mon, 18 Dec 2006 00:07:40 +0900 (JST)
Date:	Mon, 18 Dec 2006 00:07:40 +0900 (JST)
Message-Id: <20061218.000740.08076708.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Unify memset.S
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13458
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips


The 32-bit version and 64-bit version are almost equal.  Unify them.
This makes further improvements (for example, supporting CDEX, etc.)
easier.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/lib-32/Makefile |    2 
 arch/mips/lib-32/memset.S |  145 --------------------------------------
 arch/mips/lib-64/Makefile |    2 
 arch/mips/lib-64/memset.S |  142 -------------------------------------
 arch/mips/lib/Makefile    |    2 
 arch/mips/lib/memset.S    |  166 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 169 insertions(+), 290 deletions(-)

diff --git a/arch/mips/lib-32/Makefile b/arch/mips/lib-32/Makefile
index dcd4d2e..2036cf5 100644
--- a/arch/mips/lib-32/Makefile
+++ b/arch/mips/lib-32/Makefile
@@ -2,7 +2,7 @@ #
 # Makefile for MIPS-specific library files..
 #
 
-lib-y	+= memset.o watch.o
+lib-y	+= watch.o
 
 obj-$(CONFIG_CPU_MIPS32)	+= dump_tlb.o
 obj-$(CONFIG_CPU_MIPS64)	+= dump_tlb.o
diff --git a/arch/mips/lib-32/memset.S b/arch/mips/lib-32/memset.S
deleted file mode 100644
index 1981485..0000000
--- a/arch/mips/lib-32/memset.S
+++ /dev/null
@@ -1,145 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1998, 1999, 2000 by Ralf Baechle
- * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
- */
-#include <asm/asm.h>
-#include <asm/asm-offsets.h>
-#include <asm/regdef.h>
-
-#define EX(insn,reg,addr,handler)			\
-9:	insn	reg, addr;				\
-	.section __ex_table,"a"; 			\
-	PTR	9b, handler; 				\
-	.previous
-
-	.macro	f_fill64 dst, offset, val, fixup
-	EX(LONG_S, \val, (\offset +  0 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset +  1 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset +  2 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset +  3 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset +  4 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset +  5 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset +  6 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset +  7 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset +  8 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset +  9 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset + 10 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset + 11 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset + 12 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset + 13 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset + 14 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset + 15 * LONGSIZE)(\dst), \fixup)
-	.endm
-
-/*
- * memset(void *s, int c, size_t n)
- *
- * a0: start of area to clear
- * a1: char to fill with
- * a2: size of area to clear
- */
-	.set	noreorder
-	.align	5
-LEAF(memset)
-	beqz		a1, 1f
-	 move		v0, a0			/* result */
-
-	andi		a1, 0xff		/* spread fillword */
-	sll		t1, a1, 8
-	or		a1, t1
-	sll		t1, a1, 16
-	or		a1, t1
-1:
-
-FEXPORT(__bzero)
-	sltiu		t0, a2, LONGSIZE	/* very small region? */
-	bnez		t0, small_memset
-	 andi		t0, a0, LONGMASK	/* aligned? */
-
-	beqz		t0, 1f
-	 PTR_SUBU	t0, LONGSIZE		/* alignment in bytes */
-
-#ifdef __MIPSEB__
-	EX(swl, a1, (a0), first_fixup)		/* make word aligned */
-#endif
-#ifdef __MIPSEL__
-	EX(swr, a1, (a0), first_fixup)		/* make word aligned */
-#endif
-	PTR_SUBU	a0, t0			/* long align ptr */
-	PTR_ADDU	a2, t0			/* correct size */
-
-1:	ori		t1, a2, 0x3f		/* # of full blocks */
-	xori		t1, 0x3f
-	beqz		t1, memset_partial	/* no block to fill */
-	 andi		t0, a2, 0x3c
-
-	PTR_ADDU	t1, a0			/* end address */
-	.set		reorder
-1:	PTR_ADDIU	a0, 64
-	f_fill64 a0, -64, a1, fwd_fixup
-	bne		t1, a0, 1b
-	.set		noreorder
-
-memset_partial:
-	PTR_LA		t1, 2f			/* where to start */
-	PTR_SUBU	t1, t0
-	jr		t1
-	 PTR_ADDU	a0, t0			/* dest ptr */
-
-	.set		push
-	.set		noreorder
-	.set		nomacro
-	f_fill64 a0, -64, a1, partial_fixup	/* ... but first do longs ... */
-2:	.set		pop
-	andi		a2, LONGMASK		/* At most one long to go */
-
-	beqz		a2, 1f
-	 PTR_ADDU	a0, a2			/* What's left */
-#ifdef __MIPSEB__
-	EX(swr, a1, -1(a0), last_fixup)
-#endif
-#ifdef __MIPSEL__
-	EX(swl, a1, -1(a0), last_fixup)
-#endif
-1:	jr		ra
-	 move		a2, zero
-
-small_memset:
-	beqz		a2, 2f
-	 PTR_ADDU	t1, a0, a2
-
-1:	PTR_ADDIU	a0, 1			/* fill bytewise */
-	bne		t1, a0, 1b
-	 sb		a1, -1(a0)
-
-2:	jr		ra			/* done */
-	 move		a2, zero
-	END(memset)
-
-first_fixup:
-	jr	ra
-	 nop
-
-fwd_fixup:
-	PTR_L		t0, TI_TASK($28)
-	LONG_L		t0, THREAD_BUADDR(t0)
-	andi		a2, 0x3f
-	LONG_ADDU	a2, t1
-	jr		ra
-	 LONG_SUBU	a2, t0
-
-partial_fixup:
-	PTR_L		t0, TI_TASK($28)
-	LONG_L		t0, THREAD_BUADDR(t0)
-	andi		a2, LONGMASK
-	LONG_ADDU	a2, t1
-	jr		ra
-	 LONG_SUBU	a2, t0
-
-last_fixup:
-	jr		ra
-	 andi		v1, a2, LONGMASK
diff --git a/arch/mips/lib-64/Makefile b/arch/mips/lib-64/Makefile
index dcd4d2e..2036cf5 100644
--- a/arch/mips/lib-64/Makefile
+++ b/arch/mips/lib-64/Makefile
@@ -2,7 +2,7 @@ #
 # Makefile for MIPS-specific library files..
 #
 
-lib-y	+= memset.o watch.o
+lib-y	+= watch.o
 
 obj-$(CONFIG_CPU_MIPS32)	+= dump_tlb.o
 obj-$(CONFIG_CPU_MIPS64)	+= dump_tlb.o
diff --git a/arch/mips/lib-64/memset.S b/arch/mips/lib-64/memset.S
deleted file mode 100644
index e2c42c8..0000000
--- a/arch/mips/lib-64/memset.S
+++ /dev/null
@@ -1,142 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1998, 1999, 2000 by Ralf Baechle
- * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
- */
-#include <asm/asm.h>
-#include <asm/asm-offsets.h>
-#include <asm/regdef.h>
-
-#define EX(insn,reg,addr,handler)			\
-9:	insn	reg, addr;				\
-	.section __ex_table,"a"; 			\
-	PTR	9b, handler; 				\
-	.previous
-
-	.macro	f_fill64 dst, offset, val, fixup
-	EX(LONG_S, \val, (\offset +  0 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset +  1 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset +  2 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset +  3 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset +  4 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset +  5 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset +  6 * LONGSIZE)(\dst), \fixup)
-	EX(LONG_S, \val, (\offset +  7 * LONGSIZE)(\dst), \fixup)
-	.endm
-
-/*
- * memset(void *s, int c, size_t n)
- *
- * a0: start of area to clear
- * a1: char to fill with
- * a2: size of area to clear
- */
-	.set	noreorder
-	.align	5
-LEAF(memset)
-	beqz		a1, 1f
-	 move		v0, a0			/* result */
-
-	andi		a1, 0xff		/* spread fillword */
-	dsll		t1, a1, 8
-	or		a1, t1
-	dsll		t1, a1, 16
-	or		a1, t1
-	dsll		t1, a1, 32
-	or		a1, t1
-1:
-
-FEXPORT(__bzero)
-	sltiu		t0, a2, LONGSIZE	/* very small region? */
-	bnez		t0, small_memset
-	 andi		t0, a0, LONGMASK	/* aligned? */
-
-	beqz		t0, 1f
-	 PTR_SUBU	t0, LONGSIZE		/* alignment in bytes */
-
-#ifdef __MIPSEB__
-	EX(sdl, a1, (a0), first_fixup)		/* make dword aligned */
-#endif
-#ifdef __MIPSEL__
-	EX(sdr, a1, (a0), first_fixup)		/* make dword aligned */
-#endif
-	PTR_SUBU	a0, t0			/* long align ptr */
-	PTR_ADDU	a2, t0			/* correct size */
-
-1:	ori		t1, a2, 0x3f		/* # of full blocks */
-	xori		t1, 0x3f
-	beqz		t1, memset_partial	/* no block to fill */
-	 andi		t0, a2, 0x38
-
-	PTR_ADDU	t1, a0			/* end address */
-	.set		reorder
-1:	PTR_ADDIU	a0, 64
-	f_fill64 a0, -64, a1, fwd_fixup
-	bne		t1, a0, 1b
-	.set		noreorder
-
-memset_partial:
-	PTR_LA		t1, 2f			/* where to start */
-	.set		noat
-	dsrl		AT, t0, 1
-	PTR_SUBU	t1, AT
-	.set		noat
-	jr		t1
-	 PTR_ADDU	a0, t0			/* dest ptr */
-
-	.set		push
-	.set		noreorder
-	.set		nomacro
-	f_fill64 a0, -64, a1, partial_fixup	/* ... but first do longs ... */
-2:	.set		pop
-	andi		a2, LONGMASK		/* At most one long to go */
-
-	beqz		a2, 1f
-	 PTR_ADDU	a0, a2			/* What's left */
-#ifdef __MIPSEB__
-	EX(sdr, a1, -1(a0), last_fixup)
-#endif
-#ifdef __MIPSEL__
-	EX(sdl, a1, -1(a0), last_fixup)
-#endif
-1:	jr		ra
-	 move		a2, zero
-
-small_memset:
-	beqz		a2, 2f
-	 PTR_ADDU	t1, a0, a2
-
-1:	PTR_ADDIU	a0, 1			/* fill bytewise */
-	bne		t1, a0, 1b
-	 sb		a1, -1(a0)
-
-2:	jr		ra			/* done */
-	 move		a2, zero
-	END(memset)
-
-first_fixup:
-	jr	ra
-	 nop
-
-fwd_fixup:
-	PTR_L		t0, TI_TASK($28)
-	LONG_L		t0, THREAD_BUADDR(t0)
-	andi		a2, 0x3f
-	LONG_ADDU	a2, t1
-	jr		ra
-	 LONG_SUBU	a2, t0
-
-partial_fixup:
-	PTR_L		t0, TI_TASK($28)
-	LONG_L		t0, THREAD_BUADDR(t0)
-	andi		a2, LONGMASK
-	LONG_ADDU	a2, t1
-	jr		ra
-	 LONG_SUBU	a2, t0
-
-last_fixup:
-	jr		ra
-	 andi		v1, a2, LONGMASK
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 30a9b83..a9f6434 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -2,7 +2,7 @@ #
 # Makefile for MIPS-specific library files..
 #
 
-lib-y	+= csum_partial.o memcpy.o promlib.o \
+lib-y	+= csum_partial.o memcpy.o memset.o promlib.o \
 	   strlen_user.o strncpy_user.o strnlen_user.o uncached.o
 
 # libgcc-style stuff needed in the kernel
diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
new file mode 100644
index 0000000..3f8b8b3
--- /dev/null
+++ b/arch/mips/lib/memset.S
@@ -0,0 +1,166 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1998, 1999, 2000 by Ralf Baechle
+ * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
+ */
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/regdef.h>
+
+#if LONGSIZE == 4
+#define LONG_S_L swl
+#define LONG_S_R swr
+#else
+#define LONG_S_L sdl
+#define LONG_S_R sdr
+#endif
+
+#define EX(insn,reg,addr,handler)			\
+9:	insn	reg, addr;				\
+	.section __ex_table,"a"; 			\
+	PTR	9b, handler; 				\
+	.previous
+
+	.macro	f_fill64 dst, offset, val, fixup
+	EX(LONG_S, \val, (\offset +  0 * LONGSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset +  1 * LONGSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset +  2 * LONGSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset +  3 * LONGSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset +  4 * LONGSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset +  5 * LONGSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset +  6 * LONGSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset +  7 * LONGSIZE)(\dst), \fixup)
+#if LONGSIZE == 4
+	EX(LONG_S, \val, (\offset +  8 * LONGSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset +  9 * LONGSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset + 10 * LONGSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset + 11 * LONGSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset + 12 * LONGSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset + 13 * LONGSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset + 14 * LONGSIZE)(\dst), \fixup)
+	EX(LONG_S, \val, (\offset + 15 * LONGSIZE)(\dst), \fixup)
+#endif
+	.endm
+
+/*
+ * memset(void *s, int c, size_t n)
+ *
+ * a0: start of area to clear
+ * a1: char to fill with
+ * a2: size of area to clear
+ */
+	.set	noreorder
+	.align	5
+LEAF(memset)
+	beqz		a1, 1f
+	 move		v0, a0			/* result */
+
+	andi		a1, 0xff		/* spread fillword */
+	LONG_SLL		t1, a1, 8
+	or		a1, t1
+	LONG_SLL		t1, a1, 16
+#if LONGSIZE == 8
+	or		a1, t1
+	LONG_SLL		t1, a1, 32
+#endif
+	or		a1, t1
+1:
+
+FEXPORT(__bzero)
+	sltiu		t0, a2, LONGSIZE	/* very small region? */
+	bnez		t0, small_memset
+	 andi		t0, a0, LONGMASK	/* aligned? */
+
+	beqz		t0, 1f
+	 PTR_SUBU	t0, LONGSIZE		/* alignment in bytes */
+
+#ifdef __MIPSEB__
+	EX(LONG_S_L, a1, (a0), first_fixup)	/* make word/dword aligned */
+#endif
+#ifdef __MIPSEL__
+	EX(LONG_S_R, a1, (a0), first_fixup)	/* make word/dword aligned */
+#endif
+	PTR_SUBU	a0, t0			/* long align ptr */
+	PTR_ADDU	a2, t0			/* correct size */
+
+1:	ori		t1, a2, 0x3f		/* # of full blocks */
+	xori		t1, 0x3f
+	beqz		t1, memset_partial	/* no block to fill */
+	 andi		t0, a2, 0x40-LONGSIZE
+
+	PTR_ADDU	t1, a0			/* end address */
+	.set		reorder
+1:	PTR_ADDIU	a0, 64
+	f_fill64 a0, -64, a1, fwd_fixup
+	bne		t1, a0, 1b
+	.set		noreorder
+
+memset_partial:
+	PTR_LA		t1, 2f			/* where to start */
+#if LONGSIZE == 4
+	PTR_SUBU	t1, t0
+#else
+	.set		noat
+	LONG_SRL		AT, t0, 1
+	PTR_SUBU	t1, AT
+	.set		noat
+#endif
+	jr		t1
+	 PTR_ADDU	a0, t0			/* dest ptr */
+
+	.set		push
+	.set		noreorder
+	.set		nomacro
+	f_fill64 a0, -64, a1, partial_fixup	/* ... but first do longs ... */
+2:	.set		pop
+	andi		a2, LONGMASK		/* At most one long to go */
+
+	beqz		a2, 1f
+	 PTR_ADDU	a0, a2			/* What's left */
+#ifdef __MIPSEB__
+	EX(LONG_S_R, a1, -1(a0), last_fixup)
+#endif
+#ifdef __MIPSEL__
+	EX(LONG_S_L, a1, -1(a0), last_fixup)
+#endif
+1:	jr		ra
+	 move		a2, zero
+
+small_memset:
+	beqz		a2, 2f
+	 PTR_ADDU	t1, a0, a2
+
+1:	PTR_ADDIU	a0, 1			/* fill bytewise */
+	bne		t1, a0, 1b
+	 sb		a1, -1(a0)
+
+2:	jr		ra			/* done */
+	 move		a2, zero
+	END(memset)
+
+first_fixup:
+	jr	ra
+	 nop
+
+fwd_fixup:
+	PTR_L		t0, TI_TASK($28)
+	LONG_L		t0, THREAD_BUADDR(t0)
+	andi		a2, 0x3f
+	LONG_ADDU	a2, t1
+	jr		ra
+	 LONG_SUBU	a2, t0
+
+partial_fixup:
+	PTR_L		t0, TI_TASK($28)
+	LONG_L		t0, THREAD_BUADDR(t0)
+	andi		a2, LONGMASK
+	LONG_ADDU	a2, t1
+	jr		ra
+	 LONG_SUBU	a2, t0
+
+last_fixup:
+	jr		ra
+	 andi		v1, a2, LONGMASK
