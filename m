Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2011 17:14:55 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:51024 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491942Ab1CAQMa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Mar 2011 17:12:30 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mips@linux-mips.org
Subject: [PATCH V2 07/10] MIPS: lantiq: add platform device support
Date:   Tue,  1 Mar 2011 17:13:23 +0100
Message-Id: <1298996006-15960-8-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298996006-15960-1-git-send-email-blogic@openwrt.org>
References: <1298996006-15960-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch adds the wrappers for registering our platform devices.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Ralph Hempel <ralph.hempel@lantiq.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/lantiq/Makefile       |    2 +-
 arch/mips/lantiq/devices.c      |  128 +++++++++++++++++++++++++++++++++++++++
 arch/mips/lantiq/devices.h      |   20 ++++++
 arch/mips/lantiq/xway/Makefile  |    2 +-
 arch/mips/lantiq/xway/devices.c |   79 ++++++++++++++++++++++++
 arch/mips/lantiq/xway/devices.h |   17 +++++
 6 files changed, 246 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/lantiq/devices.c
 create mode 100644 arch/mips/lantiq/devices.h
 create mode 100644 arch/mips/lantiq/xway/devices.c
 create mode 100644 arch/mips/lantiq/xway/devices.h

diff --git a/arch/mips/lantiq/Makefile b/arch/mips/lantiq/Makefile
index a268391..e5dae0e 100644
--- a/arch/mips/lantiq/Makefile
+++ b/arch/mips/lantiq/Makefile
@@ -4,7 +4,7 @@
 # under the terms of the GNU General Public License version 2 as published
 # by the Free Software Foundation.
 
