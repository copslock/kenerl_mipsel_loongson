Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 15:56:23 +0100 (CET)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47702 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990502AbeAJO4PICLZ0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 15:56:15 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37EC915A2;
        Wed, 10 Jan 2018 06:56:07 -0800 (PST)
Received: from [10.1.210.88] (e110467-lin.cambridge.arm.com [10.1.210.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E92F3F487;
        Wed, 10 Jan 2018 06:56:03 -0800 (PST)
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
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3721b4ba-0685-255e-06b9-6e60678a1a92@arm.com>
Date:   Wed, 10 Jan 2018 14:56:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180110080027.13879-12-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <robin.murphy@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62035
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
> phys_to_dma, dma_to_phys and dma_capable are helpers published by
> architecture code for use of swiotlb and xen-swiotlb only.  Drivers are
> not supposed to use these directly, but use the DMA API instead.
> 
> Move these to a new asm/dma-direct.h helper, included by a
> linux/dma-direct.h wrapper that provides the default linear mapping
> unless the architecture wants to override it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
[...]
>   drivers/crypto/marvell/cesa.c                      |  1 +
>   drivers/mtd/nand/qcom_nandc.c                      |  1 +

I took a look at these, and it seems their phys_to_dma() usage is doing 
the thing which we subsequently formalised as dma_map_resource(). I've 
had a crack at a quick patch to update the CESA driver; qcom_nandc looks 
slightly more complex in that the changes probably need to span the BAM 
dmaengine driver as well.

In the process, though, I stumbled across gen_pool_dma_alloc() - yuck, 
something needs doing there, for sure...

Robin.
