Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 17:10:40 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5896 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012696AbcBDQKigyC08 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2016 17:10:38 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 8909365434A23;
        Thu,  4 Feb 2016 16:10:29 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 4 Feb 2016 16:10:32 +0000
Received: from localhost (10.100.200.26) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 4 Feb
 2016 16:10:29 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Bharat Kumar Gogada <bharatku@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        "Paul Burton" <paul.burton@imgtec.com>,
        Ley Foon Tan <lftan@altera.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Russell Joyce <russell.joyce@york.ac.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ray Jui <rjui@broadcom.com>,
        =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
        Scott Branden <sbranden@broadcom.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        "Rob Herring" <robh@kernel.org>, Duc Dang <dhdang@apm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v3 0/6] Xilinx AXI PCIe Host Bridge driver fixes
Date:   Thu, 4 Feb 2016 16:10:07 +0000
Message-ID: <1454602213-967-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.26]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51779
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

This series fixes a number of issues found using the Xilinx AXI PCIe
Host Bridge IP on the Imagination Technologies MIPS Boston development
board. It has been split out of the larger Boston board support series
at Michal's request.

Applies atop v4.5-rc2.

Paul Burton (6):
  PCI: xilinx: Keep references to both IRQ domains
  PCI: xilinx: Unify INTx & MSI interrupt FIFO decode
  PCI: xilinx: Always clear interrupt decode register
  PCI: xilinx: Clear interrupt FIFO during probe
  PCI: xilinx: Fix INTX irq dispatch
  PCI: xilinx: Allow build on MIPS platforms

 drivers/pci/host/Kconfig       |   2 +-
 drivers/pci/host/pcie-xilinx.c | 125 +++++++++++++++++++----------------------
 2 files changed, 60 insertions(+), 67 deletions(-)

-- 
2.7.0
