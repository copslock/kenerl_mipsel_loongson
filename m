Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 12:59:49 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:45126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992243AbeAJL7mdg22X (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Jan 2018 12:59:42 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 631FD1435;
        Wed, 10 Jan 2018 03:59:35 -0800 (PST)
Received: from [10.1.210.88] (e110467-lin.cambridge.arm.com [10.1.210.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98BFF3F581;
        Wed, 10 Jan 2018 03:59:31 -0800 (PST)
Subject: Re: [PATCH 20/33] dma-mapping: clear harmful GFP_* flags in common
 code
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
 <20180110080027.13879-21-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <27b90341-f9d0-356f-0194-1c7203a3f93e@arm.com>
Date:   Wed, 10 Jan 2018 11:59:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180110080027.13879-21-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <robin.murphy@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62028
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
[...]
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 9f28b2fa329e..88bcb1a8211d 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -518,6 +518,13 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
>   	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
>   		return cpu_addr;
>   
> +	/*
> +	 * Let the implementation decide on the zone to allocate from, and
> +	 * decide on the way of zeroing the memory given that the memory
> +	 * returned should always be zeroed.
> +	 */

Just a note that if we're all happy to enshrine the "allocations are 
always zeroed" behaviour in the API (I am too, for the record), we 
should remember to follow up once the dust settles to update the docs 
and I guess just #define dma_zalloc_coherent dma_alloc_coherent.

Robin.

> +	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM | __GFP_ZERO);
> +
>   	if (!arch_dma_alloc_attrs(&dev, &flag))
>   		return NULL;
>   	if (!ops->alloc)
> 
