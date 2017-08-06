Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Aug 2017 02:06:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59484 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23995109AbdHFAGGjzqc0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Aug 2017 02:06:06 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id CF6618E247BD8;
        Sun,  6 Aug 2017 01:05:55 +0100 (IST)
Received: from localhost (10.20.79.108) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 6 Aug
 2017 01:06:00 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC:     Bharat Kumar Gogada <bharatku@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        <linux-mips@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v6 6/6] PCI: xilinx: Allow build on MIPS platforms
Date:   Sat, 5 Aug 2017 17:03:51 -0700
Message-ID: <20170806000351.17952-7-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.4
In-Reply-To: <20170806000351.17952-1-paul.burton@imgtec.com>
References: <20170806000351.17952-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.108]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59384
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

Allow the xilinx-pcie driver to be built on MIPS platforms which make
use of generic PCI drivers rather than legacy MIPS-specific interfaces.
This is used on the MIPS Boston development board.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Bharat Kumar Gogada <bharatku@xilinx.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Ravikiran Gummaluri <rgummal@xilinx.com>
Cc: linux-pci@vger.kernel.org

---

Changes in v6: None
Changes in v5: None

Changes in v4:
- Depend on PCI_DRIVERS_GENERIC, which the driver won't work on MIPS without.

Changes in v3:
- Split out from Boston patchset.

Changes in v2: None

 drivers/pci/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 89d61c2cbfaa..eb8c30828011 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -71,7 +71,7 @@ config PCI_HOST_GENERIC
 
 config PCIE_XILINX
 	bool "Xilinx AXI PCIe host bridge support"
-	depends on ARCH_ZYNQ || MICROBLAZE
+	depends on ARCH_ZYNQ || MICROBLAZE || (MIPS && PCI_DRIVERS_GENERIC)
 	help
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
 	  Host Bridge driver.
-- 
2.13.4
