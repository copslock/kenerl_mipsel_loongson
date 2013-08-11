Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Aug 2013 11:20:06 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:4038 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827281Ab3HKJNkwTbZM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Aug 2013 11:13:40 +0200
Received: from [10.9.208.53] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sun, 11 Aug 2013 02:07:13 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sun, 11 Aug 2013 02:13:22 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Sun, 11 Aug 2013 02:13:22 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id C7F6CF2D76; Sun, 11
 Aug 2013 02:13:20 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Ganesan Ramalingam" <ganesanr@broadcom.com>,
        "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 09/10] MIPS: Netlogic: Add support for USB on XLP2xx
Date:   Sun, 11 Aug 2013 14:43:59 +0530
Message-ID: <1376212440-21038-10-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1376212440-21038-1-git-send-email-jchandra@broadcom.com>
References: <1376212440-21038-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7E198BCB1R079371345-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37521
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

Add USB intialization code to handle the new XLP2XX USB 3.0 block.
This adds xlp/usb-init-xlp2.c initialize the XLP2XX USB glue logic
for the XHCI and EHCI. Interrupt and IO offset code in xlp-hal/iomap.h
and xlp/nlm_hal.c is updated to handle the new USB block and interrupts.

Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/iomap.h |    7 +
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h   |    5 +
 arch/mips/netlogic/xlp/Makefile                |    1 +
 arch/mips/netlogic/xlp/nlm_hal.c               |   56 +++---
 arch/mips/netlogic/xlp/usb-init-xlp2.c         |  218 ++++++++++++++++++++++++
 arch/mips/netlogic/xlp/usb-init.c              |    3 +
 6 files changed, 270 insertions(+), 20 deletions(-)
 create mode 100644 arch/mips/netlogic/xlp/usb-init-xlp2.c

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/iomap.h b/arch/mips/include/asm/netlogic/xlp-hal/iomap.h
index 61c84de..55eee77 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/iomap.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/iomap.h
@@ -72,6 +72,12 @@
 #define XLP_IO_USB_OHCI2_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 2, 4)
 #define XLP_IO_USB_OHCI3_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 2, 5)
 
+/* XLP2xx has an updated USB block */
+#define XLP2XX_IO_USB_OFFSET(node, i)	XLP_HDR_OFFSET(node, 0, 4, i)
+#define XLP2XX_IO_USB_XHCI0_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 4, 1)
+#define XLP2XX_IO_USB_XHCI1_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 4, 2)
+#define XLP2XX_IO_USB_XHCI2_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 4, 3)
+
 #define XLP_IO_NAE_OFFSET(node)		XLP_HDR_OFFSET(node, 0, 3, 0)
 #define XLP_IO_POE_OFFSET(node)		XLP_HDR_OFFSET(node, 0, 3, 1)
 
@@ -148,6 +154,7 @@
 #define PCI_DEVICE_ID_NLM_NOR		0x1015
 #define PCI_DEVICE_ID_NLM_NAND		0x1016
 #define PCI_DEVICE_ID_NLM_MMC		0x1018
+#define PCI_DEVICE_ID_NLM_XHCI		0x101d
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
index 4950ea5..17daffb2 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
@@ -41,12 +41,17 @@
 #define PIC_PCIE_LINK_1_IRQ		20
 #define PIC_PCIE_LINK_2_IRQ		21
 #define PIC_PCIE_LINK_3_IRQ		22
+
 #define PIC_EHCI_0_IRQ			23
 #define PIC_EHCI_1_IRQ			24
 #define PIC_OHCI_0_IRQ			25
 #define PIC_OHCI_1_IRQ			26
 #define PIC_OHCI_2_IRQ			27
 #define PIC_OHCI_3_IRQ			28
+#define PIC_2XX_XHCI_0_IRQ		23
+#define PIC_2XX_XHCI_1_IRQ		24
+#define PIC_2XX_XHCI_2_IRQ		25
+
 #define PIC_MMC_IRQ			29
 #define PIC_I2C_0_IRQ			30
 #define PIC_I2C_1_IRQ			31
diff --git a/arch/mips/netlogic/xlp/Makefile b/arch/mips/netlogic/xlp/Makefile
index 85ac4a8..ed9a93c 100644
--- a/arch/mips/netlogic/xlp/Makefile
+++ b/arch/mips/netlogic/xlp/Makefile
@@ -1,3 +1,4 @@
 obj-y				+= setup.o nlm_hal.o cop2-ex.o dt.o
 obj-$(CONFIG_SMP)		+= wakeup.o
 obj-$(CONFIG_USB)		+= usb-init.o
