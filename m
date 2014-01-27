Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:25:58 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43581 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827441AbaA0UWvw-nhv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:22:51 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 18/58] MIPS: lib: memcpy: Use macro to build the copy_user code
Date:   Mon, 27 Jan 2014 20:19:05 +0000
Message-ID: <1390853985-14246-19-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_22_51
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39135
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

The code can be shared between EVA and non-EVA configurations,
therefore use a macro to build it to avoid code duplications.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/lib/memcpy.S | 253 ++++++++++++++++++++++++++++---------------------
 1 file changed, 143 insertions(+), 110 deletions(-)

diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index eed6e07..d630a28 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -92,6 +92,10 @@
 /* Pretech type */
 #define SRC_PREFETCH 1
 #define DST_PREFETCH 2
+#define LEGACY_MODE 1
+#define EVA_MODE    2
+#define USEROP   1
+#define KERNELOP 2
 
 /*
  * Wrapper to add an entry in the exception table
@@ -103,12 +107,14 @@
  * addr    : Address
  * handler : Exception handler
  */
-#define EXC(insn, type, reg, addr, handler)	\
-9:	insn reg, addr;				\
-	.section __ex_table,"a";		\
-	PTR	9b, handler;			\
-	.previous
 
+#define EXC(insn, type, reg, addr, handler)			\
+	.if \mode == LEGACY_MODE;				\
+9:		insn reg, addr;					\
+		.section __ex_table,"a";			\
+		PTR	9b, handler;				\
+		.previous;					\
+	.endif
 /*
  * Only on the 64-bit kernel we can made use of 64-bit registers.
  */
@@ -177,7 +183,10 @@
 #define LOADB(reg, addr, handler)	EXC(lb, LD_INSN, reg, addr, handler)
 #define STOREB(reg, addr, handler)	EXC(sb, ST_INSN, reg, addr, handler)
 
-#define _PREF(hint, addr, type)	        PREF(hint, addr)
+#define _PREF(hint, addr, type)						\
+	.if \mode == LEGACY_MODE;					\
+		PREF(hint, addr);					\
+	.endif
 
 #define PREFS(hint, addr) _PREF(hint, addr, SRC_PREFETCH)
 #define PREFD(hint, addr) _PREF(hint, addr, DST_PREFETCH)
@@ -210,27 +219,23 @@
 	.set	at=v1
 #endif
 
-/*
- * t6 is used as a flag to note inatomic mode.
- */
-LEAF(__copy_user_inatomic)
-	b	__copy_user_common
-	 li	t6, 1
-	END(__copy_user_inatomic)
-
-/*
- * A combined memcpy/__copy_user
- * __copy_user sets len to 0 for success; else to an upper bound of
- * the number of uncopied bytes.
- * memcpy sets v0 to dst.
- */
 	.align	5
-LEAF(memcpy)					/* a0=dst a1=src a2=len */
-	move	v0, dst				/* return value */
-.L__memcpy:
-FEXPORT(__copy_user)
-	li	t6, 0	/* not inatomic */
-__copy_user_common:
+
+	/*
+	 * Macro to build the __copy_user common code
+	 * Arguements:
+	 * mode : LEGACY_MODE or EVA_MODE
+	 * from : Source operand. USEROP or KERNELOP
+	 * to   : Destination operand. USEROP or KERNELOP
+	 */
+	.macro __BUILD_COPY_USER mode, from, to
+
+	/* initialize __memcpy if this the first time we execute this macro */
+	.ifnotdef __memcpy
+	.set __memcpy, 1
+	.hidden __memcpy /* make sure it does not leak */
+	.endif
+
 	/*
 	 * Note: dst & src may be unaligned, len may be 0
 	 * Temps
@@ -251,45 +256,45 @@ __copy_user_common:
 	and	t1, dst, ADDRMASK
 	PREFS(	0, 1*32(src) )
 	PREFD(	1, 1*32(dst) )
-	bnez	t2, .Lcopy_bytes_checklen
+	bnez	t2, .Lcopy_bytes_checklen\@
 	 and	t0, src, ADDRMASK
 	PREFS(	0, 2*32(src) )
 	PREFD(	1, 2*32(dst) )
-	bnez	t1, .Ldst_unaligned
+	bnez	t1, .Ldst_unaligned\@
 	 nop
-	bnez	t0, .Lsrc_unaligned_dst_aligned
+	bnez	t0, .Lsrc_unaligned_dst_aligned\@
 	/*
 	 * use delay slot for fall-through
 	 * src and dst are aligned; need to compute rem
 	 */
