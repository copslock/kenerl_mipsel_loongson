Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2012 01:31:00 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:44113 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903747Ab2FFX2r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2012 01:28:47 +0200
Received: by pbbrq13 with SMTP id rq13so206414pbb.36
        for <multiple recipients>; Wed, 06 Jun 2012 16:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SZZVlLSj60x8uq0mAGO2woz48nxDlwTMVq722ZLXCW4=;
        b=wdUseToPCptFqetHrzq549bGT2u0lOlyTHh6+gl1clB94JB2mMyL13ZjKMa+XIf3HJ
         2pu+Kzfc7gKK7FjdoBd7ONJQWVu/WHsc9JQD4/2MMQRym6BcVCzTY+bQJrfHaI2XYhu+
         z47/kZQCi0Qnn3lUWU8kSpeXO2YEOTUrd84WbO3zgmmYaGbTXpBEha0SHJk1nQqnKoT/
         e7YBDA215l+PFNdjlf7qpvrdl3s8EyHYOWuTJKQMzbjkIE3ORo5i7rNjqHt3PCWvBD4o
         lb+9tyvthHq3/gjuLzlFKR0cyErX4BqM5I/Npia92Rnwnx3UOf9tqwpAFMLRBLo4f2h1
         47WA==
Received: by 10.68.222.165 with SMTP id qn5mr2974849pbc.14.1339025321132;
        Wed, 06 Jun 2012 16:28:41 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id hb5sm1887852pbc.58.2012.06.06.16.28.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 16:28:39 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q56NSbX6024274;
        Wed, 6 Jun 2012 16:28:37 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q56NSbMO024273;
        Wed, 6 Jun 2012 16:28:37 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v3 5/5] MIPS: Octeon: Use device tree to register serial ports.
Date:   Wed,  6 Jun 2012 16:28:34 -0700
Message-Id: <1339025314-24216-6-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1339025314-24216-1-git-send-email-ddaney.cavm@gmail.com>
References: <1339025314-24216-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/mips/cavium-octeon/octeon-irq.c |    4 -
 arch/mips/cavium-octeon/serial.c     |  134 +++++++++++++--------------------
 2 files changed, 53 insertions(+), 85 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 5fb76aa..7fb1f22 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -1184,9 +1184,6 @@ static void __init octeon_irq_init_ciu(void)
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MBOX0, 0, 32, chip_mbox, handle_percpu_irq);
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MBOX1, 0, 33, chip_mbox, handle_percpu_irq);
 
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_UART0, 0, 34, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_UART1, 0, 35, chip, handle_level_irq);
-
 	for (i = 0; i < 4; i++)
 		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_PCI_INT0, 0, i + 36, chip, handle_level_irq);
 	for (i = 0; i < 4; i++)
@@ -1203,7 +1200,6 @@ static void __init octeon_irq_init_ciu(void)
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
