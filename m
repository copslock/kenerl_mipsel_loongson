Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 17:23:59 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30655 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007995AbbK3QXdNPhtz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 17:23:33 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 8E8B12863BB64;
        Mon, 30 Nov 2015 16:23:24 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 30 Nov 2015 16:23:27 +0000
Received: from localhost (10.100.200.236) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 30 Nov
 2015 16:23:26 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "Jiang Liu" <jiang.liu@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>,
        Russell Joyce <russell.joyce@york.ac.uk>,
        Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 05/28] PCI: xilinx: keep references to both IRQ domains
Date:   Mon, 30 Nov 2015 16:21:30 +0000
Message-ID: <1448900513-20856-6-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.236]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50186
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

pcie-xilinx creates 2 IRQ domains when built with MSI support: one for
MSI interrupts & one for legacy INTx interrupts. However, it only kept a
reference to the MSI IRQ domain. This means that any INTx interrupts
that may occur would be mapped using the wrong domain, and that only the
MSI IRQ domain would be removed along with the driver. Track both IRQ
domains & clean up both as appropriate.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 drivers/pci/host/pcie-xilinx.c | 58 ++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 3c7a0d5..c412a37 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -105,6 +105,7 @@
  * @root_busno: Root Bus number
  * @dev: Device pointer
  * @irq_domain: IRQ domain pointer
+ * @msi_irq_domain: MSI IRQ domain pointer
  * @bus_range: Bus range
  * @resources: Bus Resources
  */
@@ -115,6 +116,7 @@ struct xilinx_pcie_port {
 	u8 root_busno;
 	struct device *dev;
 	struct irq_domain *irq_domain;
+	struct irq_domain *msi_irq_domain;
 	struct resource bus_range;
 	struct list_head resources;
 };
@@ -291,7 +293,7 @@ static int xilinx_pcie_msi_setup_irq(struct msi_controller *chip,
 	if (hwirq < 0)
 		return hwirq;
 
-	irq = irq_create_mapping(port->irq_domain, hwirq);
+	irq = irq_create_mapping(port->msi_irq_domain, hwirq);
 	if (!irq)
 		return -EINVAL;
 
@@ -517,31 +519,21 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 
 /**
  * xilinx_pcie_free_irq_domain - Free IRQ domain
- * @port: PCIe port information
+ * @domain: the IRQ domain to free
+ * @nr: the number of IRQs in the domain
  */
-static void xilinx_pcie_free_irq_domain(struct xilinx_pcie_port *port)
+static void xilinx_pcie_free_irq_domain(struct irq_domain *domain, int nr)
 {
 	int i;
-	u32 irq, num_irqs;
-
-	/* Free IRQ Domain */
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-
-		free_pages(port->msi_pages, 0);
-
-		num_irqs = XILINX_NUM_MSI_IRQS;
-	} else {
-		/* INTx */
-		num_irqs = 4;
-	}
+	u32 irq;
 
-	for (i = 0; i < num_irqs; i++) {
-		irq = irq_find_mapping(port->irq_domain, i);
+	for (i = 0; i < nr; i++) {
+		irq = irq_find_mapping(domain, i);
 		if (irq > 0)
 			irq_dispose_mapping(irq);
 	}
 
-	irq_domain_remove(port->irq_domain);
+	irq_domain_remove(domain);
 }
 
 /**
@@ -571,20 +563,20 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 		return PTR_ERR(port->irq_domain);
 	}
 
-	/* Setup MSI */
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		port->irq_domain = irq_domain_add_linear(node,
-							 XILINX_NUM_MSI_IRQS,
-							 &msi_domain_ops,
-							 &xilinx_pcie_msi_chip);
-		if (!port->irq_domain) {
-			dev_err(dev, "Failed to get a MSI IRQ domain\n");
-			return PTR_ERR(port->irq_domain);
-		}
+	if (!IS_ENABLED(CONFIG_PCI_MSI))
+		return 0;
 
-		xilinx_pcie_enable_msi(port);
+	/* Setup MSI */
+	port->msi_irq_domain = irq_domain_add_linear(node,
+						     XILINX_NUM_MSI_IRQS,
+						     &msi_domain_ops,
+						     &xilinx_pcie_msi_chip);
+	if (!port->msi_irq_domain) {
+		dev_err(dev, "Failed to get a MSI IRQ domain\n");
+		return PTR_ERR(port->msi_irq_domain);
 	}
 
+	xilinx_pcie_enable_msi(port);
 	return 0;
 }
 
@@ -868,7 +860,13 @@ static int xilinx_pcie_remove(struct platform_device *pdev)
 {
 	struct xilinx_pcie_port *port = platform_get_drvdata(pdev);
 
-	xilinx_pcie_free_irq_domain(port);
+	xilinx_pcie_free_irq_domain(port->irq_domain, 4);
+
+	if (config_enabled(CONFIG_MSI)) {
+		free_pages(port->msi_pages, 0);
+		xilinx_pcie_free_irq_domain(port->msi_irq_domain,
+					    XILINX_NUM_MSI_IRQS);
+	}
 
 	return 0;
 }
-- 
2.6.2
