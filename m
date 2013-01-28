Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2013 20:12:50 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:33184 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833297Ab3A1TJ12-rW- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Jan 2013 20:09:27 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 26126BF5183;
        Mon, 28 Jan 2013 20:09:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zXxRG8GsI9f6; Mon, 28 Jan 2013 20:09:25 +0100 (CET)
Received: from flexo.localdomain (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 648D4BF5188;
        Mon, 28 Jan 2013 20:09:25 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, jogo@openwrt.org, mbizon@freebox.fr,
        cenerkee@gmail.com, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        blogic@openwrt.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 03/13] MIPS: BCM63XX: move code touching the USB private register
Date:   Mon, 28 Jan 2013 20:06:21 +0100
Message-Id: <1359399991-2236-4-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1359399991-2236-1-git-send-email-florian@openwrt.org>
References: <1359399991-2236-1-git-send-email-florian@openwrt.org>
X-archive-position: 35594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

This patch moves the code touching the USB private register in the
bcm63xx USB gadget driver to arch/mips/bcm63xx/usb-common.c in
preparation for adding support for OHCI and EHCI host controllers which
will also touch the USB private register.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/Makefile                         |    2 +-
 arch/mips/bcm63xx/usb-common.c                     |   53 ++++++++++++++++++++
 .../include/asm/mach-bcm63xx/bcm63xx_usb_priv.h    |    9 ++++
 drivers/usb/gadget/bcm63xx_udc.c                   |   27 ++--------
 4 files changed, 67 insertions(+), 24 deletions(-)
 create mode 100644 arch/mips/bcm63xx/usb-common.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_usb_priv.h

diff --git a/arch/mips/bcm63xx/Makefile b/arch/mips/bcm63xx/Makefile
index ac28073..a085c2b 100644
--- a/arch/mips/bcm63xx/Makefile
+++ b/arch/mips/bcm63xx/Makefile
@@ -1,7 +1,7 @@
 obj-y		+= clk.o cpu.o cs.o gpio.o irq.o nvram.o prom.o reset.o \
 		   setup.o timer.o dev-dsp.o dev-enet.o dev-flash.o \
 		   dev-pcmcia.o dev-rng.o dev-spi.o dev-uart.o dev-wdt.o \
-		   dev-usb-usbd.o
+		   dev-usb-usbd.o usb-common.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-y		+= boards/
diff --git a/arch/mips/bcm63xx/usb-common.c b/arch/mips/bcm63xx/usb-common.c
new file mode 100644
index 0000000..b617cf6
--- /dev/null
+++ b/arch/mips/bcm63xx/usb-common.c
@@ -0,0 +1,53 @@
+/*
+ * Broadcom BCM63xx common USB device configuration code
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012 Kevin Cernekee <cernekee@gmail.com>
+ * Copyright (C) 2012 Broadcom Corporation
+ *
+ */
+#include <linux/export.h>
+
+#include <bcm63xx_cpu.h>
+#include <bcm63xx_regs.h>
+#include <bcm63xx_io.h>
+#include <bcm63xx_usb_priv.h>
+
+void bcm63xx_usb_priv_select_phy_mode(u32 portmask, bool is_device)
+{
+	u32 val;
+
+	val = bcm_rset_readl(RSET_USBH_PRIV, USBH_PRIV_UTMI_CTL_6368_REG);
+	if (is_device) {
+		val |= (portmask << USBH_PRIV_UTMI_CTL_HOSTB_SHIFT);
+		val |= (portmask << USBH_PRIV_UTMI_CTL_NODRIV_SHIFT);
+	} else {
+		val &= ~(portmask << USBH_PRIV_UTMI_CTL_HOSTB_SHIFT);
+		val &= ~(portmask << USBH_PRIV_UTMI_CTL_NODRIV_SHIFT);
+	}
+	bcm_rset_writel(RSET_USBH_PRIV, val, USBH_PRIV_UTMI_CTL_6368_REG);
+
+	val = bcm_rset_readl(RSET_USBH_PRIV, USBH_PRIV_SWAP_6368_REG);
+	if (is_device)
+		val |= USBH_PRIV_SWAP_USBD_MASK;
+	else
+		val &= ~USBH_PRIV_SWAP_USBD_MASK;
+	bcm_rset_writel(RSET_USBH_PRIV, val, USBH_PRIV_SWAP_6368_REG);
+}
+EXPORT_SYMBOL(bcm63xx_usb_host_priv_cfg_set);
+
+void bcm63xx_usb_priv_select_pullup(u32 portmask, bool is_on)
+{
+	u32 val;
+
+	val = bcm_rset_readl(RSET_USBH_PRIV, USBH_PRIV_UTMI_CTL_6368_REG);
+	if (is_on)
+		val &= ~(portmask << USBH_PRIV_UTMI_CTL_NODRIV_SHIFT);
+	else
+		val |= (portmask << USBH_PRIV_UTMI_CTL_NODRIV_SHIFT);
+	bcm_rset_writel(RSET_USBH_PRIV, val, USBH_PRIV_UTMI_CTL_6368_REG);
+}
+EXPORT_SYMBOL(bcm63xx_usb_priv_select_pullup);
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_usb_priv.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_usb_priv.h
new file mode 100644
index 0000000..f0d4b59
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_usb_priv.h
@@ -0,0 +1,9 @@
+#ifndef BCM63XX_USB_PRIV_H_
+#define BCM63XX_USB_PRIV_H_
+
+#include <linux/types.h>
+
+void bcm63xx_usb_priv_select_phy_mode(u32 portmask, bool is_device);
+void bcm63xx_usb_priv_select_pullup(u32 portmask, bool is_on);
+
+#endif /* BCM63XX_USB_PRIV_H_ */
diff --git a/drivers/usb/gadget/bcm63xx_udc.c b/drivers/usb/gadget/bcm63xx_udc.c
index ad17533..af450c4 100644
--- a/drivers/usb/gadget/bcm63xx_udc.c
+++ b/drivers/usb/gadget/bcm63xx_udc.c
@@ -41,6 +41,7 @@
 #include <bcm63xx_dev_usb_usbd.h>
 #include <bcm63xx_io.h>
 #include <bcm63xx_regs.h>
