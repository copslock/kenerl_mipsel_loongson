Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Aug 2012 04:18:23 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:43041 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901161Ab2HOCSP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Aug 2012 04:18:15 +0200
Received: by lbbgf7 with SMTP id gf7so575706lbb.36
        for <multiple recipients>; Tue, 14 Aug 2012 19:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LoOxzBOjJlfpaXThxF2iB3CWqDT+eUTuINyaJdEtww8=;
        b=OQH4hf5RDq176d85uPXBveWJGx+lyk9nT2Op1fSyLmiyG4J4IVR9hJPkznHOZXagrC
         ms7xxpzl1jYdg+mJQthPWELxLENbdS5MlxS+qlSsdxEnjkXDfNppqPEiMn7QqE2Hxxvn
         eOhFRY8Qu1OUFMEyxrLdcQty7MhVNILg3CM3HE7/9kWnx6jqPXSMhblAgpoOWWBS0I1G
         7Tx90PLN3jjELrtA95ubNZ/mIjZPIhizlz4k+zeE7GSo+jasC32piZLQfVc1apVi/c58
         Ee+fJztPECieRGW9BQB5EFqt/PpzwMun9aOK/PFCVhXQy4KvDaOSEOFIaN4PV1wyGrVD
         Jngw==
MIME-Version: 1.0
Received: by 10.152.125.133 with SMTP id mq5mr6783388lab.12.1344997089480;
 Tue, 14 Aug 2012 19:18:09 -0700 (PDT)
Received: by 10.152.111.138 with HTTP; Tue, 14 Aug 2012 19:18:09 -0700 (PDT)
In-Reply-To: <20120813175447.GB26088@phenom.dumpdata.com>
References: <1344677543-22591-1-git-send-email-chenhc@lemote.com>
        <1344677543-22591-10-git-send-email-chenhc@lemote.com>
        <20120813175447.GB26088@phenom.dumpdata.com>
Date:   Wed, 15 Aug 2012 10:18:09 +0800
Message-ID: <CAAhV-H5_p8Rs-Wnq_fVrP0Fq-ekdQHQXxfYw8PPX-Bz4TF1Mhw@mail.gmail.com>
Subject: Re: [PATCH V5 09/18] MIPS: Loongson: Add swiotlb to support big
 memory (>4GB).
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34172
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
This can really happen, "grep dma_alloc_coherent drivers/ -rwI | grep
NULL" will get lots of information.

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
mb() is needed because of cache coherency (CPU write some data, then
map the page for a device, if without mb(), then device may read wrong
data.)

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
phys_to_dma() and dma_to_phys() are called in lib/swiotlb.c

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
