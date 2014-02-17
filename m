Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Feb 2014 06:42:08 +0100 (CET)
Received: from mail.lemote.com ([222.92.8.138]:51432 "EHLO mail.lemote.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6869245AbaBQFmEFNbug (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Feb 2014 06:42:04 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail.lemote.com (Postfix) with ESMTP id 8BE6522CC9;
        Mon, 17 Feb 2014 13:41:56 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from mail.lemote.com ([127.0.0.1])
        by localhost (mail.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TshEWTo7wn45; Mon, 17 Feb 2014 13:41:49 +0800 (CST)
Received: from mail.lemote.com (localhost [127.0.0.1])
        (Authenticated sender: chenhc@lemote.com)
        by mail.lemote.com (Postfix) with ESMTPA id 12A1422742;
        Mon, 17 Feb 2014 13:41:48 +0800 (CST)
Received: from 222.92.8.142
        (SquirrelMail authenticated user chenhc)
        by mail.lemote.com with HTTP;
        Mon, 17 Feb 2014 13:41:49 +0800
Message-ID: <c4cab01ceda4c21c8d9c7e471edfe000.squirrel@mail.lemote.com>
In-Reply-To: <20140216211206.GA491@hall.aurel32.net>
References: <1392537690-5961-1-git-send-email-chenhc@lemote.com>
    <1392537690-5961-10-git-send-email-chenhc@lemote.com>
    <20140216211206.GA491@hall.aurel32.net>
Date:   Mon, 17 Feb 2014 13:41:49 +0800
Subject: Re: [PATCH V19 09/13] MIPS: Loongson: Add swiotlb to support
 All-Memory DMA
From:   =?gb2312?Q?=22=B3=C2=BB=AA=B2=C5=22?= <chenhc@lemote.com>
To:     "Aurelien Jarno" <aurelien@aurel32.net>
Cc:     "Ralf Baechle" <ralf@linux-mips.org>,
        "John Crispin" <john@phrozen.org>,
        "Steven J. Hill" <steven.hill@imgtec.com>,
        linux-mips@linux-mips.org, "Fuxin Zhang" <zhangfx@lemote.com>,
        "Zhangjin Wu" <wuzhangjin@gmail.com>,
        "Hongliang Tao" <taohl@lemote.com>, "Hua Yan" <yanh@lemote.com>
User-Agent: SquirrelMail/1.4.22
MIME-Version: 1.0
Content-Type: text/plain;charset=gb2312
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

> On Sun, Feb 16, 2014 at 04:01:26PM +0800, Huacai Chen wrote:
>> Loongson doesn't support DMA address above 4GB traditionally. If memory
>> is more than 4GB, CONFIG_SWIOTLB and ZONE_DMA32 should be selected. In
>> this way, DMA pages are allocated below 4GB preferably. However, if low
>> memory is not enough, high pages are allocated and swiotlb is used for
>> bouncing.
>>
>> Moreover, we provide a platform-specific dma_map_ops::set_dma_mask() to
>> set a device's dma_mask and coherent_dma_mask. We use these masks to
>> distinguishes an allocated page can be used for DMA directly, or need
>> swiotlb to bounce.
>>
>> Recently, we found that 32-bit DMA isn't a hardware bug, but a hardware
>> configuration issue. So, latest firmware has enable the DMA support as
>> high as 40-bit. To support all-memory DMA for all devices (besides the
>> Loongson platform limit, there are still some devices have their own
>> DMA32 limit), and also to be compatible with old firmware, we keep use
>> swiotlb.
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> Signed-off-by: Hongliang Tao <taohl@lemote.com>
>> Signed-off-by: Hua Yan <yanh@lemote.com>
>> Tested-by: Alex Smith <alex.smith@imgtec.com>
>> Reviewed-by: Alex Smith <alex.smith@imgtec.com>
>> ---
>>  arch/mips/include/asm/dma-mapping.h                |    5 +
>>  .../mips/include/asm/mach-loongson/dma-coherence.h |   22 +++-
>>  arch/mips/loongson/common/Makefile                 |    5 +
>>  arch/mips/loongson/common/dma-swiotlb.c            |  136
>> ++++++++++++++++++++
>>  4 files changed, 167 insertions(+), 1 deletions(-)
>>  create mode 100644 arch/mips/loongson/common/dma-swiotlb.c
>>
>> diff --git a/arch/mips/include/asm/dma-mapping.h
>> b/arch/mips/include/asm/dma-mapping.h
>> index 84238c5..06412aa 100644
>> --- a/arch/mips/include/asm/dma-mapping.h
>> +++ b/arch/mips/include/asm/dma-mapping.h
>> @@ -49,9 +49,14 @@ static inline int dma_mapping_error(struct device
>> *dev, u64 mask)
>>  static inline int
>>  dma_set_mask(struct device *dev, u64 mask)
>>  {
>> +	struct dma_map_ops *ops = get_dma_ops(dev);
>> +
>>  	if(!dev->dma_mask || !dma_supported(dev, mask))
>>  		return -EIO;
>>
>> +	if (ops->set_dma_mask)
>> +		return ops->set_dma_mask(dev, mask);
>> +
>>  	*dev->dma_mask = mask;
>>
>>  	return 0;
>> diff --git a/arch/mips/include/asm/mach-loongson/dma-coherence.h
>> b/arch/mips/include/asm/mach-loongson/dma-coherence.h
>> index aeb2c05..6a90275 100644
>> --- a/arch/mips/include/asm/mach-loongson/dma-coherence.h
>> +++ b/arch/mips/include/asm/mach-loongson/dma-coherence.h
>> @@ -11,24 +11,40 @@
>>  #ifndef __ASM_MACH_LOONGSON_DMA_COHERENCE_H
>>  #define __ASM_MACH_LOONGSON_DMA_COHERENCE_H
>>
>> +#ifdef CONFIG_SWIOTLB
>> +#include <linux/swiotlb.h>
>> +#endif
>> +
>>  struct device;
>>
>> +extern dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr);
>> +extern phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr);
>>  static inline dma_addr_t plat_map_dma_mem(struct device *dev, void
>> *addr,
>>  					  size_t size)
>>  {
>> +#ifdef CONFIG_CPU_LOONGSON3
>> +	return virt_to_phys(addr);
>> +#else
>>  	return virt_to_phys(addr) | 0x80000000;
>> +#endif
>>  }
>>
>>  static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
>>  					       struct page *page)
>>  {
>> +#ifdef CONFIG_CPU_LOONGSON3
>> +	return page_to_phys(page);
>> +#else
>>  	return page_to_phys(page) | 0x80000000;
>> +#endif
>>  }
>>
>>  static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
>>  	dma_addr_t dma_addr)
>>  {
>> -#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
>> +#if defined(CONFIG_CPU_LOONGSON3) && defined(CONFIG_64BIT)
>> +	return dma_addr;
>> +#elif defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
>>  	return (dma_addr > 0x8fffffff) ? dma_addr : (dma_addr & 0x0fffffff);
>>  #else
>>  	return dma_addr & 0x7fffffff;
>> @@ -55,7 +71,11 @@ static inline int plat_dma_supported(struct device
>> *dev, u64 mask)
>>
>>  static inline int plat_device_is_coherent(struct device *dev)
>>  {
>> +#ifdef CONFIG_DMA_NONCOHERENT
>>  	return 0;
>> +#else
>> +	return 1;
>> +#endif /* CONFIG_DMA_NONCOHERENT */
>>  }
>>
>>  #endif /* __ASM_MACH_LOONGSON_DMA_COHERENCE_H */
>> diff --git a/arch/mips/loongson/common/Makefile
>> b/arch/mips/loongson/common/Makefile
>> index 9e4484c..0bb9cc9 100644
>> --- a/arch/mips/loongson/common/Makefile
>> +++ b/arch/mips/loongson/common/Makefile
>> @@ -26,3 +26,8 @@ obj-$(CONFIG_CS5536) += cs5536/
>>  #
>>
>>  obj-$(CONFIG_LOONGSON_SUSPEND) += pm.o
>> +
>> +#
>> +# Big Memory (SWIOTLB) Support
>> +#
>> +obj-$(CONFIG_SWIOTLB) += dma-swiotlb.o
>> diff --git a/arch/mips/loongson/common/dma-swiotlb.c
>> b/arch/mips/loongson/common/dma-swiotlb.c
>> new file mode 100644
>> index 0000000..c2be01f
>> --- /dev/null
>> +++ b/arch/mips/loongson/common/dma-swiotlb.c
>> @@ -0,0 +1,136 @@
>> +#include <linux/mm.h>
>> +#include <linux/init.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/scatterlist.h>
>> +#include <linux/swiotlb.h>
>> +#include <linux/bootmem.h>
>> +
>> +#include <asm/bootinfo.h>
>> +#include <boot_param.h>
>> +#include <dma-coherence.h>
>> +
>> +static void *loongson_dma_alloc_coherent(struct device *dev, size_t
>> size,
>> +		dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
>> +{
>> +	void *ret;
>> +
>> +	if (dma_alloc_from_coherent(dev, size, dma_handle, &ret))
>> +		return ret;
>> +
>> +	/* ignore region specifiers */
>> +	gfp &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
>> +
>> +#ifdef CONFIG_ISA
>> +	if (dev == NULL)
>> +		gfp |= __GFP_DMA;
>> +	else
>> +#endif
>> +#ifdef CONFIG_ZONE_DMA
>> +	if (dev->coherent_dma_mask < DMA_BIT_MASK(32))
>> +		gfp |= __GFP_DMA;
>> +	else
>> +#endif
>> +#ifdef CONFIG_ZONE_DMA32
>> +	if (dev->coherent_dma_mask < DMA_BIT_MASK(40))
>> +		gfp |= __GFP_DMA32;
>> +	else
>
> I think the same logic as in loongson_dma_set_mask should be used there,
> so that the bounce buffer is not used when it is possible to directly
> allocate the memory correctly. Something like this should work:
It seems like that we needn't to do so. Assume that loongson_sysconf.
dma_mask_bits is 41 and a device's dma_mask is 40. DMA32 zone is very
limited, but all physical memory addresses are below 40bit. If using
 __GFP_DMA32, swiotlb is probably needed because DMA32 zone is exhausted
by those dma32 devices; but if not using __GFP_DMA32, swiotlb isn't need
completely.

Huacai

>
> #ifdef CONFIG_ZONE_DMA32
> 	if (dev->coherent_dma_mask <
> DMA_BIT_MASK(loongson_sysconf.dma_mask_bits))
> 		gfp |= __GFP_DMA32;
> 	else
> #endif
>
>> +#endif
>> +	;
>> +	gfp |= __GFP_NORETRY;
>> +
>> +	ret = swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
>> +	mb();
>> +	return ret;
>> +}
>> +
>> +static void loongson_dma_free_coherent(struct device *dev, size_t size,
>> +		void *vaddr, dma_addr_t dma_handle, struct dma_attrs *attrs)
>> +{
>> +	int order = get_order(size);
>> +
>> +	if (dma_release_from_coherent(dev, order, vaddr))
>> +		return;
>> +
>> +	swiotlb_free_coherent(dev, size, vaddr, dma_handle);
>> +}
>> +
>> +static dma_addr_t loongson_dma_map_page(struct device *dev, struct page
>> *page,
>> +				unsigned long offset, size_t size,
>> +				enum dma_data_direction dir,
>> +				struct dma_attrs *attrs)
>> +{
>> +	dma_addr_t daddr = swiotlb_map_page(dev, page, offset, size,
>> +					dir, attrs);
>> +	mb();
>> +	return daddr;
>> +}
>> +
>> +static int loongson_dma_map_sg(struct device *dev, struct scatterlist
>> *sg,
>> +				int nents, enum dma_data_direction dir,
>> +				struct dma_attrs *attrs)
>> +{
>> +	int r = swiotlb_map_sg_attrs(dev, sg, nents, dir, NULL);
>> +	mb();
>> +
>> +	return r;
>> +}
>> +
>> +static void loongson_dma_sync_single_for_device(struct device *dev,
>> +				dma_addr_t dma_handle, size_t size,
>> +				enum dma_data_direction dir)
>> +{
>> +	swiotlb_sync_single_for_device(dev, dma_handle, size, dir);
>> +	mb();
>> +}
>> +
>> +static void loongson_dma_sync_sg_for_device(struct device *dev,
>> +				struct scatterlist *sg, int nents,
>> +				enum dma_data_direction dir)
>> +{
>> +	swiotlb_sync_sg_for_device(dev, sg, nents, dir);
>> +	mb();
>> +}
>> +
>> +static int loongson_dma_set_mask(struct device *dev, u64 mask)
>> +{
>> +	if (mask > DMA_BIT_MASK(loongson_sysconf.dma_mask_bits)) {
>> +		*dev->dma_mask = DMA_BIT_MASK(loongson_sysconf.dma_mask_bits);
>> +		return -EIO;
>> +	}
>> +
>> +	*dev->dma_mask = mask;
>> +
>> +	return 0;
>> +}
>> +
>> +dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
>> +{
>> +	return paddr;
>> +}
>> +
>> +phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
>> +{
>> +	return daddr;
>> +}
>> +
>> +static struct dma_map_ops loongson_dma_map_ops = {
>> +	.alloc = loongson_dma_alloc_coherent,
>> +	.free = loongson_dma_free_coherent,
>> +	.map_page = loongson_dma_map_page,
>> +	.unmap_page = swiotlb_unmap_page,
>> +	.map_sg = loongson_dma_map_sg,
>> +	.unmap_sg = swiotlb_unmap_sg_attrs,
>> +	.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
>> +	.sync_single_for_device = loongson_dma_sync_single_for_device,
>> +	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
>> +	.sync_sg_for_device = loongson_dma_sync_sg_for_device,
>> +	.mapping_error = swiotlb_dma_mapping_error,
>> +	.dma_supported = swiotlb_dma_supported,
>> +	.set_dma_mask = loongson_dma_set_mask
>> +};
>> +
>> +void __init plat_swiotlb_setup(void)
>> +{
>> +	swiotlb_init(1);
>> +	mips_dma_map_ops = &loongson_dma_map_ops;
>> +}
>> --
>> 1.7.7.3
>>
>>
>
> --
> Aurelien Jarno	                        GPG: 1024D/F1BCDB73
> aurelien@aurel32.net                 http://www.aurel32.net
>
