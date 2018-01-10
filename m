Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 14:16:37 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:46450 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994039AbeAJNQ2YfnUa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Jan 2018 14:16:28 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34923F;
        Wed, 10 Jan 2018 05:16:21 -0800 (PST)
Received: from [10.1.210.88] (e110467-lin.cambridge.arm.com [10.1.210.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 182E43F581;
        Wed, 10 Jan 2018 05:16:18 -0800 (PST)
Subject: Re: [PATCH 22/22] arm64: use swiotlb_alloc and swiotlb_free
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        Michal Simek <monstr@monstr.eu>, linux-ia64@vger.kernel.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20180110080932.14157-1-hch@lst.de>
 <20180110080932.14157-23-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <af49a676-142b-fd37-a395-67d76f7d35fa@arm.com>
Date:   Wed, 10 Jan 2018 13:16:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180110080932.14157-23-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <robin.murphy@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62034
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
> The generic swiotlb_alloc and swiotlb_free routines already take care
> of CMA allocations and adding GFP_DMA32 where needed, so use them
> instead of the arm specific helpers.

It took a while to satisfy myself that the GFP_DMA(32) handling ends up 
equivalent to the current behaviour, but I think it checks out. This 
will certainly help with the long-overdue cleanup of this file that I've 
had sat around half-finished for ages.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm64/Kconfig          |  1 +
>   arch/arm64/mm/dma-mapping.c | 46 +++------------------------------------------
>   2 files changed, 4 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 6b6985f15d02..53205c02b18a 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -59,6 +59,7 @@ config ARM64
>   	select COMMON_CLK
>   	select CPU_PM if (SUSPEND || CPU_IDLE)
>   	select DCACHE_WORD_ACCESS
> +	select DMA_DIRECT_OPS
>   	select EDAC_SUPPORT
>   	select FRAME_POINTER
>   	select GENERIC_ALLOCATOR
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 0d641875b20e..a96ec0181818 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -91,46 +91,6 @@ static int __free_from_pool(void *start, size_t size)
>   	return 1;
>   }
>   
> -static void *__dma_alloc_coherent(struct device *dev, size_t size,
> -				  dma_addr_t *dma_handle, gfp_t flags,
> -				  unsigned long attrs)
> -{
> -	if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
> -	    dev->coherent_dma_mask <= DMA_BIT_MASK(32))
> -		flags |= GFP_DMA32;
> -	if (dev_get_cma_area(dev) && gfpflags_allow_blocking(flags)) {
> -		struct page *page;
> -		void *addr;
> -
> -		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
> -						 get_order(size), flags);
> -		if (!page)
> -			return NULL;
> -
> -		*dma_handle = phys_to_dma(dev, page_to_phys(page));
> -		addr = page_address(page);
> -		memset(addr, 0, size);
> -		return addr;
> -	} else {
> -		return swiotlb_alloc_coherent(dev, size, dma_handle, flags);
> -	}
> -}
> -
> -static void __dma_free_coherent(struct device *dev, size_t size,
> -				void *vaddr, dma_addr_t dma_handle,
> -				unsigned long attrs)
> -{
> -	bool freed;
> -	phys_addr_t paddr = dma_to_phys(dev, dma_handle);
> -
> -
> -	freed = dma_release_from_contiguous(dev,
> -					phys_to_page(paddr),
> -					size >> PAGE_SHIFT);
> -	if (!freed)
> -		swiotlb_free_coherent(dev, size, vaddr, dma_handle);
> -}
> -
>   static void *__dma_alloc(struct device *dev, size_t size,
>   			 dma_addr_t *dma_handle, gfp_t flags,
>   			 unsigned long attrs)
> @@ -152,7 +112,7 @@ static void *__dma_alloc(struct device *dev, size_t size,
>   		return addr;
>   	}
>   
> -	ptr = __dma_alloc_coherent(dev, size, dma_handle, flags, attrs);
> +	ptr = swiotlb_alloc(dev, size, dma_handle, flags, attrs);
>   	if (!ptr)
>   		goto no_mem;
>   
> @@ -173,7 +133,7 @@ static void *__dma_alloc(struct device *dev, size_t size,
>   	return coherent_ptr;
>   
>   no_map:
> -	__dma_free_coherent(dev, size, ptr, *dma_handle, attrs);
> +	swiotlb_free(dev, size, ptr, *dma_handle, attrs);
>   no_mem:
>   	return NULL;
>   }
> @@ -191,7 +151,7 @@ static void __dma_free(struct device *dev, size_t size,
>   			return;
>   		vunmap(vaddr);
>   	}
> -	__dma_free_coherent(dev, size, swiotlb_addr, dma_handle, attrs);
> +	swiotlb_free(dev, size, swiotlb_addr, dma_handle, attrs);
>   }
>   
>   static dma_addr_t __swiotlb_map_page(struct device *dev, struct page *page,
> 
