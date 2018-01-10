Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 12:08:15 +0100 (CET)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44190 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992126AbeAJLIISqv5g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 12:08:08 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D29CE1529;
        Wed, 10 Jan 2018 03:08:00 -0800 (PST)
Received: from [10.1.210.88] (e110467-lin.cambridge.arm.com [10.1.210.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 265A13F318;
        Wed, 10 Jan 2018 03:07:57 -0800 (PST)
Subject: Re: [PATCH 09/33] dma-mapping: take dma_pfn_offset into account in
 dma_max_pfn
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
 <20180110080027.13879-10-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6e4732eb-9eaf-7e5b-863c-d3faa47bb513@arm.com>
Date:   Wed, 10 Jan 2018 11:07:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180110080027.13879-10-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <robin.murphy@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62025
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
> This makes sure the generic version can be used with architectures /
> devices that have a DMA offset in the direct mapping.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/dma-mapping.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 81ed9b2d84dc..d84951865be7 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -692,7 +692,7 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
>   #ifndef dma_max_pfn
>   static inline unsigned long dma_max_pfn(struct device *dev)
>   {
> -	return *dev->dma_mask >> PAGE_SHIFT;
> +	return (*dev->dma_mask >> PAGE_SHIFT) + dev->dma_pfn_offset;
>   }
>   #endif
>   
> 
