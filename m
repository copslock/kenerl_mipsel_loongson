Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jul 2010 14:13:49 +0200 (CEST)
Received: from smtp-out-005.synserver.de ([212.40.180.5]:1074 "HELO
        smtp-out-003.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with SMTP id S1491154Ab0GQMNq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Jul 2010 14:13:46 +0200
Received: (qmail 31948 invoked by uid 0); 17 Jul 2010 12:13:45 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 31910
Received: from d077015.adsl.hansenet.de (HELO localhost.localdomain) [80.171.77.15]
  by 217.119.54.77 with SMTP; 17 Jul 2010 12:13:45 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3] MIPS: JZ4740: Add platform devices
Date:   Sat, 17 Jul 2010 14:13:29 +0200
Message-Id: <1279368809-21006-1-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1276924111-11158-14-git-send-email-lars@metafoo.de>
References: <1276924111-11158-14-git-send-email-lars@metafoo.de>
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips

This patch adds platform devices for all the JZ4740 platform drivers.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

---
Changes since v1
- Add JZ4740 PCM device
- Add ADC MFD device and remove battery device

Changes since v2
- Add memory region for NAND bank
---
 arch/mips/include/asm/mach-jz4740/platform.h |   36 ++++
 arch/mips/jz4740/platform.c                  |  291 ++++++++++++++++++++++++++
 2 files changed, 327 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-jz4740/platform.h
 create mode 100644 arch/mips/jz4740/platform.c

