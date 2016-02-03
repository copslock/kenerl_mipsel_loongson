Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 12:31:13 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40288 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012118AbcBCLbLdAjFM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 12:31:11 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id E305AA408D917;
        Wed,  3 Feb 2016 11:31:02 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 11:31:04 +0000
Received: from localhost (10.100.200.105) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 11:31:03 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Joshua Kinard <kumba@gentoo.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jiri Slaby <jslaby@suse.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Zubair Lutfullah Kakakhel" <Zubair.Kakakhel@imgtec.com>,
        Kumar Gala <galak@codeaurora.org>,
        Yijing Wang <wangyijing@huawei.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        "John Crispin" <blogic@openwrt.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ray Jui <rjui@broadcom.com>,
        Richard Cochran <richardcochran@gmail.com>,
        =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "Andrew Bresticker" <abrestic@chromium.org>,
        Russell Joyce <russell.joyce@york.ac.uk>,
        Scott Branden <sbranden@broadcom.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        "Pawel Moll" <pawel.moll@arm.com>, <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Ley Foon Tan" <lftan@altera.com>, <devicetree@vger.kernel.org>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@osg.samsung.com>,
        Jens Axboe <axboe@fb.com>, Duc Dang <dhdang@apm.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        "David S. Miller" <davem@davemloft.net>,
        Joe Perches <joe@perches.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Yinghai Lu <yinghai@kernel.org>, <dmaengine@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 00/15] MIPS Boston board support
Date:   Wed, 3 Feb 2016 11:30:30 +0000
Message-ID: <1454499045-5020-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.105]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51661
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

This series introduces support for the Imagination Technologies MIPS
Boston development board. Boston is an FPGA-based development board
akin to the much older Malta board, built around a Xilinx FPGA running
a MIPS CPU & other logic including a PCIe root port connected to an
Intel EG20T Platform Controller Hub. This provides a base set of
peripherals including SATA, USB, SD/MMC, ethernet, I2C & GPIOs. PCIe
slots are also present for expansion.

v2 of this series splits out the pch_gbe ethernet driver changes to a
separate series, but keeps the Xilinx PCIe driver changes since PCIe is
so central to the Boston board & the series has shrunk somewhat since
its earlier submission.

Applies atop v4.5-rc2.

Paul Burton (15):
  dt-bindings: ascii-lcd: Document a binding for simple ASCII LCDs
  auxdisplay: driver for simple memory mapped ASCII LCD displays
  MIPS: PCI: Compatibility with ARM-like PCI host drivers
  PCI: xilinx: Keep references to both IRQ domains
  PCI: xilinx: Unify INTx & MSI interrupt FIFO decode
  PCI: xilinx: Always clear interrupt decode register
  PCI: xilinx: Clear interrupt FIFO during probe
  PCI: xilinx: Fix INTX irq dispatch
  PCI: xilinx: Allow build on MIPS platforms
  misc: pch_phub: Allow build on MIPS platforms
  dmaengine: pch_dma: Allow build on MIPS platforms
  ptp: pch: Allow build on MIPS platforms
  MIPS: Support for generating FIT (.itb) images
  dt-bindings: mips: img,boston: Document img,boston binding
  MIPS: Boston board support

 Documentation/devicetree/bindings/ascii-lcd.txt    |  10 +
 .../devicetree/bindings/mips/img/boston.txt        |  15 ++
 MAINTAINERS                                        |  14 ++
 arch/mips/Kbuild.platforms                         |   1 +
 arch/mips/Kconfig                                  |  48 +++++
 arch/mips/Makefile                                 |   6 +-
 arch/mips/boot/Makefile                            |  61 ++++++
 arch/mips/boot/dts/Makefile                        |   1 +
 arch/mips/boot/dts/img/Makefile                    |   7 +
 arch/mips/boot/dts/img/boston.dts                  | 204 ++++++++++++++++++
 arch/mips/boot/skeleton.its                        |  24 +++
 arch/mips/boston/Makefile                          |  12 ++
 arch/mips/boston/Platform                          |   8 +
 arch/mips/boston/init.c                            | 106 ++++++++++
 arch/mips/boston/int.c                             |  33 +++
 arch/mips/boston/time.c                            |  89 ++++++++
 arch/mips/boston/vmlinux.its                       |  23 ++
 arch/mips/configs/boston_defconfig                 | 173 +++++++++++++++
 .../asm/mach-boston/cpu-feature-overrides.h        |  26 +++
 arch/mips/include/asm/mach-boston/irq.h            |  18 ++
 arch/mips/include/asm/mach-boston/spaces.h         |  20 ++
 arch/mips/include/asm/pci.h                        |  67 +++++-
 arch/mips/lib/iomap-pci.c                          |   2 +-
 arch/mips/pci/Makefile                             |   6 +
 arch/mips/pci/pci-generic.c                        | 138 ++++++++++++
 arch/mips/pci/pci-legacy.c                         | 232 +++++++++++++++++++++
 arch/mips/pci/pci.c                                | 226 +-------------------
 drivers/auxdisplay/Kconfig                         |   7 +
 drivers/auxdisplay/Makefile                        |   1 +
 drivers/auxdisplay/ascii-lcd.c                     | 230 ++++++++++++++++++++
 drivers/dma/Kconfig                                |   2 +-
 drivers/misc/Kconfig                               |   2 +-
 drivers/pci/host/Kconfig                           |   2 +-
 drivers/pci/host/pcie-xilinx.c                     | 125 ++++++-----
 drivers/ptp/Kconfig                                |   2 +-
 35 files changed, 1649 insertions(+), 292 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ascii-lcd.txt
 create mode 100644 Documentation/devicetree/bindings/mips/img/boston.txt
 create mode 100644 arch/mips/boot/dts/img/Makefile
 create mode 100644 arch/mips/boot/dts/img/boston.dts
 create mode 100644 arch/mips/boot/skeleton.its
 create mode 100644 arch/mips/boston/Makefile
 create mode 100644 arch/mips/boston/Platform
 create mode 100644 arch/mips/boston/init.c
 create mode 100644 arch/mips/boston/int.c
 create mode 100644 arch/mips/boston/time.c
 create mode 100644 arch/mips/boston/vmlinux.its
 create mode 100644 arch/mips/configs/boston_defconfig
 create mode 100644 arch/mips/include/asm/mach-boston/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-boston/irq.h
 create mode 100644 arch/mips/include/asm/mach-boston/spaces.h
 create mode 100644 arch/mips/pci/pci-generic.c
 create mode 100644 arch/mips/pci/pci-legacy.c
 create mode 100644 drivers/auxdisplay/ascii-lcd.c

-- 
2.7.0
