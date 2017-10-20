Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Oct 2017 18:17:26 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:39469 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992181AbdJTQRTi09ZJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Oct 2017 18:17:19 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3BFE77FC80; Fri, 20 Oct 2017 18:17:19 +0200 (CEST)
Date:   Fri, 20 Oct 2017 18:17:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
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
Message-ID: <20171020161719.GA6247@lst.de>
References: <20171017081422.GA19475@lst.de> <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com> <20171018065316.GA11183@lst.de> <CANCKTBv+yiCNsrnx3m+W9wPqC4NdKPZ2p=zLtSa8fX6v1rPcYQ@mail.gmail.com> <20171019091644.GA14983@lst.de> <CANCKTBuaTD29My77QfOeUmtZfLAmmJXUYe6QvBW+uoH2Kb+tAQ@mail.gmail.com> <20171020073730.GA12937@lst.de> <CANCKTBsRRkwNMrxWjtgxbyZqT6NOxPX0NHDbnEO2BMjj8oVtpg@mail.gmail.com> <20171020145752.GA4694@lst.de> <CANCKTBtxp9gSdndKAZ7xGA+VozQsn2PX_-9P8A22_5Matbb7-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANCKTBtxp9gSdndKAZ7xGA+VozQsn2PX_-9P8A22_5Matbb7-w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60510
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

On Fri, Oct 20, 2017 at 11:27:41AM -0400, Jim Quinlan wrote:
>       memc0-a@[        0....3fffefff] <=> pci@[        0....3fffefff]
>       memc0-b@[100000000...13fffefff] <=> pci@[ 40000000....7fffefff]
>       memc1-a@[ 40000000....7fffefff] <=> pci@[ 80000000....bfffefff]
>       memc1-b@[300000000...33fffefff] <=> pci@[ c0000000....ffffefff]
>       memc2-a@[ 80000000....bfffefff] <=> pci@[100000000...13fffefff]
>       memc2-b@[c00000000...c3fffffff] <=> pci@[140000000...17fffffff]
> 
> This leaves a one-page gap between phsyical memory regions which would
> normally be contiguous. One cannot have a dma alloc that spans any two
> regions.  This is a drastic step, but I don't see an alternative.
> Perhaps  I may be missing what you are saying...

Ok, IFF we are guranteed to always have a gap between physical memory
locations we are fine indeed.
