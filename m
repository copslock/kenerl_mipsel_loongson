Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jan 2014 23:08:57 +0100 (CET)
Received: from [195.154.112.97] ([195.154.112.97]:40221 "EHLO hall.aurel32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816856AbaAIWIy0RZy0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Jan 2014 23:08:54 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1W1NmV-0008MW-4S; Thu, 09 Jan 2014 23:08:51 +0100
Date:   Thu, 9 Jan 2014 23:08:51 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V16 08/12] MIPS: Loongson: Add swiotlb to support big
 memory (>4GB)
Message-ID: <20140109220850.GA27771@hall.aurel32.net>
References: <1389149068-24376-1-git-send-email-chenhc@lemote.com>
 <1389149068-24376-9-git-send-email-chenhc@lemote.com>
 <20140108225847.GA11039@hall.aurel32.net>
 <CAAhV-H4h43N2OR4znwVv3miVbGkWJLapdgr9Jou1j4R8-9TRyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAAhV-H4h43N2OR4znwVv3miVbGkWJLapdgr9Jou1j4R8-9TRyA@mail.gmail.com>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38926
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

On Thu, Jan 09, 2014 at 06:33:48PM +0800, Huacai Chen wrote:
> On Thu, Jan 9, 2014 at 6:58 AM, Aurelien Jarno <aurelien@aurel32.net> wrote:
> 
> > On Wed, Jan 08, 2014 at 10:44:24AM +0800, Huacai Chen wrote:
> > > This is probably a workaround because Loongson doesn't support DMA
> > > address above 4GB. If memory is more than 4GB, CONFIG_SWIOTLB and
> > > ZONE_DMA32 should be selected. In this way, DMA pages are allocated
> > > below 4GB preferably.
> > >
> > > However, CONFIG_SWIOTLB+ZONE_DMA32 is not enough, so, we provide a
> > > platform-specific dma_map_ops::set_dma_mask() to make sure each
> > > driver's dma_mask and coherent_dma_mask is below 32-bit.
> > >
> > > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > > Signed-off-by: Hongliang Tao <taohl@lemote.com>
> > > Signed-off-by: Hua Yan <yanh@lemote.com>
> > > ---
> > >  arch/mips/include/asm/dma-mapping.h                |    5 +
> > >  .../mips/include/asm/mach-loongson/dma-coherence.h |   22 +++-
> > >  arch/mips/loongson/common/Makefile                 |    5 +
> > >  arch/mips/loongson/common/dma-swiotlb.c            |  165
> > ++++++++++++++++++++
> > >  4 files changed, 196 insertions(+), 1 deletions(-)
> > >  create mode 100644 arch/mips/loongson/common/dma-swiotlb.c
> > >
> > > diff --git a/arch/mips/include/asm/dma-mapping.h
> > b/arch/mips/include/asm/dma-mapping.h
> > > index 84238c5..06412aa 100644
> > > --- a/arch/mips/include/asm/dma-mapping.h
> > > +++ b/arch/mips/include/asm/dma-mapping.h
> > > @@ -49,9 +49,14 @@ static inline int dma_mapping_error(struct device
> > *dev, u64 mask)
> > >  static inline int
> > >  dma_set_mask(struct device *dev, u64 mask)
> > >  {
> > > +     struct dma_map_ops *ops = get_dma_ops(dev);
> > > +
> > >       if(!dev->dma_mask || !dma_supported(dev, mask))
> > >               return -EIO;
> > >
> > > +     if (ops->set_dma_mask)
> > > +             return ops->set_dma_mask(dev, mask);
> > > +
> >
> > I think that with the changes I propose in loongson_dma_alloc_coherent,
> > this should be useless.
> >
> > >       *dev->dma_mask = mask;
> > >
> > >       return 0;
> > > diff --git a/arch/mips/include/asm/mach-loongson/dma-coherence.h
> > b/arch/mips/include/asm/mach-loongson/dma-coherence.h
> > > index aeb2c05..6a90275 100644
> > > --- a/arch/mips/include/asm/mach-loongson/dma-coherence.h
> > > +++ b/arch/mips/include/asm/mach-loongson/dma-coherence.h
> > > @@ -11,24 +11,40 @@
> > >  #ifndef __ASM_MACH_LOONGSON_DMA_COHERENCE_H
> > >  #define __ASM_MACH_LOONGSON_DMA_COHERENCE_H
> > >
> > > +#ifdef CONFIG_SWIOTLB
> > > +#include <linux/swiotlb.h>
> > > +#endif
> > > +
> > >  struct device;
> > >
> > > +extern dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr);
> > > +extern phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr);
> > >  static inline dma_addr_t plat_map_dma_mem(struct device *dev, void
> > *addr,
> > >                                         size_t size)
> > >  {
> > > +#ifdef CONFIG_CPU_LOONGSON3
> > > +     return virt_to_phys(addr);
> > > +#else
> > >       return virt_to_phys(addr) | 0x80000000;
> > > +#endif
> > >  }
> > >
> > >  static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
> > >                                              struct page *page)
> > >  {
> > > +#ifdef CONFIG_CPU_LOONGSON3
> > > +     return page_to_phys(page);
> > > +#else
> > >       return page_to_phys(page) | 0x80000000;
> > > +#endif
> > >  }
> > >
> > >  static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
> > >       dma_addr_t dma_addr)
> > >  {
> > > -#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
> > > +#if defined(CONFIG_CPU_LOONGSON3) && defined(CONFIG_64BIT)
> > > +     return dma_addr;
> > > +#elif defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
> > >       return (dma_addr > 0x8fffffff) ? dma_addr : (dma_addr &
> > 0x0fffffff);
> > >  #else
> > >       return dma_addr & 0x7fffffff;
> > > @@ -55,7 +71,11 @@ static inline int plat_dma_supported(struct device
> > *dev, u64 mask)
> > >
> > >  static inline int plat_device_is_coherent(struct device *dev)
> > >  {
> > > +#ifdef CONFIG_DMA_NONCOHERENT
> > >       return 0;
> > > +#else
> > > +     return 1;
> > > +#endif /* CONFIG_DMA_NONCOHERENT */
> > >  }
> > >
> > >  #endif /* __ASM_MACH_LOONGSON_DMA_COHERENCE_H */
> > > diff --git a/arch/mips/loongson/common/Makefile
> > b/arch/mips/loongson/common/Makefile
> > > index 9e4484c..0bb9cc9 100644
> > > --- a/arch/mips/loongson/common/Makefile
> > > +++ b/arch/mips/loongson/common/Makefile
> > > @@ -26,3 +26,8 @@ obj-$(CONFIG_CS5536) += cs5536/
> > >  #
> > >
> > >  obj-$(CONFIG_LOONGSON_SUSPEND) += pm.o
> > > +
> > > +#
> > > +# Big Memory (SWIOTLB) Support
> > > +#
> > > +obj-$(CONFIG_SWIOTLB) += dma-swiotlb.o
> > > diff --git a/arch/mips/loongson/common/dma-swiotlb.c
> > b/arch/mips/loongson/common/dma-swiotlb.c
> > > new file mode 100644
> > > index 0000000..9d5451b
> > > --- /dev/null
> > > +++ b/arch/mips/loongson/common/dma-swiotlb.c
> > > @@ -0,0 +1,165 @@
> > > +#include <linux/mm.h>
> > > +#include <linux/init.h>
> > > +#include <linux/dma-mapping.h>
> > > +#include <linux/scatterlist.h>
> > > +#include <linux/swiotlb.h>
> > > +#include <linux/bootmem.h>
> > > +
> > > +#include <asm/bootinfo.h>
> > > +#include <dma-coherence.h>
> > > +
> > > +static void *loongson_dma_alloc_coherent(struct device *dev, size_t
> > size,
> > > +             dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
> > > +{
> > > +     void *ret;
> > > +
> > > +     if (dma_alloc_from_coherent(dev, size, dma_handle, &ret))
> > > +             return ret;
> > > +
> > > +     /* ignore region specifiers */
> > > +     gfp &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
> > > +
> > > +#ifdef CONFIG_ISA
> > > +     if (dev == NULL)
> > > +             gfp |= __GFP_DMA;
> > > +     else
> > > +#endif
> > > +#ifdef CONFIG_ZONE_DMA
> > > +     if (dev->coherent_dma_mask < DMA_BIT_MASK(32))
> > > +             gfp |= __GFP_DMA;
> > > +     else
> > > +#endif
> > > +#ifdef CONFIG_ZONE_DMA32
> > > +      /* Loongson-3 only support DMA in the memory below 4GB now */
> > > +     if (dev->coherent_dma_mask < DMA_BIT_MASK(40))
> >
> > You don't want the if here. If the device has coherent_dma_mask with
> > the highest bit being the 32th one or higher, you still need
> > __GFP_DMA32 to make sure the memory will be allocated below 4GB, as
> > the Loongson 3 CPU doesn't support more than 32-bit DMA.
> >
> 32-bit DMA is probably not because of Loongson-3, but because of the
> north-bridge configuration. In our recent experiments, we can enable
> 64-bit DMA by update PMON (but it need more time to prove the stability).
> So we keep the set_dma_mask() for future. Moreover, we need a correct
> dma_mask to check the DMAablity in lib/swiotlb.c.
> 
> DMA_BIT_MASK(40) comes from Radeon GPU, if DMA-40 is enabled, it doesn't
> need to alloc pages in DMA32 zone.

The description of the patch says that a Loongson system only supports
DMA below 4GB. We doesn't care here if the limit comes from the
north-bridge configuration or of the CPU. So if the limit should be 4GB,
__GFP_DMA32 should always be set. If there is no limit, it should be set
if (dev->coherent_dma_mask < DMA_BIT_MASK(64)) as the DMA32 zone is the
biggest zone usable when the address doesn't fit in 64 bit.

In any case it is not really consistent to not limit the addresses to
32 bits here, but limit them later in set_dma_mask().

-- 
Aurelien Jarno	                        GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
