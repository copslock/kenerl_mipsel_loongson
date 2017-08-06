Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Aug 2017 02:04:27 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59975 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993965AbdHFAESpSzT0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Aug 2017 02:04:18 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A6767296EECEA;
        Sun,  6 Aug 2017 01:04:07 +0100 (IST)
Received: from localhost (10.20.79.108) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 6 Aug
 2017 01:04:12 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC:     Bharat Kumar Gogada <bharatku@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        <linux-mips@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v6 0/6] PCI: xilinx: Fixes, optimisation & MIPS support
Date:   Sat, 5 Aug 2017 17:03:45 -0700
Message-ID: <20170806000351.17952-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.108]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59378
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

This series fixes an issue found using INTx interrupts with the Xilinx
AXI PCIe Host Bridge IP on the Imagination Technologies MIPS Boston
development board, performs a couple of optimisations to interrupt
handling & allows the driver to be used on MIPS systems.

Applies atop v4.13-rc3.

Paul Burton (6):
  PCI: Move enum pci_interrupt_pin to a new common header
  PCI: Introduce pci_irqd_intx_xlate()
  PCI: xilinx: Translate INTx range to hwirqs 0-3
  PCI: xilinx: Unify INTx & MSI interrupt decode
  PCI: xilinx: Don't enable config completion interrupts
  PCI: xilinx: Allow build on MIPS platforms

 drivers/pci/host/Kconfig       |  2 +-
 drivers/pci/host/pcie-xilinx.c | 58 +++++++++++++++---------------------------
 include/linux/pci-common.h     | 31 ++++++++++++++++++++++
 include/linux/pci-epf.h        |  9 +------
 include/linux/pci.h            | 33 ++++++++++++++++++++++++
 5 files changed, 87 insertions(+), 46 deletions(-)
 create mode 100644 include/linux/pci-common.h

-- 
2.13.4
