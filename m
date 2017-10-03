Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2017 13:50:08 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:51730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993122AbdJCLuCMlwMQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Oct 2017 13:50:02 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 022F580D;
        Tue,  3 Oct 2017 04:49:56 -0700 (PDT)
Received: from [10.1.210.88] (e110467-lin.cambridge.arm.com [10.1.210.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F6063F578;
        Tue,  3 Oct 2017 04:49:53 -0700 (PDT)
Subject: Re: refactor dma_cache_sync V2
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Michal Simek <monstr@monstr.eu>,
        David Howells <dhowells@redhat.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20171003104311.10058-1-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <87817c6a-b03f-6da0-4e69-22ea68d44bd5@arm.com>
Date:   Tue, 3 Oct 2017 12:49:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171003104311.10058-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <robin.murphy@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60236
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

On 03/10/17 11:43, Christoph Hellwig wrote:
> The dma_cache_sync routines is used to flush caches for memory returned
> by dma_alloc_attrs with the DMA_ATTR_NON_CONSISTENT flag (or previously
> from dma_alloc_noncoherent), but the requirements for it seems to be
> frequently misunderstood.  dma_cache_sync is documented to be a no-op for
> allocations that do not have the DMA_ATTR_NON_CONSISTENT flag set, and
> yet a lot of architectures implement it in some way despite not
> implementing DMA_ATTR_NON_CONSISTENT.
> 
> This series removes a few abuses of dma_cache_sync for non-DMA API
> purposes, then changes all remaining architectures that do not implement
> DMA_ATTR_NON_CONSISTENT to implement dma_cache_sync as a no-op, and
> then adds the struct dma_map_ops indirection we use for all other
> DMA mapping operations to dma_cache_sync as well, thus removing all but
> two implementations of the function.
> 
> Changes since V1:
>  - drop the mips fd_cacheflush, merged via maintainer
>  - spelling fix in last commit descriptions (thanks Geert)
> 

For the series,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

The MIPS DMA ops are a little fiddly, but I've satisfied myself that
CONFIG_DMA_NONCOHERENT and CONFIG_SWIOTLB are mutually exclusive for
Loongson64 such that patch #11 isn't missing anything.

Robin.
