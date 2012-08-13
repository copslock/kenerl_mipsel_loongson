Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Aug 2012 20:04:53 +0200 (CEST)
Received: from rcsinet15.oracle.com ([148.87.113.117]:25556 "EHLO
        rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903503Ab2HMSEp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Aug 2012 20:04:45 +0200
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
        by rcsinet15.oracle.com (Sentrion-MTA-4.2.2/Sentrion-MTA-4.2.2) with ESMTP id q7DI4TVr027321
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 13 Aug 2012 18:04:30 GMT
Received: from acsmt356.oracle.com (acsmt356.oracle.com [141.146.40.156])
        by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id q7DI4R3u005792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 13 Aug 2012 18:04:28 GMT
Received: from abhmt108.oracle.com (abhmt108.oracle.com [141.146.116.60])
        by acsmt356.oracle.com (8.12.11.20060308/8.12.11) with ESMTP id q7DI4QkR018007;
        Mon, 13 Aug 2012 13:04:27 -0500
Received: from phenom.dumpdata.com (/209.6.85.33)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Aug 2012 11:04:26 -0700
Received: by phenom.dumpdata.com (Postfix, from userid 1000)
        id 33164402BA; Mon, 13 Aug 2012 13:54:47 -0400 (EDT)
Date:   Mon, 13 Aug 2012 13:54:47 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V5 09/18] MIPS: Loongson: Add swiotlb to support big
 memory (>4GB).
Message-ID: <20120813175447.GB26088@phenom.dumpdata.com>
References: <1344677543-22591-1-git-send-email-chenhc@lemote.com>
 <1344677543-22591-10-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1344677543-22591-10-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Source-IP: acsinet22.oracle.com [141.146.126.238]
X-archive-position: 34132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: konrad.wilk@oracle.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Status: A

