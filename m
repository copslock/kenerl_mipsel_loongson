Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2017 13:43:28 +0200 (CEST)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51644 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993095AbdJCLnTUGltQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Oct 2017 13:43:19 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 254D580D;
        Tue,  3 Oct 2017 04:43:12 -0700 (PDT)
Received: from [10.1.210.88] (e110467-lin.cambridge.arm.com [10.1.210.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E6583F578;
        Tue,  3 Oct 2017 04:43:09 -0700 (PDT)
Subject: Re: [PATCH 07/11] powerpc: make dma_cache_sync a no-op
To:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org
Cc:     Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20171003104311.10058-1-hch@lst.de>
 <20171003104311.10058-8-hch@lst.de>
 <670a0571-1a36-51a3-db52-64bc61184c35@c-s.fr>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <1dcf9810-6e9f-c32f-a416-b114d1992ade@arm.com>
Date:   Tue, 3 Oct 2017 12:43:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <670a0571-1a36-51a3-db52-64bc61184c35@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <robin.murphy@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60234
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

On 03/10/17 12:24, Christophe LEROY wrote:
> 
> 
> Le 03/10/2017 à 12:43, Christoph Hellwig a écrit :
>> powerpc does not implement DMA_ATTR_NON_CONSISTENT allocations, so it
>> doesn't make any sense to do any work in dma_cache_sync given that it
>> must be a no-op when dma_alloc_attrs returns coherent memory.
> What about arch/powerpc/mm/dma-noncoherent.c ?

AFAICS, just like the ARM code from which it is derived, that will
always return a non-cacheable remap of the allocation, which should thus
not require explicit maintenance after CPU accesses. dma_cache_sync()
would only matter if dma_alloc_attrs(..., DMA_ATTR_NON_CONSISTENT) got
special treatment and was allowed to return a cacheable address, but PPC
doesn't even propagate the attrs to its internal __dma_alloc_coherent()
implementations.

Robin.

> Powerpc 8xx doesn't have coherent memory.
> 
> Christophe
> 
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   arch/powerpc/include/asm/dma-mapping.h | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/dma-mapping.h
>> b/arch/powerpc/include/asm/dma-mapping.h
>> index eaece3d3e225..320846442bfb 100644
>> --- a/arch/powerpc/include/asm/dma-mapping.h
>> +++ b/arch/powerpc/include/asm/dma-mapping.h
>> @@ -144,8 +144,6 @@ static inline phys_addr_t dma_to_phys(struct
>> device *dev, dma_addr_t daddr)
>>   static inline void dma_cache_sync(struct device *dev, void *vaddr,
>> size_t size,
>>           enum dma_data_direction direction)
>>   {
>> -    BUG_ON(direction == DMA_NONE);
>> -    __dma_sync(vaddr, size, (int)direction);
>>   }
>>     #endif /* __KERNEL__ */
>>
