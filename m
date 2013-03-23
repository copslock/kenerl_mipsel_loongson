Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Mar 2013 19:28:05 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:1452 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834951Ab3CWS0dOdLet (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Mar 2013 19:26:33 +0100
Received: from [10.9.208.55] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sat, 23 Mar 2013 11:21:56 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sat, 23 Mar 2013 11:26:16 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Sat, 23 Mar 2013 11:26:16 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 66F573928A; Sat, 23
 Mar 2013 11:26:15 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 4/9] MIPS: Netlogic: Avoid using fixed PIC IRT index
Date:   Sat, 23 Mar 2013 23:57:56 +0530
Message-ID: <acf99361b30f7b14d762f373b4de4a3d7663e9b6.1364062916.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1364062916.git.jchandra@broadcom.com>
References: <cover.1364062916.git.jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7D532D4E3A01621416-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35956
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
Return-Path: <linux-mips-bounce@linux-mips.org>

The index for a device interrupt in the PIC interrupt routing table
changes for different chips in the XLP family.  Avoid using the fixed
entries and derive the index value from the SoC device header.

Add workarounds for some devices which do not report the IRT index
correctly.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/pic.h |   53 ----------------------
 arch/mips/netlogic/xlp/nlm_hal.c             |   62 +++++++++++++++++---------
 2 files changed, 40 insertions(+), 75 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/pic.h b/arch/mips/include/asm/netlogic/xlp-hal/pic.h
index 3df5301..a981f46 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/pic.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/pic.h
@@ -191,59 +191,6 @@
 #define PIC_IRT_PCIE_LINK_2_INDEX	80
 #define PIC_IRT_PCIE_LINK_3_INDEX	81
 #define PIC_IRT_PCIE_LINK_INDEX(num)	((num) + PIC_IRT_PCIE_LINK_0_INDEX)
-/* 78 to 81 */
-#define PIC_NUM_NA_IRTS			32
-/* 82 to 113 */
-#define PIC_IRT_NA_0_INDEX		82
-#define PIC_IRT_NA_INDEX(num)		((num) + PIC_IRT_NA_0_INDEX)
-#define PIC_IRT_POE_INDEX		114
-
-#define PIC_NUM_USB_IRTS		6
-#define PIC_IRT_USB_0_INDEX		115
-#define PIC_IRT_EHCI_0_INDEX		115
-#define PIC_IRT_OHCI_0_INDEX		116
-#define PIC_IRT_OHCI_1_INDEX		117
-#define PIC_IRT_EHCI_1_INDEX		118
-#define PIC_IRT_OHCI_2_INDEX		119
-#define PIC_IRT_OHCI_3_INDEX		120
-#define PIC_IRT_USB_INDEX(num)		((num) + PIC_IRT_USB_0_INDEX)
-/* 115 to 120 */
-#define PIC_IRT_GDX_INDEX		121
-#define PIC_IRT_SEC_INDEX		122
-#define PIC_IRT_RSA_INDEX		123
-
-#define PIC_NUM_COMP_IRTS		4
-#define PIC_IRT_COMP_0_INDEX		124
-#define PIC_IRT_COMP_INDEX(num)		((num) + PIC_IRT_COMP_0_INDEX)
-/* 124 to 127 */
-#define PIC_IRT_GBU_INDEX		128
-#define PIC_IRT_ICC_0_INDEX		129 /* ICC - Inter Chip Coherency */
-#define PIC_IRT_ICC_1_INDEX		130
-#define PIC_IRT_ICC_2_INDEX		131
-#define PIC_IRT_CAM_INDEX		132
-#define PIC_IRT_UART_0_INDEX		133
-#define PIC_IRT_UART_1_INDEX		134
-#define PIC_IRT_I2C_0_INDEX		135
-#define PIC_IRT_I2C_1_INDEX		136
-#define PIC_IRT_SYS_0_INDEX		137
-#define PIC_IRT_SYS_1_INDEX		138
-#define PIC_IRT_JTAG_INDEX		139
-#define PIC_IRT_PIC_INDEX		140
-#define PIC_IRT_NBU_INDEX		141
-#define PIC_IRT_TCU_INDEX		142
-#define PIC_IRT_GCU_INDEX		143 /* GBC - Global Coherency */
-#define PIC_IRT_DMC_0_INDEX		144
-#define PIC_IRT_DMC_1_INDEX		145
-
-#define PIC_NUM_GPIO_IRTS		4
-#define PIC_IRT_GPIO_0_INDEX		146
-#define PIC_IRT_GPIO_INDEX(num)		((num) + PIC_IRT_GPIO_0_INDEX)
-
-/* 146 to 149 */
-#define PIC_IRT_NOR_INDEX		150
-#define PIC_IRT_NAND_INDEX		151
-#define PIC_IRT_SPI_INDEX		152
-#define PIC_IRT_MMC_INDEX		153
 
 #define PIC_CLOCK_TIMER			7
 #define PIC_IRQ_BASE			8
diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index c68fd40..87560e4 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -61,43 +61,61 @@ void nlm_node_init(int node)
 
 int nlm_irq_to_irt(int irq)
 {
-	if (!PIC_IRQ_IS_IRT(irq))
-		return -1;
+	uint64_t pcibase;
+	int devoff, irt;
 
 	switch (irq) {
 	case PIC_UART_0_IRQ:
-		return PIC_IRT_UART_0_INDEX;
+		devoff = XLP_IO_UART0_OFFSET(0);
+		break;
 	case PIC_UART_1_IRQ:
-		return PIC_IRT_UART_1_INDEX;
-	case PIC_PCIE_LINK_0_IRQ:
-	       return PIC_IRT_PCIE_LINK_0_INDEX;
-	case PIC_PCIE_LINK_1_IRQ:
-	       return PIC_IRT_PCIE_LINK_1_INDEX;
-	case PIC_PCIE_LINK_2_IRQ:
-	       return PIC_IRT_PCIE_LINK_2_INDEX;
-	case PIC_PCIE_LINK_3_IRQ:
-	       return PIC_IRT_PCIE_LINK_3_INDEX;
+		devoff = XLP_IO_UART1_OFFSET(0);
+		break;
 	case PIC_EHCI_0_IRQ:
-	       return PIC_IRT_EHCI_0_INDEX;
+		devoff = XLP_IO_USB_EHCI0_OFFSET(0);
+		break;
 	case PIC_EHCI_1_IRQ:
-	       return PIC_IRT_EHCI_1_INDEX;
+		devoff = XLP_IO_USB_EHCI1_OFFSET(0);
+		break;
 	case PIC_OHCI_0_IRQ:
-	       return PIC_IRT_OHCI_0_INDEX;
+		devoff = XLP_IO_USB_OHCI0_OFFSET(0);
+		break;
 	case PIC_OHCI_1_IRQ:
-	       return PIC_IRT_OHCI_1_INDEX;
+		devoff = XLP_IO_USB_OHCI1_OFFSET(0);
+		break;
 	case PIC_OHCI_2_IRQ:
-	       return PIC_IRT_OHCI_2_INDEX;
+		devoff = XLP_IO_USB_OHCI2_OFFSET(0);
+		break;
 	case PIC_OHCI_3_IRQ:
-	       return PIC_IRT_OHCI_3_INDEX;
+		devoff = XLP_IO_USB_OHCI3_OFFSET(0);
+		break;
 	case PIC_MMC_IRQ:
-	       return PIC_IRT_MMC_INDEX;
+		devoff = XLP_IO_SD_OFFSET(0);
+		break;
 	case PIC_I2C_0_IRQ:
-		return PIC_IRT_I2C_0_INDEX;
+		devoff = XLP_IO_I2C0_OFFSET(0);
+		break;
 	case PIC_I2C_1_IRQ:
-		return PIC_IRT_I2C_1_INDEX;
+		devoff = XLP_IO_I2C1_OFFSET(0);
+		break;
 	default:
-		return -1;
+		devoff = 0;
+		break;
 	}
+
+	if (devoff != 0) {
+		pcibase = nlm_pcicfg_base(devoff);
+		irt = nlm_read_reg(pcibase, XLP_PCI_IRTINFO_REG) & 0xffff;
+		/* HW bug, I2C 1 irt entry is off by one */
+		if (irq == PIC_I2C_1_IRQ)
+			irt = irt + 1;
+	} else if (irq >= PIC_PCIE_LINK_0_IRQ && irq <= PIC_PCIE_LINK_3_IRQ) {
+		/* HW bug, PCI IRT entries are bad on early silicon, fix */
+		irt = PIC_IRT_PCIE_LINK_INDEX(irq - PIC_PCIE_LINK_0_IRQ);
+	} else {
+		irt = -1;
+	}
+	return irt;
 }
 
 unsigned int nlm_get_core_frequency(int node, int core)
-- 
1.7.9.5
