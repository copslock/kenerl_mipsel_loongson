Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:31:23 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43633 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6870554AbaA0UYLgAXys (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:24:11 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 33/58] MIPS: lib: csum_partial: Merge EXC and load/store macros
Date:   Mon, 27 Jan 2014 20:19:20 +0000
Message-ID: <1390853985-14246-34-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_24_06
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39151
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
using the EXC macro. There are cases where a load instruction may
never fail such as when we are sure the load happens in the kernel
address space. Therefore, we merge these the EXC and LOADX/STOREX
macros into a single one. We also expand the argument list in the EXC
macro to make the macro more flexible. The extra 'type' argument is not
used by this commit, but it will be used when EVA support is added to
memcpy.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/lib/csum_partial.S | 160 ++++++++++++++++++++++++-------------------
 1 file changed, 91 insertions(+), 69 deletions(-)

diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index 5d73d0d..bff5167 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -328,20 +328,39 @@ LEAF(csum_partial)
  * These handlers do not need to overwrite any data.
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
 
+#undef LOAD
+
 #ifdef USE_DOUBLE
 
-#define LOAD   ld
-#define LOADL  ldl
-#define LOADR  ldr
-#define STOREL sdl
-#define STORER sdr
-#define STORE  sd
+#define LOADK	ld /* No exception */
+#define LOAD(reg, addr, handler)	EXC(ld, LD_INSN, reg, addr, handler)
+#define LOADBU(reg, addr, handler)	EXC(lbu, LD_INSN, reg, addr, handler)
+#define LOADL(reg, addr, handler)	EXC(ldl, LD_INSN, reg, addr, handler)
+#define LOADR(reg, addr, handler)	EXC(ldr, LD_INSN, reg, addr, handler)
+#define STOREB(reg, addr, handler)	EXC(sb, ST_INSN, reg, addr, handler)
+#define STOREL(reg, addr, handler)	EXC(sdl, ST_INSN, reg, addr, handler)
+#define STORER(reg, addr, handler)	EXC(sdr, ST_INSN, reg, addr, handler)
+#define STORE(reg, addr, handler)	EXC(sd, ST_INSN, reg, addr, handler)
 #define ADD    daddu
 #define SUB    dsubu
 #define SRL    dsrl
@@ -353,12 +372,15 @@ LEAF(csum_partial)
 
 #else
 
-#define LOAD   lw
-#define LOADL  lwl
-#define LOADR  lwr
-#define STOREL swl
-#define STORER swr
-#define STORE  sw
+#define LOADK	lw /* No exception */
+#define LOAD(reg, addr, handler)	EXC(lw, LD_INSN, reg, addr, handler)
+#define LOADBU(reg, addr, handler)	EXC(lbu, LD_INSN, reg, addr, handler)
+#define LOADL(reg, addr, handler)	EXC(lwl, LD_INSN, reg, addr, handler)
+#define LOADR(reg, addr, handler)	EXC(lwr, LD_INSN, reg, addr, handler)
+#define STOREB(reg, addr, handler)	EXC(sb, ST_INSN, reg, addr, handler)
+#define STOREL(reg, addr, handler)	EXC(swl, ST_INSN, reg, addr, handler)
+#define STORER(reg, addr, handler)	EXC(swr, ST_INSN, reg, addr, handler)
+#define STORE(reg, addr, handler)	EXC(sw, ST_INSN, reg, addr, handler)
 #define ADD    addu
 #define SUB    subu
 #define SRL    srl
@@ -439,31 +461,31 @@ FEXPORT(csum_partial_copy_nocheck)
 	SUB	len, 8*NBYTES		# subtract here for bgez loop
 	.align	4
 1:
-EXC(	LOAD	t0, UNIT(0)(src),	.Ll_exc)
-EXC(	LOAD	t1, UNIT(1)(src),	.Ll_exc_copy)
-EXC(	LOAD	t2, UNIT(2)(src),	.Ll_exc_copy)
-EXC(	LOAD	t3, UNIT(3)(src),	.Ll_exc_copy)
-EXC(	LOAD	t4, UNIT(4)(src),	.Ll_exc_copy)
-EXC(	LOAD	t5, UNIT(5)(src),	.Ll_exc_copy)
-EXC(	LOAD	t6, UNIT(6)(src),	.Ll_exc_copy)
-EXC(	LOAD	t7, UNIT(7)(src),	.Ll_exc_copy)
+	LOAD(t0, UNIT(0)(src), .Ll_exc)
+	LOAD(t1, UNIT(1)(src), .Ll_exc_copy)
+	LOAD(t2, UNIT(2)(src), .Ll_exc_copy)
+	LOAD(t3, UNIT(3)(src), .Ll_exc_copy)
+	LOAD(t4, UNIT(4)(src), .Ll_exc_copy)
+	LOAD(t5, UNIT(5)(src), .Ll_exc_copy)
+	LOAD(t6, UNIT(6)(src), .Ll_exc_copy)
+	LOAD(t7, UNIT(7)(src), .Ll_exc_copy)
 	SUB	len, len, 8*NBYTES
 	ADD	src, src, 8*NBYTES
