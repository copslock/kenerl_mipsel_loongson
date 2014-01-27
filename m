Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:25:36 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43581 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827435AbaA0UWviCLfI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:22:51 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 16/58] MIPS: lib: memcpy: Merge EXC and load/store macros
Date:   Mon, 27 Jan 2014 20:19:03 +0000
Message-ID: <1390853985-14246-17-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_22_46
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39134
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

Each load/store macro always adds an entry to the __ex_table
using the EXC macro. Therefore, these load/store macros are now merged
with the EXC one. The argument list is also expanded in order to make
the macro more flexible. The extra 'type' argument is not used by this
commit, but it will be used when the EVA support is added to the memcpy.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/lib/memcpy.S | 158 ++++++++++++++++++++++++++++---------------------
 1 file changed, 89 insertions(+), 69 deletions(-)

diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index c5c40da..ab9f046 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -10,6 +10,7 @@
  * Copyright (C) 2002 Broadcom, Inc.
  *   memcpy/copy_user author: Mark Vandevoorde
  * Copyright (C) 2007  Maciej W. Rozycki
+ * Copyright (C) 2014 Imagination Technologies Ltd.
  *
  * Mnemonic names for arguments to memcpy/__copy_user
  */
@@ -85,8 +86,22 @@
  * they're not protected.
  */
 
-#define EXC(inst_reg,addr,handler)		\
-9:	inst_reg, addr;				\
+/* Instruction type */
+#define LD_INSN 1
+#define ST_INSN 2
+
+/*
+ * Wrapper to add an entry in the exception table
+ * in case the insn causes a memory exception.
+ * Arguments:
+ * insn    : Load/store instruction
+ * type    : Instruction type
+ * reg     : Register
+ * addr    : Address
+ * handler : Exception handler
+ */
+#define EXC(insn, type, reg, addr, handler)	\
+9:	insn reg, addr;				\
 	.section __ex_table,"a";		\
 	PTR	9b, handler;			\
 	.previous
@@ -100,12 +115,13 @@
 
 #ifdef USE_DOUBLE
 
-#define LOAD   ld
-#define LOADL  ldl
-#define LOADR  ldr
-#define STOREL sdl
-#define STORER sdr
-#define STORE  sd
+#define LOADK ld /* No exception */
+#define LOAD(reg, addr, handler)	EXC(ld, LD_INSN, reg, addr, handler)
+#define LOADL(reg, addr, handler)	EXC(ldl, LD_INSN, reg, addr, handler)
+#define LOADR(reg, addr, handler)	EXC(ldr, LD_INSN, reg, addr, handler)
+#define STOREL(reg, addr, handler)	EXC(sdl, ST_INSN, reg, addr, handler)
+#define STORER(reg, addr, handler)	EXC(sdr, ST_INSN, reg, addr, handler)
+#define STORE(reg, addr, handler)	EXC(sd, ST_INSN, reg, addr, handler)
 #define ADD    daddu
 #define SUB    dsubu
 #define SRL    dsrl
@@ -136,12 +152,13 @@
 
 #else
 
-#define LOAD   lw
-#define LOADL  lwl
-#define LOADR  lwr
-#define STOREL swl
-#define STORER swr
-#define STORE  sw
+#define LOADK lw /* No exception */
+#define LOAD(reg, addr, handler)	EXC(lw, LD_INSN, reg, addr, handler)
+#define LOADL(reg, addr, handler)	EXC(lwl, LD_INSN, reg, addr, handler)
+#define LOADR(reg, addr, handler)	EXC(lwr, LD_INSN, reg, addr, handler)
+#define STOREL(reg, addr, handler)	EXC(swl, ST_INSN, reg, addr, handler)
+#define STORER(reg, addr, handler)	EXC(swr, ST_INSN, reg, addr, handler)
+#define STORE(reg, addr, handler)	EXC(sw, ST_INSN, reg, addr, handler)
 #define ADD    addu
 #define SUB    subu
 #define SRL    srl
@@ -154,6 +171,9 @@
 
 #endif /* USE_DOUBLE */
 
+#define LOADB(reg, addr, handler)	EXC(lb, LD_INSN, reg, addr, handler)
+#define STOREB(reg, addr, handler)	EXC(sb, ST_INSN, reg, addr, handler)
+
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
 #define LDFIRST LOADR
 #define LDREST	LOADL
@@ -243,25 +263,25 @@ __copy_user_common:
 	.align	4
 1:
 	R10KCBARRIER(0(ra))
