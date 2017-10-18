Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2017 08:53:27 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:53757 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990498AbdJRGxUjWUdI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Oct 2017 08:53:20 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id ECE9A68C40; Wed, 18 Oct 2017 08:53:16 +0200 (CEST)
Date:   Wed, 18 Oct 2017 08:53:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-mips@linux-mips.org, Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, linux-pci <linux-pci@vger.kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound
        traffic
Message-ID: <20171018065316.GA11183@lst.de>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com> <1507761269-7017-6-git-send-email-jim2101024@gmail.com> <589c04cb-061b-a453-3188-79324a02388e@arm.com> <20171017081422.GA19475@lst.de> <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60441
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

On Tue, Oct 17, 2017 at 12:11:55PM -0400, Jim Quinlan wrote:
> My understanding is that dma_pfn_offset is that it is a single
> constant offset from RAM, in our case, to map to PCIe space.

Yes.

> But in
> my commit message I detail how our PCIe controller presents memory
> with multiple regions with multiple different offsets. If an EP device
> maps to a region on the host memory, yes we can set the dma_pfn_offset
> for that device for that location within that range,.  But if the
> device then unmaps and allocates from another region with a different
> offset, it won't work.  If  I set dma_pfn_offset I have to assume that
> the device is using only one region of memory only, not more than one,
> and that it is not unmapping that region and mapping another (with a
> different offset).  Can I make those assumptions?

No, we can't make that assumption unfortunately.  But how is your
code going to work if the mapping spans multiple of your translation
regions?

Also I really don't think the stacking of dma_ops as in this patch
is a good idea.  For MIPS you should do the variant suggested in
the patch description and hook into dma_to_phys/phys_to_dma helpers,
and for ARM/ARM64 you should talk to the maintainers on how they
want the translation integrated.
