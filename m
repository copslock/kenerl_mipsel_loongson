Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 16:55:24 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:37613 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990492AbeAJPzRyvpk2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Jan 2018 16:55:17 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 61DFC9F163; Wed, 10 Jan 2018 16:55:17 +0100 (CET)
Date:   Wed, 10 Jan 2018 16:55:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        Michal Simek <monstr@monstr.eu>, linux-ia64@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 21/22] arm64: replace ZONE_DMA with ZONE_DMA32
Message-ID: <20180110155517.GA18774@lst.de>
References: <20180110080932.14157-1-hch@lst.de> <20180110080932.14157-22-hch@lst.de> <0371cef8-d980-96da-9cb5-3609c39be18a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0371cef8-d980-96da-9cb5-3609c39be18a@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62045
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

On Wed, Jan 10, 2018 at 12:58:14PM +0000, Robin Murphy wrote:
> On 10/01/18 08:09, Christoph Hellwig wrote:
>> arm64 uses ZONE_DMA for allocations below 32-bits.  These days we
>> name the zone for that ZONE_DMA32, which will allow to use the
>> dma-direct and generic swiotlb code as-is, so rename it.
>
> I do wonder if we could also "upgrade" GFP_DMA to GFP_DMA32 somehow when 
> !ZONE_DMA - there are almost certainly arm64 drivers out there using a 
> combination of GFP_DMA and streaming mappings which will no longer get the 
> guaranteed 32-bit addresses they expect after this. I'm not sure quite how 
> feasible that is, though :/

I can't find anything obvious in the tree. The alternative would be
to keep ZONE_DMA and set ARCH_ZONE_DMA_BITS.

> That said, I do agree that this is an appropriate change (the legacy of 
> GFP_DMA is obviously horrible), so, provided we get plenty of time to find 
> and fix the fallout when it lands:
>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

I was hoping to get this into 4.15.  What would be proper time to
fix the fallout?
