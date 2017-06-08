Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 15:59:25 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:53490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993894AbdFHN7SWuntT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Jun 2017 15:59:18 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBFBA2B;
        Thu,  8 Jun 2017 06:59:11 -0700 (PDT)
Received: from [10.1.210.40] (e110467-lin.cambridge.arm.com [10.1.210.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79A853F3E1;
        Thu,  8 Jun 2017 06:59:08 -0700 (PDT)
Subject: Re: [PATCH 06/44] iommu/dma: don't rely on DMA_ERROR_CODE
To:     Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-7-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0bfb0841-f054-78de-628d-a0955336bcb4@arm.com>
Date:   Thu, 8 Jun 2017 14:59:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170608132609.32662-7-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <robin.murphy@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robin.murphy@arm.com
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

Hi Christoph,

On 08/06/17 14:25, Christoph Hellwig wrote:
> DMA_ERROR_CODE is not a public API and will go away soon.  dma dma-iommu
> driver already implements a proper ->mapping_error method, so it's only
> using the value internally.  Add a new local define using the value
> that arm64 which is the only current user of dma-iommu.

It would be fine to just use 0, since dma-iommu already makes sure that
that will never be allocated for a valid DMA address.

Otherwise, looks good!

Robin.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/iommu/dma-iommu.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 62618e77bedc..638aea814b94 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -31,6 +31,8 @@
>  #include <linux/scatterlist.h>
>  #include <linux/vmalloc.h>
>  
> +#define IOMMU_MAPPING_ERROR	(~(dma_addr_t)0)
> +
>  struct iommu_dma_msi_page {
>  	struct list_head	list;
>  	dma_addr_t		iova;
> @@ -500,7 +502,7 @@ void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
>  {
>  	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), *handle, size);
>  	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
> -	*handle = DMA_ERROR_CODE;
> +	*handle = IOMMU_MAPPING_ERROR;
>  }
>  
>  /**
> @@ -533,7 +535,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>  	dma_addr_t iova;
>  	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
>  
> -	*handle = DMA_ERROR_CODE;
> +	*handle = IOMMU_MAPPING_ERROR;
>  
>  	min_size = alloc_sizes & -alloc_sizes;
>  	if (min_size < PAGE_SIZE) {
> @@ -627,11 +629,11 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
>  
>  	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
>  	if (!iova)
> -		return DMA_ERROR_CODE;
> +		return IOMMU_MAPPING_ERROR;
>  
>  	if (iommu_map(domain, iova, phys - iova_off, size, prot)) {
>  		iommu_dma_free_iova(cookie, iova, size);
> -		return DMA_ERROR_CODE;
> +		return IOMMU_MAPPING_ERROR;
>  	}
>  	return iova + iova_off;
>  }
> @@ -671,7 +673,7 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
>  
>  		s->offset += s_iova_off;
>  		s->length = s_length;
> -		sg_dma_address(s) = DMA_ERROR_CODE;
> +		sg_dma_address(s) = IOMMU_MAPPING_ERROR;
>  		sg_dma_len(s) = 0;
>  
>  		/*
> @@ -714,11 +716,11 @@ static void __invalidate_sg(struct scatterlist *sg, int nents)
>  	int i;
>  
>  	for_each_sg(sg, s, nents, i) {
> -		if (sg_dma_address(s) != DMA_ERROR_CODE)
> +		if (sg_dma_address(s) != IOMMU_MAPPING_ERROR)
>  			s->offset += sg_dma_address(s);
>  		if (sg_dma_len(s))
>  			s->length = sg_dma_len(s);
> -		sg_dma_address(s) = DMA_ERROR_CODE;
> +		sg_dma_address(s) = IOMMU_MAPPING_ERROR;
>  		sg_dma_len(s) = 0;
>  	}
>  }
> @@ -836,7 +838,7 @@ void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
>  
>  int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
>  {
> -	return dma_addr == DMA_ERROR_CODE;
> +	return dma_addr == IOMMU_MAPPING_ERROR;
>  }
>  
>  static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
> 
