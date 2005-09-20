Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2005 13:37:47 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:776 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225410AbVITMhc>; Tue, 20 Sep 2005 13:37:32 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id BE557F596C; Tue, 20 Sep 2005 14:37:27 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 28365-02; Tue, 20 Sep 2005 14:37:27 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 4C415F5969; Tue, 20 Sep 2005 14:37:27 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j8KCbQ0f006073;
	Tue, 20 Sep 2005 14:37:26 +0200
Date:	Tue, 20 Sep 2005 13:37:33 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Dominic Sweetman <dom@mips.com>
Cc:	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: Performance bug in c-r4k.c cache handling code
In-Reply-To: <17199.53696.27856.801284@mips.com>
Message-ID: <Pine.LNX.4.61L.0509201017220.23494@blysk.ds.pg.gda.pl>
References: <20050919154056.GG3386@hattusa.textio>
 <Pine.LNX.4.61L.0509191733180.5551@blysk.ds.pg.gda.pl> <17199.53696.27856.801284@mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/1090/Mon Sep 19 23:29:31 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 20 Sep 2005, Dominic Sweetman wrote:

> > > I found an performance bug in c-r4k.c:r4k_dma_cache_inv, where a
> > > Hit_Writeback_Inv instead of Hit_Invalidate is done.
> 
> The MIPS64 spec (which is really all there is to set standards in this
> area) regards Hit_Invalidate as optional.  So it would be nice not to
> use it.  CPUs have no standard "configuration" register you can read
> to establish which cacheops work, so to identify capable CPUs you must
> use a table of CPU attributes indexed by the CPU ID, which encourages
> the crime of building software which can't possibly run on a new CPU...

 Or just using the safe fallback -- that shouldn't be a problem (these 
functions are called indirectly).  Besides new CPUs more often than not 
require changes to kernel-level software anyway.

> So long as the buffer is in fact clean, then in most implementations a
> Hit_Writeback_Invalidate will be just as efficient.

 I hope so, but who knows what's wired there in all those old systems?...

> I suppose where DMA data subsequently gets decorated by the CPU then
> handed on to some other layer, then the buffer is freed...?

 I don't think the buffer is modified, so cache lines should remain clean. 
For the usual case of IP data is used exactly once for copy_and_csum() 
(more or less) which moves it to another buffer.

> > FYI, for R4k DECstations the need to flush the cache for newly allocated 
> > skbs reduces throughput of FDDI reception by about a half (!), down from 
> > about 90Mbps (that's for the /260)...
> 
> How did you measure the high throughput?  Have you got a
> machine with DMA-coherency you can turn on and off?

 I just disabled invalidations. ;-)  Yes, that resulted in some corrupt 
data, but it was good enough to do benchmarking.  That was an R4400 with 
1MB of S-cache.

 Eventually I should benchmark both invalidation variations against each 
other with the system in question and see if it makes any difference.  
Ironically this is where the write-back cache of the R4k gives loss rather 
than gain as compared to the write-through cache of the R3k (the system 
supports daughtercards with either CPU, so useful comparison is possible) 
as for the former I have to invalidate cache spanning the whole 
newly-allocated buffer, i.e. ~4.5kB, while for the latter I may invalidate 
only the area actually used, once a frame has been received, its length is 
known and quite often much smaller than the maximum (especially if it's 
been routed from a network that has a smaller frame length limit, like 
Ethernet).

  Maciej
