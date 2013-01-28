Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2013 20:09:29 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:33183 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833255Ab3A1TJ0eTOJo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Jan 2013 20:09:26 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 1A96DBF51CE;
        Mon, 28 Jan 2013 20:09:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Tgi7LrCDDNSS; Mon, 28 Jan 2013 20:09:25 +0100 (CET)
Received: from flexo.localdomain (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 74704BF5183;
        Mon, 28 Jan 2013 20:09:25 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, jogo@openwrt.org, mbizon@freebox.fr,
        cenerkee@gmail.com, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        blogic@openwrt.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 04/13] MIPS: BCM63XX: add OHCI/EHCI configuration bits to common USB code
Date:   Mon, 28 Jan 2013 20:06:22 +0100
Message-Id: <1359399991-2236-5-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1359399991-2236-1-git-send-email-florian@openwrt.org>
References: <1359399991-2236-1-git-send-email-florian@openwrt.org>
X-archive-position: 35583
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

This patch updates the common USB code touching the USB private
registers with the specific bits to properly enable OHCI and EHCI
controllers on BCM63xx SoCs. As a result we now need to protect access
to Read Modify Write sequences using a spinlock because we cannot
guarantee that any of the exposed helper will not be called
concurrently.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/usb-common.c                     |   97 ++++++++++++++++++++
 .../include/asm/mach-bcm63xx/bcm63xx_usb_priv.h    |    2 +
 2 files changed, 99 insertions(+)

diff --git a/arch/mips/bcm63xx/usb-common.c b/arch/mips/bcm63xx/usb-common.c
index b617cf6..e18ac08 100644
--- a/arch/mips/bcm63xx/usb-common.c
+++ b/arch/mips/bcm63xx/usb-common.c
@@ -5,10 +5,12 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
+ * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
  * Copyright (C) 2012 Kevin Cernekee <cernekee@gmail.com>
  * Copyright (C) 2012 Broadcom Corporation
  *
  */
+#include <linux/spinlock.h>
 #include <linux/export.h>
 
 #include <bcm63xx_cpu.h>
@@ -16,9 +18,14 @@
 #include <bcm63xx_io.h>
 #include <bcm63xx_usb_priv.h>
 
+static DEFINE_SPINLOCK(usb_priv_reg_lock);
+
 void bcm63xx_usb_priv_select_phy_mode(u32 portmask, bool is_device)
 {
 	u32 val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&usb_priv_reg_lock, flags);
 
 	val = bcm_rset_readl(RSET_USBH_PRIV, USBH_PRIV_UTMI_CTL_6368_REG);
 	if (is_device) {
@@ -36,12 +43,17 @@ void bcm63xx_usb_priv_select_phy_mode(u32 portmask, bool is_device)
 	else
 		val &= ~USBH_PRIV_SWAP_USBD_MASK;
 	bcm_rset_writel(RSET_USBH_PRIV, val, USBH_PRIV_SWAP_6368_REG);
+
+	spin_unlock_irqrestore(&usb_priv_reg_lock, flags);
 }
 EXPORT_SYMBOL(bcm63xx_usb_host_priv_cfg_set);
 
 void bcm63xx_usb_priv_select_pullup(u32 portmask, bool is_on)
 {
 	u32 val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&usb_priv_reg_lock, flags);
 
 	val = bcm_rset_readl(RSET_USBH_PRIV, USBH_PRIV_UTMI_CTL_6368_REG);
 	if (is_on)
@@ -49,5 +61,90 @@ void bcm63xx_usb_priv_select_pullup(u32 portmask, bool is_on)
 	else
 		val |= (portmask << USBH_PRIV_UTMI_CTL_NODRIV_SHIFT);
 	bcm_rset_writel(RSET_USBH_PRIV, val, USBH_PRIV_UTMI_CTL_6368_REG);
+
+	spin_unlock_irqrestore(&usb_priv_reg_lock, flags);
 }
 EXPORT_SYMBOL(bcm63xx_usb_priv_select_pullup);
