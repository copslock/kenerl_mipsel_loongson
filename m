Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Oct 2017 17:28:22 +0200 (CEST)
Received: from mail-it0-x244.google.com ([IPv6:2607:f8b0:4001:c0b::244]:51935
        "EHLO mail-it0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991025AbdJYP2Omaatp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Oct 2017 17:28:14 +0200
Received: by mail-it0-x244.google.com with SMTP id o135so1495453itb.0;
        Wed, 25 Oct 2017 08:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d+eyASIOrMB+fYDHTPqZJ4TD1SzqWh0CiGggAe7Zr9E=;
        b=XqWMTQhZD5tD3hMGUjj/VPXPWnzCIhVkjVBYG5ABjA9PjDKrwlFmxt3b7gSLpWSJil
         lE/9qR9iAifbfruBQxiiSkNOEgvksq1XbjacIHKErG2/XwEq8nIaBiyYI1XhnuubMiHI
         S7QecaM2umpL/AESZtMYlji4Ft88RgbGL/sLhBkbBIWuk3an9NKwlEfw88rBcS52/urR
         uKi5yktSbmIgqlYE0gfzHSooSFV56fnGIwi4XUkgPY2oorFO+3jIccjuSpyPtCxj/ZKL
         8iU2L+Otc5mbOru4GLhNewgdlHPpzqO2SGF1zugjSLVs3KhoyisW6YzgJbCl1jSZ4QKU
         dFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d+eyASIOrMB+fYDHTPqZJ4TD1SzqWh0CiGggAe7Zr9E=;
        b=pb/0V5ybwNCY5tjAwH4lyvJ4862cche69sUp2b4NOLTR6fZ/8IUFrzBuhqGJfJaYKR
         aXozrKOtfPhmW1sWHyuOYIaG/qIy37w9kYmlyKn1FTmLvGpj8ZY9yIO5nq2eB5/KH2+f
         CD/ie4woWWtjuSp/vUuhu81+fwa6bs4cQQYAEI2OcqAPjue8zWP9cen8ymEGuxRAlB2w
         /RoeOQXg813aN+2wqIgF8Z2Q1+acOWQAKsNFvTxDN2a0bzNR/PoOdf8z5XwvDh8EVfmp
         RN7xSiq/X9CNKBF5hinAbPIri2zPf9/8sNn4jIPIxX/M/LMQixbNxspG5RfqAwX7S9xf
         neng==
X-Gm-Message-State: AMCzsaVDi1nlwFKAbNpakUxe5gxPu1e8HfxnaazsSYb2IWD08CT2grKt
        ZrYFu6UYAJ3GjqWBnY0mSCJVF1hSkAjgtme+VRY=
X-Google-Smtp-Source: ABhQp+QF6r6JFAvl5H8HDeMUg6KaFgjPazp/COV/tUGeY2tPBgXHT5aVkXXRZpo88fLnj5XkBlniQqeufSg6J4QI4Zw=
X-Received: by 10.36.135.202 with SMTP id f193mr2537855ite.47.1508945288319;
 Wed, 25 Oct 2017 08:28:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.47.156 with HTTP; Wed, 25 Oct 2017 08:28:07 -0700 (PDT)
In-Reply-To: <5406ab92-c1da-f6fa-083d-82d1027130ea@gmail.com>
References: <1508868949-16652-1-git-send-email-jim2101024@gmail.com>
 <1508868949-16652-7-git-send-email-jim2101024@gmail.com> <5406ab92-c1da-f6fa-083d-82d1027130ea@gmail.com>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Wed, 25 Oct 2017 11:28:07 -0400
Message-ID: <CANCKTBvAqu-godc03BiAt+9hxAoWABLVCtBzaA9ZWLJgXnQ3Fg@mail.gmail.com>
Subject: Re: [PATCH 6/8] PCI: host: brcmstb: add MSI capability
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60553
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

On Tue, Oct 24, 2017 at 2:57 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Hi Jim,
>
> On 10/24/2017 11:15 AM, Jim Quinlan wrote:
>> This commit adds MSI to the Broadcom STB PCIe host controller. It does
>> not add MSIX since that functionality is not in the HW.  The MSI
>> controller is physically located within the PCIe block, however, there
>> is no reason why the MSI controller could not be moved elsewhere in
>> the future.
>>
>> Since the internal Brcmstb MSI controller is intertwined with the PCIe
>> controller, it is not its own platform device but rather part of the
>> PCIe platform device.
>>
>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>> ---
>>  drivers/pci/host/Kconfig           |  12 ++
>>  drivers/pci/host/Makefile          |   1 +
>>  drivers/pci/host/pci-brcmstb-msi.c | 318 +++++++++++++++++++++++++++++++++++++
>>  drivers/pci/host/pci-brcmstb.c     |  72 +++++++--
>>  drivers/pci/host/pci-brcmstb.h     |  26 +++
>>  5 files changed, 419 insertions(+), 10 deletions(-)
>>  create mode 100644 drivers/pci/host/pci-brcmstb-msi.c
>>
>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>> index b9b4f11..54aa5d2 100644
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>> @@ -228,4 +228,16 @@ config PCI_BRCMSTB
>>       default ARCH_BRCMSTB || BMIPS_GENERIC
>>       help
>>         Adds support for Broadcom Settop Box PCIe host controller.
>> +       To compile this driver as a module, choose m here.
>> +
>> +config PCI_BRCMSTB_MSI
>> +     bool "Broadcom Brcmstb PCIe MSI support"
>> +     depends on ARCH_BRCMSTB || BMIPS_GENERIC
>
> This could probably be depends on PCI_BRCMSTB, which would imply these
> two conditions. PCI_BRCMSTB_MSI on its own is probably not very useful
> without the parent RC driver.
>
>> +     depends on OF
>> +     depends on PCI_MSI
>> +     default PCI_BRCMSTB
>> +     help
>> +       Say Y here if you want to enable MSI support for Broadcom's iProc
>> +       PCIe controller
>> +
>>  endmenu
>> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
>> index c283321..1026d6f 100644
>> --- a/drivers/pci/host/Makefile
>> +++ b/drivers/pci/host/Makefile
>> @@ -23,6 +23,7 @@ obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
>>  obj-$(CONFIG_VMD) += vmd.o
>>  obj-$(CONFIG_PCI_BRCMSTB) += brcmstb-pci.o
>>  brcmstb-pci-objs := pci-brcmstb.o pci-brcmstb-dma.o
>> +obj-$(CONFIG_PCI_BRCMSTB_MSI) += pci-brcmstb-msi.o
>
> Should we combine this file with the brcmstb-pci.o? There is probably no
> functional difference, except that pci-brcmstb-msi.ko needs to be loaded
> first, right?
> --
> Florian

If you look at the pci/host/Kconfig you will see that other drivers
also have a separate MSI config (eg iproc, altera, xgene) so there is
precedent.  The reason that pci-brcmstb-msi.c is its own file is
because it depends on an irq function that is not exported.  That is
why CONFIG_PCI_BRCMSTB_MSI is bool, and CONFIG_PCI_BRCMSTB is
tristate.  -- Jim
