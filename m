Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Oct 2017 20:41:09 +0200 (CEST)
Received: from mail-wr0-x242.google.com ([IPv6:2a00:1450:400c:c0c::242]:50482
        "EHLO mail-wr0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991957AbdJYSlBXTdZr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Oct 2017 20:41:01 +0200
Received: by mail-wr0-x242.google.com with SMTP id p96so932529wrb.7
        for <linux-mips@linux-mips.org>; Wed, 25 Oct 2017 11:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=1JflFmNsnJ8qH88jwIrOFHgt100aMIr+53AxA7qHZLo=;
        b=QmG0jGca2kvGCRg4z1XntmV9YFqMZeROZaD3h00BS/9t8NRwomW4N7UfWO5fNxj9aT
         yqhscZ78FdOMcsXfWUr/6M5NtQ0n+K6vhzlYvmcJp4fZNhMl3Di4eGAt1Ow6/iRDZa5D
         FudbOFpNYdWcdTUNnbqi79Vd7hamci55QV0fQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=1JflFmNsnJ8qH88jwIrOFHgt100aMIr+53AxA7qHZLo=;
        b=gv5HlQEU+siNftt5Yo56YEheJm4Au6EAGeDaZj953/amdK+x4Sd7OYz30+bGSyyoOM
         f+0ZXGWVi19oKSOygBgFSjBaRvqHbdcgy0IMi0+nOcECsvdxS/ZmTMEYOR4DqdRUknZN
         dejJXD+KgmjJGTIGEkLo5U4bC+bKKNLpxzzwbyGHTgRrgjwSt6mlhkfKjWxt9eoTcoPt
         BRl50qpEJgvEC2XdR5IUL4LomLNASfkZeRBAZFJnhiBAzUv9eQTt5pWVF30MYoZOyOHx
         kfNs+hLC3TUL6t+ZVx+HV+ublT1tPu+NJfFoFLYs8SqsBnOOLZetfrP1yCZja+N7OwR+
         m5qg==
X-Gm-Message-State: AMCzsaWKbiM1nv+0ehQC48FIsnrZFastPKBPOjUUtCxg3m2QYECVAwFw
        kkjKsXVe9+noDhElXWm4lj3ulA==
X-Google-Smtp-Source: ABhQp+S1Y+YqWzINhQTrr09IYvXpS3dBeQcrnDLZvLfs03DlVeB1FlN3MfHDho6tSugbscZe6mpZnA==
X-Received: by 10.223.184.205 with SMTP id c13mr2879925wrg.268.1508956855805;
        Wed, 25 Oct 2017 11:40:55 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id j21sm91366wre.86.2017.10.25.11.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Oct 2017 11:40:54 -0700 (PDT)
Subject: Re: [PATCH 6/8] PCI: host: brcmstb: add MSI capability
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>
References: <1508868949-16652-1-git-send-email-jim2101024@gmail.com>
 <1508868949-16652-7-git-send-email-jim2101024@gmail.com>
 <5406ab92-c1da-f6fa-083d-82d1027130ea@gmail.com>
 <CANCKTBvAqu-godc03BiAt+9hxAoWABLVCtBzaA9ZWLJgXnQ3Fg@mail.gmail.com>
 <20171025172310.GN21840@bhelgaas-glaptop.roam.corp.google.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
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
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <3c0219a5-6b4d-b7e4-c2a4-83eba18ae06a@broadcom.com>
Date:   Wed, 25 Oct 2017 11:40:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20171025172310.GN21840@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <scott.branden@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: scott.branden@broadcom.com
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

Hi Bjorn,


On 17-10-25 10:23 AM, Bjorn Helgaas wrote:
> [+cc Ray, Scott, Jon]
>
> On Wed, Oct 25, 2017 at 11:28:07AM -0400, Jim Quinlan wrote:
>> On Tue, Oct 24, 2017 at 2:57 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>> Hi Jim,
>>>
>>> On 10/24/2017 11:15 AM, Jim Quinlan wrote:
>>>> This commit adds MSI to the Broadcom STB PCIe host controller. It does
>>>> not add MSIX since that functionality is not in the HW.  The MSI
>>>> controller is physically located within the PCIe block, however, there
>>>> is no reason why the MSI controller could not be moved elsewhere in
>>>> the future.
>>>>
>>>> Since the internal Brcmstb MSI controller is intertwined with the PCIe
>>>> controller, it is not its own platform device but rather part of the
>>>> PCIe platform device.
>>>>
>>>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>>>> ---
>>>>   drivers/pci/host/Kconfig           |  12 ++
>>>>   drivers/pci/host/Makefile          |   1 +
>>>>   drivers/pci/host/pci-brcmstb-msi.c | 318 +++++++++++++++++++++++++++++++++++++
>>>>   drivers/pci/host/pci-brcmstb.c     |  72 +++++++--
>>>>   drivers/pci/host/pci-brcmstb.h     |  26 +++
>>>>   5 files changed, 419 insertions(+), 10 deletions(-)
>>>>   create mode 100644 drivers/pci/host/pci-brcmstb-msi.c
>>>>
>>>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>>>> index b9b4f11..54aa5d2 100644
>>>> --- a/drivers/pci/host/Kconfig
>>>> +++ b/drivers/pci/host/Kconfig
>>>> @@ -228,4 +228,16 @@ config PCI_BRCMSTB
>>>>        default ARCH_BRCMSTB || BMIPS_GENERIC
>>>>        help
>>>>          Adds support for Broadcom Settop Box PCIe host controller.
>>>> +       To compile this driver as a module, choose m here.
>>>> +
>>>> +config PCI_BRCMSTB_MSI
>>>> +     bool "Broadcom Brcmstb PCIe MSI support"
>>>> +     depends on ARCH_BRCMSTB || BMIPS_GENERIC
>>> This could probably be depends on PCI_BRCMSTB, which would imply these
>>> two conditions. PCI_BRCMSTB_MSI on its own is probably not very useful
>>> without the parent RC driver.
>>>
>>>> +     depends on OF
>>>> +     depends on PCI_MSI
>>>> +     default PCI_BRCMSTB
>>>> +     help
>>>> +       Say Y here if you want to enable MSI support for Broadcom's iProc
>>>> +       PCIe controller
>>>> +
>>>>   endmenu
>>>> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
>>>> index c283321..1026d6f 100644
>>>> --- a/drivers/pci/host/Makefile
>>>> +++ b/drivers/pci/host/Makefile
>>>> @@ -23,6 +23,7 @@ obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
>>>>   obj-$(CONFIG_VMD) += vmd.o
>>>>   obj-$(CONFIG_PCI_BRCMSTB) += brcmstb-pci.o
>>>>   brcmstb-pci-objs := pci-brcmstb.o pci-brcmstb-dma.o
>>>> +obj-$(CONFIG_PCI_BRCMSTB_MSI) += pci-brcmstb-msi.o
>>> Should we combine this file with the brcmstb-pci.o? There is probably no
>>> functional difference, except that pci-brcmstb-msi.ko needs to be loaded
>>> first, right?
>>> --
>>> Florian
>> If you look at the pci/host/Kconfig you will see that other drivers
>> also have a separate MSI config (eg iproc, altera, xgene) so there is
>> precedent.  The reason that pci-brcmstb-msi.c is its own file is
>> because it depends on an irq function that is not exported.  That is
>> why CONFIG_PCI_BRCMSTB_MSI is bool, and CONFIG_PCI_BRCMSTB is
>> tristate.  -- Jim
> There is precedent, but that doesn't mean I like it :)
> I would strongly prefer one file per driver when possible.
>
> Take iproc for example.  iproc-msi.c is enabled by a Kconfig bool.  It
> contains a bunch of code with the only external entry points being
> iproc_msi_init() and iproc_msi_exit().  These are only called via
> iproc_pcie_bcma_probe() or iproc_pcie_pltfm_probe(), both of which are
> tristate.  So iproc-msi.c is only compiled if CONFIG_IPROC_BCMA or
> CONFIG_IPROC_PLATFORM are enabled, but all that text is loaded even if
> neither module is loaded, which seems suboptimal.
>
> I don't care if you have several config options to enable the BCMA
> probe and the platform probe (although these could probably be
> replaced in the code by a simple "#ifdef CONFIG_BCMA" and "#ifdef
> CONFIG_OF"), and making CONFIG_PCIE_IPROC tristate so it can be a
> module makes sense.  But I think it would be better to put all the
> code in one file instead of five, and probably remove
> CONFIG_PCIE_IPROC_MSI.  Maybe this requires exporting some IRQ
> function that currently isn't exported.  But that seems like a simpler
> solution than what we currently have.
Placing pcie-iproc-bcma.c in its own file is useful in being able to 
read the code that is actually used.  BCMA is really unnecessary if a 
few platforms stopped using BCMA and declared everything via devicetree 
or ACPI.  Same with pcie-iproc-platform.c.  Both keep the mess out of 
pcie-iproc.c.

It looks like pcie-iproc-msi.c followed existing pci drivers in place.  
So if msi was cleaned up through the entire pci drivers then yes it 
would make sense to remove CONFIG_PCIE_IPROC_MSI and combine code in 
pcie-iproc.c.  But I think leaving the bcma and platform code in their 
own files makes it easier for us to work with the code rather than 
placing unused code in ifdefs in the same file.
>
> Bjorn
Regards,
Scott
