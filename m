Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Dec 2013 15:48:01 +0100 (CET)
Received: from [195.154.112.97] ([195.154.112.97]:47465 "EHLO hall.aurel32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816233Ab3LaOr6GwUFE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Dec 2013 15:47:58 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1Vy0bq-0000OT-6u; Tue, 31 Dec 2013 15:47:54 +0100
Date:   Tue, 31 Dec 2013 15:47:54 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V15 08/12] MIPS: Loongson: Add swiotlb to support big
 memory (>4GB)
Message-ID: <20131231144754.GA20933@hall.aurel32.net>
References: <1387109676-540-1-git-send-email-chenhc@lemote.com>
 <1387109676-540-9-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1387109676-540-9-git-send-email-chenhc@lemote.com>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

On Sun, Dec 15, 2013 at 08:14:32PM +0800, Huacai Chen wrote:
> This is probably a workaround because Loongson doesn't support DMA
> address above 4GB. If memory is more than 4GB, CONFIG_SWIOTLB and
> ZONE_DMA32 should be selected. In this way, DMA pages are allocated
> below 4GB preferably.
> 
> However, CONFIG_SWIOTLB+ZONE_DMA32 is not enough, so, we provide a
> platform-specific dma_map_ops::set_dma_mask() to make sure each
> driver's dma_mask and coherent_dma_mask is below 32-bit.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Hongliang Tao <taohl@lemote.com>
> Signed-off-by: Hua Yan <yanh@lemote.com>
> ---
>  arch/mips/include/asm/dma-mapping.h                |    5 +
>  .../mips/include/asm/mach-loongson/dma-coherence.h |   23 +++
>  arch/mips/loongson/common/Makefile                 |    5 +
>  arch/mips/loongson/common/dma-swiotlb.c            |  163 ++++++++++++++++++++
>  4 files changed, 196 insertions(+), 0 deletions(-)
>  create mode 100644 arch/mips/loongson/common/dma-swiotlb.c
> 
> diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
> index 84238c5..06412aa 100644
> --- a/arch/mips/include/asm/dma-mapping.h
> +++ b/arch/mips/include/asm/dma-mapping.h
> @@ -49,9 +49,14 @@ static inline int dma_mapping_error(struct device *dev, u64 mask)
>  static inline int
>  dma_set_mask(struct device *dev, u64 mask)
>  {
> +	struct dma_map_ops *ops = get_dma_ops(dev);
> +
>  	if(!dev->dma_mask || !dma_supported(dev, mask))
>  		return -EIO;
>  
> +	if (ops->set_dma_mask)
> +		return ops->set_dma_mask(dev, mask);
> +

Hmm, this doesn't look correct to me, there is probably a bug somewhere
else... (see below).

>  	*dev->dma_mask = mask;
>  
>  	return 0;
> diff --git a/arch/mips/include/asm/mach-loongson/dma-coherence.h b/arch/mips/include/asm/mach-loongson/dma-coherence.h
> index aeb2c05..0461161 100644
> --- a/arch/mips/include/asm/mach-loongson/dma-coherence.h
> +++ b/arch/mips/include/asm/mach-loongson/dma-coherence.h
> @@ -11,18 +11,34 @@
>  #ifndef __ASM_MACH_LOONGSON_DMA_COHERENCE_H
>  #define __ASM_MACH_LOONGSON_DMA_COHERENCE_H
>  
> +#ifdef CONFIG_SWIOTLB
> +#include <linux/swiotlb.h>
> +#endif
> +
>  struct device;
>  
> +extern dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr);
> +extern phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr);
>  static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
>  					  size_t size)
>  {
> +#ifdef CONFIG_CPU_LOONGSON3
> +	return virt_to_phys(addr) < 0x10000000 ?
> +			(virt_to_phys(addr) | 0x0000000080000000) : virt_to_phys(addr);
> +#else
>  	return virt_to_phys(addr) | 0x80000000;
> +#endif
>  }

I have some problem to understand this, especially the fact that the
physical range 0x80000000 -> 0x90000000 will be mapped from two
different area, for virt_to_phys(addr) between 0x00000000 and 0x0fffffff
and for virt_to_phys(addr) between 0x80000000 and 0x90000000.

Could you maybe give us the memory map so that we can understand what is
done here.

>  static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
>  					       struct page *page)
>  {
> +#ifdef CONFIG_CPU_LOONGSON3
> +	return page_to_phys(page) < 0x10000000 ?
> +			(page_to_phys(page) | 0x0000000080000000) : page_to_phys(page);
> +#else
>  	return page_to_phys(page) | 0x80000000;
> +#endif
>  }