-obj-y := irq.o setup.o clk.o prom.o
+obj-y := irq.o setup.o clk.o prom.o devices.o
 
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 
diff --git a/arch/mips/lantiq/devices.c b/arch/mips/lantiq/devices.c
new file mode 100644
index 0000000..6384b1f
--- /dev/null
+++ b/arch/mips/lantiq/devices.c
@@ -0,0 +1,128 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/reboot.h>
+#include <linux/platform_device.h>
+#include <linux/leds.h>
+#include <linux/etherdevice.h>
+#include <linux/reboot.h>
+#include <linux/time.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+#include <linux/leds.h>
+
+#include <asm/bootinfo.h>
+#include <asm/irq.h>
+
+#include <lantiq_soc.h>
+
+#include "devices.h"
+
+#define IRQ_RES(resname, irq) \
+	{.name = #resname, .start = (irq), .flags = IORESOURCE_IRQ}
+
+/* nor flash */
+static struct resource ltq_nor_resource = {
+	.name	= "nor",
+	.start	= LTQ_FLASH_START,
+	.end	= LTQ_FLASH_START + LTQ_FLASH_MAX - 1,
+	.flags  = IORESOURCE_MEM,
+};
+
+static struct platform_device ltq_nor = {
+	.name		= "ltq_nor",
+	.resource	= &ltq_nor_resource,
+	.num_resources	= 1,
+};
+
+void __init
+ltq_register_nor(struct physmap_flash_data *data)
+{
+	ltq_nor.dev.platform_data = data;
+	platform_device_register(&ltq_nor);
+}
+
+/* watchdog */
+static struct resource ltq_wdt_resource = {
+	.name	= "watchdog",
+	.start  = LTQ_WDT_BASE_ADDR,
+	.end    = LTQ_WDT_BASE_ADDR + LTQ_WDT_SIZE - 1,
+	.flags  = IORESOURCE_MEM,
+};
+
+void __init
+ltq_register_wdt(void)
+{
+	platform_device_register_simple("ltq_wdt", 0, &ltq_wdt_resource, 1);
+}
+
+/* asc ports */
+static struct resource ltq_asc0_resources[] = {
+	{
+		.start  = LTQ_ASC0_BASE_ADDR,
+		.end    = LTQ_ASC0_BASE_ADDR + LTQ_ASC_SIZE - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	IRQ_RES(tx, LTQ_ASC_TIR(0)),
+	IRQ_RES(rx, LTQ_ASC_RIR(0)),
+	IRQ_RES(err, LTQ_ASC_EIR(0)),
+};
+
+static struct resource ltq_asc1_resources[] = {
+	{
+		.start  = LTQ_ASC1_BASE_ADDR,
+		.end    = LTQ_ASC1_BASE_ADDR + LTQ_ASC_SIZE - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	IRQ_RES(tx, LTQ_ASC_TIR(1)),
+	IRQ_RES(rx, LTQ_ASC_RIR(1)),
+	IRQ_RES(err, LTQ_ASC_EIR(1)),
+};
+
+void __init
+ltq_register_asc(int port)
+{
+	switch (port) {
+	case 0:
+		platform_device_register_simple("ltq_asc", 0,
+			ltq_asc0_resources, ARRAY_SIZE(ltq_asc0_resources));
+		break;
+	case 1:
+		platform_device_register_simple("ltq_asc", 1,
+			ltq_asc1_resources, ARRAY_SIZE(ltq_asc1_resources));
+		break;
+	default:
+		break;
+	}
+}
+
+#ifdef CONFIG_PCI
+/* pci */
+static struct platform_device ltq_pci = {
+	.name		= "ltq_pci",
+	.num_resources	= 0,
+};
+
+void __init
+ltq_register_pci(struct ltq_pci_data *data)
+{
+	ltq_pci.dev.platform_data = data;
+	platform_device_register(&ltq_pci);
+}
+#else
+void __init
+ltq_register_pci(struct ltq_pci_data *data)
+{
+	printk(KERN_INFO "kernel is compiled without PCI support\n");
+}
+#endif
diff --git a/arch/mips/lantiq/devices.h b/arch/mips/lantiq/devices.h
new file mode 100644
index 0000000..069006c
--- /dev/null
+++ b/arch/mips/lantiq/devices.h
@@ -0,0 +1,20 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#ifndef _LTQ_DEVICES_H__
+#define _LTQ_DEVICES_H__
+
+#include <lantiq_platform.h>
+#include <linux/mtd/physmap.h>
+
+extern void ltq_register_nor(struct physmap_flash_data *data);
+extern void ltq_register_wdt(void);
+extern void ltq_register_asc(int port);
+extern void ltq_register_pci(struct ltq_pci_data *data);
+
+#endif
diff --git a/arch/mips/lantiq/xway/Makefile b/arch/mips/lantiq/xway/Makefile
index 9c85ff9..74ce438 100644
--- a/arch/mips/lantiq/xway/Makefile
+++ b/arch/mips/lantiq/xway/Makefile
@@ -1,4 +1,4 @@
-obj-y := pmu.o ebu.o reset.o gpio.o
+obj-y := pmu.o ebu.o reset.o gpio.o devices.o
 
 obj-$(CONFIG_SOC_XWAY) += clk-xway.o prom-xway.o
 obj-$(CONFIG_SOC_AMAZON_SE) += clk-ase.o prom-ase.o
diff --git a/arch/mips/lantiq/xway/devices.c b/arch/mips/lantiq/xway/devices.c
new file mode 100644
index 0000000..37543f8
--- /dev/null
+++ b/arch/mips/lantiq/xway/devices.c
@@ -0,0 +1,79 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/mtd/physmap.h>
+#include <linux/kernel.h>
+#include <linux/reboot.h>
+#include <linux/platform_device.h>
+#include <linux/leds.h>
+#include <linux/etherdevice.h>
+#include <linux/reboot.h>
+#include <linux/time.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+#include <linux/leds.h>
+
+#include <asm/bootinfo.h>
+#include <asm/irq.h>
+
+#include <lantiq_soc.h>
+#include <lantiq_irq.h>
+#include <lantiq_platform.h>
+
+/* gpio */
+static struct resource ltq_gpio_resource[] = {
+	{
+		.name	= "gpio0",
+		.start  = LTQ_GPIO0_BASE_ADDR,
+		.end    = LTQ_GPIO0_BASE_ADDR + LTQ_GPIO_SIZE - 1,
+		.flags  = IORESOURCE_MEM,
+	}, {
+		.name	= "gpio1",
+		.start  = LTQ_GPIO1_BASE_ADDR,
+		.end    = LTQ_GPIO1_BASE_ADDR + LTQ_GPIO_SIZE - 1,
+		.flags  = IORESOURCE_MEM,
+	}, {
+		.name	= "gpio2",
+		.start  = LTQ_GPIO2_BASE_ADDR,
+		.end    = LTQ_GPIO2_BASE_ADDR + LTQ_GPIO_SIZE - 1,
+		.flags  = IORESOURCE_MEM,
+	}
+};
+
+void __init
+ltq_register_gpio(void)
+{
+	platform_device_register_simple("ltq_gpio", 0,
+		&ltq_gpio_resource[0], 1);
+	platform_device_register_simple("ltq_gpio", 1,
+		&ltq_gpio_resource[1], 1);
+
+	/* AR9 and VR9 have an extra gpio block */
+	if (ltq_is_ar9() || ltq_is_vr9()) {
+		platform_device_register_simple("ltq_gpio", 2,
+			&ltq_gpio_resource[2], 1);
+	}
+}
+
+/* serial to parallel conversion */
+static struct resource ltq_stp_resource = {
+	.name   = "stp",
+	.start  = LTQ_STP_BASE_ADDR,
+	.end    = LTQ_STP_BASE_ADDR + LTQ_STP_SIZE - 1,
+	.flags  = IORESOURCE_MEM,
+};
+
+void __init
+ltq_register_gpio_stp(void)
+{
+	platform_device_register_simple("ltq_stp", 0, &ltq_stp_resource, 1);
+}
diff --git a/arch/mips/lantiq/xway/devices.h b/arch/mips/lantiq/xway/devices.h
new file mode 100644
index 0000000..87ba61e
--- /dev/null
+++ b/arch/mips/lantiq/xway/devices.h
@@ -0,0 +1,17 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#ifndef _LTQ_DEVICES_XWAY_H__
+#define _LTQ_DEVICES_XWAY_H__
+
+#include "../devices.h"
+
+extern void ltq_register_gpio(void);
+extern void ltq_register_gpio_stp(void);
+
+#endif
-- 
1.7.2.3
