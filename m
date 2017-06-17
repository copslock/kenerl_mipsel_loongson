Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jun 2017 22:51:08 +0200 (CEST)
Received: from gate.crashing.org ([63.228.1.57]:46410 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994901AbdFQUux6PJVF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 17 Jun 2017 22:50:53 +0200
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.13.8) with ESMTP id v5HKoTdu029370;
        Sat, 17 Jun 2017 15:50:31 -0500
Message-ID: <1497732627.2897.128.camel@kernel.crashing.org>
Subject: Re: [PATCH 42/44] powerpc/cell: use the dma_supported method for
 ops switching
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Sun, 18 Jun 2017 06:50:27 +1000
In-Reply-To: <20170616181059.19206-43-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
         <20170616181059.19206-43-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-2.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <benh@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benh@kernel.crashing.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Fri, 2017-06-16 at 20:10 +0200, Christoph Hellwig wrote:
> Besides removing the last instance of the set_dma_mask method this also
> reduced the code duplication.

What is your rationale here ? (I have missed patch 0 it seems).

dma_supported() was supposed to be pretty much a "const" function
simply informing whether a given setup is possible. Having it perform
an actual switch of ops seems to be pushing it...

What if a driver wants to test various dma masks and then pick one ?

Where does the API documents that if a driver calls dma_supported() it
then *must* set the corresponding mask and use that ?

I don't like a function that is a "boolean query" like this one to have
such a major side effect.

From an API standpoint, dma_set_mask() is when the mask is established,
and thus when the ops switch should happen.

Ben.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/platforms/cell/iommu.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
> index 497bfbdbd967..29d4f96ed33e 100644
> --- a/arch/powerpc/platforms/cell/iommu.c
> +++ b/arch/powerpc/platforms/cell/iommu.c
> @@ -644,20 +644,14 @@ static void dma_fixed_unmap_sg(struct device *dev, struct scatterlist *sg,
>  				   direction, attrs);
>  }
>  
> -static int dma_fixed_dma_supported(struct device *dev, u64 mask)
> -{
> -	return mask == DMA_BIT_MASK(64);
> -}
> -
> -static int dma_set_mask_and_switch(struct device *dev, u64 dma_mask);
> +static int dma_suported_and_switch(struct device *dev, u64 dma_mask);
>  
>  static const struct dma_map_ops dma_iommu_fixed_ops = {
>  	.alloc          = dma_fixed_alloc_coherent,
>  	.free           = dma_fixed_free_coherent,
>  	.map_sg         = dma_fixed_map_sg,
>  	.unmap_sg       = dma_fixed_unmap_sg,
> -	.dma_supported  = dma_fixed_dma_supported,
> -	.set_dma_mask   = dma_set_mask_and_switch,
> +	.dma_supported  = dma_suported_and_switch,
>  	.map_page       = dma_fixed_map_page,
>  	.unmap_page     = dma_fixed_unmap_page,
>  	.mapping_error	= dma_iommu_mapping_error,
> @@ -952,11 +946,8 @@ static u64 cell_iommu_get_fixed_address(struct device *dev)
>  	return dev_addr;
>  }
>  
> -static int dma_set_mask_and_switch(struct device *dev, u64 dma_mask)
> +static int dma_suported_and_switch(struct device *dev, u64 dma_mask)
>  {
> -	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
> -		return -EIO;
> -
>  	if (dma_mask == DMA_BIT_MASK(64) &&
>  	    cell_iommu_get_fixed_address(dev) != OF_BAD_ADDR) {
>  		u64 addr = cell_iommu_get_fixed_address(dev) +
> @@ -965,14 +956,16 @@ static int dma_set_mask_and_switch(struct device *dev, u64 dma_mask)
>  		dev_dbg(dev, "iommu: fixed addr = %llx\n", addr);
>  		set_dma_ops(dev, &dma_iommu_fixed_ops);
>  		set_dma_offset(dev, addr);
> -	} else {
> +		return 1;
> +	}
> +
> +	if (dma_iommu_dma_supported(dev, dma_mask)) {
>  		dev_dbg(dev, "iommu: not 64-bit, using default ops\n");
>  		set_dma_ops(dev, get_pci_dma_ops());
>  		cell_dma_dev_setup(dev);
> +		return 1;
>  	}
>  
> -	*dev->dma_mask = dma_mask;
> -
>  	return 0;
>  }
>  
> @@ -1127,7 +1120,7 @@ static int __init cell_iommu_fixed_mapping_init(void)
>  		cell_iommu_setup_window(iommu, np, dbase, dsize, 0);
>  	}
>  
> -	dma_iommu_ops.set_dma_mask = dma_set_mask_and_switch;
> +	dma_iommu_ops.dma_supported = dma_suported_and_switch;
>  	set_pci_dma_ops(&dma_iommu_ops);
>  
>  	return 0;
