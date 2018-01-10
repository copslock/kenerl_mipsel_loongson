Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 13:58:33 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:46122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993588AbeAJM6ZaOEna (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Jan 2018 13:58:25 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C8BB1435;
        Wed, 10 Jan 2018 04:58:18 -0800 (PST)
Received: from [10.1.210.88] (e110467-lin.cambridge.arm.com [10.1.210.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CA4F3F581;
        Wed, 10 Jan 2018 04:58:15 -0800 (PST)
Subject: Re: [PATCH 21/22] arm64: replace ZONE_DMA with ZONE_DMA32
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        Michal Simek <monstr@monstr.eu>, linux-ia64@vger.kernel.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20180110080932.14157-1-hch@lst.de>
 <20180110080932.14157-22-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0371cef8-d980-96da-9cb5-3609c39be18a@arm.com>
Date:   Wed, 10 Jan 2018 12:58:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180110080932.14157-22-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <robin.murphy@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robin.murphy@arm.com
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

On 10/01/18 08:09, Christoph Hellwig wrote:
> arm64 uses ZONE_DMA for allocations below 32-bits.  These days we
> name the zone for that ZONE_DMA32, which will allow to use the
> dma-direct and generic swiotlb code as-is, so rename it.

I do wonder if we could also "upgrade" GFP_DMA to GFP_DMA32 somehow when 
!ZONE_DMA - there are almost certainly arm64 drivers out there using a 
combination of GFP_DMA and streaming mappings which will no longer get 
the guaranteed 32-bit addresses they expect after this. I'm not sure 
quite how feasible that is, though :/

That said, I do agree that this is an appropriate change (the legacy of 
GFP_DMA is obviously horrible), so, provided we get plenty of time to 
find and fix the fallout when it lands:

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Robin.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm64/Kconfig          |  2 +-
>   arch/arm64/mm/dma-mapping.c |  6 +++---
>   arch/arm64/mm/init.c        | 16 ++++++++--------
>   3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c9a7e9e1414f..6b6985f15d02 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -227,7 +227,7 @@ config GENERIC_CSUM
>   config GENERIC_CALIBRATE_DELAY
>   	def_bool y
>   
> -config ZONE_DMA
> +config ZONE_DMA32
>   	def_bool y
>   
>   config HAVE_GENERIC_GUP
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 6840426bbe77..0d641875b20e 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -95,9 +95,9 @@ static void *__dma_alloc_coherent(struct device *dev, size_t size,
>   				  dma_addr_t *dma_handle, gfp_t flags,
>   				  unsigned long attrs)
>   {
> -	if (IS_ENABLED(CONFIG_ZONE_DMA) &&
> +	if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
>   	    dev->coherent_dma_mask <= DMA_BIT_MASK(32))
> -		flags |= GFP_DMA;
> +		flags |= GFP_DMA32;
>   	if (dev_get_cma_area(dev) && gfpflags_allow_blocking(flags)) {
>   		struct page *page;
>   		void *addr;
> @@ -397,7 +397,7 @@ static int __init atomic_pool_init(void)
>   		page = dma_alloc_from_contiguous(NULL, nr_pages,
>   						 pool_size_order, GFP_KERNEL);
>   	else
> -		page = alloc_pages(GFP_DMA, pool_size_order);
> +		page = alloc_pages(GFP_DMA32, pool_size_order);
>   
>   	if (page) {
>   		int ret;
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 00e7b900ca41..8f03276443c9 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -217,7 +217,7 @@ static void __init reserve_elfcorehdr(void)
>   }
>   #endif /* CONFIG_CRASH_DUMP */
>   /*
> - * Return the maximum physical address for ZONE_DMA (DMA_BIT_MASK(32)). It
> + * Return the maximum physical address for ZONE_DMA32 (DMA_BIT_MASK(32)). It
>    * currently assumes that for memory starting above 4G, 32-bit devices will
>    * use a DMA offset.
>    */
> @@ -233,8 +233,8 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>   {
>   	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
>   
> -	if (IS_ENABLED(CONFIG_ZONE_DMA))
> -		max_zone_pfns[ZONE_DMA] = PFN_DOWN(max_zone_dma_phys());
> +	if (IS_ENABLED(CONFIG_ZONE_DMA32))
> +		max_zone_pfns[ZONE_DMA32] = PFN_DOWN(max_zone_dma_phys());
>   	max_zone_pfns[ZONE_NORMAL] = max;
>   
>   	free_area_init_nodes(max_zone_pfns);
> @@ -251,9 +251,9 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>   	memset(zone_size, 0, sizeof(zone_size));
>   
>   	/* 4GB maximum for 32-bit only capable devices */
> -#ifdef CONFIG_ZONE_DMA
> +#ifdef CONFIG_ZONE_DMA32
>   	max_dma = PFN_DOWN(arm64_dma_phys_limit);
> -	zone_size[ZONE_DMA] = max_dma - min;
> +	zone_size[ZONE_DMA32] = max_dma - min;
>   #endif
>   	zone_size[ZONE_NORMAL] = max - max_dma;
>   
> @@ -266,10 +266,10 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>   		if (start >= max)
>   			continue;
>   
> -#ifdef CONFIG_ZONE_DMA
> +#ifdef CONFIG_ZONE_DMA32
>   		if (start < max_dma) {
>   			unsigned long dma_end = min(end, max_dma);
> -			zhole_size[ZONE_DMA] -= dma_end - start;
> +			zhole_size[ZONE_DMA32] -= dma_end - start;
>   		}
>   #endif
>   		if (end > max_dma) {
> @@ -467,7 +467,7 @@ void __init arm64_memblock_init(void)
>   	early_init_fdt_scan_reserved_mem();
>   
>   	/* 4GB maximum for 32-bit only capable devices */
> -	if (IS_ENABLED(CONFIG_ZONE_DMA))
> +	if (IS_ENABLED(CONFIG_ZONE_DMA32))
>   		arm64_dma_phys_limit = max_zone_dma_phys();
>   	else
>   		arm64_dma_phys_limit = PHYS_MASK + 1;
> 
