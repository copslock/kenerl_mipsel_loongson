Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jul 2004 13:10:01 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:38379 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225255AbUGAMJ4>; Thu, 1 Jul 2004 13:09:56 +0100
Received: from localhost (p6018-ipad28funabasi.chiba.ocn.ne.jp [220.107.205.18])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id F207B6D7A
	for <linux-mips@linux-mips.org>; Thu,  1 Jul 2004 21:09:51 +0900 (JST)
Date: Thu, 01 Jul 2004 21:14:56 +0900 (JST)
Message-Id: <20040701.211456.59461492.anemo@mba.ocn.ne.jp>
To: linux-mips@linux-mips.org
Subject: possible overflow in __udelay
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Current __udelay implementation will cause internal overflow on the
first multiplication.

Basically, the multiplication is:

X = usecs * 2**64 / (100000 / HZ)

And maximum input usecs value is 5000 (MAX_UDELAY_MS * 1000).

If usecs == 5000 and HZ == 1000, X is 5 * 2**64.  Of course this can
not be held in 64bit variable.

How should we avoid the overflow?


1. Use smaller HZ.

HZ < 200 should be OK.


2. Use smaller MAX_UDELAY_MS.

The arch specific delay.h can provide its own MAX_UDELAY_MS.
MAX_UDELAY_MS == 1 should be OK.


3. Use smaller multiplier.

This example should be OK (but lose some precision on larger HZ)

#if HZ < (1000 / MAX_UDELAY_MS)
	usecs *= (0x8000000000000000UL / (500000 / HZ));
#elif HZ < ((1000 / MAX_UDELAY_MS) << 1)
	usecs *= (0x8000000000000000UL / (500000 / HZ)) >> 1;
	lpj <<= 1
#elif HZ < ((1000 / MAX_UDELAY_MS) << 2)
	usecs *= (0x8000000000000000UL / (500000 / HZ)) >> 2;
	lpj <<= 2
#else
	usecs *= (0x8000000000000000UL / (500000 / HZ)) >> 3;
	lpj <<= 3
#endif


Any idea?

---
Atsushi Nemoto
