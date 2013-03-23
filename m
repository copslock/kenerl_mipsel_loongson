Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Mar 2013 19:28:41 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:1529 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834955Ab3CWS0ioF1TB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Mar 2013 19:26:38 +0100
Received: from [10.9.208.57] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sat, 23 Mar 2013 11:22:02 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sat, 23 Mar 2013 11:26:22 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Sat, 23 Mar 2013 11:26:22 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id C24F739289; Sat, 23
 Mar 2013 11:26:21 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 8/9] MIPS: Netlogic: Merge platform usb.h to usb-init.c
Date:   Sat, 23 Mar 2013 23:58:00 +0530
Message-ID: <c4e3038986d58610d6b4d89278957116ccc01020.1364062916.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1364062916.git.jchandra@broadcom.com>
References: <cover.1364062916.git.jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7D532D403A01621509-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35958
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

The definitions are not used anywhere else, and merging it will
make adding the new USB definitions for XLPII series easier.
While there, cleanup some whitespace in usb-init.c. There is no
change to logic due to this commit.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/usb.h |   64 --------------------------
 arch/mips/netlogic/xlp/usb-init.c            |   49 ++++++++++++++------
 2 files changed, 36 insertions(+), 77 deletions(-)
 delete mode 100644 arch/mips/include/asm/netlogic/xlp-hal/usb.h

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/usb.h b/arch/mips/include/asm/netlogic/xlp-hal/usb.h
deleted file mode 100644
index a9cd350..0000000
--- a/arch/mips/include/asm/netlogic/xlp-hal/usb.h
+++ /dev/null
@@ -1,64 +0,0 @@
-/*
- * Copyright (c) 2003-2012 Broadcom Corporation
- * All Rights Reserved
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the Broadcom
- * license below:
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in
- *    the documentation and/or other materials provided with the
- *    distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY BROADCOM ``AS IS'' AND ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL BROADCOM OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
- * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
- * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
- * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
- * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-#ifndef __NLM_HAL_USB_H__
-#define __NLM_HAL_USB_H__
-
-#define USB_CTL_0			0x01
-#define USB_PHY_0			0x0A
-#define USB_PHY_RESET			0x01
-#define USB_PHY_PORT_RESET_0		0x10
-#define USB_PHY_PORT_RESET_1		0x20
-#define USB_CONTROLLER_RESET		0x01
-#define USB_INT_STATUS			0x0E
-#define USB_INT_EN			0x0F
-#define USB_PHY_INTERRUPT_EN		0x01
-#define USB_OHCI_INTERRUPT_EN		0x02
-#define USB_OHCI_INTERRUPT1_EN		0x04
-#define USB_OHCI_INTERRUPT2_EN		0x08
-#define USB_CTRL_INTERRUPT_EN		0x10
-
-#ifndef __ASSEMBLY__
-
-#define nlm_read_usb_reg(b, r)			nlm_read_reg(b, r)
-#define nlm_write_usb_reg(b, r, v)		nlm_write_reg(b, r, v)
-#define nlm_get_usb_pcibase(node, inst)		\
-	nlm_pcicfg_base(XLP_IO_USB_OFFSET(node, inst))
-#define nlm_get_usb_hcd_base(node, inst)	\
-	nlm_xkphys_map_pcibar0(nlm_get_usb_pcibase(node, inst))
-#define nlm_get_usb_regbase(node, inst)		\
-	(nlm_get_usb_pcibase(node, inst) + XLP_IO_PCI_HDRSZ)
-
-#endif
-#endif /* __NLM_HAL_USB_H__ */
diff --git a/arch/mips/netlogic/xlp/usb-init.c b/arch/mips/netlogic/xlp/usb-init.c
index 1d0b66c..9c401dd 100644
--- a/arch/mips/netlogic/xlp/usb-init.c
+++ b/arch/mips/netlogic/xlp/usb-init.c
@@ -42,7 +42,30 @@
 #include <asm/netlogic/haldefs.h>
 #include <asm/netlogic/xlp-hal/iomap.h>
 #include <asm/netlogic/xlp-hal/xlp.h>
-#include <asm/netlogic/xlp-hal/usb.h>
+
+/*
+ * USB glue logic registers, used only during initialization
+ */
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
+#define nlm_read_usb_reg(b, r)			nlm_read_reg(b, r)
+#define nlm_write_usb_reg(b, r, v)		nlm_write_reg(b, r, v)
+#define nlm_get_usb_pcibase(node, inst)		\
+	nlm_pcicfg_base(XLP_IO_USB_OFFSET(node, inst))
+#define nlm_get_usb_regbase(node, inst)		\
+	(nlm_get_usb_pcibase(node, inst) + XLP_IO_PCI_HDRSZ)
 
 static void nlm_usb_intr_en(int node, int port)
 {
@@ -99,23 +122,23 @@ static void nlm_usb_fixup_final(struct pci_dev *dev)
 	dev->dev.coherent_dma_mask	= DMA_BIT_MASK(64);
 	switch (dev->devfn) {
 	case 0x10:
-	       dev->irq = PIC_EHCI_0_IRQ;
-	       break;
+		dev->irq = PIC_EHCI_0_IRQ;
+		break;
 	case 0x11:
-	       dev->irq = PIC_OHCI_0_IRQ;
-	       break;
+		dev->irq = PIC_OHCI_0_IRQ;
+		break;
 	case 0x12:
-	       dev->irq = PIC_OHCI_1_IRQ;
-	       break;
+		dev->irq = PIC_OHCI_1_IRQ;
+		break;
 	case 0x13:
-	       dev->irq = PIC_EHCI_1_IRQ;
-	       break;
+		dev->irq = PIC_EHCI_1_IRQ;
+		break;
 	case 0x14:
-	       dev->irq = PIC_OHCI_2_IRQ;
-	       break;
+		dev->irq = PIC_OHCI_2_IRQ;
+		break;
 	case 0x15:
-	       dev->irq = PIC_OHCI_3_IRQ;
-	       break;
+		dev->irq = PIC_OHCI_3_IRQ;
+		break;
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_NETLOGIC, PCI_DEVICE_ID_NLM_EHCI,
-- 
1.7.9.5
