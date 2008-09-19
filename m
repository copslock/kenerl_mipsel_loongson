Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 02:14:52 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:25310 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S20031853AbYISBOt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 19 Sep 2008 02:14:49 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m8J1Eldw002691;
	Fri, 19 Sep 2008 03:14:47 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m8J1Ej2Y002686;
	Fri, 19 Sep 2008 03:14:45 +0200
Date:	Fri, 19 Sep 2008 03:14:45 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	u1@terran.org, macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: MIPS checksum bug
Message-ID: <20080919011445.GA2639@linux-mips.org>
References: <Pine.LNX.4.55.0809171104290.17103@cliff.in.clinika.pl> <20080917.222350.41199051.anemo@mba.ocn.ne.jp> <BD7F24AB-4B0C-4FA4-ADB3-5A86E7A4624F@terran.org> <20080919.011704.59652451.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080919.011704.59652451.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 19, 2008 at 01:17:04AM +0900, Atsushi Nemoto wrote:

It seems __csum_partial_copy_user and csum_partial_copy_nocheck were
affected by the same bug.  Below a patch which tries to fix the issue.
I've tested it on 64-bit only.  I seem to observe that TCP transfers
on my test machine are ramping up to full bandwith somewhat more
slowly than on another machine but there are all sorts of reasons which
make that an unscientific test.  Anyway, I'd appreciate if people could
test this on 32-bit and 64-bit machines asap.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index 8d77841..9143a42 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -53,12 +53,14 @@
 #define UNIT(unit)  ((unit)*NBYTES)
 
 #define ADDC(sum,reg)						\
-	.set	push;						\
-	.set	noat;						\
 	ADD	sum, reg;					\
 	sltu	v1, sum, reg;					\
 	ADD	sum, v1;					\
-	.set	pop
+
+#define ADDC32(sum,reg)						\
+	addu	sum, reg;					\
+	sltu	v1, sum, reg;					\
+	addu	sum, v1;					\
 
 #define CSUM_BIGCHUNK1(src, offset, sum, _t0, _t1, _t2, _t3)	\
 	LOAD	_t0, (offset + UNIT(0))(src);			\
@@ -263,24 +265,25 @@ LEAF(csum_partial)
 	dsra32	sum, sum, 0
 	addu	sum, v1
 #endif
-	sll	v1, sum, 16
-	addu	sum, v1
-	sltu	v1, sum, v1
-	srl	sum, sum, 16
-	addu	sum, v1
 
 	/* odd buffer alignment? */
 	beqz	t7, 1f
 	 nop
-	sll	v1, sum, 8
+#ifdef CPU_MIPSR2
+	wsbh	sum, sum	
+#else
+	li	v1, 0xff00ff
+	and	t0, sum, v1
+	sll	t0, t0, 8
 	srl	sum, sum, 8
-	or	sum, v1
-	andi	sum, 0xffff
+	and	sum, sum, v1
+	or	sum, sum, t0
+#endif
 	.set	pop
 1:
 	.set	reorder
 	/* Add the passed partial csum.  */
-	ADDC(sum, a2)
+	ADDC32(sum, a2)
 	jr	ra
 	.set	noreorder
 	END(csum_partial)
@@ -665,23 +668,24 @@ EXC(	sb	t0, NBYTES-2(dst), .Ls_exc)
 	dsra32	sum, sum, 0
 	addu	sum, v1
 #endif
-	sll	v1, sum, 16
-	addu	sum, v1
-	sltu	v1, sum, v1
-	srl	sum, sum, 16
-	addu	sum, v1
 
 	/* odd buffer alignment? */
 	beqz	odd, 1f
 	 nop
-	sll	v1, sum, 8
+#ifdef CPU_MIPSR2
+	wsbh	sum, sum
+#else
+	li	v1, 0xff00ff
+	and	t0, sum, v1
+	sll	t0, t0, 8
 	srl	sum, sum, 8
-	or	sum, v1
-	andi	sum, 0xffff
+	and	sum, sum, v1
+	or	sum, sum, t0
+#endif
 	.set	pop
 1:
 	.set reorder
-	ADDC(sum, psum)
+	ADDC32(sum, psum)
 	jr	ra
 	.set noreorder
 
