Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4UHbxnC025303
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 30 May 2002 10:37:59 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4UHbxGZ025302
	for linux-mips-outgoing; Thu, 30 May 2002 10:37:59 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ayrnetworks.com (64-166-72-142.ayrnetworks.com [64.166.72.142])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4UHbsnC025299
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 10:37:54 -0700
Received: (from wjhun@localhost)
	by  ayrnetworks.com (8.11.2/8.11.2) id g4UHbX722590;
	Thu, 30 May 2002 10:37:33 -0700
Date: Thu, 30 May 2002 10:37:33 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: Zhang Fuxin <fxzhang@ict.ac.cn>
Cc: Kevin Paul Herbert <kph@ayrnetworks.com>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: pcnet32.c bug?
Message-ID: <20020530103732.C22531@ayrnetworks.com>
References: <200205301546.g4UFkbnC015084@oss.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200205301546.g4UFkbnC015084@oss.sgi.com>; from fxzhang@ict.ac.cn on Thu, May 30, 2002 at 11:47:26PM +0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, May 30, 2002 at 11:47:26PM +0800, Zhang Fuxin wrote:
> I think it just mean to invalidate cache contents the cpu has for this
> buffer,and thus cpu can be sure to read data dmaed to memory by the device
> And now we are doing write back,won't that be overwriting the buffer with 
> stale data in cache?
> 
> so,the problem is,can we use wback_inv instead of inv in pci_dma_sync_single
> when the direction is FROMDEVICE? I don't think so,but that would mean many
> current drivers are broken...

If I understand this correctly, a writeback means only modified
cachelines (i.e. data cache lines with a dirty bit, like 'W', set) will
be written back to main memory.  Since the driver never actually writes
to any of these buffers (and their contents are invalidated on the
pci_map_single()), nothing should ever be written back to main memory.
If this were not the case, you would surely see packet corruption as the
stale cachelines from a re-used buffer would be written back. I tend not
to think that it's just coincidence and that MIPS caches tend to be
small...

So, writeback-invalidate is not incorrect, but it's not efficient for
all platforms. Ralf explained to me that some CPUs cannot do indexed
invalidates separately from writebacks.

I think all three (dma_cache_wback, dma_cache_wback_inv,
dma_cache_inv) of these calls should be implemented for all CPUs and
default to dma_cache_wback_inv() if not available. I can come up with a
patch if people agree (that wback_inv is a suitable replacement for
either _inv or _wback; MIPS-specific code than can be written to use
whatever is most optimal if present on that architecture...

Thanks,
Will
