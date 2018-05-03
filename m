Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 May 2018 05:54:09 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:60790 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992212AbeECDyDhtuO2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 May 2018 05:54:03 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6584068CF4; Thu,  3 May 2018 05:56:43 +0200 (CEST)
Date:   Thu, 3 May 2018 05:56:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     James Hogan <jhogan@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, sstabellini@kernel.org,
        x86@kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
        linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 11/13] mips,unicore32: swiotlb doesn't need
        sg->dma_length
Message-ID: <20180503035643.GA9781@lst.de>
References: <20180425051539.1989-1-hch@lst.de> <20180425051539.1989-12-hch@lst.de> <20180502222017.GC20766@jamesdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502222017.GC20766@jamesdev>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63854
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

On Wed, May 02, 2018 at 11:20:18PM +0100, James Hogan wrote:
> On Wed, Apr 25, 2018 at 07:15:37AM +0200, Christoph Hellwig wrote:
> > Only mips and unicore32 select CONFIG_NEED_SG_DMA_LENGTH when building
> > swiotlb.  swiotlb itself never merges segements and doesn't accesses the
> > dma_length field directly, so drop the dependency.
> 
> Is that at odds with Documentation/DMA-API-HOWTO.txt, which seems to
> suggest arch ports should enable it for IOMMUs?

swiotlb isn't really an iommu..  That being said iommus don't have to
merge segments either if they don't want to, and we have various
implementations that don't.  The whole dma api documentation needs
a major overhaul, including merging the various files and dropping a lot
of dead wood.  It has been on my todo list for a while, with an inner
hope that someone else would do it before me.
