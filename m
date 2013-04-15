Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Apr 2013 12:27:31 +0200 (CEST)
Received: from 84-245-11-97.dsl.cambrium.nl ([84.245.11.97]:37728 "EHLO
        grubby.stderr.nl" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S6835119Ab3DOK12nbbjC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Apr 2013 12:27:28 +0200
Received: from matthijs by grubby.stderr.nl with local (Exim 4.80)
        (envelope-from <matthijs@stdin.nl>)
        id 1URgdD-0002BL-1z; Mon, 15 Apr 2013 12:27:27 +0200
From:   Matthijs Kooijman <matthijs@stdin.nl>
To:     John Crispin <blogic@openwrt.org>
Cc:     linux-mips@linux-mips.org, Matthijs Kooijman <matthijs@stdin.nl>
Subject: [PATCH 2/3] MIPS: ralink: setup dma_mask for the rt305x dwc2 usb controller
Date:   Mon, 15 Apr 2013 12:27:23 +0200
Message-Id: <1366021644-8353-2-git-send-email-matthijs@stdin.nl>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1366021644-8353-1-git-send-email-matthijs@stdin.nl>
References: <1366021644-8353-1-git-send-email-matthijs@stdin.nl>
Return-Path: <matthijs@stdin.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36165
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

Add code to setup the dma mask for the usb dwc2 platform driver on
Ralink SoC. This contains a bit more code than strictly necessary, so it
can also be used to set up ehci and ohci on other ralink platforms later
on.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Matthijs Kooijman <matthijs@stdin.nl>
---
 arch/mips/ralink/Makefile     |  2 +-
 arch/mips/ralink/common.h     |  2 ++
 arch/mips/ralink/mt7620.c     |  5 +++++
 arch/mips/ralink/of.c         |  2 ++
 arch/mips/ralink/rt288x.c     |  4 ++++
 arch/mips/ralink/rt305x-usb.c | 51 +++++++++++++++++++++++++++++++++++++++++++
 arch/mips/ralink/rt3883.c     |  5 +++++
 7 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/ralink/rt305x-usb.c

v2: Rebased on top of mips-next-3.10
    Switched order with next patch
    Renamed ralink_usb_platform() to ralink_usb_init()
    Added empty function to rt288x.c

diff --git a/arch/mips/ralink/Makefile b/arch/mips/ralink/Makefile
index 38cf1a8..c5572a3 100644
--- a/arch/mips/ralink/Makefile
+++ b/arch/mips/ralink/Makefile
@@ -9,7 +9,7 @@
 obj-y := prom.o of.o reset.o clk.o irq.o
 
 obj-$(CONFIG_SOC_RT288X) += rt288x.o
-obj-$(CONFIG_SOC_RT305X) += rt305x.o
+obj-$(CONFIG_SOC_RT305X) += rt305x.o rt305x-usb.o
 obj-$(CONFIG_SOC_RT3883) += rt3883.o
 obj-$(CONFIG_SOC_MT7620) += mt7620.o
 
diff --git a/arch/mips/ralink/common.h b/arch/mips/ralink/common.h
index 83144c3..20089cae 100644
--- a/arch/mips/ralink/common.h
+++ b/arch/mips/ralink/common.h
@@ -50,4 +50,6 @@ extern void prom_soc_init(struct ralink_soc_info *soc_info);
 
 __iomem void *plat_of_remap_node(const char *node);
 
+void ralink_usb_init(void);
+
 #endif /* _RALINK_COMMON_H__ */
diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 3740826..220dc69 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -137,6 +137,11 @@ struct ralink_pinmux rt_gpio_pinmux = {
 	.uart_mask = MT7620_GPIO_MODE_GPIO,
 };
 
+void ralink_usb_init(void)
+{
+
+}
+
 void __init ralink_clk_init(void)
 {
 	unsigned long cpu_rate, sys_rate;
diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
index d285ea8..b63623b 100644
--- a/arch/mips/ralink/of.c
+++ b/arch/mips/ralink/of.c
@@ -108,6 +108,8 @@ static int __init plat_of_setup(void)
 	if (of_platform_populate(NULL, of_ids, NULL, NULL))
 		panic("failed to populate DT\n");
 
+	ralink_usb_init();
+
 	return 0;
 }
 
diff --git a/arch/mips/ralink/rt288x.c b/arch/mips/ralink/rt288x.c
index f87de1a..652201c 100644
--- a/arch/mips/ralink/rt288x.c
+++ b/arch/mips/ralink/rt288x.c
@@ -74,6 +74,10 @@ struct ralink_pinmux rt_gpio_pinmux = {
 	.wdt_reset = rt288x_wdt_reset,
 };
 
+void ralink_usb_init(void)
+{
+}
+
 void __init ralink_clk_init(void)
 {
 	unsigned long cpu_rate;
diff --git a/arch/mips/ralink/rt305x-usb.c b/arch/mips/ralink/rt305x-usb.c
new file mode 100644
index 0000000..af6f062
--- /dev/null
+++ b/arch/mips/ralink/rt305x-usb.c
@@ -0,0 +1,51 @@
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
+#include <linux/of_platform.h>
+#include <linux/dma-mapping.h>
+
+#include <asm/mach-ralink/rt305x.h>
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
+static u64 rt3050_dwc2_dmamask = DMA_BIT_MASK(32);
+
+void ralink_usb_init(void)
+{
+	if (soc_is_rt305x() || soc_is_rt3350()) {
+		ralink_add_usb("ralink,rt3050-usb",
+				NULL, &rt3050_dwc2_dmamask);
+	}
+}
diff --git a/arch/mips/ralink/rt3883.c b/arch/mips/ralink/rt3883.c
index afbf2ce..c403696 100644
--- a/arch/mips/ralink/rt3883.c
+++ b/arch/mips/ralink/rt3883.c
@@ -166,6 +166,11 @@ struct ralink_pinmux rt_gpio_pinmux = {
 	.pci_mask = RT3883_GPIO_MODE_PCI_MASK,
 };
 
+void ralink_usb_init(void)
+{
+}
+
+
 void __init ralink_clk_init(void)
 {
 	unsigned long cpu_rate, sys_rate;
-- 
1.8.0
