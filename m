Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5HHHgnC026326
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 17 Jun 2002 10:17:42 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5HHHgMg026325
	for linux-mips-outgoing; Mon, 17 Jun 2002 10:17:42 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ayrnetworks.com (64-166-72-141.ayrnetworks.com [64.166.72.141])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5HHHXnC026322
	for <linux-mips@oss.sgi.com>; Mon, 17 Jun 2002 10:17:33 -0700
Received: (from wjhun@localhost)
	by  ayrnetworks.com (8.11.2/8.11.2) id g5HHH8828454;
	Mon, 17 Jun 2002 10:17:08 -0700
Date: Mon, 17 Jun 2002 10:17:08 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: PCI DMA transfer
Message-ID: <20020617101708.A28405@ayrnetworks.com>
References: <3D0DC086.27BFAA1D@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D0DC086.27BFAA1D@mips.com>; from carstenl@mips.com on Mon, Jun 17, 2002 at 12:57:10PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 17, 2002 at 12:57:10PM +0200, Carsten Langgaard wrote:
> I can see the 'dma_cache_inv_pc' routines (in the arch/mips/mm cache
> files), in almost every incarnation, is actually doing a write-back
> invalidation, why ?
> My first thought was, that this will never work for the PCI devices
> doing DMA, so I was wondering why it actually does work.

It ought to work, though it's just not as efficient. One clear problem
is that there is no wback/inv on pci_unmap_{single,sg}(). This will
cause a problem when a driver:

- calls pci_map_single()
- DMAs into the buffer
- calls pci_dma_sync_single() [eg, a buffer smaller than rx_copybreak in
  tulip]
- copies the buffer
- returns the buffer to the device
- does another DMA transfer
- this time calls pci_unmap_single() [eg, buffer > rx_copybreak]

Clearly, stale cache lines will remain after the first buffer copy. For
the time being, we can just put the flush in the pci_unmap_* calls. This
is also pretty lame as we are always needlessly flushing the cache one
extra time (in the map *and* in the unmap. Or in the map and in the
dma_sync). I've proposed some API changes to Dave Miller that should
solve this problem. Hopefully they'll be integrated in some way and we
can enjoy both correctness and optimal performance. :o) (BTW, we've
found that the performance implications of getting this stuff right *IS*
significant, and there is indeed a noticeable difference between doing
an invalidate and a writeback-invalidate, even if there is nothing to
write back.)

> And the answer is, that this routine isn't used by the
> PCI DMA functions, no matter what the DIRECTION of the DMA transfer is.
> Has anyone got an idea why the while PCI DMA stuff is implemented this
> way (only using write-back invalidations) ?

Broken cache routines? Apathy? :o) Most likely that this hasn't hit a
lot of people yet... (see below)

> I would expect that we did a write-back invalidation of the D-cache,
> when the direction was PCI_DMA_TODEVICE and only did invalidation of the
> D-cache, when the direction was PCI_DMA_FROMDEVICE.

I sent out a patch to change this a while ago, but it got dropped since
most implementations of dma_cache_wback() just call BUG(). I've been
meaning to get a patch ready for this as well, but haven't had the time.
Well, it's a slow Monday morning, so maybe I'll do it now. :o)

For architectures that can only do a wback/inv and not an inv or wback
by itself, it should be suitable to do a wback/inv in place. In effect,
an invalidate or writeback should only be requested as a performance
enhancement, and should not differ in correctness when replaced with a
writeback-invalidate. As such, code should not write something to cache,
do an invalidate some measured amount of time later and expect the write
to be completely invalidated. Is it reasonable to expect that code will
not do this? And doing a wback/inv in place of a wback does not seem
harmful to me... At least, I can't think of a case where it would be.

Agree? Disagree? I'll put together some patches shortly...

Will
