Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2007 12:44:28 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:1701 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20030622AbXJWLoD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Oct 2007 12:44:03 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 7116B4011E;
	Tue, 23 Oct 2007 13:43:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id jviBhw6wHMXm; Tue, 23 Oct 2007 13:43:25 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 3FD504011D;
	Tue, 23 Oct 2007 13:43:25 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9NBhSEL019959;
	Tue, 23 Oct 2007 13:43:28 +0200
Date:	Tue, 23 Oct 2007 12:43:25 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH] R4000/R4400 daddiu erratum workaround
Message-ID: <Pine.LNX.4.64N.0710222036210.14902@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4572/Tue Oct 23 09:50:50 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17177
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 This complements the generic R4000/R4400 errata workaround code and adds 
bits for the daddiu problem.  In most places it just modifies handwritten 
assembly code so that the assembler is allowed to use a temporary register 
as daddiu may now be treated as a macro that expands to a sequence of li 
and daddu.  It is the AT register or, where AT is unavailable or used 
explicitly for another purpose, an explicitly-named register is selected, 
using the .set at=<reg> feature added recently to gas.  This feature is 
only used if CONFIG_CPU_DADDI_WORKAROUNDS has been set, so if the 
workaround remains disabled, the required version of binutils stays 
unchanged.

 Similarly, daddiu instructions put in branch delay slots in noreorder 
fragments are now taken out of them and the assembler is allowed to 
reorder them itself as possible (which it does making the whole idea of 
scheduling them into delay slots manually questionable).

 Also in the very few places where such a simple conversion was not 
possible, a handcoded longer sequence is implemented.

 Other than that there are changes to code responsible for building the 
TLB fault and page clear/copy handlers to avoid daddiu as appropriate.  
These are only effective if the erratum is verified to be present at the 
run time.

 Finally there is a trivial update to __delay(), because it uses daddiu in 
a branch delay slot.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 This has been verified with a DECstation 5000/150 and works for me.  It 
requires the set of generic changes sent separately to be effective.

 Comments are welcome.

 Please consider.

  Maciej

diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/arch/mips/kernel/genex.S linux-mips-2.6.23-rc5-20070904/arch/mips/kernel/genex.S
--- linux-mips-2.6.23-rc5-20070904.macro/arch/mips/kernel/genex.S	2007-09-04 04:55:19.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/arch/mips/kernel/genex.S	2007-10-03 20:59:41.000000000 +0000
@@ -6,7 +6,7 @@
  * Copyright (C) 1994 - 2000, 2001, 2003 Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  * Copyright (C) 2001 MIPS Technologies, Inc.
- * Copyright (C) 2002 Maciej W. Rozycki
+ * Copyright (C) 2002, 2007  Maciej W. Rozycki
  */
 #include <linux/init.h>
 
@@ -471,7 +471,13 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	jr	k0
 	 rfe
 #else
+#ifndef CONFIG_CPU_DADDI_WORKAROUNDS
 	LONG_ADDIU	k0, 4		/* stall on $k0 */
+#else
+	.set	at=v1
+	LONG_ADDIU	k0, 4
+	.set	noat
+#endif
 	MTC0	k0, CP0_EPC
 	/* I hope three instructions between MTC0 and ERET are enough... */
 	ori	k1, _THREAD_MASK
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/arch/mips/lib/csum_partial.S linux-mips-2.6.23-rc5-20070904/arch/mips/lib/csum_partial.S
--- linux-mips-2.6.23-rc5-20070904.macro/arch/mips/lib/csum_partial.S	2007-02-05 16:38:47.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/arch/mips/lib/csum_partial.S	2007-10-03 21:01:37.000000000 +0000
@@ -7,6 +7,7 @@
  *
  * Copyright (C) 1998, 1999 Ralf Baechle
  * Copyright (C) 1999 Silicon Graphics, Inc.
+ * Copyright (C) 2007  Maciej W. Rozycki
  */
 #include <linux/errno.h>
 #include <asm/asm.h>
@@ -52,9 +53,12 @@
 #define UNIT(unit)  ((unit)*NBYTES)
 
 #define ADDC(sum,reg)						\
+	.set	push;						\
+	.set	noat;						\
 	ADD	sum, reg;					\
 	sltu	v1, sum, reg;					\
-	ADD	sum, v1
+	ADD	sum, v1;					\
+	.set	pop
 
 #define CSUM_BIGCHUNK1(src, offset, sum, _t0, _t1, _t2, _t3)	\
 	LOAD	_t0, (offset + UNIT(0))(src);			\
@@ -178,8 +182,10 @@ move_128bytes:
 	CSUM_BIGCHUNK(src, 0x40, sum, t0, t1, t3, t4)
 	CSUM_BIGCHUNK(src, 0x60, sum, t0, t1, t3, t4)
 	LONG_SUBU	t8, t8, 0x01
