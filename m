Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2010 18:35:38 +0100 (CET)
Received: from sakura.staff.proxad.net ([213.228.1.107]:53006 "EHLO
        sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492196Ab0A3RfK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2010 18:35:10 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id 26EE8551082; Sat, 30 Jan 2010 18:35:10 +0100 (CET)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 1/7] MIPS: bcm63xx: register integrated OHCI controller device.
Date:   Sat, 30 Jan 2010 18:34:52 +0100
Message-Id: <1264872898-28149-2-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1264872898-28149-1-git-send-email-mbizon@freebox.fr>
References: <1264872898-28149-1-git-send-email-mbizon@freebox.fr>
X-archive-position: 25758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19469

The bcm63xx SOC has an integrated OHCI controller, this patch adds
platform device registration and change board code to register ohci
device when necessary.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 arch/mips/bcm63xx/Kconfig                          |    6 ++
 arch/mips/bcm63xx/Makefile                         |    3 +-
 arch/mips/bcm63xx/boards/board_bcm963xx.c          |    4 ++
 arch/mips/bcm63xx/dev-usb-ohci.c                   |   49 ++++++++++++++++++++
 .../asm/mach-bcm63xx/bcm63xx_dev_usb_ohci.h        |    6 ++
 5 files changed, 67 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/bcm63xx/dev-usb-ohci.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_usb_ohci.h

diff --git a/arch/mips/bcm63xx/Kconfig b/arch/mips/bcm63xx/Kconfig
index fb177d6..76fbbf7 100644
--- a/arch/mips/bcm63xx/Kconfig
+++ b/arch/mips/bcm63xx/Kconfig
@@ -16,10 +16,16 @@ config BCM63XX_CPU_6345
 config BCM63XX_CPU_6348
 	bool "support 6348 CPU"
 	select HW_HAS_PCI
+	select USB_ARCH_HAS_OHCI
+	select USB_OHCI_BIG_ENDIAN_DESC
+	select USB_OHCI_BIG_ENDIAN_MMIO
 
 config BCM63XX_CPU_6358
 	bool "support 6358 CPU"
 	select HW_HAS_PCI
+	select USB_ARCH_HAS_OHCI
+	select USB_OHCI_BIG_ENDIAN_DESC
+	select USB_OHCI_BIG_ENDIAN_MMIO
 endmenu
 
 source "arch/mips/bcm63xx/boards/Kconfig"
diff --git a/arch/mips/bcm63xx/Makefile b/arch/mips/bcm63xx/Makefile
index 00064b6..be5d7ad 100644
--- a/arch/mips/bcm63xx/Makefile
+++ b/arch/mips/bcm63xx/Makefile
@@ -1,5 +1,6 @@
 obj-y		+= clk.o cpu.o cs.o gpio.o irq.o prom.o setup.o timer.o \
-		   dev-dsp.o dev-enet.o dev-pcmcia.o dev-uart.o dev-wdt.o
+		   dev-dsp.o dev-enet.o dev-pcmcia.o dev-uart.o dev-wdt.o \
+		   dev-usb-ohci.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-y		+= boards/
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index ea17941..e2c0c36 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -24,6 +24,7 @@
 #include <bcm63xx_dev_enet.h>
 #include <bcm63xx_dev_dsp.h>
 #include <bcm63xx_dev_pcmcia.h>
+#include <bcm63xx_dev_usb_ohci.h>
 #include <board_bcm963xx.h>
 
 #define PFX	"board_bcm963xx: "
@@ -803,6 +804,9 @@ int __init board_register_devices(void)
 	    !board_get_mac_address(board.enet1.mac_addr))
 		bcm63xx_enet_register(1, &board.enet1);
 
+	if (board.has_ohci0)
+		bcm63xx_ohci_register();
+
 	if (board.has_dsp)
 		bcm63xx_dsp_register(&board.dsp);
 
diff --git a/arch/mips/bcm63xx/dev-usb-ohci.c b/arch/mips/bcm63xx/dev-usb-ohci.c
new file mode 100644
index 0000000..f1fb442
--- /dev/null
+++ b/arch/mips/bcm63xx/dev-usb-ohci.c
@@ -0,0 +1,49 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2010 Maxime Bizon <mbizon@freebox.fr>
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <bcm63xx_cpu.h>
+#include <bcm63xx_dev_usb_ohci.h>
+
+static struct resource ohci_resources[] = {
+	{
+		/* start & end filled at runtime */
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		/* start filled at runtime */
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static u64 ohci_dmamask = ~(u32)0;
+
+static struct platform_device bcm63xx_ohci_device = {
+	.name		= "bcm63xx_ohci",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(ohci_resources),
+	.resource	= ohci_resources,
+	.dev		= {
+		.dma_mask		= &ohci_dmamask,
+		.coherent_dma_mask	= 0xffffffff,
+	},
+};
+
+int __init bcm63xx_ohci_register(void)
+{
+	if (!BCMCPU_IS_6348() && !BCMCPU_IS_6358())
+		return 0;
+
+	ohci_resources[0].start = bcm63xx_regset_address(RSET_OHCI0);
+	ohci_resources[0].end = ohci_resources[0].start;
+	ohci_resources[0].end += RSET_OHCI_SIZE - 1;
+	ohci_resources[1].start = bcm63xx_get_irq_number(IRQ_OHCI0);
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
1.6.3.3
