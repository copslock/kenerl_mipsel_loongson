Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 10:32:14 +0100 (CET)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42964 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994554AbeAJJcFyEm08 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 10:32:05 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80A931529;
        Wed, 10 Jan 2018 01:31:58 -0800 (PST)
Received: from [10.1.79.5] (unknown [10.1.79.5])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D0753F41F;
        Wed, 10 Jan 2018 01:31:54 -0800 (PST)
Subject: Re: [PATCH 11/33] dma-mapping: move swiotlb arch helpers to a new
 header
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
 <20180110080027.13879-12-hch@lst.de>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <b2bd6f4b-a932-5251-517b-83bbccfe7c53@arm.com>
Date:   Wed, 10 Jan 2018 09:31:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180110080027.13879-12-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <vladimir.murzin@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62023
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

On 10/01/18 08:00, Christoph Hellwig wrote:
> index 9110988b92a1..f00833acb626 100644
> --- a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
> +++ b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
> @@ -61,6 +61,14 @@ static inline void plat_post_dma_flush(struct device *dev)
>  {
>  }
>  
> +static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
> +{
> +	if (!dev->dma_mask)
> +		return false;
> +
> +	return addr + size <= *dev->dma_mask;
> +}
> +

I know it is copy&paste, but it seems it has off by one error and it should be

return addr + size - 1 <= *dev->dma_mask;


>  dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr);
>  phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr);
>  

snip...

> diff --git a/arch/mips/include/asm/mach-loongson64/dma-coherence.h b/arch/mips/include/asm/mach-loongson64/dma-coherence.h
> index 1602a9e9e8c2..5cfda8f893e9 100644
> --- a/arch/mips/include/asm/mach-loongson64/dma-coherence.h
> +++ b/arch/mips/include/asm/mach-loongson64/dma-coherence.h
> @@ -17,6 +17,14 @@
>  
>  struct device;
>  
> +static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
> +{
> +	if (!dev->dma_mask)
> +		return false;
> +
> +	return addr + size <= *dev->dma_mask;


ditto

Cheers
Vladimir
