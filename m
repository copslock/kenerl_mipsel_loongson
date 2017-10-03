Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2017 13:25:11 +0200 (CEST)
Received: from pegase1.c-s.fr ([93.17.236.30]:6957 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993122AbdJCLZEEQek3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Oct 2017 13:25:04 +0200
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 3y5xX20XQWz9ttS8;
        Tue,  3 Oct 2017 13:24:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id XxkidNpwgkOU; Tue,  3 Oct 2017 13:24:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 3y5xX1756yz9ttS3;
        Tue,  3 Oct 2017 13:24:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3F9198B7B2;
        Tue,  3 Oct 2017 13:24:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tnw9lKhrQ33D; Tue,  3 Oct 2017 13:24:58 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E5EAD8B745;
        Tue,  3 Oct 2017 13:24:57 +0200 (CEST)
Subject: Re: [PATCH 07/11] powerpc: make dma_cache_sync a no-op
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20171003104311.10058-1-hch@lst.de>
 <20171003104311.10058-8-hch@lst.de>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <670a0571-1a36-51a3-db52-64bc61184c35@c-s.fr>
Date:   Tue, 3 Oct 2017 13:24:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171003104311.10058-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Return-Path: <christophe.leroy@c-s.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: christophe.leroy@c-s.fr
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



Le 03/10/2017 à 12:43, Christoph Hellwig a écrit :
> powerpc does not implement DMA_ATTR_NON_CONSISTENT allocations, so it
> doesn't make any sense to do any work in dma_cache_sync given that it
> must be a no-op when dma_alloc_attrs returns coherent memory.
What about arch/powerpc/mm/dma-noncoherent.c ?

Powerpc 8xx doesn't have coherent memory.

Christophe

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/powerpc/include/asm/dma-mapping.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
> index eaece3d3e225..320846442bfb 100644
> --- a/arch/powerpc/include/asm/dma-mapping.h
> +++ b/arch/powerpc/include/asm/dma-mapping.h
> @@ -144,8 +144,6 @@ static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
>   static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
>   		enum dma_data_direction direction)
>   {
> -	BUG_ON(direction == DMA_NONE);
> -	__dma_sync(vaddr, size, (int)direction);
>   }
>   
>   #endif /* __KERNEL__ */
> 
