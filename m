Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Dec 2017 21:14:54 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:37978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992176AbdLOUOqwA1a- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Dec 2017 21:14:46 +0100
Received: from localhost (unknown [69.71.4.159])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B535620C0F;
        Fri, 15 Dec 2017 20:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B535620C0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date:   Fri, 15 Dec 2017 14:14:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH v3 3/8] PCI: brcmstb: Add Broadcom STB PCIe host
 controller driver
Message-ID: <20171215201434.GY30595@bhelgaas-glaptop.roam.corp.google.com>
References: <1510697532-32828-1-git-send-email-jim2101024@gmail.com>
 <1510697532-32828-4-git-send-email-jim2101024@gmail.com>
 <20171212221642.GB95453@bhelgaas-glaptop.roam.corp.google.com>
 <CANCKTBvtqNWZYXpLdUnEWwA2=14XhJ6adR5muOAYubY_1SxZWw@mail.gmail.com>
 <20171214225133.GM30595@bhelgaas-glaptop.roam.corp.google.com>
 <CANCKTBvFhHb57JdG01aiSypBAcUeLzY3Dhuh5xP-_F5k_NcAhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANCKTBvFhHb57JdG01aiSypBAcUeLzY3Dhuh5xP-_F5k_NcAhA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <helgaas@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: helgaas@kernel.org
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

On Fri, Dec 15, 2017 at 02:53:57PM -0500, Jim Quinlan wrote:
> On Thu, Dec 14, 2017 at 5:51 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Dec 13, 2017 at 06:53:53PM -0500, Jim Quinlan wrote:
> >> On Tue, Dec 12, 2017 at 5:16 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >> > On Tue, Nov 14, 2017 at 05:12:07PM -0500, Jim Quinlan wrote:
> >> >> This commit adds the basic Broadcom STB PCIe controller.  Missing is
> >> >> the ability to process MSI and also handle dma-ranges for inbound
> >> >> memory accesses.  These two functionalities are added in subsequent
> >> >> commits.
> >> >>
> >> >> The PCIe block contains an MDIO interface.  This is a local interface
> >> >> only accessible by the PCIe controller.  It cannot be used or shared
> >> >> by any other HW.  As such, the small amount of code for this
> >> >> controller is included in this driver as there is little upside to put
> >> >> it elsewhere.
> >> ...
> >
> >> >> +static bool brcm_pcie_valid_device(struct brcm_pcie *pcie, struct pci_bus *bus,
> >> >> +                                int dev)
> >> >> +{
> >> >> +     if (pci_is_root_bus(bus)) {
> >> >> +             if (dev > 0)
> >> >> +                     return false;
> >> >> +     } else {
> >> >> +             /* If there is no link, then there is no device */
> >> >> +             if (!brcm_pcie_link_up(pcie))
> >> >> +                     return false;
> >> >
> >> > This is racy, since the link can go down after you check but before
> >> > you do the config access.  I assume your hardware can deal with a
> >> > config access that targets a link that is down?
> >>
> >> Yes, that can happen but there is really nothing that can be done if
> >> the link goes down in that vulnerability window.  What do you suggest
> >> doing?
> >
> > Most hardware drops writes and returns ~0 on reads if the link is
> > down.  I assume your hardware does something similar, and that should
> > be enough.  You shouldn't have to check whether the link is up.
> Unfortunately our HW is quite unforgiving and effects a synchronous or
> asynchronous abort when doing a config access when the link or power
> has gone down on the EP.  I will open a discussion with the PCIe HW
> folks regarding why our controller does not behave like "most
> hardware".  Thanks, Jim

I mentioned in the other thread [1] that I think the best way to
handle this is to figure out how to deal with the abort cleanly.
Using a test like *_pcie_link_up() to try to avoid it is a 99%
solution that means we'll see rare failures that are very difficult to
reproduce and debug.

> > The hardware might report errors, e.g., via AER, if the link is down.
> > And we might not not handle those nicely.  If we have issues there, we
> > should find out and fix them.

[1] https://lkml.kernel.org/r/20171214225821.GN30595@bhelgaas-glaptop.roam.corp.google.com
