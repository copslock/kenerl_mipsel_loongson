Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Apr 2013 13:53:47 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:41813 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6829888Ab3DJLve3m9KK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Apr 2013 13:51:34 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Gabor Juhos <juhosg@openwrt.org>, linux-mips@linux-mips.org,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 06/18] MIPS: ralink: add pinmux driver
Date:   Wed, 10 Apr 2013 13:47:15 +0200
Message-Id: <1365594447-13068-7-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1365594447-13068-1-git-send-email-blogic@openwrt.org>
References: <1365594447-13068-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Add code to setup the pinmux on ralonk SoC. The SoC has a single 32 bit register
for this functionality with simple on/off bits. Building a full featured pinctrl
driver would be overkill.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/Makefile |    2 +-
 arch/mips/ralink/common.h |    8 +++-
 arch/mips/ralink/of.c     |    2 +
 arch/mips/ralink/pinmux.c |   95 +++++++++++++++++++++++++++++++++++++++++++++
 arch/mips/ralink/rt305x.c |    6 +--
 5 files changed, 107 insertions(+), 6 deletions(-)
 create mode 100644 arch/mips/ralink/pinmux.c

diff --git a/arch/mips/ralink/Makefile b/arch/mips/ralink/Makefile
index 939757f..39ef249 100644
--- a/arch/mips/ralink/Makefile
+++ b/arch/mips/ralink/Makefile
@@ -6,7 +6,7 @@
 # Copyright (C) 2009-2011 Gabor Juhos <juhosg@openwrt.org>
 # Copyright (C) 2013 John Crispin <blogic@openwrt.org>
 
-obj-y := prom.o of.o reset.o clk.o irq.o
+obj-y := prom.o of.o reset.o clk.o irq.o pinmux.o
 
 obj-$(CONFIG_SOC_RT305X) += rt305x.o
 
diff --git a/arch/mips/ralink/common.h b/arch/mips/ralink/common.h
index 3009903..193c76c 100644
--- a/arch/mips/ralink/common.h
+++ b/arch/mips/ralink/common.h
@@ -22,9 +22,13 @@ struct ralink_pinmux {
 	struct ralink_pinmux_grp *mode;
 	struct ralink_pinmux_grp *uart;
 	int uart_shift;
+	u32 uart_mask;
 	void (*wdt_reset)(void);
+	struct ralink_pinmux_grp *pci;
+	int pci_shift;
+	u32 pci_mask;
 };
-extern struct ralink_pinmux gpio_pinmux;
+extern struct ralink_pinmux rt_pinmux;
 
 struct ralink_soc_info {
 	unsigned char sys_type[RAMIPS_SYS_TYPE_LEN];
@@ -41,4 +45,6 @@ extern void prom_soc_init(struct ralink_soc_info *soc_info);
 
 __iomem void *plat_of_remap_node(const char *node);
 
+void ralink_pinmux(void);
+
 #endif /* _RALINK_COMMON_H__ */
diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
index 4165e70..ecf1482 100644
--- a/arch/mips/ralink/of.c
+++ b/arch/mips/ralink/of.c
@@ -101,6 +101,8 @@ static int __init plat_of_setup(void)
 	if (of_platform_populate(NULL, of_ids, NULL, NULL))
 		panic("failed to populate DT\n");
 
+	ralink_pinmux();
+
 	return 0;
 }
 
