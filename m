Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6BFNXRw006270
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 08:23:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6BFNWMR006269
	for linux-mips-outgoing; Thu, 11 Jul 2002 08:23:32 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6BFNLRw006259
	for <linux-mips@oss.sgi.com>; Thu, 11 Jul 2002 08:23:25 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id TAA07679;
	Thu, 11 Jul 2002 19:27:44 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id TAA26446; Thu, 11 Jul 2002 19:24:57 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id TAA27419; Thu, 11 Jul 2002 19:22:46 +0400 (MSK)
Message-ID: <3D2DA3D5.66664759@niisi.msk.ru>
Date: Thu, 11 Jul 2002 19:27:17 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.79 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
References: <Pine.GSO.3.96.1020711152156.7876E-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=x-user-defined
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> >
> > There're two possible optimization:
> > 1. (Requires only the instruction that swaps caches must run uncached)
> >       CPU may skip implementation of double check of cache hit on loads.
> >       Scenario: mtc0 with cache swapping with ensuring next instructions are
> > in cache
> >       (pipelining here!); swap occurs; must check again the instructions are
> > in
> >       the cache because the same cacheline in the data cache may have valid
> > bit set
> >       and CPU will get data instead of code.
> 
>  I can't really see a problem here for proper implementations.  The CPU
> may have fetched a few instructions beyond the mtc0 doing a cache swap.

Load from memory into I-cache, setting the valid bit.

> It's OK since we didn't modify the code.  As long as the swap doesn't
> complete, the CPU is using the real I-cache.  Once it's completed, it uses
> the D-cache.  Since the new cache is used in the normal mode of operation,
> now tag matches and line replacements occur here as if it was the real
> I-cache.  No need to do any extra checks at any stage.

Have to check the cacheline at given address again. D-cache may have the
valid bit set for the cacheline at the same address. Address means
location in a cache, not memory. Check at address requires one extra
tick as opposed to checking the bit.

Please, note that CPU isn't a monolitic program, but rather a set of
functional blocks, so "proper implementation" may require additional
signals on wires and delays.

> 
>  It's possible they broke something, simply.

My guess they implemented No. 1. more or less.

Anybody from IDT here with strong willing to broke NDA ? :-)

Regards,
Gleb.
