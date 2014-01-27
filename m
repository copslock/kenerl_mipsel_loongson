Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:31:43 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43641 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6870555AbaA0UYNlQK1f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:24:13 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 34/58] MIPS: lib: csum_partial: Add macro to build csum_partial symbols
Date:   Mon, 27 Jan 2014 20:19:21 +0000
Message-ID: <1390853985-14246-35-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_24_08
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39152
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

In preparation for EVA support, we use a macro to build the
__csum_partial_copy_user main code so it can be shared across
multiple implementations. EVA uses the same code but it replaces
the load/store/prefetch instructions with the EVA specific ones
therefore using a macro avoids unnecessary code duplications.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/lib/csum_partial.S | 200 +++++++++++++++++++++++--------------------
 1 file changed, 108 insertions(+), 92 deletions(-)

diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index bff5167..62c8768 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -331,6 +331,10 @@ LEAF(csum_partial)
 /* Instruction type */
 #define LD_INSN 1
 #define ST_INSN 2
+#define LEGACY_MODE 1
+#define EVA_MODE    2
+#define USEROP   1
+#define KERNELOP 2
 
 /*
  * Wrapper to add an entry in the exception table
@@ -343,10 +347,12 @@ LEAF(csum_partial)
  * handler : Exception handler
  */
 #define EXC(insn, type, reg, addr, handler)	\
-9:	insn reg, addr;				\
-	.section __ex_table,"a";		\
-	PTR	9b, handler;			\
-	.previous
+	.if \mode == LEGACY_MODE;		\
+9:		insn reg, addr;			\
+		.section __ex_table,"a";	\
+		PTR	9b, handler;		\
+		.previous;			\
+	.endif
 
 #undef LOAD
 
@@ -419,16 +425,20 @@ LEAF(csum_partial)
 	.set	at=v1
 #endif
 
-LEAF(__csum_partial_copy_kernel)
-FEXPORT(__csum_partial_copy_to_user)
-FEXPORT(__csum_partial_copy_from_user)
+	.macro __BUILD_CSUM_PARTIAL_COPY_USER mode, from, to, __nocheck
+
 	PTR_ADDU	AT, src, len	/* See (1) above. */
+	/* initialize __nocheck if this the first time we execute this
+	 * macro
+	 */
 #ifdef CONFIG_64BIT
 	move	errptr, a4
 #else
 	lw	errptr, 16(sp)
 #endif
-FEXPORT(csum_partial_copy_nocheck)
+	.if \__nocheck == 1
+	FEXPORT(csum_partial_copy_nocheck)
+	.endif
 	move	sum, zero
 	move	odd, zero
 	/*
@@ -444,48 +454,48 @@ FEXPORT(csum_partial_copy_nocheck)
 	 */
 	sltu	t2, len, NBYTES
 	and	t1, dst, ADDRMASK
-	bnez	t2, .Lcopy_bytes_checklen
+	bnez	t2, .Lcopy_bytes_checklen\@
 	 and	t0, src, ADDRMASK
 	andi	odd, dst, 0x1			/* odd buffer? */
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
 	 nop
 	SUB	len, 8*NBYTES		# subtract here for bgez loop
 	.align	4
 1:
-	LOAD(t0, UNIT(0)(src), .Ll_exc)
-	LOAD(t1, UNIT(1)(src), .Ll_exc_copy)
-	LOAD(t2, UNIT(2)(src), .Ll_exc_copy)
-	LOAD(t3, UNIT(3)(src), .Ll_exc_copy)
-	LOAD(t4, UNIT(4)(src), .Ll_exc_copy)
-	LOAD(t5, UNIT(5)(src), .Ll_exc_copy)
-	LOAD(t6, UNIT(6)(src), .Ll_exc_copy)
-	LOAD(t7, UNIT(7)(src), .Ll_exc_copy)
+	LOAD(t0, UNIT(0)(src), .Ll_exc\@)
+	LOAD(t1, UNIT(1)(src), .Ll_exc_copy\@)
+	LOAD(t2, UNIT(2)(src), .Ll_exc_copy\@)
+	LOAD(t3, UNIT(3)(src), .Ll_exc_copy\@)
+	LOAD(t4, UNIT(4)(src), .Ll_exc_copy\@)
+	LOAD(t5, UNIT(5)(src), .Ll_exc_copy\@)
+	LOAD(t6, UNIT(6)(src), .Ll_exc_copy\@)
+	LOAD(t7, UNIT(7)(src), .Ll_exc_copy\@)
 	SUB	len, len, 8*NBYTES
 	ADD	src, src, 8*NBYTES
