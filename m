Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Oct 2017 23:11:30 +0200 (CEST)
Received: from mail-io0-x242.google.com ([IPv6:2607:f8b0:4001:c06::242]:51701
        "EHLO mail-io0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990511AbdJYVLX0d0jc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Oct 2017 23:11:23 +0200
Received: by mail-io0-x242.google.com with SMTP id b186so2496727iof.8;
        Wed, 25 Oct 2017 14:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=numCSL22TqwfSeqEEoe2n3nPWgF5IYZzAFSZ77sJ25w=;
        b=JqBi6je5w4tIyMw0spQq+sshPCipIWMfU6rKYJcpvPoiicrKAqKOBCbp4+c2JYi6HF
         0w5FT18MtY2NkcrAzCFGxqRrPEdyV/40KNQ/i4C+ZXRVG4ddhPnk3NN7wwWRnp+z9M0k
         aakDI+bV5NVsWSnm2RDxmKZag7Vg7aPfZxZ6FNj/ibRHW/vHqkkac14ktChLWT+YQd6r
         zzCOSJZMUK2Kc6x0dqMqEd2FVdbrym1IzZqX0VsBRp/etm2w1oZg2gqa7H0DjGvWfDGn
         db9etfpmEzZDPMKMH3lCITP/TBrqlhvkM/kMPChAvxMHLcIZ1cPrO1tOoDikSVRKNMDE
         ruOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=numCSL22TqwfSeqEEoe2n3nPWgF5IYZzAFSZ77sJ25w=;
        b=mBOw5I6Sx9fYPKboEPTI3mTjTFAjd+3E9TLqfCHKBvj21/EIdkzdpm+fW1jZLQZCMR
         dr31U39T20Kq3tWRgQ5jWfOT0h5oKqommwRd3v4RMCqtUpoeJpjCATzqbUu/E6o5KWq/
         82cBec766mHYxTcO1BzMkrscZx1YuvqFtzKUFVzcBvHQThrmVcfYEOyS4Y5StHSfmJws
         5MhB8/xc+KuCD48hiwuT9SlRq3SjPXtScjK4zIPPzHAHFvB9Vdwf4B59jZBzlDmOQl2A
         lk/txDLtqmOZ5q0d88K/GWPUyHcWw8o2TOitEQuj7B/b+2/DdawmzgJmquf+hVbNWWJt
         foVA==
X-Gm-Message-State: AMCzsaUG4YDt/tSf0nnZQbfzKBxUNF+Z5qgs2d0sHMQ5NoJqxMym1Pas
        e7GCu8KgD+MaOqU6CA96sY42W2QpyapksNBki7A=
X-Google-Smtp-Source: ABhQp+QSbT+Yja3XOruGB37aELxhGUfeOAA7PswLYA22ZLgOnm5TLFWLrqkIpafEQWnQe67Sw1Xew9cQg3kYA6MaBBQ=
X-Received: by 10.107.140.9 with SMTP id o9mr28013949iod.93.1508965876917;
 Wed, 25 Oct 2017 14:11:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.47.156 with HTTP; Wed, 25 Oct 2017 14:11:16 -0700 (PDT)
In-Reply-To: <20171025201619.GO21840@bhelgaas-glaptop.roam.corp.google.com>
References: <1508868949-16652-1-git-send-email-jim2101024@gmail.com>
 <1508868949-16652-7-git-send-email-jim2101024@gmail.com> <5406ab92-c1da-f6fa-083d-82d1027130ea@gmail.com>
 <CANCKTBvAqu-godc03BiAt+9hxAoWABLVCtBzaA9ZWLJgXnQ3Fg@mail.gmail.com>
 <20171025172310.GN21840@bhelgaas-glaptop.roam.corp.google.com>
 <3c0219a5-6b4d-b7e4-c2a4-83eba18ae06a@broadcom.com> <20171025201619.GO21840@bhelgaas-glaptop.roam.corp.google.com>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Wed, 25 Oct 2017 17:11:16 -0400
Message-ID: <CANCKTBsdcFSAASaOcXA0h3eYfq-UnF0UciTXex=F86d6E7E6CQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] PCI: host: brcmstb: add MSI capability
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
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

