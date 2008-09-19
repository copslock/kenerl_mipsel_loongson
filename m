Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 16:43:12 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:49100 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20311549AbYISPnF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 19 Sep 2008 16:43:05 +0100
Received: from localhost (p1191-ipad304funabasi.chiba.ocn.ne.jp [123.217.155.191])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id F1171AD5F; Sat, 20 Sep 2008 00:42:59 +0900 (JST)
Date:	Sat, 20 Sep 2008 00:43:19 +0900 (JST)
Message-Id: <20080920.004319.93205397.anemo@mba.ocn.ne.jp>
To:	u1@terran.org
Cc:	macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: MIPS checksum bug
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080919.011704.59652451.anemo@mba.ocn.ne.jp>
References: <20080917.222350.41199051.anemo@mba.ocn.ne.jp>
	<BD7F24AB-4B0C-4FA4-ADB3-5A86E7A4624F@terran.org>
	<20080919.011704.59652451.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 19 Sep 2008 01:17:04 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> Thank you for testing.  Though this patch did not fixed your problem,
> I still have a doubt on 64-bit optimization.
> 
> If your hardware could run 32-bit kernel, could you confirm the
> problem can happens in 32-bit too or not?

I think I found possible breakage on 64-bit path.

There are some "lw" (and "ulw") used in 64-bit path and they should be
"lwu" (and "ulwu" ... but there is no such pseudo insn) to avoid
sign-extention.

Here is a completely untested patch.

diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index 8d77841..40f9174 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -39,12 +39,14 @@
 #ifdef USE_DOUBLE
 
 #define LOAD   ld
+#define LOAD32 lwu
 #define ADD    daddu
 #define NBYTES 8
 
 #else
 
 #define LOAD   lw
+#define LOAD32 lw
 #define ADD    addu
 #define NBYTES 4
 
@@ -60,6 +62,14 @@
 	ADD	sum, v1;					\
 	.set	pop
 
+#define ADDC32(sum,reg)						\
+	.set	push;						\
+	.set	noat;						\
+	addu	sum, reg;					\
+	sltu	v1, sum, reg;					\
+	addu	sum, v1;					\
+	.set	pop
+
 #define CSUM_BIGCHUNK1(src, offset, sum, _t0, _t1, _t2, _t3)	\
 	LOAD	_t0, (offset + UNIT(0))(src);			\
 	LOAD	_t1, (offset + UNIT(1))(src);			\
@@ -132,7 +142,7 @@ LEAF(csum_partial)
 	beqz	t8, .Lqword_align
 	 andi	t8, src, 0x8
 
-	lw	t0, 0x00(src)
+	LOAD32	t0, 0x00(src)
 	LONG_SUBU	a1, a1, 0x4
 	ADDC(sum, t0)
 	PTR_ADDU	src, src, 0x4
@@ -211,7 +221,7 @@ LEAF(csum_partial)
 	LONG_SRL	t8, t8, 0x2
 
 .Lend_words:
-	lw	t0, (src)
+	LOAD32	t0, (src)
 	LONG_SUBU	t8, t8, 0x1
 	ADDC(sum, t0)
 	.set	reorder				/* DADDI_WAR */
@@ -229,6 +239,9 @@ LEAF(csum_partial)
 
 	/* Still a full word to go  */
 	ulw	t1, (src)
+#ifdef USE_DOUBLE
+	add	t1, zero	/* clear upper 32bit */
+#endif
 	PTR_ADDIU	src, 4
 	ADDC(sum, t1)
 
@@ -280,7 +293,7 @@ LEAF(csum_partial)
 1:
 	.set	reorder
 	/* Add the passed partial csum.  */
-	ADDC(sum, a2)
+	ADDC32(sum, a2)
 	jr	ra
 	.set	noreorder
 	END(csum_partial)
@@ -681,7 +694,7 @@ EXC(	sb	t0, NBYTES-2(dst), .Ls_exc)
 	.set	pop
 1:
 	.set reorder
-	ADDC(sum, psum)
+	ADDC32(sum, psum)
 	jr	ra
 	.set noreorder
 
