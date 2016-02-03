Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 12:33:19 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54192 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012155AbcBCLczoGJPM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 12:32:55 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 3E880BFD97783;
        Wed,  3 Feb 2016 11:32:48 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 11:32:49 +0000
Received: from localhost (10.100.200.105) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 11:32:49 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "Jiang Liu" <jiang.liu@linux.intel.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>,
        Russell Joyce <russell.joyce@york.ac.uk>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Jingoo Han" <jingoohan1@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 07/15] PCI: xilinx: Clear interrupt FIFO during probe
Date:   Wed, 3 Feb 2016 11:30:37 +0000
Message-ID: <1454499045-5020-8-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 51668
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

xilinx_pcie_init_port clears the pending interrupts in the interrupt
decode register, but does not clear the interrupt FIFO. This would lead
to spurious interrupts if any were present in the FIFO at probe time.
Clear the interrupt FIFO prior to the interrupt decode register in order
to start with a clean slate as expected.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 8961def56845 ("PCI: xilinx: Add Xilinx AXI PCIe Host Bridge IP driver")

---

Changes in v2:
- Add Fixes tag.

 drivers/pci/host/pcie-xilinx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 1eb74a2..6c5a503 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -568,6 +568,8 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
  */
 static void xilinx_pcie_init_port(struct xilinx_pcie_port *port)
 {
+	u32 val;
+
 	if (xilinx_pcie_link_is_up(port))
 		dev_info(port->dev, "PCIe Link is UP\n");
 	else
@@ -577,6 +579,17 @@ static void xilinx_pcie_init_port(struct xilinx_pcie_port *port)
 	pcie_write(port, ~XILINX_PCIE_IDR_ALL_MASK,
 		   XILINX_PCIE_REG_IMR);
 
+	/* Clear interrupt FIFO */
+	while (1) {
+		val = pcie_read(port, XILINX_PCIE_REG_RPIFR1);
+
+		if (!(val & XILINX_PCIE_RPIFR1_INTR_VALID))
+			break;
+
+		pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
+			   XILINX_PCIE_REG_RPIFR1);
+	}
+
 	/* Clear pending interrupts */
 	pcie_write(port, pcie_read(port, XILINX_PCIE_REG_IDR) &
 			 XILINX_PCIE_IMR_ALL_MASK,
-- 
2.7.0
