Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jul 2004 15:52:05 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:48613 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225463AbUGGOwB>; Wed, 7 Jul 2004 15:52:01 +0100
Received: from localhost (p1005-ipad202funabasi.chiba.ocn.ne.jp [222.146.72.5])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id 25A1970FB
	for <linux-mips@linux-mips.org>; Wed,  7 Jul 2004 23:51:58 +0900 (JST)
Date: Wed, 07 Jul 2004 23:57:23 +0900 (JST)
Message-Id: <20040707.235723.74756758.anemo@mba.ocn.ne.jp>
To: linux-mips@linux-mips.org
Subject: Re: possible overflow in __udelay
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20040701.211456.59461492.anemo@mba.ocn.ne.jp>
References: <20040701.211456.59461492.anemo@mba.ocn.ne.jp>
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
X-archive-position: 5417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 01 Jul 2004 21:14:56 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:

anemo> Current __udelay implementation will cause internal overflow on
anemo> the first multiplication.

anemo> Basically, the multiplication is:

anemo> X = usecs * 2**64 / (100000 / HZ)

anemo> And maximum input usecs value is 5000 (MAX_UDELAY_MS * 1000).

anemo> If usecs == 5000 and HZ == 1000, X is 5 * 2**64.  Of course
anemo> this can not be held in 64bit variable.

anemo> How should we avoid the overflow?

anemo> ....

Don't you really have any comments?

I believe, for example, mdelay(10) does not work properly on most MIPS
ports (except for DECSTATION and JAZZ which have smaller HZ value).

---
Atsushi Nemoto
