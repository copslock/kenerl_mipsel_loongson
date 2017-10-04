Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Oct 2017 10:29:30 +0200 (CEST)
Received: from pegase1.c-s.fr ([93.17.236.30]:58165 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990482AbdJDI3VRwhcX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Oct 2017 10:29:21 +0200
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 3y6TZl3532z9ttBs;
        Wed,  4 Oct 2017 10:29:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id geeUt-CqHz3Z; Wed,  4 Oct 2017 10:29:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 3y6TZl2Vvzz9ttBp;
        Wed,  4 Oct 2017 10:29:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B8C208B891;
        Wed,  4 Oct 2017 10:29:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JWtzsTQIw0Da; Wed,  4 Oct 2017 10:29:13 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 76AE88B74B;
        Wed,  4 Oct 2017 10:29:13 +0200 (CEST)
Subject: Re: [PATCH 07/11] powerpc: make dma_cache_sync a no-op
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, Chris Zankel <chris@zankel.net>,
        Michal Simek <monstr@monstr.eu>, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20171003104311.10058-1-hch@lst.de>
 <20171003104311.10058-8-hch@lst.de>
 <670a0571-1a36-51a3-db52-64bc61184c35@c-s.fr> <20171003114330.GA24592@lst.de>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <fd0ccac1-51dc-1eff-f1ac-63f9df282de2@c-s.fr>
Date:   Wed, 4 Oct 2017 10:29:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171003114330.GA24592@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Return-Path: <christophe.leroy@c-s.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60245
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



Le 03/10/2017 à 13:43, Christoph Hellwig a écrit :
> On Tue, Oct 03, 2017 at 01:24:57PM +0200, Christophe LEROY wrote:
>>> powerpc does not implement DMA_ATTR_NON_CONSISTENT allocations, so it
>>> doesn't make any sense to do any work in dma_cache_sync given that it
>>> must be a no-op when dma_alloc_attrs returns coherent memory.
>> What about arch/powerpc/mm/dma-noncoherent.c ?
>>
>> Powerpc 8xx doesn't have coherent memory.
> 
> It doesn't implement the DMA_ATTR_NON_CONSISTENT interface either,
> so if it really doesn't have a way to provide dma coherent allocation
> (although the code in __dma_alloc_coherent suggests it does provide
> dma coherent allocations) I have no idea how it could ever have
> worked.
> 

Yes indeed it provides coherent memory by allocation non cached memory.

And drivers aiming at using non coherent memory do it by using kmalloc() 
with GFP_DMA then dma_map_single().
Then they use dma_sync_single_for_xxx(), which calls __dma_sync() on the 
8xx and is a nop on other powerpcs.

Christophe
