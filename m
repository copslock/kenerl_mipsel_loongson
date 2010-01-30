Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2010 18:36:03 +0100 (CET)
Received: from sakura.staff.proxad.net ([213.228.1.107]:53008 "EHLO
        sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492514Ab0A3RfL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2010 18:35:11 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id 973E8551082; Sat, 30 Jan 2010 18:35:11 +0100 (CET)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 2/7] MIPS: bcm63xx: register integrated EHCI controller device.
Date:   Sat, 30 Jan 2010 18:34:53 +0100
Message-Id: <1264872898-28149-3-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1264872898-28149-1-git-send-email-mbizon@freebox.fr>
References: <1264872898-28149-1-git-send-email-mbizon@freebox.fr>
X-archive-position: 25759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19470

The bcm63xx SOC has an integrated EHCI controller, this patch adds
platform device registration and change board code to register
EHCI device when necessary.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 arch/mips/bcm63xx/Kconfig                          |    2 +
 arch/mips/bcm63xx/Makefile                         |    2 +-
 arch/mips/bcm63xx/boards/board_bcm963xx.c          |    4 ++
 arch/mips/bcm63xx/dev-usb-ehci.c                   |   49 ++++++++++++++++++++
 .../asm/mach-bcm63xx/bcm63xx_dev_usb_ehci.h        |    6 ++
 5 files changed, 62 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/bcm63xx/dev-usb-ehci.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_usb_ehci.h

diff --git a/arch/mips/bcm63xx/Kconfig b/arch/mips/bcm63xx/Kconfig
index 76fbbf7..4aa21e8 100644
--- a/arch/mips/bcm63xx/Kconfig
+++ b/arch/mips/bcm63xx/Kconfig
@@ -26,6 +26,8 @@ config BCM63XX_CPU_6358
 	select USB_ARCH_HAS_OHCI
 	select USB_OHCI_BIG_ENDIAN_DESC
 	select USB_OHCI_BIG_ENDIAN_MMIO
+	select USB_ARCH_HAS_EHCI
+	select USB_EHCI_BIG_ENDIAN_MMIO
 endmenu
 
 source "arch/mips/bcm63xx/boards/Kconfig"
diff --git a/arch/mips/bcm63xx/Makefile b/arch/mips/bcm63xx/Makefile
index be5d7ad..6e229c2 100644
--- a/arch/mips/bcm63xx/Makefile
+++ b/arch/mips/bcm63xx/Makefile
@@ -1,6 +1,6 @@
 obj-y		+= clk.o cpu.o cs.o gpio.o irq.o prom.o setup.o timer.o \
 		   dev-dsp.o dev-enet.o dev-pcmcia.o dev-uart.o dev-wdt.o \
-		   dev-usb-ohci.o
+		   dev-usb-ohci.o dev-usb-ehci.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-y		+= boards/
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index e2c0c36..b0d3db3 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -25,6 +25,7 @@
 #include <bcm63xx_dev_dsp.h>
 #include <bcm63xx_dev_pcmcia.h>
 #include <bcm63xx_dev_usb_ohci.h>
+#include <bcm63xx_dev_usb_ehci.h>
 #include <board_bcm963xx.h>
 
 #define PFX	"board_bcm963xx: "
@@ -804,6 +805,9 @@ int __init board_register_devices(void)
 	    !board_get_mac_address(board.enet1.mac_addr))
 		bcm63xx_enet_register(1, &board.enet1);
 
+	if (board.has_ehci0)
+		bcm63xx_ehci_register();
+
 	if (board.has_ohci0)
 		bcm63xx_ohci_register();
 
diff --git a/arch/mips/bcm63xx/dev-usb-ehci.c b/arch/mips/bcm63xx/dev-usb-ehci.c
new file mode 100644
index 0000000..4bdd675
--- /dev/null
+++ b/arch/mips/bcm63xx/dev-usb-ehci.c
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
+#include <bcm63xx_dev_usb_ehci.h>
+
+static struct resource ehci_resources[] = {
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
+static u64 ehci_dmamask = ~(u32)0;
+
+static struct platform_device bcm63xx_ehci_device = {
+	.name		= "bcm63xx_ehci",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(ehci_resources),
+	.resource	= ehci_resources,
+	.dev		= {
+		.dma_mask		= &ehci_dmamask,
+		.coherent_dma_mask	= 0xffffffff,
+	},
+};
+
+int __init bcm63xx_ehci_register(void)
+{
+	if (!BCMCPU_IS_6358())
+		return 0;
+
+	ehci_resources[0].start = bcm63xx_regset_address(RSET_EHCI0);
+	ehci_resources[0].end = ehci_resources[0].start;
+	ehci_resources[0].end += RSET_EHCI_SIZE - 1;
+	ehci_resources[1].start = bcm63xx_get_irq_number(IRQ_EHCI0);
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
1.6.3.3
