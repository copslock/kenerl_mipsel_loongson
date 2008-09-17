Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Sep 2008 11:40:28 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:25589 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20221419AbYIQKkI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Sep 2008 11:40:08 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m8HAe67q017339;
	Wed, 17 Sep 2008 12:40:06 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m8HAe2oM017335;
	Wed, 17 Sep 2008 11:40:06 +0100
Date:	Wed, 17 Sep 2008 11:40:01 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Bryan Phillippe <u1@terran.org>
cc:	linux-mips@linux-mips.org
Subject: Re: MIPS checksum bug
In-Reply-To: <B45397E7-EBE4-497B-9055-42B604A909AA@terran.org>
Message-ID: <Pine.LNX.4.55.0809171104290.17103@cliff.in.clinika.pl>
References: <072748C6-07A9-4167-A8A5-80D0F7D9C784@darkforest.org>
 <B45397E7-EBE4-497B-9055-42B604A909AA@terran.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 16 Sep 2008, Bryan Phillippe wrote:

> I've experimented with the following change:
> 
> --- /home/bp/tmp/csum_partial.S.orig	2008-09-16 12:01:00.000000000 -0700
> +++ arch/mips/lib/csum_partial.S	2008-09-16 11:51:44.000000000 -0700
> @@ -281,6 +281,23 @@
> 	.set	reorder
> 	/* Add the passed partial csum.  */
> 	ADDC(sum, a2)
> +
> +	/* fold checksum again to clear the high bits before returning */
> +	.set	push
> +	.set	noat
> +#ifdef USE_DOUBLE
> +	dsll32	v1, sum, 0
> +	daddu	sum, v1
> +	sltu	v1, sum, v1
> +	dsra32	sum, sum, 0
> +	addu	sum, v1
> +#endif
> +	sll	v1, sum, 16
> +	addu	sum, v1
> +	sltu	v1, sum, v1
> +	srl	sum, sum, 16
> +	addu	sum, v1
> +
> 	jr	ra
> 	.set	noreorder
> 	END(csum_partial)
> 
> and it seems to fix the problem for me.  Can you comment?

 It seems obvious that a carry from the bit #15 in the last addition of
the passed checksum -- ADDC(sum, a2) -- will negate the effect of the
folding.  However a simpler fix should do as well.  Try if the following
patch works for you.  Please note this is completely untested and further
optimisation is possible, but I've skipped it in this version for clarity.

 Thanks for raising the issue.

  Maciej

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
--- a/arch/mips/lib/csum_partial.S	2008-05-05 02:55:23.000000000 
+0000
+++ b/arch/mips/lib/csum_partial.S	2008-09-17 10:32:37.000000000 
+0000
@@ -253,6 +253,9 @@ LEAF(csum_partial)
 
 1:	ADDC(sum, t1)
 
+	/* Add the passed partial csum.  */
+	ADDC(sum, a2)
+
 	/* fold checksum */
 	.set	push
 	.set	noat
@@ -278,11 +281,8 @@ LEAF(csum_partial)
 	andi	sum, 0xffff
 	.set	pop
 1:
-	.set	reorder
-	/* Add the passed partial csum.  */
-	ADDC(sum, a2)
 	jr	ra
-	.set	noreorder
+	 nop
 	END(csum_partial)
 
 