> +static void *loongson_dma_alloc_coherent(struct device *dev, size_t size,
> +				dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
> +{
> +	void *ret;
> +
> +	if (dma_alloc_from_coherent(dev, size, dma_handle, &ret))
> +		return ret;
> +
> +	/* ignore region specifiers */
> +	gfp &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
> +
> +#ifdef CONFIG_ZONE_DMA
> +	if (dev == NULL)
> +		gfp |= __GFP_DMA;

When would this happen? dev == NULL?

> +	else if (dev->coherent_dma_mask <= DMA_BIT_MASK(24))
> +		gfp |= __GFP_DMA;
> +	else
> +#endif
> +#ifdef CONFIG_ZONE_DMA32
> +	if (dev->coherent_dma_mask <= DMA_BIT_MASK(32))
> +		gfp |= __GFP_DMA32;
> +	else

Why the 'else'
> +#endif
> +	;

why?
> +	gfp |= __GFP_NORETRY;
> +
> +	ret = swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
> +	mb();

Why the 'mb()' ? Can you just do
	return swiotlb_alloc_coherent(...) 

> +	return ret;
> +}
> +
> +static void loongson_dma_free_coherent(struct device *dev, size_t size,
> +				void *vaddr, dma_addr_t dma_handle, struct dma_attrs *attrs)
> +{
> +	int order = get_order(size);
> +
> +	if (dma_release_from_coherent(dev, order, vaddr))
> +		return;
> +
> +	swiotlb_free_coherent(dev, size, vaddr, dma_handle);
> +}
> +
> +static dma_addr_t loongson_dma_map_page(struct device *dev, struct page *page,
> +				unsigned long offset, size_t size,
> +				enum dma_data_direction dir,
> +				struct dma_attrs *attrs)
> +{
> +	dma_addr_t daddr = swiotlb_map_page(dev, page, offset, size,
> +					dir, attrs);
> +	mb();

Please do 'return swiotlb_map_page(..)'..

But if you are doing that why don't you just set the dma_ops.map_page = swiotlb_map_page
?


> +	return daddr;
> +}
> +
> +static int loongson_dma_map_sg(struct device *dev, struct scatterlist *sg,
> +				int nents, enum dma_data_direction dir,
> +				struct dma_attrs *attrs)
> +{
> +	int r = swiotlb_map_sg_attrs(dev, sg, nents, dir, NULL);
> +	mb();
> +
> +	return r;
> +}
> +
> +static void loongson_dma_sync_single_for_device(struct device *dev,
> +				dma_addr_t dma_handle, size_t size,
> +				enum dma_data_direction dir)
> +{
> +	swiotlb_sync_single_for_device(dev, dma_handle, size, dir);
> +	mb();
> +}
> +
> +static void loongson_dma_sync_sg_for_device(struct device *dev,
> +				struct scatterlist *sg, int nents,
> +				enum dma_data_direction dir)
> +{
> +	swiotlb_sync_sg_for_device(dev, sg, nents, dir);
> +	mb();
> +}
> +

I am not really sure why you have these extra functions, when you could
just modify the dma_ops to point to the swiotlb ones

> +static dma_addr_t loongson_unity_phys_to_dma(struct device *dev, phys_addr_t paddr)
> +{
> +	return (paddr < 0x10000000) ?
> +			(paddr | 0x0000000080000000) : paddr;
> +}
> +
> +static phys_addr_t loongson_unity_dma_to_phys(struct device *dev, dma_addr_t daddr)
> +{
> +	return (daddr < 0x90000000 && daddr >= 0x80000000) ?
> +			(daddr & 0x0fffffff) : daddr;
> +}
> +
> +struct loongson_dma_map_ops {
> +	struct dma_map_ops dma_map_ops;
> +	dma_addr_t (*phys_to_dma)(struct device *dev, phys_addr_t paddr);
> +	phys_addr_t (*dma_to_phys)(struct device *dev, dma_addr_t daddr);
> +};
> +
> +dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
> +{
> +	struct loongson_dma_map_ops *ops = container_of(get_dma_ops(dev),
> +					struct loongson_dma_map_ops, dma_map_ops);
> +
> +	return ops->phys_to_dma(dev, paddr);
> +}
> +
> +phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
> +{
> +	struct loongson_dma_map_ops *ops = container_of(get_dma_ops(dev),
> +					struct loongson_dma_map_ops, dma_map_ops);
> +
> +	return ops->dma_to_phys(dev, daddr);
> +}
> +
> +static int loongson_dma_set_mask(struct device *dev, u64 mask)
> +{
> +	/* Loongson doesn't support DMA above 32-bit */
> +	if (mask > DMA_BIT_MASK(32))
> +		return -EIO;
> +
> +	*dev->dma_mask = mask;
> +
> +	return 0;
> +}
> +
> +static struct loongson_dma_map_ops loongson_linear_dma_map_ops = {
> +	.dma_map_ops = {
> +		.alloc = loongson_dma_alloc_coherent,
> +		.free = loongson_dma_free_coherent,
> +		.map_page = loongson_dma_map_page,

But why not 'swiotlb_map_page'?

> +		.unmap_page = swiotlb_unmap_page,
> +		.map_sg = loongson_dma_map_sg,
> +		.unmap_sg = swiotlb_unmap_sg_attrs,
> +		.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
> +		.sync_single_for_device = loongson_dma_sync_single_for_device,
> +		.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
> +		.sync_sg_for_device = loongson_dma_sync_sg_for_device,
> +		.mapping_error = swiotlb_dma_mapping_error,
> +		.dma_supported = swiotlb_dma_supported,
> +		.set_dma_mask = loongson_dma_set_mask
> +	},
> +	.phys_to_dma = loongson_unity_phys_to_dma,
> +	.dma_to_phys = loongson_unity_dma_to_phys

Why do you need these? I am not seeing it being used here by any external code?

> +};
> +
> +void __init plat_swiotlb_setup(void)
> +{
> +	swiotlb_init(1);
> +	mips_dma_map_ops = &loongson_linear_dma_map_ops.dma_map_ops;
> +}
> diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
> index 3fab204..122f4f8 100644
> --- a/arch/mips/mm/dma-default.c
> +++ b/arch/mips/mm/dma-default.c
> @@ -42,6 +42,13 @@ static inline int cpu_is_noncoherent_r10000(struct device *dev)
>  	       current_cpu_type() == CPU_R12000);
>  }
>  
> +static inline int cpu_is_noncoherent_loongson(struct device *dev)
> +{
> +	return !plat_device_is_coherent(dev) &&
> +			(current_cpu_type() == CPU_LOONGSON2 ||
> +			 current_cpu_type() == CPU_LOONGSON3);
> +}
> +
>  static gfp_t massage_gfp_flags(const struct device *dev, gfp_t gfp)
>  {
>  	gfp_t dma_flag;
> @@ -209,7 +216,7 @@ static inline void __dma_sync(struct page *page,
>  static void mips_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
>  	size_t size, enum dma_data_direction direction, struct dma_attrs *attrs)
>  {
> -	if (cpu_is_noncoherent_r10000(dev))
> +	if (cpu_is_noncoherent_r10000(dev) || cpu_is_noncoherent_loongson(dev))
>  		__dma_sync(dma_addr_to_page(dev, dma_addr),
>  			   dma_addr & ~PAGE_MASK, size, direction);
>  
> @@ -260,7 +267,7 @@ static void mips_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>  static void mips_dma_sync_single_for_cpu(struct device *dev,
>  	dma_addr_t dma_handle, size_t size, enum dma_data_direction direction)
>  {
> -	if (cpu_is_noncoherent_r10000(dev))
> +	if (cpu_is_noncoherent_r10000(dev) || cpu_is_noncoherent_loongson(dev))
>  		__dma_sync(dma_addr_to_page(dev, dma_handle),
>  			   dma_handle & ~PAGE_MASK, size, direction);
>  }
> @@ -281,7 +288,7 @@ static void mips_dma_sync_sg_for_cpu(struct device *dev,
>  
>  	/* Make sure that gcc doesn't leave the empty loop body.  */
>  	for (i = 0; i < nelems; i++, sg++) {
> -		if (cpu_is_noncoherent_r10000(dev))
> +		if (cpu_is_noncoherent_r10000(dev) || cpu_is_noncoherent_loongson(dev))
>  			__dma_sync(sg_page(sg), sg->offset, sg->length,
>  				   direction);
>  	}
> -- 
> 1.7.7.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
