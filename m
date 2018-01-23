Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2018 14:20:41 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:47194 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992781AbeAWNUeeRMYJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Jan 2018 14:20:34 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5463B68C35; Tue, 23 Jan 2018 14:20:33 +0100 (CET)
Date:   Tue, 23 Jan 2018 14:20:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-pci@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 4/8] PCI: brcmstb: Add dma-range mapping for inbound
        traffic
Message-ID: <20180123132033.GA21438@lst.de>
References: <1516058925-46522-1-git-send-email-jim2101024@gmail.com> <1516058925-46522-5-git-send-email-jim2101024@gmail.com> <CAL_JsqKpWNJXNpKS5qC99N0+H_P37DcRE-rN9HFwT5tVmRFCNw@mail.gmail.com> <20180118073123.GA15766@lst.de> <EDAEFB0F-BB7C-444A-B282-F178F5ADFCBF@gmail.com> <20180118152331.GA24461@lst.de> <d62226a2-a92c-cdcb-4a9b-e69ab677bc60@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d62226a2-a92c-cdcb-4a9b-e69ab677bc60@broadcom.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62280
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

On Fri, Jan 19, 2018 at 11:47:54AM -0800, Florian Fainelli wrote:
> How can this work well in the context of a loadable module for instance?
> For MIPS, this would mean that we have to override phys_to_dma() and
> dma_to_phys() in the platform that is *susceptible* to use this PCIe
> controller (arch/mips/bmips) which is fine, but there, we essentially
> need to find a way to make this dynamic based on whether the PCIe
> controller is loaded or not.
> 
> As you might have seen from this patch, what needs to be done is highly
> dependent on the processor architecture and its memory controller
> physical memory map, so I don't see how we are in any better situation
> if we need to replicate 3 times across MIPS, ARM and ARM64 how the
> addresses need to be mangled.
> 
> Are you suggesting we somehow decouple the memory mangling part into a
> portion that can be built into the kernel image (so phys_to_dma() and
> dma_to_phys() is resolved at vmlinux link time) and can be selected by
> different architectures that need it? If so, yikes.

On architectures with crazy PCIe controllers (this seems to include
mips, arm, arm64 and x86 thanks to the weird SOCs) we will need a
a few different memory maps, yes.  Take a look at
arch/x86/pci/sta2x11-fixup.c, preferably from a tree where the worst
issues are fixed:

http://git.infradead.org/users/hch/misc.git/blob/refs/heads/dma-direct-all:/arch/x86/pci/sta2x11-fixup.c

Overriding phys_to_dma and dma_to_phys is required if you need to
support swiotlb, and chances are with a broken PCIe controller on
arm64 or mips64 you eventuall will.

This sta2x11 code should probably be lifted to common code in
one form or another eventually, althought it will need another
fair round of cleanups for now.

> I can see value in having a generic mechanism, ala X86_DMA_REMAP
> allowing architectures to have the ability to override phys_to_dma() and
> dma_to_phys() but right now, especially if we look at
> arch/x86/pci/sta2x11-fixup.c this really appears to be quite messy and
> equally ugly than stacking operations...
> 
> What is the actual problem you want to avoid with the stacking of DMA
> operations, is it because it becomes harder to audit, or are there are
> other reasons?

Audit, consolidate into a single dma-direct implementation and properly
support swiotlb out of the box.
