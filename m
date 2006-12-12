Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Dec 2006 16:23:08 +0000 (GMT)
Received: from [210.190.142.172] ([210.190.142.172]:61928 "HELO
	smtp.mba.ocn.ne.jp") by ftp.linux-mips.org with SMTP
	id S20038801AbWLLQXB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Dec 2006 16:23:01 +0000
Received: from localhost (p4142-ipad01funabasi.chiba.ocn.ne.jp [61.207.78.142])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id DF74BBBC0; Wed, 13 Dec 2006 01:22:06 +0900 (JST)
Date:	Wed, 13 Dec 2006 01:22:06 +0900 (JST)
Message-Id: <20061213.012206.98747230.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] csum_partial and copy in parallel
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
X-archive-position: 13434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Implement optimized asm version of csum_partial_copy_nocheck,
csum_partial_copy_from_user and csum_and_copy_to_user which can do
calculate and copy in parallel, based on memcpy.S.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/lib/Makefile            |    2 
 arch/mips/lib/csum_partial.S      |  459 ++++++++++++++++++++++++++++++++++++
 arch/mips/lib/csum_partial_copy.c |   52 ----
 include/asm-mips/checksum.h       |   31 +-
 4 files changed, 479 insertions(+), 65 deletions(-)

diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 9bf005f..30a9b83 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -2,7 +2,7 @@ #
 # Makefile for MIPS-specific library files..
 #
 
-lib-y	+= csum_partial.o csum_partial_copy.o memcpy.o promlib.o \
+lib-y	+= csum_partial.o memcpy.o promlib.o \
 	   strlen_user.o strncpy_user.o strnlen_user.o uncached.o
 
 # libgcc-style stuff needed in the kernel
diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index 9db3572..ec0744d 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -8,7 +8,9 @@
  * Copyright (C) 1998, 1999 Ralf Baechle
  * Copyright (C) 1999 Silicon Graphics, Inc.
  */
+#include <linux/errno.h>
 #include <asm/asm.h>
+#include <asm/asm-offsets.h>
 #include <asm/regdef.h>
 
 #ifdef CONFIG_64BIT
@@ -271,3 +273,460 @@ #endif
 	jr	ra
 	.set	noreorder
 	END(csum_partial)