diff --git a/arch/mips/ralink/pinmux.c b/arch/mips/ralink/pinmux.c
new file mode 100644
index 0000000..c10df50
--- /dev/null
+++ b/arch/mips/ralink/pinmux.c
@@ -0,0 +1,95 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+
+#include <asm/mach-ralink/ralink_regs.h>
+
+#include "common.h"
+
+#define SYSC_REG_GPIO_MODE	0x60
+
+static u32 ralink_mux_mask(const char *name, struct ralink_pinmux_grp *grps)
+{
+	for (; grps->name; grps++)
+		if (!strcmp(grps->name, name))
+			return grps->mask;
+
+	return 0;
+}
+
+void ralink_pinmux(void)
+{
+	const __be32 *wdt;
+	struct device_node *np;
+	struct property *prop;
+	const char *uart, *pci, *pin;
+	u32 mode = 0;
+
+	np = of_find_compatible_node(NULL, NULL, "ralink,rt3050-sysc");
+	if (!np)
+		return;
+
+	of_property_for_each_string(np, "ralink,gpiomux", prop, pin) {
+		int m = ralink_mux_mask(pin, rt_pinmux.mode);
+		if (m) {
+			mode |= m;
+			pr_debug("pinmux: registered gpiomux \"%s\"\n", pin);
+		} else {
+			pr_err("pinmux: failed to load \"%s\"\n", pin);
+		}
+	}
+
+	of_property_for_each_string(np, "ralink,pinmux", prop, pin) {
+		int m = ralink_mux_mask(pin, rt_pinmux.mode);
+		if (m) {
+			mode &= ~m;
+			pr_debug("pinmux: registered pinmux \"%s\"\n", pin);
+		} else {
+			pr_err("pinmux: failed to load group \"%s\"\n", pin);
+		}
+	}
+
+	uart = NULL;
+	if (rt_pinmux.uart)
+		of_property_read_string(np, "ralink,uartmux", &uart);
+
+	if (uart) {
+		int m = ralink_mux_mask(uart, rt_pinmux.uart);
+
+		if (m) {
+			mode &= ~(rt_pinmux.uart_mask << rt_pinmux.uart_shift);
+			mode |= m << rt_pinmux.uart_shift;
+			pr_debug("pinmux: registered uartmux \"%s\"\n", uart);
+		} else {
+			pr_debug("pinmux: unknown uartmux \"%s\"\n", uart);
+		}
+	}
+
+	wdt = of_get_property(np, "ralink,wdtmux", NULL);
+	if (wdt && *wdt && rt_pinmux.wdt_reset)
+		rt_pinmux.wdt_reset();
+
+	pci = NULL;
+	if (rt_pinmux.pci)
+		of_property_read_string(np, "ralink,pcimux", &pci);
+
+	if (pci) {
+		int m = ralink_mux_mask(pci, rt_pinmux.pci);
+		mode &= ~(rt_pinmux.pci_mask << rt_pinmux.pci_shift);
+		if (m) {
+			mode |= (m << rt_pinmux.pci_shift);
+			pr_debug("pinmux: registered pcimux \"%s\"\n", pci);
+		} else {
+			pr_debug("pinmux: registered pcimux \"gpio\"\n");
+		}
+	}
+
+	rt_sysc_w32(mode, SYSC_REG_GPIO_MODE);
+}
diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
index 856ebff..d9ea53d 100644
--- a/arch/mips/ralink/rt305x.c
+++ b/arch/mips/ralink/rt305x.c
@@ -97,9 +97,6 @@ struct ralink_pinmux_grp uart_mux[] = {
 		.mask = RT305X_GPIO_MODE_GPIO_I2S,
 		.gpio_first = RT305X_GPIO_7,
 		.gpio_last = RT305X_GPIO_14,
-	}, {
-		.name = "gpio",
-		.mask = RT305X_GPIO_MODE_GPIO,
 	}, {0}
 };
 
@@ -114,10 +111,11 @@ void rt305x_wdt_reset(void)
 	rt_sysc_w32(t, SYSC_REG_SYSTEM_CONFIG);
 }
 
-struct ralink_pinmux gpio_pinmux = {
+struct ralink_pinmux rt_pinmux = {
 	.mode = mode_mux,
 	.uart = uart_mux,
 	.uart_shift = RT305X_GPIO_MODE_UART0_SHIFT,
+	.uart_mask = RT305X_GPIO_MODE_GPIO,
 	.wdt_reset = rt305x_wdt_reset,
 };
 
-- 
1.7.10.4
