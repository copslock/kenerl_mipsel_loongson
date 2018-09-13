Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2018 20:25:04 +0200 (CEST)
Received: from mail-lf1-x142.google.com ([IPv6:2a00:1450:4864:20::142]:40066
        "EHLO mail-lf1-x142.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993964AbeIMSZB1Squg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Sep 2018 20:25:01 +0200
Received: by mail-lf1-x142.google.com with SMTP id x26-v6so5643521lfi.7;
        Thu, 13 Sep 2018 11:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3nEtL4ot7xSAHYnj31Q6a+5sFM2mSp9TW27ApBduc5w=;
        b=uFnnuqKJyzGu5A8b2Cuh0Ku6rNu27a48PK9U3HecZUe6TaZaXM951fpD2POrpBisez
         eE6NXsjWrfe9DnT5ZlKRU3EdhRET0EfZGbswm5U+0HwaENF0tel/rLTfUasxvoqU+igw
         rd556wBEWoVsqU+5qIrXhKzDGH7oAd1Q9ITPz6qEMcjn02vQIGnVV+9LOZDsNRNt6M79
         QCW+tGZxMrL+AjQ065DyFBdco7kYGSFiSI3r5uJ5BC4kOczdfJJzyIPV4awFPtIuBg2A
         0GDw7kzUQ4/oh3XZqhUCMndSr4VX8yHbM3HSJX8ysHmkPExflJqCOF+95MY8+80vCD6n
         sbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3nEtL4ot7xSAHYnj31Q6a+5sFM2mSp9TW27ApBduc5w=;
        b=X47r2PaJ9JplOSWonFfZgUmOLt4iG9BHzXfXAl34IquiUk289UUzqb9dSuCUz+vqjG
         5keIzAn1HolvypMr4NA/JlrT+nni8UevYvbX59olgMIsjRc0YafZ8Rzd3tYty8OWIMBh
         Gzx/MjR2YopIuIt1CPInAnJPfmb2y0Rj9vdAdt3CB07wpT4TpE22CZLEy0KA9YKKH70C
         3QFCupBdjmK2pQMDLfYrBpJXY5T3e9GE0DKwR2ryWXApJ7ZLUfY4w/sxhqK8EKbYCRZ8
         yr3Q+Kk+7Zt++NbZ0UBUKJImVn4o4CLGqDfKnNvJv86+Oa5xvFpoCSttEJOiTPbz7D8U
         I2Gw==
X-Gm-Message-State: APzg51DUHDPadhKGksOWe2O4FY8xJRJEa6O1sdssNSXQM2aTEeCtk5kb
        Nl1YBAaOV1l50v29efrXHuCGKPfHB48jrQAsd5o=
X-Google-Smtp-Source: ANB0Vdb+Wg/oC6Iss4gsMV4JoCLxwSqElXF0y6FdcxHyZu/HqvWfUIFQIyZ6omPxHdlm8iVnC7CfzMoIGQgIuYcbtiA=
X-Received: by 2002:a19:dd49:: with SMTP id u70-v6mr6039902lfg.135.1536863095645;
 Thu, 13 Sep 2018 11:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <1536266581-7308-1-git-send-email-jim2101024@gmail.com> <20180913110737.GB2051@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180913110737.GB2051@e107981-ln.cambridge.arm.com>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Thu, 13 Sep 2018 14:24:44 -0400
Message-ID: <CANCKTBvCRoOvB_h6-4EdxqH0MGt1vx-FcyQq1N0uhe9fDi+Hcg@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] PCI: brcmstb: Add Broadcom Settopbox PCIe support
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux@armlinux.org.uk, Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>, paul.burton@mips.com,
        jhogan@kernel.org, Kevin Cernekee <cernekee@gmail.com>,
        yamada.masahiro@socionext.com, Arnd Bergmann <arnd@arndb.de>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Jinbum Park <jinb.park7@gmail.com>, vladimir.murzin@arm.com,
        alexandre.belloni@bootlin.com, palmer@sifive.com, stefan@agner.ch,
        Eric Anholt <eric@anholt.net>, horms+renesas@verge.net.au,
        Tony Lindgren <tony@atomide.com>, stefan.wahren@i2se.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        olof@lixom.net, thellstrom@vmware.com, alexander.deucher@amd.com,
        dirk@hohndel.org, tglx@linutronix.de,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        gregkh@linuxfoundation.org, Robin Murphy <robin.murphy@arm.com>,
        Justin Chen <justinpopo6@gmail.com>, markus.mayer@broadcom.com,
        gpowell@broadcom.com, opendmb@gmail.com,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66224
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

