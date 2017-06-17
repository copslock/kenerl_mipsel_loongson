Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jun 2017 21:58:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64137 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994897AbdFQT6FdMRfh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Jun 2017 21:58:05 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 2C29244DF9E90;
        Sat, 17 Jun 2017 20:57:54 +0100 (IST)
Received: from localhost (10.20.78.225) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sat, 17 Jun
 2017 20:57:58 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bharat Kumar Gogada <bharatku@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-mips@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v5 0/4] PCI: xilinx: Fixes, optimisation & MIPS support
Date:   Sat, 17 Jun 2017 12:57:37 -0700
Message-ID: <20170617195741.12757-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.78.225]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58586
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

Applies atop v4.12-rc5.

Paul Burton (4):
  PCI: xilinx: Create legacy IRQ domain with size 5
  PCI: xilinx: Unify INTx & MSI interrupt decode
  PCI: xilinx: Don't enable config completion interrupts
  PCI: xilinx: Allow build on MIPS platforms

 drivers/pci/host/Kconfig       |  2 +-
 drivers/pci/host/pcie-xilinx.c | 55 +++++++++++++++---------------------------
 2 files changed, 20 insertions(+), 37 deletions(-)

-- 
2.13.1
