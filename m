Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2006 16:31:55 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:58330 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28575511AbWL1Qbv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2006 16:31:51 +0000
Received: from localhost (p5142-ipad201funabasi.chiba.ocn.ne.jp [222.146.68.142])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A83BCBAF6; Fri, 29 Dec 2006 01:31:46 +0900 (JST)
Date:	Fri, 29 Dec 2006 01:31:45 +0900 (JST)
Message-Id: <20061229.013145.126760356.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH 1/3] Fix csum_partial_copy_from_user (take 2)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061228.003413.27954771.anemo@mba.ocn.ne.jp>
References: <20061227.005407.59032424.anemo@mba.ocn.ne.jp>
	<20061228.003413.27954771.anemo@mba.ocn.ne.jp>
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
X-archive-position: 13524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 28 Dec 2006 00:34:13 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> I forgot to change function names in comment block.  Revised.

Revised again.  Fix "warning: cast adds address space to expression"
sparse warnings.


Subject: [PATCH 1/3] Fix csum_partial_copy_from_user (take 2)

I found that asm version of csum_partial_copy_from_user() introduced
in e9e016815f264227b6260f77ca84f1c43cf8b9bd was less effective.

For csum_partial_copy_from_user() case, "both_aligned" 8-word copy/sum
loop block is skipped to handle LOAD failure properly, and 4-word
copy/sum block is not loop, thus we will loop at ineffective
"less_than_4units" block.

This patch re-arrange register usages so that t0-t7 can be used in
"both_aligned" loop.  This makes "both_aligned" loop can be used for
copy_from_user case too.  This patch also cleanup codes around entry
point.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/lib/csum_partial.S |   77 +++++++++++++++--------------------------
 include/asm-mips/checksum.h  |   12 +++---
 2 files changed, 36 insertions(+), 53 deletions(-)

diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index ec0744d..daba7d8 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -279,8 +279,7 @@ #endif
  * checksum and copy routines based on memcpy.S
  *
  *	csum_partial_copy_nocheck(src, dst, len, sum)
- *	__csum_partial_copy_from_user(src, dst, len, sum, errp)
- *	__csum_and_copy_to_user(src, dst, len, sum, errp)
+ *	__csum_and_copy_user(src, dst, len, sum, errp)
  *
  * See "Spec" in memcpy.S for details.  Unlike __copy_user, all
  * function in this file use the standard calling convention.
@@ -291,8 +290,8 @@ #define dst a1
 #define len a2
 #define psum a3
 #define sum v0
-#define odd t5
-#define errptr t6
+#define odd t8
+#define errptr t9
 
 /*
  * The exception handler for loads requires that:
@@ -376,30 +375,20 @@ #define ADDRMASK (NBYTES-1)
 
 	.set	noat
 
-LEAF(csum_partial_copy_nocheck)
-	move	AT, zero
-	b	__csum_partial_copy
-	 move	errptr, zero
-FEXPORT(__csum_partial_copy_from_user)
-	b	__csum_partial_copy_user
-	 PTR_ADDU	AT, src, len	/* See (1) above. */
-FEXPORT(__csum_and_copy_to_user)
-	move	AT, zero
-__csum_partial_copy_user:
+LEAF(__csum_partial_copy_user)
+	PTR_ADDU	AT, src, len	/* See (1) above. */
 #ifdef CONFIG_64BIT
 	move	errptr, a4
 #else
 	lw	errptr, 16(sp)
 #endif
-__csum_partial_copy:
+FEXPORT(csum_partial_copy_nocheck)
 	move	sum, zero
 	move	odd, zero
 	/*
 	 * Note: dst & src may be unaligned, len may be 0
 	 * Temps
 	 */
-#define rem t8
-
 	/*
 	 * The "issue break"s below are very approximate.
 	 * Issue delays for dcache fills will perturb the schedule, as will
@@ -422,51 +411,45 @@ #define rem t8
 both_aligned:
 	 SRL	t0, len, LOG_NBYTES+3    # +3 for 8 units/iter
 	beqz	t0, cleanup_both_aligned # len < 8*NBYTES
-	 and	rem, len, (8*NBYTES-1)	 # rem = len % (8*NBYTES)
-	/*
-	 * We can not do this loop if LOAD might fail, otherwize
-	 * l_exc_copy can not calclate sum correctly.
-	 * AT==0 means LOAD should not fail.
-	 */
-	bnez	AT, cleanup_both_aligned
 	 nop
+	SUB	len, 8*NBYTES		# subtract here for bgez loop
 	.align	4
 1:
