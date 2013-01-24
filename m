Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2013 18:47:57 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:52028 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833459Ab3AXRr4h09vf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Jan 2013 18:47:56 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: mips-next: Pull Request for 3.9
Date:   Thu, 24 Jan 2013 18:45:13 +0100
Message-Id: <1359049513-10847-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 35548
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

The following changes since commit 5da1f88b8b727dc3a66c52d4513e871be6d43d19:

  Merge tag 'usb-3.8-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb (2013-01-18 14:06:29 -0800)

are available in the git repository at:


  git://git.linux-mips.org/pub/scm/john/linux-john.git mips-next-3.9

for you to fetch changes up to 25ab7db41c1bcb07eb728b83b75022dc5e7f5dc6:

  MIPS: Loongson: Add a Loongson-3 default config file (2013-01-24 16:07:19 +0100)



Hi Ralf,

various patches for the following platforms bcm47xx, loongson3, xlp, lantiq and
a few generic patches from Steven

Please consider pulling these into upstream-sfr.git

	John

----------------------------------------------------------------
Hauke Mehrtens (12):
      MIPS: BCM47XX: use common error codes in nvram reads
      MIPS: BCM47XX: return error when init of nvram failed
      MIPS: BCM47XX: nvram add nand flash support
      MIPS: BCM47XX: rename early_nvram_init to nvram_init
      MIPS: BCM47XX: handle different nvram sizes
      MIPS: BCM47XX: add bcm47xx prefix in front of nvram function names
      MIPS: BCM47XX: trim the nvram values for parsing
      MIPS: BCM47XX: select BOOT_RAW
      MIPS: BCM47XX: select NO_EXCEPT_FILL
      MIPS: BCM47XX: use fallback sprom var for board_{rev,type}
      bcma: add gpio_to_irq again
      ssb: add gpio_to_irq again

Huacai Chen (12):
      MIPS: Loongson: Add basic Loongson-3 definition
      MIPS: Loongson: Add basic Loongson-3 CPU support
      MIPS: Loongson 3: Add Lemote-3A machtypes definition
      MIPS: Loongson: Add UEFI-like firmware interface support
      MIPS: Loongson 3: Add HT-linked PCI support
      MIPS: Loongson 3: Add IRQ init and dispatch support
      MIPS: Loongson 3: Add serial port support
      MIPS: Loongson: Add swiotlb to support big memory (>4GB)
      MIPS: Loongson: Add Loongson-3 Kconfig options
      MIPS: Loongson 3: Add Loongson-3 SMP support
      MIPS: Loongson 3: Add CPU hotplug support
      MIPS: Loongson: Add a Loongson-3 default config file

Jayachandran C (11):
      MIPS: Netlogic: Fix UP compilation on XLR
      MIPS: Netlogic: add XLS6xx to FMN config
      MIPS: Netlogic: Optimize EIMR/EIRR accesses in 32-bit
      MIPS: PCI: Byteswap not needed in little-endian mode
      MIPS: Netlogic: Split XLP L1 i-cache among threads
      MIPS: Netlogic: Use PIC timer as a clocksource
      MIPS: PCI: Prevent hang on XLP reg read
      MIPS: Netlogic: No hazards needed for XLR/XLS
      MIPS: Netlogic: use preset loops per jiffy
      MIPS: Netlogic: Fix for quad-XLP boot
      MIPS: PCI: Multi-node PCI support for Netlogic XLP

John Crispin (6):
      MIPS: show correct cpu name for 24KEc
      MIPS: lantiq: trivial typo fix
      MIPS: lantiq: adds static clock for PP32
      MIPS: lantiq: add GPHY clock gate bits
      MIPS: lantiq: improve pci reset gpio handling
      MIPS: lantiq: rework external irq code

Rafal Milecki (1):
      MIPS: bcm47xx: separate functions finding flash window addr