-EXC(	STORE	t0, UNIT(0)(dst),	.Ls_exc)
+	STORE(t0, UNIT(0)(dst),	.Ls_exc)
 	ADDC(sum, t0)
-EXC(	STORE	t1, UNIT(1)(dst),	.Ls_exc)
+	STORE(t1, UNIT(1)(dst),	.Ls_exc)
 	ADDC(sum, t1)
-EXC(	STORE	t2, UNIT(2)(dst),	.Ls_exc)
+	STORE(t2, UNIT(2)(dst),	.Ls_exc)
 	ADDC(sum, t2)
-EXC(	STORE	t3, UNIT(3)(dst),	.Ls_exc)
+	STORE(t3, UNIT(3)(dst),	.Ls_exc)
 	ADDC(sum, t3)
-EXC(	STORE	t4, UNIT(4)(dst),	.Ls_exc)
+	STORE(t4, UNIT(4)(dst),	.Ls_exc)
 	ADDC(sum, t4)
-EXC(	STORE	t5, UNIT(5)(dst),	.Ls_exc)
+	STORE(t5, UNIT(5)(dst),	.Ls_exc)
 	ADDC(sum, t5)
-EXC(	STORE	t6, UNIT(6)(dst),	.Ls_exc)
+	STORE(t6, UNIT(6)(dst),	.Ls_exc)
 	ADDC(sum, t6)
-EXC(	STORE	t7, UNIT(7)(dst),	.Ls_exc)
+	STORE(t7, UNIT(7)(dst),	.Ls_exc)
 	ADDC(sum, t7)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, 8*NBYTES
@@ -483,19 +505,19 @@ EXC(	STORE	t7, UNIT(7)(dst),	.Ls_exc)
 	/*
 	 * len >= 4*NBYTES
 	 */
-EXC(	LOAD	t0, UNIT(0)(src),	.Ll_exc)
-EXC(	LOAD	t1, UNIT(1)(src),	.Ll_exc_copy)
-EXC(	LOAD	t2, UNIT(2)(src),	.Ll_exc_copy)
-EXC(	LOAD	t3, UNIT(3)(src),	.Ll_exc_copy)
+	LOAD(t0, UNIT(0)(src), .Ll_exc)
+	LOAD(t1, UNIT(1)(src), .Ll_exc_copy)
+	LOAD(t2, UNIT(2)(src), .Ll_exc_copy)
+	LOAD(t3, UNIT(3)(src), .Ll_exc_copy)
 	SUB	len, len, 4*NBYTES
 	ADD	src, src, 4*NBYTES
-EXC(	STORE	t0, UNIT(0)(dst),	.Ls_exc)
+	STORE(t0, UNIT(0)(dst),	.Ls_exc)
 	ADDC(sum, t0)
-EXC(	STORE	t1, UNIT(1)(dst),	.Ls_exc)
+	STORE(t1, UNIT(1)(dst),	.Ls_exc)
 	ADDC(sum, t1)
-EXC(	STORE	t2, UNIT(2)(dst),	.Ls_exc)
+	STORE(t2, UNIT(2)(dst),	.Ls_exc)
 	ADDC(sum, t2)
-EXC(	STORE	t3, UNIT(3)(dst),	.Ls_exc)
+	STORE(t3, UNIT(3)(dst),	.Ls_exc)
 	ADDC(sum, t3)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, 4*NBYTES
@@ -508,10 +530,10 @@ EXC(	STORE	t3, UNIT(3)(dst),	.Ls_exc)
 	beq	rem, len, .Lcopy_bytes
 	 nop
 1:
-EXC(	LOAD	t0, 0(src),		.Ll_exc)
+	LOAD(t0, 0(src), .Ll_exc)
 	ADD	src, src, NBYTES
 	SUB	len, len, NBYTES
-EXC(	STORE	t0, 0(dst),		.Ls_exc)
+	STORE(t0, 0(dst), .Ls_exc)
 	ADDC(sum, t0)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, NBYTES
@@ -534,10 +556,10 @@ EXC(	STORE	t0, 0(dst),		.Ls_exc)
 	 ADD	t1, dst, len	# t1 is just past last byte of dst
 	li	bits, 8*NBYTES
 	SLL	rem, len, 3	# rem = number of bits to keep
-EXC(	LOAD	t0, 0(src),		.Ll_exc)
+	LOAD(t0, 0(src), .Ll_exc)
 	SUB	bits, bits, rem # bits = number of bits to discard
 	SHIFT_DISCARD t0, t0, bits
-EXC(	STREST	t0, -1(t1),		.Ls_exc)
+	STREST(t0, -1(t1), .Ls_exc)
 	SHIFT_DISCARD_REVERT t0, t0, bits
 	.set reorder
 	ADDC(sum, t0)
