Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 17:44:49 +0100 (CET)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46404 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994628AbeABQodDmAZp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 17:44:33 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C61780D;
        Tue,  2 Jan 2018 08:44:26 -0800 (PST)
Received: from [10.1.78.252] (unknown [10.1.78.252])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC7F33F53D;
        Tue,  2 Jan 2018 08:44:22 -0800 (PST)
Subject: Re: [PATCH 31/67] dma-direct: make dma_direct_{alloc, free} available
 to other implementations
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, x86@kernel.org,
        linux-snps-arc@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-m68k@lists.linux-m68k.org, patches@groups.riscv.org,
        linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-32-hch@lst.de>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <f7aca03c-e893-d10a-7a28-bb3c9ae47900@arm.com>
Date:   Tue, 2 Jan 2018 16:44:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20171229081911.2802-32-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: ru
Content-Transfer-Encoding: 7bit
Return-Path: <vladimir.murzin@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vladimir.murzin@arm.com
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

On 29/12/17 08:18, Christoph Hellwig wrote:
> So that they don't need to indirect through the operation vector.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/mm/dma-mapping-nommu.c | 9 +++------
>  include/linux/dma-direct.h      | 5 +++++
>  lib/dma-direct.c                | 6 +++---
>  3 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
> index 49e9831dc0f1..b4cf3e4e9d4a 100644
> --- a/arch/arm/mm/dma-mapping-nommu.c
> +++ b/arch/arm/mm/dma-mapping-nommu.c
> @@ -11,7 +11,7 @@
>  
>  #include <linux/export.h>
>  #include <linux/mm.h>
> -#include <linux/dma-mapping.h>
> +#include <linux/dma-direct.h>
>  #include <linux/scatterlist.h>
>  
>  #include <asm/cachetype.h>
> @@ -39,7 +39,6 @@ static void *arm_nommu_dma_alloc(struct device *dev, size_t size,
>  				 unsigned long attrs)
>  
>  {
> -	const struct dma_map_ops *ops = &dma_direct_ops;
>  	void *ret;
>  
>  	/*
> @@ -48,7 +47,7 @@ static void *arm_nommu_dma_alloc(struct device *dev, size_t size,
>  	 */
>  
>  	if (attrs & DMA_ATTR_NON_CONSISTENT)
> -		return ops->alloc(dev, size, dma_handle, gfp, attrs);
> +		return dma_direct_alloc(dev, size, dma_handle, gfp, attrs);
>  
>  	ret = dma_alloc_from_global_coherent(size, dma_handle);
>  
> @@ -70,10 +69,8 @@ static void arm_nommu_dma_free(struct device *dev, size_t size,
>  			       void *cpu_addr, dma_addr_t dma_addr,
>  			       unsigned long attrs)
>  {
> -	const struct dma_map_ops *ops = &dma_direct_ops;
> -
>  	if (attrs & DMA_ATTR_NON_CONSISTENT) {
> -		ops->free(dev, size, cpu_addr, dma_addr, attrs);
> +		dma_direct_free(dev, size, cpu_addr, dma_addr, attrs);
>  	} else {
>  		int ret = dma_release_from_global_coherent(get_order(size),
>  							   cpu_addr);
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index 10e924b7cba7..4788bf0bf683 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -38,4 +38,9 @@ static inline void dma_mark_clean(void *addr, size_t size)
>  }
>  #endif /* CONFIG_ARCH_HAS_DMA_MARK_CLEAN */
>  
> +void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
> +		gfp_t gfp, unsigned long attrs);
> +void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
> +		dma_addr_t dma_addr, unsigned long attrs);
> +
>  #endif /* _LINUX_DMA_DIRECT_H */
> diff --git a/lib/dma-direct.c b/lib/dma-direct.c
> index f8467cb3d89a..7e913728e099 100644
> --- a/lib/dma-direct.c
> +++ b/lib/dma-direct.c
> @@ -33,8 +33,8 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
>  	return phys_to_dma(dev, phys) + size <= dev->coherent_dma_mask;
>  }
>  
> -static void *dma_direct_alloc(struct device *dev, size_t size,
> -		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
> +void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
> +		gfp_t gfp, unsigned long attrs)
>  {
>  	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>  	int page_order = get_order(size);
> @@ -71,7 +71,7 @@ static void *dma_direct_alloc(struct device *dev, size_t size,
>  	return page_address(page);
>  }
>  
> -static void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
> +void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
>  		dma_addr_t dma_addr, unsigned long attrs)
>  {
>  	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> 

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

Thanks
Vladimir