Steven J. Hill (5):
      MIPS: Clean-ups for MIPS Technologies Inc. generic header file.
      MIPS: Add support for the M14KEc core.
      MIPS: dsp: Add assembler support for DSP ASEs.
      MIPS: dsp: Support toolchains without DSP ASE and microMIPS.
      MIPS: dsp: Simplify the DSP macros.

 arch/mips/Kconfig                                  |   31 ++
 arch/mips/bcm47xx/nvram.c                          |  159 +++++--
 arch/mips/bcm47xx/setup.c                          |    6 +-
 arch/mips/bcm47xx/sprom.c                          |   22 +-
 arch/mips/configs/loongson3_defconfig              |  328 ++++++++++++++
 arch/mips/include/asm/addrspace.h                  |    6 +
 arch/mips/include/asm/bootinfo.h                   |   24 +-
 arch/mips/include/asm/cpu-features.h               |    3 +
 arch/mips/include/asm/cpu.h                        |    8 +-
 arch/mips/include/asm/dma-mapping.h                |    5 +
 arch/mips/include/asm/hazards.h                    |    2 +-
 .../asm/mach-bcm47xx/{nvram.h => bcm47xx_nvram.h}  |   13 +-
 arch/mips/include/asm/mach-lantiq/lantiq.h         |    2 +
 arch/mips/include/asm/mach-loongson/boot_param.h   |  151 +++++++
 .../mips/include/asm/mach-loongson/dma-coherence.h |   23 +
 arch/mips/include/asm/mach-loongson/irq.h          |   24 ++
 arch/mips/include/asm/mach-loongson/loongson.h     |   26 +-
 arch/mips/include/asm/mach-loongson/machine.h      |    6 +
 arch/mips/include/asm/mach-loongson/pci.h          |    5 +
 arch/mips/include/asm/mach-loongson/spaces.h       |   15 +
 arch/mips/include/asm/mips-boards/generic.h        |   28 +-
 arch/mips/include/asm/mipsregs.h                   |  312 ++++++--------
 arch/mips/include/asm/module.h                     |    2 +
 arch/mips/include/asm/netlogic/mips-extns.h        |   79 ++++
 .../mips/include/asm/netlogic/xlp-hal/cpucontrol.h |    2 +
 arch/mips/include/asm/netlogic/xlp-hal/pic.h       |   12 +-
 arch/mips/include/asm/netlogic/xlr/pic.h           |   48 ++-
 arch/mips/include/asm/pgtable-bits.h               |    7 +
 arch/mips/include/asm/smp.h                        |    1 +
 arch/mips/kernel/Makefile                          |   31 ++
 arch/mips/kernel/cpu-probe.c                       |   26 +-
 arch/mips/lantiq/clk.c                             |   12 +-
 arch/mips/lantiq/clk.h                             |    7 +-
 arch/mips/lantiq/falcon/sysctrl.c                  |    4 +-
 arch/mips/lantiq/irq.c                             |  105 +++--
 arch/mips/lantiq/xway/clk.c                        |   43 ++
 arch/mips/lantiq/xway/reset.c                      |    9 +
 arch/mips/lantiq/xway/sysctrl.c                    |   15 +-
 arch/mips/loongson/Kconfig                         |   52 +++
 arch/mips/loongson/Makefile                        |    6 +
 arch/mips/loongson/Platform                        |    1 +
 arch/mips/loongson/common/Makefile                 |    5 +
 arch/mips/loongson/common/dma-swiotlb.c            |  163 +++++++
 arch/mips/loongson/common/env.c                    |   67 ++-
 arch/mips/loongson/common/init.c                   |   14 +-
 arch/mips/loongson/common/machtype.c               |   20 +-
 arch/mips/loongson/common/mem.c                    |   42 ++
 arch/mips/loongson/common/pci.c                    |    6 +-
 arch/mips/loongson/common/reset.c                  |   16 +
 arch/mips/loongson/common/serial.c                 |   26 +-
 arch/mips/loongson/common/setup.c                  |    8 +-
 arch/mips/loongson/common/uart_base.c              |    9 +-
 arch/mips/loongson/loongson-3/Makefile             |    6 +
 arch/mips/loongson/loongson-3/irq.c                |   97 +++++
 arch/mips/loongson/loongson-3/smp.c                |  450 ++++++++++++++++++++
 arch/mips/loongson/loongson-3/smp.h                |   24 ++
 arch/mips/mm/c-r4k.c                               |   63 ++-
 arch/mips/mm/tlb-r4k.c                             |    2 +-
 arch/mips/mm/tlbex.c                               |    2 +
 arch/mips/netlogic/common/irq.c                    |   41 +-
 arch/mips/netlogic/common/smp.c                    |    8 +-
 arch/mips/netlogic/common/smpboot.S                |    6 +
 arch/mips/netlogic/common/time.c                   |   56 +++
 arch/mips/netlogic/xlp/wakeup.c                    |   35 +-
 arch/mips/netlogic/xlr/fmn-config.c                |    2 +
 arch/mips/netlogic/xlr/platform.c                  |    2 +-
 arch/mips/netlogic/xlr/setup.c                     |    7 +-
 arch/mips/oprofile/common.c                        |    1 +
 arch/mips/oprofile/op_model_mipsxx.c               |    4 +
 arch/mips/pci/Makefile                             |    1 +
 arch/mips/pci/fixup-loongson3.c                    |   64 +++
 arch/mips/pci/ops-loongson3.c                      |  104 +++++
 arch/mips/pci/pci-lantiq.c                         |   12 +-
 arch/mips/pci/pci-xlp.c                            |  124 ++++--
 drivers/bcma/driver_gpio.c                         |   11 +
 drivers/mtd/bcm47xxpart.c                          |    2 +-
 drivers/net/ethernet/broadcom/b44.c                |    4 +-
 drivers/ssb/driver_chipcommon_pmu.c                |    4 +-
 drivers/ssb/driver_gpio.c                          |   22 +
 include/linux/ssb/ssb_driver_gige.h                |    6 +-
 80 files changed, 2714 insertions(+), 483 deletions(-)
 create mode 100644 arch/mips/configs/loongson3_defconfig
 rename arch/mips/include/asm/mach-bcm47xx/{nvram.h => bcm47xx_nvram.h} (84%)
 create mode 100644 arch/mips/include/asm/mach-loongson/boot_param.h
 create mode 100644 arch/mips/include/asm/mach-loongson/irq.h
 create mode 100644 arch/mips/include/asm/mach-loongson/spaces.h
 create mode 100644 arch/mips/loongson/common/dma-swiotlb.c
 create mode 100644 arch/mips/loongson/loongson-3/Makefile
 create mode 100644 arch/mips/loongson/loongson-3/irq.c
 create mode 100644 arch/mips/loongson/loongson-3/smp.c
 create mode 100644 arch/mips/loongson/loongson-3/smp.h
 create mode 100644 arch/mips/pci/fixup-loongson3.c
 create mode 100644 arch/mips/pci/ops-loongson3.c
