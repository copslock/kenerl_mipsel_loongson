Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2012 15:43:44 +0100 (CET)
Received: from smtpgw2.netlogicmicro.com ([12.203.210.54]:52728 "EHLO
        smtpgw2.netlogicmicro.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904116Ab2BBOje (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2012 15:39:34 +0100
Received: from pps.filterd (smtpgw2 [127.0.0.1])
        by smtpgw2.netlogicmicro.com (8.14.5/8.14.5) with SMTP id q12Ed9ZJ029370;
        Thu, 2 Feb 2012 06:39:27 -0800
Received: from hqcas02.netlogicmicro.com (hqcas02.netlogicmicro.com [10.65.50.15])
        by smtpgw2.netlogicmicro.com with ESMTP id 11pcrwt2ah-1
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 02 Feb 2012 06:39:27 -0800
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Ganesan Ramalingam <ganesanr@netlogicmicro.com>,
        Jayachandran C <jayachandranc@netlogicmicro.com>
Subject: [PATCH 11/11] MIPS: Netlogic: USB support for XLP
Date:   Thu, 2 Feb 2012 20:13:05 +0530
Message-ID: <5360c071d54ce6c5217b53fc41e4672a680ff3f4.1328189941.git.jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1328189941.git.jayachandranc@netlogicmicro.com>
References: <cover.1328189941.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.7.0.77]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.6.7361,1.0.211,0.0.0000
 definitions=2012-01-28_02:2012-01-27,2012-01-28,1970-01-01 signatures=0
X-archive-position: 32394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Ganesan Ramalingam <ganesanr@netlogicmicro.com>

The XLP USB controller appears as a device on the internal SoC PCIe
bus, the block has 2 EHCI blocks and 4 OHCI blocks. Change are to:

* Add files netlogic/xlp/usb-init.c and asm/netlogic/xlp-hal/usb.h
  to initialize the USB controller and define PCI fixups. The PCI
  fixups are to setup interrupts and DMA mask.
* Update include/asm/xlp-hal/{iomap.h,pic.h,xlp.h} to add interrupt
  mapping for EHCI/OHCI interrupts.

Signed-off-by: Ganesan Ramalingam <ganesanr@netlogicmicro.com>
Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/iomap.h |    2 +-
 arch/mips/include/asm/netlogic/xlp-hal/pic.h   |    4 +
 arch/mips/include/asm/netlogic/xlp-hal/usb.h   |   64 ++++++++++++
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h   |    6 +
 arch/mips/netlogic/xlp/Makefile                |    1 +
 arch/mips/netlogic/xlp/nlm_hal.c               |   24 +++++
 arch/mips/netlogic/xlp/platform.c              |    2 +-
 arch/mips/netlogic/xlp/usb-init.c              |  125 ++++++++++++++++++++++++
 8 files changed, 226 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/usb.h
 create mode 100644 arch/mips/netlogic/xlp/usb-init.c

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/iomap.h b/arch/mips/include/asm/netlogic/xlp-hal/iomap.h
index ece86f1..2c63f97 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/iomap.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/iomap.h
@@ -132,7 +132,7 @@
 #define	PCI_DEVICE_ID_NLM_PIC		0x1003
 #define	PCI_DEVICE_ID_NLM_PCIE		0x1004
 #define	PCI_DEVICE_ID_NLM_EHCI		0x1007
-#define	PCI_DEVICE_ID_NLM_ILK		0x1008
+#define	PCI_DEVICE_ID_NLM_OHCI		0x1008
 #define	PCI_DEVICE_ID_NLM_NAE		0x1009
 #define	PCI_DEVICE_ID_NLM_POE		0x100A
 #define	PCI_DEVICE_ID_NLM_FMN		0x100B
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/pic.h b/arch/mips/include/asm/netlogic/xlp-hal/pic.h
index b6628f7..ad8b802 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/pic.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/pic.h
@@ -201,7 +201,11 @@
 #define PIC_NUM_USB_IRTS		6
 #define PIC_IRT_USB_0_INDEX		115
 #define PIC_IRT_EHCI_0_INDEX		115
+#define PIC_IRT_OHCI_0_INDEX		116
+#define PIC_IRT_OHCI_1_INDEX		117
 #define PIC_IRT_EHCI_1_INDEX		118
+#define PIC_IRT_OHCI_2_INDEX		119
+#define PIC_IRT_OHCI_3_INDEX		120
 #define PIC_IRT_USB_INDEX(num)		((num) + PIC_IRT_USB_0_INDEX)
 /* 115 to 120 */
 #define PIC_IRT_GDX_INDEX		121
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/usb.h b/arch/mips/include/asm/netlogic/xlp-hal/usb.h
new file mode 100644
index 0000000..4052be4
--- /dev/null
+++ b/arch/mips/include/asm/netlogic/xlp-hal/usb.h
@@ -0,0 +1,64 @@
+/*
+ * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
+ * reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the NetLogic
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
+ * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef __NLM_HAL_USB_H__
+#define __NLM_HAL_USB_H__
+
+#define USB_CTL_0			0x01
+#define USB_PHY_0			0x0A
+#define USB_PHY_RESET			0x01
+#define USB_PHY_PORT_RESET_0		0x10
+#define USB_PHY_PORT_RESET_1		0x20
+#define USB_CONTROLLER_RESET		0x01
+#define USB_INT_STATUS			0x0E
+#define USB_INT_EN			0x0F
+#define USB_PHY_INTERRUPT_EN		0x01
+#define USB_OHCI_INTERRUPT_EN		0x02
+#define USB_OHCI_INTERRUPT1_EN		0x04
+#define USB_OHCI_INTERRUPT2_EN		0x08
+#define USB_CTRL_INTERRUPT_EN		0x10
+
+#ifndef __ASSEMBLY__
+
+#define nlm_read_usb_reg(b, r)			nlm_read_reg(b, r)
+#define nlm_write_usb_reg(b, r, v)		nlm_write_reg(b, r, v)
+#define nlm_get_usb_pcibase(node, inst)		\
+	nlm_pcicfg_base(XLP_IO_USB_OFFSET(node, inst))
+#define nlm_get_usb_hcd_base(node, inst)	\
+	nlm_xkphys_map_pcibar0(nlm_get_usb_pcibase(node, inst))
+#define nlm_get_usb_regbase(node, inst)		\
+	(nlm_get_usb_pcibase(node, inst) + XLP_IO_PCI_HDRSZ)
+
+#endif
+#endif /* __NLM_HAL_USB_H__ */
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
index dc6e98e..3921a31 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
@@ -41,6 +41,12 @@
 #define PIC_PCIE_LINK_1_IRQ		20
 #define PIC_PCIE_LINK_2_IRQ		21
 #define PIC_PCIE_LINK_3_IRQ		22
+#define PIC_EHCI_0_IRQ			23
+#define PIC_EHCI_1_IRQ			24
+#define PIC_OHCI_0_IRQ			25
+#define PIC_OHCI_1_IRQ			26
+#define PIC_OHCI_2_IRQ			27
+#define PIC_OHCI_3_IRQ			28
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/mips/netlogic/xlp/Makefile b/arch/mips/netlogic/xlp/Makefile
index b93ed83..5bd24b6 100644
--- a/arch/mips/netlogic/xlp/Makefile
+++ b/arch/mips/netlogic/xlp/Makefile
@@ -1,2 +1,3 @@
 obj-y				+= setup.o platform.o nlm_hal.o
 obj-$(CONFIG_SMP)		+= wakeup.o
+obj-$(CONFIG_USB)		+= usb-init.o
diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index 3a4a172..fad2cae 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -77,6 +77,18 @@ int nlm_irq_to_irt(int irq)
 	       return PIC_IRT_PCIE_LINK_2_INDEX;
 	case PIC_PCIE_LINK_3_IRQ:
 	       return PIC_IRT_PCIE_LINK_3_INDEX;
+	case PIC_EHCI_0_IRQ:
+	       return PIC_IRT_EHCI_0_INDEX;
+	case PIC_EHCI_1_IRQ:
+	       return PIC_IRT_EHCI_1_INDEX;
+	case PIC_OHCI_0_IRQ:
+	       return PIC_IRT_OHCI_0_INDEX;
+	case PIC_OHCI_1_IRQ:
+	       return PIC_IRT_OHCI_1_INDEX;
+	case PIC_OHCI_2_IRQ:
+	       return PIC_IRT_OHCI_2_INDEX;
+	case PIC_OHCI_3_IRQ:
+	       return PIC_IRT_OHCI_3_INDEX;
 	default:
 		return -1;
 	}