+obj-$(CONFIG_USB)		+= usb-init-xlp2.o
diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index 04adb75..56c50ba 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -65,6 +65,7 @@ int nlm_irq_to_irt(int irq)
 	uint64_t pcibase;
 	int devoff, irt;
 
+	devoff = 0;
 	switch (irq) {
 	case PIC_UART_0_IRQ:
 		devoff = XLP_IO_UART0_OFFSET(0);
@@ -72,24 +73,6 @@ int nlm_irq_to_irt(int irq)
 	case PIC_UART_1_IRQ:
 		devoff = XLP_IO_UART1_OFFSET(0);
 		break;
-	case PIC_EHCI_0_IRQ:
-		devoff = XLP_IO_USB_EHCI0_OFFSET(0);
-		break;
-	case PIC_EHCI_1_IRQ:
-		devoff = XLP_IO_USB_EHCI1_OFFSET(0);
-		break;
-	case PIC_OHCI_0_IRQ:
-		devoff = XLP_IO_USB_OHCI0_OFFSET(0);
-		break;
-	case PIC_OHCI_1_IRQ:
-		devoff = XLP_IO_USB_OHCI1_OFFSET(0);
-		break;
-	case PIC_OHCI_2_IRQ:
-		devoff = XLP_IO_USB_OHCI2_OFFSET(0);
-		break;
-	case PIC_OHCI_3_IRQ:
-		devoff = XLP_IO_USB_OHCI3_OFFSET(0);
-		break;
 	case PIC_MMC_IRQ:
 		devoff = XLP_IO_SD_OFFSET(0);
 		break;
@@ -103,8 +86,41 @@ int nlm_irq_to_irt(int irq)
 			devoff = XLP_IO_I2C0_OFFSET(0);
 		break;
 	default:
-		devoff = 0;
-		break;
+		if (cpu_is_xlpii()) {
+			switch (irq) {
+				/* XLP2XX has three XHCI USB controller */
+			case PIC_2XX_XHCI_0_IRQ:
+				devoff = XLP2XX_IO_USB_XHCI0_OFFSET(0);
+				break;
+			case PIC_2XX_XHCI_1_IRQ:
+				devoff = XLP2XX_IO_USB_XHCI1_OFFSET(0);
+				break;
+			case PIC_2XX_XHCI_2_IRQ:
+				devoff = XLP2XX_IO_USB_XHCI2_OFFSET(0);
+				break;
+			}
+		} else {
+			switch (irq) {
+			case PIC_EHCI_0_IRQ:
+				devoff = XLP_IO_USB_EHCI0_OFFSET(0);
+				break;
+			case PIC_EHCI_1_IRQ:
+				devoff = XLP_IO_USB_EHCI1_OFFSET(0);
+				break;
+			case PIC_OHCI_0_IRQ:
+				devoff = XLP_IO_USB_OHCI0_OFFSET(0);
+				break;
+			case PIC_OHCI_1_IRQ:
+				devoff = XLP_IO_USB_OHCI1_OFFSET(0);
+				break;
+			case PIC_OHCI_2_IRQ:
+				devoff = XLP_IO_USB_OHCI2_OFFSET(0);
+				break;
+			case PIC_OHCI_3_IRQ:
+				devoff = XLP_IO_USB_OHCI3_OFFSET(0);
+				break;
+			}
+		}
 	}
 
 	if (devoff != 0) {
diff --git a/arch/mips/netlogic/xlp/usb-init-xlp2.c b/arch/mips/netlogic/xlp/usb-init-xlp2.c
new file mode 100644
index 0000000..adc7fe8
--- /dev/null
+++ b/arch/mips/netlogic/xlp/usb-init-xlp2.c
@@ -0,0 +1,218 @@
+/*
+ * Copyright (c) 2003-2013 Broadcom Corporation
+ * All Rights Reserved
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the Broadcom
+ * license below:
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY BROADCOM ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL BROADCOM OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/irq.h>
+
+#include <asm/netlogic/common.h>
+#include <asm/netlogic/haldefs.h>
+#include <asm/netlogic/xlp-hal/iomap.h>
+#include <asm/netlogic/xlp-hal/xlp.h>
+
+#define XLP2XX_USB3_CTL_0		0xc0
+#define XLP2XX_VAUXRST			BIT(0)
+#define XLP2XX_VCCRST			BIT(1)
+#define XLP2XX_NUM2PORT			9
+#define XLP2XX_NUM3PORT			13
+#define XLP2XX_RTUNEREQ			BIT(20)
+#define XLP2XX_MS_CSYSREQ		BIT(21)
+#define XLP2XX_XS_CSYSREQ		BIT(22)
+#define XLP2XX_RETENABLEN		BIT(23)
+#define XLP2XX_TX2RX			BIT(24)
+#define XLP2XX_XHCIREV			BIT(25)
+#define XLP2XX_ECCDIS			BIT(26)
+
+#define XLP2XX_USB3_INT_REG		0xc2
+#define XLP2XX_USB3_INT_MASK		0xc3
+
+#define XLP2XX_USB_PHY_TEST		0xc6
+#define XLP2XX_PRESET			BIT(0)
+#define XLP2XX_ATERESET			BIT(1)
+#define XLP2XX_LOOPEN			BIT(2)
+#define XLP2XX_TESTPDHSP		BIT(3)
+#define XLP2XX_TESTPDSSP		BIT(4)
+#define XLP2XX_TESTBURNIN		BIT(5)
+
+#define XLP2XX_USB_PHY_LOS_LV		0xc9
+#define XLP2XX_LOSLEV			0
+#define XLP2XX_LOSBIAS			5
+#define XLP2XX_SQRXTX			8
+#define XLP2XX_TXBOOST			11
+#define XLP2XX_RSLKSEL			16
+#define XLP2XX_FSEL			20
+
+#define XLP2XX_USB_RFCLK_REG		0xcc
+#define XLP2XX_VVLD			30
+
+#define nlm_read_usb_reg(b, r)		nlm_read_reg(b, r)
+#define nlm_write_usb_reg(b, r, v)	nlm_write_reg(b, r, v)
+
+#define nlm_xlp2xx_get_usb_pcibase(node, inst)		\
+	nlm_pcicfg_base(XLP2XX_IO_USB_OFFSET(node, inst))
+#define nlm_xlp2xx_get_usb_regbase(node, inst)		\
+	(nlm_xlp2xx_get_usb_pcibase(node, inst) + XLP_IO_PCI_HDRSZ)
+
+static void xlp2xx_usb_ack(struct irq_data *data)
+{
+	u64 port_addr;
+
+	switch (data->irq) {
+	case PIC_2XX_XHCI_0_IRQ:
+		port_addr = nlm_xlp2xx_get_usb_regbase(0, 1);
+		break;
+	case PIC_2XX_XHCI_1_IRQ:
+		port_addr = nlm_xlp2xx_get_usb_regbase(0, 2);
+		break;
+	case PIC_2XX_XHCI_2_IRQ:
+		port_addr = nlm_xlp2xx_get_usb_regbase(0, 3);
+		break;
+	default:
+		pr_err("No matching USB irq!\n");
+		return;
+	}
+	nlm_write_usb_reg(port_addr, XLP2XX_USB3_INT_REG, 0xffffffff);
+}
+
+static void nlm_xlp2xx_usb_hw_reset(int node, int port)
+{
+	u64 port_addr, xhci_base, pci_base;
+	void __iomem *corebase;
+	u32 val;
+
+	port_addr = nlm_xlp2xx_get_usb_regbase(node, port);
+
+	/* Set frequency */
+	val = nlm_read_usb_reg(port_addr, XLP2XX_USB_PHY_LOS_LV);
+	val &= ~(0x3f << XLP2XX_FSEL);
+	val |= (0x27 << XLP2XX_FSEL);
+	nlm_write_usb_reg(port_addr, XLP2XX_USB_PHY_LOS_LV, val);
+
+	val = nlm_read_usb_reg(port_addr, XLP2XX_USB_RFCLK_REG);
+	val |= (1 << XLP2XX_VVLD);
+	nlm_write_usb_reg(port_addr, XLP2XX_USB_RFCLK_REG, val);
+
+	/* PHY reset */
+	val = nlm_read_usb_reg(port_addr, XLP2XX_USB_PHY_TEST);
+	val &= (XLP2XX_ATERESET | XLP2XX_LOOPEN | XLP2XX_TESTPDHSP
+		| XLP2XX_TESTPDSSP | XLP2XX_TESTBURNIN);
+	nlm_write_usb_reg(port_addr, XLP2XX_USB_PHY_TEST, val);
+
+	/* Setup control register */
+	val =  XLP2XX_VAUXRST | XLP2XX_VCCRST | (1 << XLP2XX_NUM2PORT)
+		| (1 << XLP2XX_NUM3PORT) | XLP2XX_MS_CSYSREQ | XLP2XX_XS_CSYSREQ
+		| XLP2XX_RETENABLEN | XLP2XX_XHCIREV;
+	nlm_write_usb_reg(port_addr, XLP2XX_USB3_CTL_0, val);
+
+	/* Enabling interrupt on cores */
+	nlm_write_usb_reg(port_addr, XLP2XX_USB3_INT_MASK, 0x000fff0f);
+
+	/* clear all interrupts */
+	nlm_write_usb_reg(port_addr, XLP2XX_USB3_INT_REG, 0xffffffff);
+
+	udelay(2000);
+
+	/* XHCI configuration at PCI mem */
+	pci_base = nlm_xlp2xx_get_usb_pcibase(node, port);
+	xhci_base = nlm_read_usb_reg(pci_base, 0x4) & ~0xf;
+	corebase = ioremap(xhci_base, 0x10000);
+	if (!corebase)
+		return;
+
+	writel(0x240002, corebase + 0xc2c0);
+	/* GCTL 0xc110 */
+	val = readl(corebase + 0xc110);
+	val &= ~(0x3 << 12);
+	val |= (1 << 12);
+	writel(val, corebase + 0xc110);
+	udelay(100);
+
+	/* PHYCFG 0xc200 */
+	val = readl(corebase + 0xc200);
+	val &= ~(1 << 6);
+	writel(val, corebase + 0xc200);
+	udelay(100);
+
+	/* PIPECTL 0xc2c0 */
+	val = readl(corebase + 0xc2c0);
+	val &= ~(1 << 17);
+	writel(val, corebase + 0xc2c0);
+
+	iounmap((void *) corebase);
+}
+
+static int __init nlm_platform_xlp2xx_usb_init(void)
+{
+	if (!cpu_is_xlpii())
+		return 0;
+
+	pr_info("Initializing 2XX USB Interface\n");
+	nlm_xlp2xx_usb_hw_reset(0, 1);
+	nlm_xlp2xx_usb_hw_reset(0, 2);
+	nlm_xlp2xx_usb_hw_reset(0, 3);
+	nlm_set_pic_extra_ack(0, PIC_2XX_XHCI_0_IRQ, xlp2xx_usb_ack);
+	nlm_set_pic_extra_ack(0, PIC_2XX_XHCI_1_IRQ, xlp2xx_usb_ack);
+	nlm_set_pic_extra_ack(0, PIC_2XX_XHCI_2_IRQ, xlp2xx_usb_ack);
+
+	return 0;
+}
+
+arch_initcall(nlm_platform_xlp2xx_usb_init);
+
+static u64 xlp_usb_dmamask = ~(u32)0;
+
+/* Fixup the IRQ for USB devices which is exist on XLP SOC PCIE bus */
+static void nlm_usb_fixup_final(struct pci_dev *dev)
+{
+	dev->dev.dma_mask		= &xlp_usb_dmamask;
+	dev->dev.coherent_dma_mask	= DMA_BIT_MASK(32);
+	switch (dev->devfn) {
+	case 0x21:
+		dev->irq = PIC_2XX_XHCI_0_IRQ;
+		break;
+	case 0x22:
+		dev->irq = PIC_2XX_XHCI_1_IRQ;
+		break;
+	case 0x23:
+		dev->irq = PIC_2XX_XHCI_2_IRQ;
+		break;
+	}
+}
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_NETLOGIC, PCI_DEVICE_ID_NLM_XHCI,
+		nlm_usb_fixup_final);
diff --git a/arch/mips/netlogic/xlp/usb-init.c b/arch/mips/netlogic/xlp/usb-init.c
index ef3897e..61bc303 100644
--- a/arch/mips/netlogic/xlp/usb-init.c
+++ b/arch/mips/netlogic/xlp/usb-init.c
@@ -100,6 +100,9 @@ static void nlm_usb_hw_reset(int node, int port)
 
 static int __init nlm_platform_usb_init(void)
 {
+	if (cpu_is_xlpii())
+		return 0;
+
 	pr_info("Initializing USB Interface\n");
 	nlm_usb_hw_reset(0, 0);
 	nlm_usb_hw_reset(0, 3);
-- 
1.7.9.5
