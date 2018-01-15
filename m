Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2018 00:29:37 +0100 (CET)
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:32950 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994666AbeAOX31shIt5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Jan 2018 00:29:27 +0100
Received: from nis-sj1-27.broadcom.com (nis-sj1-27.lvn.broadcom.net [10.75.144.136])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 6C6D430C04E;
        Mon, 15 Jan 2018 15:29:19 -0800 (PST)
Received: from stbsrv-and-3.and.broadcom.com (stbsrv-and-3.and.broadcom.com [10.28.16.21])
        by nis-sj1-27.broadcom.com (Postfix) with ESMTP id D7556AC0741;
        Mon, 15 Jan 2018 15:29:16 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jim Quinlan <jim2101024@gmail.com>
Subject: [PATCH v4 0/8] PCI: brcmstb: Add Broadcom Settopbox PCIe support
Date:   Mon, 15 Jan 2018 18:28:37 -0500
Message-Id: <1516058925-46522-1-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62141
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

This patch series adds support for the Broadcom Settopbox PCIe host
controller.  It is targeted to Broadcom Settopbox chips running on
ARM, ARM64, and MIPS platforms.

V4 Changes:
  - Merged all BrcmSTB PCIe controller files into a single file.
  - All new files now have the SPDX identifier.
  - Removed the list of PCIe controllers.
  - Removed "link-up" race.
  - Removed probe of msi psuedo-device.
  - Multiple comment text changes, as requested.
  - "SSC" => "Spread Spectrum Clocking".
  - Set 'memc' variable.
  - Unnecessary variable initializations removed (eg rc_bar2_size).
  - Added comment on "L23" link state.
  - Removed use of "__refdata".
  - Formatting of structure elements.

V3 Changes:
  - Fold pcie-brcmstb-msi.c into pcie-brcmstb.c
  - Use PCI_XXX constants for PCIe capability registers
  - Removal of any unused constants
  - Change s/pci/pcie/ for filenames, comment text
  - Config space access now uses 8/16/32 read/writes
  - Use proper multi-line comment style
  - Use function names, structure that are common in other host drivers
  - DT binding 'brcm,ssc' is now 'brcm,enable-ssc'
  - Dropped DT binding 'xyz-supply'
  - Not setting CRS support as Linux does it if it is advertised.
  - Removed code that was considered "debug code".
  - Use of_get_pcie_domain_nr()
  - Variable 'bridge_setup_done' removed.

V2 Changes:
* Patch brcmstb-add-memory-API:
  - fix DT_PROP_DATA_TO_U32 macro.
  - dropped one EXPORT_SYMBOL, changed the other to GPL.
* Patch DT-docs-for-Brcmstb-PCIe:
  - change 'brcm,gen' prop to standard 'max-link-speed'.
  - rewrite bindings commit to omit standard prop defs.
  - change props "supplies", "supply-names" to "xyz-supply"
* Patch removed: export-symbol-arch_setup_dma_ops [4/9]
* Patch brcmstb-add-dma-ranges:
  - use get_dma_ops(); also use a const dma_map_ops structure.
  - rewrite map_sg(), unmap_sg(), other calls like syng_sg_*()
  - omit brcm_mapping_error(), but added code in brcm_dma_supported()
  - put all of the notifier code in one compilation unit.

Florian Fainelli (1):
  SOC: brcmstb: add memory API

Jim Quinlan (7):
  dt-bindings: pci: Add DT docs for Brcmstb PCIe device
  PCI: brcmstb: Add Broadcom STB PCIe host controller driver
  PCI: brcmstb: Add dma-range mapping for inbound traffic
  PCI/MSI: Enable PCI_MSI_IRQ_DOMAIN support for MIPS
  PCI: brcmstb: Add MSI capability
  MIPS: BMIPS: Add PCI bindings for 7425, 7435
  MIPS: BMIPS: Enable PCI

 .../devicetree/bindings/pci/brcmstb-pcie.txt       |   59 +
 arch/mips/Kconfig                                  |    3 +
 arch/mips/boot/dts/brcm/bcm7425.dtsi               |   26 +
 arch/mips/boot/dts/brcm/bcm7435.dtsi               |   27 +
 arch/mips/boot/dts/brcm/bcm97425svmb.dts           |    4 +
 arch/mips/boot/dts/brcm/bcm97435svmb.dts           |    4 +
 arch/mips/include/asm/Kbuild                       |    1 +
 drivers/pci/Kconfig                                |    2 +-
 drivers/pci/host/Kconfig                           |    9 +
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pcie-brcmstb.c                    | 1830 ++++++++++++++++++++
 drivers/soc/bcm/brcmstb/Makefile                   |    2 +-
 drivers/soc/bcm/brcmstb/memory.c                   |  158 ++
 include/soc/brcmstb/memory_api.h                   |   25 +
 14 files changed, 2149 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/brcmstb-pcie.txt
 create mode 100644 drivers/pci/host/pcie-brcmstb.c
 create mode 100644 drivers/soc/bcm/brcmstb/memory.c
 create mode 100644 include/soc/brcmstb/memory_api.h

-- 
1.9.0.138.g2de3478
