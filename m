Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 13:22:36 +0100 (CET)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45664 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993981AbeAJMW3TNGfX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 13:22:29 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 577E71435;
        Wed, 10 Jan 2018 04:22:22 -0800 (PST)
Received: from [10.1.210.88] (e110467-lin.cambridge.arm.com [10.1.210.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D3323F581;
        Wed, 10 Jan 2018 04:22:20 -0800 (PST)
Subject: Re: [PATCH 10/22] swiotlb: refactor coherent buffer allocation
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        Michal Simek <monstr@monstr.eu>, linux-ia64@vger.kernel.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20180110080932.14157-1-hch@lst.de>
 <20180110080932.14157-11-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <cecc98cf-2e6a-a7bc-7390-d6dcced038c4@arm.com>
Date:   Wed, 10 Jan 2018 12:22:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180110080932.14157-11-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <robin.murphy@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62032
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
> Factor out a new swiotlb_alloc_buffer helper that allocates DMA coherent
> memory from the swiotlb bounce buffer.
> 
> This allows to simplify the swiotlb_alloc implemenation that uses
> dma_direct_alloc to try to allocate a reachable buffer first.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   lib/swiotlb.c | 122 +++++++++++++++++++++++++++++++---------------------------
>   1 file changed, 65 insertions(+), 57 deletions(-)
> 
> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
> index 1a147f1354a1..bf2d19ee91c1 100644
> --- a/lib/swiotlb.c
> +++ b/lib/swiotlb.c
> @@ -709,75 +709,79 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
>   }
>   EXPORT_SYMBOL_GPL(swiotlb_tbl_sync_single);
>   
> -void *
> -swiotlb_alloc_coherent(struct device *hwdev, size_t size,
> -		       dma_addr_t *dma_handle, gfp_t flags)
> +static inline bool dma_coherent_ok(struct device *dev, dma_addr_t addr,
> +		size_t size)
>   {
> -	bool warn = !(flags & __GFP_NOWARN);
> -	dma_addr_t dev_addr;
> -	void *ret;
> -	int order = get_order(size);
> -	u64 dma_mask = DMA_BIT_MASK(32);
> +	u64 mask = DMA_BIT_MASK(32);
>   
> -	if (hwdev && hwdev->coherent_dma_mask)
> -		dma_mask = hwdev->coherent_dma_mask;
> +	if (dev && dev->coherent_dma_mask)
> +		mask = dev->coherent_dma_mask;
> +	return addr + size - 1 <= mask;
> +}
>   
> -	ret = (void *)__get_free_pages(flags, order);
> -	if (ret) {
> -		dev_addr = swiotlb_virt_to_bus(hwdev, ret);
> -		if (dev_addr + size - 1 > dma_mask) {
> -			/*
> -			 * The allocated memory isn't reachable by the device.
> -			 */
> -			free_pages((unsigned long) ret, order);
> -			ret = NULL;
> -		}
> -	}
> -	if (!ret) {
> -		/*
> -		 * We are either out of memory or the device can't DMA to
> -		 * GFP_DMA memory; fall back on map_single(), which
> -		 * will grab memory from the lowest available address range.
> -		 */
> -		phys_addr_t paddr = map_single(hwdev, 0, size, DMA_FROM_DEVICE,
> -					       warn ? 0 : DMA_ATTR_NO_WARN);
> -		if (paddr == SWIOTLB_MAP_ERROR)
> -			goto err_warn;
> +static void *
> +swiotlb_alloc_buffer(struct device *dev, size_t size, dma_addr_t *dma_handle,
> +		unsigned long attrs)
> +{
> +	phys_addr_t phys_addr;
> +
> +	if (swiotlb_force == SWIOTLB_NO_FORCE)
> +		goto out_warn;
>   
> -		ret = phys_to_virt(paddr);
> -		dev_addr = swiotlb_phys_to_dma(hwdev, paddr);
> +	phys_addr = swiotlb_tbl_map_single(dev,
> +			swiotlb_phys_to_dma(dev, io_tlb_start),
> +			0, size, DMA_FROM_DEVICE, 0);
> +	if (phys_addr == SWIOTLB_MAP_ERROR)
> +		goto out_warn;
>   
> -		/* Confirm address can be DMA'd by device */
> -		if (dev_addr + size - 1 > dma_mask) {
> -			printk("hwdev DMA mask = 0x%016Lx, dev_addr = 0x%016Lx\n",
> -			       (unsigned long long)dma_mask,
> -			       (unsigned long long)dev_addr);
> +	*dma_handle = swiotlb_phys_to_dma(dev, phys_addr);

nit: this should probably go after the dma_coherent_ok() check (as with 
the original logic).

>   
> -			/*
> -			 * DMA_TO_DEVICE to avoid memcpy in unmap_single.
> -			 * The DMA_ATTR_SKIP_CPU_SYNC is optional.
> -			 */
> -			swiotlb_tbl_unmap_single(hwdev, paddr,
> -						 size, DMA_TO_DEVICE,
> -						 DMA_ATTR_SKIP_CPU_SYNC);
> -			goto err_warn;
> -		}
> -	}
> +	if (dma_coherent_ok(dev, *dma_handle, size))
> +		goto out_unmap;
>   
> -	*dma_handle = dev_addr;
> -	memset(ret, 0, size);
> +	memset(phys_to_virt(phys_addr), 0, size);
> +	return phys_to_virt(phys_addr);
>   
> -	return ret;
> +out_unmap:
> +	dev_warn(dev, "hwdev DMA mask = 0x%016Lx, dev_addr = 0x%016Lx\n",
> +		(unsigned long long)(dev ? dev->coherent_dma_mask : 0),
> +		(unsigned long long)*dma_handle);
>   
> -err_warn:
> -	if (warn && printk_ratelimit()) {
> -		pr_warn("swiotlb: coherent allocation failed for device %s size=%zu\n",
> -			dev_name(hwdev), size);
> +	/*
> +	 * DMA_TO_DEVICE to avoid memcpy in unmap_single.
> +	 * DMA_ATTR_SKIP_CPU_SYNC is optional.
> +	 */
> +	swiotlb_tbl_unmap_single(dev, phys_addr, size, DMA_TO_DEVICE,
> +			DMA_ATTR_SKIP_CPU_SYNC);
> +out_warn:
> +	if ((attrs & DMA_ATTR_NO_WARN) && printk_ratelimit()) {
> +		dev_warn(dev,
> +			"swiotlb: coherent allocation failed, size=%zu\n",
> +			size);
>   		dump_stack();
>   	}
> -
>   	return NULL;
>   }
> +
> +void *
> +swiotlb_alloc_coherent(struct device *hwdev, size_t size,
> +		       dma_addr_t *dma_handle, gfp_t flags)
> +{
> +	int order = get_order(size);
> +	unsigned long attrs = (flags & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0;
> +	void *ret;
> +
> +	ret = (void *)__get_free_pages(flags, order);
> +	if (ret) {
> +		*dma_handle = swiotlb_virt_to_bus(hwdev, ret);
> +		if (dma_coherent_ok(hwdev, *dma_handle, size)) {
> +			memset(ret, 0, size);
> +			return ret;
> +		}

Aren't we leaking the pages here?

Robin.

> +	}
> +
> +	return swiotlb_alloc_buffer(hwdev, size, dma_handle, attrs);
> +}
>   EXPORT_SYMBOL(swiotlb_alloc_coherent);
>   
>   static bool swiotlb_free_buffer(struct device *dev, size_t size,
> @@ -1103,6 +1107,10 @@ void *swiotlb_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   {
>   	void *vaddr;
>   
> +	/* temporary workaround: */
> +	if (gfp & __GFP_NOWARN)
> +		attrs |= DMA_ATTR_NO_WARN;
> +
>   	/*
>   	 * Don't print a warning when the first allocation attempt fails.
>   	 * swiotlb_alloc_coherent() will print a warning when the DMA memory
> @@ -1112,7 +1120,7 @@ void *swiotlb_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   
>   	vaddr = dma_direct_alloc(dev, size, dma_handle, gfp, attrs);
>   	if (!vaddr)
> -		vaddr = swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
> +		vaddr = swiotlb_alloc_buffer(dev, size, dma_handle, attrs);
>   	return vaddr;
>   }
>   
> 
