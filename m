Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 17:12:21 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:33433 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992675AbdJSPMPEX3vl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Oct 2017 17:12:15 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id BBCB2DE7F8; Thu, 19 Oct 2017 17:12:14 +0200 (CEST)
Date:   Thu, 19 Oct 2017 17:12:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Huacai Chen <chenhc@lemote.com>, Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fuxin Zhang <zhangfx@lemote.com>, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH V8 4/5] libsas: Align SMP req/resp to
        dma_get_cache_alignment()
Message-ID: <20171019151214.GD24204@lst.de>
References: <1508227542-13165-1-git-send-email-chenhc@lemote.com> <CGME20171017080448epcas5p2c7c53292d84838f6d06e78abf4416729@epcas5p2.samsung.com> <1508227542-13165-4-git-send-email-chenhc@lemote.com> <286bf838-4d2f-a25f-baf9-ef3ac9b37d93@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286bf838-4d2f-a25f-baf9-ef3ac9b37d93@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60481
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

On Tue, Oct 17, 2017 at 01:55:43PM +0200, Marek Szyprowski wrote:
> If I remember correctly, kernel guarantees that each kmalloced buffer is
> always at least aligned to the CPU cache line, so CPU cache can be
> invalidated on the allocated buffer without corrupting anything else.

Yes, from slab.h:

/*
 * Some archs want to perform DMA into kmalloc caches and need a guaranteed
 * alignment larger than the alignment of a 64-bit integer.
 * Setting ARCH_KMALLOC_MINALIGN in arch headers allows that.
 */
#if defined(ARCH_DMA_MINALIGN) && ARCH_DMA_MINALIGN > 8
#define ARCH_KMALLOC_MINALIGN ARCH_DMA_MINALIGN
#define KMALLOC_MIN_SIZE ARCH_DMA_MINALIGN
#define KMALLOC_SHIFT_LOW ilog2(ARCH_DMA_MINALIGN)
#else
#define ARCH_KMALLOC_MINALIGN __alignof__(unsigned long long)
#endif

Mips sets this for a few subarchitectures, but it seems like you need
to set it for yours as well.
