Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2016 18:53:02 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33971 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993107AbcKVRwyri88E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Nov 2016 18:52:54 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id DAF6BF0846EAB;
        Tue, 22 Nov 2016 17:52:44 +0000 (GMT)
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 22 Nov 2016 17:52:48 +0000
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <ralf@linux-mips.org>
CC:     <Zubair.Kakakhel@imgtec.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] MIPS: xilfpga: Use irq-xilinx-intc
Date:   Tue, 22 Nov 2016 17:52:37 +0000
Message-ID: <20161122175243.8853-1-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 2.10.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55847
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

The interrupt controller driver was in arch/microblaze.
The patches to move the driver out from arch/microblaze
to drivers/irqchip/irq-xilinx-intc.c have now been accepted [1]

Hence, xilfpga can make use of the driver in v4.10.

These patches do the following:
- Use the irqchip driver
- Add Device Tree nodes for various peripherals that were blocked
- Enable those drivers in the defconfig

Based on v4.9-rc6

Regards,
ZubairLK

[1] https://lkml.org/lkml/2016/11/22/186

Zubair Lutfullah Kakakhel (6):
  MIPS: xilfpga: Use irqchip instead of the legacy way
  MIPS: xilfpga: Use Xilinx Interrupt Controller
  MIPS: xilfpga: Update DT node and specify uart irq
  MIPS: xilfpga: Add DT node for AXI I2C
  MIPS: xilfpga: Add DT node for AXI emaclite
  MIPS: xilfpga: Update defconfig

 arch/mips/Kconfig                        |  1 +
 arch/mips/boot/dts/xilfpga/nexys4ddr.dts | 63 ++++++++++++++++++++++++++++++++
 arch/mips/configs/xilfpga_defconfig      | 37 ++++++++++++++++++-
 arch/mips/xilfpga/intc.c                 |  7 +---
 4 files changed, 102 insertions(+), 6 deletions(-)

-- 
2.10.2
