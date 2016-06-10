Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2016 12:59:14 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:47692 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27041564AbcFJK7LgI4Q8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Jun 2016 12:59:11 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CE30F;
        Fri, 10 Jun 2016 03:59:41 -0700 (PDT)
Received: from [10.1.205.154] (e104324-lin.cambridge.arm.com [10.1.205.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB4B83F213;
        Fri, 10 Jun 2016 03:58:54 -0700 (PDT)
Subject: Re: [PATCH v4 43/44] dma-mapping: Remove dma_get_attr
To:     Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1465553521-27303-1-git-send-email-k.kozlowski@samsung.com>
 <1465553521-27303-44-git-send-email-k.kozlowski@samsung.com>
Cc:     hch@infradead.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonas Bonn <jonas@southpole.se>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mark Yao <mark.yao@rock-chips.com>,
        David Airlie <airlied@linux.ie>,
        Heiko Stuebner <heiko@sntech.de>,
        Joerg Roedel <joro@8bytes.org>,
        Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Andrea Gelmini <andrea.gelmini@gelma.net>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Rabin Vincent <rabin@rab.in>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Doug Anderson <armlinux@m.disordat.com>,
        Jisheng Zhang <jszhang@marvell.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Alex Smith <alex.smith@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@suse.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-media@vger.kernel.org
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <575A9D6D.9040808@arm.com>
Date:   Fri, 10 Jun 2016 11:58:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <1465553521-27303-44-git-send-email-k.kozlowski@samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <robin.murphy@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54017
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

On 10/06/16 11:12, Krzysztof Kozlowski wrote:
> After switching DMA attributes to unsigned long it is easier to just
> compare the bits.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> [for avr32]
> Acked-by: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
> ---
[...]
>   arch/arm64/mm/dma-mapping.c                    | 10 +++----
[...]
>   drivers/iommu/dma-iommu.c                      |  2 +-
[...]
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index a7686028dfeb..06c068ca3541 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -32,7 +32,7 @@
>   static pgprot_t __get_dma_pgprot(unsigned long attrs, pgprot_t prot,
>   				 bool coherent)
>   {
> -	if (!coherent || dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs))
> +	if (!coherent || (attrs & DMA_ATTR_WRITE_COMBINE))
>   		return pgprot_writecombine(prot);
>   	return prot;
>   }
> @@ -702,7 +702,7 @@ static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
>   	dma_addr_t dev_addr = iommu_dma_map_page(dev, page, offset, size, prot);
>
>   	if (!iommu_dma_mapping_error(dev, dev_addr) &&
> -	    !dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
> +	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
>   		__iommu_sync_single_for_device(dev, dev_addr, size, dir);
>
>   	return dev_addr;
> @@ -712,7 +712,7 @@ static void __iommu_unmap_page(struct device *dev, dma_addr_t dev_addr,
>   			       size_t size, enum dma_data_direction dir,
>   			       unsigned long attrs)
>   {
> -	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
> +	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
>   		__iommu_sync_single_for_cpu(dev, dev_addr, size, dir);
>
>   	iommu_dma_unmap_page(dev, dev_addr, size, dir, attrs);
> @@ -752,7 +752,7 @@ static int __iommu_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
>   {
>   	bool coherent = is_device_dma_coherent(dev);
>
> -	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
> +	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
>   		__iommu_sync_sg_for_device(dev, sgl, nelems, dir);
>
>   	return iommu_dma_map_sg(dev, sgl, nelems,
> @@ -764,7 +764,7 @@ static void __iommu_unmap_sg_attrs(struct device *dev,
>   				   enum dma_data_direction dir,
>   				   unsigned long attrs)
>   {
> -	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
> +	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
>   		__iommu_sync_sg_for_cpu(dev, sgl, nelems, dir);
>
>   	iommu_dma_unmap_sg(dev, sgl, nelems, dir, attrs);
[...]
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 6c1bda504fb1..08a1e2f3690f 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -306,7 +306,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>   	} else {
>   		size = ALIGN(size, min_size);
>   	}
> -	if (dma_get_attr(DMA_ATTR_ALLOC_SINGLE_PAGES, attrs))
> +	if (attrs & DMA_ATTR_ALLOC_SINGLE_PAGES)
>   		alloc_sizes = min_size;
>
>   	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
[...]

These all look appropriate to me; thanks!

For arm64 and dma-iommu:

Acked-by: Robin Murphy <robin.murphy@arm.com>