Same here.

>  static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
> @@ -30,6 +46,9 @@ static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
>  {
>  #if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
>  	return (dma_addr > 0x8fffffff) ? dma_addr : (dma_addr & 0x0fffffff);
> +#elif defined(CONFIG_CPU_LOONGSON3) && defined(CONFIG_64BIT)
> +	return (dma_addr < 0x90000000 && dma_addr >= 0x80000000) ?
> +			(dma_addr & 0x0fffffff) : dma_addr;
>  #else
>  	return dma_addr & 0x7fffffff;
>  #endif
> @@ -55,7 +74,11 @@ static inline int plat_dma_supported(struct device *dev, u64 mask)
>  
>  static inline int plat_device_is_coherent(struct device *dev)
>  {
> +#ifdef CONFIG_DMA_NONCOHERENT
>  	return 0;
> +#else
> +	return 1;
> +#endif /* CONFIG_DMA_NONCOHERENT */
>  }
>  
>  #endif /* __ASM_MACH_LOONGSON_DMA_COHERENCE_H */
> diff --git a/arch/mips/loongson/common/Makefile b/arch/mips/loongson/common/Makefile
> index 9e4484c..0bb9cc9 100644
> --- a/arch/mips/loongson/common/Makefile
> +++ b/arch/mips/loongson/common/Makefile
> @@ -26,3 +26,8 @@ obj-$(CONFIG_CS5536) += cs5536/
>  #
>  
>  obj-$(CONFIG_LOONGSON_SUSPEND) += pm.o
> +
> +#
> +# Big Memory (SWIOTLB) Support
> +#
> +obj-$(CONFIG_SWIOTLB) += dma-swiotlb.o
> diff --git a/arch/mips/loongson/common/dma-swiotlb.c b/arch/mips/loongson/common/dma-swiotlb.c
> new file mode 100644
> index 0000000..6741f1b
> --- /dev/null
> +++ b/arch/mips/loongson/common/dma-swiotlb.c
> @@ -0,0 +1,163 @@
> +#include <linux/mm.h>
> +#include <linux/init.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/scatterlist.h>
> +#include <linux/swiotlb.h>
> +#include <linux/bootmem.h>
> +
> +#include <asm/bootinfo.h>
> +#include <dma-coherence.h>
> +
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
> +	else if (dev->coherent_dma_mask <= DMA_BIT_MASK(24))
> +		gfp |= __GFP_DMA;
> +	else
> +#endif
> +#ifdef CONFIG_ZONE_DMA32
> +	if (dev == NULL)
> +		gfp |= __GFP_DMA32;
> +	else if (dev->coherent_dma_mask <= DMA_BIT_MASK(32))
> +		gfp |= __GFP_DMA32;
> +	else
> +#endif
> +	;

...this part is probably where the bug lies. You have to force
__GFP_DMA32 (unless __GFP_DMA is set), to make sure the DMA will be
allocated in the 32-bit zone, as Loongson 3A doest support DMA only 
below 4GB.

Also the logic above is likely wrong, I invite you to look at commit
a2e715a86c6dc85fb4a13c0c818637131de44cd2. You want to use __GFP_DMA if
the dma mask doesn't fit in the 32-bit region.

#ifdef CONFIG_ISA
	if (dev == NULL)
		dma_flag = __GFP_DMA;
	else
#endif
#ifdef CONFIG_ZONE_DMA
	if (dev->coherent_dma_mask < DMA_BIT_MASK(32))
		dma_flag = __GFP_DMA;
	else
#endif
#ifdef CONFIG_ZONE_DMA32
	/* Loongson 3A only support DMA in the memory below 4GB */
	dma_flag = __GFP_DMA32;
#endif
	;

> +	gfp |= __GFP_NORETRY;
> +
> +	ret = swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
> +	mb();
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

The name "unity" is a big strange here as it's clearly not a transparent
mapping. You should probably just call them loongson_phys_to_dma and
loongson_dma_to_phys. Also as above I don't really understand what is
done here.

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
> +	if (mask > DMA_BIT_MASK(32)) {
> +		*dev->dma_mask = DMA_BIT_MASK(32);
> +		return -EIO;
> +	}
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
> +};
> +
> +void __init plat_swiotlb_setup(void)
> +{
> +	swiotlb_init(1);
> +	mips_dma_map_ops = &loongson_linear_dma_map_ops.dma_map_ops;
> +}
> -- 
> 1.7.7.3
> 
> 
> 

-- 
Aurelien Jarno	                        GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
