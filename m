Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jun 2012 07:26:44 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:53322 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903696Ab2FWFYC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Jun 2012 07:24:02 +0200
Received: (qmail 25649 invoked from network); 23 Jun 2012 05:23:59 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 23 Jun 2012 05:23:59 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Fri, 22 Jun 2012 22:23:59 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     <ffainelli@freebox.fr>, <mbizon@freebox.fr>,
        <jonas.gorski@gmail.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 7/7] MIPS: BCM63XX: Create platform_device for USBD
Date:   Fri, 22 Jun 2012 22:14:57 -0700
Message-Id: <e2aacdca2b2e2f5b7ee20563032bf1ee@localhost>
In-Reply-To: <0f67eabbb0d5c59add27e42a08b94944@localhost>
References: <0f67eabbb0d5c59add27e42a08b94944@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 33796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/bcm63xx/Makefile                         |  2 +-
 arch/mips/bcm63xx/boards/board_bcm963xx.c          | 10 +++
 arch/mips/bcm63xx/dev-usb-usbd.c                   | 72 ++++++++++++++++++++++
 .../asm/mach-bcm63xx/bcm63xx_dev_usb_usbd.h        | 17 +++++
 .../mips/include/asm/mach-bcm63xx/board_bcm963xx.h |  5 ++
 5 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/bcm63xx/dev-usb-usbd.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_usb_usbd.h

diff --git a/arch/mips/bcm63xx/Makefile b/arch/mips/bcm63xx/Makefile
index 833af72..9bbb30a 100644
--- a/arch/mips/bcm63xx/Makefile
+++ b/arch/mips/bcm63xx/Makefile
@@ -1,6 +1,6 @@
 obj-y		+= clk.o cpu.o cs.o gpio.o irq.o prom.o setup.o timer.o \
 		   dev-dsp.o dev-enet.o dev-flash.o dev-pcmcia.o dev-rng.o \
-		   dev-spi.o dev-uart.o dev-wdt.o
+		   dev-spi.o dev-uart.o dev-wdt.o dev-usb-usbd.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-y		+= boards/
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index feb0525..ea4ea77 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -24,6 +24,7 @@
 #include <bcm63xx_dev_flash.h>
 #include <bcm63xx_dev_pcmcia.h>
 #include <bcm63xx_dev_spi.h>
+#include <bcm63xx_dev_usb_usbd.h>
 #include <board_bcm963xx.h>
 
 #define PFX	"board_bcm963xx: "
@@ -42,6 +43,12 @@ static struct board_info __initdata board_96328avng = {
 
 	.has_uart0			= 1,
 	.has_pci			= 1,
+	.has_usbd			= 0,
+
+	.usbd = {
+		.use_fullspeed		= 0,
+		.port_no		= 0,
+	},
 
 	.leds = {
 		{
@@ -888,6 +895,9 @@ int __init board_register_devices(void)
 	    !board_get_mac_address(board.enet1.mac_addr))
 		bcm63xx_enet_register(1, &board.enet1);
 
+	if (board.has_usbd)
+		bcm63xx_usbd_register(&board.usbd);
+
 	if (board.has_dsp)
 		bcm63xx_dsp_register(&board.dsp);
 
diff --git a/arch/mips/bcm63xx/dev-usb-usbd.c b/arch/mips/bcm63xx/dev-usb-usbd.c
new file mode 100644
index 0000000..5aeae2b
--- /dev/null
+++ b/arch/mips/bcm63xx/dev-usb-usbd.c
@@ -0,0 +1,72 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ * Copyright (C) 2012 Kevin Cernekee <cernekee@gmail.com>
+ * Copyright (C) 2012 Broadcom Corporation
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <bcm63xx_cpu.h>
+#include <bcm63xx_dev_usb_usbd.h>
+
+static struct resource usbd_resources[] = {
+	{
+		.start		= -1, /* filled at runtime */
+		.end		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= -1, /* filled at runtime */
+		.end		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_IRQ,
+	},
+	{
+		.start		= -1, /* filled at runtime */
+		.end		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static u64 usbd_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device bcm63xx_usbd_device = {
+	.name		= "bcm63xx_udc",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(usbd_resources),
+	.resource	= usbd_resources,
+	.dev		= {
+		.dma_mask		= &usbd_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+int __init bcm63xx_usbd_register(const struct bcm63xx_usbd_platform_data *pd)
+{
+	if (!BCMCPU_IS_6328() && !BCMCPU_IS_6368())
+		return 0;
+
+	usbd_resources[0].start = bcm63xx_regset_address(RSET_USBD);
+	usbd_resources[0].end = usbd_resources[0].start + RSET_USBD_SIZE - 1;
+
+	usbd_resources[1].start = bcm63xx_regset_address(RSET_USBDMA);
+	usbd_resources[1].end = usbd_resources[1].start + RSET_USBDMA_SIZE - 1;
+
+	usbd_resources[2].start = bcm63xx_get_irq_number(IRQ_USBD);
+
+	usbd_resources[3].start = bcm63xx_get_irq_number(IRQ_USBDMA_RXDMA0);
+	usbd_resources[3].end = bcm63xx_get_irq_number(IRQ_USBDMA_TXDMA5);
+
+	platform_device_add_data(&bcm63xx_usbd_device, pd, sizeof(*pd));
+
+	return platform_device_register(&bcm63xx_usbd_device);
+}
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_usb_usbd.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_usb_usbd.h
new file mode 100644
index 0000000..5d6d698
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_usb_usbd.h
@@ -0,0 +1,17 @@
+#ifndef BCM63XX_DEV_USB_USBD_H_
+#define BCM63XX_DEV_USB_USBD_H_
+
+/*
+ * usb device platform data
+ */
+struct bcm63xx_usbd_platform_data {
+	/* board can only support full speed (USB 1.1) */
+	int use_fullspeed;
+
+	/* 0-based port index, for chips with >1 USB PHY */
+	int port_no;
+};
+
+int bcm63xx_usbd_register(const struct bcm63xx_usbd_platform_data *pd);
+
+#endif /* BCM63XX_DEV_USB_USBD_H_ */
diff --git a/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h b/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
index 474daaa..b0dd4bb 100644
--- a/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
+++ b/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
@@ -5,6 +5,7 @@
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <bcm63xx_dev_enet.h>
+#include <bcm63xx_dev_usb_usbd.h>
 #include <bcm63xx_dev_dsp.h>
 
 /*
@@ -44,6 +45,7 @@ struct board_info {
 	unsigned int	has_pccard:1;
 	unsigned int	has_ohci0:1;
 	unsigned int	has_ehci0:1;
+	unsigned int	has_usbd:1;
 	unsigned int	has_dsp:1;
 	unsigned int	has_uart0:1;
 	unsigned int	has_uart1:1;
@@ -52,6 +54,9 @@ struct board_info {
 	struct bcm63xx_enet_platform_data enet0;
 	struct bcm63xx_enet_platform_data enet1;
 
+	/* USB config */
+	struct bcm63xx_usbd_platform_data usbd;
+
 	/* DSP config */
 	struct bcm63xx_dsp_platform_data dsp;
 
-- 
1.7.11.1
