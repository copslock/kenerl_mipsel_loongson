Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Sep 2008 14:23:52 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:8681 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20231600AbYIQNXp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Sep 2008 14:23:45 +0100
Received: from localhost (p4013-ipad208funabasi.chiba.ocn.ne.jp [60.43.105.13])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id F423AB505; Wed, 17 Sep 2008 22:23:38 +0900 (JST)
Date:	Wed, 17 Sep 2008 22:23:50 +0900 (JST)
Message-Id: <20080917.222350.41199051.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	u1@terran.org, linux-mips@linux-mips.org
Subject: Re: MIPS checksum bug
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.55.0809171104290.17103@cliff.in.clinika.pl>
References: <072748C6-07A9-4167-A8A5-80D0F7D9C784@darkforest.org>
	<B45397E7-EBE4-497B-9055-42B604A909AA@terran.org>
	<Pine.LNX.4.55.0809171104290.17103@cliff.in.clinika.pl>
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
X-archive-position: 20517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 17 Sep 2008 11:40:01 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> > and it seems to fix the problem for me.  Can you comment?
> 
>  It seems obvious that a carry from the bit #15 in the last addition of
> the passed checksum -- ADDC(sum, a2) -- will negate the effect of the
> folding.  However a simpler fix should do as well.  Try if the following
> patch works for you.  Please note this is completely untested and further
> optimisation is possible, but I've skipped it in this version for clarity.

Well, csum_partial()'s return value is __wsum (32-bit).  So strictly
there is no need to folding into 16-bit.

I think this bug was introduced by my commit
ed99e2bc1dc5dc54eb5a019f4975562dbef20103 ("[MIPS] Optimize
csum_partial for 64bit kernel").  This commit changed ADDC to using
daddu for 64-bit kernel and that was wrong for the last addition of
partial csum which should be 32-bit addition.

Here is my proposal fix.  Bryan, could you try it too?

diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index 8d77841..8b15766 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -60,6 +60,14 @@
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
@@ -280,7 +288,7 @@ LEAF(csum_partial)
 1:
 	.set	reorder
 	/* Add the passed partial csum.  */
-	ADDC(sum, a2)
+	ADDC32(sum, a2)
 	jr	ra
 	.set	noreorder
 	END(csum_partial)
@@ -681,7 +689,7 @@ EXC(	sb	t0, NBYTES-2(dst), .Ls_exc)
 	.set	pop
 1:
 	.set reorder
-	ADDC(sum, psum)
+	ADDC32(sum, psum)
 	jr	ra
 	.set noreorder
 
