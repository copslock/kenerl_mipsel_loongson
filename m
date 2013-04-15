Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Apr 2013 12:27:49 +0200 (CEST)
Received: from 84-245-11-97.dsl.cambrium.nl ([84.245.11.97]:37730 "EHLO
        grubby.stderr.nl" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S6835122Ab3DOK12oNRUT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Apr 2013 12:27:28 +0200
Received: from matthijs by grubby.stderr.nl with local (Exim 4.80)
        (envelope-from <matthijs@stdin.nl>)
        id 1URgdD-0002BO-3C; Mon, 15 Apr 2013 12:27:27 +0200
From:   Matthijs Kooijman <matthijs@stdin.nl>
To:     John Crispin <blogic@openwrt.org>
Cc:     linux-mips@linux-mips.org, Matthijs Kooijman <matthijs@stdin.nl>
Subject: [PATCH 3/3] owrt: MIPS: ralink: add usb platform support
Date:   Mon, 15 Apr 2013 12:27:24 +0200
Message-Id: <1366021644-8353-3-git-send-email-matthijs@stdin.nl>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1366021644-8353-1-git-send-email-matthijs@stdin.nl>
References: <1366021644-8353-1-git-send-email-matthijs@stdin.nl>
Return-Path: <matthijs@stdin.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matthijs@stdin.nl
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

From: John Crispin <blogic@openwrt.org>

Add code to load the platform ehci/ohci driver on Ralink SoC. For the usb core
to work we need to populate the platform_data during boot, prior to the usb
driver being loaded.

Signed-off-by: John Crispin <blogic@openwrt.org>
[matthijs@stdin.nl: Extracted non-ohci/ehci 3052 code into separate patch]
Signed-off-by: Matthijs Kooijman <matthijs@stdin.nl>
---
 arch/mips/ralink/Makefile     |   2 +-
 arch/mips/ralink/rt305x-usb.c |  74 ++++++++++++++++++++++++++
 arch/mips/ralink/rt3883-usb.c | 118 ++++++++++++++++++++++++++++++++++++++++++
 arch/mips/ralink/rt3883.c     |   5 --
 4 files changed, 193 insertions(+), 6 deletions(-)
 create mode 100644 arch/mips/ralink/rt3883-usb.c

v2: Rebased on top of mips-next-3.10
    Switched order with previous patch

This patch isn't intended for mips-next-3.10 yet.

diff --git a/arch/mips/ralink/Makefile b/arch/mips/ralink/Makefile
index c5572a3..ef7d6c8 100644
--- a/arch/mips/ralink/Makefile
+++ b/arch/mips/ralink/Makefile
@@ -10,7 +10,7 @@ obj-y := prom.o of.o reset.o clk.o irq.o
 
 obj-$(CONFIG_SOC_RT288X) += rt288x.o
 obj-$(CONFIG_SOC_RT305X) += rt305x.o rt305x-usb.o
-obj-$(CONFIG_SOC_RT3883) += rt3883.o
+obj-$(CONFIG_SOC_RT3883) += rt3883.o rt3883-usb.o
 obj-$(CONFIG_SOC_MT7620) += mt7620.o
 
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
diff --git a/arch/mips/ralink/rt305x-usb.c b/arch/mips/ralink/rt305x-usb.c
index af6f062..d18f739 100644
--- a/arch/mips/ralink/rt305x-usb.c
+++ b/arch/mips/ralink/rt305x-usb.c
@@ -11,11 +11,77 @@
 #include <linux/init.h>
 #include <linux/module.h>
 
+#include <linux/delay.h>
 #include <linux/of_platform.h>
 #include <linux/dma-mapping.h>
+#include <linux/usb/ehci_pdriver.h>
+#include <linux/usb/ohci_pdriver.h>
 
+#include <asm/mach-ralink/ralink_regs.h>
 #include <asm/mach-ralink/rt305x.h>
 
+static atomic_t rt3352_usb_pwr_ref = ATOMIC_INIT(0);
+
+static int rt3352_usb_power_on(struct platform_device *pdev)
+{
+
+	if (atomic_inc_return(&rt3352_usb_pwr_ref) == 1) {
+		u32 t;
+
+		t = rt_sysc_r32(RT3352_SYSC_REG_USB_PS);
+
+		/* enable clock for port0's and port1's phys */
+		t = rt_sysc_r32(RT3352_SYSC_REG_CLKCFG1);
+		t |= RT3352_CLKCFG1_UPHY0_CLK_EN | RT3352_CLKCFG1_UPHY1_CLK_EN;
+		rt_sysc_w32(t, RT3352_SYSC_REG_CLKCFG1);
+		mdelay(500);
+
+		/* pull USBHOST and USBDEV out from reset */
+		t = rt_sysc_r32(RT3352_SYSC_REG_RSTCTRL);
+		t &= ~(RT3352_RSTCTRL_UHST | RT3352_RSTCTRL_UDEV);
+		rt_sysc_w32(t, RT3352_SYSC_REG_RSTCTRL);
+		mdelay(500);
+
+		/* enable host mode */
+		t = rt_sysc_r32(RT3352_SYSC_REG_SYSCFG1);
+		t |= RT3352_SYSCFG1_USB0_HOST_MODE;
+		rt_sysc_w32(t, RT3352_SYSC_REG_SYSCFG1);
+
+		t = rt_sysc_r32(RT3352_SYSC_REG_USB_PS);
+	}
+
+	return 0;
+}
+
+static void rt3352_usb_power_off(struct platform_device *pdev)
+{
+	if (atomic_dec_return(&rt3352_usb_pwr_ref) == 0) {
+		u32 t;
+
+		/* put USBHOST and USBDEV into reset */
+		t = rt_sysc_r32(RT3352_SYSC_REG_RSTCTRL);
+		t |= RT3352_RSTCTRL_UHST | RT3352_RSTCTRL_UDEV;
+		rt_sysc_w32(t, RT3352_SYSC_REG_RSTCTRL);
+		udelay(10000);
+
+		/* disable clock for port0's and port1's phys*/
+		t = rt_sysc_r32(RT3352_SYSC_REG_CLKCFG1);
+		t &= ~(RT3352_CLKCFG1_UPHY0_CLK_EN | RT3352_CLKCFG1_UPHY1_CLK_EN);
+		rt_sysc_w32(t, RT3352_SYSC_REG_CLKCFG1);
+		udelay(10000);
+	}
+}
+
+static struct usb_ehci_pdata rt3352_ehci_data = {
+	.power_on	= rt3352_usb_power_on,
+	.power_off	= rt3352_usb_power_off,
+};
+
+static struct usb_ohci_pdata rt3352_ohci_data = {
+	.power_on	= rt3352_usb_power_on,
+	.power_off	= rt3352_usb_power_off,
+};
+
 static void ralink_add_usb(char *name, void *pdata, u64 *mask)
 {
 	struct device_node *node;
@@ -40,10 +106,18 @@ error_out:
 	of_node_put(node);
 }
 
+static u64 rt3352_ohci_dmamask = DMA_BIT_MASK(32);
+static u64 rt3352_ehci_dmamask = DMA_BIT_MASK(32);
 static u64 rt3050_dwc2_dmamask = DMA_BIT_MASK(32);
 
 void ralink_usb_init(void)
 {
+	if (soc_is_rt3352() || soc_is_rt5350()) {
+		ralink_add_usb("ohci-platform",
+				&rt3352_ohci_data, &rt3352_ohci_dmamask);
+		ralink_add_usb("ehci-platform",
+				&rt3352_ehci_data, &rt3352_ehci_dmamask);
+	}
 	if (soc_is_rt305x() || soc_is_rt3350()) {
 		ralink_add_usb("ralink,rt3050-usb",
 				NULL, &rt3050_dwc2_dmamask);
diff --git a/arch/mips/ralink/rt3883-usb.c b/arch/mips/ralink/rt3883-usb.c
new file mode 100644
index 0000000..8cf778e
--- /dev/null
+++ b/arch/mips/ralink/rt3883-usb.c
@@ -0,0 +1,118 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
+ * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+
+#include <linux/delay.h>
+#include <linux/of_platform.h>
+#include <linux/dma-mapping.h>
+#include <linux/usb/ehci_pdriver.h>
+#include <linux/usb/ohci_pdriver.h>
+
+#include <asm/mach-ralink/ralink_regs.h>
+#include <asm/mach-ralink/rt3883.h>
+
+static atomic_t rt3883_usb_pwr_ref = ATOMIC_INIT(0);
+
+static int rt3883_usb_power_on(struct platform_device *pdev)
+{
+	if (atomic_inc_return(&rt3883_usb_pwr_ref) == 1) {
+		u32 t;
+
+		t = rt_sysc_r32(RT3883_SYSC_REG_USB_PS);
+
+		/* enable clock for port0's and port1's phys */
+		t = rt_sysc_r32(RT3883_SYSC_REG_CLKCFG1);
+		t |= RT3883_CLKCFG1_UPHY0_CLK_EN | RT3883_CLKCFG1_UPHY1_CLK_EN;
+		rt_sysc_w32(t, RT3883_SYSC_REG_CLKCFG1);
+		mdelay(500);
+
+		/* pull USBHOST and USBDEV out from reset */
+		t = rt_sysc_r32(RT3883_SYSC_REG_RSTCTRL);
+		t &= ~(RT3883_RSTCTRL_UHST | RT3883_RSTCTRL_UDEV);
+		rt_sysc_w32(t, RT3883_SYSC_REG_RSTCTRL);
+		mdelay(500);
+
+		/* enable host mode */
+		t = rt_sysc_r32(RT3883_SYSC_REG_SYSCFG1);
+		t |= RT3883_SYSCFG1_USB0_HOST_MODE;
+		rt_sysc_w32(t, RT3883_SYSC_REG_SYSCFG1);
+
+		t = rt_sysc_r32(RT3883_SYSC_REG_USB_PS);
+	}
+
+	return 0;
+}
+
+static void rt3883_usb_power_off(struct platform_device *pdev)
+{
+	if (atomic_dec_return(&rt3883_usb_pwr_ref) == 0) {
+		u32 t;
+
+		/* put USBHOST and USBDEV into reset */
+		t = rt_sysc_r32(RT3883_SYSC_REG_RSTCTRL);
+		t |= RT3883_RSTCTRL_UHST | RT3883_RSTCTRL_UDEV;
+		rt_sysc_w32(t, RT3883_SYSC_REG_RSTCTRL);
+		udelay(10000);
+
+		/* disable clock for port0's and port1's phys*/
+		t = rt_sysc_r32(RT3883_SYSC_REG_CLKCFG1);
+		t &= ~(RT3883_CLKCFG1_UPHY0_CLK_EN |
+		RT3883_CLKCFG1_UPHY1_CLK_EN);
+		rt_sysc_w32(t, RT3883_SYSC_REG_CLKCFG1);
+		udelay(10000);
+	}
+}
+
+static struct usb_ohci_pdata rt3883_ohci_data = {
+	.power_on	= rt3883_usb_power_on,
+	.power_off	= rt3883_usb_power_off,
+};
+
+static struct usb_ehci_pdata rt3883_ehci_data = {
+	.power_on	= rt3883_usb_power_on,
+	.power_off	= rt3883_usb_power_off,
+};
+
+static void ralink_add_usb(char *name, void *pdata, u64 *mask)
+{
+	struct device_node *node;
+	struct platform_device *pdev;
+
+	node = of_find_compatible_node(NULL, NULL, name);
+	if (!node)
+		return;
+
+	pdev = of_find_device_by_node(node);
+	if (!pdev)
+		goto error_out;
+
+	if (pdata)
+		pdev->dev.platform_data = pdata;
+	if (mask) {
+		pdev->dev.dma_mask = mask;
+		pdev->dev.coherent_dma_mask = *mask;
+	}
+
+error_out:
+	of_node_put(node);
+}
+
+static u64 rt3883_ohci_dmamask = DMA_BIT_MASK(32);
+static u64 rt3883_ehci_dmamask = DMA_BIT_MASK(32);
+
+void ralink_usb_init(void)
+{
+	ralink_add_usb("ohci-platform",
+			&rt3883_ohci_data, &rt3883_ohci_dmamask);
+	ralink_add_usb("ehci-platform",
+			&rt3883_ehci_data, &rt3883_ehci_dmamask);
+}
diff --git a/arch/mips/ralink/rt3883.c b/arch/mips/ralink/rt3883.c
index c403696..afbf2ce 100644
--- a/arch/mips/ralink/rt3883.c
+++ b/arch/mips/ralink/rt3883.c
@@ -166,11 +166,6 @@ struct ralink_pinmux rt_gpio_pinmux = {
 	.pci_mask = RT3883_GPIO_MODE_PCI_MASK,
 };
 
-void ralink_usb_init(void)
-{
-}
-
-
 void __init ralink_clk_init(void)
 {
 	unsigned long cpu_rate, sys_rate;
-- 
1.8.0
