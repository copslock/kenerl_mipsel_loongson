Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:26:53 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43583 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6829721AbaA0UW7hNJRf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:22:59 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 21/58] MIPS: lib: memset: Use macro to build the __bzero symbol
Date:   Mon, 27 Jan 2014 20:19:08 +0000
Message-ID: <1390853985-14246-22-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_22_59
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Build the __bzero symbol using a macor. In EVA mode we will
need to use similar code to do the userspace load operations so
it is better if we use a macro to avoid code duplications.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/lib/memset.S | 95 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 35 deletions(-)

diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index d857985..05fac19 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -34,6 +34,9 @@
 #define FILLPTRG t0
 #endif
 
+#define LEGACY_MODE 1
+#define EVA_MODE    2
+
 #define EX(insn,reg,addr,handler)			\
 9:	insn	reg, addr;				\
 	.section __ex_table,"a";			\
@@ -63,33 +66,23 @@
 #endif
 	.endm
 
-/*
- * memset(void *s, int c, size_t n)
- *
- * a0: start of area to clear
- * a1: char to fill with
- * a2: size of area to clear
- */
 	.set	noreorder
 	.align	5
-LEAF(memset)
-	beqz		a1, 1f
-	move		v0, a0			/* result */
 
-	andi		a1, 0xff		/* spread fillword */
-	LONG_SLL		t1, a1, 8
-	or		a1, t1
-	LONG_SLL		t1, a1, 16
-#if LONGSIZE == 8
-	or		a1, t1
-	LONG_SLL		t1, a1, 32
-#endif
-	or		a1, t1
-1:
+	/*
+	 * Macro to generate the __bzero{,_user} symbol
+	 * Arguments:
+	 * mode: LEGACY_MODE or EVA_MODE
+	 */
+	.macro __BUILD_BZERO mode
+	/* Initialize __memset if this is the first time we call this macro */
+	.ifnotdef __memset
+	.set __memset, 1
+	.hidden __memset /* Make sure it does not leak */
+	.endif
 
-FEXPORT(__bzero)
 	sltiu		t0, a2, STORSIZE	/* very small region? */
-	bnez		t0, .Lsmall_memset
+	bnez		t0, .Lsmall_memset\@
 	andi		t0, a0, STORMASK	/* aligned? */
 
 #ifdef CONFIG_CPU_MICROMIPS
@@ -109,28 +102,28 @@ FEXPORT(__bzero)
 
 	R10KCBARRIER(0(ra))
 #ifdef __MIPSEB__
-	EX(LONG_S_L, a1, (a0), .Lfirst_fixup)	/* make word/dword aligned */
+	EX(LONG_S_L, a1, (a0), .Lfirst_fixup\@)	/* make word/dword aligned */
 #endif
 #ifdef __MIPSEL__
-	EX(LONG_S_R, a1, (a0), .Lfirst_fixup)	/* make word/dword aligned */
+	EX(LONG_S_R, a1, (a0), .Lfirst_fixup\@)	/* make word/dword aligned */
 #endif
 	PTR_SUBU	a0, t0			/* long align ptr */
 	PTR_ADDU	a2, t0			/* correct size */
 
 1:	ori		t1, a2, 0x3f		/* # of full blocks */
 	xori		t1, 0x3f
-	beqz		t1, .Lmemset_partial	/* no block to fill */
+	beqz		t1, .Lmemset_partial\@	/* no block to fill */
 	andi		t0, a2, 0x40-STORSIZE
 
 	PTR_ADDU	t1, a0			/* end address */
 	.set		reorder
 1:	PTR_ADDIU	a0, 64
 	R10KCBARRIER(0(ra))
-	f_fill64 a0, -64, FILL64RG, .Lfwd_fixup
+	f_fill64 a0, -64, FILL64RG, .Lfwd_fixup\@
 	bne		t1, a0, 1b
 	.set		noreorder
 
-.Lmemset_partial:
+.Lmemset_partial\@:
 	R10KCBARRIER(0(ra))
 	PTR_LA		t1, 2f			/* where to start */
 #ifdef CONFIG_CPU_MICROMIPS
@@ -150,7 +143,8 @@ FEXPORT(__bzero)
 	.set		push
 	.set		noreorder
 	.set		nomacro
-	f_fill64 a0, -64, FILL64RG, .Lpartial_fixup	/* ... but first do longs ... */
+	/* ... but first do longs ... */
+	f_fill64 a0, -64, FILL64RG, .Lpartial_fixup\@
 2:	.set		pop
 	andi		a2, STORMASK		/* At most one long to go */
 
@@ -158,15 +152,15 @@ FEXPORT(__bzero)
 	PTR_ADDU	a0, a2			/* What's left */
 	R10KCBARRIER(0(ra))
 #ifdef __MIPSEB__
-	EX(LONG_S_R, a1, -1(a0), .Llast_fixup)
+	EX(LONG_S_R, a1, -1(a0), .Llast_fixup\@)
 #endif
 #ifdef __MIPSEL__
-	EX(LONG_S_L, a1, -1(a0), .Llast_fixup)
+	EX(LONG_S_L, a1, -1(a0), .Llast_fixup\@)
 #endif
 1:	jr		ra
 	move		a2, zero
 
-.Lsmall_memset:
+.Lsmall_memset\@:
 	beqz		a2, 2f
 	PTR_ADDU	t1, a0, a2
 
@@ -177,13 +171,17 @@ FEXPORT(__bzero)
 
 2:	jr		ra			/* done */
 	move		a2, zero
+	.if __memset == 1
 	END(memset)
+	.set __memset, 0
+	.hidden __memset
+	.endif
 
-.Lfirst_fixup:
+.Lfirst_fixup\@:
 	jr	ra
 	nop
 
-.Lfwd_fixup:
+.Lfwd_fixup\@:
 	PTR_L		t0, TI_TASK($28)
 	andi		a2, 0x3f
 	LONG_L		t0, THREAD_BUADDR(t0)
@@ -191,7 +189,7 @@ FEXPORT(__bzero)
 	jr		ra
 	LONG_SUBU	a2, t0
 
-.Lpartial_fixup:
+.Lpartial_fixup\@:
 	PTR_L		t0, TI_TASK($28)
 	andi		a2, STORMASK
 	LONG_L		t0, THREAD_BUADDR(t0)
@@ -199,6 +197,33 @@ FEXPORT(__bzero)
 	jr		ra
 	LONG_SUBU	a2, t0
 
-.Llast_fixup:
+.Llast_fixup\@:
 	jr		ra
 	andi		v1, a2, STORMASK
+
+	.endm
+
+/*
+ * memset(void *s, int c, size_t n)
+ *
+ * a0: start of area to clear
+ * a1: char to fill with
+ * a2: size of area to clear
+ */
+
+LEAF(memset)
+	beqz		a1, 1f
+	move		v0, a0			/* result */
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
+FEXPORT(__bzero)
+	__BUILD_BZERO LEGACY_MODE
-- 
1.8.5.3