@@ -97,6 +109,18 @@ int nlm_irt_to_irq(int irt)
 	       return PIC_PCIE_LINK_2_IRQ;
 	case PIC_IRT_PCIE_LINK_3_INDEX:
 	       return PIC_PCIE_LINK_3_IRQ;
+	case PIC_IRT_EHCI_0_INDEX:
+		return PIC_EHCI_0_IRQ;
+	case PIC_IRT_EHCI_1_INDEX:
+		return PIC_EHCI_1_IRQ;
+	case PIC_IRT_OHCI_0_INDEX:
+		return PIC_OHCI_0_IRQ;
+	case PIC_IRT_OHCI_1_INDEX:
+		return PIC_OHCI_1_IRQ;
+	case PIC_IRT_OHCI_2_INDEX:
+		return PIC_OHCI_2_IRQ;
+	case PIC_IRT_OHCI_3_INDEX:
+		return PIC_OHCI_3_IRQ;
 	default:
 		return -1;
 	}
diff --git a/arch/mips/netlogic/xlp/platform.c b/arch/mips/netlogic/xlp/platform.c
index 1f5e4cb..2c510d5 100644
--- a/arch/mips/netlogic/xlp/platform.c
+++ b/arch/mips/netlogic/xlp/platform.c
@@ -53,7 +53,7 @@
 
 static unsigned int nlm_xlp_uart_in(struct uart_port *p, int offset)
 {
-	 return nlm_read_reg(p->iobase, offset);
+	return nlm_read_reg(p->iobase, offset);
 }
 
 static void nlm_xlp_uart_out(struct uart_port *p, int offset, int value)