-	STORE(t0, UNIT(0)(dst),	.Ls_exc)
+	STORE(t0, UNIT(0)(dst),	.Ls_exc\@)
 	ADDC(sum, t0)
-	STORE(t1, UNIT(1)(dst),	.Ls_exc)
+	STORE(t1, UNIT(1)(dst),	.Ls_exc\@)
 	ADDC(sum, t1)
-	STORE(t2, UNIT(2)(dst),	.Ls_exc)
+	STORE(t2, UNIT(2)(dst),	.Ls_exc\@)
 	ADDC(sum, t2)
-	STORE(t3, UNIT(3)(dst),	.Ls_exc)
+	STORE(t3, UNIT(3)(dst),	.Ls_exc\@)
 	ADDC(sum, t3)
-	STORE(t4, UNIT(4)(dst),	.Ls_exc)
+	STORE(t4, UNIT(4)(dst),	.Ls_exc\@)
 	ADDC(sum, t4)
-	STORE(t5, UNIT(5)(dst),	.Ls_exc)
+	STORE(t5, UNIT(5)(dst),	.Ls_exc\@)
 	ADDC(sum, t5)
-	STORE(t6, UNIT(6)(dst),	.Ls_exc)
+	STORE(t6, UNIT(6)(dst),	.Ls_exc\@)
 	ADDC(sum, t6)
-	STORE(t7, UNIT(7)(dst),	.Ls_exc)
+	STORE(t7, UNIT(7)(dst),	.Ls_exc\@)
 	ADDC(sum, t7)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, 8*NBYTES
@@ -496,44 +506,44 @@ FEXPORT(csum_partial_copy_nocheck)
 	/*
 	 * len == the number of bytes left to copy < 8*NBYTES
 	 */
-.Lcleanup_both_aligned:
+.Lcleanup_both_aligned\@:
 #define rem t7
-	beqz	len, .Ldone
+	beqz	len, .Ldone\@
 	 sltu	t0, len, 4*NBYTES
-	bnez	t0, .Lless_than_4units
+	bnez	t0, .Lless_than_4units\@
 	 and	rem, len, (NBYTES-1)	# rem = len % NBYTES
 	/*
 	 * len >= 4*NBYTES
 	 */
-	LOAD(t0, UNIT(0)(src), .Ll_exc)
-	LOAD(t1, UNIT(1)(src), .Ll_exc_copy)
-	LOAD(t2, UNIT(2)(src), .Ll_exc_copy)
-	LOAD(t3, UNIT(3)(src), .Ll_exc_copy)
+	LOAD(t0, UNIT(0)(src), .Ll_exc\@)
+	LOAD(t1, UNIT(1)(src), .Ll_exc_copy\@)
+	LOAD(t2, UNIT(2)(src), .Ll_exc_copy\@)
+	LOAD(t3, UNIT(3)(src), .Ll_exc_copy\@)
 	SUB	len, len, 4*NBYTES
 	ADD	src, src, 4*NBYTES
-	STORE(t0, UNIT(0)(dst),	.Ls_exc)
+	STORE(t0, UNIT(0)(dst),	.Ls_exc\@)
 	ADDC(sum, t0)
-	STORE(t1, UNIT(1)(dst),	.Ls_exc)
+	STORE(t1, UNIT(1)(dst),	.Ls_exc\@)
 	ADDC(sum, t1)
-	STORE(t2, UNIT(2)(dst),	.Ls_exc)
+	STORE(t2, UNIT(2)(dst),	.Ls_exc\@)
 	ADDC(sum, t2)
