Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2013 20:11:20 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:33218 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833261Ab3A1TJ06Qr2K (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Jan 2013 20:09:26 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 5D3CABF56A6;
        Mon, 28 Jan 2013 20:09:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U-MJzldG-0lo; Mon, 28 Jan 2013 20:09:25 +0100 (CET)
Received: from flexo.localdomain (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 917EBBF5194;
        Mon, 28 Jan 2013 20:09:25 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, jogo@openwrt.org, mbizon@freebox.fr,
        cenerkee@gmail.com, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        blogic@openwrt.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 06/13] MIPS: BCM63XX: add support for the on-chip OHCI controller
Date:   Mon, 28 Jan 2013 20:06:24 +0100
Message-Id: <1359399991-2236-7-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1359399991-2236-1-git-send-email-florian@openwrt.org>
References: <1359399991-2236-1-git-send-email-florian@openwrt.org>
X-archive-position: 35589
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

Broadcom BCM63XX SoCs include an on-chip OHCI controller which can be
driven by the ohci-platform generic driver by using specific power
on/off/suspend callback to manage clocks and hardware specific
configuration.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/Makefile                         |    2 +-
 arch/mips/bcm63xx/dev-usb-ohci.c                   |   94 ++++++++++++++++++++
 .../asm/mach-bcm63xx/bcm63xx_dev_usb_ohci.h        |    6 ++
 3 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/bcm63xx/dev-usb-ohci.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_usb_ohci.h

diff --git a/arch/mips/bcm63xx/Makefile b/arch/mips/bcm63xx/Makefile
index a085c2b..a2a501a 100644
--- a/arch/mips/bcm63xx/Makefile
+++ b/arch/mips/bcm63xx/Makefile
@@ -1,7 +1,7 @@
 obj-y		+= clk.o cpu.o cs.o gpio.o irq.o nvram.o prom.o reset.o \
 		   setup.o timer.o dev-dsp.o dev-enet.o dev-flash.o \
 		   dev-pcmcia.o dev-rng.o dev-spi.o dev-uart.o dev-wdt.o \
-		   dev-usb-usbd.o usb-common.o
+		   dev-usb-ohci.o dev-usb-usbd.o usb-common.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-y		+= boards/
diff --git a/arch/mips/bcm63xx/dev-usb-ohci.c b/arch/mips/bcm63xx/dev-usb-ohci.c
new file mode 100644
index 0000000..b33e397
--- /dev/null
+++ b/arch/mips/bcm63xx/dev-usb-ohci.c
@@ -0,0 +1,94 @@
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
+#include <linux/usb/ohci_pdriver.h>
+#include <linux/dma-mapping.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+
+#include <bcm63xx_cpu.h>
+#include <bcm63xx_regs.h>
+#include <bcm63xx_io.h>
+#include <bcm63xx_usb_priv.h>
+#include <bcm63xx_dev_usb_ohci.h>
+
+static struct resource ohci_resources[] = {
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
+static u64 ohci_dmamask = DMA_BIT_MASK(32);
+
+static struct clk *usb_host_clock;
+
+static int bcm63xx_ohci_power_on(struct platform_device *pdev)
+{
+	usb_host_clock = clk_get(&pdev->dev, "usbh");
+	if (IS_ERR_OR_NULL(usb_host_clock))
+		return -ENODEV;
+
+	clk_prepare_enable(usb_host_clock);
+
+	bcm63xx_usb_priv_ohci_cfg_set();
+
+	return 0;
+}
+
+static void bcm63xx_ohci_power_off(struct platform_device *pdev)
+{
+	if (!IS_ERR_OR_NULL(usb_host_clock)) {
+		clk_disable_unprepare(usb_host_clock);
+		clk_put(usb_host_clock);
+	}
+}
+
+static struct usb_ohci_pdata bcm63xx_ohci_pdata = {
+	.big_endian_desc	= 1,
+	.big_endian_mmio	= 1,
+	.no_big_frame_no	= 1,
+	.num_ports		= 1,
+	.power_on		= bcm63xx_ohci_power_on,
+	.power_off		= bcm63xx_ohci_power_off,
+	.power_suspend		= bcm63xx_ohci_power_off,
+};
+
+static struct platform_device bcm63xx_ohci_device = {
+	.name		= "ohci-platform",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(ohci_resources),
+	.resource	= ohci_resources,
+	.dev		= {
+		.platform_data		= &bcm63xx_ohci_pdata,
+		.dma_mask		= &ohci_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+int __init bcm63xx_ohci_register(void)
+{
+	if (BCMCPU_IS_6345() || BCMCPU_IS_6338())
+		return -ENODEV;
+
+	ohci_resources[0].start = bcm63xx_regset_address(RSET_OHCI0);
+	ohci_resources[0].end = ohci_resources[0].start;
+	ohci_resources[0].end += RSET_OHCI_SIZE - 1;
+	ohci_resources[1].start = bcm63xx_get_irq_number(IRQ_OHCI0);
+
+	return platform_device_register(&bcm63xx_ohci_device);
+}
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_usb_ohci.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_usb_ohci.h
new file mode 100644
index 0000000..518a04d
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_usb_ohci.h
@@ -0,0 +1,6 @@
+#ifndef BCM63XX_DEV_USB_OHCI_H_
+#define BCM63XX_DEV_USB_OHCI_H_
+
+int bcm63xx_ohci_register(void);
+
+#endif /* BCM63XX_DEV_USB_OHCI_H_ */
-- 
1.7.10.4
