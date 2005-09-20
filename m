Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2005 14:19:53 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:43274 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225417AbVITNTg>;
	Tue, 20 Sep 2005 14:19:36 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1EHi0I-0002Ze-00; Tue, 20 Sep 2005 14:17:46 +0100
Received: from gladsmuir.algor.co.uk ([172.20.192.66] helo=gladsmuir)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1EHi1A-0008Ds-00; Tue, 20 Sep 2005 14:18:40 +0100
From:	Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17200.3119.436273.291080@gargle.gargle.HOWL>
Date:	Tue, 20 Sep 2005 14:18:39 +0100
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Dominic Sweetman <dom@mips.com>, Thiemo Seufer <ths@networkno.de>,
	linux-mips@linux-mips.org
Subject: Re: Performance bug in c-r4k.c cache handling code
In-Reply-To: <Pine.LNX.4.61L.0509201017220.23494@blysk.ds.pg.gda.pl>
References: <20050919154056.GG3386@hattusa.textio>
	<Pine.LNX.4.61L.0509191733180.5551@blysk.ds.pg.gda.pl>
	<17199.53696.27856.801284@mips.com>
	<Pine.LNX.4.61L.0509201017220.23494@blysk.ds.pg.gda.pl>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.827,
	required 4, AWL, BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Maciej W. Rozycki (macro@linux-mips.org) writes:

> Besides new CPUs more often than not 
> require changes to kernel-level software anyway.

Making sure that isn't so is the reason why there's a MIPS32/64 spec
(with all the privileged operations defined).  Which also avoids the
undesirable development step of new hardware combined with new kernel
software... 

> > How did you measure the high throughput?  Have you got a
> > machine with DMA-coherency you can turn on and off?
> 
>  I just disabled invalidations. ;-)

Ouch.  So the effect could have come from a variety of sources.

> That was an R4400 with 1MB of S-cache.

With an R4400 S-cache, any difference between "would write it back but
it's clean" and "just invalidate" is likely to be small, since in
either case the time will be dominated by the (external) cache tag
memory RMW operation.

> Eventually I should benchmark both invalidation variations against each 
> other with the system in question and see if it makes any difference.  

Indeed.  And it might also be a good idea to test a more modern
system, too, to see how big an effect this might be.

> Ironically this is where the write-back cache of the R4k gives loss
> rather than gain as compared to the write-through cache of the R3k
> (the system supports daughtercards with either CPU, so useful
> comparison is possible)...

Maybe.  But remember, on the R3K every write was a write through, and
they all had a cost in bus congestion, which may have delayed a
following read and held up the CPU (or the write buffer may have
filled and stalled the CPU). 

I think up to about 33MHz write-through remained a tolerable policy
for 1988-era memory systems; any faster than that and you just sank
under a flood of writes.  2005-era memory systems are much faster when
bursting, but the time they take to process a single write cycle has
improved by less than 2x.  So write-through is still a really bad idea
for 100MHz CPUs using off-chip memory.

Even when your device requires you to push out all the data it can be
more efficient to write data to the cache and then force writeback to
memory: at least that way the data goes to the memory in efficient
burst cycles.

--
Dominic
