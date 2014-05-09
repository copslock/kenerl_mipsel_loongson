Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2014 12:58:55 +0200 (CEST)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:14564 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843057AbaEIK6nZMMdr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 May 2014 12:58:43 +0200
X-IronPort-AV: E=Sophos;i="4.97,1017,1389772800"; 
   d="scan'208";a="28885169"
Received: from irvexchcas07.broadcom.com (HELO IRVEXCHCAS07.corp.ad.broadcom.com) ([10.9.208.55])
  by mail-gw1-out.broadcom.com with ESMTP; 09 May 2014 05:14:19 -0700
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Fri, 9 May 2014 03:58:35 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Fri, 9 May 2014 03:58:35 -0700
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 84C9F5D818;    Fri,  9 May 2014 03:58:32 -0700 (PDT)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>
Subject: [PATCH v2 09/17] MIPS: Netlogic: IRQ mapping for some more SoC blocks
Date:   Fri, 9 May 2014 16:35:34 +0530
Message-ID: <1399633534-23124-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <a69c93df8067c9bce9aeb7d9e6e3bf40e582e8e1.1398780013.git.jchandra@broadcom.com>
References: <a69c93df8067c9bce9aeb7d9e6e3bf40e582e8e1.1398780013.git.jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40052
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

Add IRQ to IRT (PIC interupt table index) mapping for SATA, GPIO, NAND
and SPI interfaces on the XLP SoC. Fix offsets for few blocks and add
device IDs for a few blocks.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
[v2: Fix GPIO irq]

 arch/mips/include/asm/netlogic/xlp-hal/iomap.h |   16 +++--
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h   |    4 ++
 arch/mips/netlogic/xlp/nlm_hal.c               |   84 ++++++++++++++++--------
 3 files changed, 69 insertions(+), 35 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/iomap.h b/arch/mips/include/asm/netlogic/xlp-hal/iomap.h
index 1f23dfa..14b2f51 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/iomap.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/iomap.h
@@ -74,6 +74,8 @@
 #define XLP_IO_USB_OHCI2_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 2, 4)
 #define XLP_IO_USB_OHCI3_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 2, 5)
 
+#define XLP_IO_SATA_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 3, 2)
+
 /* XLP2xx has an updated USB block */
 #define XLP2XX_IO_USB_OFFSET(node, i)	XLP_HDR_OFFSET(node, 0, 4, i)
 #define XLP2XX_IO_USB_XHCI0_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 4, 1)
@@ -103,13 +105,11 @@
 #define XLP_IO_SYS_OFFSET(node)		XLP_HDR_OFFSET(node, 0, 6, 5)
 #define XLP_IO_JTAG_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 6, 6)
 
+/* Flash */
 #define XLP_IO_NOR_OFFSET(node)		XLP_HDR_OFFSET(node, 0, 7, 0)
 #define XLP_IO_NAND_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 7, 1)
 #define XLP_IO_SPI_OFFSET(node)		XLP_HDR_OFFSET(node, 0, 7, 2)
-/* SD flash */
-#define XLP_IO_SD_OFFSET(node)		XLP_HDR_OFFSET(node, 0, 7, 3)
-#define XLP_IO_MMC_OFFSET(node, slot)	\
-		((XLP_IO_SD_OFFSET(node))+(slot*0x100)+XLP_IO_PCI_HDRSZ)
+#define XLP_IO_MMC_OFFSET(node)		XLP_HDR_OFFSET(node, 0, 7, 3)
 
 /* Things have changed drastically in XLP 9XX */
 #define XLP9XX_HDR_OFFSET(n, d, f)	\
@@ -135,11 +135,11 @@
 /* XLP9XX on-chip SATA controller */
 #define XLP9XX_IO_SATA_OFFSET(node)		XLP9XX_HDR_OFFSET(node, 3, 2)
 
+/* Flash */
 #define XLP9XX_IO_NOR_OFFSET(node)		XLP9XX_HDR_OFFSET(node, 7, 0)
 #define XLP9XX_IO_NAND_OFFSET(node)		XLP9XX_HDR_OFFSET(node, 7, 1)
 #define XLP9XX_IO_SPI_OFFSET(node)		XLP9XX_HDR_OFFSET(node, 7, 2)
-/* SD flash */
-#define XLP9XX_IO_MMCSD_OFFSET(node)		XLP9XX_HDR_OFFSET(node, 7, 3)
+#define XLP9XX_IO_MMC_OFFSET(node)		XLP9XX_HDR_OFFSET(node, 7, 3)
 
 /* PCI config header register id's */
 #define XLP_PCI_CFGREG0			0x00
@@ -186,8 +186,10 @@
 #define PCI_DEVICE_ID_NLM_NOR		0x1015
 #define PCI_DEVICE_ID_NLM_NAND		0x1016
 #define PCI_DEVICE_ID_NLM_MMC		0x1018
-#define PCI_DEVICE_ID_NLM_XHCI		0x101d
+#define PCI_DEVICE_ID_NLM_SATA		0x101A
+#define PCI_DEVICE_ID_NLM_XHCI		0x101D
 
+#define PCI_DEVICE_ID_XLP9XX_MMC	0x9018
 #define PCI_DEVICE_ID_XLP9XX_SATA	0x901A
 #define PCI_DEVICE_ID_XLP9XX_XHCI	0x901D
 
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
index 1b56bd4..488863e 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
@@ -58,6 +58,10 @@
 #define PIC_I2C_1_IRQ			31
 #define PIC_I2C_2_IRQ			32
 #define PIC_I2C_3_IRQ			33
