Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jun 2005 17:23:24 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:38877 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225398AbVFVQXC>; Wed, 22 Jun 2005 17:23:02 +0100
Received: from localhost (p6103-ipad204funabasi.chiba.ocn.ne.jp [222.146.93.103])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 09C478418; Thu, 23 Jun 2005 01:21:55 +0900 (JST)
Date:	Thu, 23 Jun 2005 01:26:29 +0900 (JST)
Message-Id: <20050623.012629.41198930.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	kumba@gentoo.org, linux-mips@linux-mips.org
Subject: Re: .set mips2 breaks 64bit kernel
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.61L.0506221403420.4849@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.61L.0506221330240.4849@blysk.ds.pg.gda.pl>
	<42B95FB2.1090604@gentoo.org>
	<Pine.LNX.4.61L.0506221403420.4849@blysk.ds.pg.gda.pl>
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
X-archive-position: 8137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 22 Jun 2005 14:30:41 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> said:

macro> But I think there is one possiblity of a problem -- obsolete
macro> versions of GCC may rely on gas expanding "ll" and "sc" as
macro> macros, i.e. substitute a name of a symbol rather than a valid
macro> machine-level address expression (e.g. "0($reg)" or
macro> "%lo(sym)($reg)") for memory constraints.  Well, by using "m"
macro> right now we sort of permit it to.

Yes, this is my case.

A line in net/key/af_key.c:pfkey_create()

	atomic_inc(&pfkey_socks_nr);

was translated to:

		.set	mips2					
1:	ll	$3, pfkey_socks_nr		# atomic_add		
	addu	$3, 1					
	sc	$3, pfkey_socks_nr					
	beqz	$3, 1b					
	.set	mips0					

Then gas expands the 'll' to LUI and LL (no high 32bit).

I'm using gcc 3.4.4 and binutils 2.16.1.  Not so brand new but not so
obsolete (I hope :-))

---
Atsushi Nemoto
