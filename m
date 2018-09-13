Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2018 13:07:59 +0200 (CEST)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50460 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992362AbeIMLHzhEsxy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Sep 2018 13:07:55 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F11980D;
        Thu, 13 Sep 2018 04:07:48 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.emea.arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61D363F557;
        Thu, 13 Sep 2018 04:07:40 -0700 (PDT)
Date:   Thu, 13 Sep 2018 12:07:37 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Jinbum Park <jinb.park7@gmail.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Stefan Agner <stefan@agner.ch>, Eric Anholt <eric@anholt.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Tony Lindgren <tony@atomide.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Olof Johansson <olof@lixom.net>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Dirk Hohndel (VMware)" <dirk@hohndel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Justin Chen <justinpopo6@gmail.com>,
        Markus Mayer <markus.mayer@broadcom.com>,
        Gareth Powell <gpowell@broadcom.com>,
        Doug Berger <opendmb@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 00/12] PCI: brcmstb: Add Broadcom Settopbox PCIe
 support
Message-ID: <20180913110737.GB2051@e107981-ln.cambridge.arm.com>
References: <1536266581-7308-1-git-send-email-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536266581-7308-1-git-send-email-jim2101024@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <lorenzo.pieralisi@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66221
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

FYI,

AFAICS this thread did not make it to any vger list you addressed, I
can't apply/review patches that do not appear on
linux-pci@vger.kernel.org at least so we need to figure out what went
wrong.

I would consider trimming the CC list to start with, which is huge.

Lorenzo