-	STORE(t3, UNIT(3)(dst),	.Ls_exc)
+	STORE(t3, UNIT(3)(dst),	.Ls_exc\@)
 	ADDC(sum, t3)
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
-	LOAD(t0, 0(src), .Ll_exc)
+	LOAD(t0, 0(src), .Ll_exc\@)
 	ADD	src, src, NBYTES
 	SUB	len, len, NBYTES
-	STORE(t0, 0(dst), .Ls_exc)
+	STORE(t0, 0(dst), .Ls_exc\@)
 	ADDC(sum, t0)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, NBYTES
@@ -552,20 +562,20 @@ FEXPORT(csum_partial_copy_nocheck)
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
 	SHIFT_DISCARD_REVERT t0, t0, bits
 	.set reorder
 	ADDC(sum, t0)
-	b	.Ldone
+	b	.Ldone\@
 	.set noreorder
-.Ldst_unaligned:
+.Ldst_unaligned\@:
 	/*
 	 * dst is unaligned
 	 * t0 = src & ADDRMASK
@@ -576,25 +586,25 @@ FEXPORT(csum_partial_copy_nocheck)
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
-	STFIRST(t3, FIRST(0)(dst), .Ls_exc)
+	STFIRST(t3, FIRST(0)(dst), .Ls_exc\@)
 	SLL	t4, t1, 3		# t4 = number of bits to discard
 	SHIFT_DISCARD t3, t3, t4
 	/* no SHIFT_DISCARD_REVERT to handle odd buffer properly */
 	ADDC(sum, t3)
-	beq	len, t2, .Ldone
+	beq	len, t2, .Ldone\@
 	 SUB	len, len, t2
 	ADD	dst, dst, t2
-	beqz	match, .Lboth_aligned
+	beqz	match, .Lboth_aligned\@
 	 ADD	src, src, t2
 
-.Lsrc_unaligned_dst_aligned:
+.Lsrc_unaligned_dst_aligned\@:
 	SRL	t0, len, LOG_NBYTES+2	 # +2 for 4 units/iter
-	beqz	t0, .Lcleanup_src_unaligned
+	beqz	t0, .Lcleanup_src_unaligned\@
 	 and	rem, len, (4*NBYTES-1)	 # rem = len % 4*NBYTES
 1:
 /*
@@ -603,53 +613,53 @@ FEXPORT(csum_partial_copy_nocheck)
  * It's OK to load FIRST(N+1) before REST(N) because the two addresses
  * are to the same unit (unless src is aligned, but it's not).
  */
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
 	ADD	src, src, 4*NBYTES
 #ifdef CONFIG_CPU_SB1
 	nop				# improves slotting
 #endif
-	STORE(t0, UNIT(0)(dst),	.Ls_exc)
+	STORE(t0, UNIT(0)(dst),	.Ls_exc\@)
 	ADDC(sum, t0)
-	STORE(t1, UNIT(1)(dst),	.Ls_exc)
+	STORE(t1, UNIT(1)(dst),	.Ls_exc\@)
 	ADDC(sum, t1)
-	STORE(t2, UNIT(2)(dst),	.Ls_exc)
+	STORE(t2, UNIT(2)(dst),	.Ls_exc\@)
 	ADDC(sum, t2)
-	STORE(t3, UNIT(3)(dst),	.Ls_exc)
+	STORE(t3, UNIT(3)(dst),	.Ls_exc\@)
 	ADDC(sum, t3)
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
-	LDFIRST(t0, FIRST(0)(src), .Ll_exc)
-	LDREST(t0, REST(0)(src), .Ll_exc_copy)
+	LDFIRST(t0, FIRST(0)(src), .Ll_exc\@)
+	LDREST(t0, REST(0)(src), .Ll_exc_copy\@)
 	ADD	src, src, NBYTES
 	SUB	len, len, NBYTES
-	STORE(t0, 0(dst), .Ls_exc)
+	STORE(t0, 0(dst), .Ls_exc\@)
 	ADDC(sum, t0)
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
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
 #define SHIFT_START 0
@@ -662,12 +672,12 @@ FEXPORT(csum_partial_copy_nocheck)
 	li	t3, SHIFT_START # shift
 /* use .Ll_exc_copy here to return correct sum on fault */
 #define COPY_BYTE(N)			\
