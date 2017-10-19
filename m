Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 17:10:15 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:33410 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992636AbdJSPKJGReTl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Oct 2017 17:10:09 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DF27EDE7F8; Thu, 19 Oct 2017 17:10:08 +0200 (CEST)
Date:   Thu, 19 Oct 2017 17:10:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
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
Subject: Re: [PATCH V8 3/5] scsi: Align block queue to
        dma_get_cache_alignment()
Message-ID: <20171019151008.GC24204@lst.de>
References: <1508227542-13165-1-git-send-email-chenhc@lemote.com> <1508227542-13165-3-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508227542-13165-3-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60479
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

On Tue, Oct 17, 2017 at 04:05:40PM +0800, Huacai Chen wrote:
> In non-coherent DMA mode, kernel uses cache flushing operations to
> maintain I/O coherency, so scsi's block queue should be aligned to
> ARCH_DMA_MINALIGN. Otherwise, If a DMA buffer and a kernel structure
> share a same cache line, and if the kernel structure has dirty data,
> cache_invalidate (no writeback) will cause data corruption.

Looks fine to, and I like cleaning up the arcane 0x03 as wel.
