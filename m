Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Sep 2002 10:33:17 +0200 (CEST)
Received: from ftp.mips.com ([206.31.31.227]:7394 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1122961AbSILIdQ>;
	Thu, 12 Sep 2002 10:33:16 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g8C8WWUD017396;
	Thu, 12 Sep 2002 01:32:32 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id BAA00030;
	Thu, 12 Sep 2002 01:32:30 -0700 (PDT)
Received: from mips.com (IDENT:carstenl@coplin20 [192.168.205.90])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g8C8WQb19613;
	Thu, 12 Sep 2002 10:32:27 +0200 (MEST)
Message-ID: <3D805119.5A9E3C42@mips.com>
Date: Thu, 12 Sep 2002 10:32:25 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31-P3-UP-WS-jg i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
Subject: memcpy
Content-Type: multipart/mixed;
 boundary="------------B6F61DC383BBFBDE077BE76C"
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------B6F61DC383BBFBDE077BE76C
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

I have found another bug in the 64-bit memcpy function, so I figured it
was time to use the 32-bit version (as it's more or less are prepared
for 64-bit).
With a few fixes the memcpy.S file can now be shared between the 32-bit
and 64-bit kernel (the only difference is the definition of USE_DOUBLE).

I have attached the patch for arch/mips/lib/memcpy.S and the full file
for the arch/mips64/lib/memcpy.S

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------B6F61DC383BBFBDE077BE76C
Content-Type: text/plain; charset=iso-8859-15;
 name="memcpy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="memcpy.patch"

Index: arch/mips/lib/memcpy.S
===================================================================
RCS file: /cvs/linux/arch/mips/lib/memcpy.S,v
retrieving revision 1.6.2.3
diff -u -r1.6.2.3 memcpy.S
--- arch/mips/lib/memcpy.S	2002/06/30 23:10:57	1.6.2.3
+++ arch/mips/lib/memcpy.S	2002/09/12 08:12:21
@@ -99,6 +99,24 @@
 #define NBYTES 8
 #define LOG_NBYTES 3
 
+/* 
+ * As we are sharing code base with the mips32 tree (which use the o32 ABI
+ * register definitions). We need to redefine the register definitions from
+ * the n64 ABI register naming to the o32 ABI register naming.
+ */
+#undef t0
+#undef t1
+#undef t2
+#undef t3
+#define t0	$8
+#define t1	$9
+#define t2	$10
+#define t3	$11
+#define t4	$12
+#define t5	$13
+#define t6	$14
+#define t7	$15
+	
 #else
 
 #define LOAD   lw
@@ -385,7 +403,7 @@
 	 *
 	 * Assumes src < THREAD_BUADDR($28)
 	 */
-	lw	t0, THREAD_BUADDR($28)
+	LOAD	t0, THREAD_BUADDR($28)
 1:
 EXC(	lb	t1, 0(src),	l_exc)
 	ADD	src, src, 1
@@ -393,16 +411,16 @@
 	bne	src, t0, 1b
 	 ADD	dst, dst, 1
 l_exc:
-	lw	t0, THREAD_BUADDR($28)	# t0 is just past last good address
+	LOAD	t0, THREAD_BUADDR($28)	# t0 is just past last good address
 	 nop
-	subu	len, AT, t0		# len number of uncopied bytes
+	SUB	len, AT, t0		# len number of uncopied bytes
 	/*
 	 * Here's where we rely on src and dst being incremented in tandem,
 	 *   See (3) above.
 	 * dst += (fault addr - src) to put dst at first byte to clear
 	 */
-	addu	dst, t0			# compute start address in a1
-	subu	dst, src
+	ADD	dst, t0			# compute start address in a1
+	SUB	dst, src
 	/*
 	 * Clear len bytes starting at dst.  Can't call __bzero because it
 	 * might modify len.  An inefficient loop for these rare times...
@@ -440,8 +458,8 @@
 
 	.align	5
 LEAF(memmove)
-	addu	t0, a0, a2
-	addu	t1, a1, a2
+	ADD	t0, a0, a2
+	ADD	t1, a1, a2
 	sltu	t0, a1, t0			# dst + len <= src -> memcpy
 	sltu	t1, a0, t1			# dst >= src + len -> memcpy
 	and	t0, t1
@@ -455,16 +473,16 @@
 	 sltu	t0, a1, a0
 	beqz	t0, r_end_bytes_up		# src >= dst
 	 nop
-	addu	a0, a2				# dst = dst + len
-	addu	a1, a2				# src = src + len
+	ADD	a0, a2				# dst = dst + len
+	ADD	a1, a2				# src = src + len
 
 r_end_bytes:
 	lb	t0, -1(a1)
-	subu	a2, a2, 0x1
+	SUB	a2, a2, 0x1
 	sb	t0, -1(a0)
-	subu	a1, a1, 0x1
+	SUB	a1, a1, 0x1
 	bnez	a2, r_end_bytes
-	 subu	a0, a0, 0x1
+	 SUB	a0, a0, 0x1
 
 r_out:
 	jr	ra
@@ -472,11 +490,11 @@
 
 r_end_bytes_up:
 	lb	t0, (a1)
-	subu	a2, a2, 0x1
+	SUB	a2, a2, 0x1
 	sb	t0, (a0)
-	addu	a1, a1, 0x1
+	ADD	a1, a1, 0x1
 	bnez	a2, r_end_bytes_up
-	 addu	a0, a0, 0x1
+	 ADD	a0, a0, 0x1
 
 	jr	ra
 	 move	a2, zero

--------------B6F61DC383BBFBDE077BE76C
Content-Type: text/plain; charset=iso-8859-15;
 name="memcpy.S"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="memcpy.S"

/*
 * This file is subject to the terms and conditions of the GNU General Public
 * License.  See the file "COPYING" in the main directory of this archive
 * for more details.
 *
 * Unified implementation of memcpy, memmove and the __copy_user backend.
 *
 * Copyright (C) 1998, 99, 2000, 01, 2002 Ralf Baechle (ralf@gnu.org)
 * Copyright (C) 1999, 2000, 01, 2002 Silicon Graphics, Inc.
 * Copyright (C) 2002 Broadcom, Inc.
 *   memcpy/copy_user author: Mark Vandevoorde
 *
 * Mnemonic names for arguments to memcpy/__copy_user
 */
#include <linux/config.h>
#include <asm/asm.h>
#include <asm/offset.h>
#include <asm/regdef.h>

#define dst a0
#define src a1
#define len a2

/*
 * Spec
 *
 * memcpy copies len bytes from src to dst and sets v0 to dst.
 * It assumes that
 *   - src and dst don't overlap
 *   - src is readable
 *   - dst is writable
 * memcpy uses the standard calling convention
 *
 * __copy_user copies up to len bytes from src to dst and sets a2 (len) to
 * the number of uncopied bytes due to an exception caused by a read or write.
 * __copy_user assumes that src and dst don't overlap, and that the call is
 * implementing one of the following:
 *   copy_to_user
 *     - src is readable  (no exceptions when reading src)
 *   copy_from_user
 *     - dst is writable  (no exceptions when writing dst)
 * __copy_user uses a non-standard calling convention; see
 * include/asm-mips/uaccess.h
 *
 * When an exception happens on a load, the handler must
 # ensure that all of the destination buffer is overwritten to prevent
 * leaking information to user mode programs.
 */

/*
 * Implementation
 */

/*
 * The exception handler for loads requires that:
 *  1- AT contain the address of the byte just past the end of the source
 *     of the copy,
 *  2- src_entry <= src < AT, and
 *  3- (dst - src) == (dst_entry - src_entry),
 * The _entry suffix denotes values when __copy_user was called.
 *
 * (1) is set up up by uaccess.h and maintained by not writing AT in copy_user
 * (2) is met by incrementing src by the number of bytes copied
 * (3) is met by not doing loads between a pair of increments of dst and src
 *
 * The exception handlers for stores adjust len (if necessary) and return.
 * These handlers do not need to overwrite any data.
 *
 * For __rmemcpy and memmove an exception is always a kernel bug, therefore
 * they're not protected.
 */

#define EXC(inst_reg,addr,handler)		\
9:	inst_reg, addr;				\
	.section __ex_table,"a";		\
	PTR	9b, handler;			\
	.previous

/*
 * In the mips64 (not mips32) tree, so we use doubles
 */
#define USE_DOUBLE

#if defined(USE_DOUBLE)

#define LOAD   ld
#define LOADL  ldl
#define LOADR  ldr
#define STOREL sdl
#define STORER sdr
#define STORE  sd
#define ADD    daddu
#define SUB    dsubu
#define SRL    dsrl
#define SRA    dsra
#define SLL    dsll
#define SLLV   dsllv
#define SRLV   dsrlv
#define NBYTES 8
#define LOG_NBYTES 3

/* 
 * As we are sharing code base with the mips32 tree (which use the o32 ABI
 * register definitions). We need to redefine the register definitions from
 * the n64 ABI register naming to the o32 ABI register naming.
 */
#undef t0
#undef t1
#undef t2
#undef t3
#define t0	$8
#define t1	$9
#define t2	$10
#define t3	$11
#define t4	$12
#define t5	$13
#define t6	$14
#define t7	$15
	
#else

#define LOAD   lw
#define LOADL  lwl
#define LOADR  lwr
#define STOREL swl
#define STORER swr
#define STORE  sw
#define ADD    addu
#define SUB    subu
#define SRL    srl
#define SLL    sll
#define SRA    sra
#define SLLV   sllv
#define SRLV   srlv
#define NBYTES 4
#define LOG_NBYTES 2

#endif /* USE_DOUBLE */

#ifdef CONFIG_CPU_LITTLE_ENDIAN
#define LDFIRST LOADR
#define LDREST  LOADL
#define STFIRST STORER
#define STREST  STOREL
#define SHIFT_DISCARD SLLV
#else
#define LDFIRST LOADL
#define LDREST  LOADR
#define STFIRST STOREL
#define STREST  STORER
#define SHIFT_DISCARD SRLV
#endif

#define FIRST(unit) ((unit)*NBYTES)
#define REST(unit)  (FIRST(unit)+NBYTES-1)
#define UNIT(unit)  FIRST(unit)

#define ADDRMASK (NBYTES-1)

	.text
	.set	noreorder
	.set	noat

/*
 * A combined memcpy/__copy_user
 * __copy_user sets len to 0 for success; else to an upper bound of
 * the number of uncopied bytes.
 * memcpy sets v0 to dst.
 */
	.align	5
LEAF(memcpy)					/* a0=dst a1=src a2=len */
	move	v0, dst				/* return value */
__memcpy:
FEXPORT(__copy_user)
	/*
	 * Note: dst & src may be unaligned, len may be 0
	 * Temps
	 */
#define rem t8

	/*
	 * The "issue break"s below are very approximate.
	 * Issue delays for dcache fills will perturb the schedule, as will
	 * load queue full replay traps, etc.
	 *
	 * If len < NBYTES use byte operations.
	 */
	PREF(	0, 0(src) )
	PREF(	1, 0(dst) )
	sltu	t2, len, NBYTES
	and	t1, dst, ADDRMASK
	PREF(	0, 1*32(src) )
	PREF(	1, 1*32(dst) )
	bnez	t2, copy_bytes_checklen
	 and	t0, src, ADDRMASK
	PREF(	0, 2*32(src) )
	PREF(	1, 2*32(dst) )
	bnez	t1, dst_unaligned
	 nop
	bnez	t0, src_unaligned_dst_aligned
	/*
	 * use delay slot for fall-through
	 * src and dst are aligned; need to compute rem
	 */
both_aligned:
	 SRL	t0, len, LOG_NBYTES+3    # +3 for 8 units/iter
	beqz	t0, cleanup_both_aligned # len < 8*NBYTES
	 and	rem, len, (8*NBYTES-1)	 # rem = len % (8*NBYTES)
	PREF(	0, 3*32(src) )
	PREF(	1, 3*32(dst) )
	.align	4
1:
EXC(	LOAD	t0, UNIT(0)(src),	l_exc)
EXC(	LOAD	t1, UNIT(1)(src),	l_exc_copy)
EXC(	LOAD	t2, UNIT(2)(src),	l_exc_copy)
EXC(	LOAD	t3, UNIT(3)(src),	l_exc_copy)
	SUB	len, len, 8*NBYTES
EXC(	LOAD	t4, UNIT(4)(src),	l_exc_copy)
EXC(	LOAD	t7, UNIT(5)(src),	l_exc_copy)
EXC(	STORE	t0, UNIT(0)(dst),	s_exc_p8u)
EXC(	STORE	t1, UNIT(1)(dst),	s_exc_p7u)
EXC(	LOAD	t0, UNIT(6)(src),	l_exc_copy)
EXC(	LOAD	t1, UNIT(7)(src),	l_exc_copy)
	ADD	src, src, 8*NBYTES
	ADD	dst, dst, 8*NBYTES
EXC(	STORE	t2, UNIT(-6)(dst),	s_exc_p6u)
EXC(	STORE	t3, UNIT(-5)(dst),	s_exc_p5u)
EXC(	STORE	t4, UNIT(-4)(dst),	s_exc_p4u)
EXC(	STORE	t7, UNIT(-3)(dst),	s_exc_p3u)
EXC(	STORE	t0, UNIT(-2)(dst),	s_exc_p2u)
EXC(	STORE	t1, UNIT(-1)(dst),	s_exc_p1u)
	PREF(	0, 8*32(src) )
	PREF(	1, 8*32(dst) )
	bne	len, rem, 1b
	 nop

	/*
	 * len == rem == the number of bytes left to copy < 8*NBYTES
	 */
cleanup_both_aligned:
	beqz	len, done
	 sltu	t0, len, 4*NBYTES
	bnez	t0, less_than_4units
	 and	rem, len, (NBYTES-1)	# rem = len % NBYTES
	/*
	 * len >= 4*NBYTES
	 */
EXC(	LOAD	t0, UNIT(0)(src),	l_exc)
EXC(	LOAD	t1, UNIT(1)(src),	l_exc_copy)
EXC(	LOAD	t2, UNIT(2)(src),	l_exc_copy)
EXC(	LOAD	t3, UNIT(3)(src),	l_exc_copy)
	SUB	len, len, 4*NBYTES
	ADD	src, src, 4*NBYTES
EXC(	STORE	t0, UNIT(0)(dst),	s_exc_p4u)
EXC(	STORE	t1, UNIT(1)(dst),	s_exc_p3u)
EXC(	STORE	t2, UNIT(2)(dst),	s_exc_p2u)
EXC(	STORE	t3, UNIT(3)(dst),	s_exc_p1u)
	beqz	len, done
	 ADD	dst, dst, 4*NBYTES
less_than_4units:
	/*
	 * rem = len % NBYTES
	 */
	beq	rem, len, copy_bytes
	 nop
1:
EXC(	LOAD	 t0, 0(src),		l_exc)
	ADD	src, src, NBYTES
	SUB	len, len, NBYTES
EXC(	STORE	t0, 0(dst),		s_exc_p1u)
	bne	rem, len, 1b
	 ADD	dst, dst, NBYTES

	/*
	 * src and dst are aligned, need to copy rem bytes (rem < NBYTES)
	 * A loop would do only a byte at a time with possible branch
	 * mispredicts.  Can't do an explicit LOAD dst,mask,or,STORE
	 * because can't assume read-access to dst.  Instead, use
	 * STREST dst, which doesn't require read access to dst.
	 *
	 * This code should perform better than a simple loop on modern,
	 * wide-issue mips processors because the code has fewer branches and
	 * more instruction-level parallelism.
	 */
#define bits t2
	beqz	len, done
	 ADD	t1, dst, len	# t1 is just past last byte of dst
	li	bits, 8*NBYTES
	SLL	rem, len, 3	# rem = number of bits to keep
EXC(	LOAD	t0, 0(src),		l_exc)
	SUB	bits, bits, rem	# bits = number of bits to discard
	SHIFT_DISCARD t0, t0, bits
EXC(	STREST	t0, -1(t1),		s_exc)
	jr	ra
	 move	len, zero
dst_unaligned:
	/*
	 * dst is unaligned
	 * t0 = src & ADDRMASK
	 * t1 = dst & ADDRMASK; T1 > 0
	 * len >= NBYTES
	 *
	 * Copy enough bytes to align dst
	 * Set match = (src and dst have same alignment)
	 */
#define match rem
EXC(	LDFIRST	t3, FIRST(0)(src),	l_exc)
	ADD	t2, zero, NBYTES
EXC(	LDREST	t3, REST(0)(src),	l_exc_copy)
	SUB	t2, t2, t1	# t2 = number of bytes copied
	xor	match, t0, t1
EXC(	STFIRST t3, FIRST(0)(dst),	s_exc)
	beq	len, t2, done
	 SUB	len, len, t2
	ADD	dst, dst, t2
	beqz	match, both_aligned
	 ADD	src, src, t2

src_unaligned_dst_aligned:
	SRL	t0, len, LOG_NBYTES+2    # +2 for 4 units/iter
	PREF(	0, 3*32(src) )
	beqz	t0, cleanup_src_unaligned
	 and	rem, len, (4*NBYTES-1)   # rem = len % 4*NBYTES
	PREF(	1, 3*32(dst) )
1:
/*
 * Avoid consecutive LD*'s to the same register since some mips
 * implementations can't issue them in the same cycle.
 * It's OK to load FIRST(N+1) before REST(N) because the two addresses
 * are to the same unit (unless src is aligned, but it's not).
 */
EXC(	LDFIRST	t0, FIRST(0)(src),	l_exc)
EXC(	LDFIRST	t1, FIRST(1)(src),	l_exc_copy)
	SUB     len, len, 4*NBYTES
EXC(	LDREST	t0, REST(0)(src),	l_exc_copy)
EXC(	LDREST	t1, REST(1)(src),	l_exc_copy)
EXC(	LDFIRST	t2, FIRST(2)(src),	l_exc_copy)
EXC(	LDFIRST	t3, FIRST(3)(src),	l_exc_copy)
EXC(	LDREST	t2, REST(2)(src),	l_exc_copy)
EXC(	LDREST	t3, REST(3)(src),	l_exc_copy)
	PREF(	0, 9*32(src) )	   	# 0 is PREF_LOAD  (not streamed)
	ADD	src, src, 4*NBYTES
#ifdef CONFIG_CPU_SB1
	nop			   	# improves slotting
#endif
EXC(	STORE	t0, UNIT(0)(dst),	s_exc_p4u)
EXC(	STORE	t1, UNIT(1)(dst),	s_exc_p3u)
EXC(	STORE	t2, UNIT(2)(dst),	s_exc_p2u)
EXC(	STORE	t3, UNIT(3)(dst),	s_exc_p1u)
	PREF(	1, 9*32(dst) )     	# 1 is PREF_STORE (not streamed)
	bne	len, rem, 1b
	 ADD	dst, dst, 4*NBYTES

cleanup_src_unaligned:
	beqz	len, done
	 and	rem, len, NBYTES-1  # rem = len % NBYTES
	beq	rem, len, copy_bytes
1:
EXC(	 LDFIRST t0, FIRST(0)(src),	l_exc)
EXC(	LDREST	t0, REST(0)(src),	l_exc_copy)
	ADD	src, src, NBYTES
	SUB	len, len, NBYTES
EXC(	STORE	t0, 0(dst),		s_exc_p1u)
	bne	len, rem, 1b
	 ADD	dst, dst, NBYTES

copy_bytes_checklen:
	beqz	len, done
	 nop
copy_bytes:
	/* 0 < len < NBYTES  */
#define COPY_BYTE(N)			\
EXC(	lb	t0, N(src), l_exc);	\
	SUB	len, len, 1;		\
	beqz	len, done;		\
EXC(	 sb	t0, N(dst), s_exc_p1)

	COPY_BYTE(0)
	COPY_BYTE(1)
#ifdef USE_DOUBLE
	COPY_BYTE(2)
	COPY_BYTE(3)
	COPY_BYTE(4)
	COPY_BYTE(5)
#endif
EXC(	lb	t0, NBYTES-2(src), l_exc)
	SUB	len, len, 1
	jr	ra
EXC(	 sb	t0, NBYTES-2(dst), s_exc_p1)
done:
	jr	ra
	 nop
	END(memcpy)

l_exc_copy:
	/*
	 * Copy bytes from src until faulting load address (or until a
	 * lb faults)
	 *
	 * When reached by a faulting LDFIRST/LDREST, THREAD_BUADDR($28)
	 * may be more than a byte beyond the last address.
	 * Hence, the lb below may get an exception.
	 *
	 * Assumes src < THREAD_BUADDR($28)
	 */
	LOAD	t0, THREAD_BUADDR($28)
1:
EXC(	lb	t1, 0(src),	l_exc)
	ADD	src, src, 1
	sb	t1, 0(dst)	# can't fault -- we're copy_from_user
	bne	src, t0, 1b
	 ADD	dst, dst, 1
l_exc:
	LOAD	t0, THREAD_BUADDR($28)	# t0 is just past last good address
	 nop
	SUB	len, AT, t0		# len number of uncopied bytes
	/*
	 * Here's where we rely on src and dst being incremented in tandem,
	 *   See (3) above.
	 * dst += (fault addr - src) to put dst at first byte to clear
	 */
	ADD	dst, t0			# compute start address in a1
	SUB	dst, src
	/*
	 * Clear len bytes starting at dst.  Can't call __bzero because it
	 * might modify len.  An inefficient loop for these rare times...
	 */
	beqz	len, done
	 SUB	src, len, 1
1:	sb	zero, 0(dst)
	ADD	dst, dst, 1
	bnez	src, 1b
	 SUB	src, src, 1
	jr	ra
	 nop


#define SEXC(n)				\
s_exc_p ## n ## u:			\
	jr	ra;			\
	 ADD	len, len, n*NBYTES

SEXC(8)
SEXC(7)
SEXC(6)
SEXC(5)
SEXC(4)
SEXC(3)
SEXC(2)
SEXC(1)

s_exc_p1:
	jr	ra
	 ADD	len, len, 1
s_exc:
	jr	ra
	 nop

	.align	5
LEAF(memmove)
	ADD	t0, a0, a2
	ADD	t1, a1, a2
	sltu	t0, a1, t0			# dst + len <= src -> memcpy
	sltu	t1, a0, t1			# dst >= src + len -> memcpy
	and	t0, t1
	beqz	t0, __memcpy
	 move	v0, a0				/* return value */
	beqz	a2, r_out
	END(memmove)

	/* fall through to __rmemcpy */
LEAF(__rmemcpy)					/* a0=dst a1=src a2=len */
	 sltu	t0, a1, a0
	beqz	t0, r_end_bytes_up		# src >= dst
	 nop
	ADD	a0, a2				# dst = dst + len
	ADD	a1, a2				# src = src + len

r_end_bytes:
	lb	t0, -1(a1)
	SUB	a2, a2, 0x1
	sb	t0, -1(a0)
	SUB	a1, a1, 0x1
	bnez	a2, r_end_bytes
	 SUB	a0, a0, 0x1

r_out:
	jr	ra
	 move	a2, zero

r_end_bytes_up:
	lb	t0, (a1)
	SUB	a2, a2, 0x1
	sb	t0, (a0)
	ADD	a1, a1, 0x1
	bnez	a2, r_end_bytes_up
	 ADD	a0, a0, 0x1

	jr	ra
	 move	a2, zero
	END(__rmemcpy)

--------------B6F61DC383BBFBDE077BE76C--