+	.set	reorder				/* DADDI_WAR */
+	PTR_ADDU	src, src, 0x80
 	bnez	t8, move_128bytes
-	 PTR_ADDU	src, src, 0x80
+	.set	noreorder
 
 1:
 	beqz	t2, 1f
@@ -208,8 +214,10 @@ end_words:
 	lw	t0, (src)
 	LONG_SUBU	t8, t8, 0x1
 	ADDC(sum, t0)
+	.set	reorder				/* DADDI_WAR */
+	PTR_ADDU	src, src, 0x4
 	bnez	t8, end_words
-	 PTR_ADDU	src, src, 0x4
+	.set	noreorder
 
 /* unknown src alignment and < 8 bytes to go  */
 small_csumcpy:
@@ -246,6 +254,8 @@ small_csumcpy:
 1:	ADDC(sum, t1)
 
 	/* fold checksum */
+	.set	push
+	.set	noat
 #ifdef USE_DOUBLE
 	dsll32	v1, sum, 0
 	daddu	sum, v1
@@ -266,6 +276,7 @@ small_csumcpy:
 	srl	sum, sum, 8
 	or	sum, v1
 	andi	sum, 0xffff
+	.set	pop
 1:
 	.set	reorder
 	/* Add the passed partial csum.  */
@@ -373,7 +384,11 @@ small_csumcpy:
 
 #define ADDRMASK (NBYTES-1)
 
+#ifndef CONFIG_CPU_DADDI_WORKAROUNDS
 	.set	noat
+#else
+	.set	at=v1
+#endif
 
 LEAF(__csum_partial_copy_user)
 	PTR_ADDU	AT, src, len	/* See (1) above. */
@@ -441,8 +456,10 @@ EXC(	STORE	t6, UNIT(6)(dst),	s_exc)
 	ADDC(sum, t6)
 EXC(	STORE	t7, UNIT(7)(dst),	s_exc)
 	ADDC(sum, t7)
+	.set	reorder				/* DADDI_WAR */
+	ADD	dst, dst, 8*NBYTES
 	bgez	len, 1b
-	 ADD	dst, dst, 8*NBYTES
+	.set	noreorder
 	ADD	len, 8*NBYTES		# revert len (see above)
 
 	/*
@@ -471,8 +488,10 @@ EXC(	STORE	t2, UNIT(2)(dst),	s_exc)
 	ADDC(sum, t2)
 EXC(	STORE	t3, UNIT(3)(dst),	s_exc)
 	ADDC(sum, t3)
+	.set	reorder				/* DADDI_WAR */
+	ADD	dst, dst, 4*NBYTES
 	beqz	len, done
-	 ADD	dst, dst, 4*NBYTES
+	.set	noreorder
 less_than_4units:
 	/*
 	 * rem = len % NBYTES
@@ -485,8 +504,10 @@ EXC(	LOAD	t0, 0(src),		l_exc)
 	SUB	len, len, NBYTES
 EXC(	STORE	t0, 0(dst),		s_exc)
 	ADDC(sum, t0)
+	.set	reorder				/* DADDI_WAR */
+	ADD	dst, dst, NBYTES
 	bne	rem, len, 1b
-	 ADD	dst, dst, NBYTES
+	.set	noreorder
 
 	/*
 	 * src and dst are aligned, need to copy rem bytes (rem < NBYTES)
@@ -572,8 +593,10 @@ EXC(	STORE	t2, UNIT(2)(dst),	s_exc)
 	ADDC(sum, t2)
 EXC(	STORE	t3, UNIT(3)(dst),	s_exc)
 	ADDC(sum, t3)
+	.set	reorder				/* DADDI_WAR */
+	ADD	dst, dst, 4*NBYTES
 	bne	len, rem, 1b
-	 ADD	dst, dst, 4*NBYTES
+	.set	noreorder
 
 cleanup_src_unaligned:
 	beqz	len, done