-.Lboth_aligned:
+.Lboth_aligned\@:
 	 SRL	t0, len, LOG_NBYTES+3	 # +3 for 8 units/iter
-	beqz	t0, .Lcleanup_both_aligned # len < 8*NBYTES
+	beqz	t0, .Lcleanup_both_aligned\@ # len < 8*NBYTES
 	 and	rem, len, (8*NBYTES-1)	 # rem = len % (8*NBYTES)
 	PREFS(	0, 3*32(src) )
 	PREFD(	1, 3*32(dst) )
 	.align	4
 1:
 	R10KCBARRIER(0(ra))
-	LOAD(t0, UNIT(0)(src), .Ll_exc)
-	LOAD(t1, UNIT(1)(src), .Ll_exc_copy)
-	LOAD(t2, UNIT(2)(src), .Ll_exc_copy)
-	LOAD(t3, UNIT(3)(src), .Ll_exc_copy)
+	LOAD(t0, UNIT(0)(src), .Ll_exc\@)
+	LOAD(t1, UNIT(1)(src), .Ll_exc_copy\@)
+	LOAD(t2, UNIT(2)(src), .Ll_exc_copy\@)
+	LOAD(t3, UNIT(3)(src), .Ll_exc_copy\@)
 	SUB	len, len, 8*NBYTES
-	LOAD(t4, UNIT(4)(src), .Ll_exc_copy)
-	LOAD(t7, UNIT(5)(src), .Ll_exc_copy)
-	STORE(t0, UNIT(0)(dst),	.Ls_exc_p8u)
-	STORE(t1, UNIT(1)(dst),	.Ls_exc_p7u)
-	LOAD(t0, UNIT(6)(src), .Ll_exc_copy)
-	LOAD(t1, UNIT(7)(src), .Ll_exc_copy)
+	LOAD(t4, UNIT(4)(src), .Ll_exc_copy\@)
+	LOAD(t7, UNIT(5)(src), .Ll_exc_copy\@)
+	STORE(t0, UNIT(0)(dst),	.Ls_exc_p8u\@)
+	STORE(t1, UNIT(1)(dst),	.Ls_exc_p7u\@)
+	LOAD(t0, UNIT(6)(src), .Ll_exc_copy\@)
+	LOAD(t1, UNIT(7)(src), .Ll_exc_copy\@)
 	ADD	src, src, 8*NBYTES
 	ADD	dst, dst, 8*NBYTES
-	STORE(t2, UNIT(-6)(dst), .Ls_exc_p6u)
-	STORE(t3, UNIT(-5)(dst), .Ls_exc_p5u)
-	STORE(t4, UNIT(-4)(dst), .Ls_exc_p4u)
-	STORE(t7, UNIT(-3)(dst), .Ls_exc_p3u)
-	STORE(t0, UNIT(-2)(dst), .Ls_exc_p2u)
-	STORE(t1, UNIT(-1)(dst), .Ls_exc_p1u)
+	STORE(t2, UNIT(-6)(dst), .Ls_exc_p6u\@)
+	STORE(t3, UNIT(-5)(dst), .Ls_exc_p5u\@)
+	STORE(t4, UNIT(-4)(dst), .Ls_exc_p4u\@)
+	STORE(t7, UNIT(-3)(dst), .Ls_exc_p3u\@)
+	STORE(t0, UNIT(-2)(dst), .Ls_exc_p2u\@)
+	STORE(t1, UNIT(-1)(dst), .Ls_exc_p1u\@)
 	PREFS(	0, 8*32(src) )
 	PREFD(	1, 8*32(dst) )
 	bne	len, rem, 1b
@@ -298,41 +303,41 @@ __copy_user_common:
 	/*
 	 * len == rem == the number of bytes left to copy < 8*NBYTES
 	 */
-.Lcleanup_both_aligned:
-	beqz	len, .Ldone
+.Lcleanup_both_aligned\@:
+	beqz	len, .Ldone\@
 	 sltu	t0, len, 4*NBYTES
-	bnez	t0, .Lless_than_4units
+	bnez	t0, .Lless_than_4units\@
 	 and	rem, len, (NBYTES-1)	# rem = len % NBYTES
 	/*
 	 * len >= 4*NBYTES
 	 */