+
+/* The following array represents the meaning of the DESC/DATA
+ * endian swapping with respect to the CPU configured endianness
+ *
+ * DATA	ENDN	mmio	descriptor
+ * 0	0	BE	invalid
+ * 0	1	BE	LE
+ * 1	0	BE	BE
+ * 1	1	BE	invalid
+ *
+ * Since BCM63XX SoCs are configured to be in big-endian mode
+ * we want configuration at line 3.
+ */
+void bcm63xx_usb_priv_ohci_cfg_set(void)
+{
+	u32 reg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&usb_priv_reg_lock, flags);
+
+	if (BCMCPU_IS_6348())
+		bcm_rset_writel(RSET_OHCI_PRIV, 0, OHCI_PRIV_REG);
+	else if (BCMCPU_IS_6358()) {
+		reg = bcm_rset_readl(RSET_USBH_PRIV, USBH_PRIV_SWAP_6358_REG);
+		reg &= ~USBH_PRIV_SWAP_OHCI_ENDN_MASK;
+		reg |= USBH_PRIV_SWAP_OHCI_DATA_MASK;
+		bcm_rset_writel(RSET_USBH_PRIV, reg, USBH_PRIV_SWAP_6358_REG);
+		/*
+		 * The magic value comes for the original vendor BSP
+		 * and is needed for USB to work. Datasheet does not
+		 * help, so the magic value is used as-is.
+		 */
+		bcm_rset_writel(RSET_USBH_PRIV, 0x1c0020,
+				USBH_PRIV_TEST_6358_REG);
+
+	} else if (BCMCPU_IS_6328() || BCMCPU_IS_6368()) {
+		reg = bcm_rset_readl(RSET_USBH_PRIV, USBH_PRIV_SWAP_6368_REG);
+		reg &= ~USBH_PRIV_SWAP_OHCI_ENDN_MASK;
+		reg |= USBH_PRIV_SWAP_OHCI_DATA_MASK;
+		bcm_rset_writel(RSET_USBH_PRIV, reg, USBH_PRIV_SWAP_6368_REG);
+
+		reg = bcm_rset_readl(RSET_USBH_PRIV, USBH_PRIV_SETUP_6368_REG);
+		reg |= USBH_PRIV_SETUP_IOC_MASK;
+		bcm_rset_writel(RSET_USBH_PRIV, reg, USBH_PRIV_SETUP_6368_REG);
+	}
+
+	spin_unlock_irqrestore(&usb_priv_reg_lock, flags);
+}
+
+void bcm63xx_usb_priv_ehci_cfg_set(void)
+{
+	u32 reg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&usb_priv_reg_lock, flags);
+
+	if (BCMCPU_IS_6358()) {
+		reg = bcm_rset_readl(RSET_USBH_PRIV, USBH_PRIV_SWAP_6358_REG);
+		reg &= ~USBH_PRIV_SWAP_EHCI_ENDN_MASK;
+		reg |= USBH_PRIV_SWAP_EHCI_DATA_MASK;
+		bcm_rset_writel(RSET_USBH_PRIV, reg, USBH_PRIV_SWAP_6358_REG);
+
+		/*
+		 * The magic value comes for the original vendor BSP
+		 * and is needed for USB to work. Datasheet does not
+		 * help, so the magic value is used as-is.
+		 */
+		bcm_rset_writel(RSET_USBH_PRIV, 0x1c0020,
+				USBH_PRIV_TEST_6358_REG);
+
+	} else if (BCMCPU_IS_6328() || BCMCPU_IS_6368()) {
+		reg = bcm_rset_readl(RSET_USBH_PRIV, USBH_PRIV_SWAP_6368_REG);
+		reg &= ~USBH_PRIV_SWAP_EHCI_ENDN_MASK;
+		reg |= USBH_PRIV_SWAP_EHCI_DATA_MASK;
+		bcm_rset_writel(RSET_USBH_PRIV, reg, USBH_PRIV_SWAP_6368_REG);
+
+		reg = bcm_rset_readl(RSET_USBH_PRIV, USBH_PRIV_SETUP_6368_REG);
+		reg |= USBH_PRIV_SETUP_IOC_MASK;
+		bcm_rset_writel(RSET_USBH_PRIV, reg, USBH_PRIV_SETUP_6368_REG);
+	}
+
+	spin_unlock_irqrestore(&usb_priv_reg_lock, flags);
+}
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_usb_priv.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_usb_priv.h
index f0d4b59..e7c01e4 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_usb_priv.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_usb_priv.h
@@ -5,5 +5,7 @@
 
 void bcm63xx_usb_priv_select_phy_mode(u32 portmask, bool is_device);
 void bcm63xx_usb_priv_select_pullup(u32 portmask, bool is_on);
+void bcm63xx_usb_priv_ohci_cfg_set(void);
+void bcm63xx_usb_priv_ehci_cfg_set(void);
 
 #endif /* BCM63XX_USB_PRIV_H_ */
-- 
1.7.10.4