+#include <bcm63xx_usb_priv.h>
 
 #define DRV_MODULE_NAME		"bcm63xx_udc"
 
@@ -863,22 +864,7 @@ static void bcm63xx_select_phy_mode(struct bcm63xx_udc *udc, bool is_device)
 		bcm_gpio_writel(val, GPIO_PINMUX_OTHR_REG);
 	}
 
-	val = bcm_rset_readl(RSET_USBH_PRIV, USBH_PRIV_UTMI_CTL_6368_REG);
-	if (is_device) {
-		val |= (portmask << USBH_PRIV_UTMI_CTL_HOSTB_SHIFT);
-		val |= (portmask << USBH_PRIV_UTMI_CTL_NODRIV_SHIFT);
-	} else {
-		val &= ~(portmask << USBH_PRIV_UTMI_CTL_HOSTB_SHIFT);
-		val &= ~(portmask << USBH_PRIV_UTMI_CTL_NODRIV_SHIFT);
-	}
-	bcm_rset_writel(RSET_USBH_PRIV, val, USBH_PRIV_UTMI_CTL_6368_REG);
-
-	val = bcm_rset_readl(RSET_USBH_PRIV, USBH_PRIV_SWAP_6368_REG);
-	if (is_device)
-		val |= USBH_PRIV_SWAP_USBD_MASK;
-	else
-		val &= ~USBH_PRIV_SWAP_USBD_MASK;
-	bcm_rset_writel(RSET_USBH_PRIV, val, USBH_PRIV_SWAP_6368_REG);
+	bcm63xx_usb_priv_select_phy_mode(portmask, is_device);
 }
 
 /**
@@ -892,14 +878,9 @@ static void bcm63xx_select_phy_mode(struct bcm63xx_udc *udc, bool is_device)
  */
 static void bcm63xx_select_pullup(struct bcm63xx_udc *udc, bool is_on)
 {
-	u32 val, portmask = BIT(udc->pd->port_no);
+	u32 portmask = BIT(udc->pd->port_no);
 
-	val = bcm_rset_readl(RSET_USBH_PRIV, USBH_PRIV_UTMI_CTL_6368_REG);
-	if (is_on)
-		val &= ~(portmask << USBH_PRIV_UTMI_CTL_NODRIV_SHIFT);
-	else
-		val |= (portmask << USBH_PRIV_UTMI_CTL_NODRIV_SHIFT);
-	bcm_rset_writel(RSET_USBH_PRIV, val, USBH_PRIV_UTMI_CTL_6368_REG);
+	bcm63xx_usb_priv_select_pullup(portmask, is_on);
 }
 
 /**
-- 
1.7.10.4
