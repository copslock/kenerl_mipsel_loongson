Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 11:16:56 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:59634 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990414AbdJSJQuC56VX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Oct 2017 11:16:50 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E7D99DE7AB; Thu, 19 Oct 2017 11:16:44 +0200 (CEST)
Date:   Thu, 19 Oct 2017 11:16:44 +0200
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
Message-ID: <20171019091644.GA14983@lst.de>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com> <1507761269-7017-6-git-send-email-jim2101024@gmail.com> <589c04cb-061b-a453-3188-79324a02388e@arm.com> <20171017081422.GA19475@lst.de> <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com> <20171018065316.GA11183@lst.de> <CANCKTBv+yiCNsrnx3m+W9wPqC4NdKPZ2p=zLtSa8fX6v1rPcYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANCKTBv+yiCNsrnx3m+W9wPqC4NdKPZ2p=zLtSa8fX6v1rPcYQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60457
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

On Wed, Oct 18, 2017 at 10:41:17AM -0400, Jim Quinlan wrote:
> That's what brcm_to_{pci,cpu} are for -- they keep a list of the
> dma-ranges given in the PCIe DT node, and translate from system memory
> addresses to pci-space addresses, and vice versa.  As long as people
> are using the DMA API it should work.  It works for all of the ARM,
> ARM64, and MIPS Broadcom systems I've tested, using eight different EP
> devices.  Note that I am not thrilled to be advocating this mechanism
> but it seemed the best alternative.

Say we are using your original example ranges:

 memc0-a@[        0....3fffffff] <=> pci@[        0....3fffffff]
 memc0-b@[100000000...13fffffff] <=> pci@[ 40000000....7fffffff]
 memc1-a@[ 40000000....7fffffff] <=> pci@[ 80000000....bfffffff]
 memc1-b@[300000000...33fffffff] <=> pci@[ c0000000....ffffffff]
 memc2-a@[ 80000000....bfffffff] <=> pci@[100000000...13fffffff]
 memc2-b@[c00000000...c3fffffff] <=> pci@[140000000...17fffffff]

and now you get a dma mapping request for physical addresses
3fffff00 to 4000000f, which would span two of your ranges.  How
is this going to work?

> I would prefer that the same code work for all three architectures.
> What I would like from ARM/ARM64 is the ability to override
> phys_to_dma() and dma_to_phys(); I thought the chances of that being
> accepted would be slim.  But you are right, I should ask the
> maintainers.

It is still better than trying to stack dma ops, which is a receipe
for problems down the road.
