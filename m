Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Dec 2017 18:14:15 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:35762 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991685AbdLOROH4iTpR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Dec 2017 18:14:07 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8E011435;
        Fri, 15 Dec 2017 09:14:00 -0800 (PST)
Received: from red-moon (unknown [10.1.206.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31DEB3F318;
        Fri, 15 Dec 2017 09:13:57 -0800 (PST)
Date:   Fri, 15 Dec 2017 17:14:40 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/8] SOC: brcmstb: add memory API
Message-ID: <20171215171440.GB32131@red-moon>
References: <1510697532-32828-1-git-send-email-jim2101024@gmail.com>
 <1510697532-32828-2-git-send-email-jim2101024@gmail.com>
 <20171205205926.GJ23510@bhelgaas-glaptop.roam.corp.google.com>
 <CANCKTBvoXpF-H8Pck5TsH+7tNM=di1-uoedqACE+kjNEAUodYg@mail.gmail.com>
 <20171212211404.GA95453@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171212211404.GA95453@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <lorenzo.pieralisi@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lorenzo.pieralisi@arm.com
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

On Tue, Dec 12, 2017 at 03:14:04PM -0600, Bjorn Helgaas wrote:
> [+cc Lorenzo]
> 
> On Tue, Dec 12, 2017 at 03:53:28PM -0500, Jim Quinlan wrote:
> > On Tue, Dec 5, 2017 at 3:59 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Tue, Nov 14, 2017 at 05:12:05PM -0500, Jim Quinlan wrote:
> > >> From: Florian Fainelli <f.fainelli@gmail.com>
> > >>
> > >> This commit adds a memory API suitable for ascertaining the sizes of
> > >> each of the N memory controllers in a Broadcom STB chip.  Its first
> > >> user will be the Broadcom STB PCIe root complex driver, which needs
> > >> to know these sizes to properly set up DMA mappings for inbound
> > >> regions.
> > >>
> > >> We cannot use memblock here or anything like what Linux provides
> > >> because it collapses adjacent regions within a larger block, and here
> > >> we actually need per-memory controller addresses and sizes, which is
> > >> why we resort to manual DT parsing.
> > >>
> > >> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > >> ---
> > >>  drivers/soc/bcm/brcmstb/Makefile |   2 +-
> > >>  drivers/soc/bcm/brcmstb/memory.c | 172 +++++++++++++++++++++++++++++++++++++++
> > >>  include/soc/brcmstb/memory_api.h |  25 ++++++
> > >>  3 files changed, 198 insertions(+), 1 deletion(-)
> > >>  create mode 100644 drivers/soc/bcm/brcmstb/memory.c
> > >>  create mode 100644 include/soc/brcmstb/memory_api.h
> > >>
> > >> diff --git a/drivers/soc/bcm/brcmstb/Makefile b/drivers/soc/bcm/brcmstb/Makefile
> > >> index 9120b27..4cea7b6 100644
> > >> --- a/drivers/soc/bcm/brcmstb/Makefile
> > >> +++ b/drivers/soc/bcm/brcmstb/Makefile
> > >> @@ -1 +1 @@
> > >> -obj-y                                += common.o biuctrl.o
> > >> +obj-y                                += common.o biuctrl.o memory.o
> > >> diff --git a/drivers/soc/bcm/brcmstb/memory.c b/drivers/soc/bcm/brcmstb/memory.c
> > >> new file mode 100644
> > >> index 0000000..eb647ad9
> > >> --- /dev/null
> > >> +++ b/drivers/soc/bcm/brcmstb/memory.c
> > >
> > > I sort of assume based on [1] that every new file should have an SPDX
> > > identifier ("The Linux kernel requires the precise SPDX identifier in
> > > all source files") and that the actual text of the GPL can be omitted.
> > >
> > > Only a few files in drivers/pci currently have an SPDX identifier.  I
> > > don't know if that's oversight or work-in-progress or what.
> > >
> > > [1] https://lkml.kernel.org/r/20171204212120.484179273@linutronix.de
> > >
> > 
> > Bjorn, Did you get a chance to review the other commits of this
> > submission (V3)?  I would like any additional feedback before I send
> > out a V4 with SPDX fixes.  Thanks, JimQ
> 
> Lorenzo is taking over drivers/pci/host/* and he'll no doubt have some
> comments when he gets to this.  I'll point out a few quick formatting
> things in the meantime.

I need some time to review the code but overall I am quite worried about
patches 1 and 4 in particular, it is ok to have platform host bridge
drivers but we can't rewrite a DMA layer for a specific host bridge, I
really do not like that - it is just not manageable from a maintenance
perspective for the mainline kernel.

Lorenzo
