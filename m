Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 12:49:54 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:44976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992126AbeAJLtrIHgZX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Jan 2018 12:49:47 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8E8C1435;
        Wed, 10 Jan 2018 03:49:39 -0800 (PST)
Received: from [10.1.210.88] (e110467-lin.cambridge.arm.com [10.1.210.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B37A3F581;
        Wed, 10 Jan 2018 03:49:36 -0800 (PST)
Subject: Re: [PATCH 31/33] dma-direct: reject too small dma masks
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, x86@kernel.org,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        linux-snps-arc@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, patches@groups.riscv.org,
        linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20180110080027.13879-1-hch@lst.de>
 <20180110080027.13879-32-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0bcca030-a8da-c34a-a905-707986689f33@arm.com>
Date:   Wed, 10 Jan 2018 11:49:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180110080027.13879-32-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <robin.murphy@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62027
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

On 10/01/18 08:00, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/dma-direct.h |  1 +
>   lib/dma-direct.c           | 19 +++++++++++++++++++
>   2 files changed, 20 insertions(+)
> 
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index 4788bf0bf683..bcdb1a3e4b1f 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -42,5 +42,6 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   		gfp_t gfp, unsigned long attrs);
>   void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
>   		dma_addr_t dma_addr, unsigned long attrs);
> +int dma_direct_supported(struct device *dev, u64 mask);
>   
>   #endif /* _LINUX_DMA_DIRECT_H */
> diff --git a/lib/dma-direct.c b/lib/dma-direct.c
> index 784a68dfdbe3..40b1f92f2214 100644
> --- a/lib/dma-direct.c
> +++ b/lib/dma-direct.c
> @@ -122,6 +122,24 @@ static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
>   	return nents;
>   }
>   
> +int dma_direct_supported(struct device *dev, u64 mask)
> +{
> +#ifdef CONFIG_ZONE_DMA
> +	if (mask < DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
> +		return 0;
> +#else
> +	/*
> +	 * Because 32-bit DMA masks are so common we expect every architecture
> +	 * to be able to satisfy them - either by not supporting more physical
> +	 * memory, or by providing a ZONE_DMA32.  If neither is the case, the
> +	 * architecture needs to use an IOMMU instead of the direct mapping.
> +	 */
> +	if (mask < DMA_BIT_MASK(32))
> +		return 0;

Do you think it's worth the effort to be a little more accommodating 
here? i.e.:

		return dma_max_pfn(dev) >= max_pfn;

We seem to have a fair few 28-31 bit masks for older hardware which 
probably associates with host systems packing equivalently small amounts 
of RAM.

Otherwise though,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Robin.

> +#endif
> +	return 1;
> +}
> +
>   static int dma_direct_mapping_error(struct device *dev, dma_addr_t dma_addr)
>   {
>   	return dma_addr == DIRECT_MAPPING_ERROR;
> @@ -132,6 +150,7 @@ const struct dma_map_ops dma_direct_ops = {
>   	.free			= dma_direct_free,
>   	.map_page		= dma_direct_map_page,
>   	.map_sg			= dma_direct_map_sg,
> +	.dma_supported		= dma_direct_supported,
>   	.mapping_error		= dma_direct_mapping_error,
>   };
>   EXPORT_SYMBOL(dma_direct_ops);
> 