-	LOAD( t0, UNIT(0)(src),	.Ll_exc)
-	LOAD( t1, UNIT(1)(src),	.Ll_exc_copy)
-	LOAD( t2, UNIT(2)(src),	.Ll_exc_copy)
-	LOAD( t3, UNIT(3)(src),	.Ll_exc_copy)
+	LOAD( t0, UNIT(0)(src),	.Ll_exc\@)
+	LOAD( t1, UNIT(1)(src),	.Ll_exc_copy\@)
+	LOAD( t2, UNIT(2)(src),	.Ll_exc_copy\@)
+	LOAD( t3, UNIT(3)(src),	.Ll_exc_copy\@)
 	SUB	len, len, 4*NBYTES
 	ADD	src, src, 4*NBYTES
 	R10KCBARRIER(0(ra))
-	STORE(t0, UNIT(0)(dst),	.Ls_exc_p4u)
-	STORE(t1, UNIT(1)(dst),	.Ls_exc_p3u)
-	STORE(t2, UNIT(2)(dst),	.Ls_exc_p2u)
-	STORE(t3, UNIT(3)(dst),	.Ls_exc_p1u)
+	STORE(t0, UNIT(0)(dst),	.Ls_exc_p4u\@)
+	STORE(t1, UNIT(1)(dst),	.Ls_exc_p3u\@)
+	STORE(t2, UNIT(2)(dst),	.Ls_exc_p2u\@)
+	STORE(t3, UNIT(3)(dst),	.Ls_exc_p1u\@)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, 4*NBYTES
-	beqz	len, .Ldone
+	beqz	len, .Ldone\@
 	.set	noreorder
-.Lless_than_4units:
+.Lless_than_4units\@:
 	/*
 	 * rem = len % NBYTES
 	 */
-	beq	rem, len, .Lcopy_bytes
+	beq	rem, len, .Lcopy_bytes\@
 	 nop
 1:
 	R10KCBARRIER(0(ra))
-	LOAD(t0, 0(src), .Ll_exc)
+	LOAD(t0, 0(src), .Ll_exc\@)
 	ADD	src, src, NBYTES
 	SUB	len, len, NBYTES
-	STORE(t0, 0(dst), .Ls_exc_p1u)
+	STORE(t0, 0(dst), .Ls_exc_p1u\@)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, NBYTES
 	bne	rem, len, 1b
@@ -350,17 +355,17 @@ __copy_user_common:
 	 * more instruction-level parallelism.
 	 */
 #define bits t2
-	beqz	len, .Ldone
+	beqz	len, .Ldone\@
 	 ADD	t1, dst, len	# t1 is just past last byte of dst
 	li	bits, 8*NBYTES
 	SLL	rem, len, 3	# rem = number of bits to keep
-	LOAD(t0, 0(src), .Ll_exc)
+	LOAD(t0, 0(src), .Ll_exc\@)
 	SUB	bits, bits, rem # bits = number of bits to discard
 	SHIFT_DISCARD t0, t0, bits
-	STREST(t0, -1(t1), .Ls_exc)
+	STREST(t0, -1(t1), .Ls_exc\@)
 	jr	ra
 	 move	len, zero
-.Ldst_unaligned:
+.Ldst_unaligned\@:
 	/*
 	 * dst is unaligned
 	 * t0 = src & ADDRMASK
@@ -371,23 +376,23 @@ __copy_user_common:
 	 * Set match = (src and dst have same alignment)
 	 */
 #define match rem
-	LDFIRST(t3, FIRST(0)(src), .Ll_exc)
+	LDFIRST(t3, FIRST(0)(src), .Ll_exc\@)
 	ADD	t2, zero, NBYTES
-	LDREST(t3, REST(0)(src), .Ll_exc_copy)
+	LDREST(t3, REST(0)(src), .Ll_exc_copy\@)
 	SUB	t2, t2, t1	# t2 = number of bytes copied
 	xor	match, t0, t1
 	R10KCBARRIER(0(ra))
-	STFIRST(t3, FIRST(0)(dst), .Ls_exc)
-	beq	len, t2, .Ldone
+	STFIRST(t3, FIRST(0)(dst), .Ls_exc\@)
+	beq	len, t2, .Ldone\@
 	 SUB	len, len, t2
 	ADD	dst, dst, t2
-	beqz	match, .Lboth_aligned
+	beqz	match, .Lboth_aligned\@
 	 ADD	src, src, t2
 
-.Lsrc_unaligned_dst_aligned:
+.Lsrc_unaligned_dst_aligned\@:
 	SRL	t0, len, LOG_NBYTES+2	 # +2 for 4 units/iter
 	PREFS(	0, 3*32(src) )