-	LOAD	t0, UNIT(0)(src)
-	LOAD	t1, UNIT(1)(src)
-	LOAD	t2, UNIT(2)(src)
-	LOAD	t3, UNIT(3)(src)
+EXC(	LOAD	t0, UNIT(0)(src),	l_exc)
+EXC(	LOAD	t1, UNIT(1)(src),	l_exc_copy)
+EXC(	LOAD	t2, UNIT(2)(src),	l_exc_copy)
+EXC(	LOAD	t3, UNIT(3)(src),	l_exc_copy)
+EXC(	LOAD	t4, UNIT(4)(src),	l_exc_copy)
+EXC(	LOAD	t5, UNIT(5)(src),	l_exc_copy)
+EXC(	LOAD	t6, UNIT(6)(src),	l_exc_copy)
+EXC(	LOAD	t7, UNIT(7)(src),	l_exc_copy)
 	SUB	len, len, 8*NBYTES
-	LOAD	t4, UNIT(4)(src)
-	LOAD	t7, UNIT(5)(src)
+	ADD	src, src, 8*NBYTES
 EXC(	STORE	t0, UNIT(0)(dst),	s_exc)
 	ADDC(sum, t0)
 EXC(	STORE	t1, UNIT(1)(dst),	s_exc)
 	ADDC(sum, t1)
-	LOAD	t0, UNIT(6)(src)
-	LOAD	t1, UNIT(7)(src)
-	ADD	src, src, 8*NBYTES
-	ADD	dst, dst, 8*NBYTES
-EXC(	STORE	t2, UNIT(-6)(dst),	s_exc)
+EXC(	STORE	t2, UNIT(2)(dst),	s_exc)
 	ADDC(sum, t2)
-EXC(	STORE	t3, UNIT(-5)(dst),	s_exc)
+EXC(	STORE	t3, UNIT(3)(dst),	s_exc)
 	ADDC(sum, t3)
-EXC(	STORE	t4, UNIT(-4)(dst),	s_exc)
+EXC(	STORE	t4, UNIT(4)(dst),	s_exc)
 	ADDC(sum, t4)
-EXC(	STORE	t7, UNIT(-3)(dst),	s_exc)
+EXC(	STORE	t5, UNIT(5)(dst),	s_exc)
+	ADDC(sum, t5)
+EXC(	STORE	t6, UNIT(6)(dst),	s_exc)
+	ADDC(sum, t6)
+EXC(	STORE	t7, UNIT(7)(dst),	s_exc)
 	ADDC(sum, t7)
-EXC(	STORE	t0, UNIT(-2)(dst),	s_exc)
-	ADDC(sum, t0)
-EXC(	STORE	t1, UNIT(-1)(dst),	s_exc)
-	.set reorder
-	ADDC(sum, t1)
-	bne	len, rem, 1b
-	.set noreorder
+	bgez	len, 1b
+	 ADD	dst, dst, 8*NBYTES
+	ADD	len, 8*NBYTES		# revert len (see above)
 
 	/*
-	 * len == rem == the number of bytes left to copy < 8*NBYTES
+	 * len == the number of bytes left to copy < 8*NBYTES
 	 */
 cleanup_both_aligned:
+#define rem t7
 	beqz	len, done
 	 sltu	t0, len, 4*NBYTES
 	bnez	t0, less_than_4units
@@ -729,4 +712,4 @@ s_exc:
 	li	v1, -EFAULT
 	jr	ra
 	 sw	v1, (errptr)
-	END(csum_partial_copy_nocheck)
+	END(__csum_partial_copy_user)
diff --git a/include/asm-mips/checksum.h b/include/asm-mips/checksum.h
index 6596fe6..24cdcc6 100644
--- a/include/asm-mips/checksum.h
+++ b/include/asm-mips/checksum.h
@@ -29,10 +29,8 @@ #include <asm/uaccess.h>
  */
 __wsum csum_partial(const void *buff, int len, __wsum sum);
 
-__wsum __csum_partial_copy_from_user(const void __user *src, void *dst,
-				     int len, __wsum sum, int *err_ptr);
-__wsum __csum_and_copy_to_user(const void *src, void __user *dst,
-			       int len, __wsum sum, int *err_ptr);
+__wsum __csum_partial_copy_user(const void *src, void *dst,
+				int len, __wsum sum, int *err_ptr);
 
 /*
  * this is a new version of the above that records errors it finds in *errp,
@@ -43,7 +41,8 @@ __wsum csum_partial_copy_from_user(const
 				   __wsum sum, int *err_ptr)
 {
 	might_sleep();
-	return __csum_partial_copy_from_user(src, dst, len, sum, err_ptr);
+	return __csum_partial_copy_user((__force void *)src, dst,
+					len, sum, err_ptr);
 }
 
 /*
@@ -56,7 +55,8 @@ __wsum csum_and_copy_to_user(const void 
 {
 	might_sleep();
 	if (access_ok(VERIFY_WRITE, dst, len))
-		return __csum_and_copy_to_user(src, dst, len, sum, err_ptr);
+		return __csum_partial_copy_user(src, (__force void *)dst,
+						len, sum, err_ptr);
 	if (len)
 		*err_ptr = -EFAULT;
 
