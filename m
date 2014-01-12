Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jan 2014 10:58:36 +0100 (CET)
Received: from [195.154.112.97] ([195.154.112.97]:57624 "EHLO hall.aurel32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827346AbaALJ6Q6A9cR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 12 Jan 2014 10:58:16 +0100
Received: from pc-198-95-101-190.cm.vtr.net ([190.101.95.198] helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1W2Ho6-0003RN-8v; Sun, 12 Jan 2014 10:58:15 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1W2Hnq-0001Kk-3X; Sun, 12 Jan 2014 10:57:58 +0100
Date:   Sun, 12 Jan 2014 10:57:58 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Alex Smith <alex.smith@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V16 08/12] MIPS: Loongson: Add swiotlb to support big
 memory (>4GB)
Message-ID: <20140112095758.GA5054@ohm.rr44.fr>
References: <1389149068-24376-1-git-send-email-chenhc@lemote.com>
 <1389149068-24376-9-git-send-email-chenhc@lemote.com>
 <52CE9C92.9080400@imgtec.com>
 <CAAhV-H7ZO0gNzQ5wQ-yD=NiP2AJrc3-bWLXHo-HDngf27c9+gQ@mail.gmail.com>
 <20140111152523.GD5925@ohm.rr44.fr>
 <CAAhV-H5Jy48vhZALc=frkAYGS6W7SUQ_6-FsXBBS1mfhpv75GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAAhV-H5Jy48vhZALc=frkAYGS6W7SUQ_6-FsXBBS1mfhpv75GQ@mail.gmail.com>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38943
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

On Sun, Jan 12, 2014 at 05:12:46PM +0800, Huacai Chen wrote:
> On Sat, Jan 11, 2014 at 11:25 PM, Aurelien Jarno <aurelien@aurel32.net> wrote:
> > On Sat, Jan 11, 2014 at 08:50:25PM +0800, Huacai Chen wrote:
> >> On Thu, Jan 9, 2014 at 8:56 PM, Alex Smith <alex.smith@imgtec.com> wrote:
> >>
> >> > On 08/01/14 02:44, Huacai Chen wrote:
> >> >
> >> >> This is probably a workaround because Loongson doesn't support DMA
> >> >> address above 4GB. If memory is more than 4GB, CONFIG_SWIOTLB and
> >> >> ZONE_DMA32 should be selected. In this way, DMA pages are allocated
> >> >> below 4GB preferably.
> >> >>
> >> >> However, CONFIG_SWIOTLB+ZONE_DMA32 is not enough, so, we provide a
> >> >> platform-specific dma_map_ops::set_dma_mask() to make sure each
> >> >> driver's dma_mask and coherent_dma_mask is below 32-bit.
> >> >>
> >> >> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> >> >> Signed-off-by: Hongliang Tao <taohl@lemote.com>
> >> >> Signed-off-by: Hua Yan <yanh@lemote.com>
> >> >> ---
> >> >>   arch/mips/include/asm/dma-mapping.h                |    5 +
> >> >>   .../mips/include/asm/mach-loongson/dma-coherence.h |   22 +++-
> >> >>   arch/mips/loongson/common/Makefile                 |    5 +
> >> >>   arch/mips/loongson/common/dma-swiotlb.c            |  165
> >> >> ++++++++++++++++++++
> >> >>   4 files changed, 196 insertions(+), 1 deletions(-)
> >> >>   create mode 100644 arch/mips/loongson/common/dma-swiotlb.c
> >> >>
> >> >> diff --git a/arch/mips/include/asm/dma-mapping.h
> >> >> b/arch/mips/include/asm/dma-mapping.h
> >> >> index 84238c5..06412aa 100644
> >> >> --- a/arch/mips/include/asm/dma-mapping.h
> >> >> +++ b/arch/mips/include/asm/dma-mapping.h
> >> >> @@ -49,9 +49,14 @@ static inline int dma_mapping_error(struct device
> >> >> *dev, u64 mask)
> >> >>   static inline int
> >> >>   dma_set_mask(struct device *dev, u64 mask)
> >> >>   {
> >> >> +       struct dma_map_ops *ops = get_dma_ops(dev);
> >> >> +
> >> >>         if(!dev->dma_mask || !dma_supported(dev, mask))
> >> >>                 return -EIO;
> >> >>
> >> >> +       if (ops->set_dma_mask)
> >> >> +               return ops->set_dma_mask(dev, mask);
> >> >> +
> >> >>         *dev->dma_mask = mask;
> >> >>
> >> >>         return 0;
> >> >> diff --git a/arch/mips/include/asm/mach-loongson/dma-coherence.h
> >> >> b/arch/mips/include/asm/mach-loongson/dma-coherence.h
> >> >> index aeb2c05..6a90275 100644
> >> >> --- a/arch/mips/include/asm/mach-loongson/dma-coherence.h
> >> >> +++ b/arch/mips/include/asm/mach-loongson/dma-coherence.h
> >> >> @@ -11,24 +11,40 @@
> >> >>   #ifndef __ASM_MACH_LOONGSON_DMA_COHERENCE_H
> >> >>   #define __ASM_MACH_LOONGSON_DMA_COHERENCE_H
> >> >>
> >> >> +#ifdef CONFIG_SWIOTLB
> >> >> +#include <linux/swiotlb.h>
> >> >> +#endif
> >> >> +
> >> >>   struct device;
> >> >>
> >> >> +extern dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr);
> >> >> +extern phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr);
> >> >>   static inline dma_addr_t plat_map_dma_mem(struct device *dev, void
> >> >> *addr,
> >> >>                                           size_t size)
> >> >>   {
> >> >> +#ifdef CONFIG_CPU_LOONGSON3
> >> >> +       return virt_to_phys(addr);
> >> >> +#else
> >> >>         return virt_to_phys(addr) | 0x80000000;
> >> >> +#endif
> >> >>   }
> >> >>
> >> >>   static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
> >> >>                                                struct page *page)
> >> >>   {
> >> >> +#ifdef CONFIG_CPU_LOONGSON3
> >> >> +       return page_to_phys(page);
> >> >> +#else
> >> >>         return page_to_phys(page) | 0x80000000;
> >> >> +#endif
> >> >>   }
> >> >>
> >> >>   static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
> >> >>         dma_addr_t dma_addr)
> >> >>   {
> >> >> -#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
> >> >> +#if defined(CONFIG_CPU_LOONGSON3) && defined(CONFIG_64BIT)
> >> >> +       return dma_addr;
> >> >> +#elif defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
> >> >>         return (dma_addr > 0x8fffffff) ? dma_addr : (dma_addr &
> >> >> 0x0fffffff);
> >> >>   #else
> >> >>         return dma_addr & 0x7fffffff;
> >> >> @@ -55,7 +71,11 @@ static inline int plat_dma_supported(struct device
> >> >> *dev, u64 mask)
> >> >>
> >> >>   static inline int plat_device_is_coherent(struct device *dev)
> >> >>   {
> >> >> +#ifdef CONFIG_DMA_NONCOHERENT
> >> >>         return 0;
> >> >> +#else
> >> >> +       return 1;
> >> >> +#endif /* CONFIG_DMA_NONCOHERENT */
> >> >>   }
> >> >>
> >> >>   #endif /* __ASM_MACH_LOONGSON_DMA_COHERENCE_H */
> >> >> diff --git a/arch/mips/loongson/common/Makefile
> >> >> b/arch/mips/loongson/common/Makefile
> >> >> index 9e4484c..0bb9cc9 100644
> >> >> --- a/arch/mips/loongson/common/Makefile
> >> >> +++ b/arch/mips/loongson/common/Makefile
> >> >> @@ -26,3 +26,8 @@ obj-$(CONFIG_CS5536) += cs5536/
> >> >>   #
> >> >>
> >> >>   obj-$(CONFIG_LOONGSON_SUSPEND) += pm.o
> >> >> +
> >> >> +#
> >> >> +# Big Memory (SWIOTLB) Support
> >> >> +#
> >> >> +obj-$(CONFIG_SWIOTLB) += dma-swiotlb.o
> >> >> diff --git a/arch/mips/loongson/common/dma-swiotlb.c
> >> >> b/arch/mips/loongson/common/dma-swiotlb.c
> >> >> new file mode 100644
> >> >> index 0000000..9d5451b
> >> >> --- /dev/null
> >> >> +++ b/arch/mips/loongson/common/dma-swiotlb.c
> >> >> @@ -0,0 +1,165 @@
> >> >> +#include <linux/mm.h>
> >> >> +#include <linux/init.h>
> >> >> +#include <linux/dma-mapping.h>
> >> >> +#include <linux/scatterlist.h>
> >> >> +#include <linux/swiotlb.h>
> >> >> +#include <linux/bootmem.h>
> >> >> +
> >> >> +#include <asm/bootinfo.h>
> >> >> +#include <dma-coherence.h>
> >> >> +
> >> >> +static void *loongson_dma_alloc_coherent(struct device *dev, size_t
> >> >> size,
> >> >> +               dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs
> >> >> *attrs)
> >> >> +{
> >> >> +       void *ret;
> >> >> +
> >> >> +       if (dma_alloc_from_coherent(dev, size, dma_handle, &ret))
> >> >> +               return ret;
> >> >> +
> >> >> +       /* ignore region specifiers */
> >> >> +       gfp &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
> >> >> +
> >> >> +#ifdef CONFIG_ISA
> >> >> +       if (dev == NULL)
> >> >> +               gfp |= __GFP_DMA;
> >> >> +       else
> >> >> +#endif
> >> >> +#ifdef CONFIG_ZONE_DMA
> >> >> +       if (dev->coherent_dma_mask < DMA_BIT_MASK(32))
> >> >> +               gfp |= __GFP_DMA;
> >> >> +       else
> >> >> +#endif
> >> >> +#ifdef CONFIG_ZONE_DMA32
> >> >> +        /* Loongson-3 only support DMA in the memory below 4GB now */
> >> >> +       if (dev->coherent_dma_mask < DMA_BIT_MASK(40))
> >> >> +               gfp |= __GFP_DMA32;
> >> >> +       else
> >> >> +#endif
> >> >> +       ;
> >> >> +       gfp |= __GFP_NORETRY;
> >> >> +
> >> >> +       ret = swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
> >> >> +       mb();
> >> >> +       return ret;
> >> >> +}
> >> >> +
> >> >> +static void loongson_dma_free_coherent(struct device *dev, size_t size,
> >> >> +               void *vaddr, dma_addr_t dma_handle, struct dma_attrs
> >> >> *attrs)
> >> >> +{
> >> >> +       int order = get_order(size);
> >> >> +
> >> >> +       if (dma_release_from_coherent(dev, order, vaddr))
> >> >> +               return;
> >> >> +
> >> >> +       swiotlb_free_coherent(dev, size, vaddr, dma_handle);
> >> >> +}
> >> >> +
> >> >> +static dma_addr_t loongson_dma_map_page(struct device *dev, struct page
> >> >> *page,
> >> >> +                               unsigned long offset, size_t size,
> >> >> +                               enum dma_data_direction dir,
> >> >> +                               struct dma_attrs *attrs)
> >> >> +{
> >> >> +       dma_addr_t daddr = swiotlb_map_page(dev, page, offset, size,
> >> >> +                                       dir, attrs);
> >> >> +       mb();
> >> >> +       return daddr;
> >> >> +}
> >> >> +
> >> >> +static int loongson_dma_map_sg(struct device *dev, struct scatterlist
> >> >> *sg,
> >> >> +                               int nents, enum dma_data_direction dir,
> >> >> +                               struct dma_attrs *attrs)
> >> >> +{
> >> >> +       int r = swiotlb_map_sg_attrs(dev, sg, nents, dir, NULL);
> >> >> +       mb();
> >> >> +
> >> >> +       return r;
> >> >> +}
> >> >> +
> >> >> +static void loongson_dma_sync_single_for_device(struct device *dev,
> >> >> +                               dma_addr_t dma_handle, size_t size,
> >> >> +                               enum dma_data_direction dir)
> >> >> +{
> >> >> +       swiotlb_sync_single_for_device(dev, dma_handle, size, dir);
> >> >> +       mb();
> >> >> +}
> >> >> +
> >> >> +static void loongson_dma_sync_sg_for_device(struct device *dev,
> >> >> +                               struct scatterlist *sg, int nents,
> >> >> +                               enum dma_data_direction dir)
> >> >> +{
> >> >> +       swiotlb_sync_sg_for_device(dev, sg, nents, dir);
> >> >> +       mb();
> >> >> +}
> >> >> +
> >> >> +static dma_addr_t
> >> >> +loongson_unity_phys_to_dma(struct device *dev, phys_addr_t paddr)
> >> >> +{
> >> >> +       return paddr;
> >> >> +}
> >> >> +
> >> >> +static phys_addr_t
> >> >> +loongson_unity_dma_to_phys(struct device *dev, dma_addr_t daddr)
> >> >> +{
> >> >> +       return daddr;
> >> >> +}
> >> >> +
> >> >> +struct loongson_dma_map_ops {
> >> >> +       struct dma_map_ops dma_map_ops;
> >> >> +       dma_addr_t (*phys_to_dma)(struct device *dev, phys_addr_t paddr);
> >> >> +       phys_addr_t (*dma_to_phys)(struct device *dev, dma_addr_t daddr);
> >> >> +};
> >> >> +
> >> >> +dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
> >> >> +{
> >> >> +       struct loongson_dma_map_ops *ops = container_of(get_dma_ops(dev),
> >> >> +                               struct loongson_dma_map_ops, dma_map_ops);
> >> >> +
> >> >> +       return ops->phys_to_dma(dev, paddr);
> >> >> +}
> >> >> +
> >> >> +phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
> >> >> +{
> >> >> +       struct loongson_dma_map_ops *ops = container_of(get_dma_ops(dev),
> >> >> +                               struct loongson_dma_map_ops, dma_map_ops);
> >> >> +
> >> >> +       return ops->dma_to_phys(dev, daddr);
> >> >> +}
> >> >>
> >> >
> >> > This seems a little bit convoluted. Since phys_to_dma and dma_to_phys will
> >> > always end up calling the loongson_unity_ functions, I don't see any point
> >> > in having the loongson_dma_map_ops structure to point to them. You can just
> >> > implement phys_to_dma and dma_to_phys as inlines in
> >> > mach-loongson/dma-coherence.h.
> >> >
> >> This part comes from arch/mips/cavium-octeon/dma-octeon.c, I think this is
> >> needed in future.
> >
> > On Cavium Octeon you have different mappings depending on the CPU, but
> > this is not the case on Loongson 3A. So I think that Alex is right and
> > that it can be simplified.
> Loongson-3 can work with other northbridge (LS2H) other than RS780 and
> there are already products.
> Loongson-3 with LS2H has different mappings than RS780 (but of course
> the current patchset doesn't
> support LS2H). Can I keep the code as is? Or I must take Alex's
> suggestion and modify here until the
> LS2H patchset?

I think it's better to use simple code as Alex suggested, and to change
it later in the LS2H patchset.

Aurelien

-- 
Aurelien Jarno                          GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
