Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 20:45:49 +0100 (CET)
Received: from smtprelay.synopsys.com ([198.182.60.111]:53485 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992828AbeAETplwhXYu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jan 2018 20:45:41 +0100
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 95AF810C0239;
        Fri,  5 Jan 2018 11:45:31 -0800 (PST)
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9B02FCE1;
        Fri,  5 Jan 2018 11:45:28 -0800 (PST)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Fri, 5 Jan 2018 11:45:28 -0800
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Sat, 6 Jan 2018 01:15:25 +0530
Received: from [10.10.161.67] (10.10.161.67) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Sat, 6 Jan 2018 01:15:24 +0530
Subject: Re: [PATCH 09/67] arc: remove CONFIG_ARC_PLAT_NEEDS_PHYS_TO_DMA
To:     Christoph Hellwig <hch@lst.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "patches@groups.riscv.org" <patches@groups.riscv.org>,
        "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <monstr@monstr.eu>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-10-hch@lst.de>
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <2c24bfd1-5f54-4b82-444e-833dc53b6efd@synopsys.com>
Date:   Fri, 5 Jan 2018 11:45:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171229081911.2802-10-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.10.161.67]
Return-Path: <Vineet.Gupta1@synopsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Vineet.Gupta1@synopsys.com
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

On 12/29/2017 12:25 AM, Christoph Hellwig wrote:
> We always use the stub definitions, so remove the unused other code.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vineet Gupta <vgupta@synopsys.com>

FWIW, it was removed and reintroduced as one of the customers wanted it, which is 
not relevant now !

Thx,
-Vineet

> ---
>   arch/arc/Kconfig                   |  3 ---
>   arch/arc/include/asm/dma-mapping.h |  7 -------
>   arch/arc/mm/dma.c                  | 14 +++++++-------
>   3 files changed, 7 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index 9d5fd00d9e91..f3a80cf164cc 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -463,9 +463,6 @@ config ARCH_PHYS_ADDR_T_64BIT
>   config ARCH_DMA_ADDR_T_64BIT
>   	bool
>   
> -config ARC_PLAT_NEEDS_PHYS_TO_DMA
> -	bool
> -
>   config ARC_KVADDR_SIZE
>   	int "Kernel Virtual Address Space size (MB)"
>   	range 0 512
> diff --git a/arch/arc/include/asm/dma-mapping.h b/arch/arc/include/asm/dma-mapping.h
> index 94285031c4fb..7a16824bfe98 100644
> --- a/arch/arc/include/asm/dma-mapping.h
> +++ b/arch/arc/include/asm/dma-mapping.h
> @@ -11,13 +11,6 @@
>   #ifndef ASM_ARC_DMA_MAPPING_H
>   #define ASM_ARC_DMA_MAPPING_H
>   
> -#ifndef CONFIG_ARC_PLAT_NEEDS_PHYS_TO_DMA
> -#define plat_dma_to_phys(dev, dma_handle) ((phys_addr_t)(dma_handle))
> -#define plat_phys_to_dma(dev, paddr) ((dma_addr_t)(paddr))
> -#else
> -#include <plat/dma.h>
> -#endif
> -
>   extern const struct dma_map_ops arc_dma_ops;
>   
>   static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
> diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
> index fad18261ef6a..1d405b86250c 100644
> --- a/arch/arc/mm/dma.c
> +++ b/arch/arc/mm/dma.c
> @@ -60,7 +60,7 @@ static void *arc_dma_alloc(struct device *dev, size_t size,
>   	/* This is linear addr (0x8000_0000 based) */
>   	paddr = page_to_phys(page);
>   
> -	*dma_handle = plat_phys_to_dma(dev, paddr);
> +	*dma_handle = paddr;
>   
>   	/* This is kernel Virtual address (0x7000_0000 based) */
>   	if (need_kvaddr) {
> @@ -92,7 +92,7 @@ static void *arc_dma_alloc(struct device *dev, size_t size,
>   static void arc_dma_free(struct device *dev, size_t size, void *vaddr,
>   		dma_addr_t dma_handle, unsigned long attrs)
>   {
> -	phys_addr_t paddr = plat_dma_to_phys(dev, dma_handle);
> +	phys_addr_t paddr = dma_handle;
>   	struct page *page = virt_to_page(paddr);
>   	int is_non_coh = 1;
>   
> @@ -111,7 +111,7 @@ static int arc_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   {
>   	unsigned long user_count = vma_pages(vma);
>   	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	unsigned long pfn = __phys_to_pfn(plat_dma_to_phys(dev, dma_addr));
> +	unsigned long pfn = __phys_to_pfn(dma_addr);
>   	unsigned long off = vma->vm_pgoff;
>   	int ret = -ENXIO;
>   
> @@ -175,7 +175,7 @@ static dma_addr_t arc_dma_map_page(struct device *dev, struct page *page,
>   	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>   		_dma_cache_sync(paddr, size, dir);
>   
> -	return plat_phys_to_dma(dev, paddr);
> +	return paddr;
>   }
>   
>   /*
> @@ -190,7 +190,7 @@ static void arc_dma_unmap_page(struct device *dev, dma_addr_t handle,
>   			       size_t size, enum dma_data_direction dir,
>   			       unsigned long attrs)
>   {
> -	phys_addr_t paddr = plat_dma_to_phys(dev, handle);
> +	phys_addr_t paddr = handle;
>   
>   	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>   		_dma_cache_sync(paddr, size, dir);
> @@ -224,13 +224,13 @@ static void arc_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>   static void arc_dma_sync_single_for_cpu(struct device *dev,
>   		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
>   {
> -	_dma_cache_sync(plat_dma_to_phys(dev, dma_handle), size, DMA_FROM_DEVICE);
> +	_dma_cache_sync(dma_handle, size, DMA_FROM_DEVICE);
>   }
>   
>   static void arc_dma_sync_single_for_device(struct device *dev,
>   		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
>   {
> -	_dma_cache_sync(plat_dma_to_phys(dev, dma_handle), size, DMA_TO_DEVICE);
> +	_dma_cache_sync(dma_handle, size, DMA_TO_DEVICE);
>   }
>   
>   static void arc_dma_sync_sg_for_cpu(struct device *dev,
