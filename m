Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2005 13:23:07 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:52509 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225410AbVITMWu>; Tue, 20 Sep 2005 13:22:50 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j8KCMi3p008283;
	Tue, 20 Sep 2005 13:22:44 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j8KCMhEf008282;
	Tue, 20 Sep 2005 13:22:43 +0100
Date:	Tue, 20 Sep 2005 13:22:43 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dominic Sweetman <dom@mips.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: Performance bug in c-r4k.c cache handling code
Message-ID: <20050920122243.GE3159@linux-mips.org>
References: <20050919154056.GG3386@hattusa.textio> <Pine.LNX.4.61L.0509191733180.5551@blysk.ds.pg.gda.pl> <17199.53696.27856.801284@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17199.53696.27856.801284@mips.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 20, 2005 at 10:09:20AM +0100, Dominic Sweetman wrote:

> > > I found an performance bug in c-r4k.c:r4k_dma_cache_inv, where a
> > > Hit_Writeback_Inv instead of Hit_Invalidate is done.
> 
> The MIPS64 spec (which is really all there is to set standards in this
> area) regards Hit_Invalidate as optional.  So it would be nice not to
> use it.  CPUs have no standard "configuration" register you can read
> to establish which cacheops work, so to identify capable CPUs you must
> use a table of CPU attributes indexed by the CPU ID, which encourages
> the crime of building software which can't possibly run on a new CPU...
> 
> So long as the buffer is in fact clean, then in most implementations a
> Hit_Writeback_Invalidate will be just as efficient.

This are R4700 numbers, the only I was able to find in a quick search.

  Hit_Invalidate_D		 7 cycles for a cache miss
				 9 cycles for a cache hit
  Hit_Writeback_Invalidate_D	 7 cycles for a cache miss
				12 cycles for a cache hit if the cache line
				   is clean.
				14 cycles for a cache hit if the cache line
				   is dirty (Writeback).
  Hit_Writeback_D		 7 cycles for a cache miss
				10 cycles for a cache hit if the cache line
				   is clean
				14 cycles for a cache hit if the cache line
				   is dirty (Writeback).

> Moreover, CPUs always "post" writes to some extent, so a small
> percentage of dirty lines can be handled without any great overhead.
> So a significant advantage can only occur when the buffer you want to
> invalidate (prior to DMA-in) was fairly recently densely written by
> the CPU; and this is only safe when all that data can be guaranteed to
> now be of no importance to anyone.

Linux has a well-defined ABI that DMA drivers are supposed to use; the
functions of this ABI that perform cache flushes also take a DMA
direction argument based on which the implementation can deciede on what
the best flush function for a particular case will be.

> Randomly and retrospectively discarding writes could generate some
> very interesting bugs, or (indeed) usually hide some very interesting
> bugs.  It's the kind of thing one would lik to avoid!
> 
> I suppose where DMA data subsequently gets decorated by the CPU then
> handed on to some other layer, then the buffer is freed...?
> 
> > FYI, for R4k DECstations the need to flush the cache for newly allocated 
> > skbs reduces throughput of FDDI reception by about a half (!), down from 
> > about 90Mbps (that's for the /260)...

Software coherency will result in many server / client type operations
approximate worst case as none of the data will reside in caches.  Routers
are going to be somewhat better off - as long as they don't peek to deep
into the packets, that is.

> How did you measure the high throughput?  Have you got a
> machine with DMA-coherency you can turn on and off?

Afaik AMD Alchemy processors have configurable coherency.

  Ralf
