Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Oct 2016 19:19:21 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:2565 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991532AbcJERTOJltju (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Oct 2016 19:19:14 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 9ED912773CD0D;
        Wed,  5 Oct 2016 18:19:00 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 5 Oct 2016
 18:19:01 +0100
Received: from localhost (10.100.200.82) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 5 Oct
 2016 18:19:01 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v3 00/18] MIPS generic kernels, SEAD-3 & Boston support
Date:   Wed, 5 Oct 2016 18:18:06 +0100
Message-ID: <20161005171824.18014-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.82]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

This series introduces some infrastructure for building generic kernels
which will run on multiple boards depending upon the device tree
provided to them by the bootloader. It converts SEAD-3 to make use of
this, and adds support for the MIPS Boston development platform.

The Boston support can be tested in QEMU with this patchset applied:

  https://lists.gnu.org/archive/html/qemu-devel/2016-08/msg03419.html

To do so, configure the kernel for the generic 64r6el_defconfig & run
QEMU like so:

  $ make ARCH=mips 64r6el_defconfig
  $ make ARCH=mips CROSS_COMPILE=my-toolchain-
  $ qemu-system-mips64el -M boston \
      -kernel arch/mips/boot/vmlinux.gz.itb \
      serial stdio

The same kernel binary will also boot on a SEAD-3 if using a bootloader
capable of loading the FIT image format (ie. U-Boot). These 2 boards
form the starting point for the generic kernels, with Ci20 & Ci40 able
to be added easily. Malta will require further work, but I've got most
peripherals converted to probe using device tree as a starting point &
will submit that separately.

v3 drops some patches which aren't critical & need comments made during
review addressing. This series applies atop mips-for-linux-next as of
6a44eb2884ca, but needs the remaining patches of my SEAD-3 DT conversion
series to be applied first.

