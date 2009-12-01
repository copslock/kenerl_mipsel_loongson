Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 04:58:42 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52760 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491808AbZLAD6i (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Dec 2009 04:58:38 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB13wwNe015313;
        Tue, 1 Dec 2009 03:58:58 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB13wwCk015311;
        Tue, 1 Dec 2009 03:58:58 GMT
Date:   Tue, 1 Dec 2009 03:58:58 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David VomLehn <dvomlehn@cisco.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] Set of fixes for DMA when dma_addr_t != physical
 address
Message-ID: <20091201035857.GC29728@linux-mips.org>
References: <20091125200027.GA13748@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091125200027.GA13748@dvomlehn-lnx2.corp.sa.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 25, 2009 at 03:00:28PM -0500, David VomLehn wrote:

> Fixes for using DMA on systems where the DMA address and the physical address
> differ.
> 
> Signed-off-by: Dezhong Diao <dediao@cisco.com>
> Signed-off-by: David VomLehn <dvomlehn@cisco.com>
> ---
>  arch/mips/mm/dma-default.c |   22 ++++++++++++++--------
>  1 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
> index 414d7ff..eaa7fb4 100644
> --- a/arch/mips/mm/dma-default.c
> +++ b/arch/mips/mm/dma-default.c
> @@ -24,8 +24,11 @@ static inline unsigned long dma_addr_to_virt(struct device *dev,
>  	dma_addr_t dma_addr)
>  {
>  	unsigned long addr = plat_dma_addr_to_phys(dev, dma_addr);
> +	unsigned int offset = (dma_addr & ~PAGE_MASK);
> +	struct page *pg;
>  
> -	return (unsigned long)phys_to_virt(addr);
> +	pg = pfn_to_page(addr >> PAGE_SHIFT);
> +	return (unsigned long)(page_address(pg) + offset);

So this is the core of the two patches.

It'll make I/O to kmapped pages work - but you're not supposed to do that.
The burden to perform I/O on highmem pages is on the subsystem that does
the I/O, not the DMA layer!

>  }
>  
>  /*
> @@ -136,7 +139,6 @@ EXPORT_SYMBOL(dma_free_coherent);
>  static inline void __dma_sync(unsigned long addr, size_t size,
>  	enum dma_data_direction direction)
>  {
> -

This is the blank line the previous patch shouldn't have added.

>  	BUG_ON(addr < KSEG0);
>  
>  	switch (direction) {
> @@ -197,8 +199,8 @@ int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>  		addr = (unsigned long) sg_virt(sg);
>  		if (!plat_device_is_coherent(dev) && (addr >= KSEG0))
>  			__dma_sync(addr, sg->length, direction);
> -
> -		sg->dma_address = sg_phys(sg);
> +		sg->dma_address = plat_map_dma_mem_page(dev, sg_page(sg)) +
> +			sg->offset;

Ah, this segment undoes the damage done by the previous patch.  If I apply
both and diff, the change looks like:

-               sg->dma_address = plat_map_dma_mem(dev,
-                                                  (void *)addr, sg->length);
+               sg->dma_address = plat_map_dma_mem_page(dev, sg_page(sg)) +
+                       sg->offset;

sg_page returns a struct page *.  Adding sg->offset yields nonense.  I think
you mean something like ((unsigned long) sg_page(sg)) + sg->offset.

>  	}
>  
>  	return nents;
> @@ -253,7 +255,8 @@ void dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
>  		unsigned long addr;
>  
>  		addr = dma_addr_to_virt(dev, dma_handle);
> -		__dma_sync(addr, size, direction);
> +		if (addr >= KSEG0)
> +			__dma_sync(addr, size, direction);

Again this KSEG0 comparison will not work as intended on 64-bit.  And on 32-bit
I don't see why it would be required.  No userspace address should ever be
passed into this function.

>  	}
>  }
>  
> @@ -269,7 +272,8 @@ void dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
>  		unsigned long addr;
>  
>  		addr = dma_addr_to_virt(dev, dma_handle);
> -		__dma_sync(addr, size, direction);
> +		if (addr >= KSEG0)
> +			__dma_sync(addr, size, direction);

Ditto.

>  	}
>  }
>  
> @@ -284,7 +288,8 @@ void dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
>  		unsigned long addr;
>  
>  		addr = dma_addr_to_virt(dev, dma_handle);
> -		__dma_sync(addr + offset, size, direction);
> +		if (addr >= KSEG0)
> +			__dma_sync(addr + offset, size, direction);

Ditto.

>  	}
>  }
>  
> @@ -300,7 +305,8 @@ void dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
>  		unsigned long addr;
>  
>  		addr = dma_addr_to_virt(dev, dma_handle);
> -		__dma_sync(addr + offset, size, direction);
> +		if (addr >= KSEG0)
> +			__dma_sync(addr + offset, size, direction);

Ditto.

>  	}
>  }
>  

  Ralf