+
+
+/*
+ * checksum and copy routines based on memcpy.S
+ *
+ *	csum_partial_copy_nocheck(src, dst, len, sum)
+ *	__csum_partial_copy_from_user(src, dst, len, sum, errp)
+ *	__csum_and_copy_to_user(src, dst, len, sum, errp)
+ *
+ * See "Spec" in memcpy.S for details.  Unlike __copy_user, all
+ * function in this file use the standard calling convention.
+ */
+
+#define src a0
+#define dst a1
+#define len a2
+#define psum a3
+#define sum v0
+#define odd t5
+#define errptr t6
+
+/*
+ * The exception handler for loads requires that:
+ *  1- AT contain the address of the byte just past the end of the source
+ *     of the copy,
+ *  2- src_entry <= src < AT, and
+ *  3- (dst - src) == (dst_entry - src_entry),
+ * The _entry suffix denotes values when __copy_user was called.
+ *
+ * (1) is set up up by __csum_partial_copy_from_user and maintained by
+ *	not writing AT in __csum_partial_copy
+ * (2) is met by incrementing src by the number of bytes copied
+ * (3) is met by not doing loads between a pair of increments of dst and src
+ *
+ * The exception handlers for stores stores -EFAULT to errptr and return.
+ * These handlers do not need to overwrite any data.
+ */
+
+#define EXC(inst_reg,addr,handler)		\
+9:	inst_reg, addr;				\
+	.section __ex_table,"a";		\
+	PTR	9b, handler;			\
+	.previous
+
+#ifdef USE_DOUBLE
+
+#define LOAD   ld
+#define LOADL  ldl
+#define LOADR  ldr
+#define STOREL sdl
+#define STORER sdr
+#define STORE  sd
+#define ADD    daddu
+#define SUB    dsubu
+#define SRL    dsrl
+#define SLL    dsll
+#define SLLV   dsllv
+#define SRLV   dsrlv
+#define NBYTES 8
+#define LOG_NBYTES 3
+
+#else
+
+#define LOAD   lw
+#define LOADL  lwl
+#define LOADR  lwr
+#define STOREL swl
+#define STORER swr
+#define STORE  sw
+#define ADD    addu
+#define SUB    subu
+#define SRL    srl
+#define SLL    sll
+#define SLLV   sllv
+#define SRLV   srlv
+#define NBYTES 4
+#define LOG_NBYTES 2
+
+#endif /* USE_DOUBLE */
+
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+#define LDFIRST LOADR
+#define LDREST  LOADL
+#define STFIRST STORER
+#define STREST  STOREL
+#define SHIFT_DISCARD SLLV
+#define SHIFT_DISCARD_REVERT SRLV
+#else
+#define LDFIRST LOADL
+#define LDREST  LOADR
+#define STFIRST STOREL
+#define STREST  STORER
+#define SHIFT_DISCARD SRLV
+#define SHIFT_DISCARD_REVERT SLLV
+#endif
+
+#define FIRST(unit) ((unit)*NBYTES)
+#define REST(unit)  (FIRST(unit)+NBYTES-1)
+
+#define ADDRMASK (NBYTES-1)
+
+	.set	noat
+
+LEAF(csum_partial_copy_nocheck)
+	move	AT, zero
+	b	__csum_partial_copy
+	 move	errptr, zero
+FEXPORT(__csum_partial_copy_from_user)
+	b	__csum_partial_copy_user
+	 PTR_ADDU	AT, src, len	/* See (1) above. */
+FEXPORT(__csum_and_copy_to_user)
+	move	AT, zero
+__csum_partial_copy_user:
+#ifdef CONFIG_64BIT
+	move	errptr, a4
+#else
+	lw	errptr, 16(sp)
+#endif
+__csum_partial_copy:
+	move	sum, zero
+	move	odd, zero
+	/*
+	 * Note: dst & src may be unaligned, len may be 0
+	 * Temps
+	 */
+#define rem t8
+
+	/*
+	 * The "issue break"s below are very approximate.
+	 * Issue delays for dcache fills will perturb the schedule, as will
+	 * load queue full replay traps, etc.
+	 *
+	 * If len < NBYTES use byte operations.
+	 */
+	sltu	t2, len, NBYTES
+	and	t1, dst, ADDRMASK
+	bnez	t2, copy_bytes_checklen
+	 and	t0, src, ADDRMASK
+	andi	odd, dst, 0x1			/* odd buffer? */
+	bnez	t1, dst_unaligned
+	 nop
+	bnez	t0, src_unaligned_dst_aligned
+	/*
+	 * use delay slot for fall-through
+	 * src and dst are aligned; need to compute rem
+	 */
+both_aligned:
+	 SRL	t0, len, LOG_NBYTES+3    # +3 for 8 units/iter
+	beqz	t0, cleanup_both_aligned # len < 8*NBYTES
+	 and	rem, len, (8*NBYTES-1)	 # rem = len % (8*NBYTES)
+	/*
+	 * We can not do this loop if LOAD might fail, otherwize
+	 * l_exc_copy can not calclate sum correctly.
+	 * AT==0 means LOAD should not fail.
+	 */
+	bnez	AT, cleanup_both_aligned
+	 nop
+	.align	4
+1:
+	LOAD	t0, UNIT(0)(src)
+	LOAD	t1, UNIT(1)(src)
+	LOAD	t2, UNIT(2)(src)
+	LOAD	t3, UNIT(3)(src)
+	SUB	len, len, 8*NBYTES
+	LOAD	t4, UNIT(4)(src)
+	LOAD	t7, UNIT(5)(src)
+EXC(	STORE	t0, UNIT(0)(dst),	s_exc)
+	ADDC(sum, t0)
+EXC(	STORE	t1, UNIT(1)(dst),	s_exc)
+	ADDC(sum, t1)
+	LOAD	t0, UNIT(6)(src)
+	LOAD	t1, UNIT(7)(src)
+	ADD	src, src, 8*NBYTES
+	ADD	dst, dst, 8*NBYTES
+EXC(	STORE	t2, UNIT(-6)(dst),	s_exc)
+	ADDC(sum, t2)
+EXC(	STORE	t3, UNIT(-5)(dst),	s_exc)
+	ADDC(sum, t3)
+EXC(	STORE	t4, UNIT(-4)(dst),	s_exc)
+	ADDC(sum, t4)
+EXC(	STORE	t7, UNIT(-3)(dst),	s_exc)
+	ADDC(sum, t7)
+EXC(	STORE	t0, UNIT(-2)(dst),	s_exc)
+	ADDC(sum, t0)
+EXC(	STORE	t1, UNIT(-1)(dst),	s_exc)
+	.set reorder
+	ADDC(sum, t1)
+	bne	len, rem, 1b
+	.set noreorder
+
+	/*
+	 * len == rem == the number of bytes left to copy < 8*NBYTES
+	 */
+cleanup_both_aligned:
+	beqz	len, done
+	 sltu	t0, len, 4*NBYTES
+	bnez	t0, less_than_4units
+	 and	rem, len, (NBYTES-1)	# rem = len % NBYTES
+	/*
+	 * len >= 4*NBYTES
+	 */
+EXC(	LOAD	t0, UNIT(0)(src),	l_exc)
+EXC(	LOAD	t1, UNIT(1)(src),	l_exc_copy)
+EXC(	LOAD	t2, UNIT(2)(src),	l_exc_copy)
+EXC(	LOAD	t3, UNIT(3)(src),	l_exc_copy)
+	SUB	len, len, 4*NBYTES
+	ADD	src, src, 4*NBYTES
+EXC(	STORE	t0, UNIT(0)(dst),	s_exc)
+	ADDC(sum, t0)
+EXC(	STORE	t1, UNIT(1)(dst),	s_exc)
+	ADDC(sum, t1)
+EXC(	STORE	t2, UNIT(2)(dst),	s_exc)
+	ADDC(sum, t2)
+EXC(	STORE	t3, UNIT(3)(dst),	s_exc)
+	ADDC(sum, t3)
+	beqz	len, done
+	 ADD	dst, dst, 4*NBYTES
+less_than_4units:
+	/*
+	 * rem = len % NBYTES
+	 */
+	beq	rem, len, copy_bytes
+	 nop
+1:
+EXC(	LOAD	t0, 0(src),		l_exc)
+	ADD	src, src, NBYTES
+	SUB	len, len, NBYTES
+EXC(	STORE	t0, 0(dst),		s_exc)
+	ADDC(sum, t0)
+	bne	rem, len, 1b
+	 ADD	dst, dst, NBYTES
+
+	/*
+	 * src and dst are aligned, need to copy rem bytes (rem < NBYTES)
+	 * A loop would do only a byte at a time with possible branch
+	 * mispredicts.  Can't do an explicit LOAD dst,mask,or,STORE
+	 * because can't assume read-access to dst.  Instead, use
+	 * STREST dst, which doesn't require read access to dst.
+	 *
+	 * This code should perform better than a simple loop on modern,
+	 * wide-issue mips processors because the code has fewer branches and
+	 * more instruction-level parallelism.
+	 */
+#define bits t2
+	beqz	len, done
+	 ADD	t1, dst, len	# t1 is just past last byte of dst
+	li	bits, 8*NBYTES
+	SLL	rem, len, 3	# rem = number of bits to keep
+EXC(	LOAD	t0, 0(src),		l_exc)
+	SUB	bits, bits, rem	# bits = number of bits to discard
+	SHIFT_DISCARD t0, t0, bits
+EXC(	STREST	t0, -1(t1),		s_exc)
+	SHIFT_DISCARD_REVERT t0, t0, bits
+	.set reorder
+	ADDC(sum, t0)
+	b	done
+	.set noreorder
+dst_unaligned:
+	/*
+	 * dst is unaligned
+	 * t0 = src & ADDRMASK
+	 * t1 = dst & ADDRMASK; T1 > 0
+	 * len >= NBYTES
+	 *
+	 * Copy enough bytes to align dst
+	 * Set match = (src and dst have same alignment)
+	 */
+#define match rem
+EXC(	LDFIRST	t3, FIRST(0)(src),	l_exc)
+	ADD	t2, zero, NBYTES
+EXC(	LDREST	t3, REST(0)(src),	l_exc_copy)
+	SUB	t2, t2, t1	# t2 = number of bytes copied
+	xor	match, t0, t1
+EXC(	STFIRST t3, FIRST(0)(dst),	s_exc)
+	SLL	t4, t1, 3		# t4 = number of bits to discard
+	SHIFT_DISCARD t3, t3, t4
+	/* no SHIFT_DISCARD_REVERT to handle odd buffer properly */
+	ADDC(sum, t3)
+	beq	len, t2, done
+	 SUB	len, len, t2
+	ADD	dst, dst, t2
+	beqz	match, both_aligned
+	 ADD	src, src, t2
+
+src_unaligned_dst_aligned:
+	SRL	t0, len, LOG_NBYTES+2    # +2 for 4 units/iter
+	beqz	t0, cleanup_src_unaligned
+	 and	rem, len, (4*NBYTES-1)   # rem = len % 4*NBYTES
+1:
+/*
+ * Avoid consecutive LD*'s to the same register since some mips
+ * implementations can't issue them in the same cycle.
+ * It's OK to load FIRST(N+1) before REST(N) because the two addresses
+ * are to the same unit (unless src is aligned, but it's not).
+ */
+EXC(	LDFIRST	t0, FIRST(0)(src),	l_exc)
+EXC(	LDFIRST	t1, FIRST(1)(src),	l_exc_copy)
+	SUB     len, len, 4*NBYTES
+EXC(	LDREST	t0, REST(0)(src),	l_exc_copy)
+EXC(	LDREST	t1, REST(1)(src),	l_exc_copy)
+EXC(	LDFIRST	t2, FIRST(2)(src),	l_exc_copy)
+EXC(	LDFIRST	t3, FIRST(3)(src),	l_exc_copy)
+EXC(	LDREST	t2, REST(2)(src),	l_exc_copy)
+EXC(	LDREST	t3, REST(3)(src),	l_exc_copy)
+	ADD	src, src, 4*NBYTES
+#ifdef CONFIG_CPU_SB1
+	nop				# improves slotting
+#endif
+EXC(	STORE	t0, UNIT(0)(dst),	s_exc)
+	ADDC(sum, t0)
+EXC(	STORE	t1, UNIT(1)(dst),	s_exc)
+	ADDC(sum, t1)
+EXC(	STORE	t2, UNIT(2)(dst),	s_exc)
+	ADDC(sum, t2)
+EXC(	STORE	t3, UNIT(3)(dst),	s_exc)
+	ADDC(sum, t3)
+	bne	len, rem, 1b
+	 ADD	dst, dst, 4*NBYTES
+
+cleanup_src_unaligned:
+	beqz	len, done
+	 and	rem, len, NBYTES-1  # rem = len % NBYTES
+	beq	rem, len, copy_bytes
+	 nop
+1:
+EXC(	LDFIRST t0, FIRST(0)(src),	l_exc)
+EXC(	LDREST	t0, REST(0)(src),	l_exc_copy)
+	ADD	src, src, NBYTES
+	SUB	len, len, NBYTES
+EXC(	STORE	t0, 0(dst),		s_exc)
+	ADDC(sum, t0)
+	bne	len, rem, 1b
+	 ADD	dst, dst, NBYTES
+
+copy_bytes_checklen:
+	beqz	len, done
+	 nop
+copy_bytes:
+	/* 0 < len < NBYTES  */
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+#define SHIFT_START 0
+#define SHIFT_INC 8
+#else
+#define SHIFT_START 8*(NBYTES-1)
+#define SHIFT_INC -8
+#endif
+	move	t2, zero	# partial word
+	li	t3, SHIFT_START	# shift
+/* use l_exc_copy here to return correct sum on fault */
+#define COPY_BYTE(N)			\
+EXC(	lbu	t0, N(src), l_exc_copy);	\
+	SUB	len, len, 1;		\
+EXC(	sb	t0, N(dst), s_exc);	\
+	SLLV	t0, t0, t3;		\
+	addu	t3, SHIFT_INC;		\
+	beqz	len, copy_bytes_done;	\
+	 or	t2, t0
+
+	COPY_BYTE(0)
+	COPY_BYTE(1)
+#ifdef USE_DOUBLE
+	COPY_BYTE(2)
+	COPY_BYTE(3)
+	COPY_BYTE(4)
+	COPY_BYTE(5)
+#endif
+EXC(	lbu	t0, NBYTES-2(src), l_exc_copy)
+	SUB	len, len, 1
+EXC(	sb	t0, NBYTES-2(dst), s_exc)
+	SLLV	t0, t0, t3
+	or	t2, t0
+copy_bytes_done:
+	ADDC(sum, t2)
+done:
+	/* fold checksum */
+#ifdef USE_DOUBLE
+	dsll32	v1, sum, 0
+	daddu	sum, v1
+	sltu	v1, sum, v1
+	dsra32	sum, sum, 0
+	addu	sum, v1
+#endif
+	sll	v1, sum, 16
+	addu	sum, v1
+	sltu	v1, sum, v1
+	srl	sum, sum, 16
+	addu	sum, v1
+
+	/* odd buffer alignment? */
+	beqz	odd, 1f
+	 nop
+	sll	v1, sum, 8
+	srl	sum, sum, 8
+	or	sum, v1
+	andi	sum, 0xffff
+1:
+	.set reorder
+	ADDC(sum, psum)
+	jr	ra
+	.set noreorder
+
+l_exc_copy:
+	/*
+	 * Copy bytes from src until faulting load address (or until a
+	 * lb faults)
+	 *
+	 * When reached by a faulting LDFIRST/LDREST, THREAD_BUADDR($28)
+	 * may be more than a byte beyond the last address.
+	 * Hence, the lb below may get an exception.
+	 *
+	 * Assumes src < THREAD_BUADDR($28)
+	 */
+	LOAD	t0, TI_TASK($28)
+	 li	t2, SHIFT_START
+	LOAD	t0, THREAD_BUADDR(t0)
+1:
+EXC(	lbu	t1, 0(src),	l_exc)
+	ADD	src, src, 1
+	sb	t1, 0(dst)	# can't fault -- we're copy_from_user
+	SLLV	t1, t1, t2
+	addu	t2, SHIFT_INC
+	ADDC(sum, t1)
+	bne	src, t0, 1b
+	 ADD	dst, dst, 1
+l_exc:
+	LOAD	t0, TI_TASK($28)
+	 nop
+	LOAD	t0, THREAD_BUADDR(t0)	# t0 is just past last good address
+	 nop
+	SUB	len, AT, t0		# len number of uncopied bytes
+	/*
+	 * Here's where we rely on src and dst being incremented in tandem,
+	 *   See (3) above.
+	 * dst += (fault addr - src) to put dst at first byte to clear
+	 */
+	ADD	dst, t0			# compute start address in a1
+	SUB	dst, src
+	/*
+	 * Clear len bytes starting at dst.  Can't call __bzero because it
+	 * might modify len.  An inefficient loop for these rare times...
+	 */
+	beqz	len, done
+	 SUB	src, len, 1
+1:	sb	zero, 0(dst)
+	ADD	dst, dst, 1
+	bnez	src, 1b
+	 SUB	src, src, 1
+	li	v1, -EFAULT
+	b	done
+	 sw	v1, (errptr)
+
+s_exc:
+	li	v0, -1 /* invalid checksum */
+	li	v1, -EFAULT
+	jr	ra
+	 sw	v1, (errptr)
+	END(csum_partial_copy_nocheck)
diff --git a/arch/mips/lib/csum_partial_copy.c b/arch/mips/lib/csum_partial_copy.c
deleted file mode 100644
index 0677104..0000000
--- a/arch/mips/lib/csum_partial_copy.c
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1994, 1995 Waldorf Electronics GmbH
- * Copyright (C) 1998, 1999 Ralf Baechle
- */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <asm/byteorder.h>
-#include <asm/string.h>
-#include <asm/uaccess.h>
-#include <net/checksum.h>
-
-/*
- * copy while checksumming, otherwise like csum_partial
- */
-__wsum csum_partial_copy_nocheck(const void *src,
-	void *dst, int len, __wsum sum)
-{
-	/*
-	 * It's 2:30 am and I don't feel like doing it real ...
-	 * This is lots slower than the real thing (tm)
-	 */
-	sum = csum_partial(src, len, sum);
-	memcpy(dst, src, len);
-
-	return sum;
-}
-
-EXPORT_SYMBOL(csum_partial_copy_nocheck);
-
-/*
- * Copy from userspace and compute checksum.  If we catch an exception
- * then zero the rest of the buffer.
- */
-__wsum csum_partial_copy_from_user (const void __user *src,
-	void *dst, int len, __wsum sum, int *err_ptr)
-{
-	int missing;
-
-	might_sleep();
-	missing = copy_from_user(dst, src, len);
-	if (missing) {
-		memset(dst + len - missing, 0, missing);
-		*err_ptr = -EFAULT;
-	}
-
-	return csum_partial(dst, len, sum);
-}
diff --git a/include/asm-mips/checksum.h b/include/asm-mips/checksum.h
index 9b768c3..6596fe6 100644
--- a/include/asm-mips/checksum.h
+++ b/include/asm-mips/checksum.h
@@ -29,31 +29,38 @@ #include <asm/uaccess.h>
  */
 __wsum csum_partial(const void *buff, int len, __wsum sum);
 
