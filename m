Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 07:57:31 +0200 (CEST)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:47115 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903424Ab2HNF5X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Aug 2012 07:57:23 +0200
Received: by lagu2 with SMTP id u2so8084lag.36
        for <multiple recipients>; Mon, 13 Aug 2012 22:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CSZhjcwVCJmRzLHsl9037NCjh7uzFhhoycXzM3rfY40=;
        b=gcXFoKxZMyv0FzqOjaJlMLzBttEOV70DFPmmNUpYED29Vju0Bm7wWj2y+5j/rulzst
         16akr6+2cL+u/oY8RZbYFBJQsuZxVh9vCZ7mtRkLuW76bS6wXQmkQ2tdFL+x+1HWz8GA
         RiHg/YzMEL9ODHlJoj7hqsFeDdDmzXz+3tlGFT0JscZphNDNWMLBogR9HtMYGT7hwi95
         hahYoylVJwxdtX5Ye7fNkCSg4aAM+zpS3Xe3MhMiEJAdX/oXD52kxiXzJabhyut4mKV1
         r6GtKPl2/80IgghrHnCByRX+Vl5fvZHDzlZDVojRVQ+sXXxhROJeAT2R41yU+jnpoRSP
         wkKA==
MIME-Version: 1.0
Received: by 10.152.110.46 with SMTP id hx14mr1959503lab.21.1344923837870;
 Mon, 13 Aug 2012 22:57:17 -0700 (PDT)
Received: by 10.152.111.138 with HTTP; Mon, 13 Aug 2012 22:57:17 -0700 (PDT)
In-Reply-To: <20120813175447.GB26088@phenom.dumpdata.com>
References: <1344677543-22591-1-git-send-email-chenhc@lemote.com>
        <1344677543-22591-10-git-send-email-chenhc@lemote.com>
        <20120813175447.GB26088@phenom.dumpdata.com>
Date:   Tue, 14 Aug 2012 13:57:17 +0800
Message-ID: <CAAhV-H7mJUC9njF_wHda8ymUBkUom5AZ+u8OFXtA42uyA-hFxg@mail.gmail.com>
Subject: Re: [PATCH V5 09/18] MIPS: Loongson: Add swiotlb to support big
 memory (>4GB).
From:   Huacai Chen <chenhuacai@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

Hi, David,

Seems like you are the original author of code in
arch/mips/cavium-octeon/dma-octeon.c. Could you please tell me why we
need mb() in alloc_coherent(), map_page(), map_sg()? It seems like
because of cache coherency (CPU write some data, then map the page for
a device, if without mb(), then device may read wrong data.) but I'm
not sure.