diff --git a/arch/mips/netlogic/xlp/usb-init.c b/arch/mips/netlogic/xlp/usb-init.c
new file mode 100644
index 0000000..81ce206
--- /dev/null
+++ b/arch/mips/netlogic/xlp/usb-init.c
@@ -0,0 +1,125 @@
+/*
+ * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
+ * reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the NetLogic
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
+ * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
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
+#include <linux/platform_device.h>
+
+#include <asm/netlogic/haldefs.h>
+#include <asm/netlogic/xlp-hal/iomap.h>
+#include <asm/netlogic/xlp-hal/xlp.h>
+#include <asm/netlogic/xlp-hal/usb.h>
+
+static void nlm_usb_intr_en(int node, int port)
+{
+	uint32_t val;
+	uint64_t port_addr;
+
+	port_addr = nlm_get_usb_regbase(node, port);
+	val = nlm_read_usb_reg(port_addr, USB_INT_EN);
+	val = USB_CTRL_INTERRUPT_EN  | USB_OHCI_INTERRUPT_EN |
+		USB_OHCI_INTERRUPT1_EN | USB_CTRL_INTERRUPT_EN  |
+		USB_OHCI_INTERRUPT_EN | USB_OHCI_INTERRUPT2_EN;
+	nlm_write_usb_reg(port_addr, USB_INT_EN, val);
+}
+
+static void nlm_usb_hw_reset(int node, int port)
+{
+	uint64_t port_addr;
+	uint32_t val;
+
+	/* reset USB phy */
+	port_addr = nlm_get_usb_regbase(node, port);
+	val = nlm_read_usb_reg(port_addr, USB_PHY_0);
+	val &= ~(USB_PHY_RESET | USB_PHY_PORT_RESET_0 | USB_PHY_PORT_RESET_1);
+	nlm_write_usb_reg(port_addr, USB_PHY_0, val);
+
+	mdelay(100);
+	val = nlm_read_usb_reg(port_addr, USB_CTL_0);
+	val &= ~(USB_CONTROLLER_RESET);
+	val |= 0x4;
+	nlm_write_usb_reg(port_addr, USB_CTL_0, val);
+}
+
+static int __init nlm_platform_usb_init(void)
+{
+	pr_info("Initializing USB Interface\n");
+	nlm_usb_hw_reset(0, 0);
+	nlm_usb_hw_reset(0, 3);
+
+	/* Enable PHY interrupts */
+	nlm_usb_intr_en(0, 0);
+	nlm_usb_intr_en(0, 3);
+
+	return 0;
+}
+
+arch_initcall(nlm_platform_usb_init);
+
+static u64 xlp_usb_dmamask = ~(u32)0;
+
+/* Fixup the IRQ for USB devices which is exist on XLP SOC PCIE bus */
+static void nlm_usb_fixup_final(struct pci_dev *dev)
+{
+	dev->dev.dma_mask		= &xlp_usb_dmamask,
+	dev->dev.coherent_dma_mask	= DMA_BIT_MASK(64);
+	switch (dev->devfn) {
+	case 0x10:
+	       dev->irq = PIC_EHCI_0_IRQ;
+	       break;
+	case 0x11:
+	       dev->irq = PIC_OHCI_0_IRQ;
+	       break;
+	case 0x12:
+	       dev->irq = PIC_OHCI_1_IRQ;
+	       break;
+	case 0x13:
+	       dev->irq = PIC_EHCI_1_IRQ;
+	       break;
+	case 0x14:
+	       dev->irq = PIC_OHCI_2_IRQ;
+	       break;
+	case 0x15:
+	       dev->irq = PIC_OHCI_3_IRQ;
+	       break;
+	}
+
+	return 0;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_NETLOGIC, PCI_DEVICE_ID_NLM_EHCI,
+		nlm_usb_fixup_final);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_NETLOGIC, PCI_DEVICE_ID_NLM_OHCI,
+		nlm_usb_fixup_final);
-- 
1.7.5.4