diff --git a/arch/mips/include/asm/mach-jz4740/platform.h b/arch/mips/include/asm/mach-jz4740/platform.h
new file mode 100644
index 0000000..8987a76
--- /dev/null
+++ b/arch/mips/include/asm/mach-jz4740/platform.h
@@ -0,0 +1,36 @@
+/*
+ *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
+ *  JZ4740 platform device definitions
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under  the terms of the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+
+#ifndef __JZ4740_PLATFORM_H
+#define __JZ4740_PLATFORM_H
+
+#include <linux/platform_device.h>
+
+extern struct platform_device jz4740_usb_ohci_device;
+extern struct platform_device jz4740_udc_device;
+extern struct platform_device jz4740_mmc_device;
+extern struct platform_device jz4740_rtc_device;
+extern struct platform_device jz4740_i2c_device;
+extern struct platform_device jz4740_nand_device;
+extern struct platform_device jz4740_framebuffer_device;
+extern struct platform_device jz4740_i2s_device;
+extern struct platform_device jz4740_pcm_device;
+extern struct platform_device jz4740_codec_device;
+extern struct platform_device jz4740_adc_device;
+
+void jz4740_serial_device_register(void);
+
+#endif
diff --git a/arch/mips/jz4740/platform.c b/arch/mips/jz4740/platform.c
new file mode 100644
index 0000000..95bc2b5
--- /dev/null
+++ b/arch/mips/jz4740/platform.c
@@ -0,0 +1,291 @@
+/*
+ *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
+ *  JZ4740 platform devices
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under  the terms of the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+
+#include <linux/dma-mapping.h>
+
+#include <asm/mach-jz4740/platform.h>
+#include <asm/mach-jz4740/base.h>
+#include <asm/mach-jz4740/irq.h>
+
+#include <linux/serial_core.h>
+#include <linux/serial_8250.h>
+
+#include "serial.h"
+#include "clock.h"
+
+/* OHCI controller */
+static struct resource jz4740_usb_ohci_resources[] = {
+	{
+		.start	= JZ4740_UHC_BASE_ADDR,
+		.end	= JZ4740_UHC_BASE_ADDR + 0x1000 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= JZ4740_IRQ_UHC,
+		.end	= JZ4740_IRQ_UHC,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device jz4740_usb_ohci_device = {
+	.name		= "jz4740-ohci",
+	.id		= -1,
+	.dev = {
+		.dma_mask = &jz4740_usb_ohci_device.dev.coherent_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(jz4740_usb_ohci_resources),
+	.resource	= jz4740_usb_ohci_resources,
+};
+
+/* UDC (USB gadget controller) */
+static struct resource jz4740_usb_gdt_resources[] = {
+	{
+		.start	= JZ4740_UDC_BASE_ADDR,
+		.end	= JZ4740_UDC_BASE_ADDR + 0x1000 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= JZ4740_IRQ_UDC,
+		.end	= JZ4740_IRQ_UDC,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device jz4740_udc_device = {
+	.name		= "jz-udc",
+	.id		= -1,
+	.dev = {
+		.dma_mask = &jz4740_udc_device.dev.coherent_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(jz4740_usb_gdt_resources),
+	.resource	= jz4740_usb_gdt_resources,
+};
+
+/* MMC/SD controller */
+static struct resource jz4740_mmc_resources[] = {
+	{
+		.start	= JZ4740_MSC_BASE_ADDR,
+		.end	= JZ4740_MSC_BASE_ADDR + 0x1000 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= JZ4740_IRQ_MSC,
+		.end	= JZ4740_IRQ_MSC,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device jz4740_mmc_device = {
+	.name		= "jz4740-mmc",
+	.id		= 0,
+	.dev = {
+		.dma_mask = &jz4740_mmc_device.dev.coherent_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
+	.num_resources  = ARRAY_SIZE(jz4740_mmc_resources),
+	.resource	= jz4740_mmc_resources,
+};
+
+/* RTC controller */
+static struct resource jz4740_rtc_resources[] = {
+	{
+		.start	= JZ4740_RTC_BASE_ADDR,
+		.end	= JZ4740_RTC_BASE_ADDR + 0x38 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start  = JZ4740_IRQ_RTC,
+		.end	= JZ4740_IRQ_RTC,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device jz4740_rtc_device = {
+	.name		= "jz4740-rtc",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(jz4740_rtc_resources),
+	.resource	= jz4740_rtc_resources,
+};
+
+/* I2C controller */
+static struct resource jz4740_i2c_resources[] = {
+	{
+		.start	= JZ4740_I2C_BASE_ADDR,
+		.end	= JZ4740_I2C_BASE_ADDR + 0x1000 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= JZ4740_IRQ_I2C,
+		.end	= JZ4740_IRQ_I2C,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device jz4740_i2c_device = {
+	.name		= "jz4740-i2c",
+	.id		= 0,
+	.num_resources  = ARRAY_SIZE(jz4740_i2c_resources),
+	.resource	= jz4740_i2c_resources,
+};
+
+/* NAND controller */
+static struct resource jz4740_nand_resources[] = {
+	{
+		.name	= "mmio",
+		.start	= JZ4740_EMC_BASE_ADDR,
+		.end	= JZ4740_EMC_BASE_ADDR + 0x1000 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.name	= "bank",
+		.start	= 0x18000000,
+		.end	= 0x180C0000 - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device jz4740_nand_device = {
+	.name = "jz4740-nand",
+	.num_resources = ARRAY_SIZE(jz4740_nand_resources),
+	.resource = jz4740_nand_resources,
+};
+
+/* LCD controller */
+static struct resource jz4740_framebuffer_resources[] = {
+	{
+		.start	= JZ4740_LCD_BASE_ADDR,
+		.end	= JZ4740_LCD_BASE_ADDR + 0x1000 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+struct platform_device jz4740_framebuffer_device = {
+	.name		= "jz4740-fb",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(jz4740_framebuffer_resources),
+	.resource	= jz4740_framebuffer_resources,
+	.dev = {
+		.dma_mask = &jz4740_framebuffer_device.dev.coherent_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
+};
+
+/* I2S controller */
+static struct resource jz4740_i2s_resources[] = {
+	{
+		.start	= JZ4740_AIC_BASE_ADDR,
+		.end	= JZ4740_AIC_BASE_ADDR + 0x38 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+struct platform_device jz4740_i2s_device = {
+	.name		= "jz4740-i2s",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(jz4740_i2s_resources),
+	.resource	= jz4740_i2s_resources,
+};
+
+/* PCM */
+struct platform_device jz4740_pcm_device = {
+	.name		= "jz4740-pcm",
+	.id		= -1,
+};
+
+/* Codec */
+static struct resource jz4740_codec_resources[] = {
+	{
+		.start	= JZ4740_AIC_BASE_ADDR + 0x80,
+		.end	= JZ4740_AIC_BASE_ADDR + 0x88 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+struct platform_device jz4740_codec_device = {
+	.name		= "jz4740-codec",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(jz4740_codec_resources),
+	.resource	= jz4740_codec_resources,
+};
+
+/* ADC controller */
+static struct resource jz4740_adc_resources[] = {
+	{
+		.start	= JZ4740_SADC_BASE_ADDR,
+		.end	= JZ4740_SADC_BASE_ADDR + 0x30,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= JZ4740_IRQ_SADC,
+		.end	= JZ4740_IRQ_SADC,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= JZ4740_IRQ_ADC_BASE,
+		.end	= JZ4740_IRQ_ADC_BASE,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device jz4740_adc_device = {
+	.name		= "jz4740-adc",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(jz4740_adc_resources),
+	.resource	= jz4740_adc_resources,
+};
+
+/* Serial */
+#define JZ4740_UART_DATA(_id) \
+	{ \
+		.flags = UPF_SKIP_TEST | UPF_IOREMAP | UPF_FIXED_TYPE, \
+		.iotype = UPIO_MEM, \
+		.regshift = 2, \
+		.serial_out = jz4740_serial_out, \
+		.type = PORT_16550, \
+		.mapbase = JZ4740_UART ## _id ## _BASE_ADDR, \
+		.irq = JZ4740_IRQ_UART ## _id, \
+	}
+
+static struct plat_serial8250_port jz4740_uart_data[] = {
+	JZ4740_UART_DATA(0),
+	JZ4740_UART_DATA(1),
+	{},
+};
+
+static struct platform_device jz4740_uart_device = {
+	.name = "serial8250",
+	.id = 0,
+	.dev = {
+		.platform_data = jz4740_uart_data,
+	},
+};
+
+void jz4740_serial_device_register(void)
+{
+	struct plat_serial8250_port *p;
+
+	for (p = jz4740_uart_data; p->flags != 0; ++p)
+		p->uartclk = jz4740_clock_bdata.ext_rate;
+
+	platform_device_register(&jz4740_uart_device);
+}
-- 
1.5.6.5