On Tue, Aug 14, 2012 at 1:54 AM, Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>> +static void *loongson_dma_alloc_coherent(struct device *dev, size_t size,
>> +                             dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
>> +{
>> +     void *ret;
>> +
>> +     if (dma_alloc_from_coherent(dev, size, dma_handle, &ret))
>> +             return ret;
>> +
>> +     /* ignore region specifiers */
>> +     gfp &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
>> +
>> +#ifdef CONFIG_ZONE_DMA
>> +     if (dev == NULL)
>> +             gfp |= __GFP_DMA;
>
> When would this happen? dev == NULL?
>
>> +     else if (dev->coherent_dma_mask <= DMA_BIT_MASK(24))
>> +             gfp |= __GFP_DMA;
>> +     else
>> +#endif
>> +#ifdef CONFIG_ZONE_DMA32
>> +     if (dev->coherent_dma_mask <= DMA_BIT_MASK(32))
>> +             gfp |= __GFP_DMA32;
>> +     else
>
> Why the 'else'
>> +#endif
>> +     ;
>
> why?
>> +     gfp |= __GFP_NORETRY;
>> +
>> +     ret = swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
>> +     mb();
>
> Why the 'mb()' ? Can you just do
>         return swiotlb_alloc_coherent(...)
>
>> +     return ret;
>> +}
>> +
>> +static void loongson_dma_free_coherent(struct device *dev, size_t size,
>> +                             void *vaddr, dma_addr_t dma_handle, struct dma_attrs *attrs)
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
>
> Please do 'return swiotlb_map_page(..)'..
>
> But if you are doing that why don't you just set the dma_ops.map_page = swiotlb_map_page
> ?
>
>
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
>
> I am not really sure why you have these extra functions, when you could
> just modify the dma_ops to point to the swiotlb ones
>
>> +static dma_addr_t loongson_unity_phys_to_dma(struct device *dev, phys_addr_t paddr)
>> +{
>> +     return (paddr < 0x10000000) ?
>> +                     (paddr | 0x0000000080000000) : paddr;
>> +}
>> +
>> +static phys_addr_t loongson_unity_dma_to_phys(struct device *dev, dma_addr_t daddr)
>> +{
>> +     return (daddr < 0x90000000 && daddr >= 0x80000000) ?
>> +                     (daddr & 0x0fffffff) : daddr;
>> +}
>> +
>> +struct loongson_dma_map_ops {
>> +     struct dma_map_ops dma_map_ops;
>> +     dma_addr_t (*phys_to_dma)(struct device *dev, phys_addr_t paddr);
>> +     phys_addr_t (*dma_to_phys)(struct device *dev, dma_addr_t daddr);
>> +};
>> +
>> +dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
>> +{
>> +     struct loongson_dma_map_ops *ops = container_of(get_dma_ops(dev),
>> +                                     struct loongson_dma_map_ops, dma_map_ops);
>> +
>> +     return ops->phys_to_dma(dev, paddr);
>> +}
>> +
>> +phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
>> +{
>> +     struct loongson_dma_map_ops *ops = container_of(get_dma_ops(dev),
>> +                                     struct loongson_dma_map_ops, dma_map_ops);
>> +
>> +     return ops->dma_to_phys(dev, daddr);
>> +}
>> +
>> +static int loongson_dma_set_mask(struct device *dev, u64 mask)
>> +{
>> +     /* Loongson doesn't support DMA above 32-bit */
>> +     if (mask > DMA_BIT_MASK(32))
>> +             return -EIO;
>> +
>> +     *dev->dma_mask = mask;
>> +
>> +     return 0;
>> +}
>> +
>> +static struct loongson_dma_map_ops loongson_linear_dma_map_ops = {
>> +     .dma_map_ops = {
>> +             .alloc = loongson_dma_alloc_coherent,
>> +             .free = loongson_dma_free_coherent,
>> +             .map_page = loongson_dma_map_page,
>
> But why not 'swiotlb_map_page'?
>
>> +             .unmap_page = swiotlb_unmap_page,
>> +             .map_sg = loongson_dma_map_sg,
>> +             .unmap_sg = swiotlb_unmap_sg_attrs,
>> +             .sync_single_for_cpu = swiotlb_sync_single_for_cpu,
>> +             .sync_single_for_device = loongson_dma_sync_single_for_device,
>> +             .sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
>> +             .sync_sg_for_device = loongson_dma_sync_sg_for_device,
>> +             .mapping_error = swiotlb_dma_mapping_error,
>> +             .dma_supported = swiotlb_dma_supported,
>> +             .set_dma_mask = loongson_dma_set_mask
>> +     },
>> +     .phys_to_dma = loongson_unity_phys_to_dma,
>> +     .dma_to_phys = loongson_unity_dma_to_phys
>
> Why do you need these? I am not seeing it being used here by any external code?
>
>> +};
>> +
>> +void __init plat_swiotlb_setup(void)
>> +{
>> +     swiotlb_init(1);
>> +     mips_dma_map_ops = &loongson_linear_dma_map_ops.dma_map_ops;
>> +}
>> diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
>> index 3fab204..122f4f8 100644
>> --- a/arch/mips/mm/dma-default.c
>> +++ b/arch/mips/mm/dma-default.c
>> @@ -42,6 +42,13 @@ static inline int cpu_is_noncoherent_r10000(struct device *dev)
>>              current_cpu_type() == CPU_R12000);
>>  }
>>
>> +static inline int cpu_is_noncoherent_loongson(struct device *dev)
>> +{
>> +     return !plat_device_is_coherent(dev) &&
>> +                     (current_cpu_type() == CPU_LOONGSON2 ||
>> +                      current_cpu_type() == CPU_LOONGSON3);
>> +}
>> +
>>  static gfp_t massage_gfp_flags(const struct device *dev, gfp_t gfp)
>>  {
>>       gfp_t dma_flag;
>> @@ -209,7 +216,7 @@ static inline void __dma_sync(struct page *page,
>>  static void mips_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
>>       size_t size, enum dma_data_direction direction, struct dma_attrs *attrs)
>>  {
>> -     if (cpu_is_noncoherent_r10000(dev))
>> +     if (cpu_is_noncoherent_r10000(dev) || cpu_is_noncoherent_loongson(dev))
>>               __dma_sync(dma_addr_to_page(dev, dma_addr),
>>                          dma_addr & ~PAGE_MASK, size, direction);
>>
>> @@ -260,7 +267,7 @@ static void mips_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>>  static void mips_dma_sync_single_for_cpu(struct device *dev,
>>       dma_addr_t dma_handle, size_t size, enum dma_data_direction direction)
>>  {
>> -     if (cpu_is_noncoherent_r10000(dev))
>> +     if (cpu_is_noncoherent_r10000(dev) || cpu_is_noncoherent_loongson(dev))
>>               __dma_sync(dma_addr_to_page(dev, dma_handle),
>>                          dma_handle & ~PAGE_MASK, size, direction);
>>  }
>> @@ -281,7 +288,7 @@ static void mips_dma_sync_sg_for_cpu(struct device *dev,
>>
>>       /* Make sure that gcc doesn't leave the empty loop body.  */
>>       for (i = 0; i < nelems; i++, sg++) {
>> -             if (cpu_is_noncoherent_r10000(dev))
>> +             if (cpu_is_noncoherent_r10000(dev) || cpu_is_noncoherent_loongson(dev))
>>                       __dma_sync(sg_page(sg), sg->offset, sg->length,
>>                                  direction);
>>       }
>> --
>> 1.7.7.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