On Thu, Sep 06, 2018 at 04:42:49PM -0400, Jim Quinlan wrote:
> This patch series adds support for the Broadcom Settopbox PCIe host
> controller.  It is targeted to Broadcom Settopbox chips running on
> ARM, ARM64, and MIPS platforms.
> 
> V5 Changes:
>   - V4 had its own DMA ops structure in the PCIe driver which would
>     override/coexist with the default arch DMA ops.  This approach was
>     scrapped, and this version instead essentially implements custom
>     definitions of the __phys_to_dma and __dma_to_phys operations for the
>     three target arches: MIPs, ARM64, ARM.  This was the course suggested
>     by one of the V4 reviewers (ChristophH).
> 
>     For MIPs and ARM64, the DMA remapping is easily accomplished by having
>     custom definitions of __phys_to_dma and __dma_to_phys.  For
>     MIPs/BMIPs, ARCH_HAS_PHYS_TO_DMA is already selected and the two
>     functions are just modified.  For ARM64, this driver selects
>     ARCH_HAS_PHYS_TO_DMA and declares and defines __phys_to_dma() and
>     __dma_to_phys().  For ARM, things were not so simple.  The default
>     functions like __arch_pfn_to_dma() had to be overridden by custom ones
>     defined in arch/arm/mach-bcm/include/mach/memory.h.  For these
>     functions to be "seen", we had to declare our own brcmstb_defconfig
>     and no longer use multi_v7_defconfig.  This is unfortunate.
> 
>   - Commits have been better organized to first implement the main driver,
>     then add features (MSI, DMA remap infrastructure), and then add
>     the DMA remapping modifications for MIPs, ARM64, and ARM.
> 
> V4 Changes:
>   - Merged all BrcmSTB PCIe controller files into a single file.
>   - All new files now have the SPDX identifier.
>   - Removed the list of PCIe controllers.
>   - Removed "link-up" race.
>   - Removed probe of msi psuedo-device.
>   - Multiple comment text changes, as requested.
>   - "SSC" => "Spread Spectrum Clocking".
>   - Set 'memc' variable.
>   - Unnecessary variable initializations removed (eg rc_bar2_size).
>   - Added comment on "L23" link state.
>   - Removed use of "__refdata".
>   - Formatting of structure elements.
> 
> V3 Changes:
>   - Fold pcie-brcmstb-msi.c into pcie-brcmstb.c
>   - Use PCI_XXX constants for PCIe capability registers
>   - Removal of any unused constants
>   - Change s/pci/pcie/ for filenames, comment text
>   - Config space access now uses 8/16/32 read/writes
>   - Use proper multi-line comment style
>   - Use function names, structure that are common in other host drivers
>   - DT binding 'brcm,ssc' is now 'brcm,enable-ssc'
>   - Dropped DT binding 'xyz-supply'
>   - Not setting CRS support as Linux does it if it is advertised.
>   - Removed code that was considered "debug code".
>   - Use of_get_pcie_domain_nr()
>   - Variable 'bridge_setup_done' removed.
> 
> V2 Changes:
> * Patch brcmstb-add-memory-API:
>   - fix DT_PROP_DATA_TO_U32 macro.
>   - dropped one EXPORT_SYMBOL, changed the other to GPL.
> * Patch DT-docs-for-Brcmstb-PCIe:
>   - change 'brcm,gen' prop to standard 'max-link-speed'.
>   - rewrite bindings commit to omit standard prop defs.
>   - change props "supplies", "supply-names" to "xyz-supply"
> * Patch removed: export-symbol-arch_setup_dma_ops [4/9]
> * Patch brcmstb-add-dma-ranges:
>   - use get_dma_ops(); also use a const dma_map_ops structure.
>   - rewrite map_sg(), unmap_sg(), other calls like syng_sg_*()
>   - omit brcm_mapping_error(), but added code in brcm_dma_supported()
>   - put all of the notifier code in one compilation unit.
> 
> 
> 
> Florian Fainelli (1):
>   soc: bcm: brcmstb: add memory API
> 
> Jim Quinlan (11):
>   dt-bindings: pci: add DT docs for Brcmstb PCIe device
>   PCI: brcmstb: add Broadcom STB PCIe host controller driver
>   PCI: brcmstb: add dma-range mapping for inbound traffic
>   PCI: brcmstb: add MSI capability
>   MIPS: BMIPS: add dma remap for BrcmSTB PCIe
>   PCI/MSI: enable PCI_MSI_IRQ_DOMAIN support for MIPS
>   MIPS: BMIPS: add PCI bindings for 7425, 7435
>   MIPS: BMIPS: enable PCI
>   ARM64: declare __phys_to_dma on ARCH_HAS_PHYS_TO_DMA
>   ARM64: add dma remap for BrcmSTB PCIe
>   ARM: add dma remap for BrcmSTB PCIe
> 
>  .../devicetree/bindings/pci/brcmstb-pcie.txt       |   59 +
>  arch/arm/Kconfig                                   |   33 +
>  arch/arm/configs/brcmstb_defconfig                 |  204 +++
>  arch/arm/configs/multi_v7_defconfig                |    3 -
>  arch/arm/mach-bcm/Kconfig                          |   21 +-
>  arch/arm/mach-bcm/Makefile.boot                    |    0
>  arch/arm/mach-bcm/include/mach/irqs.h              |    3 +
>  arch/arm/mach-bcm/include/mach/memory.h            |   47 +
>  arch/arm/mach-bcm/include/mach/uncompress.h        |    8 +
>  arch/arm64/include/asm/dma-direct.h                |   16 +
>  arch/mips/Kconfig                                  |    3 +
>  arch/mips/bmips/dma.c                              |    9 +
>  arch/mips/boot/dts/brcm/bcm7425.dtsi               |   28 +
>  arch/mips/boot/dts/brcm/bcm7435.dtsi               |   28 +
>  arch/mips/boot/dts/brcm/bcm97425svmb.dts           |    4 +
>  arch/mips/boot/dts/brcm/bcm97435svmb.dts           |    4 +
>  drivers/pci/Kconfig                                |    2 +-
>  drivers/pci/controller/Kconfig                     |   13 +
>  drivers/pci/controller/Makefile                    |    1 +
>  drivers/pci/controller/pcie-brcmstb.c              | 1554 ++++++++++++++++++++
>  drivers/soc/bcm/brcmstb/Makefile                   |    2 +-
>  drivers/soc/bcm/brcmstb/memory.c                   |  158 ++
>  include/soc/brcmstb/common.h                       |   16 +
>  include/soc/brcmstb/memory_api.h                   |   26 +
>  24 files changed, 2217 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/brcmstb-pcie.txt
>  create mode 100644 arch/arm/configs/brcmstb_defconfig
>  create mode 100644 arch/arm/mach-bcm/Makefile.boot
>  create mode 100644 arch/arm/mach-bcm/include/mach/irqs.h
>  create mode 100644 arch/arm/mach-bcm/include/mach/memory.h
>  create mode 100644 arch/arm/mach-bcm/include/mach/uncompress.h
>  create mode 100644 arch/arm64/include/asm/dma-direct.h
>  create mode 100644 drivers/pci/controller/pcie-brcmstb.c
>  create mode 100644 drivers/soc/bcm/brcmstb/memory.c
>  create mode 100644 include/soc/brcmstb/memory_api.h
> 
> -- 
> 1.9.0.138.g2de3478
> 