Paul Burton (18):
  MIPS: PCI: Use struct list_head lists
  MIPS: PCI: Support for CONFIG_PCI_DOMAINS_GENERIC
  MIPS: PCI: Make pcibios_set_cache_line_size an initcall
  MIPS: PCI: Inline pcibios_assign_all_busses
  MIPS: PCI: Split pci.c into pci.c & pci-legacy.c
  MIPS: PCI: Introduce CONFIG_PCI_DRIVERS_LEGACY
  MIPS: PCI: Support generic drivers
  MIPS: Sanitise coherentio semantics
  MIPS: dma-default: Don't check hw_coherentio if device is non-coherent
  MIPS: Support per-device DMA coherence
  MIPS: Print CM error reports upon bus errors
  MIPS: Adjust MIPS64 CAC_BASE to reflect Config.K0
  MIPS: Support generating Flattened Image Trees (.itb)
  MIPS: generic: Introduce generic DT-based board support
  MIPS: generic: Convert SEAD-3 to a generic board
  dt-bindings: Document img,boston-clock binding
  clk: boston: Add a driver for MIPS Boston board clocks
  MIPS: generic: Support MIPS Boston development boards

 .../devicetree/bindings/clock/img,boston-clock.txt |  27 ++
 arch/mips/Kbuild.platforms                         |   2 +-
 arch/mips/Kconfig                                  | 105 ++++---
 arch/mips/Makefile                                 |  77 +++++-
 arch/mips/alchemy/common/setup.c                   |   6 +-
 arch/mips/boot/Makefile                            |  66 +++++
 arch/mips/boot/dts/Makefile                        |   1 +
 arch/mips/boot/dts/img/Makefile                    |   7 +
 arch/mips/boot/dts/img/boston.dts                  | 230 ++++++++++++++++
 arch/mips/boot/dts/mti/Makefile                    |   2 +-
 arch/mips/boot/dts/mti/sead3.dts                   |   1 +
 arch/mips/configs/generic/32r1.config              |   2 +
 arch/mips/configs/generic/32r2.config              |   3 +
 arch/mips/configs/generic/32r6.config              |   2 +
 arch/mips/configs/generic/64r1.config              |   4 +
 arch/mips/configs/generic/64r2.config              |   5 +
 arch/mips/configs/generic/64r6.config              |   4 +
 arch/mips/configs/generic/board-boston.config      |  46 ++++
 arch/mips/configs/generic/board-sead-3.config      |  32 +++
 arch/mips/configs/generic/eb.config                |   1 +
 arch/mips/configs/generic/el.config                |   1 +
 arch/mips/configs/generic/micro32r2.config         |   4 +
 arch/mips/configs/generic_defconfig                |  96 +++++++
 arch/mips/configs/sead3_defconfig                  | 129 ---------
 arch/mips/configs/sead3micro_defconfig             | 122 ---------
 arch/mips/generic/Kconfig                          |  27 ++
 arch/mips/generic/Makefile                         |  15 +
 arch/mips/generic/Platform                         |  14 +
 .../sead3-dtshim.c => generic/board-sead3.c}       | 106 +++++++-
 arch/mips/generic/init.c                           | 176 ++++++++++++
 arch/mips/generic/irq.c                            |  64 +++++
 arch/mips/generic/proc.c                           |  29 ++
 arch/mips/generic/vmlinux.its.S                    |  56 ++++
 arch/mips/include/asm/addrspace.h                  |   3 +-
 arch/mips/include/asm/device.h                     |   5 +
 arch/mips/include/asm/dma-coherence.h              |  16 +-
 arch/mips/include/asm/dma-mapping.h                |  10 +
 arch/mips/include/asm/mach-generic/dma-coherence.h |  14 +-
 arch/mips/include/asm/mach-generic/spaces.h        |   8 +-
 arch/mips/include/asm/mach-ip27/spaces.h           |   1 +
 .../include/asm/mach-sead3/cpu-feature-overrides.h |  72 -----
 arch/mips/include/asm/mach-sead3/irq.h             |   9 -
 .../include/asm/mach-sead3/kernel-entry-init.h     |  21 --
 arch/mips/include/asm/mach-sead3/sead3-dtshim.h    |  29 --
 arch/mips/include/asm/mach-sead3/war.h             |  24 --
 arch/mips/include/asm/machine.h                    |  63 +++++
 arch/mips/include/asm/pci.h                        |  60 +++-
 arch/mips/kernel/traps.c                           |   3 +
 arch/mips/lib/iomap-pci.c                          |   4 +
 arch/mips/mm/c-r4k.c                               |   7 +-
 arch/mips/mm/dma-default.c                         |  16 +-
 arch/mips/mti-malta/malta-int.c                    |  15 -
 arch/mips/mti-malta/malta-setup.c                  |  10 +-
 arch/mips/mti-sead3/Makefile                       |  15 -
 arch/mips/mti-sead3/Platform                       |   7 -
 arch/mips/mti-sead3/sead3-init.c                   | 100 -------
 arch/mips/mti-sead3/sead3-int.c                    |  23 --
 arch/mips/mti-sead3/sead3-setup.c                  |  39 ---
 arch/mips/mti-sead3/sead3-time.c                   |  91 -------
 arch/mips/pci/Makefile                             |   2 +
 arch/mips/pci/pci-alchemy.c                        |   3 +-
 arch/mips/pci/pci-generic.c                        |  52 ++++
 arch/mips/pci/pci-legacy.c                         | 302 +++++++++++++++++++++
 arch/mips/pci/pci.c                                | 297 +-------------------
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/imgtec/Kconfig                         |  10 +
 drivers/clk/imgtec/Makefile                        |   1 +
 drivers/clk/imgtec/clk-boston.c                    | 101 +++++++
 include/dt-bindings/clock/boston-clock.h           |  14 +
 70 files changed, 1824 insertions(+), 1087 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/img,boston-clock.txt
 create mode 100644 arch/mips/boot/dts/img/Makefile
 create mode 100644 arch/mips/boot/dts/img/boston.dts
 create mode 100644 arch/mips/configs/generic/32r1.config
 create mode 100644 arch/mips/configs/generic/32r2.config
 create mode 100644 arch/mips/configs/generic/32r6.config
 create mode 100644 arch/mips/configs/generic/64r1.config
 create mode 100644 arch/mips/configs/generic/64r2.config
 create mode 100644 arch/mips/configs/generic/64r6.config
 create mode 100644 arch/mips/configs/generic/board-boston.config
 create mode 100644 arch/mips/configs/generic/board-sead-3.config
 create mode 100644 arch/mips/configs/generic/eb.config
 create mode 100644 arch/mips/configs/generic/el.config
 create mode 100644 arch/mips/configs/generic/micro32r2.config
 create mode 100644 arch/mips/configs/generic_defconfig
 delete mode 100644 arch/mips/configs/sead3_defconfig
 delete mode 100644 arch/mips/configs/sead3micro_defconfig
 create mode 100644 arch/mips/generic/Kconfig
 create mode 100644 arch/mips/generic/Makefile
 create mode 100644 arch/mips/generic/Platform
 rename arch/mips/{mti-sead3/sead3-dtshim.c => generic/board-sead3.c} (72%)
 create mode 100644 arch/mips/generic/init.c
 create mode 100644 arch/mips/generic/irq.c
 create mode 100644 arch/mips/generic/proc.c
 create mode 100644 arch/mips/generic/vmlinux.its.S
 delete mode 100644 arch/mips/include/asm/mach-sead3/cpu-feature-overrides.h
 delete mode 100644 arch/mips/include/asm/mach-sead3/irq.h
 delete mode 100644 arch/mips/include/asm/mach-sead3/kernel-entry-init.h
 delete mode 100644 arch/mips/include/asm/mach-sead3/sead3-dtshim.h
 delete mode 100644 arch/mips/include/asm/mach-sead3/war.h
 create mode 100644 arch/mips/include/asm/machine.h
 delete mode 100644 arch/mips/mti-sead3/Makefile
 delete mode 100644 arch/mips/mti-sead3/Platform
 delete mode 100644 arch/mips/mti-sead3/sead3-init.c
 delete mode 100644 arch/mips/mti-sead3/sead3-int.c
 delete mode 100644 arch/mips/mti-sead3/sead3-setup.c
 delete mode 100644 arch/mips/mti-sead3/sead3-time.c
 create mode 100644 arch/mips/pci/pci-generic.c
 create mode 100644 arch/mips/pci/pci-legacy.c
 create mode 100644 drivers/clk/imgtec/Kconfig
 create mode 100644 drivers/clk/imgtec/Makefile
 create mode 100644 drivers/clk/imgtec/clk-boston.c
 create mode 100644 include/dt-bindings/clock/boston-clock.h

-- 
2.10.0
