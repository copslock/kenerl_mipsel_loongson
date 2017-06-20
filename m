Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 15:15:26 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:53667 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992111AbdFTNPDgfSSn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Jun 2017 15:15:03 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1C8007FC0D; Tue, 20 Jun 2017 15:15:03 +0200 (CEST)
Date:   Tue, 20 Jun 2017 15:15:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: new dma-mapping tree, was Re: clean up and modularize arch
        dma_mapping interface V2
Message-ID: <20170620131503.GA30769@lst.de>
References: <20170620124140.GA27163@lst.de> <6025d4d4-1975-9598-c16d-26d17d029ec7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6025d4d4-1975-9598-c16d-26d17d029ec7@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58686
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

On Tue, Jun 20, 2017 at 02:14:36PM +0100, Robin Murphy wrote:
> Hi Christoph,
> 
> On 20/06/17 13:41, Christoph Hellwig wrote:
> > On Fri, Jun 16, 2017 at 08:10:15PM +0200, Christoph Hellwig wrote:
> >> I plan to create a new dma-mapping tree to collect all this work.
> >> Any volunteers for co-maintainers, especially from the iommu gang?
> > 
> > Ok, I've created the new tree:
> > 
> >    git://git.infradead.org/users/hch/dma-mapping.git for-next
> > 
> > Gitweb:
> > 
> >    http://git.infradead.org/users/hch/dma-mapping.git/shortlog/refs/heads/for-next
> > 
> > And below is the patch to add the MAINTAINERS entry, additions welcome.
> 
> I'm happy to be a reviewer, since I've been working in this area for
> some time, particularly with the dma-iommu code and arm64 DMA ops.

Great, I'll add you!