@@ -587,8 +610,10 @@ EXC(	LDREST	t0, REST(0)(src),	l_exc_copy
 	SUB	len, len, NBYTES
 EXC(	STORE	t0, 0(dst),		s_exc)
 	ADDC(sum, t0)
+	.set	reorder				/* DADDI_WAR */
+	ADD	dst, dst, NBYTES
 	bne	len, rem, 1b
-	 ADD	dst, dst, NBYTES
+	.set	noreorder
 
 copy_bytes_checklen:
 	beqz	len, done
@@ -631,6 +656,8 @@ copy_bytes_done:
 	ADDC(sum, t2)
 done:
 	/* fold checksum */
+	.set	push
+	.set	noat
 #ifdef USE_DOUBLE
 	dsll32	v1, sum, 0
 	daddu	sum, v1
@@ -651,6 +678,7 @@ done:
 	srl	sum, sum, 8
 	or	sum, v1
 	andi	sum, 0xffff
+	.set	pop
 1:
 	.set reorder
 	ADDC(sum, psum)
@@ -678,8 +706,10 @@ EXC(	lbu	t1, 0(src),	l_exc)
 	SLLV	t1, t1, t2
 	addu	t2, SHIFT_INC
 	ADDC(sum, t1)
+	.set	reorder				/* DADDI_WAR */
+	ADD	dst, dst, 1
 	bne	src, t0, 1b
-	 ADD	dst, dst, 1
+	.set	noreorder
 l_exc:
 	LOAD	t0, TI_TASK($28)
 	 nop
@@ -697,12 +727,22 @@ l_exc:
 	 * Clear len bytes starting at dst.  Can't call __bzero because it
 	 * might modify len.  An inefficient loop for these rare times...
 	 */
+	.set	reorder				/* DADDI_WAR */
+	SUB	src, len, 1
 	beqz	len, done
-	 SUB	src, len, 1
+	.set	noreorder
 1:	sb	zero, 0(dst)
 	ADD	dst, dst, 1
+	.set	push
+	.set	noat
+#ifndef CONFIG_CPU_DADDI_WORKAROUNDS
 	bnez	src, 1b
 	 SUB	src, src, 1
+#else
+	li	v1, 1
+	bnez	src, 1b
+	 SUB	src, src, v1
+#endif
 	li	v1, -EFAULT
 	b	done
 	 sw	v1, (errptr)
@@ -712,4 +752,5 @@ s_exc:
 	li	v1, -EFAULT
 	jr	ra
 	 sw	v1, (errptr)
+	.set	pop
 	END(__csum_partial_copy_user)
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/arch/mips/lib/memcpy-inatomic.S linux-mips-2.6.23-rc5-20070904/arch/mips/lib/memcpy-inatomic.S
--- linux-mips-2.6.23-rc5-20070904.macro/arch/mips/lib/memcpy-inatomic.S	2007-02-20 05:57:28.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/arch/mips/lib/memcpy-inatomic.S	2007-10-03 21:01:42.000000000 +0000
@@ -9,6 +9,7 @@
  * Copyright (C) 1999, 2000, 01, 2002 Silicon Graphics, Inc.
  * Copyright (C) 2002 Broadcom, Inc.
  *   memcpy/copy_user author: Mark Vandevoorde
+ * Copyright (C) 2007  Maciej W. Rozycki
  *
  * Mnemonic names for arguments to memcpy/__copy_user
  */
@@ -175,7 +176,11 @@
 
 	.text
 	.set	noreorder
+#ifndef CONFIG_CPU_DADDI_WORKAROUNDS
 	.set	noat
+#else
+	.set	at=v1
+#endif
 
 /*
  * A combined memcpy/__copy_user
@@ -268,8 +273,10 @@ EXC(	LOAD	t3, UNIT(3)(src),	l_exc_copy)
 	STORE	t1, UNIT(1)(dst)
 	STORE	t2, UNIT(2)(dst)
 	STORE	t3, UNIT(3)(dst)
+	.set	reorder				/* DADDI_WAR */
+	ADD	dst, dst, 4*NBYTES
 	beqz	len, done
-	 ADD	dst, dst, 4*NBYTES
+	.set	noreorder
 less_than_4units:
 	/*
 	 * rem = len % NBYTES
@@ -281,8 +288,10 @@ EXC(	LOAD	t0, 0(src),		l_exc)
 	ADD	src, src, NBYTES
 	SUB	len, len, NBYTES
 	STORE	t0, 0(dst)
+	.set	reorder				/* DADDI_WAR */
+	ADD	dst, dst, NBYTES
 	bne	rem, len, 1b
-	 ADD	dst, dst, NBYTES
+	.set	noreorder
 
 	/*
 	 * src and dst are aligned, need to copy rem bytes (rem < NBYTES)
@@ -361,8 +370,10 @@ EXC(	LDREST	t3, REST(3)(src),	l_exc_copy
 	STORE	t2, UNIT(2)(dst)
 	STORE	t3, UNIT(3)(dst)
 	PREF(	1, 9*32(dst) )     	# 1 is PREF_STORE (not streamed)
+	.set	reorder				/* DADDI_WAR */
+	ADD	dst, dst, 4*NBYTES
 	bne	len, rem, 1b
-	 ADD	dst, dst, 4*NBYTES
+	.set	noreorder
 
 cleanup_src_unaligned:
 	beqz	len, done
@@ -375,8 +386,10 @@ EXC(	LDREST	t0, REST(0)(src),	l_exc_copy
 	ADD	src, src, NBYTES
 	SUB	len, len, NBYTES
 	STORE	t0, 0(dst)
+	.set	reorder				/* DADDI_WAR */
+	ADD	dst, dst, NBYTES
 	bne	len, rem, 1b
-	 ADD	dst, dst, NBYTES
+	.set	noreorder
 
 copy_bytes_checklen:
 	beqz	len, done
@@ -424,8 +437,10 @@ l_exc_copy:
 EXC(	lb	t1, 0(src),	l_exc)
 	ADD	src, src, 1
 	sb	t1, 0(dst)	# can't fault -- we're copy_from_user
+	.set	reorder				/* DADDI_WAR */
+	ADD	dst, dst, 1
 	bne	src, t0, 1b
-	 ADD	dst, dst, 1
+	.set	noreorder
 l_exc:
 	LOAD	t0, TI_TASK($28)
 	 nop
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/arch/mips/lib/memcpy.S linux-mips-2.6.23-rc5-20070904/arch/mips/lib/memcpy.S
--- linux-mips-2.6.23-rc5-20070904.macro/arch/mips/lib/memcpy.S	2006-09-20 20:49:39.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/arch/mips/lib/memcpy.S	2007-10-03 21:01:46.000000000 +0000
@@ -9,6 +9,7 @@
  * Copyright (C) 1999, 2000, 01, 2002 Silicon Graphics, Inc.
  * Copyright (C) 2002 Broadcom, Inc.
  *   memcpy/copy_user author: Mark Vandevoorde
+ * Copyright (C) 2007  Maciej W. Rozycki
  *
  * Mnemonic names for arguments to memcpy/__copy_user
  */
@@ -175,7 +176,11 @@
 
 	.text
 	.set	noreorder
+#ifndef CONFIG_CPU_DADDI_WORKAROUNDS
 	.set	noat
+#else
+	.set	at=v1
+#endif
 
 /*
  * A combined memcpy/__copy_user
@@ -271,8 +276,10 @@ EXC(	STORE	t0, UNIT(0)(dst),	s_exc_p4u)
 EXC(	STORE	t1, UNIT(1)(dst),	s_exc_p3u)
 EXC(	STORE	t2, UNIT(2)(dst),	s_exc_p2u)
 EXC(	STORE	t3, UNIT(3)(dst),	s_exc_p1u)
+	.set	reorder				/* DADDI_WAR */
+	ADD	dst, dst, 4*NBYTES
 	beqz	len, done
-	 ADD	dst, dst, 4*NBYTES
+	.set	noreorder
 less_than_4units:
 	/*
 	 * rem = len % NBYTES
@@ -284,8 +291,10 @@ EXC(	LOAD	t0, 0(src),		l_exc)
 	ADD	src, src, NBYTES
 	SUB	len, len, NBYTES
 EXC(	STORE	t0, 0(dst),		s_exc_p1u)
+	.set	reorder				/* DADDI_WAR */
+	ADD	dst, dst, NBYTES
 	bne	rem, len, 1b
-	 ADD	dst, dst, NBYTES
+	.set	noreorder
 
 	/*
 	 * src and dst are aligned, need to copy rem bytes (rem < NBYTES)
@@ -364,8 +373,10 @@ EXC(	STORE	t1, UNIT(1)(dst),	s_exc_p3u)
 EXC(	STORE	t2, UNIT(2)(dst),	s_exc_p2u)
 EXC(	STORE	t3, UNIT(3)(dst),	s_exc_p1u)
 	PREF(	1, 9*32(dst) )     	# 1 is PREF_STORE (not streamed)
+	.set	reorder				/* DADDI_WAR */
+	ADD	dst, dst, 4*NBYTES
 	bne	len, rem, 1b
-	 ADD	dst, dst, 4*NBYTES
+	.set	noreorder
 
 cleanup_src_unaligned:
 	beqz	len, done
@@ -378,8 +389,10 @@ EXC(	LDREST	t0, REST(0)(src),	l_exc_copy
 	ADD	src, src, NBYTES
 	SUB	len, len, NBYTES
 EXC(	STORE	t0, 0(dst),		s_exc_p1u)
+	.set	reorder				/* DADDI_WAR */
+	ADD	dst, dst, NBYTES
 	bne	len, rem, 1b
-	 ADD	dst, dst, NBYTES
+	.set	noreorder
 
 copy_bytes_checklen:
 	beqz	len, done
@@ -427,8 +440,10 @@ l_exc_copy:
 EXC(	lb	t1, 0(src),	l_exc)
 	ADD	src, src, 1
 	sb	t1, 0(dst)	# can't fault -- we're copy_from_user
+	.set	reorder				/* DADDI_WAR */
+	ADD	dst, dst, 1
 	bne	src, t0, 1b
-	 ADD	dst, dst, 1
+	.set	noreorder
 l_exc:
 	LOAD	t0, TI_TASK($28)
 	 nop
@@ -446,20 +461,33 @@ l_exc:
 	 * Clear len bytes starting at dst.  Can't call __bzero because it
 	 * might modify len.  An inefficient loop for these rare times...
 	 */
+	.set	reorder				/* DADDI_WAR */
+	SUB	src, len, 1
 	beqz	len, done
-	 SUB	src, len, 1
+	.set	noreorder
 1:	sb	zero, 0(dst)
 	ADD	dst, dst, 1
+#ifndef CONFIG_CPU_DADDI_WORKAROUNDS
 	bnez	src, 1b
 	 SUB	src, src, 1
+#else
+	.set	push
+	.set	noat
+	li	v1, 1
+	bnez	src, 1b
+	 SUB	src, src, v1
+	.set	pop
+#endif
 	jr	ra
 	 nop
 
 
-#define SEXC(n)				\
-s_exc_p ## n ## u:			\
-	jr	ra;			\
-	 ADD	len, len, n*NBYTES
+#define SEXC(n)							\
+	.set	reorder;			/* DADDI_WAR */	\
+s_exc_p ## n ## u:						\
+	ADD	len, len, n*NBYTES;				\
+	jr	ra;						\
+	.set	noreorder
 
 SEXC(8)
 SEXC(7)
@@ -471,8 +499,10 @@ SEXC(2)
 SEXC(1)
 
 s_exc_p1:
+	.set	reorder				/* DADDI_WAR */
+	ADD	len, len, 1
 	jr	ra
-	 ADD	len, len, 1
+	.set	noreorder
 s_exc:
 	jr	ra
 	 nop
@@ -502,8 +532,10 @@ r_end_bytes:
 	SUB	a2, a2, 0x1
 	sb	t0, -1(a0)
 	SUB	a1, a1, 0x1
+	.set	reorder				/* DADDI_WAR */
+	SUB	a0, a0, 0x1
 	bnez	a2, r_end_bytes
-	 SUB	a0, a0, 0x1
+	.set	noreorder
 
 r_out:
 	jr	ra
@@ -514,8 +546,10 @@ r_end_bytes_up:
 	SUB	a2, a2, 0x1
 	sb	t0, (a0)
 	ADD	a1, a1, 0x1
+	.set	reorder				/* DADDI_WAR */
+	ADD	a0, a0, 0x1
 	bnez	a2, r_end_bytes_up
-	 ADD	a0, a0, 0x1
+	.set	noreorder
 
 	jr	ra
 	 move	a2, zero
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/arch/mips/lib/memset.S linux-mips-2.6.23-rc5-20070904/arch/mips/lib/memset.S
--- linux-mips-2.6.23-rc5-20070904.macro/arch/mips/lib/memset.S	2007-02-05 16:38:47.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/arch/mips/lib/memset.S	2007-10-03 21:01:51.000000000 +0000
@@ -5,6 +5,7 @@
  *
  * Copyright (C) 1998, 1999, 2000 by Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
+ * Copyright (C) 2007  Maciej W. Rozycki
  */
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
@@ -74,8 +75,16 @@ FEXPORT(__bzero)
 	bnez		t0, small_memset
 	 andi		t0, a0, LONGMASK	/* aligned? */
 
+#ifndef CONFIG_CPU_DADDI_WORKAROUNDS
 	beqz		t0, 1f
 	 PTR_SUBU	t0, LONGSIZE		/* alignment in bytes */
+#else
+	.set		noat
+	li		AT, LONGSIZE
+	beqz		t0, 1f
+	 PTR_SUBU	t0, AT			/* alignment in bytes */
+	.set		at
+#endif
 
 #ifdef __MIPSEB__
 	EX(LONG_S_L, a1, (a0), first_fixup)	/* make word/dword aligned */
@@ -106,7 +115,7 @@ memset_partial:
 	.set		noat
 	LONG_SRL		AT, t0, 1
 	PTR_SUBU	t1, AT
-	.set		noat
+	.set		at
 #endif
 	jr		t1
 	 PTR_ADDU	a0, t0			/* dest ptr */
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/arch/mips/lib/strncpy_user.S linux-mips-2.6.23-rc5-20070904/arch/mips/lib/strncpy_user.S
--- linux-mips-2.6.23-rc5-20070904.macro/arch/mips/lib/strncpy_user.S	2005-11-04 17:02:37.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/arch/mips/lib/strncpy_user.S	2007-09-30 23:32:47.000000000 +0000
@@ -41,9 +41,9 @@ FEXPORT(__strncpy_from_user_nocheck_asm)
 	beqz		t0, 2f
 	 sb		t0, (a0)
 	PTR_ADDIU	v0, 1
-	bne		v0, a2, 1b
-	 PTR_ADDIU	a0, 1
 	.set		reorder
+	PTR_ADDIU	a0, 1
+	bne		v0, a2, 1b
 2:	PTR_ADDU	t0, a1, v0
 	xor		t0, a1
 	bltz		t0, fault
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/arch/mips/mm/pg-r4k.c linux-mips-2.6.23-rc5-20070904/arch/mips/mm/pg-r4k.c
--- linux-mips-2.6.23-rc5-20070904.macro/arch/mips/mm/pg-r4k.c	2007-02-05 16:38:47.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/arch/mips/mm/pg-r4k.c	2007-10-03 20:34:43.000000000 +0000
@@ -4,6 +4,7 @@
  * for more details.
  *
  * Copyright (C) 2003, 04, 05 Ralf Baechle (ralf@linux-mips.org)
+ * Copyright (C) 2007  Maciej W. Rozycki
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -12,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/proc_fs.h>
 
+#include <asm/bugs.h>
 #include <asm/cacheops.h>
 #include <asm/inst.h>
 #include <asm/io.h>
@@ -255,64 +257,58 @@ static inline void build_store_reg(int r
 	__build_store_reg(reg);
 }
 
-static inline void build_addiu_a2_a0(unsigned long offset)
+static inline void build_addiu_rt_rs(unsigned int rt, unsigned int rs,
+				     unsigned long offset)
 {
 	union mips_instruction mi;
 
 	BUG_ON(offset > 0x7fff);
 
-	mi.i_format.opcode     = cpu_has_64bit_gp_regs ? daddiu_op : addiu_op;
-	mi.i_format.rs         = 4;		/* $a0 */
-	mi.i_format.rt         = 6;		/* $a2 */
-	mi.i_format.simmediate = offset;
+	if (cpu_has_64bit_gp_regs && DADDI_WAR && r4k_daddiu_bug()) {
+		mi.i_format.opcode     = addiu_op;
+		mi.i_format.rs         = 0;	/* $zero */
+		mi.i_format.rt         = 25;	/* $t9 */
+		mi.i_format.simmediate = offset;
+		emit_instruction(mi);
 
+		mi.r_format.opcode     = spec_op;
+		mi.r_format.rs         = rs;
+		mi.r_format.rt         = 25;	/* $t9 */
+		mi.r_format.rd         = rt;
+		mi.r_format.re         = 0;
+		mi.r_format.func       = daddu_op;
+	} else {
+		mi.i_format.opcode     = cpu_has_64bit_gp_regs ?
+					 daddiu_op : addiu_op;
+		mi.i_format.rs         = rs;
+		mi.i_format.rt         = rt;
+		mi.i_format.simmediate = offset;
+	}
 	emit_instruction(mi);
 }
 
-static inline void build_addiu_a2(unsigned long offset)
+static inline void build_addiu_a2_a0(unsigned long offset)
 {
-	union mips_instruction mi;
-
-	BUG_ON(offset > 0x7fff);
-
-	mi.i_format.opcode     = cpu_has_64bit_gp_regs ? daddiu_op : addiu_op;
-	mi.i_format.rs         = 6;		/* $a2 */
-	mi.i_format.rt         = 6;		/* $a2 */
-	mi.i_format.simmediate = offset;
+	build_addiu_rt_rs(6, 4, offset);	/* $a2, $a0, offset */
+}
 
-	emit_instruction(mi);
+static inline void build_addiu_a2(unsigned long offset)
+{
+	build_addiu_rt_rs(6, 6, offset);	/* $a2, $a2, offset */
 }
 
 static inline void build_addiu_a1(unsigned long offset)
 {
-	union mips_instruction mi;
-
-	BUG_ON(offset > 0x7fff);
-
-	mi.i_format.opcode     = cpu_has_64bit_gp_regs ? daddiu_op : addiu_op;
-	mi.i_format.rs         = 5;		/* $a1 */
-	mi.i_format.rt         = 5;		/* $a1 */
-	mi.i_format.simmediate = offset;
+	build_addiu_rt_rs(5, 5, offset);	/* $a1, $a1, offset */
 
 	load_offset -= offset;
-
-	emit_instruction(mi);
 }
 
 static inline void build_addiu_a0(unsigned long offset)
 {
-	union mips_instruction mi;
-
-	BUG_ON(offset > 0x7fff);
-
-	mi.i_format.opcode     = cpu_has_64bit_gp_regs ? daddiu_op : addiu_op;
-	mi.i_format.rs         = 4;		/* $a0 */
-	mi.i_format.rt         = 4;		/* $a0 */
-	mi.i_format.simmediate = offset;
+	build_addiu_rt_rs(4, 4, offset);	/* $a0, $a0, offset */
 
 	store_offset -= offset;
-
-	emit_instruction(mi);
 }
 
 static inline void build_bne(unsigned int *dest)
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/arch/mips/mm/tlbex.c linux-mips-2.6.23-rc5-20070904/arch/mips/mm/tlbex.c
--- linux-mips-2.6.23-rc5-20070904.macro/arch/mips/mm/tlbex.c	2007-07-10 04:57:46.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/arch/mips/mm/tlbex.c	2007-10-03 21:13:21.000000000 +0000
@@ -6,7 +6,7 @@
  * Synthesize TLB refill handlers at runtime.
  *
  * Copyright (C) 2004,2005,2006 by Thiemo Seufer
- * Copyright (C) 2005  Maciej W. Rozycki
+ * Copyright (C) 2005, 2007  Maciej W. Rozycki
  * Copyright (C) 2006  Ralf Baechle (ralf@linux-mips.org)
  *
  * ... and the days got worse and worse and now you see
@@ -27,6 +27,7 @@
 #include <linux/string.h>
 #include <linux/init.h>
 
+#include <asm/bugs.h>
 #include <asm/pgtable.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
@@ -278,7 +279,7 @@ static void __init build_insn(u32 **buf,
 			break;
 		}
 
-	if (!ip)
+	if (!ip || (opc == insn_daddiu && r4k_daddiu_bug()))
 		panic("Unsupported TLB synthesizer instruction %d", opc);
 
 	op = ip->match;
@@ -510,23 +511,33 @@ L_LA(_r3000_write_probe_fail)
 #define i_ssnop(buf) i_sll(buf, 0, 0, 1)
 #define i_ehb(buf) i_sll(buf, 0, 0, 3)
 
-#ifdef CONFIG_64BIT
 static __init int __maybe_unused in_compat_space_p(long addr)
 {
 	/* Is this address in 32bit compat space? */
+#ifdef CONFIG_64BIT
 	return (((addr) & 0xffffffff00000000L) == 0xffffffff00000000L);
+#else
+	return 1;
+#endif
 }
 
 static __init int __maybe_unused rel_highest(long val)
 {
+#ifdef CONFIG_64BIT
 	return ((((val + 0x800080008000L) >> 48) & 0xffff) ^ 0x8000) - 0x8000;
+#else
+	return 0;
+#endif
 }
 
 static __init int __maybe_unused rel_higher(long val)
 {
+#ifdef CONFIG_64BIT
 	return ((((val + 0x80008000L) >> 32) & 0xffff) ^ 0x8000) - 0x8000;
-}
+#else
+	return 0;
 #endif
+}
 
 static __init int rel_hi(long val)
 {
@@ -540,7 +551,6 @@ static __init int rel_lo(long val)
 
 static __init void i_LA_mostly(u32 **buf, unsigned int rs, long addr)
 {
-#ifdef CONFIG_64BIT
 	if (!in_compat_space_p(addr)) {
 		i_lui(buf, rs, rel_highest(addr));
 		if (rel_higher(addr))
@@ -552,16 +562,18 @@ static __init void i_LA_mostly(u32 **buf
 		} else
 			i_dsll32(buf, rs, rs, 0);
 	} else
-#endif
 		i_lui(buf, rs, rel_hi(addr));
 }
 
-static __init void __maybe_unused i_LA(u32 **buf, unsigned int rs,
-					     long addr)
+static __init void __maybe_unused i_LA(u32 **buf, unsigned int rs, long addr)
 {
 	i_LA_mostly(buf, rs, addr);
-	if (rel_lo(addr))
-		i_ADDIU(buf, rs, rs, rel_lo(addr));
+	if (rel_lo(addr)) {
+		if (!in_compat_space_p(addr))
+			i_daddiu(buf, rs, rs, rel_lo(addr));
+		else
+			i_addiu(buf, rs, rs, rel_lo(addr));
+	}
 }
 
 /*
@@ -1068,7 +1080,10 @@ build_get_pgd_vmalloc64(u32 **p, struct 
 	} else {
 		i_LA_mostly(p, ptr, modd);
 		il_b(p, r, label_vmalloc_done);
-		i_daddiu(p, ptr, ptr, rel_lo(modd));
+		if (in_compat_space_p(modd))
+			i_addiu(p, ptr, ptr, rel_lo(modd));
+		else
+			i_daddiu(p, ptr, ptr, rel_lo(modd));
 	}
 
 	l_vmalloc(l, *p);
@@ -1089,7 +1104,10 @@ build_get_pgd_vmalloc64(u32 **p, struct 
 	} else {
 		i_LA_mostly(p, ptr, swpd);
 		il_b(p, r, label_vmalloc_done);
-		i_daddiu(p, ptr, ptr, rel_lo(swpd));
+		if (in_compat_space_p(swpd))
+			i_addiu(p, ptr, ptr, rel_lo(swpd));
+		else
+			i_daddiu(p, ptr, ptr, rel_lo(swpd));
 	}
 }
 
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/include/asm-mips/delay.h linux-mips-2.6.23-rc5-20070904/include/asm-mips/delay.h
--- linux-mips-2.6.23-rc5-20070904.macro/include/asm-mips/delay.h	2007-05-02 04:56:22.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/include/asm-mips/delay.h	2007-10-03 21:04:18.000000000 +0000
@@ -25,7 +25,7 @@ static inline void __delay(unsigned long
 		"	.set	reorder					\n"
 		: "=r" (loops)
 		: "0" (loops));
-	else if (sizeof(long) == 8)
+	else if (sizeof(long) == 8 && !DADDI_WAR)
 		__asm__ __volatile__ (
 		"	.set	noreorder				\n"
 		"	.align	3					\n"
@@ -34,6 +34,15 @@ static inline void __delay(unsigned long
 		"	.set	reorder					\n"
 		: "=r" (loops)
 		: "0" (loops));
+	else if (sizeof(long) == 8 && DADDI_WAR)
+		__asm__ __volatile__ (
+		"	.set	noreorder				\n"
+		"	.align	3					\n"
+		"1:	bnez	%0, 1b					\n"
+		"	dsubu	%0, %2					\n"
+		"	.set	reorder					\n"
+		: "=r" (loops)
+		: "0" (loops), "r" (1));
 }
 
 
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/include/asm-mips/stackframe.h linux-mips-2.6.23-rc5-20070904/include/asm-mips/stackframe.h
--- linux-mips-2.6.23-rc5-20070904.macro/include/asm-mips/stackframe.h	2007-07-10 04:56:54.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/include/asm-mips/stackframe.h	2007-10-03 20:55:29.000000000 +0000
@@ -6,6 +6,7 @@
  * Copyright (C) 1994, 95, 96, 99, 2001 Ralf Baechle
  * Copyright (C) 1994, 1995, 1996 Paul M. Antoine.
  * Copyright (C) 1999 Silicon Graphics, Inc.
+ * Copyright (C) 2007  Maciej W. Rozycki
  */
 #ifndef _ASM_STACKFRAME_H
 #define _ASM_STACKFRAME_H
@@ -145,8 +146,16 @@
 		.set	reorder
 		/* Called from user mode, new stack. */
 		get_saved_sp
+#ifndef CONFIG_CPU_DADDI_WORKAROUNDS
 8:		move	k0, sp
 		PTR_SUBU sp, k1, PT_SIZE
+#else
+		.set	at=k0
+8:		PTR_SUBU k1, PT_SIZE
+		.set	noat
+		move	k0, sp
+		move	sp, k1
+#endif
 		LONG_S	k0, PT_R29(sp)
 		LONG_S	$3, PT_R3(sp)
 		/*
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/include/asm-mips/uaccess.h linux-mips-2.6.23-rc5-20070904/include/asm-mips/uaccess.h
--- linux-mips-2.6.23-rc5-20070904.macro/include/asm-mips/uaccess.h	2007-05-02 04:56:23.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/include/asm-mips/uaccess.h	2007-10-03 20:54:57.000000000 +0000
@@ -5,6 +5,7 @@
  *
  * Copyright (C) 1996, 1997, 1998, 1999, 2000, 03, 04 by Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
+ * Copyright (C) 2007  Maciej W. Rozycki
  */
 #ifndef _ASM_UACCESS_H
 #define _ASM_UACCESS_H
@@ -387,6 +388,12 @@ extern void __put_user_unknown(void);
 	"jal\t" #destination "\n\t"
 #endif
 
+#ifndef CONFIG_CPU_DADDI_WORKAROUNDS
+#define DADDI_SCRATCH "$0"
+#else
+#define DADDI_SCRATCH "$3"
+#endif
+
 extern size_t __copy_user(void *__to, const void *__from, size_t __n);
 
 #define __invoke_copy_to_user(to,from,n)				\
@@ -403,7 +410,7 @@ extern size_t __copy_user(void *__to, co
 	: "+r" (__cu_to_r), "+r" (__cu_from_r), "+r" (__cu_len_r)	\
 	:								\
 	: "$8", "$9", "$10", "$11", "$12", "$15", "$24", "$31",		\
-	  "memory");							\
+	  DADDI_SCRATCH, "memory");					\
 	__cu_len_r;							\
 })
 
@@ -512,7 +519,7 @@ extern size_t __copy_user_inatomic(void 
 	: "+r" (__cu_to_r), "+r" (__cu_from_r), "+r" (__cu_len_r)	\
 	:								\
 	: "$8", "$9", "$10", "$11", "$12", "$15", "$24", "$31",		\
-	  "memory");							\
+	  DADDI_SCRATCH, "memory");					\
 	__cu_len_r;							\
 })
 
@@ -535,7 +542,7 @@ extern size_t __copy_user_inatomic(void 
 	: "+r" (__cu_to_r), "+r" (__cu_from_r), "+r" (__cu_len_r)	\
 	:								\
 	: "$8", "$9", "$10", "$11", "$12", "$15", "$24", "$31",		\
-	  "memory");							\
+	  DADDI_SCRATCH, "memory");					\
 	__cu_len_r;							\
 })
 