+#define PIC_SPI_IRQ			34
+#define PIC_NAND_IRQ			37
+#define PIC_SATA_IRQ			38
+#define PIC_GPIO_IRQ			39
 
 #define PIC_PCIE_LINK_MSI_IRQ_BASE	44	/* 44 - 47 MSI IRQ */
 #define PIC_PCIE_LINK_MSI_IRQ(i)	(44 + (i))
diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index d85019b..66a2dae 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -66,31 +66,39 @@ void nlm_node_init(int node)
 	spin_lock_init(&nodep->piclock);
 }
 
-int nlm_irq_to_irt(int irq)
+static int xlp9xx_irq_to_irt(int irq)
+{
+	switch (irq) {
+	case PIC_GPIO_IRQ:
+		return 12;
+	case PIC_9XX_XHCI_0_IRQ:
+		return 114;
+	case PIC_9XX_XHCI_1_IRQ:
+		return 115;
+	case PIC_UART_0_IRQ:
+		return 133;
+	case PIC_UART_1_IRQ:
+		return 134;
+	case PIC_SATA_IRQ:
+		return 143;
+	case PIC_SPI_IRQ:
+		return 152;
+	case PIC_MMC_IRQ:
+		return 153;
+	case PIC_PCIE_LINK_LEGACY_IRQ(0):
+	case PIC_PCIE_LINK_LEGACY_IRQ(1):
+	case PIC_PCIE_LINK_LEGACY_IRQ(2):
+	case PIC_PCIE_LINK_LEGACY_IRQ(3):
+		return 191 + irq - PIC_PCIE_LINK_LEGACY_IRQ_BASE;
+	}
+	return -1;
+}
+
+static int xlp_irq_to_irt(int irq)
 {
 	uint64_t pcibase;
 	int devoff, irt;
 
-	/* bypass for 9xx */
-	if (cpu_is_xlp9xx()) {
-		switch (irq) {
-		case PIC_9XX_XHCI_0_IRQ:
-			return 114;
-		case PIC_9XX_XHCI_1_IRQ:
-			return 115;
-		case PIC_UART_0_IRQ:
-			return 133;
-		case PIC_UART_1_IRQ:
-			return 134;
-		case PIC_PCIE_LINK_LEGACY_IRQ(0):
-		case PIC_PCIE_LINK_LEGACY_IRQ(1):
-		case PIC_PCIE_LINK_LEGACY_IRQ(2):
-		case PIC_PCIE_LINK_LEGACY_IRQ(3):
-			return 191 + irq - PIC_PCIE_LINK_LEGACY_IRQ_BASE;
-		}
-		return -1;
-	}
-
 	devoff = 0;
 	switch (irq) {
 	case PIC_UART_0_IRQ:
@@ -100,7 +108,7 @@ int nlm_irq_to_irt(int irq)
 		devoff = XLP_IO_UART1_OFFSET(0);
 		break;
 	case PIC_MMC_IRQ:
-		devoff = XLP_IO_SD_OFFSET(0);
+		devoff = XLP_IO_MMC_OFFSET(0);
 		break;
 	case PIC_I2C_0_IRQ:	/* I2C will be fixed up */
 	case PIC_I2C_1_IRQ:
@@ -111,6 +119,18 @@ int nlm_irq_to_irt(int irq)
 		else
 			devoff = XLP_IO_I2C0_OFFSET(0);
 		break;
+	case PIC_SATA_IRQ:
+		devoff = XLP_IO_SATA_OFFSET(0);
+		break;
+	case PIC_GPIO_IRQ:
+		devoff = XLP_IO_GPIO_OFFSET(0);
+		break;
+	case PIC_NAND_IRQ:
+		devoff = XLP_IO_NAND_OFFSET(0);
+		break;
+	case PIC_SPI_IRQ:
+		devoff = XLP_IO_SPI_OFFSET(0);
+		break;
 	default:
 		if (cpu_is_xlpii()) {
 			switch (irq) {
@@ -166,18 +186,26 @@ int nlm_irq_to_irt(int irq)
 		/* HW bug, PCI IRT entries are bad on early silicon, fix */
 		irt = PIC_IRT_PCIE_LINK_INDEX(irq -
 					PIC_PCIE_LINK_LEGACY_IRQ_BASE);
-	} else if (irq >= PIC_PCIE_LINK_MSI_IRQ(0) &&
-			irq <= PIC_PCIE_LINK_MSI_IRQ(3)) {
-		irt = -2;
-	} else if (irq >= PIC_PCIE_MSIX_IRQ(0) &&
-			irq <= PIC_PCIE_MSIX_IRQ(3)) {
-		irt = -2;
 	} else {
 		irt = -1;
 	}
 	return irt;
 }
 
+int nlm_irq_to_irt(int irq)
+{
+	/* return -2 for irqs without 1-1 mapping */
+	if (irq >= PIC_PCIE_LINK_MSI_IRQ(0) && irq <= PIC_PCIE_LINK_MSI_IRQ(3))
+		return -2;
+	if (irq >= PIC_PCIE_MSIX_IRQ(0) && irq <= PIC_PCIE_MSIX_IRQ(3))
+		return -2;
+
+	if (cpu_is_xlp9xx())
+		return xlp9xx_irq_to_irt(irq);
+	else
+		return xlp_irq_to_irt(irq);
+}
+
 unsigned int nlm_get_core_frequency(int node, int core)
 {
 	unsigned int pll_divf, pll_divr, dfs_div, ext_div;
-- 
1.7.9.5
