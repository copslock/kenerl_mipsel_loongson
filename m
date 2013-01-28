Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2013 20:12:14 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:33221 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833264Ab3A1TJ1D5rW6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Jan 2013 20:09:27 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 883C4BF51AC;
        Mon, 28 Jan 2013 20:09:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JhJ6Q1AeJbka; Mon, 28 Jan 2013 20:09:25 +0100 (CET)
Received: from flexo.localdomain (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id B4548BF5198;
        Mon, 28 Jan 2013 20:09:25 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, jogo@openwrt.org, mbizon@freebox.fr,
        cenerkee@gmail.com, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        blogic@openwrt.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 09/13] MIPS: BCM63XX: add support for the on-chip EHCI controller
Date:   Mon, 28 Jan 2013 20:06:27 +0100
Message-Id: <1359399991-2236-10-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1359399991-2236-1-git-send-email-florian@openwrt.org>
References: <1359399991-2236-1-git-send-email-florian@openwrt.org>
X-archive-position: 35592
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

Broadcom BCM63XX SoCs include an on-chip EHCI controller which can be
driven by the generic ehci-platform driver by using specific power
on/off/suspend callbacks to manage clocks and hardware specific
configuration.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/Makefile                         |    2 +-
 arch/mips/bcm63xx/dev-usb-ehci.c                   |   92 ++++++++++++++++++++
 .../asm/mach-bcm63xx/bcm63xx_dev_usb_ehci.h        |    6 ++
 3 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/bcm63xx/dev-usb-ehci.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_usb_ehci.h

diff --git a/arch/mips/bcm63xx/Makefile b/arch/mips/bcm63xx/Makefile
index a2a501a..c3503ae 100644
--- a/arch/mips/bcm63xx/Makefile
+++ b/arch/mips/bcm63xx/Makefile
@@ -1,7 +1,7 @@
 obj-y		+= clk.o cpu.o cs.o gpio.o irq.o nvram.o prom.o reset.o \
 		   setup.o timer.o dev-dsp.o dev-enet.o dev-flash.o \
 		   dev-pcmcia.o dev-rng.o dev-spi.o dev-uart.o dev-wdt.o \
-		   dev-usb-ohci.o dev-usb-usbd.o usb-common.o
+		   dev-usb-ehci.o dev-usb-ohci.o dev-usb-usbd.o usb-common.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-y		+= boards/
diff --git a/arch/mips/bcm63xx/dev-usb-ehci.c b/arch/mips/bcm63xx/dev-usb-ehci.c
new file mode 100644
index 0000000..0ea7888
--- /dev/null
+++ b/arch/mips/bcm63xx/dev-usb-ehci.c
@@ -0,0 +1,92 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ * Copyright (C) 2013 Florian Fainelli <florian@openwrt.org>
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/usb/ehci_pdriver.h>
+#include <linux/dma-mapping.h>
+
+#include <bcm63xx_cpu.h>
+#include <bcm63xx_regs.h>
+#include <bcm63xx_io.h>
+#include <bcm63xx_usb_priv.h>
+#include <bcm63xx_dev_usb_ehci.h>
+
+static struct resource ehci_resources[] = {
+	{
+		.start		= -1, /* filled at runtime */
+		.end		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static u64 ehci_dmamask = DMA_BIT_MASK(32);
+
+static struct clk *usb_host_clock;
+
+static int bcm63xx_ehci_power_on(struct platform_device *pdev)
+{
+	usb_host_clock = clk_get(&pdev->dev, "usbh");
+	if (IS_ERR_OR_NULL(usb_host_clock))
+		return -ENODEV;
+
+	clk_prepare_enable(usb_host_clock);
+
+	bcm63xx_usb_priv_ehci_cfg_set();
+
+	return 0;
+}
+
+static void bcm63xx_ehci_power_off(struct platform_device *pdev)
+{
+	if (!IS_ERR_OR_NULL(usb_host_clock)) {
+		clk_disable_unprepare(usb_host_clock);
+		clk_put(usb_host_clock);
+	}
+}
+
+static struct usb_ehci_pdata bcm63xx_ehci_pdata = {
+	.big_endian_desc	= 1,
+	.big_endian_mmio	= 1,
+	.power_on		= bcm63xx_ehci_power_on,
+	.power_off		= bcm63xx_ehci_power_off,
+	.power_suspend		= bcm63xx_ehci_power_off,
+};
+
+static struct platform_device bcm63xx_ehci_device = {
+	.name		= "ehci-platform",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(ehci_resources),
+	.resource	= ehci_resources,
+	.dev		= {
+		.platform_data		= &bcm63xx_ehci_pdata,
+		.dma_mask		= &ehci_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+int __init bcm63xx_ehci_register(void)
+{
+	if (!BCMCPU_IS_6328() && !BCMCPU_IS_6358() && !BCMCPU_IS_6368())
+		return 0;
+
+	ehci_resources[0].start = bcm63xx_regset_address(RSET_EHCI0);
+	ehci_resources[0].end = ehci_resources[0].start;
+	ehci_resources[0].end += RSET_EHCI_SIZE - 1;
+	ehci_resources[1].start = bcm63xx_get_irq_number(IRQ_EHCI0);
+
+	return platform_device_register(&bcm63xx_ehci_device);
+}
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_usb_ehci.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_usb_ehci.h
new file mode 100644
index 0000000..17fb519
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_usb_ehci.h
@@ -0,0 +1,6 @@
+#ifndef BCM63XX_DEV_USB_EHCI_H_
+#define BCM63XX_DEV_USB_EHCI_H_
+
+int bcm63xx_ehci_register(void);
+
+#endif /* BCM63XX_DEV_USB_EHCI_H_ */
-- 
1.7.10.4
