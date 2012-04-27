Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Apr 2012 03:23:49 +0200 (CEST)
Received: from mail-pz0-f48.google.com ([209.85.210.48]:45091 "EHLO
        mail-pz0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903724Ab2D0BUo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Apr 2012 03:20:44 +0200
Received: by dakb39 with SMTP id b39so245350dak.35
        for <multiple recipients>; Thu, 26 Apr 2012 18:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=KFeWPE+Mqf9pdFaaS+b8nZFcZLlTXB9VE4JbQf/N0nU=;
        b=YsSr1edGLF7JDy1ypjDsD2IDZmFTXe4AVyhFsCnP7+FDDjxje5pRA6NILpD1ow2IwS
         Bj7hP1Yo2JXBJo5dyr7GeyVHxFQrS0jl3BFwQ7a6V3nhwki+ZrkyMztHzl77WDLLCjZG
         n6nJGcNQmoPn3K9BtEht7phNcfcLY/ms8mPqE827W0MT+8+GI1pTXTAVOgUolCPPoyqf
         fJc4naKMR0bwLcppYRcNXzujBHwWRGwk7PcQES+wetGbQGT0ZAg15Hb/u7hNW74xmNL3
         PMQHr+OxNjGWoBtTU3kHbh1AoxpLueC73VIAB5p0zcC11M0YPHkFi0mlsDSW5gfMfxfy
         W/2g==
Received: by 10.68.221.202 with SMTP id qg10mr11656078pbc.132.1335489638018;
        Thu, 26 Apr 2012 18:20:38 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id tv5sm1017622pbc.35.2012.04.26.18.20.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Apr 2012 18:20:35 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3R1KXL4027082;
        Thu, 26 Apr 2012 18:20:33 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3R1KXhS027081;
        Thu, 26 Apr 2012 18:20:33 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v2 5/5] MIPS: Octeon: Use device tree to register serial ports.
Date:   Thu, 26 Apr 2012 18:20:30 -0700
Message-Id: <1335489630-27017-6-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1335489630-27017-1-git-send-email-ddaney.cavm@gmail.com>
References: <1335489630-27017-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

Switch to using the device tree to register serial ports.

Add all the ports with compatible = "cavium,octeon-3860-uart".  Octeon serial
ports have their own device type, required port flags, and I/O
functions, so using of_serial.c is not indicated.

We need to do this as late_initcall, as the 8250 driver must be
initialized before we add any ports.  8250 initialization is done at
device_initcall time.

The OCTEON_IRQ_UART{0,1,2} symbols are removed as they are now unused
and interfere with irq_domain used by the device tree code.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/octeon-irq.c |    4 -
 arch/mips/cavium-octeon/serial.c     |  134 +++++++++++++--------------------
 2 files changed, 53 insertions(+), 85 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index a729728..f3d27ec 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -1175,9 +1175,6 @@ static void __init octeon_irq_init_ciu(void)
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MBOX0, 0, 32, chip_mbox, handle_percpu_irq);
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MBOX1, 0, 33, chip_mbox, handle_percpu_irq);
 
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_UART0, 0, 34, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_UART1, 0, 35, chip, handle_level_irq);
-
 	for (i = 0; i < 4; i++)
 		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_PCI_INT0, 0, i + 36, chip, handle_level_irq);
 	for (i = 0; i < 4; i++)
@@ -1194,7 +1191,6 @@ static void __init octeon_irq_init_ciu(void)
 	for (i = 0; i < 16; i++)
 		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_WDOG0, 1, i + 0, chip_wd, handle_level_irq);
 
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_UART2, 1, 16, chip, handle_level_irq);
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_USB1, 1, 17, chip, handle_level_irq);
 
 	gpio_node = of_find_compatible_node(NULL, NULL, "cavium,octeon-3860-gpio");
diff --git a/arch/mips/cavium-octeon/serial.c b/arch/mips/cavium-octeon/serial.c
index 057f0ae..138b221 100644
--- a/arch/mips/cavium-octeon/serial.c
+++ b/arch/mips/cavium-octeon/serial.c
@@ -43,95 +43,67 @@ void octeon_serial_out(struct uart_port *up, int offset, int value)
 	cvmx_write_csr((uint64_t)(up->membase + (offset << 3)), (u8)value);
 }
 
