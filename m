Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jul 2004 16:06:48 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:12525 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225474AbUGGPGo>; Wed, 7 Jul 2004 16:06:44 +0100
Received: from localhost (p4055-ipad01funabasi.chiba.ocn.ne.jp [61.207.78.55])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id DF3736F74
	for <linux-mips@linux-mips.org>; Thu,  8 Jul 2004 00:06:41 +0900 (JST)
Date: Thu, 08 Jul 2004 00:12:07 +0900 (JST)
Message-Id: <20040708.001207.74754796.anemo@mba.ocn.ne.jp>
To: linux-mips@linux-mips.org
Subject: Re: possible overflow in __udelay
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20040707.235723.74756758.anemo@mba.ocn.ne.jp>
References: <20040701.211456.59461492.anemo@mba.ocn.ne.jp>
	<20040707.235723.74756758.anemo@mba.ocn.ne.jp>
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
X-archive-position: 5418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 07 Jul 2004 23:57:23 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:

anemo> I believe, for example, mdelay(10) does not work properly on
anemo> most MIPS ports (except for DECSTATION and JAZZ which have
anemo> smaller HZ value).

Oops, mdelay(10) should work.  But mdelay(5) (mdelay(MAX_UDELAY_MS))
does not work.

---
Atsushi Nemoto
