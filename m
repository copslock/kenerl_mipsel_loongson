Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jun 2017 17:37:19 +0200 (CEST)
Received: from gate.crashing.org ([63.228.1.57]:51875 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993887AbdFXPhMIX6gA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 24 Jun 2017 17:37:12 +0200
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.13.8) with ESMTP id v5OFatdn014035;
        Sat, 24 Jun 2017 10:36:56 -0500
Message-ID: <1498318616.31581.87.camel@kernel.crashing.org>
Subject: Re: clean up and modularize arch dma_mapping interface V2
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@lst.de>, tndave <tushar.n.dave@oracle.com>
Cc:     linux-mips@linux-mips.org, linux-samsung-soc@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org,
        openrisc@lists.librecores.org, netdev@vger.kernel.org,
        sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Date:   Sat, 24 Jun 2017 10:36:56 -0500
In-Reply-To: <20170624071855.GD14580@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
         <162d7932-5766-4c29-5471-07d1b699190a@oracle.com>
         <20170624071855.GD14580@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-2.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <benh@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benh@kernel.crashing.org
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

On Sat, 2017-06-24 at 09:18 +0200, Christoph Hellwig wrote:
> On Wed, Jun 21, 2017 at 12:24:28PM -0700, tndave wrote:
> > Thanks for doing this.
> > So archs can still have their own definition for dma_set_mask() if 
> > HAVE_ARCH_DMA_SET_MASK is y?
> > (and similarly for dma_set_coherent_mask() when 
> > CONFIG_ARCH_HAS_DMA_SET_COHERENT_MASK is y)
> > Any plan to change these?
> 
> Yes, those should go away, but I'm not entirely sure how yet.  We'll
> need some hook for switching between an IOMMU and a direct mapping
> (I guess that's what you want to do for sparc as well?), and I need
> to find the best way to do that.  Reimplementing all of dma_set_mask
> and dma_set_coherent_mask is something that I want to move away from.

I think we still need to do it. For example we have a bunch new "funky"
cases.

We already have the case where we mix the direct and iommu mappings,
on some powerpc platforms that translates in an iommu mapping down at
0 for the 32-bit space and a direct mapping high up in the PCI address
space (which crops the top bits and thus hits memory at 0 onwards).

This type of hybrid layout is needed by some adapters, typically
storage, which want to keep the "coherent" mask at 32-bit but support
64-bit for streaming masks.

Another one we are trying to deal better with at the moment is devices
with DMA addressing limitations. Some GPUs typically (but not only)
have limits that go all accross the gamut, typically I've seen 40 bits,
44 bits and 47 bits... And of course those are "high peformance"
adapters so we don't want to limit them to the comparatively small
iommu mapping with extra overhead.

At the moment, we're looking at a dma_set_mask() hook that will, for
these guys, re-configure the iommu mapping to create a "compressed"
linear mapping of system memory (ie, skipping the holes we have between
chip on P9 for example) using the largest possible iommu page size
(256M on P8, 1G on P9).

This is made tricky of course because several devices can potentially
share a DMA domain based on various platform specific reasons. And of
course we have no way to figure out what's the "common denominator" of
all those devices before they start doing DMA. A driver can start
before the neighbour is probed and a driver can start doing DMAs using
the standard 32-bit mapping without doing dma_set_mask().

So heuristics ... ugh. Better ideas welcome :-) All that to say that we
are far from being able to get rid of dma_set_mask() custom
implementations (and coherent mask too).

I was tempted at some point retiring the 32-bit iommu mapping
completely, just doing that "linear" thing I mentioned above and
swiotlb for the rest, along with introducing ZONE_DMA32 on powerpc
(with the real 64-bit bypass still around for non-limited devices but
that's then just extra speed by bypassing the iommu xlate & cache).

But I worry of the impact on those silly adapters that set the coherent
mask to 32-bits to keep their microcode & descriptor ring down in 32-
bit space. I'm not sure how well ZONE_DMA32 behaves in those cases.

Cheers,
Ben.
