Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Nov 2002 16:38:27 +0100 (CET)
Received: from p508B66C1.dip.t-dialin.net ([80.139.102.193]:441 "EHLO
	p508B66C1.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S1122121AbSKEPi0>; Tue, 5 Nov 2002 16:38:26 +0100
Received: (ralf@3ffe:8260:2020:2::20) by ralf.linux-mips.org
	id <S867025AbSKEPiJ>; Tue, 5 Nov 2002 16:38:09 +0100
Date: Tue, 5 Nov 2002 16:38:07 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Carsten Langgaard <carstenl@mips.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Prefetches in memcpy
Message-ID: <20021105163806.A24996@bacchus.dhis.org>
References: <3DC7CB8B.E2C1D4E5@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DC7CB8B.E2C1D4E5@mips.com>; from carstenl@mips.com on Tue, Nov 05, 2002 at 02:45:47PM +0100
X-Accept-Language: de,en,fr
Return-Path: <ralf@uni-koblenz.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@uni-koblenz.de
Precedence: bulk
X-list: linux-mips

On Tue, Nov 05, 2002 at 02:45:47PM +0100, Carsten Langgaard wrote:

> The problem is the prefetches in the memcpy function in the kernel.
> There is spread a number of PREF instructions in the memcpy function,
> but there is no check if we are prefetching out-side the areas we are
> copying to/from. This is extremely dangerous because we might prefetch
> out-side the physical memory area, causing e.g. a bus error or something
> even more nasty.
> 
> I recently found something even nastier, it could also hit a DMA buffer
> region, and thereby break the PCI DMA flushing scheme.
> For example if the kernel is doing a memcpy from an area that's next to
> a DMA buffer area, we could end up in a situation where, we are
> prefetching
> data into the cache from a memory location that is used for DMA transfer
> and owned by the device, but the DMA transfer has not yet completed.
> We then end up in a situation, where the memory and cache is out of sync
> and the cache is containing some old data.
> 
> So we definitely need to do something about the prefetches in the memcpy
> function.  We can either get rid of all the prefetches or make sure we
> don't prefetch out side the "memcpy" area.

We could fix the prefetch into DMA buffer problem with an extra flush but
that's going to be expensive, I rather think we should avoid prefetches.
As Kevin explained KSEG1 is a loophole in the spec so we can't really say
what the behaviour of memcpy will be in KSEG1.

So I think the fix will have to be:

 - Avoid prefetching beyond the end of the copy area in memcpy and memmove.
 - Introduce a second variant of memcpy that never does prefetching.  This
   one will be safe to use in KSEG1 / uncached XKPHYS also and will be used
   for memcpy_fromio, memcpy_toio and friends.

  Ralf