+__wsum __csum_partial_copy_from_user(const void __user *src, void *dst,
+				     int len, __wsum sum, int *err_ptr);
+__wsum __csum_and_copy_to_user(const void *src, void __user *dst,
+			       int len, __wsum sum, int *err_ptr);
+
 /*
  * this is a new version of the above that records errors it finds in *errp,
  * but continues and zeros the rest of the buffer.
  */
-__wsum csum_partial_copy_from_user(const void __user *src,
-					 void *dst, int len,
-					 __wsum sum, int *errp);
+static inline
+__wsum csum_partial_copy_from_user(const void __user *src, void *dst, int len,
+				   __wsum sum, int *err_ptr)
+{
+	might_sleep();
+	return __csum_partial_copy_from_user(src, dst, len, sum, err_ptr);
+}
 
 /*
  * Copy and checksum to user
  */
 #define HAVE_CSUM_COPY_USER
-static inline __wsum csum_and_copy_to_user (const void *src, void __user *dst,
-						  int len, __wsum sum,
-						  int *err_ptr)
+static inline
+__wsum csum_and_copy_to_user(const void *src, void __user *dst, int len,
+			     __wsum sum, int *err_ptr)
 {
 	might_sleep();
-	sum = csum_partial(src, len, sum);
-
-	if (copy_to_user(dst, src, len)) {
+	if (access_ok(VERIFY_WRITE, dst, len))
+		return __csum_and_copy_to_user(src, dst, len, sum, err_ptr);
+	if (len)
 		*err_ptr = -EFAULT;
-		return (__force __wsum)-1;
-	}
 
-	return sum;
+	return (__force __wsum)-1; /* invalid checksum */
 }
 
 /*
