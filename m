Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2018 08:31:34 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:50311 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990425AbeARHbXzEMkU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Jan 2018 08:31:23 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1F36068DB6; Thu, 18 Jan 2018 08:31:23 +0100 (CET)
Date:   Thu, 18 Jan 2018 08:31:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
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
Message-ID: <20180118073123.GA15766@lst.de>
References: <1516058925-46522-1-git-send-email-jim2101024@gmail.com> <1516058925-46522-5-git-send-email-jim2101024@gmail.com> <CAL_JsqKpWNJXNpKS5qC99N0+H_P37DcRE-rN9HFwT5tVmRFCNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKpWNJXNpKS5qC99N0+H_P37DcRE-rN9HFwT5tVmRFCNw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62231
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

On Wed, Jan 17, 2018 at 08:15:33PM -0600, Rob Herring wrote:
> > (a) overriding/redefining the dma_to_phys() and phys_to_dma() calls
> > that are used by the dma_ops routines.  This is the approach of
> >
> >         arch/mips/cavium-octeon/dma-octeon.c
> 
> MIPS is rarely an example to follow. :)

But in this case it actually is the example to follow as told previously.

NAK again for these chained dma ops that only create problems.
