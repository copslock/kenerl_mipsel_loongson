Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jan 2017 17:19:57 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:51461 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992078AbdA0QTsjNwJE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Jan 2017 17:19:48 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 530B1ABC6;
        Fri, 27 Jan 2017 16:19:48 +0000 (UTC)
Date:   Fri, 27 Jan 2017 17:19:46 +0100
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
Subject: Re: [PATCH 2/3] mm: cma_alloc: allow to specify GFP mask
Message-ID: <20170127161946.GB6357@dhcp22.suse.cz>
References: <20170119170707.31741-1-l.stach@pengutronix.de>
 <20170119170707.31741-2-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170119170707.31741-2-l.stach@pengutronix.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <mhocko@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56525
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

On Thu 19-01-17 18:07:06, Lucas Stach wrote:
> Most users of this interface just want to use it with the default
> GFP_KERNEL flags, but for cases where DMA memory is allocated it may
> be called from a different context.
> 
> No functional change yet, just passing through the flag to the
> underlying alloc_contig_range function.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/powerpc/kvm/book3s_hv_builtin.c | 3 ++-
>  drivers/base/dma-contiguous.c        | 2 +-
>  include/linux/cma.h                  | 3 ++-
>  mm/cma.c                             | 5 +++--
>  mm/cma_debug.c                       | 2 +-
>  5 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
> index 5bb24be0b346..56a62d97ab2d 100644
> --- a/arch/powerpc/kvm/book3s_hv_builtin.c
> +++ b/arch/powerpc/kvm/book3s_hv_builtin.c
> @@ -56,7 +56,8 @@ struct page *kvm_alloc_hpt(unsigned long nr_pages)
>  {
>  	VM_BUG_ON(order_base_2(nr_pages) < KVM_CMA_CHUNK_ORDER - PAGE_SHIFT);
>  
> -	return cma_alloc(kvm_cma, nr_pages, order_base_2(HPT_ALIGN_PAGES));
> +	return cma_alloc(kvm_cma, nr_pages, order_base_2(HPT_ALIGN_PAGES),
> +			 GFP_KERNEL);
>  }
>  EXPORT_SYMBOL_GPL(kvm_alloc_hpt);
>  
> diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> index e167a1e1bccb..d1a9cbabc627 100644
> --- a/drivers/base/dma-contiguous.c
> +++ b/drivers/base/dma-contiguous.c
> @@ -193,7 +193,7 @@ struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
>  	if (align > CONFIG_CMA_ALIGNMENT)
>  		align = CONFIG_CMA_ALIGNMENT;
>  
> -	return cma_alloc(dev_get_cma_area(dev), count, align);
> +	return cma_alloc(dev_get_cma_area(dev), count, align, GFP_KERNEL);
>  }
>  
>  /**
> diff --git a/include/linux/cma.h b/include/linux/cma.h
> index 6f0a91b37f68..03f32d0bd1d8 100644
> --- a/include/linux/cma.h
> +++ b/include/linux/cma.h
> @@ -29,6 +29,7 @@ extern int __init cma_declare_contiguous(phys_addr_t base,
>  extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>  					unsigned int order_per_bit,
>  					struct cma **res_cma);
> -extern struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align);
> +extern struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
> +			      gfp_t gfp_mask);
>  extern bool cma_release(struct cma *cma, const struct page *pages, unsigned int count);
>  #endif
> diff --git a/mm/cma.c b/mm/cma.c
> index fbd67d866f67..a33ddfde315d 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -362,7 +362,8 @@ int __init cma_declare_contiguous(phys_addr_t base,
>   * This function allocates part of contiguous memory on specific
>   * contiguous memory area.
>   */
> -struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align)
> +struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
> +		       gfp_t gfp_mask)
>  {
>  	unsigned long mask, offset;
>  	unsigned long pfn = -1;
> @@ -408,7 +409,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align)
>  		pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
>  		mutex_lock(&cma_mutex);
>  		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
> -					 GFP_KERNEL);
> +					 gfp_mask);
>  		mutex_unlock(&cma_mutex);
>  		if (ret == 0) {
>  			page = pfn_to_page(pfn);
> diff --git a/mm/cma_debug.c b/mm/cma_debug.c
> index f8e4b60db167..ffc0c3d0ae64 100644
> --- a/mm/cma_debug.c
> +++ b/mm/cma_debug.c
> @@ -138,7 +138,7 @@ static int cma_alloc_mem(struct cma *cma, int count)
>  	if (!mem)
>  		return -ENOMEM;
>  
> -	p = cma_alloc(cma, count, 0);
> +	p = cma_alloc(cma, count, 0, GFP_KERNEL);
>  	if (!p) {
>  		kfree(mem);
>  		return -ENOMEM;
> -- 
> 2.11.0
> 

-- 
Michal Hocko
SUSE Labs
