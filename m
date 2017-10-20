Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Oct 2017 09:37:40 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:37040 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990421AbdJTHhcSkzAj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Oct 2017 09:37:32 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7290C7FC76; Fri, 20 Oct 2017 09:37:30 +0200 (CEST)
Date:   Fri, 20 Oct 2017 09:37:30 +0200
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
Message-ID: <20171020073730.GA12937@lst.de>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com> <1507761269-7017-6-git-send-email-jim2101024@gmail.com> <589c04cb-061b-a453-3188-79324a02388e@arm.com> <20171017081422.GA19475@lst.de> <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com> <20171018065316.GA11183@lst.de> <CANCKTBv+yiCNsrnx3m+W9wPqC4NdKPZ2p=zLtSa8fX6v1rPcYQ@mail.gmail.com> <20171019091644.GA14983@lst.de> <CANCKTBuaTD29My77QfOeUmtZfLAmmJXUYe6QvBW+uoH2Kb+tAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANCKTBuaTD29My77QfOeUmtZfLAmmJXUYe6QvBW+uoH2Kb+tAQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60492
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

On Thu, Oct 19, 2017 at 06:47:45PM -0400, Jim Quinlan wrote:
> The only way to prevent this is to reserve a single page at the end of
> the first memory region of any pair that are adjacent in physical
> memory.  A hack, yes, but I don't see an easier way out of this.  Many
> if not most of our boards do not have adjacent regions and would not
> need this.

dma mappings can be much larger than a single page.  For the block
world take a look at __blk_segment_map_sg which does the merging
of contiguous pages into a single SG segment.  You'd have to override
BIOVEC_PHYS_MERGEABLE to prevent this from happening in your supported
architectures for the block layer.
