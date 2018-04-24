Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Apr 2018 08:54:28 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:48016 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992312AbeDXGyVnc82n (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Apr 2018 08:54:21 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 720AA68DB3; Tue, 24 Apr 2018 08:55:49 +0200 (CEST)
Date:   Tue, 24 Apr 2018 08:55:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, linux-mips@linux-mips.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 11/12] swiotlb: move the SWIOTLB config symbol to
        lib/Kconfig
Message-ID: <20180424065549.GA18468@lst.de>
References: <20180423170419.20330-1-hch@lst.de> <20180423170419.20330-12-hch@lst.de> <20180423235205.GH16141@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423235205.GH16141@n2100.armlinux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63717
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

On Tue, Apr 24, 2018 at 12:52:05AM +0100, Russell King - ARM Linux wrote:
> On Mon, Apr 23, 2018 at 07:04:18PM +0200, Christoph Hellwig wrote:
> > This way we have one central definition of it, and user can select it as
> > needed.  Note that we also add a second ARCH_HAS_SWIOTLB symbol to
> > indicate the architecture supports swiotlb at all, so that we can still
> > make the usage optional for a few architectures that want this feature
> > to be user selectable.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Hmm, this looks like we end up with NEED_SG_DMA_LENGTH=y on ARM by
> default, which probably isn't a good idea - ARM pre-dates the dma_length
> parameter in scatterlists, and I don't think all code is guaranteed to
> do the right thing if this is enabled.

We shouldn't end up with NEED_SG_DMA_LENGTH=y on ARM by default.
It is only select by ARM_DMA_USE_IOMMU before the patch, and it will
now also be selected by SWIOTLB, which for arm is never used or seleted
directly by anything but xen-swiotlb.

Then again looking at the series there shouldn't be any need to
even select NEED_SG_DMA_LENGTH for swiotlb, as we'll never merge segments,
so I'll fix that up.