-	LOADBU(t0, N(src), .Ll_exc_copy);	\
+	LOADBU(t0, N(src), .Ll_exc_copy\@);	\
 	SUB	len, len, 1;		\
-	STOREB(t0, N(dst), .Ls_exc);	\
+	STOREB(t0, N(dst), .Ls_exc\@);	\
 	SLLV	t0, t0, t3;		\
 	addu	t3, SHIFT_INC;		\
-	beqz	len, .Lcopy_bytes_done; \
+	beqz	len, .Lcopy_bytes_done\@; \
 	 or	t2, t0
 
 	COPY_BYTE(0)
@@ -678,14 +688,14 @@ FEXPORT(csum_partial_copy_nocheck)
 	COPY_BYTE(4)
 	COPY_BYTE(5)
 #endif
-	LOADBU(t0, NBYTES-2(src), .Ll_exc_copy)
+	LOADBU(t0, NBYTES-2(src), .Ll_exc_copy\@)
 	SUB	len, len, 1
-	STOREB(t0, NBYTES-2(dst), .Ls_exc)
+	STOREB(t0, NBYTES-2(dst), .Ls_exc\@)
 	SLLV	t0, t0, t3
 	or	t2, t0
-.Lcopy_bytes_done:
+.Lcopy_bytes_done\@:
 	ADDC(sum, t2)
-.Ldone:
+.Ldone\@:
 	/* fold checksum */
 #ifdef USE_DOUBLE
 	dsll32	v1, sum, 0
@@ -714,7 +724,7 @@ FEXPORT(csum_partial_copy_nocheck)
 	jr	ra
 	.set noreorder
 
-.Ll_exc_copy:
+.Ll_exc_copy\@:
 	/*
 	 * Copy bytes from src until faulting load address (or until a
 	 * lb faults)
@@ -729,7 +739,7 @@ FEXPORT(csum_partial_copy_nocheck)
 	 li	t2, SHIFT_START
 	LOADK	t0, THREAD_BUADDR(t0)
 1:
-	LOADBU(t1, 0(src), .Ll_exc)
+	LOADBU(t1, 0(src), .Ll_exc\@)
 	ADD	src, src, 1
 	sb	t1, 0(dst)	# can't fault -- we're copy_from_user
 	SLLV	t1, t1, t2
@@ -739,7 +749,7 @@ FEXPORT(csum_partial_copy_nocheck)
 	ADD	dst, dst, 1
 	bne	src, t0, 1b
 	.set	noreorder
-.Ll_exc:
+.Ll_exc\@:
 	LOADK	t0, TI_TASK($28)
 	 nop
 	LOADK	t0, THREAD_BUADDR(t0)	# t0 is just past last good address
@@ -758,7 +768,7 @@ FEXPORT(csum_partial_copy_nocheck)
 	 */
 	.set	reorder				/* DADDI_WAR */
 	SUB	src, len, 1
-	beqz	len, .Ldone
+	beqz	len, .Ldone\@
 	.set	noreorder
 1:	sb	zero, 0(dst)
 	ADD	dst, dst, 1
@@ -773,13 +783,19 @@ FEXPORT(csum_partial_copy_nocheck)
 	 SUB	src, src, v1
 #endif
 	li	v1, -EFAULT
-	b	.Ldone
+	b	.Ldone\@
 	 sw	v1, (errptr)
 
-.Ls_exc:
+.Ls_exc\@:
 	li	v0, -1 /* invalid checksum */
 	li	v1, -EFAULT
 	jr	ra
 	 sw	v1, (errptr)
 	.set	pop
-	END(__csum_partial_copy_kernel)
+	.endm
+
+LEAF(__csum_partial_copy_kernel)
+FEXPORT(__csum_partial_copy_to_user)
+FEXPORT(__csum_partial_copy_from_user)
+__BUILD_CSUM_PARTIAL_COPY_USER LEGACY_MODE USEROP USEROP 1
+END(__csum_partial_copy_kernel)
-- 
1.8.5.3
