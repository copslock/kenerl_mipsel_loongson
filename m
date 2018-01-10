Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 12:08:49 +0100 (CET)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44248 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992126AbeAJLIiJqumg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 12:08:38 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 109D11529;
        Wed, 10 Jan 2018 03:08:32 -0800 (PST)
Received: from [10.1.210.88] (e110467-lin.cambridge.arm.com [10.1.210.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BAA73F318;
        Wed, 10 Jan 2018 03:08:28 -0800 (PST)
Subject: Re: [PATCH 10/33] arm64: don't override dma_max_pfn
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
 <20180110080027.13879-11-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <115563c4-7929-a68c-459a-89d787051053@arm.com>
Date:   Wed, 10 Jan 2018 11:08:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180110080027.13879-11-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <robin.murphy@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62026
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
> The generic version now takes dma_pfn_offset into account, so there is no
> more need for an architecture override.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm64/include/asm/dma-mapping.h | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> index 0df756b24863..eada887a93bf 100644
> --- a/arch/arm64/include/asm/dma-mapping.h
> +++ b/arch/arm64/include/asm/dma-mapping.h
> @@ -76,14 +76,5 @@ static inline void dma_mark_clean(void *addr, size_t size)
>   {
>   }
>   
> -/* Override for dma_max_pfn() */
> -static inline unsigned long dma_max_pfn(struct device *dev)
> -{
> -	dma_addr_t dma_max = (dma_addr_t)*dev->dma_mask;
> -
> -	return (ulong)dma_to_phys(dev, dma_max) >> PAGE_SHIFT;
> -}
> -#define dma_max_pfn(dev) dma_max_pfn(dev)
> -
>   #endif	/* __KERNEL__ */
>   #endif	/* __ASM_DMA_MAPPING_H */
> 
