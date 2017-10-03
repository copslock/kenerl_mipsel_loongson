Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2017 13:43:51 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:33056 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993156AbdJCLng4o4HQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Oct 2017 13:43:36 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C909568CEE; Tue,  3 Oct 2017 13:43:30 +0200 (CEST)
Date:   Tue, 3 Oct 2017 13:43:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Chris Zankel <chris@zankel.net>,
        Michal Simek <monstr@monstr.eu>, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 07/11] powerpc: make dma_cache_sync a no-op
Message-ID: <20171003114330.GA24592@lst.de>
References: <20171003104311.10058-1-hch@lst.de> <20171003104311.10058-8-hch@lst.de> <670a0571-1a36-51a3-db52-64bc61184c35@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670a0571-1a36-51a3-db52-64bc61184c35@c-s.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
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

On Tue, Oct 03, 2017 at 01:24:57PM +0200, Christophe LEROY wrote:
>> powerpc does not implement DMA_ATTR_NON_CONSISTENT allocations, so it
>> doesn't make any sense to do any work in dma_cache_sync given that it
>> must be a no-op when dma_alloc_attrs returns coherent memory.
> What about arch/powerpc/mm/dma-noncoherent.c ?
>
> Powerpc 8xx doesn't have coherent memory.

It doesn't implement the DMA_ATTR_NON_CONSISTENT interface either,
so if it really doesn't have a way to provide dma coherent allocation
(although the code in __dma_alloc_coherent suggests it does provide
dma coherent allocations) I have no idea how it could ever have
worked.
