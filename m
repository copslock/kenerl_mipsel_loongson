Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 15:44:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59433 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992474AbcHRNoIIczTI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 15:44:08 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 0F7B878CADB8C;
        Thu, 18 Aug 2016 14:43:49 +0100 (IST)
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 18 Aug 2016 14:43:51 +0100
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <monstr@monstr.eu>, <ralf@linux-mips.org>, <tglx@linutronix.de>
CC:     <jason@lakedaemon.net>, <marc.zyngier@arm.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH V2 00/10] microblaze/MIPS: xilfpga: intc and peripheral
Date:   Thu, 18 Aug 2016 14:43:14 +0100
Message-ID: <1471527804-26175-1-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

Hi,

The MIPS based Xilfpga platform uses the axi interrupt controller
daisy chained to the MIPS microAptiv cpu interrupt controller.
This patch series moves the axi interrupt controller driver out
of arch/microblaze to drivers/irqchip. This makes it usable by
MIPS. The rest of the series basically enables drivers and adds dt
nodes.

Would make sense for this to go via the MIPS tree.
Hence, ACKs from microblaze. irqchip and net welcome.

Compile tested on microblaze-el only!
Based on v4.8-rc2

Regards,
ZubairLK

V1 -> V2
Resubmitting without truncating the diff output for file moves
Removed accidental local mac address entry
Individual logs have more detail

Zubair Lutfullah Kakakhel (10):
  microblaze: irqchip: Move intc driver to irqchip
  irqchip: xilinx: Add support for parent intc
  MIPS: xilfpga: Use irqchip_init instead of the legacy way
  MIPS: xilfpga: Use Xilinx AXI Interrupt Controller
  MIPS: xilfpga: Update DT node and specify uart irq
  MIPS: Xilfpga: Add DT node for AXI I2C
  net: ethernet: xilinx: Generate random mac if none found
  net: ethernet: xilinx: Enable emaclite for MIPS
  MIPS: xilfpga: Add DT node for AXI emaclite
  MIPS: xilfpga: Update defconfig

 arch/microblaze/Kconfig                       |   1 +
 arch/microblaze/kernel/Makefile               |   2 +-
 arch/microblaze/kernel/intc.c                 | 196 -----------------------
 arch/mips/Kconfig                             |   1 +
 arch/mips/boot/dts/xilfpga/nexys4ddr.dts      |  63 ++++++++
 arch/mips/configs/xilfpga_defconfig           |  37 ++++-
 arch/mips/xilfpga/intc.c                      |   7 +-
 drivers/irqchip/Kconfig                       |   4 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-axi-intc.c                | 222 ++++++++++++++++++++++++++
 drivers/net/ethernet/xilinx/Kconfig           |   4 +-
 drivers/net/ethernet/xilinx/xilinx_emaclite.c |   6 +-
 12 files changed, 337 insertions(+), 207 deletions(-)
 delete mode 100644 arch/microblaze/kernel/intc.c
 create mode 100644 drivers/irqchip/irq-axi-intc.c

-- 
1.9.1