On Thu, Sep 13, 2018 at 7:07 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> FYI,
>
> AFAICS this thread did not make it to any vger list you addressed, I
> can't apply/review patches that do not appear on
> linux-pci@vger.kernel.org at least so we need to figure out what went
> wrong.
>
> I would consider trimming the CC list to start with, which is huge.
>
> Lorenzo

Hi Lorenzo, this may have had something to do with an email issue on
my end.  I will resend again soon.
Thanks, Jim

>
> On Thu, Sep 06, 2018 at 04:42:49PM -0400, Jim Quinlan wrote:
> > This patch series adds support for the Broadcom Settopbox PCIe host
> > controller.  It is targeted to Broadcom Settopbox chips running on
> > ARM, ARM64, and MIPS platforms.
> >
> > V5 Changes:
> >   - V4 had its own DMA ops structure in the PCIe driver which would
> >     override/coexist with the default arch DMA ops.  This approach was
> >     scrapped, and this version instead essentially implements custom
> >     definitions of the __phys_to_dma and __dma_to_phys operations for the
> >     three target arches: MIPs, ARM64, ARM.  This was the course suggested
> >     by one of the V4 reviewers (ChristophH).
> >
> >     For MIPs and ARM64, the DMA remapping is easily accomplished by having
> >     custom definitions of __phys_to_dma and __dma_to_phys.  For
> >     MIPs/BMIPs, ARCH_HAS_PHYS_TO_DMA is already selected and the two
> >     functions are just modified.  For ARM64, this driver selects
> >     ARCH_HAS_PHYS_TO_DMA and declares and defines __phys_to_dma() and
> >     __dma_to_phys().  For ARM, things were not so simple.  The default
> >     functions like __arch_pfn_to_dma() had to be overridden by custom ones
> >     defined in arch/arm/mach-bcm/include/mach/memory.h.  For these
> >     functions to be "seen", we had to declare our own brcmstb_defconfig
> >     and no longer use multi_v7_defconfig.  This is unfortunate.
> >
> >   - Commits have been better organized to first implement the main driver,
> >     then add features (MSI, DMA remap infrastructure), and then add
> >     the DMA remapping modifications for MIPs, ARM64, and ARM.
> >
> > V4 Changes:
> >   - Merged all BrcmSTB PCIe controller files into a single file.
> >   - All new files now have the SPDX identifier.
> >   - Removed the list of PCIe controllers.
> >   - Removed "link-up" race.
> >   - Removed probe of msi psuedo-device.
> >   - Multiple comment text changes, as requested.
> >   - "SSC" => "Spread Spectrum Clocking".
> >   - Set 'memc' variable.
> >   - Unnecessary variable initializations removed (eg rc_bar2_size).
> >   - Added comment on "L23" link state.
> >   - Removed use of "__refdata".
> >   - Formatting of structure elements.
> >
> > V3 Changes:
> >   - Fold pcie-brcmstb-msi.c into pcie-brcmstb.c
> >   - Use PCI_XXX constants for PCIe capability registers
> >   - Removal of any unused constants
> >   - Change s/pci/pcie/ for filenames, comment text
> >   - Config space access now uses 8/16/32 read/writes
> >   - Use proper multi-line comment style
> >   - Use function names, structure that are common in other host drivers
> >   - DT binding 'brcm,ssc' is now 'brcm,enable-ssc'
> >   - Dropped DT binding 'xyz-supply'
> >   - Not setting CRS support as Linux does it if it is advertised.
> >   - Removed code that was considered "debug code".
> >   - Use of_get_pcie_domain_nr()
> >   - Variable 'bridge_setup_done' removed.
> >
> > V2 Changes:
> > * Patch brcmstb-add-memory-API:
> >   - fix DT_PROP_DATA_TO_U32 macro.
> >   - dropped one EXPORT_SYMBOL, changed the other to GPL.
> > * Patch DT-docs-for-Brcmstb-PCIe:
> >   - change 'brcm,gen' prop to standard 'max-link-speed'.
> >   - rewrite bindings commit to omit standard prop defs.
> >   - change props "supplies", "supply-names" to "xyz-supply"
> > * Patch removed: export-symbol-arch_setup_dma_ops [4/9]
> > * Patch brcmstb-add-dma-ranges:
> >   - use get_dma_ops(); also use a const dma_map_ops structure.
> >   - rewrite map_sg(), unmap_sg(), other calls like syng_sg_*()
> >   - omit brcm_mapping_error(), but added code in brcm_dma_supported()
> >   - put all of the notifier code in one compilation unit.
> >
> >
> >
> > Florian Fainelli (1):
> >   soc: bcm: brcmstb: add memory API
> >
> > Jim Quinlan (11):
> >   dt-bindings: pci: add DT docs for Brcmstb PCIe device
> >   PCI: brcmstb: add Broadcom STB PCIe host controller driver
> >   PCI: brcmstb: add dma-range mapping for inbound traffic
> >   PCI: brcmstb: add MSI capability
> >   MIPS: BMIPS: add dma remap for BrcmSTB PCIe
> >   PCI/MSI: enable PCI_MSI_IRQ_DOMAIN support for MIPS
> >   MIPS: BMIPS: add PCI bindings for 7425, 7435
> >   MIPS: BMIPS: enable PCI
> >   ARM64: declare __phys_to_dma on ARCH_HAS_PHYS_TO_DMA
> >   ARM64: add dma remap for BrcmSTB PCIe
> >   ARM: add dma remap for BrcmSTB PCIe
> >
> >  .../devicetree/bindings/pci/brcmstb-pcie.txt       |   59 +
> >  arch/arm/Kconfig                                   |   33 +
> >  arch/arm/configs/brcmstb_defconfig                 |  204 +++
> >  arch/arm/configs/multi_v7_defconfig                |    3 -
> >  arch/arm/mach-bcm/Kconfig                          |   21 +-
> >  arch/arm/mach-bcm/Makefile.boot                    |    0
> >  arch/arm/mach-bcm/include/mach/irqs.h              |    3 +
> >  arch/arm/mach-bcm/include/mach/memory.h            |   47 +
> >  arch/arm/mach-bcm/include/mach/uncompress.h        |    8 +
> >  arch/arm64/include/asm/dma-direct.h                |   16 +
> >  arch/mips/Kconfig                                  |    3 +
> >  arch/mips/bmips/dma.c                              |    9 +
> >  arch/mips/boot/dts/brcm/bcm7425.dtsi               |   28 +
> >  arch/mips/boot/dts/brcm/bcm7435.dtsi               |   28 +
> >  arch/mips/boot/dts/brcm/bcm97425svmb.dts           |    4 +
> >  arch/mips/boot/dts/brcm/bcm97435svmb.dts           |    4 +
> >  drivers/pci/Kconfig                                |    2 +-
> >  drivers/pci/controller/Kconfig                     |   13 +
> >  drivers/pci/controller/Makefile                    |    1 +
> >  drivers/pci/controller/pcie-brcmstb.c              | 1554 ++++++++++++++++++++
> >  drivers/soc/bcm/brcmstb/Makefile                   |    2 +-
> >  drivers/soc/bcm/brcmstb/memory.c                   |  158 ++
> >  include/soc/brcmstb/common.h                       |   16 +
> >  include/soc/brcmstb/memory_api.h                   |   26 +
> >  24 files changed, 2217 insertions(+), 25 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/brcmstb-pcie.txt
> >  create mode 100644 arch/arm/configs/brcmstb_defconfig
> >  create mode 100644 arch/arm/mach-bcm/Makefile.boot
> >  create mode 100644 arch/arm/mach-bcm/include/mach/irqs.h
> >  create mode 100644 arch/arm/mach-bcm/include/mach/memory.h
> >  create mode 100644 arch/arm/mach-bcm/include/mach/uncompress.h
> >  create mode 100644 arch/arm64/include/asm/dma-direct.h
> >  create mode 100644 drivers/pci/controller/pcie-brcmstb.c
> >  create mode 100644 drivers/soc/bcm/brcmstb/memory.c
> >  create mode 100644 include/soc/brcmstb/memory_api.h
> >
> > --
> > 1.9.0.138.g2de3478
> >
