Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Mar 2009 10:28:09 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:31370 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20032723AbZC2J1D (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 29 Mar 2009 10:27:03 +0100
Received: (qmail 22286 invoked from network); 29 Mar 2009 11:26:14 +0200
Received: from flagship.roarinelk.net (HELO localhost.localdomain) (192.168.0.197)
  by 192.168.0.1 with SMTP; 29 Mar 2009 11:26:14 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 1/3] Alchemy: get rid of common/platform.c
Date:	Sun, 29 Mar 2009 11:27:00 +0200
Message-Id: <1238318822-4772-2-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1238318822-4772-1-git-send-email-mano@roarinelk.homelinux.net>
References: <1238318822-4772-1-git-send-email-mano@roarinelk.homelinux.net>
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Move device registration out of common/platform.c into the individual
boards' platform.c files.

Every board should register the devices it wants to use (i.e. on one
of my Au1200 systems UART1 is unused [pinmux problems] and its
functionality is provided by an external device.  This also results
in a completely useless ttyS1 entry; I want this entry gone without
having to add a lot more #ifdef <platform> lines to common/platform.c).

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/common/Makefile             |    4 +-
 arch/mips/alchemy/common/platform.c           |  369 -------------------------
 arch/mips/alchemy/devboards/db1x00/Makefile   |    2 +-
 arch/mips/alchemy/devboards/db1x00/platform.c |  165 +++++++++++
 arch/mips/alchemy/devboards/pb1000/Makefile   |    2 +-
 arch/mips/alchemy/devboards/pb1000/platform.c |   90 ++++++
 arch/mips/alchemy/devboards/pb1100/Makefile   |    2 +-
 arch/mips/alchemy/devboards/pb1100/platform.c |  116 ++++++++
 arch/mips/alchemy/devboards/pb1200/platform.c |  190 +++++++++++++-
 arch/mips/alchemy/devboards/pb1500/Makefile   |    2 +-
 arch/mips/alchemy/devboards/pb1500/platform.c |   88 ++++++
 arch/mips/alchemy/devboards/pb1550/Makefile   |    2 +-
 arch/mips/alchemy/devboards/pb1550/platform.c |  106 +++++++
 arch/mips/alchemy/mtx-1/platform.c            |   64 +++++
 arch/mips/alchemy/xxs1500/Makefile            |    3 +-
 arch/mips/alchemy/xxs1500/platform.c          |   87 ++++++
 16 files changed, 914 insertions(+), 378 deletions(-)
 delete mode 100644 arch/mips/alchemy/common/platform.c
 create mode 100644 arch/mips/alchemy/devboards/db1x00/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1000/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1100/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1500/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1550/platform.c
 create mode 100644 arch/mips/alchemy/xxs1500/platform.c

diff --git a/arch/mips/alchemy/common/Makefile b/arch/mips/alchemy/common/Makefile
index d50d476..962612c 100644
--- a/arch/mips/alchemy/common/Makefile
+++ b/arch/mips/alchemy/common/Makefile
@@ -6,8 +6,8 @@
 #
 
 obj-y += prom.o irq.o puts.o time.o reset.o \
-	clocks.o platform.o power.o setup.o \
-	sleeper.o dma.o dbdma.o gpio.o
+	clocks.o power.o setup.o sleeper.o \
+	dma.o dbdma.o gpio.o
 
 obj-$(CONFIG_PCI)		+= pci.o
 
diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
deleted file mode 100644
index 5c76c64..0000000
--- a/arch/mips/alchemy/common/platform.c
+++ /dev/null
@@ -1,369 +0,0 @@
-/*
- * Platform device support for Au1x00 SoCs.
- *
- * Copyright 2004, Matt Porter <mporter@kernel.crashing.org>
- *
- * (C) Copyright Embedded Alley Solutions, Inc 2005
- * Author: Pantelis Antoniou <pantelis@embeddedalley.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/dma-mapping.h>
-#include <linux/platform_device.h>
-#include <linux/serial_8250.h>
-#include <linux/init.h>
-
-#include <asm/mach-au1x00/au1xxx.h>
-#include <asm/mach-au1x00/au1xxx_dbdma.h>
-#include <asm/mach-au1x00/au1100_mmc.h>
-
-#define PORT(_base, _irq)				\
-	{						\
-		.iobase		= _base,		\
-		.membase	= (void __iomem *)_base,\
-		.mapbase	= CPHYSADDR(_base),	\
-		.irq		= _irq,			\
-		.regshift	= 2,			\
-		.iotype		= UPIO_AU,		\
-		.flags		= UPF_SKIP_TEST 	\
-	}
-
-static struct plat_serial8250_port au1x00_uart_data[] = {
-#if defined(CONFIG_SERIAL_8250_AU1X00)
-#if defined(CONFIG_SOC_AU1000)
-	PORT(UART0_ADDR, AU1000_UART0_INT),
-	PORT(UART1_ADDR, AU1000_UART1_INT),
-	PORT(UART2_ADDR, AU1000_UART2_INT),
-	PORT(UART3_ADDR, AU1000_UART3_INT),
-#elif defined(CONFIG_SOC_AU1500)
-	PORT(UART0_ADDR, AU1500_UART0_INT),
-	PORT(UART3_ADDR, AU1500_UART3_INT),
-#elif defined(CONFIG_SOC_AU1100)
-	PORT(UART0_ADDR, AU1100_UART0_INT),
-	PORT(UART1_ADDR, AU1100_UART1_INT),
-	PORT(UART3_ADDR, AU1100_UART3_INT),
-#elif defined(CONFIG_SOC_AU1550)
-	PORT(UART0_ADDR, AU1550_UART0_INT),
-	PORT(UART1_ADDR, AU1550_UART1_INT),
-	PORT(UART3_ADDR, AU1550_UART3_INT),
-#elif defined(CONFIG_SOC_AU1200)
-	PORT(UART0_ADDR, AU1200_UART0_INT),
-	PORT(UART1_ADDR, AU1200_UART1_INT),
-#endif
-#endif	/* CONFIG_SERIAL_8250_AU1X00 */
-	{ },
-};
-
-static struct platform_device au1xx0_uart_device = {
-	.name			= "serial8250",
-	.id			= PLAT8250_DEV_AU1X00,
-	.dev			= {
-		.platform_data	= au1x00_uart_data,
-	},
-};
-
-/* OHCI (USB full speed host controller) */
-static struct resource au1xxx_usb_ohci_resources[] = {
-	[0] = {
-		.start		= USB_OHCI_BASE,
-		.end		= USB_OHCI_BASE + USB_OHCI_LEN - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= AU1000_USB_HOST_INT,
-		.end		= AU1000_USB_HOST_INT,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-/* The dmamask must be set for OHCI to work */
-static u64 ohci_dmamask = DMA_32BIT_MASK;
-
-static struct platform_device au1xxx_usb_ohci_device = {
-	.name		= "au1xxx-ohci",
-	.id		= 0,
-	.dev = {
-		.dma_mask		= &ohci_dmamask,
-		.coherent_dma_mask	= DMA_32BIT_MASK,
-	},
-	.num_resources	= ARRAY_SIZE(au1xxx_usb_ohci_resources),
-	.resource	= au1xxx_usb_ohci_resources,
-};
-
-/*** AU1100 LCD controller ***/
-
-#ifdef CONFIG_FB_AU1100
-static struct resource au1100_lcd_resources[] = {
-	[0] = {
-		.start          = LCD_PHYS_ADDR,
-		.end            = LCD_PHYS_ADDR + 0x800 - 1,
-		.flags          = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start          = AU1100_LCD_INT,
-		.end            = AU1100_LCD_INT,
-		.flags          = IORESOURCE_IRQ,
-	}
-};
-
-static u64 au1100_lcd_dmamask = DMA_32BIT_MASK;
-
-static struct platform_device au1100_lcd_device = {
-	.name           = "au1100-lcd",
-	.id             = 0,
-	.dev = {
-		.dma_mask               = &au1100_lcd_dmamask,
-		.coherent_dma_mask      = DMA_32BIT_MASK,
-	},
-	.num_resources  = ARRAY_SIZE(au1100_lcd_resources),
-	.resource       = au1100_lcd_resources,
-};
-#endif
-
-#ifdef CONFIG_SOC_AU1200
-/* EHCI (USB high speed host controller) */
-static struct resource au1xxx_usb_ehci_resources[] = {
-	[0] = {
-		.start		= USB_EHCI_BASE,
-		.end		= USB_EHCI_BASE + USB_EHCI_LEN - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= AU1000_USB_HOST_INT,
-		.end		= AU1000_USB_HOST_INT,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static u64 ehci_dmamask = DMA_32BIT_MASK;
-
-static struct platform_device au1xxx_usb_ehci_device = {
-	.name		= "au1xxx-ehci",
-	.id		= 0,
-	.dev = {
-		.dma_mask		= &ehci_dmamask,
-		.coherent_dma_mask	= DMA_32BIT_MASK,
-	},
-	.num_resources	= ARRAY_SIZE(au1xxx_usb_ehci_resources),
-	.resource	= au1xxx_usb_ehci_resources,
-};
-
-/* Au1200 UDC (USB gadget controller) */
-static struct resource au1xxx_usb_gdt_resources[] = {
-	[0] = {
-		.start		= USB_UDC_BASE,
-		.end		= USB_UDC_BASE + USB_UDC_LEN - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= AU1200_USB_INT,
-		.end		= AU1200_USB_INT,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static u64 udc_dmamask = DMA_32BIT_MASK;
-
-static struct platform_device au1xxx_usb_gdt_device = {
-	.name		= "au1xxx-udc",
-	.id		= 0,
-	.dev = {
-		.dma_mask		= &udc_dmamask,
-		.coherent_dma_mask	= DMA_32BIT_MASK,
-	},
-	.num_resources	= ARRAY_SIZE(au1xxx_usb_gdt_resources),
-	.resource	= au1xxx_usb_gdt_resources,
-};
-
-/* Au1200 UOC (USB OTG controller) */
-static struct resource au1xxx_usb_otg_resources[] = {
-	[0] = {
-		.start		= USB_UOC_BASE,
-		.end		= USB_UOC_BASE + USB_UOC_LEN - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= AU1200_USB_INT,
-		.end		= AU1200_USB_INT,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static u64 uoc_dmamask = DMA_32BIT_MASK;
-
-static struct platform_device au1xxx_usb_otg_device = {
-	.name		= "au1xxx-uoc",
-	.id		= 0,
-	.dev = {
-		.dma_mask		= &uoc_dmamask,
-		.coherent_dma_mask	= DMA_32BIT_MASK,
-	},
-	.num_resources	= ARRAY_SIZE(au1xxx_usb_otg_resources),
-	.resource	= au1xxx_usb_otg_resources,
-};
-
-static struct resource au1200_lcd_resources[] = {
-	[0] = {
-		.start          = LCD_PHYS_ADDR,
-		.end            = LCD_PHYS_ADDR + 0x800 - 1,
-		.flags          = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start          = AU1200_LCD_INT,
-		.end            = AU1200_LCD_INT,
-		.flags          = IORESOURCE_IRQ,
-	}
-};
-
-static u64 au1200_lcd_dmamask = DMA_32BIT_MASK;
-
-static struct platform_device au1200_lcd_device = {
-	.name           = "au1200-lcd",
-	.id             = 0,
-	.dev = {
-		.dma_mask               = &au1200_lcd_dmamask,
-		.coherent_dma_mask      = DMA_32BIT_MASK,
-	},
-	.num_resources  = ARRAY_SIZE(au1200_lcd_resources),
-	.resource       = au1200_lcd_resources,
-};
-
-static u64 au1xxx_mmc_dmamask =  DMA_32BIT_MASK;
-
-extern struct au1xmmc_platform_data au1xmmc_platdata[2];
-
-static struct resource au1200_mmc0_resources[] = {
-	[0] = {
-		.start          = SD0_PHYS_ADDR,
-		.end            = SD0_PHYS_ADDR + 0x7ffff,
-		.flags          = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= AU1200_SD_INT,
-		.end		= AU1200_SD_INT,
-		.flags		= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start		= DSCR_CMD0_SDMS_TX0,
-		.end		= DSCR_CMD0_SDMS_TX0,
-		.flags		= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start          = DSCR_CMD0_SDMS_RX0,
-		.end		= DSCR_CMD0_SDMS_RX0,
-		.flags          = IORESOURCE_DMA,
-	}
-};
-
-static struct platform_device au1200_mmc0_device = {
-	.name = "au1xxx-mmc",
-	.id = 0,
-	.dev = {
-		.dma_mask		= &au1xxx_mmc_dmamask,
-		.coherent_dma_mask	= DMA_32BIT_MASK,
-		.platform_data		= &au1xmmc_platdata[0],
-	},
-	.num_resources	= ARRAY_SIZE(au1200_mmc0_resources),
-	.resource	= au1200_mmc0_resources,
-};
-
-#ifndef CONFIG_MIPS_DB1200
-static struct resource au1200_mmc1_resources[] = {
-	[0] = {
-		.start          = SD1_PHYS_ADDR,
-		.end            = SD1_PHYS_ADDR + 0x7ffff,
-		.flags          = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= AU1200_SD_INT,
-		.end		= AU1200_SD_INT,
-		.flags		= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start		= DSCR_CMD0_SDMS_TX1,
-		.end		= DSCR_CMD0_SDMS_TX1,
-		.flags		= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start          = DSCR_CMD0_SDMS_RX1,
-		.end		= DSCR_CMD0_SDMS_RX1,
-		.flags          = IORESOURCE_DMA,
-	}
-};
-
-static struct platform_device au1200_mmc1_device = {
-	.name = "au1xxx-mmc",
-	.id = 1,
-	.dev = {
-		.dma_mask		= &au1xxx_mmc_dmamask,
-		.coherent_dma_mask	= DMA_32BIT_MASK,
-		.platform_data		= &au1xmmc_platdata[1],
-	},
-	.num_resources	= ARRAY_SIZE(au1200_mmc1_resources),
-	.resource	= au1200_mmc1_resources,
-};
-#endif /* #ifndef CONFIG_MIPS_DB1200 */
-#endif /* #ifdef CONFIG_SOC_AU1200 */
-
-static struct platform_device au1x00_pcmcia_device = {
-	.name 		= "au1x00-pcmcia",
-	.id 		= 0,
-};
-
-/* All Alchemy demoboards with I2C have this #define in their headers */
-#ifdef SMBUS_PSC_BASE
-static struct resource pbdb_smbus_resources[] = {
-	{
-		.start	= CPHYSADDR(SMBUS_PSC_BASE),
-		.end	= CPHYSADDR(SMBUS_PSC_BASE + 0xfffff),
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device pbdb_smbus_device = {
-	.name		= "au1xpsc_smbus",
-	.id		= 0,	/* bus number */
-	.num_resources	= ARRAY_SIZE(pbdb_smbus_resources),
-	.resource	= pbdb_smbus_resources,
-};
-#endif
-
-static struct platform_device *au1xxx_platform_devices[] __initdata = {
-	&au1xx0_uart_device,
-	&au1xxx_usb_ohci_device,
-	&au1x00_pcmcia_device,
-#ifdef CONFIG_FB_AU1100
-	&au1100_lcd_device,
-#endif
-#ifdef CONFIG_SOC_AU1200
-	&au1xxx_usb_ehci_device,
-	&au1xxx_usb_gdt_device,
-	&au1xxx_usb_otg_device,
-	&au1200_lcd_device,
-	&au1200_mmc0_device,
-#ifndef CONFIG_MIPS_DB1200
-	&au1200_mmc1_device,
-#endif
-#endif
-#ifdef SMBUS_PSC_BASE
-	&pbdb_smbus_device,
-#endif
-};
-
-static int __init au1xxx_platform_init(void)
-{
-	unsigned int uartclk = get_au1x00_uart_baud_base() * 16;
-	int i;
-
-	/* Fill up uartclk. */
-	for (i = 0; au1x00_uart_data[i].flags; i++)
-		au1x00_uart_data[i].uartclk = uartclk;
-
-	return platform_add_devices(au1xxx_platform_devices,
-				    ARRAY_SIZE(au1xxx_platform_devices));
-}
-
-arch_initcall(au1xxx_platform_init);
diff --git a/arch/mips/alchemy/devboards/db1x00/Makefile b/arch/mips/alchemy/devboards/db1x00/Makefile
index 432241a..532a214 100644
--- a/arch/mips/alchemy/devboards/db1x00/Makefile
+++ b/arch/mips/alchemy/devboards/db1x00/Makefile
@@ -5,4 +5,4 @@
 # Makefile for the Alchemy Semiconductor DBAu1xx0 boards.
 #
 
-obj-y := board_setup.o irqmap.o
+obj-y := board_setup.o irqmap.o platform.o
diff --git a/arch/mips/alchemy/devboards/db1x00/platform.c b/arch/mips/alchemy/devboards/db1x00/platform.c
new file mode 100644
index 0000000..49d6e5c
--- /dev/null
+++ b/arch/mips/alchemy/devboards/db1x00/platform.c
@@ -0,0 +1,165 @@
+/*
+ * Platform device support for Au1x00 SoCs.
+ *
+ * Copyright 2004, Matt Porter <mporter@kernel.crashing.org>
+ *
+ * (C) Copyright Embedded Alley Solutions, Inc 2005
+ * Author: Pantelis Antoniou <pantelis@embeddedalley.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+#include <linux/serial_8250.h>
+#include <linux/init.h>
+
+#include <asm/mach-au1x00/au1xxx.h>
+
+#define PORT(_base, _irq)					\
+	{							\
+		.iobase		= _base,			\
+		.mapbase	= _base,			\
+		.irq		= _irq,				\
+		.regshift	= 2,				\
+		.iotype		= UPIO_AU,			\
+		.flags		= UPF_SKIP_TEST | UPF_IOREMAP	\
+	}
+
+static struct plat_serial8250_port au1x00_uart_data[] = {
+#if defined(CONFIG_SOC_AU1000)
+	PORT(UART0_PHYS_ADDR, AU1000_UART0_INT),
+	PORT(UART1_PHYS_ADDR, AU1000_UART1_INT),
+	PORT(UART2_PHYS_ADDR, AU1000_UART2_INT),
+	PORT(UART3_PHYS_ADDR, AU1000_UART3_INT),
+#elif defined(CONFIG_SOC_AU1500)
+	PORT(UART0_PHYS_ADDR, AU1500_UART0_INT),
+	PORT(UART3_PHYS_ADDR, AU1500_UART3_INT),
+#elif defined(CONFIG_SOC_AU1100)
+	PORT(UART0_PHYS_ADDR, AU1100_UART0_INT),
+	PORT(UART1_PHYS_ADDR, AU1100_UART1_INT),
+	PORT(UART3_PHYS_ADDR, AU1100_UART3_INT),
+#elif defined(CONFIG_SOC_AU1550)
+	PORT(UART0_PHYS_ADDR, AU1550_UART0_INT),
+	PORT(UART1_PHYS_ADDR, AU1550_UART1_INT),
+	PORT(UART3_PHYS_ADDR, AU1550_UART3_INT),
+#endif
+	{ },
+};
+
+static struct platform_device au1xx0_uart_device = {
+	.name			= "serial8250",
+	.id			= PLAT8250_DEV_AU1X00,
+	.dev			= {
+		.platform_data	= au1x00_uart_data,
+	},
+};
+
+/* OHCI (USB full speed host controller) */
+static struct resource au1xxx_usb_ohci_resources[] = {
+	[0] = {
+		.start		= USB_OHCI_BASE,
+		.end		= USB_OHCI_BASE + USB_OHCI_LEN - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= AU1000_USB_HOST_INT,
+		.end		= AU1000_USB_HOST_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+/* The dmamask must be set for OHCI to work */
+static u64 ohci_dmamask = DMA_32BIT_MASK;
+
+static struct platform_device au1xxx_usb_ohci_device = {
+	.name		= "au1xxx-ohci",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &ohci_dmamask,
+		.coherent_dma_mask	= DMA_32BIT_MASK,
+	},
+	.num_resources	= ARRAY_SIZE(au1xxx_usb_ohci_resources),
+	.resource	= au1xxx_usb_ohci_resources,
+};
+
+/*** AU1100 LCD controller ***/
+
+#ifdef CONFIG_FB_AU1100
+static struct resource au1100_lcd_resources[] = {
+	[0] = {
+		.start          = LCD_PHYS_ADDR,
+		.end            = LCD_PHYS_ADDR + 0x800 - 1,
+		.flags          = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start          = AU1100_LCD_INT,
+		.end            = AU1100_LCD_INT,
+		.flags          = IORESOURCE_IRQ,
+	}
+};
+
+static u64 au1100_lcd_dmamask = DMA_32BIT_MASK;
+
+static struct platform_device au1100_lcd_device = {
+	.name           = "au1100-lcd",
+	.id             = 0,
+	.dev = {
+		.dma_mask               = &au1100_lcd_dmamask,
+		.coherent_dma_mask      = DMA_32BIT_MASK,
+	},
+	.num_resources  = ARRAY_SIZE(au1100_lcd_resources),
+	.resource       = au1100_lcd_resources,
+};
+#endif
+
+static struct platform_device au1x00_pcmcia_device = {
+	.name 		= "au1x00-pcmcia",
+	.id 		= 0,
+};
+
+#ifdef SMBUS_PSC_BASE	/* Db1550 */
+static struct resource pbdb_smbus_resources[] = {
+	{
+		.start	= CPHYSADDR(SMBUS_PSC_BASE),
+		.end	= CPHYSADDR(SMBUS_PSC_BASE + 0xfffff),
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device pbdb_smbus_device = {
+	.name		= "au1xpsc_smbus",
+	.id		= 0,	/* bus number */
+	.num_resources	= ARRAY_SIZE(pbdb_smbus_resources),
+	.resource	= pbdb_smbus_resources,
+};
+#endif
+
+static struct platform_device *au1xxx_platform_devices[] __initdata = {
+	&au1xx0_uart_device,
+	&au1xxx_usb_ohci_device,
+	&au1x00_pcmcia_device,
+#ifdef CONFIG_FB_AU1100
+	&au1100_lcd_device,
+#endif
+#ifdef SMBUS_PSC_BASE
+	&pbdb_smbus_device,
+#endif
+};
+
+static int __init au1xxx_platform_init(void)
+{
+	unsigned int uartclk = get_au1x00_uart_baud_base() * 16;
+	int i;
+
+	/* Fill up uartclk. */
+	for (i = 0; au1x00_uart_data[i].flags; i++)
+		au1x00_uart_data[i].uartclk = uartclk;
+
+	return platform_add_devices(au1xxx_platform_devices,
+				    ARRAY_SIZE(au1xxx_platform_devices));
+}
+
+arch_initcall(au1xxx_platform_init);
diff --git a/arch/mips/alchemy/devboards/pb1000/Makefile b/arch/mips/alchemy/devboards/pb1000/Makefile
index 97c6615..38d11bb 100644
--- a/arch/mips/alchemy/devboards/pb1000/Makefile
+++ b/arch/mips/alchemy/devboards/pb1000/Makefile
@@ -5,4 +5,4 @@
 # Makefile for the Alchemy Semiconductor Pb1000 board.
 #
 
-obj-y := board_setup.o
+obj-y := board_setup.o platform.o
diff --git a/arch/mips/alchemy/devboards/pb1000/platform.c b/arch/mips/alchemy/devboards/pb1000/platform.c
new file mode 100644
index 0000000..0661a49
--- /dev/null
+++ b/arch/mips/alchemy/devboards/pb1000/platform.c
@@ -0,0 +1,90 @@
+/*
+ * pb1000 platform device registration.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/serial_8250.h>
+
+#include <asm/mach-au1x00/au1000.h>
+
+#define PORT(_base, _irq)					\
+	{							\
+		.iobase		= _base,			\
+		.mapbase	= _base,			\
+		.irq		= _irq,				\
+		.regshift	= 2,				\
+		.iotype		= UPIO_AU,			\
+		.flags		= UPF_SKIP_TEST | UPF_IOREMAP	\
+	}
+
+static struct plat_serial8250_port pb1000_uart_data[] = {
+	PORT(UART0_PHYS_ADDR, AU1000_UART0_INT),
+	PORT(UART1_PHYS_ADDR, AU1000_UART1_INT),
+	PORT(UART2_PHYS_ADDR, AU1000_UART2_INT),
+	PORT(UART3_PHYS_ADDR, AU1000_UART3_INT),
+	{},
+};
+
+static struct platform_device pb1000_uart_device = {
+	.name			= "serial8250",
+	.id			= PLAT8250_DEV_AU1X00,
+	.dev			= {
+		.platform_data	= pb1000_uart_data,
+	},
+};
+
+/* OHCI (USB full speed host controller) */
+static struct resource au1xxx_usb_ohci_resources[] = {
+	[0] = {
+		.start		= USB_OHCI_BASE,
+		.end		= USB_OHCI_BASE + USB_OHCI_LEN - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= AU1000_USB_HOST_INT,
+		.end		= AU1000_USB_HOST_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+/* The dmamask must be set for OHCI to work */
+static u64 ohci_dmamask = DMA_32BIT_MASK;
+
+static struct platform_device au1xxx_usb_ohci_device = {
+	.name		= "au1xxx-ohci",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &ohci_dmamask,
+		.coherent_dma_mask	= DMA_32BIT_MASK,
+	},
+	.num_resources	= ARRAY_SIZE(au1xxx_usb_ohci_resources),
+	.resource	= au1xxx_usb_ohci_resources,
+};
+
+static struct platform_device pb1000_pcmcia_device = {
+	.name 		= "au1x00-pcmcia",
+	.id 		= 0,
+};
+
+static struct platform_device *pb1000_devices[] = {
+	&pb1000_uart_device,
+	&au1xxx_usb_ohci_device,
+	&pb1000_pcmcia_device,
+};
+
+static int __init pb1000_platform_init(void)
+{
+	unsigned int uartclk = get_au1x00_uart_baud_base() * 16;
+	int i;
+
+	/* Fill up uartclk. */
+	for (i = 0; pb1000_uart_data[i].flags; i++)
+		pb1000_uart_data[i].uartclk = uartclk;
+
+	return platform_add_devices(pb1000_devices,
+				    ARRAY_SIZE(pb1000_devices));
+}
+
+arch_initcall(pb1000_platform_init);
diff --git a/arch/mips/alchemy/devboards/pb1100/Makefile b/arch/mips/alchemy/devboards/pb1100/Makefile
index c586dd7..7e3756c 100644
--- a/arch/mips/alchemy/devboards/pb1100/Makefile
+++ b/arch/mips/alchemy/devboards/pb1100/Makefile
@@ -5,4 +5,4 @@
 # Makefile for the Alchemy Semiconductor Pb1100 board.
 #
 
-obj-y := board_setup.o
+obj-y := board_setup.o platform.o
diff --git a/arch/mips/alchemy/devboards/pb1100/platform.c b/arch/mips/alchemy/devboards/pb1100/platform.c
new file mode 100644
index 0000000..276db5a
--- /dev/null
+++ b/arch/mips/alchemy/devboards/pb1100/platform.c
@@ -0,0 +1,116 @@
+/*
+ * pb1100 platform device registration.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/serial_8250.h>
+
+#include <asm/mach-au1x00/au1000.h>
+
+#define PORT(_base, _irq)					\
+	{							\
+		.iobase		= _base,			\
+		.mapbase	= _base,			\
+		.irq		= _irq,				\
+		.regshift	= 2,				\
+		.iotype		= UPIO_AU,			\
+		.flags		= UPF_SKIP_TEST | UPF_IOREMAP	\
+	}
+
+static struct plat_serial8250_port pb1100_uart_data[] = {
+	PORT(UART0_PHYS_ADDR, AU1100_UART0_INT),
+	PORT(UART1_PHYS_ADDR, AU1100_UART1_INT),
+	PORT(UART3_PHYS_ADDR, AU1100_UART3_INT),
+	{},
+};
+
+static struct platform_device pb1100_uart_device = {
+	.name			= "serial8250",
+	.id			= PLAT8250_DEV_AU1X00,
+	.dev			= {
+		.platform_data	= pb1100_uart_data,
+	},
+};
+
+/* OHCI (USB full speed host controller) */
+static struct resource au1xxx_usb_ohci_resources[] = {
+	[0] = {
+		.start		= USB_OHCI_BASE,
+		.end		= USB_OHCI_BASE + USB_OHCI_LEN - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= AU1000_USB_HOST_INT,
+		.end		= AU1000_USB_HOST_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+/* The dmamask must be set for OHCI to work */
+static u64 ohci_dmamask = DMA_32BIT_MASK;
+
+static struct platform_device au1xxx_usb_ohci_device = {
+	.name		= "au1xxx-ohci",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &ohci_dmamask,
+		.coherent_dma_mask	= DMA_32BIT_MASK,
+	},
+	.num_resources	= ARRAY_SIZE(au1xxx_usb_ohci_resources),
+	.resource	= au1xxx_usb_ohci_resources,
+};
+
+static struct platform_device pb1100_pcmcia_device = {
+	.name 		= "au1x00-pcmcia",
+	.id 		= 0,
+};
+
+static struct resource au1100_lcd_resources[] = {
+	[0] = {
+		.start          = LCD_PHYS_ADDR,
+		.end            = LCD_PHYS_ADDR + 0x800 - 1,
+		.flags          = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start          = AU1100_LCD_INT,
+		.end            = AU1100_LCD_INT,
+		.flags          = IORESOURCE_IRQ,
+	}
+};
+
+static u64 au1100_lcd_dmamask = DMA_32BIT_MASK;
+
+static struct platform_device au1100_lcd_device = {
+	.name           = "au1100-lcd",
+	.id             = 0,
+	.dev = {
+		.dma_mask               = &au1100_lcd_dmamask,
+		.coherent_dma_mask      = DMA_32BIT_MASK,
+	},
+	.num_resources  = ARRAY_SIZE(au1100_lcd_resources),
+	.resource       = au1100_lcd_resources,
+};
+
+static struct platform_device *pb1100_devices[] = {
+	&pb1100_uart_device,
+	&au1xxx_usb_ohci_device,
+	&pb1100_pcmcia_device,
+	&au1100_lcd_device,
+};
+
+static int __init pb1100_platform_init(void)
+{
+	unsigned int uartclk = get_au1x00_uart_baud_base() * 16;
+	int i;
+
+	/* Fill up uartclk. */
+	for (i = 0; pb1100_uart_data[i].flags; i++)
+		pb1100_uart_data[i].uartclk = uartclk;
+
+	return platform_add_devices(pb1100_devices,
+				    ARRAY_SIZE(pb1100_devices));
+}
+
+arch_initcall(pb1100_platform_init);
diff --git a/arch/mips/alchemy/devboards/pb1200/platform.c b/arch/mips/alchemy/devboards/pb1200/platform.c
index 9530329..ff446a5 100644
--- a/arch/mips/alchemy/devboards/pb1200/platform.c
+++ b/arch/mips/alchemy/devboards/pb1200/platform.c
@@ -22,12 +22,38 @@
 #include <linux/init.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
+#include <linux/serial_8250.h>
 
+#include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx.h>
 #include <asm/mach-au1x00/au1100_mmc.h>
 
 static int mmc_activity;
 
+#define PORT(_base, _irq)					\
+	{							\
+		.iobase		= _base,			\
+		.mapbase	= _base,			\
+		.irq		= _irq,				\
+		.regshift	= 2,				\
+		.iotype		= UPIO_AU,			\
+		.flags		= UPF_SKIP_TEST | UPF_IOREMAP	\
+	}
+
+static struct plat_serial8250_port au1200_uart_data[] = {
+	PORT(UART0_PHYS_ADDR, AU1200_UART0_INT),
+	PORT(UART1_PHYS_ADDR, AU1200_UART1_INT),
+	{ },
+};
+
+static struct platform_device au1200_uart_device = {
+	.name			= "serial8250",
+	.id			= PLAT8250_DEV_AU1X00,
+	.dev			= {
+		.platform_data	= au1200_uart_data,
+	},
+};
+
 static void pb1200mmc0_set_power(void *mmc_host, int state)
 {
 	if (state)
@@ -152,13 +178,175 @@ static struct platform_device smc91c111_device = {
 	.resource	= smc91c111_resources
 };
 
+static struct resource au1xxx_usb_ohci_resources[] = {
+	[0] = {
+		.start		= USB_OHCI_BASE,
+		.end		= USB_OHCI_BASE + USB_OHCI_LEN - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= AU1000_USB_HOST_INT,
+		.end		= AU1000_USB_HOST_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+/* The dmamask must be set for OHCI to work */
+static u64 ohci_dmamask = DMA_32BIT_MASK;
+
+static struct platform_device au1xxx_usb_ohci_device = {
+	.name		= "au1xxx-ohci",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &ohci_dmamask,
+		.coherent_dma_mask	= DMA_32BIT_MASK,
+	},
+	.num_resources	= ARRAY_SIZE(au1xxx_usb_ohci_resources),
+	.resource	= au1xxx_usb_ohci_resources,
+};
+
+static struct resource au1xxx_usb_ehci_resources[] = {
+	[0] = {
+		.start		= USB_EHCI_BASE,
+		.end		= USB_EHCI_BASE + USB_EHCI_LEN - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= AU1000_USB_HOST_INT,
+		.end		= AU1000_USB_HOST_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static u64 ehci_dmamask = DMA_32BIT_MASK;
+
+static struct platform_device au1xxx_usb_ehci_device = {
+	.name		= "au1xxx-ehci",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &ehci_dmamask,
+		.coherent_dma_mask	= DMA_32BIT_MASK,
+	},
+	.num_resources	= ARRAY_SIZE(au1xxx_usb_ehci_resources),
+	.resource	= au1xxx_usb_ehci_resources,
+};
+
+/* Au1200 UDC (USB gadget controller) */
+static struct resource au1xxx_usb_gdt_resources[] = {
+	[0] = {
+		.start		= USB_UDC_BASE,
+		.end		= USB_UDC_BASE + USB_UDC_LEN - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= AU1200_USB_INT,
+		.end		= AU1200_USB_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static u64 udc_dmamask = DMA_32BIT_MASK;
+
+static struct platform_device au1xxx_usb_gdt_device = {
+	.name		= "au1xxx-udc",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &udc_dmamask,
+		.coherent_dma_mask	= DMA_32BIT_MASK,
+	},
+	.num_resources	= ARRAY_SIZE(au1xxx_usb_gdt_resources),
+	.resource	= au1xxx_usb_gdt_resources,
+};
+
+/* Au1200 UOC (USB OTG controller) */
+static struct resource au1xxx_usb_otg_resources[] = {
+	[0] = {
+		.start		= USB_UOC_BASE,
+		.end		= USB_UOC_BASE + USB_UOC_LEN - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= AU1200_USB_INT,
+		.end		= AU1200_USB_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static u64 uoc_dmamask = DMA_32BIT_MASK;
+
+static struct platform_device au1xxx_usb_otg_device = {
+	.name		= "au1xxx-uoc",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &uoc_dmamask,
+		.coherent_dma_mask	= DMA_32BIT_MASK,
+	},
+	.num_resources	= ARRAY_SIZE(au1xxx_usb_otg_resources),
+	.resource	= au1xxx_usb_otg_resources,
+};
+
+static struct resource au1200_lcd_resources[] = {
+	[0] = {
+		.start          = LCD_PHYS_ADDR,
+		.end            = LCD_PHYS_ADDR + 0x800 - 1,
+		.flags          = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start          = AU1200_LCD_INT,
+		.end            = AU1200_LCD_INT,
+		.flags          = IORESOURCE_IRQ,
+	}
+};
+
+static u64 au1200_lcd_dmamask = DMA_32BIT_MASK;
+
+static struct platform_device au1200_lcd_device = {
+	.name           = "au1200-lcd",
+	.id             = 0,
+	.dev = {
+		.dma_mask               = &au1200_lcd_dmamask,
+		.coherent_dma_mask      = DMA_32BIT_MASK,
+	},
+	.num_resources  = ARRAY_SIZE(au1200_lcd_resources),
+	.resource       = au1200_lcd_resources,
+};
+
+static struct resource pb1200_smbus_resources[] = {
+	{
+		.start	= CPHYSADDR(SMBUS_PSC_BASE),
+		.end	= CPHYSADDR(SMBUS_PSC_BASE + 0xfffff),
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device pb1200_smbus_device = {
+	.name		= "au1xpsc_smbus",
+	.id		= 0,	/* bus number */
+	.num_resources	= ARRAY_SIZE(pb1200_smbus_resources),
+	.resource	= pb1200_smbus_resources,
+};
+
 static struct platform_device *board_platform_devices[] __initdata = {
+	&au1200_uart_device,
 	&ide_device,
-	&smc91c111_device
+	&smc91c111_device,
+	&au1xxx_usb_ohci_device,
+	&au1xxx_usb_ehci_device,
+	&au1xxx_usb_gdt_device,
+	&au1xxx_usb_otg_device,
+	&au1200_lcd_device,
+	&pb1200_smbus_device,
 };
 
 static int __init board_register_devices(void)
 {
+	unsigned int uartclk = get_au1x00_uart_baud_base() * 16;
+	int i;
+
+	/* Fill up uartclk. */
+	for (i = 0; au1200_uart_data[i].flags; i++)
+		au1200_uart_data[i].uartclk = uartclk;
+
 	return platform_add_devices(board_platform_devices,
 				    ARRAY_SIZE(board_platform_devices));
 }
diff --git a/arch/mips/alchemy/devboards/pb1500/Makefile b/arch/mips/alchemy/devboards/pb1500/Makefile
index 173b419..e83b151 100644
--- a/arch/mips/alchemy/devboards/pb1500/Makefile
+++ b/arch/mips/alchemy/devboards/pb1500/Makefile
@@ -5,4 +5,4 @@
 # Makefile for the Alchemy Semiconductor Pb1500 board.
 #
 
-obj-y := board_setup.o
+obj-y := board_setup.o platform.o
diff --git a/arch/mips/alchemy/devboards/pb1500/platform.c b/arch/mips/alchemy/devboards/pb1500/platform.c
new file mode 100644
index 0000000..5c68d68
--- /dev/null
+++ b/arch/mips/alchemy/devboards/pb1500/platform.c
@@ -0,0 +1,88 @@
+/*
+ * pb1500 platform device registration.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/serial_8250.h>
+
+#include <asm/mach-au1x00/au1000.h>
+
+#define PORT(_base, _irq)					\
+	{							\
+		.iobase		= _base,			\
+		.mapbase	= _base,			\
+		.irq		= _irq,				\
+		.regshift	= 2,				\
+		.iotype		= UPIO_AU,			\
+		.flags		= UPF_SKIP_TEST | UPF_IOREMAP	\
+	}
+
+static struct plat_serial8250_port pb1500_uart_data[] = {
+	PORT(UART0_PHYS_ADDR, AU1500_UART0_INT),
+	PORT(UART3_PHYS_ADDR, AU1500_UART3_INT),
+	{},
+};
+
+static struct platform_device pb1500_uart_device = {
+	.name			= "serial8250",
+	.id			= PLAT8250_DEV_AU1X00,
+	.dev			= {
+		.platform_data	= pb1500_uart_data,
+	},
+};
+
+/* OHCI (USB full speed host controller) */
+static struct resource au1xxx_usb_ohci_resources[] = {
+	[0] = {
+		.start		= USB_OHCI_BASE,
+		.end		= USB_OHCI_BASE + USB_OHCI_LEN - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= AU1000_USB_HOST_INT,
+		.end		= AU1000_USB_HOST_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+/* The dmamask must be set for OHCI to work */
+static u64 ohci_dmamask = DMA_32BIT_MASK;
+
+static struct platform_device au1xxx_usb_ohci_device = {
+	.name		= "au1xxx-ohci",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &ohci_dmamask,
+		.coherent_dma_mask	= DMA_32BIT_MASK,
+	},
+	.num_resources	= ARRAY_SIZE(au1xxx_usb_ohci_resources),
+	.resource	= au1xxx_usb_ohci_resources,
+};
+
+static struct platform_device pb1500_pcmcia_device = {
+	.name 		= "au1x00-pcmcia",
+	.id 		= 0,
+};
+
+static struct platform_device *pb1500_devices[] = {
+	&pb1500_uart_device,
+	&au1xxx_usb_ohci_device,
+	&pb1500_pcmcia_device,
+};
+
+static int __init pb1500_platform_init(void)
+{
+	unsigned int uartclk = get_au1x00_uart_baud_base() * 16;
+	int i;
+
+	/* Fill up uartclk. */
+	for (i = 0; pb1500_uart_data[i].flags; i++)
+		pb1500_uart_data[i].uartclk = uartclk;
+
+	return platform_add_devices(pb1500_devices,
+				    ARRAY_SIZE(pb1500_devices));
+}
+
+arch_initcall(pb1500_platform_init);
diff --git a/arch/mips/alchemy/devboards/pb1550/Makefile b/arch/mips/alchemy/devboards/pb1550/Makefile
index cff95bc..9661b6e 100644
--- a/arch/mips/alchemy/devboards/pb1550/Makefile
+++ b/arch/mips/alchemy/devboards/pb1550/Makefile
@@ -5,4 +5,4 @@
 # Makefile for the Alchemy Semiconductor Pb1550 board.
 #
 
-obj-y := board_setup.o
+obj-y := board_setup.o platform.o
diff --git a/arch/mips/alchemy/devboards/pb1550/platform.c b/arch/mips/alchemy/devboards/pb1550/platform.c
new file mode 100644
index 0000000..f653193
--- /dev/null
+++ b/arch/mips/alchemy/devboards/pb1550/platform.c
@@ -0,0 +1,106 @@
+/*
+ * pb1550 platform device registration.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/serial_8250.h>
+
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-pb1x00/pb1550.h>
+
+#define PORT(_base, _irq)					\
+	{							\
+		.iobase		= _base,			\
+		.mapbase	= _base,			\
+		.irq		= _irq,				\
+		.regshift	= 2,				\
+		.iotype		= UPIO_AU,			\
+		.flags		= UPF_SKIP_TEST | UPF_IOREMAP	\
+	}
+
+static struct plat_serial8250_port pb1550_uart_data[] = {
+	PORT(UART0_PHYS_ADDR, AU1550_UART0_INT),
+	PORT(UART1_PHYS_ADDR, AU1550_UART1_INT),
+	PORT(UART3_PHYS_ADDR, AU1550_UART3_INT),
+	{},
+};
+
+static struct platform_device pb1550_uart_device = {
+	.name			= "serial8250",
+	.id			= PLAT8250_DEV_AU1X00,
+	.dev			= {
+		.platform_data	= pb1550_uart_data,
+	},
+};
+
+/* OHCI (USB full speed host controller) */
+static struct resource au1xxx_usb_ohci_resources[] = {
+	[0] = {
+		.start		= USB_OHCI_BASE,
+		.end		= USB_OHCI_BASE + USB_OHCI_LEN - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= AU1000_USB_HOST_INT,
+		.end		= AU1000_USB_HOST_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+/* The dmamask must be set for OHCI to work */
+static u64 ohci_dmamask = DMA_32BIT_MASK;
+
+static struct platform_device au1xxx_usb_ohci_device = {
+	.name		= "au1xxx-ohci",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &ohci_dmamask,
+		.coherent_dma_mask	= DMA_32BIT_MASK,
+	},
+	.num_resources	= ARRAY_SIZE(au1xxx_usb_ohci_resources),
+	.resource	= au1xxx_usb_ohci_resources,
+};
+
+static struct platform_device pb1550_pcmcia_device = {
+	.name 		= "au1x00-pcmcia",
+	.id 		= 0,
+};
+
+static struct resource pb1550_smbus_resources[] = {
+	{
+		.start	= CPHYSADDR(SMBUS_PSC_BASE),
+		.end	= CPHYSADDR(SMBUS_PSC_BASE + 0xfffff),
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device pb1550_smbus_device = {
+	.name		= "au1xpsc_smbus",
+	.id		= 0,	/* bus number */
+	.num_resources	= ARRAY_SIZE(pb1550_smbus_resources),
+	.resource	= pb1550_smbus_resources,
+};
+
+static struct platform_device *pb1550_devices[] = {
+	&pb1550_uart_device,
+	&au1xxx_usb_ohci_device,
+	&pb1550_pcmcia_device,
+	&pb1550_smbus_device,
+};
+
+static int __init pb1550_platform_init(void)
+{
+	unsigned int uartclk = get_au1x00_uart_baud_base() * 16;
+	int i;
+
+	/* Fill up uartclk. */
+	for (i = 0; pb1550_uart_data[i].flags; i++)
+		pb1550_uart_data[i].uartclk = uartclk;
+
+	return platform_add_devices(pb1550_devices,
+				    ARRAY_SIZE(pb1550_devices));
+}
+
+arch_initcall(pb1550_platform_init);
diff --git a/arch/mips/alchemy/mtx-1/platform.c b/arch/mips/alchemy/mtx-1/platform.c
index 8b5914d..da1f72b 100644
--- a/arch/mips/alchemy/mtx-1/platform.c
+++ b/arch/mips/alchemy/mtx-1/platform.c
@@ -18,6 +18,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/leds.h>
@@ -26,8 +27,11 @@
 #include <linux/input.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
+#include <linux/serial_8250.h>
 #include <mtd/mtd-abi.h>
 
+#include <asm/mach-au1x00/au1xxx.h>
+
 static struct gpio_keys_button mtx1_gpio_button[] = {
 	{
 		.gpio = 207,
@@ -133,15 +137,75 @@ static struct platform_device mtx1_mtd = {
 	.resource	= &mtx1_mtd_resource,
 };
 
+#define PORT(_base, _irq)					\
+	{							\
+		.iobase		= _base,			\
+		.mapbase	= _base,			\
+		.irq		= _irq,				\
+		.regshift	= 2,				\
+		.iotype		= UPIO_AU,			\
+		.flags		= UPF_SKIP_TEST | UPF_IOREMAP	\
+	}
+
+static struct plat_serial8250_port mtx1_uart_data[] = {
+	PORT(UART0_PHYS_ADDR, AU1500_UART0_INT),
+	PORT(UART3_PHYS_ADDR, AU1500_UART3_INT),
+	{ },
+};
+
+static struct platform_device mtx1_uarts = {
+	.name			= "serial8250",
+	.id			= PLAT8250_DEV_AU1X00,
+	.dev			= {
+		.platform_data	= mtx1_uart_data,
+	},
+};
+
+static struct resource au1xxx_usb_ohci_resources[] = {
+	[0] = {
+		.start		= USB_OHCI_BASE,
+		.end		= USB_OHCI_BASE + USB_OHCI_LEN - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= AU1000_USB_HOST_INT,
+		.end		= AU1000_USB_HOST_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+/* The dmamask must be set for OHCI to work */
+static u64 ohci_dmamask = DMA_32BIT_MASK;
+
+static struct platform_device au1xxx_usb_ohci_device = {
+	.name		= "au1xxx-ohci",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &ohci_dmamask,
+		.coherent_dma_mask	= DMA_32BIT_MASK,
+	},
+	.num_resources	= ARRAY_SIZE(au1xxx_usb_ohci_resources),
+	.resource	= au1xxx_usb_ohci_resources,
+};
+
 static struct __initdata platform_device * mtx1_devs[] = {
+	&mtx1_uarts,
 	&mtx1_gpio_leds,
 	&mtx1_wdt,
 	&mtx1_button,
 	&mtx1_mtd,
+	&au1xxx_usb_ohci_device,
 };
 
 static int __init mtx1_register_devices(void)
 {
+	unsigned int uartclk = get_au1x00_uart_baud_base() * 16;
+	int i;
+
+	/* Fill up uartclk. */
+	for (i = 0; au1x00_uart_data[i].flags; i++)
+		au1x00_uart_data[i].uartclk = uartclk;
+
 	gpio_direction_input(207);
 	return platform_add_devices(mtx1_devs, ARRAY_SIZE(mtx1_devs));
 }
diff --git a/arch/mips/alchemy/xxs1500/Makefile b/arch/mips/alchemy/xxs1500/Makefile
index db3c526..95aa487 100644
--- a/arch/mips/alchemy/xxs1500/Makefile
+++ b/arch/mips/alchemy/xxs1500/Makefile
@@ -5,4 +5,5 @@
 # Makefile for MyCable XXS1500 board.
 #
 
-lib-y := init.o board_setup.o irqmap.o
+lib-y := init.o board_setup.o irqmap.o platform.o
+
diff --git a/arch/mips/alchemy/xxs1500/platform.c b/arch/mips/alchemy/xxs1500/platform.c
new file mode 100644
index 0000000..52f94e7
--- /dev/null
+++ b/arch/mips/alchemy/xxs1500/platform.c
@@ -0,0 +1,87 @@
+/*
+ * xxs1500 platform device registration
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/serial_8250.h>
+
+#include <asm/mach-au1x00/au1000.h>
+
+#define PORT(_base, _irq)					\
+	{							\
+		.iobase		= _base,			\
+		.mapbase	= _base,			\
+		.irq		= _irq,				\
+		.regshift	= 2,				\
+		.iotype		= UPIO_AU,			\
+		.flags		= UPF_SKIP_TEST | UPF_IOREMAP	\
+	}
+
+static struct plat_serial8250_port xxs1500_uart_data[] = {
+	PORT(UART0_PHYS_ADDR, AU1500_UART0_INT),
+	PORT(UART3_PHYS_ADDR, AU1500_UART3_INT),
+	{ },
+};
+
+static struct platform_device xxs1500_uart_device = {
+	.name			= "serial8250",
+	.id			= PLAT8250_DEV_AU1X00,
+	.dev			= {
+		.platform_data	= xxs1500_uart_data,
+	},
+};
+
+/* OHCI (USB full speed host controller) */
+static struct resource au1xxx_usb_ohci_resources[] = {
+	[0] = {
+		.start		= USB_OHCI_BASE,
+		.end		= USB_OHCI_BASE + USB_OHCI_LEN - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= AU1000_USB_HOST_INT,
+		.end		= AU1000_USB_HOST_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+/* The dmamask must be set for OHCI to work */
+static u64 ohci_dmamask = DMA_32BIT_MASK;
+
+static struct platform_device au1xxx_usb_ohci_device = {
+	.name		= "au1xxx-ohci",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &ohci_dmamask,
+		.coherent_dma_mask	= DMA_32BIT_MASK,
+	},
+	.num_resources	= ARRAY_SIZE(au1xxx_usb_ohci_resources),
+	.resource	= au1xxx_usb_ohci_resources,
+};
+
+static struct platform_device xxs1500_pcmcia_device = {
+	.name 		= "au1x00-pcmcia",
+	.id 		= 0,
+};
+
+static struct platform_device *xxs1500_devices[] = {
+	&xxs1500_uart_device,
+	&au1xxx_usb_ohci_device,
+	&xxs1500_pcmcia_device,
+};
+
+static int __init xxs1500_platform_init(void)
+{
+	unsigned int uartclk = get_au1x00_uart_baud_base() * 16;
+	int i;
+
+	/* Fill up uartclk. */
+	for (i = 0; xxs1500_uart_data[i].flags; i++)
+		xxs1500_uart_data[i].uartclk = uartclk;
+
+	return platform_add_devices(xxs1500_devices,
+				    ARRAY_SIZE(xxs1500_devices));
+}
+
+arch_initcall(xxs1500_platform_init);
-- 
1.6.2
