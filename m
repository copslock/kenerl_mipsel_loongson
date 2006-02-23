Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2006 14:03:25 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:39684 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133476AbWBWODR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Feb 2006 14:03:17 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1NE9mGC027877;
	Thu, 23 Feb 2006 14:09:48 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1NE9lFr027876;
	Thu, 23 Feb 2006 14:09:47 GMT
Date:	Thu, 23 Feb 2006 14:09:47 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Koeller <thomas.koeller@baslerweb.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] atomic functions broken
Message-ID: <20060223140947.GB6272@linux-mips.org>
References: <200602222125.39999.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602222125.39999.thomas.koeller@baslerweb.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 22, 2006 at 09:25:39PM +0100, Thomas Koeller wrote:

> The ll/sc versions of atomic_sub_if_positive(), and the corresponding 64-bit functions,
> are broken. The value returned by those functions is always one, no matter what.

Good catch - and I wonder how you found this bug since it didn't seem to
cause any obvious damage.  I just went for a different fix though - I was
able to get away without an extra register and squeeze the needed extra
instruction into a delay slot, so no code size penalty either.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

--- a/include/asm-mips/atomic.h
+++ b/include/asm-mips/atomic.h
@@ -250,7 +250,10 @@ static __inline__ int atomic_sub_if_posi
 		"	subu	%0, %1, %3				\n"
 		"	bltz	%0, 1f					\n"
 		"	sc	%0, %2					\n"
+		"	.set	noreorder				\n"
 		"	beqzl	%0, 1b					\n"
+		"	 subu	%0, %1, %3				\n"
+		"	.set	reorder					\n"
 		"	sync						\n"
 		"1:							\n"
 		"	.set	mips0					\n"
@@ -266,7 +269,10 @@ static __inline__ int atomic_sub_if_posi
 		"	subu	%0, %1, %3				\n"
 		"	bltz	%0, 1f					\n"
 		"	sc	%0, %2					\n"
+		"	.set	noreorder				\n"
 		"	beqz	%0, 1b					\n"
+		"	 subu	%0, %1, %3				\n"
+		"	.set	reorder					\n"
 		"	sync						\n"
 		"1:							\n"
 		"	.set	mips0					\n"
@@ -598,7 +604,10 @@ static __inline__ long atomic64_sub_if_p
 		"	dsubu	%0, %1, %3				\n"
 		"	bltz	%0, 1f					\n"
 		"	scd	%0, %2					\n"
+		"	.set	noreorder				\n"
 		"	beqzl	%0, 1b					\n"
+		"	 dsubu	%0, %1, %3				\n"
+		"	.set	reorder					\n"
 		"	sync						\n"
 		"1:							\n"
 		"	.set	mips0					\n"
@@ -614,7 +623,10 @@ static __inline__ long atomic64_sub_if_p
 		"	dsubu	%0, %1, %3				\n"
 		"	bltz	%0, 1f					\n"
 		"	scd	%0, %2					\n"
+		"	.set	noreorder				\n"
 		"	beqz	%0, 1b					\n"
+		"	 dsubu	%0, %1, %3				\n"
+		"	.set	reorder					\n"
 		"	sync						\n"
 		"1:							\n"
 		"	.set	mips0					\n"