-EXC(	LOAD	t0, UNIT(0)(src),	.Ll_exc)
-EXC(	LOAD	t1, UNIT(1)(src),	.Ll_exc_copy)
-EXC(	LOAD	t2, UNIT(2)(src),	.Ll_exc_copy)
-EXC(	LOAD	t3, UNIT(3)(src),	.Ll_exc_copy)
+	LOAD(t0, UNIT(0)(src), .Ll_exc)
+	LOAD(t1, UNIT(1)(src), .Ll_exc_copy)
+	LOAD(t2, UNIT(2)(src), .Ll_exc_copy)
+	LOAD(t3, UNIT(3)(src), .Ll_exc_copy)
 	SUB	len, len, 8*NBYTES
-EXC(	LOAD	t4, UNIT(4)(src),	.Ll_exc_copy)
-EXC(	LOAD	t7, UNIT(5)(src),	.Ll_exc_copy)
-EXC(	STORE	t0, UNIT(0)(dst),	.Ls_exc_p8u)
-EXC(	STORE	t1, UNIT(1)(dst),	.Ls_exc_p7u)
-EXC(	LOAD	t0, UNIT(6)(src),	.Ll_exc_copy)
-EXC(	LOAD	t1, UNIT(7)(src),	.Ll_exc_copy)
+	LOAD(t4, UNIT(4)(src), .Ll_exc_copy)
+	LOAD(t7, UNIT(5)(src), .Ll_exc_copy)
+	STORE(t0, UNIT(0)(dst),	.Ls_exc_p8u)
+	STORE(t1, UNIT(1)(dst),	.Ls_exc_p7u)
+	LOAD(t0, UNIT(6)(src), .Ll_exc_copy)
+	LOAD(t1, UNIT(7)(src), .Ll_exc_copy)
 	ADD	src, src, 8*NBYTES
 	ADD	dst, dst, 8*NBYTES
-EXC(	STORE	t2, UNIT(-6)(dst),	.Ls_exc_p6u)
-EXC(	STORE	t3, UNIT(-5)(dst),	.Ls_exc_p5u)
-EXC(	STORE	t4, UNIT(-4)(dst),	.Ls_exc_p4u)
-EXC(	STORE	t7, UNIT(-3)(dst),	.Ls_exc_p3u)
-EXC(	STORE	t0, UNIT(-2)(dst),	.Ls_exc_p2u)
-EXC(	STORE	t1, UNIT(-1)(dst),	.Ls_exc_p1u)
+	STORE(t2, UNIT(-6)(dst), .Ls_exc_p6u)
+	STORE(t3, UNIT(-5)(dst), .Ls_exc_p5u)
+	STORE(t4, UNIT(-4)(dst), .Ls_exc_p4u)
+	STORE(t7, UNIT(-3)(dst), .Ls_exc_p3u)
+	STORE(t0, UNIT(-2)(dst), .Ls_exc_p2u)
+	STORE(t1, UNIT(-1)(dst), .Ls_exc_p1u)
 	PREF(	0, 8*32(src) )
 	PREF(	1, 8*32(dst) )
 	bne	len, rem, 1b
@@ -278,17 +298,17 @@ EXC(	STORE	t1, UNIT(-1)(dst),	.Ls_exc_p1u)
 	/*
 	 * len >= 4*NBYTES
 	 */
-EXC(	LOAD	t0, UNIT(0)(src),	.Ll_exc)
-EXC(	LOAD	t1, UNIT(1)(src),	.Ll_exc_copy)
-EXC(	LOAD	t2, UNIT(2)(src),	.Ll_exc_copy)
-EXC(	LOAD	t3, UNIT(3)(src),	.Ll_exc_copy)
+	LOAD( t0, UNIT(0)(src),	.Ll_exc)
+	LOAD( t1, UNIT(1)(src),	.Ll_exc_copy)
+	LOAD( t2, UNIT(2)(src),	.Ll_exc_copy)
+	LOAD( t3, UNIT(3)(src),	.Ll_exc_copy)
 	SUB	len, len, 4*NBYTES
 	ADD	src, src, 4*NBYTES
 	R10KCBARRIER(0(ra))
-EXC(	STORE	t0, UNIT(0)(dst),	.Ls_exc_p4u)
-EXC(	STORE	t1, UNIT(1)(dst),	.Ls_exc_p3u)
-EXC(	STORE	t2, UNIT(2)(dst),	.Ls_exc_p2u)
-EXC(	STORE	t3, UNIT(3)(dst),	.Ls_exc_p1u)
+	STORE(t0, UNIT(0)(dst),	.Ls_exc_p4u)
+	STORE(t1, UNIT(1)(dst),	.Ls_exc_p3u)
+	STORE(t2, UNIT(2)(dst),	.Ls_exc_p2u)
+	STORE(t3, UNIT(3)(dst),	.Ls_exc_p1u)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, 4*NBYTES
 	beqz	len, .Ldone
