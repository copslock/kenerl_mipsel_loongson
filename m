Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 03:14:18 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:35749 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493261AbZLACOO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Dec 2009 03:14:14 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB12E9mw006971;
        Tue, 1 Dec 2009 02:14:09 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB12E8QU006969;
        Tue, 1 Dec 2009 02:14:08 GMT
Date:   Tue, 1 Dec 2009 02:14:08 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David VomLehn <dvomlehn@cisco.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] Set of fixes for DMA when dma_addr_t != physical
 address
Message-ID: <20091201021408.GB29728@linux-mips.org>
References: <20091125200024.GA13307@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091125200024.GA13307@dvomlehn-lnx2.corp.sa.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 25, 2009 at 03:00:24PM -0500, David VomLehn wrote:

> From: Jon Fraser <jfraser@broadcom.com>
> DMA changes from Jon Fraser, slightly tweaked for 2.6.30.
> 
> Signed-off-by: Jon Fraser <jfraser@broadcom.com>
> Signed-off-by: David VomLehn <dvomlehn@cisco.com>
> ---
>  arch/mips/mm/dma-default.c |   14 ++++++++++----
>  1 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
> index 4fdb7f5..70cff1f 100644
> --- a/arch/mips/mm/dma-default.c
> +++ b/arch/mips/mm/dma-default.c
> @@ -135,6 +135,9 @@ EXPORT_SYMBOL(dma_free_coherent);
>  static inline void __dma_sync(unsigned long addr, size_t size,
>  	enum dma_data_direction direction)
>  {
> +
> +	BUG_ON(addr < KSEG0);

This won't work right on 64-bit.

> +
>  	switch (direction) {
>  	case DMA_TO_DEVICE:
>  		dma_cache_wback(addr, size);
> @@ -188,11 +191,13 @@ int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>  	for (i = 0; i < nents; i++, sg++) {
>  		unsigned long addr;
>  
> +		BUG_ON(!sg_page(sg));
> +

No need to test this; the sg_virt() in the next line will blow up if
a bad sg was passed in.

>  		addr = (unsigned long) sg_virt(sg);
> -		if (!plat_device_is_coherent(dev) && addr)
> +		if (!plat_device_is_coherent(dev) && (addr >= KSEG0))

Again this KSEG0 test won't work right on 64-bit.

>  			__dma_sync(addr, sg->length, direction);
> -		sg->dma_address = plat_map_dma_mem(dev,
> -				                   (void *)addr, sg->length);
> +
> +		sg->dma_address = sg_phys(sg);

This breaks anything with a non-trival DMA engine like Jazz.

>  	}
>  
>  	return nents;
> @@ -229,7 +234,7 @@ void dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
>  		if (!plat_device_is_coherent(dev) &&
>  		    direction != DMA_TO_DEVICE) {
>  			addr = (unsigned long) sg_virt(sg);
> -			if (addr)
> +			if (addr >= KSEG0)
>  				__dma_sync(addr, sg->length, direction);

Ditto re. KSEG0.

>  		}
>  		plat_unmap_dma_mem(dev, sg->dma_address);
> @@ -359,6 +364,7 @@ void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
>  	       enum dma_data_direction direction)
>  {
>  	BUG_ON(direction == DMA_NONE);
> +	BUG_ON(vaddr < (void *)KSEG0);

Ditto.

>  
>  	plat_extra_sync_for_device(dev);
>  	if (!plat_device_is_coherent(dev))

  Ralf
