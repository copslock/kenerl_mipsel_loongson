Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 17:38:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33059 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992472AbcHZPiONW0gI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 17:38:14 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id BCC18B0390998;
        Fri, 26 Aug 2016 16:37:52 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 16:37:55 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        John Crispin <john@phrozen.org>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jacek Anaszewski <j.anaszewski@samsung.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        John Crispin <blogic@openwrt.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Qais Yousef <qsyousef@gmail.com>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-clk@vger.kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        <devicetree@vger.kernel.org>, Qais Yousef <qais.yousef@imgtec.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Joerg Roedel <jroedel@suse.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH 00/26] MIPS generic kernels, SEAD-3 & Boston support
Date:   Fri, 26 Aug 2016 16:36:59 +0100
Message-ID: <20160826153725.11629-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54784
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

This series applies atop v4.8-rc3 with my "MIPS: SEAD3 device tree
conversion" series applied first.

Paul Burton (26):
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
  dt-bindings: Document mti,mips-cpc binding
  MIPS: CPC: Provide a default mips_cpc_default_phys_base
  dt-bindings: Document mti,mips-cdmm binding
  MIPS: CDMM: Allow CDMM base address to be specified via DT
  irqchip: mips-cpu: Replace magic 0x100 with IE_SW0
  irqchip: mips-cpu: Prepare for non-legacy IRQ domains
  irqchip: mips-cpu: Introduce IPI IRQ domain support
  MIPS: smp-mt: Use CPU interrupt controller IPI IRQ domain support
  MIPS: Stengthen IPI IRQ domain sanity check
  MIPS: Adjust MIPS64 CAC_BASE to reflect Config.K0
  MIPS: Support generating Flattened Image Trees (.itb)
  MIPS: generic: Introduce generic DT-based board support
  MIPS: generic: Convert SEAD-3 to a generic board
  dt-bindings: Document img,boston-clock binding
  clk: boston: Add a driver for MIPS Boston board clocks
  MIPS: generic: Support MIPS Boston development boards

 .../devicetree/bindings/clock/img,boston-clock.txt |  27 ++
 .../devicetree/bindings/misc/mti,mips-cdmm.txt     |   8 +
 .../devicetree/bindings/misc/mti,mips-cpc.txt      |   8 +
 arch/mips/Kbuild.platforms                         |   2 +-
 arch/mips/Kconfig                                  | 104 ++++---
 arch/mips/Makefile                                 |  72 ++++-
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
 arch/mips/configs/generic/64r1.config              |   1 +
 arch/mips/configs/generic/64r2.config              |   2 +
 arch/mips/configs/generic/64r6.config              |   1 +
 arch/mips/configs/generic/board-boston.config      |  46 ++++
 arch/mips/configs/generic/board-sead-3.config      |  32 +++
 arch/mips/configs/generic/eb.config                |   1 +
 arch/mips/configs/generic/el.config                |   1 +
 arch/mips/configs/generic/micro32r2.config         |   4 +
 arch/mips/configs/generic_defconfig                |   2 +
 arch/mips/configs/sead3_defconfig                  | 129 ---------
 arch/mips/configs/sead3micro_defconfig             | 122 ---------
 arch/mips/generic/Kconfig                          |  27 ++
 arch/mips/generic/Makefile                         |  15 +
 arch/mips/generic/Platform                         |  14 +
 .../sead3-dtshim.c => generic/board-sead3.c}       | 106 +++++++-
 arch/mips/generic/init.c                           | 174 ++++++++++++
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
 arch/mips/include/asm/pci.h                        |  57 +++-
 arch/mips/kernel/mips-cpc.c                        |  18 ++
 arch/mips/kernel/smp-mt.c                          |  49 +---
 arch/mips/kernel/smp.c                             |  20 +-
 arch/mips/kernel/traps.c                           |   3 +
 arch/mips/lantiq/irq.c                             |  52 ----
 arch/mips/lib/iomap-pci.c                          |   4 +
 arch/mips/mm/c-r4k.c                               |   7 +-
 arch/mips/mm/dma-default.c                         |  16 +-
 arch/mips/mti-malta/malta-int.c                    |  90 +-----
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
 arch/mips/pci/pci.c                                | 296 +-------------------
 drivers/bus/mips_cdmm.c                            |  13 +
 drivers/clk/Kconfig                                |   9 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-boston.c                           | 131 +++++++++
 drivers/irqchip/Kconfig                            |   2 +
 drivers/irqchip/irq-mips-cpu.c                     | 149 ++++++++--
 include/dt-bindings/clock/boston-clock.h           |  13 +
 77 files changed, 1937 insertions(+), 1279 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/img,boston-clock.txt
 create mode 100644 Documentation/devicetree/bindings/misc/mti,mips-cdmm.txt
 create mode 100644 Documentation/devicetree/bindings/misc/mti,mips-cpc.txt
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
 create mode 100644 drivers/clk/clk-boston.c
 create mode 100644 include/dt-bindings/clock/boston-clock.h

-- 
2.9.3
