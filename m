Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 16:02:28 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:53600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994822AbdFHOCNh3GXT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Jun 2017 16:02:13 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C8CE2B;
        Thu,  8 Jun 2017 07:02:05 -0700 (PDT)
Received: from [10.1.210.40] (e110467-lin.cambridge.arm.com [10.1.210.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8F893F3E1;
        Thu,  8 Jun 2017 07:02:01 -0700 (PDT)
Subject: Re: [PATCH 16/44] arm64: remove DMA_ERROR_CODE
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
 <20170608132609.32662-17-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <dddc8995-8278-0604-07cd-ffe34526686e@arm.com>
Date:   Thu, 8 Jun 2017 15:02:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170608132609.32662-17-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <robin.murphy@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58358
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

On 08/06/17 14:25, Christoph Hellwig wrote:
> The dma alloc interface returns an error by return NULL, and the
> mapping interfaces rely on the mapping_error method, which the dummy
> ops already implement correctly.
> 
> Thus remove the DMA_ERROR_CODE define.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/include/asm/dma-mapping.h | 1 -
>  arch/arm64/mm/dma-mapping.c          | 3 +--
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> index 5392dbeffa45..cf8fc8f05580 100644
> --- a/arch/arm64/include/asm/dma-mapping.h
> +++ b/arch/arm64/include/asm/dma-mapping.h
> @@ -24,7 +24,6 @@
>  #include <xen/xen.h>
>  #include <asm/xen/hypervisor.h>
>  
> -#define DMA_ERROR_CODE	(~(dma_addr_t)0)
>  extern const struct dma_map_ops dummy_dma_ops;
>  
>  static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 3216e098c058..147fbb907a2f 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -184,7 +184,6 @@ static void *__dma_alloc(struct device *dev, size_t size,
>  no_map:
>  	__dma_free_coherent(dev, size, ptr, *dma_handle, attrs);
>  no_mem:
> -	*dma_handle = DMA_ERROR_CODE;
>  	return NULL;
>  }
>  
> @@ -487,7 +486,7 @@ static dma_addr_t __dummy_map_page(struct device *dev, struct page *page,
>  				   enum dma_data_direction dir,
>  				   unsigned long attrs)
>  {
> -	return DMA_ERROR_CODE;
> +	return 0;
>  }
>  
>  static void __dummy_unmap_page(struct device *dev, dma_addr_t dev_addr,
> 
