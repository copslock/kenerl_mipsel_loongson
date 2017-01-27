Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jan 2017 17:21:04 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:51549 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992078AbdA0QU4YyaQE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Jan 2017 17:20:56 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 011B0AAA3;
        Fri, 27 Jan 2017 16:20:56 +0000 (UTC)
Date:   Fri, 27 Jan 2017 17:20:54 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Alexander Graf <agraf@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
Subject: Re: [PATCH 3/3] mm: wire up GFP flag passing in
 dma_alloc_from_contiguous
Message-ID: <20170127162053.GC6357@dhcp22.suse.cz>
References: <20170119170707.31741-1-l.stach@pengutronix.de>
 <20170119170707.31741-3-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170119170707.31741-3-l.stach@pengutronix.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <mhocko@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mhocko@kernel.org
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

On Thu 19-01-17 18:07:07, Lucas Stach wrote:
> The callers of the DMA alloc functions already provide the proper
> context GFP flags. Make sure to pass them through to the CMA
> allocator, to make the CMA compaction context aware.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Looks good to me
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/arm/mm/dma-mapping.c      | 16 +++++++++-------
>  arch/arm64/mm/dma-mapping.c    |  4 ++--
>  arch/mips/mm/dma-default.c     |  4 ++--
>  arch/x86/kernel/pci-dma.c      |  3 ++-
>  arch/xtensa/kernel/pci-dma.c   |  3 ++-
>  drivers/base/dma-contiguous.c  |  5 +++--
>  drivers/iommu/amd_iommu.c      |  2 +-
>  drivers/iommu/intel-iommu.c    |  2 +-
>  include/linux/dma-contiguous.h |  4 ++--
>  9 files changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index ab7710002ba6..4d6ec7d821c8 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -349,7 +349,7 @@ static void __dma_free_buffer(struct page *page, size_t size)
>  static void *__alloc_from_contiguous(struct device *dev, size_t size,
>  				     pgprot_t prot, struct page **ret_page,
>  				     const void *caller, bool want_vaddr,
> -				     int coherent_flag);
> +				     int coherent_flag, gfp_t gfp);
>  
>  static void *__alloc_remap_buffer(struct device *dev, size_t size, gfp_t gfp,
>  				 pgprot_t prot, struct page **ret_page,
> @@ -420,7 +420,8 @@ static int __init atomic_pool_init(void)
>  	 */
>  	if (dev_get_cma_area(NULL))
>  		ptr = __alloc_from_contiguous(NULL, atomic_pool_size, prot,
> -				      &page, atomic_pool_init, true, NORMAL);
> +				      &page, atomic_pool_init, true, NORMAL,
> +				      GFP_KERNEL);
>  	else
>  		ptr = __alloc_remap_buffer(NULL, atomic_pool_size, gfp, prot,
>  					   &page, atomic_pool_init, true);
> @@ -594,14 +595,14 @@ static int __free_from_pool(void *start, size_t size)
>  static void *__alloc_from_contiguous(struct device *dev, size_t size,
>  				     pgprot_t prot, struct page **ret_page,
>  				     const void *caller, bool want_vaddr,
> -				     int coherent_flag)
> +				     int coherent_flag, gfp_t gfp)
>  {
>  	unsigned long order = get_order(size);
>  	size_t count = size >> PAGE_SHIFT;
>  	struct page *page;
>  	void *ptr = NULL;
>  
> -	page = dma_alloc_from_contiguous(dev, count, order);
> +	page = dma_alloc_from_contiguous(dev, count, order, gfp);
>  	if (!page)
>  		return NULL;
>  
> @@ -655,7 +656,7 @@ static inline pgprot_t __get_dma_pgprot(unsigned long attrs, pgprot_t prot)
>  #define __get_dma_pgprot(attrs, prot)				__pgprot(0)
>  #define __alloc_remap_buffer(dev, size, gfp, prot, ret, c, wv)	NULL
>  #define __alloc_from_pool(size, ret_page)			NULL
> -#define __alloc_from_contiguous(dev, size, prot, ret, c, wv, coherent_flag)	NULL
> +#define __alloc_from_contiguous(dev, size, prot, ret, c, wv, coherent_flag, gfp)	NULL
>  #define __free_from_pool(cpu_addr, size)			do { } while (0)
>  #define __free_from_contiguous(dev, page, cpu_addr, size, wv)	do { } while (0)
>  #define __dma_free_remap(cpu_addr, size)			do { } while (0)
> @@ -697,7 +698,8 @@ static void *cma_allocator_alloc(struct arm_dma_alloc_args *args,
>  {
>  	return __alloc_from_contiguous(args->dev, args->size, args->prot,
>  				       ret_page, args->caller,
> -				       args->want_vaddr, args->coherent_flag);
> +				       args->want_vaddr, args->coherent_flag,
> +				       args->gfp);
>  }
>  
>  static void cma_allocator_free(struct arm_dma_free_args *args)
> @@ -1293,7 +1295,7 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
>  		unsigned long order = get_order(size);
>  		struct page *page;
>  
> -		page = dma_alloc_from_contiguous(dev, count, order);
> +		page = dma_alloc_from_contiguous(dev, count, order, gfp);
>  		if (!page)
>  			goto error;
>  
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index e04082700bb1..b998f56e6a53 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -107,7 +107,7 @@ static void *__dma_alloc_coherent(struct device *dev, size_t size,
>  		void *addr;
>  
>  		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
> -							get_order(size));
> +						 get_order(size), flags);
>  		if (!page)
>  			return NULL;
>  
> @@ -379,7 +379,7 @@ static int __init atomic_pool_init(void)
>  
>  	if (dev_get_cma_area(NULL))
>  		page = dma_alloc_from_contiguous(NULL, nr_pages,
> -							pool_size_order);
> +						 pool_size_order, GFP_KERNEL);
>  	else
>  		page = alloc_pages(GFP_DMA, pool_size_order);
>  
> diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
> index a39c36af97ad..1895a692efd4 100644
> --- a/arch/mips/mm/dma-default.c
> +++ b/arch/mips/mm/dma-default.c
> @@ -148,8 +148,8 @@ static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
>  	gfp = massage_gfp_flags(dev, gfp);
>  
>  	if (IS_ENABLED(CONFIG_DMA_CMA) && gfpflags_allow_blocking(gfp))
> -		page = dma_alloc_from_contiguous(dev,
> -					count, get_order(size));
> +		page = dma_alloc_from_contiguous(dev, count, get_order(size),
> +						 gfp);
>  	if (!page)
>  		page = alloc_pages(gfp, get_order(size));
>  
> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> index d30c37750765..d5c223c9cf11 100644
> --- a/arch/x86/kernel/pci-dma.c
> +++ b/arch/x86/kernel/pci-dma.c
> @@ -91,7 +91,8 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,
>  	page = NULL;
>  	/* CMA can be used only in the context which permits sleeping */
>  	if (gfpflags_allow_blocking(flag)) {
> -		page = dma_alloc_from_contiguous(dev, count, get_order(size));
> +		page = dma_alloc_from_contiguous(dev, count, get_order(size),
> +						 flag);
>  		if (page && page_to_phys(page) + size > dma_mask) {
>  			dma_release_from_contiguous(dev, page, count);
>  			page = NULL;
> diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
> index 70e362e6038e..34c1f9fa6acc 100644
> --- a/arch/xtensa/kernel/pci-dma.c
> +++ b/arch/xtensa/kernel/pci-dma.c
> @@ -158,7 +158,8 @@ static void *xtensa_dma_alloc(struct device *dev, size_t size,
>  		flag |= GFP_DMA;
>  
>  	if (gfpflags_allow_blocking(flag))
> -		page = dma_alloc_from_contiguous(dev, count, get_order(size));
> +		page = dma_alloc_from_contiguous(dev, count, get_order(size),
> +						 flag);
>  
>  	if (!page)
>  		page = alloc_pages(flag, get_order(size));
> diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> index d1a9cbabc627..b55804cac4c4 100644
> --- a/drivers/base/dma-contiguous.c
> +++ b/drivers/base/dma-contiguous.c
> @@ -181,6 +181,7 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
>   * @dev:   Pointer to device for which the allocation is performed.
>   * @count: Requested number of pages.
>   * @align: Requested alignment of pages (in PAGE_SIZE order).
> + * @gfp_mask: GFP flags to use for this allocation.
>   *
>   * This function allocates memory buffer for specified device. It uses
>   * device specific contiguous memory area if available or the default
> @@ -188,12 +189,12 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
>   * function.
>   */
>  struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
> -				       unsigned int align)
> +				       unsigned int align, gfp_t gfp_mask)
>  {
>  	if (align > CONFIG_CMA_ALIGNMENT)
>  		align = CONFIG_CMA_ALIGNMENT;
>  
> -	return cma_alloc(dev_get_cma_area(dev), count, align, GFP_KERNEL);
> +	return cma_alloc(dev_get_cma_area(dev), count, align, gfp_mask);
>  }
>  
>  /**
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 3ef0f42984f2..bd2e335cdf39 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -2668,7 +2668,7 @@ static void *alloc_coherent(struct device *dev, size_t size,
>  			return NULL;
>  
>  		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
> -						 get_order(size));
> +						 get_order(size), flag);
>  		if (!page)
>  			return NULL;
>  	}
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 8a185250ae5a..3f804eb4299a 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3827,7 +3827,7 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
>  	if (gfpflags_allow_blocking(flags)) {
>  		unsigned int count = size >> PAGE_SHIFT;
>  
> -		page = dma_alloc_from_contiguous(dev, count, order);
> +		page = dma_alloc_from_contiguous(dev, count, order, flags);
>  		if (page && iommu_no_mapping(dev) &&
>  		    page_to_phys(page) + size > dev->coherent_dma_mask) {
>  			dma_release_from_contiguous(dev, page, count);
> diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
> index fec734df1524..b67bf6ac907d 100644
> --- a/include/linux/dma-contiguous.h
> +++ b/include/linux/dma-contiguous.h
> @@ -112,7 +112,7 @@ static inline int dma_declare_contiguous(struct device *dev, phys_addr_t size,
>  }
>  
>  struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
> -				       unsigned int order);
> +				       unsigned int order, gfp_t gfp_mask);
>  bool dma_release_from_contiguous(struct device *dev, struct page *pages,
>  				 int count);
>  
> @@ -145,7 +145,7 @@ int dma_declare_contiguous(struct device *dev, phys_addr_t size,
>  
>  static inline
>  struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
> -				       unsigned int order)
> +				       unsigned int order, gfp_t gfp_mask)
>  {
>  	return NULL;
>  }
> -- 
> 2.11.0
> 

-- 
Michal Hocko
SUSE Labs