On Wed, Oct 25, 2017 at 4:16 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Wed, Oct 25, 2017 at 11:40:47AM -0700, Scott Branden wrote:
>> Hi Bjorn,
>>
>>
>> On 17-10-25 10:23 AM, Bjorn Helgaas wrote:
>> >[+cc Ray, Scott, Jon]
>> >
>> >On Wed, Oct 25, 2017 at 11:28:07AM -0400, Jim Quinlan wrote:
>> >>On Tue, Oct 24, 2017 at 2:57 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> >>>Hi Jim,
>> >>>
>> >>>On 10/24/2017 11:15 AM, Jim Quinlan wrote:
>> >>>>This commit adds MSI to the Broadcom STB PCIe host controller. It does
>> >>>>not add MSIX since that functionality is not in the HW.  The MSI
>> >>>>controller is physically located within the PCIe block, however, there
>> >>>>is no reason why the MSI controller could not be moved elsewhere in
>> >>>>the future.
>> >>>>
>> >>>>Since the internal Brcmstb MSI controller is intertwined with the PCIe
>> >>>>controller, it is not its own platform device but rather part of the
>> >>>>PCIe platform device.
>> >>>>
>> >>>>Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>> >>>>---
>> >>>>  drivers/pci/host/Kconfig           |  12 ++
>> >>>>  drivers/pci/host/Makefile          |   1 +
>> >>>>  drivers/pci/host/pci-brcmstb-msi.c | 318 +++++++++++++++++++++++++++++++++++++
>> >>>>  drivers/pci/host/pci-brcmstb.c     |  72 +++++++--
>> >>>>  drivers/pci/host/pci-brcmstb.h     |  26 +++
>> >>>>  5 files changed, 419 insertions(+), 10 deletions(-)
>> >>>>  create mode 100644 drivers/pci/host/pci-brcmstb-msi.c
>> >>>>
>> >>>>diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>> >>>>index b9b4f11..54aa5d2 100644
>> >>>>--- a/drivers/pci/host/Kconfig
>> >>>>+++ b/drivers/pci/host/Kconfig
>> >>>>@@ -228,4 +228,16 @@ config PCI_BRCMSTB
>> >>>>       default ARCH_BRCMSTB || BMIPS_GENERIC
>> >>>>       help
>> >>>>         Adds support for Broadcom Settop Box PCIe host controller.
>> >>>>+       To compile this driver as a module, choose m here.
>> >>>>+
>> >>>>+config PCI_BRCMSTB_MSI
>> >>>>+     bool "Broadcom Brcmstb PCIe MSI support"
>> >>>>+     depends on ARCH_BRCMSTB || BMIPS_GENERIC
>> >>>This could probably be depends on PCI_BRCMSTB, which would imply these
>> >>>two conditions. PCI_BRCMSTB_MSI on its own is probably not very useful
>> >>>without the parent RC driver.
>> >>>
>> >>>>+     depends on OF
>> >>>>+     depends on PCI_MSI
>> >>>>+     default PCI_BRCMSTB
>> >>>>+     help
>> >>>>+       Say Y here if you want to enable MSI support for Broadcom's iProc
>> >>>>+       PCIe controller
>> >>>>+
>> >>>>  endmenu
>> >>>>diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
>> >>>>index c283321..1026d6f 100644
>> >>>>--- a/drivers/pci/host/Makefile
>> >>>>+++ b/drivers/pci/host/Makefile
>> >>>>@@ -23,6 +23,7 @@ obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
>> >>>>  obj-$(CONFIG_VMD) += vmd.o
>> >>>>  obj-$(CONFIG_PCI_BRCMSTB) += brcmstb-pci.o
>> >>>>  brcmstb-pci-objs := pci-brcmstb.o pci-brcmstb-dma.o
>> >>>>+obj-$(CONFIG_PCI_BRCMSTB_MSI) += pci-brcmstb-msi.o
>> >>>Should we combine this file with the brcmstb-pci.o? There is probably no
>> >>>functional difference, except that pci-brcmstb-msi.ko needs to be loaded
>> >>>first, right?
>> >>>--
>> >>>Florian
>> >>If you look at the pci/host/Kconfig you will see that other drivers
>> >>also have a separate MSI config (eg iproc, altera, xgene) so there is
>> >>precedent.  The reason that pci-brcmstb-msi.c is its own file is
>> >>because it depends on an irq function that is not exported.  That is
>> >>why CONFIG_PCI_BRCMSTB_MSI is bool, and CONFIG_PCI_BRCMSTB is
>> >>tristate.  -- Jim
>> >There is precedent, but that doesn't mean I like it :)
>> >I would strongly prefer one file per driver when possible.
>> >
>> >Take iproc for example.  iproc-msi.c is enabled by a Kconfig bool.  It
>> >contains a bunch of code with the only external entry points being
>> >iproc_msi_init() and iproc_msi_exit().  These are only called via
>> >iproc_pcie_bcma_probe() or iproc_pcie_pltfm_probe(), both of which are
>> >tristate.  So iproc-msi.c is only compiled if CONFIG_IPROC_BCMA or
>> >CONFIG_IPROC_PLATFORM are enabled, but all that text is loaded even if
>> >neither module is loaded, which seems suboptimal.
>> >
>> >I don't care if you have several config options to enable the BCMA
>> >probe and the platform probe (although these could probably be
>> >replaced in the code by a simple "#ifdef CONFIG_BCMA" and "#ifdef
>> >CONFIG_OF"), and making CONFIG_PCIE_IPROC tristate so it can be a
>> >module makes sense.  But I think it would be better to put all the
>> >code in one file instead of five, and probably remove
>> >CONFIG_PCIE_IPROC_MSI.  Maybe this requires exporting some IRQ
>> >function that currently isn't exported.  But that seems like a simpler
>> >solution than what we currently have.
>> Placing pcie-iproc-bcma.c in its own file is useful in being able to
>> read the code that is actually used.  BCMA is really unnecessary if
>> a few platforms stopped using BCMA and declared everything via
>> devicetree or ACPI.  Same with pcie-iproc-platform.c.  Both keep the
>> mess out of pcie-iproc.c.
>
> Maybe.  Both pcie-iproc-bcma.c and pcie-iproc-platform.c are small
> (280 lines combined) relative to pcie-iproc.c + pcie-iproc-msi.c (2150
> lines combined), and keeping them separate requires pcie-iproc.h,
> which could otherwise be folded into pcie-iproc.c.  So I'm still a
> little skeptical.  You think of combining them as a mess, but I think
> of it as a big convenience because I could see all the iproc-related
> code in one place :)
>
>> It looks like pcie-iproc-msi.c followed existing pci drivers in
>> place.  So if msi was cleaned up through the entire pci drivers then
>> yes it would make sense to remove CONFIG_PCIE_IPROC_MSI and combine
>> code in pcie-iproc.c.  But I think leaving the bcma and platform
>> code in their own files makes it easier for us to work with the code
>> rather than placing unused code in ifdefs in the same file.
>
> But I do object *more* to putting MSI in a separate file, especially
> given the fact that all PCIe devices that generate interrupts must
> support MSI.  So any reasonable PCIe root complex must also support
> MSI, and I don't really see the benefit of configuring and building it
> separately.
>
> Anyway, iproc is already in the tree, and we *could* maybe change
> something eventually.
>
> The question we need to decide now is about how brcmstb should be
> structured.  Somebody mentioned an IRQ function that would have to be
> exported for the brcmstb main driver & MSI pieces to be combined.  I
> don't know what specifically that is, but I thought maybe iproc had
> the same issue.
I was one the one who said an export was needed but I just recompiled
the MSI code as a module and had no problem.  I was probably using an
older tree when I concluded this.  So I'm fine with combining the MSI
code in the same file as the driver.

>
> Bjorn