@@ -301,10 +321,10 @@ EXC(	STORE	t3, UNIT(3)(dst),	.Ls_exc_p1u)
 	 nop
 1:
 	R10KCBARRIER(0(ra))
-EXC(	LOAD	t0, 0(src),		.Ll_exc)
+	LOAD(t0, 0(src), .Ll_exc)
 	ADD	src, src, NBYTES
 	SUB	len, len, NBYTES
-EXC(	STORE	t0, 0(dst),		.Ls_exc_p1u)
+	STORE(t0, 0(dst), .Ls_exc_p1u)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, NBYTES
 	bne	rem, len, 1b
@@ -326,10 +346,10 @@ EXC(	STORE	t0, 0(dst),		.Ls_exc_p1u)
 	 ADD	t1, dst, len	# t1 is just past last byte of dst
 	li	bits, 8*NBYTES
 	SLL	rem, len, 3	# rem = number of bits to keep
-EXC(	LOAD	t0, 0(src),		.Ll_exc)
+	LOAD(t0, 0(src), .Ll_exc)
 	SUB	bits, bits, rem # bits = number of bits to discard
 	SHIFT_DISCARD t0, t0, bits
-EXC(	STREST	t0, -1(t1),		.Ls_exc)
+	STREST(t0, -1(t1), .Ls_exc)
 	jr	ra
 	 move	len, zero
 .Ldst_unaligned:
@@ -343,13 +363,13 @@ EXC(	STREST	t0, -1(t1),		.Ls_exc)
 	 * Set match = (src and dst have same alignment)
 	 */
 #define match rem
-EXC(	LDFIRST t3, FIRST(0)(src),	.Ll_exc)
+	LDFIRST(t3, FIRST(0)(src), .Ll_exc)
 	ADD	t2, zero, NBYTES
-EXC(	LDREST	t3, REST(0)(src),	.Ll_exc_copy)
+	LDREST(t3, REST(0)(src), .Ll_exc_copy)
 	SUB	t2, t2, t1	# t2 = number of bytes copied
 	xor	match, t0, t1
 	R10KCBARRIER(0(ra))
-EXC(	STFIRST t3, FIRST(0)(dst),	.Ls_exc)
+	STFIRST(t3, FIRST(0)(dst), .Ls_exc)
 	beq	len, t2, .Ldone
 	 SUB	len, len, t2
 	ADD	dst, dst, t2
