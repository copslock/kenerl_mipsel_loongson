Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 15:11:53 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:52237 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990395AbeAXOLqQUDj8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Jan 2018 15:11:46 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B092068D6E; Wed, 24 Jan 2018 15:11:44 +0100 (CET)
Date:   Wed, 24 Jan 2018 15:11:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     James Hogan <jhogan@kernel.org>
Cc:     Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] MIPS: Loongson64: Add cache_sync to
        loongson_dma_map_ops
Message-ID: <20180124141144.GB25393@lst.de>
References: <1510821355-24694-1-git-send-email-chenhc@lemote.com> <20180124140234.GF5446@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180124140234.GF5446@saruman>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62315
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

On Wed, Jan 24, 2018 at 02:02:35PM +0000, James Hogan wrote:
> On Thu, Nov 16, 2017 at 04:35:55PM +0800, Huacai Chen wrote:
> > To support coherent & non-coherent DMA co-exsistance, we should add
> > cache_sync to loongson_dma_map_ops.
> > 
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> 
> I presume this was broken by commit c9eb6172c328 ("dma-mapping: turn
> dma_cache_sync into a dma_map_ops method") in 4.15-rc1? (Christoph Cc'd)

I don't think that is the case.

In mips only mips_default_dma_map_ops supports DMA_ATTR_NON_CONSISTENT,
and mips_default_dma_map_ops grew support for the dma_cache_sync
operation.

Neither Octeon nor longsoon respect the DMA_ATTR_NON_CONSISTENT argument
to dma_alloc_attrs, so there is no point in implementing dma_cache_sync
for them.
