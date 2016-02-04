Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 17:12:34 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62963 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012696AbcBDQMdFUEB8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2016 17:12:33 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 37BDD8AF786BA;
        Thu,  4 Feb 2016 16:12:24 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 4 Feb 2016 16:12:27 +0000
Received: from localhost (10.100.200.26) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 4 Feb
 2016 16:12:17 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Bharat Kumar Gogada <bharatku@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        "Paul Burton" <paul.burton@imgtec.com>,
        Ley Foon Tan <lftan@altera.com>,
        "Arnd Bergmann" <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        "Scott Branden" <sbranden@broadcom.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        <linux-kernel@vger.kernel.org>, Duc Dang <dhdang@apm.com>,
        <linux-pci@vger.kernel.org>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ray Jui <rjui@broadcom.com>, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v3 6/6] PCI: xilinx: Allow build on MIPS platforms
Date:   Thu, 4 Feb 2016 16:10:13 +0000
Message-ID: <1454602213-967-7-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454602213-967-1-git-send-email-paul.burton@imgtec.com>
References: <1454602213-967-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.26]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51785
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

Allow the xilinx-pcie driver to be built on MIPS platforms. This will be
used on the MIPS Boston board.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>

---

Changes in v3:
- Split out from Boston patchset.

Changes in v2: None

 drivers/pci/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 75a6054..0aee193 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -81,7 +81,7 @@ config PCI_KEYSTONE
 
 config PCIE_XILINX
 	bool "Xilinx AXI PCIe host bridge support"
-	depends on ARCH_ZYNQ
+	depends on ARCH_ZYNQ || MIPS
 	help
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
 	  Host Bridge driver.
-- 
2.7.0