@@ -370,24 +390,24 @@ EXC(	STFIRST t3, FIRST(0)(dst),	.Ls_exc)
  * are to the same unit (unless src is aligned, but it's not).
  */
 	R10KCBARRIER(0(ra))
-EXC(	LDFIRST t0, FIRST(0)(src),	.Ll_exc)
-EXC(	LDFIRST t1, FIRST(1)(src),	.Ll_exc_copy)
+	LDFIRST(t0, FIRST(0)(src), .Ll_exc)
+	LDFIRST(t1, FIRST(1)(src), .Ll_exc_copy)
 	SUB	len, len, 4*NBYTES
-EXC(	LDREST	t0, REST(0)(src),	.Ll_exc_copy)
-EXC(	LDREST	t1, REST(1)(src),	.Ll_exc_copy)
-EXC(	LDFIRST t2, FIRST(2)(src),	.Ll_exc_copy)
-EXC(	LDFIRST t3, FIRST(3)(src),	.Ll_exc_copy)
-EXC(	LDREST	t2, REST(2)(src),	.Ll_exc_copy)
-EXC(	LDREST	t3, REST(3)(src),	.Ll_exc_copy)
+	LDREST(t0, REST(0)(src), .Ll_exc_copy)
+	LDREST(t1, REST(1)(src), .Ll_exc_copy)
+	LDFIRST(t2, FIRST(2)(src), .Ll_exc_copy)
+	LDFIRST(t3, FIRST(3)(src), .Ll_exc_copy)
+	LDREST(t2, REST(2)(src), .Ll_exc_copy)
+	LDREST(t3, REST(3)(src), .Ll_exc_copy)
 	PREF(	0, 9*32(src) )		# 0 is PREF_LOAD  (not streamed)
 	ADD	src, src, 4*NBYTES
 #ifdef CONFIG_CPU_SB1
 	nop				# improves slotting
 #endif
-EXC(	STORE	t0, UNIT(0)(dst),	.Ls_exc_p4u)
-EXC(	STORE	t1, UNIT(1)(dst),	.Ls_exc_p3u)
-EXC(	STORE	t2, UNIT(2)(dst),	.Ls_exc_p2u)
-EXC(	STORE	t3, UNIT(3)(dst),	.Ls_exc_p1u)
+	STORE(t0, UNIT(0)(dst),	.Ls_exc_p4u)
+	STORE(t1, UNIT(1)(dst),	.Ls_exc_p3u)
+	STORE(t2, UNIT(2)(dst),	.Ls_exc_p2u)
+	STORE(t3, UNIT(3)(dst),	.Ls_exc_p1u)
 	PREF(	1, 9*32(dst) )		# 1 is PREF_STORE (not streamed)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, 4*NBYTES
@@ -401,11 +421,11 @@ EXC(	STORE	t3, UNIT(3)(dst),	.Ls_exc_p1u)
 	 nop
 1:
 	R10KCBARRIER(0(ra))
-EXC(	LDFIRST t0, FIRST(0)(src),	.Ll_exc)
-EXC(	LDREST	t0, REST(0)(src),	.Ll_exc_copy)
+	LDFIRST(t0, FIRST(0)(src), .Ll_exc)
+	LDREST(t0, REST(0)(src), .Ll_exc_copy)
 	ADD	src, src, NBYTES
 	SUB	len, len, NBYTES
-EXC(	STORE	t0, 0(dst),		.Ls_exc_p1u)
+	STORE(t0, 0(dst), .Ls_exc_p1u)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, NBYTES
 	bne	len, rem, 1b
@@ -418,10 +438,10 @@ EXC(	STORE	t0, 0(dst),		.Ls_exc_p1u)
 	/* 0 < len < NBYTES  */
 	R10KCBARRIER(0(ra))
 #define COPY_BYTE(N)			\
-EXC(	lb	t0, N(src), .Ll_exc);	\
+	LOADB(t0, N(src), .Ll_exc);	\
 	SUB	len, len, 1;		\
 	beqz	len, .Ldone;		\
-EXC(	 sb	t0, N(dst), .Ls_exc_p1)
+	STOREB(t0, N(dst), .Ls_exc_p1)
 
 	COPY_BYTE(0)
 	COPY_BYTE(1)
@@ -431,10 +451,10 @@ EXC(	 sb	t0, N(dst), .Ls_exc_p1)
 	COPY_BYTE(4)
 	COPY_BYTE(5)
 #endif
-EXC(	lb	t0, NBYTES-2(src), .Ll_exc)
+	LOADB(t0, NBYTES-2(src), .Ll_exc)
 	SUB	len, len, 1
 	jr	ra
-EXC(	 sb	t0, NBYTES-2(dst), .Ls_exc_p1)
+	STOREB(t0, NBYTES-2(dst), .Ls_exc_p1)
 .Ldone:
 	jr	ra
 	 nop
@@ -451,11 +471,11 @@ EXC(	 sb	t0, NBYTES-2(dst), .Ls_exc_p1)
 	 *
 	 * Assumes src < THREAD_BUADDR($28)
 	 */
-	LOAD	t0, TI_TASK($28)
+	LOADK	t0, TI_TASK($28)
 	 nop
-	LOAD	t0, THREAD_BUADDR(t0)
+	LOADK	t0, THREAD_BUADDR(t0)
 1:
-EXC(	lb	t1, 0(src),	.Ll_exc)
+	LOADB(t1, 0(src), .Ll_exc)
 	ADD	src, src, 1
 	sb	t1, 0(dst)	# can't fault -- we're copy_from_user
 	.set	reorder				/* DADDI_WAR */
@@ -463,9 +483,9 @@ EXC(	lb	t1, 0(src),	.Ll_exc)
 	bne	src, t0, 1b
 	.set	noreorder
 .Ll_exc:
-	LOAD	t0, TI_TASK($28)
+	LOADK	t0, TI_TASK($28)
 	 nop
-	LOAD	t0, THREAD_BUADDR(t0)	# t0 is just past last good address
+	LOADK	t0, THREAD_BUADDR(t0)	# t0 is just past last good address
 	 nop
 	SUB	len, AT, t0		# len number of uncopied bytes
 	bnez	t6, .Ldone	/* Skip the zeroing part if inatomic */
-- 
1.8.5.3
