Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2012 19:04:39 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:36024 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6826641Ab2KKSEiMgSmn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Nov 2012 19:04:38 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [MIPS] Pull request for 3.8
Date:   Sun, 11 Nov 2012 19:03:30 +0100
Message-Id: <1352657010-9632-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 34949
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

Hi Ralf,

here is my queue of patches i consider ready for 3.8.

Included are mainly fixes for various of the supported platforms and 2 generic MIPS fixes.

Please consider pulling this into the upstream-sfr tree.

	John


The following changes since commit 0e4a43ed08e2f44aa7b96aa95d0a540d675483e1:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-3.0-fixes (2012-11-07 13:38:56 +0100)

are available in the git repository at:


  http://dev.phrozen.org/githttp/mips-next.git mips-next

for you to fetch changes up to 0224cde212df4abf251f89c3724a800b1949a774:

  MIPS: lantiq: adds GPHY firmware loader (2012-11-11 18:47:41 +0100)

----------------------------------------------------------------
Charles Hardin (1):
      mips/octeon: 16-Bit NOR flash was not being detected during boot

Ganesan Ramalingam (1):
      MIPS: Netlogic: Support for XLR/XLS Fast Message Network

Hauke Mehrtens (5):
      MIPS: BCM47XX: ignore last memory page
      MIPS: BCM47XX: improve memory size detection
      MIPS: BCM47xx: read out full board data
      MIPS: BCM47XX: read sprom without prefix if no ieee80211 core
      MIPS: BCM47xx: sprom: read values without prefix as fallback

Jayachandran C (11):
      MIPS: Netlogic: select MIPSR2 for XLP
      MIPS: Netlogic: Enable SUE bit in cores
      MIPS: Netlogic: Move fdt init to plat_mem_setup
      MIPS: Netlogic: Fix DMA zone selection for 64-bit
      MIPS: Netlogic: Fix interrupt table entry init
      MIPS: Netlogic: Pass cpuid to early_init_secondary
      MIPS: Netlogic: Update PIC access functions
      MIPS: Netlogic: Move from u32 cpumask to cpumask_t
      MIPS: Netlogic: Support for multi-chip configuration
      MIPS: Netlogic: Make number of nodes configurable
      MIPS: Netlogic: PIC IRQ handling update for multi-chip

John Crispin (6):
      MIPS: lantiq: unbreak devicetree init
      MIPS: lantiq: fix bootselect bits on XRX200 SoC
      MIPS: lantiq: verbose init of dma core
      MIPS: lantiq: adds xrx200 ethernet clock definition
      MIPS: lantiq: adds code for booting GPHY
      MIPS: lantiq: adds GPHY firmware loader

Jonas Gorski (5):
      MIPS: BCM63XX: add and use a clock for PCIe
      MIPS: BCM63XX: add softreset register description for BCM6358
      MIPS: BCM63XX: add core reset helper
      MIPS: BCM63XX: use the new reset helper
      MIPS: BCM63XX: move nvram functions into their own file

Kelvin Cheung (4):
      MIPS: Loongson1B: use common clock infrastructure instead of private APIs
      MIPS: Loongson1B: improve ls1x_serial_setup()
      MIPS: Loongson1B: Update stmmac_mdio_bus_data
      MIPS: Loongson1B: Fix a typo

Kevin Cernekee (1):
      MIPS: tlbex: Fix section mismatches

Madhusudan Bhat (1):
      MIPS: oprofile: Support for XLR/XLS processors

Shane McDonald (1):
      MIPS: Move processing of coherency kernel parameters earlier

