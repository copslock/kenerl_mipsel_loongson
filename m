Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 17:43:35 +0100 (CET)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46298 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994628AbeABQn2YdJjp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 17:43:28 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11CA380D;
        Tue,  2 Jan 2018 08:43:21 -0800 (PST)
Received: from [10.1.78.252] (unknown [10.1.78.252])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 349063F53D;
        Tue,  2 Jan 2018 08:43:17 -0800 (PST)
Subject: Re: [PATCH 30/67] dma-direct: retry allocations using GFP_DMA for
 small masks
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
 <20171229081911.2802-31-hch@lst.de>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <f6139b03-0a4a-a9fe-4818-9b0bccf419e4@arm.com>
Date:   Tue, 2 Jan 2018 16:43:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20171229081911.2802-31-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <vladimir.murzin@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61855
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
> If we got back an allocation that wasn't inside the support coherent mask,
> retry the allocation using GFP_DMA.
> 
> Based on the x86 code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  lib/dma-direct.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/dma-direct.c b/lib/dma-direct.c
> index ab81de3ac1d3..f8467cb3d89a 100644
> --- a/lib/dma-direct.c
> +++ b/lib/dma-direct.c
> @@ -28,6 +28,11 @@ check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
>  	return true;
>  }
>  
> +static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
> +{
> +	return phys_to_dma(dev, phys) + size <= dev->coherent_dma_mask;

Shouldn't it be: phys_to_dma(dev, phys) + size - 1 <= dev->coherent_dma_mask ?

> +}
> +
>  static void *dma_direct_alloc(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>  {
> @@ -35,11 +40,29 @@ static void *dma_direct_alloc(struct device *dev, size_t size,
>  	int page_order = get_order(size);
>  	struct page *page = NULL;
>  
> +again:
>  	/* CMA can be used only in the context which permits sleeping */
> -	if (gfpflags_allow_blocking(gfp))
> +	if (gfpflags_allow_blocking(gfp)) {
>  		page = dma_alloc_from_contiguous(dev, count, page_order, gfp);
> +		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
> +			dma_release_from_contiguous(dev, page, count);
> +			page = NULL;
> +		}
> +	}
>  	if (!page)
>  		page = alloc_pages_node(dev_to_node(dev), gfp, page_order);
> +
> +	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
> +		__free_pages(page, page_order);
> +		page = NULL;
> +
> +		if (dev->coherent_dma_mask < DMA_BIT_MASK(32) &&
> +		    !(gfp & GFP_DMA)) {
> +			gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
> +			goto again;

Shouldn't we limit number of attempts?

Thanks
Vladimir
