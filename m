Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 12:32:43 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52105 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012172AbcBCLcYb311M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 12:32:24 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 0B2C95DDF5823;
        Wed,  3 Feb 2016 11:32:16 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 11:32:18 +0000
Received: from localhost (10.100.200.105) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 11:32:17 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "Jiang Liu" <jiang.liu@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Russell Joyce <russell.joyce@york.ac.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Jingoo Han" <jingoohan1@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 05/15] PCI: xilinx: Unify INTx & MSI interrupt FIFO decode
Date:   Wed, 3 Feb 2016 11:30:35 +0000
Message-ID: <1454499045-5020-6-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454499045-5020-1-git-send-email-paul.burton@imgtec.com>
References: <1454499045-5020-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.105]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51666
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

When decoding either an INTx or MSI interrupt, the driver has no way to
know which it will pull out of the interrupt FIFO. If both were pending
then this would lead to either the interrupt being handled incorrectly
(MSI interrupt treated as INTx) or not at all (INTx interrupt dropped by
MSI path). Unify the reading of the interrupt FIFO & act according to
the type of interrupt actually read.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 8961def56845 ("PCI: xilinx: Add Xilinx AXI PCIe Host Bridge IP driver")

---

Changes in v2:
- Add Fixes tag.

 drivers/pci/host/pcie-xilinx.c | 47 +++++++++++++-----------------------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 1490bd1..afdfb09 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -397,7 +397,7 @@ static const struct irq_domain_ops intx_domain_ops = {
 static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 {
 	struct xilinx_pcie_port *port = (struct xilinx_pcie_port *)data;
-	u32 val, mask, status, msi_data;
+	u32 val, mask, status;
 
 	/* Read interrupt decode and mask registers */
 	val = pcie_read(port, XILINX_PCIE_REG_IDR);
@@ -437,8 +437,8 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 		xilinx_pcie_clear_err_interrupts(port);
 	}
 
-	if (status & XILINX_PCIE_INTR_INTX) {
-		/* INTx interrupt received */
+	if (status & (XILINX_PCIE_INTR_INTX | XILINX_PCIE_INTR_MSI)) {
+		/* Interrupt received */
 		val = pcie_read(port, XILINX_PCIE_REG_RPIFR1);
 
 		/* Check whether interrupt valid */
@@ -447,41 +447,22 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 			return IRQ_HANDLED;
 		}
 
-		if (!(val & XILINX_PCIE_RPIFR1_MSI_INTR)) {
-			/* Clear interrupt FIFO register 1 */
-			pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
-				   XILINX_PCIE_REG_RPIFR1);
-
-			/* Handle INTx Interrupt */
+		if (val & XILINX_PCIE_RPIFR1_MSI_INTR) {
+			irq = pcie_read(port, XILINX_PCIE_REG_RPIFR2) &
+				XILINX_PCIE_RPIFR2_MSG_DATA;
+		} else {
 			val = ((val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
 				XILINX_PCIE_RPIFR1_INTR_SHIFT) + 1;
-			generic_handle_irq(irq_find_mapping(port->irq_domain,
-							    val));
+			irq = irq_find_mapping(port->irq_domain, val);
 		}
-	}
 
-	if (status & XILINX_PCIE_INTR_MSI) {
-		/* MSI Interrupt */
-		val = pcie_read(port, XILINX_PCIE_REG_RPIFR1);
+		/* Clear interrupt FIFO register 1 */
+		pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
+			   XILINX_PCIE_REG_RPIFR1);
 
-		if (!(val & XILINX_PCIE_RPIFR1_INTR_VALID)) {
-			dev_warn(port->dev, "RP Intr FIFO1 read error\n");
-			return IRQ_HANDLED;
-		}
-
-		if (val & XILINX_PCIE_RPIFR1_MSI_INTR) {
-			msi_data = pcie_read(port, XILINX_PCIE_REG_RPIFR2) &
-				   XILINX_PCIE_RPIFR2_MSG_DATA;
-
-			/* Clear interrupt FIFO register 1 */
-			pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
-				   XILINX_PCIE_REG_RPIFR1);
-
-			if (IS_ENABLED(CONFIG_PCI_MSI)) {
-				/* Handle MSI Interrupt */
-				generic_handle_irq(msi_data);
-			}
-		}
+		if (IS_ENABLED(CONFIG_PCI_MSI) ||
+			!(val & XILINX_PCIE_RPIFR1_MSI_INTR))
+			generic_handle_irq(irq);
 	}
 
 	if (status & XILINX_PCIE_INTR_SLV_UNSUPP)
-- 
2.7.0
