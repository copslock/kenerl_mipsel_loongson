Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 17:26:56 +0100 (CET)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46074 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994626AbeABQ0irOfMp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 17:26:38 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE78680D;
        Tue,  2 Jan 2018 08:26:32 -0800 (PST)
Received: from [10.1.78.252] (unknown [10.1.78.252])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B445C3F53D;
        Tue,  2 Jan 2018 08:26:28 -0800 (PST)
Subject: Re: [PATCH 26/67] dma-direct: use phys_to_dma
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
 <20171229081911.2802-27-hch@lst.de>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <76092d0d-3e74-9433-5fae-afc512e34b20@arm.com>
Date:   Tue, 2 Jan 2018 16:26:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20171229081911.2802-27-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <vladimir.murzin@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61852
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
> This means it uses whatever linear remapping scheme that the architecture
> provides is used in the generic dma_direct ops.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  lib/dma-direct.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/dma-direct.c b/lib/dma-direct.c
> index 439db40854b7..0e087650e86b 100644
> --- a/lib/dma-direct.c
> +++ b/lib/dma-direct.c
> @@ -1,12 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - *	lib/dma-noop.c
> - *
> - * DMA operations that map to physical addresses without flushing memory.
> + * DMA operations that map physical memory directly without using an IOMMU or
> + * flushing caches.
>   */
>  #include <linux/export.h>
>  #include <linux/mm.h>
> -#include <linux/dma-mapping.h>
> +#include <linux/dma-direct.h>
>  #include <linux/scatterlist.h>
>  #include <linux/pfn.h>
>  
> @@ -17,7 +16,7 @@ static void *dma_direct_alloc(struct device *dev, size_t size,
>  
>  	ret = (void *)__get_free_pages(gfp, get_order(size));
>  	if (ret)
> -		*dma_handle = virt_to_phys(ret) - PFN_PHYS(dev->dma_pfn_offset);
> +		*dma_handle = phys_to_dma(dev, virt_to_phys(ret));
>  
>  	return ret;
>  }
> @@ -32,7 +31,7 @@ static dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
>  		unsigned long offset, size_t size, enum dma_data_direction dir,
>  		unsigned long attrs)
>  {
> -	return page_to_phys(page) + offset - PFN_PHYS(dev->dma_pfn_offset);
> +	return phys_to_dma(dev, page_to_phys(page)) + offset;
>  }
>  
>  static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
> @@ -42,12 +41,9 @@ static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
>  	struct scatterlist *sg;
>  
>  	for_each_sg(sgl, sg, nents, i) {
> -		dma_addr_t offset = PFN_PHYS(dev->dma_pfn_offset);
> -		void *va;
> -
>  		BUG_ON(!sg_page(sg));
> -		va = sg_virt(sg);
> -		sg_dma_address(sg) = (dma_addr_t)virt_to_phys(va) - offset;
> +
> +		sg_dma_address(sg) = phys_to_dma(dev, sg_phys(sg));
>  		sg_dma_len(sg) = sg->length;
>  	}
>  
> 

From ARM NOMMU perspective

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

Thanks
Vladimir
