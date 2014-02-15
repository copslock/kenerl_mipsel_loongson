Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Feb 2014 15:50:45 +0100 (CET)
Received: from mail-bk0-f51.google.com ([209.85.214.51]:49489 "EHLO
        mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816642AbaBOOu0RYR7r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Feb 2014 15:50:26 +0100
Received: by mail-bk0-f51.google.com with SMTP id w10so3755927bkz.38
        for <multiple recipients>; Sat, 15 Feb 2014 06:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ICZdtZ1tvrBHaLyDofu1KaFRGYrEOsczRyI+Z5TSFwo=;
        b=FDQ0wGgYvwt3nclAmcuQ/8ca0G5G1pDvknlWKZf3KOcFY1HyMlLWR+hw7NYpwbM39f
         o/gD4f5r6MdRWAWw+PDKR6dIjDYTIrgzQ1jbJ4u8xTg3bLeSn28Q2tuNQ12I39e1YSnA
         ghegKyBfs1FepFS9OWK9lfHkUa19vOar5V7fLT+Y870gpnJevn1yntfADutj3s2OETjk
         mtaQpb5UrUgtOCK+aR0vjMfRGfzRS3Obf3CckyJwCeRyVyf/SXApEA7E3Fpk6wFPt08U
         hc3XDKajcFMBGE+t46Ixj6lpU2UTLv8zAmAQoCG2OKEDYwvbsUuQ0psV8Awuj4HfwO6d
         7Jcg==
MIME-Version: 1.0
X-Received: by 10.204.101.197 with SMTP id d5mr4397943bko.13.1392475820622;
 Sat, 15 Feb 2014 06:50:20 -0800 (PST)
Received: by 10.204.169.76 with HTTP; Sat, 15 Feb 2014 06:50:20 -0800 (PST)
In-Reply-To: <20140214075751.GA8116@ohm.rr44.fr>
References: <1392293343-5453-1-git-send-email-chenhc@lemote.com>
        <1392293343-5453-10-git-send-email-chenhc@lemote.com>
        <20140214075751.GA8116@ohm.rr44.fr>
Date:   Sat, 15 Feb 2014 22:50:20 +0800
X-Google-Sender-Auth: cLeidNz43-f5z_g4lHK17pI2Ow4
Message-ID: <CAAhV-H6RNczW=uOL4KuTa=SKoffUY6s+SMM+FGkbYF3D_6WJXg@mail.gmail.com>
Subject: Re: [PATCH V18 09/13] MIPS: Loongson: Add swiotlb to support big
 memory (>4GB)
From:   Huacai Chen <chenhc@lemote.com>
To:     Aurelien Jarno <aurelien@aurel32.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39308
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

On Fri, Feb 14, 2014 at 3:57 PM, Aurelien Jarno <aurelien@aurel32.net> wrote:
> On Thu, Feb 13, 2014 at 08:08:59PM +0800, Huacai Chen wrote:
>> This is probably a workaround because Loongson doesn't support DMA
>> address above 4GB. If memory is more than 4GB, CONFIG_SWIOTLB and
>> ZONE_DMA32 should be selected. In this way, DMA pages are allocated
>> below 4GB preferably.
>>
>> However, CONFIG_SWIOTLB+ZONE_DMA32 is not enough, so, we provide a
>> platform-specific dma_map_ops::set_dma_mask() to make sure each
>> driver's dma_mask and coherent_dma_mask is below 32-bit.
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
>>  arch/mips/loongson/common/dma-swiotlb.c            |  137 ++++++++++++++++++++
>>  4 files changed, 168 insertions(+), 1 deletions(-)
>>  create mode 100644 arch/mips/loongson/common/dma-swiotlb.c
>>
>> diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
>> index 84238c5..06412aa 100644
>> --- a/arch/mips/include/asm/dma-mapping.h
>> +++ b/arch/mips/include/asm/dma-mapping.h
>> @@ -49,9 +49,14 @@ static inline int dma_mapping_error(struct device *dev, u64 mask)
>>  static inline int
>>  dma_set_mask(struct device *dev, u64 mask)
>>  {
>> +     struct dma_map_ops *ops = get_dma_ops(dev);
>> +
>>       if(!dev->dma_mask || !dma_supported(dev, mask))
>>               return -EIO;
>>
>> +     if (ops->set_dma_mask)
>> +             return ops->set_dma_mask(dev, mask);
>> +
>>       *dev->dma_mask = mask;
>>
>>       return 0;
>> diff --git a/arch/mips/include/asm/mach-loongson/dma-coherence.h b/arch/mips/include/asm/mach-loongson/dma-coherence.h
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
>>  static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
>>                                         size_t size)
>>  {
>> +#ifdef CONFIG_CPU_LOONGSON3
>> +     return virt_to_phys(addr);
>> +#else
>>       return virt_to_phys(addr) | 0x80000000;
>> +#endif
>>  }
>>
>>  static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
>>                                              struct page *page)
>>  {
>> +#ifdef CONFIG_CPU_LOONGSON3
>> +     return page_to_phys(page);
>> +#else
>>       return page_to_phys(page) | 0x80000000;
>> +#endif
>>  }
>>
>>  static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
>>       dma_addr_t dma_addr)
>>  {
>> -#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
>> +#if defined(CONFIG_CPU_LOONGSON3) && defined(CONFIG_64BIT)
>> +     return dma_addr;
>> +#elif defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
>>       return (dma_addr > 0x8fffffff) ? dma_addr : (dma_addr & 0x0fffffff);
>>  #else
>>       return dma_addr & 0x7fffffff;
>> @@ -55,7 +71,11 @@ static inline int plat_dma_supported(struct device *dev, u64 mask)
>>
>>  static inline int plat_device_is_coherent(struct device *dev)
>>  {
>> +#ifdef CONFIG_DMA_NONCOHERENT
>>       return 0;
>> +#else
>> +     return 1;
>> +#endif /* CONFIG_DMA_NONCOHERENT */
>>  }
>>
>>  #endif /* __ASM_MACH_LOONGSON_DMA_COHERENCE_H */
>> diff --git a/arch/mips/loongson/common/Makefile b/arch/mips/loongson/common/Makefile
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
>> diff --git a/arch/mips/loongson/common/dma-swiotlb.c b/arch/mips/loongson/common/dma-swiotlb.c
>> new file mode 100644
>> index 0000000..dcf7d0b
>> --- /dev/null
>> +++ b/arch/mips/loongson/common/dma-swiotlb.c
>> @@ -0,0 +1,137 @@
>> +#include <linux/mm.h>
>> +#include <linux/init.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/scatterlist.h>
>> +#include <linux/swiotlb.h>
>> +#include <linux/bootmem.h>
>> +
>> +#include <asm/bootinfo.h>
>> +#include <dma-coherence.h>
>> +
>> +static void *loongson_dma_alloc_coherent(struct device *dev, size_t size,
>> +             dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
>> +{
>> +     void *ret;
>> +
>> +     if (dma_alloc_from_coherent(dev, size, dma_handle, &ret))
>> +             return ret;
>> +
>> +     /* ignore region specifiers */
>> +     gfp &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
>> +
>> +#ifdef CONFIG_ISA
>> +     if (dev == NULL)
>> +             gfp |= __GFP_DMA;
>> +     else
>> +#endif
>> +#ifdef CONFIG_ZONE_DMA
>> +     if (dev->coherent_dma_mask < DMA_BIT_MASK(32))
>> +             gfp |= __GFP_DMA;
>> +     else
>> +#endif
>> +#ifdef CONFIG_ZONE_DMA32
>> +      /* Loongson-3 only support DMA in the memory below 4GB now */
>> +     if (dev->coherent_dma_mask < DMA_BIT_MASK(40))
>> +             gfp |= __GFP_DMA32;
>
> This code doesn't match the comment above, nor the patch description.
>
> If the Loongson-3 CPU really doesn't support DMA above 4GB, the if test
> with DMA_BIT_MASK(40) should be removed and __GFP_DMA32 always set.
> Not selecting it means the DMA buffer might be allocated above 4GB and
> that the bounce buffer will be use instead. This is works, but has a
> cost in performances.
>
> If the Loongson-3 CPU does support DMA up to 40 bit, the comment and
> the patch description should be adjusted instead.
Recently, we found that 32-bit DMA isn't a hardware bug, but a hardware
configuration issue. So, latest firmware has enable the DMA support as
high as 40-bit. To support all-memory DMA for all devices (besides the
Loongson platform limit, there are still some devices have their own
DMA32 limit), and also to be compatible with old firmware, we keep use
swiotlb.

I'll make LEFI export the dma_mask_bits, which make it possible to support
both 32-bit and 40-bit DMA in V19.

Of course, the commit message will be rewritten.

>
>> +     else
>> +#endif
>> +     ;
>> +     gfp |= __GFP_NORETRY;
>> +
>> +     ret = swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
>> +     mb();
>> +     return ret;
>> +}
>> +
>> +static void loongson_dma_free_coherent(struct device *dev, size_t size,
>> +             void *vaddr, dma_addr_t dma_handle, struct dma_attrs *attrs)
>> +{
>> +     int order = get_order(size);
>> +
>> +     if (dma_release_from_coherent(dev, order, vaddr))
>> +             return;
>> +
>> +     swiotlb_free_coherent(dev, size, vaddr, dma_handle);
>> +}
>> +
>> +static dma_addr_t loongson_dma_map_page(struct device *dev, struct page *page,
>> +                             unsigned long offset, size_t size,
>> +                             enum dma_data_direction dir,
>> +                             struct dma_attrs *attrs)
>> +{
>> +     dma_addr_t daddr = swiotlb_map_page(dev, page, offset, size,
>> +                                     dir, attrs);
>> +     mb();
>> +     return daddr;
>> +}
>> +
>> +static int loongson_dma_map_sg(struct device *dev, struct scatterlist *sg,
>> +                             int nents, enum dma_data_direction dir,
>> +                             struct dma_attrs *attrs)
>> +{
>> +     int r = swiotlb_map_sg_attrs(dev, sg, nents, dir, NULL);
>> +     mb();
>> +
>> +     return r;
>> +}
>> +
>> +static void loongson_dma_sync_single_for_device(struct device *dev,
>> +                             dma_addr_t dma_handle, size_t size,
>> +                             enum dma_data_direction dir)
>> +{
>> +     swiotlb_sync_single_for_device(dev, dma_handle, size, dir);
>> +     mb();
>> +}
>> +
>> +static void loongson_dma_sync_sg_for_device(struct device *dev,
>> +                             struct scatterlist *sg, int nents,
>> +                             enum dma_data_direction dir)
>> +{
>> +     swiotlb_sync_sg_for_device(dev, sg, nents, dir);
>> +     mb();
>> +}
>> +
>> +static int loongson_dma_set_mask(struct device *dev, u64 mask)
>> +{
>> +     /* Loongson doesn't support DMA above 32-bit */
>> +     if (mask > DMA_BIT_MASK(32)) {
>> +             *dev->dma_mask = DMA_BIT_MASK(32);
>> +             return -EIO;
>> +     }
>> +
>> +     *dev->dma_mask = mask;
>> +
>> +     return 0;
>> +}
>> +
>> +dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
>> +{
>> +     return paddr;
>> +}
>> +
>> +phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
>> +{
>> +     return daddr;
>> +}
>> +
>> +static struct dma_map_ops loongson_dma_map_ops = {
>> +     .alloc = loongson_dma_alloc_coherent,
>> +     .free = loongson_dma_free_coherent,
>> +     .map_page = loongson_dma_map_page,
>> +     .unmap_page = swiotlb_unmap_page,
>> +     .map_sg = loongson_dma_map_sg,
>> +     .unmap_sg = swiotlb_unmap_sg_attrs,
>> +     .sync_single_for_cpu = swiotlb_sync_single_for_cpu,
>> +     .sync_single_for_device = loongson_dma_sync_single_for_device,
>> +     .sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
>> +     .sync_sg_for_device = loongson_dma_sync_sg_for_device,
>> +     .mapping_error = swiotlb_dma_mapping_error,
>> +     .dma_supported = swiotlb_dma_supported,
>> +     .set_dma_mask = loongson_dma_set_mask
>> +};
>> +
>> +void __init plat_swiotlb_setup(void)
>> +{
>> +     swiotlb_init(1);
>> +     mips_dma_map_ops = &loongson_dma_map_ops;
>> +}
>
> Beside the point above, this patch looks fine and also a lot cleaner
> than in V16.
>
> Thanks,
> Aurelien
>
>
> --
> Aurelien Jarno                          GPG: 1024D/F1BCDB73
> aurelien@aurel32.net                 http://www.aurel32.net
>