@@ -554,12 +576,12 @@ EXC(	STREST	t0, -1(t1),		.Ls_exc)
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
-EXC(	STFIRST t3, FIRST(0)(dst),	.Ls_exc)
+	STFIRST(t3, FIRST(0)(dst), .Ls_exc)
 	SLL	t4, t1, 3		# t4 = number of bits to discard
 	SHIFT_DISCARD t3, t3, t4
 	/* no SHIFT_DISCARD_REVERT to handle odd buffer properly */
@@ -581,26 +603,26 @@ EXC(	STFIRST t3, FIRST(0)(dst),	.Ls_exc)
  * It's OK to load FIRST(N+1) before REST(N) because the two addresses
  * are to the same unit (unless src is aligned, but it's not).
  */
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
 	ADD	src, src, 4*NBYTES
 #ifdef CONFIG_CPU_SB1
 	nop				# improves slotting
 #endif
-EXC(	STORE	t0, UNIT(0)(dst),	.Ls_exc)
+	STORE(t0, UNIT(0)(dst),	.Ls_exc)
 	ADDC(sum, t0)
-EXC(	STORE	t1, UNIT(1)(dst),	.Ls_exc)
+	STORE(t1, UNIT(1)(dst),	.Ls_exc)
 	ADDC(sum, t1)
-EXC(	STORE	t2, UNIT(2)(dst),	.Ls_exc)
+	STORE(t2, UNIT(2)(dst),	.Ls_exc)
 	ADDC(sum, t2)
-EXC(	STORE	t3, UNIT(3)(dst),	.Ls_exc)
+	STORE(t3, UNIT(3)(dst),	.Ls_exc)
 	ADDC(sum, t3)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, 4*NBYTES
@@ -613,11 +635,11 @@ EXC(	STORE	t3, UNIT(3)(dst),	.Ls_exc)
 	beq	rem, len, .Lcopy_bytes
 	 nop
 1:
-EXC(	LDFIRST t0, FIRST(0)(src),	.Ll_exc)
-EXC(	LDREST	t0, REST(0)(src),	.Ll_exc_copy)
+	LDFIRST(t0, FIRST(0)(src), .Ll_exc)
+	LDREST(t0, REST(0)(src), .Ll_exc_copy)
 	ADD	src, src, NBYTES
 	SUB	len, len, NBYTES
-EXC(	STORE	t0, 0(dst),		.Ls_exc)
+	STORE(t0, 0(dst), .Ls_exc)
 	ADDC(sum, t0)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, NBYTES
@@ -640,9 +662,9 @@ EXC(	STORE	t0, 0(dst),		.Ls_exc)
 	li	t3, SHIFT_START # shift
 /* use .Ll_exc_copy here to return correct sum on fault */
 #define COPY_BYTE(N)			\
-EXC(	lbu	t0, N(src), .Ll_exc_copy);	\
+	LOADBU(t0, N(src), .Ll_exc_copy);	\
 	SUB	len, len, 1;		\
-EXC(	sb	t0, N(dst), .Ls_exc);	\
+	STOREB(t0, N(dst), .Ls_exc);	\
 	SLLV	t0, t0, t3;		\
 	addu	t3, SHIFT_INC;		\
 	beqz	len, .Lcopy_bytes_done; \
@@ -656,9 +678,9 @@ EXC(	sb	t0, N(dst), .Ls_exc);	\
 	COPY_BYTE(4)
 	COPY_BYTE(5)
 #endif
-EXC(	lbu	t0, NBYTES-2(src), .Ll_exc_copy)
+	LOADBU(t0, NBYTES-2(src), .Ll_exc_copy)
 	SUB	len, len, 1
-EXC(	sb	t0, NBYTES-2(dst), .Ls_exc)
+	STOREB(t0, NBYTES-2(dst), .Ls_exc)
 	SLLV	t0, t0, t3
 	or	t2, t0
 .Lcopy_bytes_done:
@@ -703,11 +725,11 @@ EXC(	sb	t0, NBYTES-2(dst), .Ls_exc)
 	 *
 	 * Assumes src < THREAD_BUADDR($28)
 	 */
-	LOAD	t0, TI_TASK($28)
+	LOADK	t0, TI_TASK($28)
 	 li	t2, SHIFT_START
-	LOAD	t0, THREAD_BUADDR(t0)
+	LOADK	t0, THREAD_BUADDR(t0)
 1:
-EXC(	lbu	t1, 0(src),	.Ll_exc)
+	LOADBU(t1, 0(src), .Ll_exc)
 	ADD	src, src, 1
 	sb	t1, 0(dst)	# can't fault -- we're copy_from_user
 	SLLV	t1, t1, t2
@@ -718,9 +740,9 @@ EXC(	lbu	t1, 0(src),	.Ll_exc)
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
 	/*
-- 
1.8.5.3