-/*
- * Allocated in .bss, so it is all zeroed.
- */
-#define OCTEON_MAX_UARTS 3
-static struct plat_serial8250_port octeon_uart8250_data[OCTEON_MAX_UARTS + 1];
-static struct platform_device octeon_uart8250_device = {
-	.name			= "serial8250",
-	.id			= PLAT8250_DEV_PLATFORM,
-	.dev			= {
-		.platform_data	= octeon_uart8250_data,
-	},
-};
-
-static void __init octeon_uart_set_common(struct plat_serial8250_port *p)
+static int __devinit octeon_serial_probe(struct platform_device *pdev)
 {
-	p->flags = ASYNC_SKIP_TEST | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
-	p->type = PORT_OCTEON;
-	p->iotype = UPIO_MEM;
-	p->regshift = 3;	/* I/O addresses are every 8 bytes */
+	int irq, res;
+	struct resource *res_mem;
+	struct uart_port port;
+
+	/* All adaptors have an irq.  */
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	memset(&port, 0, sizeof(port));
+
+	port.flags = ASYNC_SKIP_TEST | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
+	port.type = PORT_OCTEON;
+	port.iotype = UPIO_MEM;
+	port.regshift = 3;
+	port.dev = &pdev->dev;
+
 	if (octeon_is_simulation())
 		/* Make simulator output fast*/
-		p->uartclk = 115200 * 16;
+		port.uartclk = 115200 * 16;
 	else
-		p->uartclk = octeon_get_io_clock_rate();
-	p->serial_in = octeon_serial_in;
-	p->serial_out = octeon_serial_out;
-}
+		port.uartclk = octeon_get_io_clock_rate();
 
-static int __init octeon_serial_init(void)
-{
-	int enable_uart0;
-	int enable_uart1;
-	int enable_uart2;
-	struct plat_serial8250_port *p;
-
-#ifdef CONFIG_CAVIUM_OCTEON_2ND_KERNEL
-	/*
-	 * If we are configured to run as the second of two kernels,
-	 * disable uart0 and enable uart1. Uart0 is owned by the first
-	 * kernel
-	 */
-	enable_uart0 = 0;
-	enable_uart1 = 1;
-#else
-	/*
-	 * We are configured for the first kernel. We'll enable uart0
-	 * if the bootloader told us to use 0, otherwise will enable
-	 * uart 1.
-	 */
-	enable_uart0 = (octeon_get_boot_uart() == 0);
-	enable_uart1 = (octeon_get_boot_uart() == 1);
-#ifdef CONFIG_KGDB
-	enable_uart1 = 1;
-#endif
-#endif
-
-	/* Right now CN52XX is the only chip with a third uart */
-	enable_uart2 = OCTEON_IS_MODEL(OCTEON_CN52XX);
-
-	p = octeon_uart8250_data;
-	if (enable_uart0) {
-		/* Add a ttyS device for hardware uart 0 */
-		octeon_uart_set_common(p);
-		p->membase = (void *) CVMX_MIO_UARTX_RBR(0);
-		p->mapbase = CVMX_MIO_UARTX_RBR(0) & ((1ull << 49) - 1);
-		p->irq = OCTEON_IRQ_UART0;
-		p++;
-	}
+	port.serial_in = octeon_serial_in;
+	port.serial_out = octeon_serial_out;
+	port.irq = irq;
 
-	if (enable_uart1) {
-		/* Add a ttyS device for hardware uart 1 */
-		octeon_uart_set_common(p);
-		p->membase = (void *) CVMX_MIO_UARTX_RBR(1);
-		p->mapbase = CVMX_MIO_UARTX_RBR(1) & ((1ull << 49) - 1);
-		p->irq = OCTEON_IRQ_UART1;
-		p++;
-	}
-	if (enable_uart2) {
-		/* Add a ttyS device for hardware uart 2 */
-		octeon_uart_set_common(p);
-		p->membase = (void *) CVMX_MIO_UART2_RBR;
-		p->mapbase = CVMX_MIO_UART2_RBR & ((1ull << 49) - 1);
-		p->irq = OCTEON_IRQ_UART2;
-		p++;
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res_mem == NULL) {
+		dev_err(&pdev->dev, "found no memory resource\n");
+		return -ENXIO;
 	}
+	port.mapbase = res_mem->start;
+	port.membase = ioremap(res_mem->start, resource_size(res_mem));
 
-	BUG_ON(p > &octeon_uart8250_data[OCTEON_MAX_UARTS]);
+	res = serial8250_register_port(&port);
 
-	return platform_device_register(&octeon_uart8250_device);
+	return res >= 0 ? 0 : res;
 }
 
-device_initcall(octeon_serial_init);
+static struct of_device_id octeon_serial_match[] = {
+	{
+		.compatible = "cavium,octeon-3860-uart",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, octeon_serial_match);
+
+static struct platform_driver octeon_serial_driver = {
+	.probe		= octeon_serial_probe,
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "octeon_serial",
+		.of_match_table = octeon_serial_match,
+	},
+};
+
+static int __init octeon_serial_init(void)
+{
+	return platform_driver_register(&octeon_serial_driver);
+}
+late_initcall(octeon_serial_init);
-- 
1.7.2.3
