Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Dec 2013 12:16:12 +0100 (CET)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:63752 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6867263Ab3LULLKVmjOV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Dec 2013 12:11:10 +0100
X-IronPort-AV: E=Sophos;i="4.95,527,1384329600"; 
   d="scan'208";a="4638695"
Received: from irvexchcas06.broadcom.com (HELO IRVEXCHCAS06.corp.ad.broadcom.com) ([10.9.208.53])
  by mail-gw1-out.broadcom.com with ESMTP; 21 Dec 2013 03:17:16 -0800
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP Server
 (TLS) id 14.1.438.0; Sat, 21 Dec 2013 03:11:09 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.1.438.0; Sat, 21 Dec 2013 03:11:08 -0800
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 C3D22246A7;    Sat, 21 Dec 2013 03:11:05 -0800 (PST)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Ganesan Ramalingam <ganesanr@broadcom.com>, <ralf@linux-mips.org>,
        Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 16/18] MIPS: Netlogic: XLP9XX USB support
Date:   Sat, 21 Dec 2013 16:52:28 +0530
Message-ID: <1387624950-31297-17-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1387624950-31297-1-git-send-email-jchandra@broadcom.com>
References: <1387624950-31297-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38789
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

From: Ganesan Ramalingam <ganesanr@broadcom.com>

XLP9XX has a USB 3.0 controller on-chip with 2 xHCI ports. The USB
block is similar to the one on XLP2XX, so update usb-init-xlp2.c
to handle XLP9XX as well.

Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/iomap.h |    3 +
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h   |    2 +
 arch/mips/netlogic/xlp/nlm_hal.c               |    4 ++
 arch/mips/netlogic/xlp/usb-init-xlp2.c         |   88 ++++++++++++++++++++----
 4 files changed, 84 insertions(+), 13 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/iomap.h b/arch/mips/include/asm/netlogic/xlp-hal/iomap.h
index 92fd866..1f23dfa 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/iomap.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/iomap.h
@@ -188,6 +188,9 @@
 #define PCI_DEVICE_ID_NLM_MMC		0x1018
 #define PCI_DEVICE_ID_NLM_XHCI		0x101d
 
+#define PCI_DEVICE_ID_XLP9XX_SATA	0x901A
+#define PCI_DEVICE_ID_XLP9XX_XHCI	0x901D
+
 #ifndef __ASSEMBLY__
 
 #define nlm_read_pci_reg(b, r)		nlm_read_reg(b, r)
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
index 120c003..2b0c959 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
@@ -50,6 +50,8 @@
 #define PIC_2XX_XHCI_0_IRQ		23
 #define PIC_2XX_XHCI_1_IRQ		24
 #define PIC_2XX_XHCI_2_IRQ		25
+#define PIC_9XX_XHCI_0_IRQ		23
+#define PIC_9XX_XHCI_1_IRQ		24
 
 #define PIC_MMC_IRQ			29
 #define PIC_I2C_0_IRQ			30
diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index e7ff2d3..997cd9e 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -72,6 +72,10 @@ int nlm_irq_to_irt(int irq)
 	/* bypass for 9xx */
 	if (cpu_is_xlp9xx()) {
 		switch (irq) {
+		case PIC_9XX_XHCI_0_IRQ:
+			return 114;
+		case PIC_9XX_XHCI_1_IRQ:
+			return 115;
 		case PIC_UART_0_IRQ:
 			return 133;
 		case PIC_UART_1_IRQ:
diff --git a/arch/mips/netlogic/xlp/usb-init-xlp2.c b/arch/mips/netlogic/xlp/usb-init-xlp2.c
index 36e9c22..17ade1c 100644
--- a/arch/mips/netlogic/xlp/usb-init-xlp2.c
+++ b/arch/mips/netlogic/xlp/usb-init-xlp2.c
@@ -37,6 +37,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/pci_ids.h>
 #include <linux/platform_device.h>
 #include <linux/irq.h>
 
@@ -83,12 +84,14 @@
 #define nlm_read_usb_reg(b, r)		nlm_read_reg(b, r)
 #define nlm_write_usb_reg(b, r, v)	nlm_write_reg(b, r, v)
 
-#define nlm_xlpii_get_usb_pcibase(node, inst)		\
-	nlm_pcicfg_base(XLP2XX_IO_USB_OFFSET(node, inst))
+#define nlm_xlpii_get_usb_pcibase(node, inst)			\
+			nlm_pcicfg_base(cpu_is_xlp9xx() ?	\
+			XLP9XX_IO_USB_OFFSET(node, inst) :	\
+			XLP2XX_IO_USB_OFFSET(node, inst))
 #define nlm_xlpii_get_usb_regbase(node, inst)		\
 	(nlm_xlpii_get_usb_pcibase(node, inst) + XLP_IO_PCI_HDRSZ)
 
-static void xlpii_usb_ack(struct irq_data *data)
+static void xlp2xx_usb_ack(struct irq_data *data)
 {
 	u64 port_addr;
 
@@ -109,6 +112,29 @@ static void xlpii_usb_ack(struct irq_data *data)
 	nlm_write_usb_reg(port_addr, XLPII_USB3_INT_REG, 0xffffffff);
 }
 
+static void xlp9xx_usb_ack(struct irq_data *data)
+{
+	u64 port_addr;
+	int node, irq;
+
+	/* Find the node and irq on the node */
+	irq = data->irq % NLM_IRQS_PER_NODE;
+	node = data->irq / NLM_IRQS_PER_NODE;
+
+	switch (irq) {
+	case PIC_9XX_XHCI_0_IRQ:
+		port_addr = nlm_xlpii_get_usb_regbase(node, 1);
+		break;
+	case PIC_9XX_XHCI_1_IRQ:
+		port_addr = nlm_xlpii_get_usb_regbase(node, 2);
+		break;
+	default:
+		pr_err("No matching USB irq %d node  %d!\n", irq, node);
+		return;
+	}
+	nlm_write_usb_reg(port_addr, XLPII_USB3_INT_REG, 0xffffffff);
+}
+
 static void nlm_xlpii_usb_hw_reset(int node, int port)
 {
 	u64 port_addr, xhci_base, pci_base;
@@ -178,17 +204,33 @@ static void nlm_xlpii_usb_hw_reset(int node, int port)
 
 static int __init nlm_platform_xlpii_usb_init(void)
 {
+	int node;
+
 	if (!cpu_is_xlpii())
 		return 0;
 
-	pr_info("Initializing 2XX USB Interface\n");
-	nlm_xlpii_usb_hw_reset(0, 1);
-	nlm_xlpii_usb_hw_reset(0, 2);
-	nlm_xlpii_usb_hw_reset(0, 3);
-	nlm_set_pic_extra_ack(0, PIC_2XX_XHCI_0_IRQ, xlpii_usb_ack);
-	nlm_set_pic_extra_ack(0, PIC_2XX_XHCI_1_IRQ, xlpii_usb_ack);
-	nlm_set_pic_extra_ack(0, PIC_2XX_XHCI_2_IRQ, xlpii_usb_ack);
+	if (!cpu_is_xlp9xx()) {
+		/* XLP 2XX single node */
+		pr_info("Initializing 2XX USB Interface\n");
+		nlm_xlpii_usb_hw_reset(0, 1);
+		nlm_xlpii_usb_hw_reset(0, 2);
+		nlm_xlpii_usb_hw_reset(0, 3);
+		nlm_set_pic_extra_ack(0, PIC_2XX_XHCI_0_IRQ, xlp2xx_usb_ack);
+		nlm_set_pic_extra_ack(0, PIC_2XX_XHCI_1_IRQ, xlp2xx_usb_ack);
+		nlm_set_pic_extra_ack(0, PIC_2XX_XHCI_2_IRQ, xlp2xx_usb_ack);
+		return 0;
+	}
 
+	/* XLP 9XX, multi-node */
+	pr_info("Initializing 9XX USB Interface\n");
+	for (node = 0; node < NLM_NR_NODES; node++) {
+		if (!nlm_node_present(node))
+			continue;
+		nlm_xlpii_usb_hw_reset(node, 1);
+		nlm_xlpii_usb_hw_reset(node, 2);
+		nlm_set_pic_extra_ack(node, PIC_9XX_XHCI_0_IRQ, xlp9xx_usb_ack);
+		nlm_set_pic_extra_ack(node, PIC_9XX_XHCI_1_IRQ, xlp9xx_usb_ack);
+	}
 	return 0;
 }
 
@@ -196,8 +238,26 @@ arch_initcall(nlm_platform_xlpii_usb_init);
 
 static u64 xlp_usb_dmamask = ~(u32)0;
 
-/* Fixup IRQ for USB devices on XLP the SoC PCIe bus */
-static void nlm_usb_fixup_final(struct pci_dev *dev)
+/* Fixup the IRQ for USB devices which is exist on XLP9XX SOC PCIE bus */
+static void nlm_xlp9xx_usb_fixup_final(struct pci_dev *dev)
+{
+	int node;
+
+	node = xlp_socdev_to_node(dev);
+	dev->dev.dma_mask		= &xlp_usb_dmamask;
+	dev->dev.coherent_dma_mask	= DMA_BIT_MASK(32);
+	switch (dev->devfn) {
+	case 0x21:
+		dev->irq = nlm_irq_to_xirq(node, PIC_9XX_XHCI_0_IRQ);
+		break;
+	case 0x22:
+		dev->irq = nlm_irq_to_xirq(node, PIC_9XX_XHCI_1_IRQ);
+		break;
+	}
+}
+
+/* Fixup the IRQ for USB devices which is exist on XLP2XX SOC PCIE bus */
+static void nlm_xlp2xx_usb_fixup_final(struct pci_dev *dev)
 {
 	dev->dev.dma_mask		= &xlp_usb_dmamask;
 	dev->dev.coherent_dma_mask	= DMA_BIT_MASK(32);
@@ -214,5 +274,7 @@ static void nlm_usb_fixup_final(struct pci_dev *dev)
 	}
 }
 
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_XLP9XX_XHCI,
+		nlm_xlp9xx_usb_fixup_final);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_NETLOGIC, PCI_DEVICE_ID_NLM_XHCI,
-		nlm_usb_fixup_final);
+		nlm_xlp2xx_usb_fixup_final);
-- 
1.7.9.5