-	beqz	t0, .Lcleanup_src_unaligned
+	beqz	t0, .Lcleanup_src_unaligned\@
 	 and	rem, len, (4*NBYTES-1)	 # rem = len % 4*NBYTES
 	PREFD(	1, 3*32(dst) )
 1:
@@ -398,58 +403,58 @@ __copy_user_common:
  * are to the same unit (unless src is aligned, but it's not).
  */
 	R10KCBARRIER(0(ra))
-	LDFIRST(t0, FIRST(0)(src), .Ll_exc)
-	LDFIRST(t1, FIRST(1)(src), .Ll_exc_copy)
+	LDFIRST(t0, FIRST(0)(src), .Ll_exc\@)
+	LDFIRST(t1, FIRST(1)(src), .Ll_exc_copy\@)
 	SUB	len, len, 4*NBYTES
-	LDREST(t0, REST(0)(src), .Ll_exc_copy)
-	LDREST(t1, REST(1)(src), .Ll_exc_copy)
-	LDFIRST(t2, FIRST(2)(src), .Ll_exc_copy)
-	LDFIRST(t3, FIRST(3)(src), .Ll_exc_copy)
-	LDREST(t2, REST(2)(src), .Ll_exc_copy)
-	LDREST(t3, REST(3)(src), .Ll_exc_copy)
+	LDREST(t0, REST(0)(src), .Ll_exc_copy\@)
+	LDREST(t1, REST(1)(src), .Ll_exc_copy\@)
+	LDFIRST(t2, FIRST(2)(src), .Ll_exc_copy\@)
+	LDFIRST(t3, FIRST(3)(src), .Ll_exc_copy\@)
+	LDREST(t2, REST(2)(src), .Ll_exc_copy\@)
+	LDREST(t3, REST(3)(src), .Ll_exc_copy\@)
 	PREFS(	0, 9*32(src) )		# 0 is PREF_LOAD  (not streamed)
 	ADD	src, src, 4*NBYTES
 #ifdef CONFIG_CPU_SB1
 	nop				# improves slotting
 #endif
-	STORE(t0, UNIT(0)(dst),	.Ls_exc_p4u)
-	STORE(t1, UNIT(1)(dst),	.Ls_exc_p3u)
-	STORE(t2, UNIT(2)(dst),	.Ls_exc_p2u)
-	STORE(t3, UNIT(3)(dst),	.Ls_exc_p1u)
+	STORE(t0, UNIT(0)(dst),	.Ls_exc_p4u\@)
+	STORE(t1, UNIT(1)(dst),	.Ls_exc_p3u\@)
+	STORE(t2, UNIT(2)(dst),	.Ls_exc_p2u\@)
+	STORE(t3, UNIT(3)(dst),	.Ls_exc_p1u\@)
 	PREFD(	1, 9*32(dst) )		# 1 is PREF_STORE (not streamed)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, 4*NBYTES
 	bne	len, rem, 1b
 	.set	noreorder
 
-.Lcleanup_src_unaligned:
-	beqz	len, .Ldone
+.Lcleanup_src_unaligned\@:
+	beqz	len, .Ldone\@
 	 and	rem, len, NBYTES-1  # rem = len % NBYTES
-	beq	rem, len, .Lcopy_bytes
+	beq	rem, len, .Lcopy_bytes\@
 	 nop
 1:
 	R10KCBARRIER(0(ra))
-	LDFIRST(t0, FIRST(0)(src), .Ll_exc)
-	LDREST(t0, REST(0)(src), .Ll_exc_copy)
+	LDFIRST(t0, FIRST(0)(src), .Ll_exc\@)
+	LDREST(t0, REST(0)(src), .Ll_exc_copy\@)
 	ADD	src, src, NBYTES
 	SUB	len, len, NBYTES
-	STORE(t0, 0(dst), .Ls_exc_p1u)
+	STORE(t0, 0(dst), .Ls_exc_p1u\@)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, NBYTES
 	bne	len, rem, 1b
 	.set	noreorder
 
-.Lcopy_bytes_checklen:
-	beqz	len, .Ldone
+.Lcopy_bytes_checklen\@:
+	beqz	len, .Ldone\@
 	 nop
-.Lcopy_bytes:
+.Lcopy_bytes\@:
 	/* 0 < len < NBYTES  */
 	R10KCBARRIER(0(ra))
 #define COPY_BYTE(N)			\
-	LOADB(t0, N(src), .Ll_exc);	\
+	LOADB(t0, N(src), .Ll_exc\@);	\
 	SUB	len, len, 1;		\
-	beqz	len, .Ldone;		\
-	STOREB(t0, N(dst), .Ls_exc_p1)
+	beqz	len, .Ldone\@;		\
+	STOREB(t0, N(dst), .Ls_exc_p1\@)
 
 	COPY_BYTE(0)
 	COPY_BYTE(1)
@@ -459,16 +464,19 @@ __copy_user_common:
 	COPY_BYTE(4)
 	COPY_BYTE(5)
 #endif
-	LOADB(t0, NBYTES-2(src), .Ll_exc)
+	LOADB(t0, NBYTES-2(src), .Ll_exc\@)
 	SUB	len, len, 1
 	jr	ra
-	STOREB(t0, NBYTES-2(dst), .Ls_exc_p1)
-.Ldone:
+	STOREB(t0, NBYTES-2(dst), .Ls_exc_p1\@)
+.Ldone\@:
 	jr	ra
-	 nop
+	.if __memcpy == 1
 	END(memcpy)
+	.set __memcpy, 0
+	.hidden __memcpy
+	.endif
 
-.Ll_exc_copy:
+.Ll_exc_copy\@:
 	/*
 	 * Copy bytes from src until faulting load address (or until a
 	 * lb faults)
@@ -483,20 +491,20 @@ __copy_user_common:
 	 nop
 	LOADK	t0, THREAD_BUADDR(t0)
 1:
-	LOADB(t1, 0(src), .Ll_exc)
+	LOADB(t1, 0(src), .Ll_exc\@)
 	ADD	src, src, 1
 	sb	t1, 0(dst)	# can't fault -- we're copy_from_user
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, 1
 	bne	src, t0, 1b
 	.set	noreorder
-.Ll_exc:
+.Ll_exc\@:
 	LOADK	t0, TI_TASK($28)
 	 nop
 	LOADK	t0, THREAD_BUADDR(t0)	# t0 is just past last good address
 	 nop
 	SUB	len, AT, t0		# len number of uncopied bytes
-	bnez	t6, .Ldone	/* Skip the zeroing part if inatomic */
+	bnez	t6, .Ldone\@	/* Skip the zeroing part if inatomic */
 	/*
 	 * Here's where we rely on src and dst being incremented in tandem,
 	 *   See (3) above.
@@ -510,7 +518,7 @@ __copy_user_common:
 	 */
 	.set	reorder				/* DADDI_WAR */
 	SUB	src, len, 1
-	beqz	len, .Ldone
+	beqz	len, .Ldone\@
 	.set	noreorder
 1:	sb	zero, 0(dst)
 	ADD	dst, dst, 1
@@ -531,7 +539,7 @@ __copy_user_common:
 
 #define SEXC(n)							\
 	.set	reorder;			/* DADDI_WAR */ \
-.Ls_exc_p ## n ## u:						\
+.Ls_exc_p ## n ## u\@:						\
 	ADD	len, len, n*NBYTES;				\
 	jr	ra;						\
 	.set	noreorder
@@ -545,14 +553,15 @@ SEXC(3)
 SEXC(2)
 SEXC(1)
 
-.Ls_exc_p1:
+.Ls_exc_p1\@:
 	.set	reorder				/* DADDI_WAR */
 	ADD	len, len, 1
 	jr	ra
 	.set	noreorder
-.Ls_exc:
+.Ls_exc\@:
 	jr	ra
 	 nop
+	.endm
 
 	.align	5
 LEAF(memmove)
@@ -603,3 +612,27 @@ LEAF(__rmemcpy)					/* a0=dst a1=src a2=len */
 	jr	ra
 	 move	a2, zero
 	END(__rmemcpy)
+
+/*
+ * t6 is used as a flag to note inatomic mode.
+ */
+LEAF(__copy_user_inatomic)
+	b	__copy_user_common
+	li	t6, 1
+	END(__copy_user_inatomic)
+
+/*
+ * A combined memcpy/__copy_user
+ * __copy_user sets len to 0 for success; else to an upper bound of
+ * the number of uncopied bytes.
+ * memcpy sets v0 to dst.
+ */
+	.align	5
+LEAF(memcpy)					/* a0=dst a1=src a2=len */
+	move	v0, dst				/* return value */
+.L__memcpy:
+FEXPORT(__copy_user)
+	li	t6, 0	/* not inatomic */
+__copy_user_common:
+	/* Legacy Mode, user <-> user */
+	__BUILD_COPY_USER LEGACY_MODE USEROP USEROP
-- 
1.8.5.3