Zi Shen Lim (1):
      MIPS: perf: Add XLP support for hardware perf.

 arch/mips/Kconfig                                  |    9 +-
 arch/mips/bcm47xx/prom.c                           |   20 +-
 arch/mips/bcm47xx/setup.c                          |   11 +-
 arch/mips/bcm47xx/sprom.c                          |  780 +++++++++++---------
 arch/mips/bcm63xx/Makefile                         |    7 +-
 arch/mips/bcm63xx/boards/board_bcm963xx.c          |   71 +-
 arch/mips/bcm63xx/clk.c                            |   34 +-
 arch/mips/bcm63xx/nvram.c                          |  104 +++
 arch/mips/bcm63xx/reset.c                          |  223 ++++++
 arch/mips/cavium-octeon/flash_setup.c              |    3 +-
 arch/mips/include/asm/mach-bcm47xx/bcm47xx.h       |    4 +-
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h |   35 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h  |   10 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_reset.h |   21 +
 .../mips/include/asm/mach-bcm63xx/board_bcm963xx.h |   17 -
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |    3 +
 arch/mips/include/asm/mach-loongson1/platform.h    |    3 +-
 arch/mips/include/asm/mach-loongson1/regs-clk.h    |    7 +-
 arch/mips/include/asm/mach-netlogic/irq.h          |    4 +-
 arch/mips/include/asm/mach-netlogic/multi-node.h   |   54 ++
 arch/mips/include/asm/netlogic/common.h            |   51 +-
 arch/mips/include/asm/netlogic/interrupt.h         |    2 +-
 arch/mips/include/asm/netlogic/mips-extns.h        |  142 ++++
 arch/mips/include/asm/netlogic/xlp-hal/pic.h       |   44 +-
 arch/mips/include/asm/netlogic/xlp-hal/sys.h       |    1 -
 arch/mips/include/asm/netlogic/xlr/fmn.h           |  363 +++++++++
 arch/mips/include/asm/netlogic/xlr/pic.h           |    2 -
 arch/mips/include/asm/netlogic/xlr/xlr.h           |    6 +-
 arch/mips/kernel/perf_event_mipsxx.c               |  124 ++++
 arch/mips/lantiq/Kconfig                           |    4 +
 arch/mips/lantiq/prom.c                            |    5 +-
 arch/mips/lantiq/xway/Makefile                     |    2 +
 arch/mips/lantiq/xway/dma.c                        |    9 +-
 arch/mips/lantiq/xway/reset.c                      |   58 +-
 arch/mips/lantiq/xway/sysctrl.c                    |    4 +
 arch/mips/lantiq/xway/xrx200_phy_fw.c              |   97 +++
 arch/mips/loongson1/Kconfig                        |    2 +-
 arch/mips/loongson1/common/clock.c                 |  159 +---
 arch/mips/loongson1/common/platform.c              |   10 +-
 arch/mips/loongson1/ls1b/board.c                   |    5 +-
 arch/mips/mm/c-r4k.c                               |    8 +-
 arch/mips/mm/tlbex.c                               |    8 +-
 arch/mips/netlogic/Kconfig                         |   28 +
 arch/mips/netlogic/common/irq.c                    |  165 +++--
 arch/mips/netlogic/common/smp.c                    |   89 ++-
 arch/mips/netlogic/common/smpboot.S                |    6 +-
 arch/mips/netlogic/xlp/nlm_hal.c                   |   67 +-
 arch/mips/netlogic/xlp/setup.c                     |   50 +-
 arch/mips/netlogic/xlp/wakeup.c                    |   83 ++-
 arch/mips/netlogic/xlr/Makefile                    |    4 +-
 arch/mips/netlogic/xlr/fmn-config.c                |  290 ++++++++
 arch/mips/netlogic/xlr/fmn.c                       |  204 +++++
 arch/mips/netlogic/xlr/setup.c                     |   37 +-
 arch/mips/netlogic/xlr/wakeup.c                    |   23 +-
 arch/mips/oprofile/Makefile                        |    1 +
 arch/mips/oprofile/common.c                        |    1 +
 arch/mips/oprofile/op_model_mipsxx.c               |   29 +
 arch/mips/pci/pci-bcm63xx.c                        |   34 +-
 58 files changed, 2719 insertions(+), 918 deletions(-)
 create mode 100644 arch/mips/bcm63xx/nvram.c
 create mode 100644 arch/mips/bcm63xx/reset.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_reset.h
 create mode 100644 arch/mips/include/asm/mach-netlogic/multi-node.h
 create mode 100644 arch/mips/include/asm/netlogic/xlr/fmn.h
 create mode 100644 arch/mips/lantiq/xway/xrx200_phy_fw.c
 create mode 100644 arch/mips/netlogic/xlr/fmn-config.c
 create mode 100644 arch/mips/netlogic/xlr/fmn.c
