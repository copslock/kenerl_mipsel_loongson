Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Jan 2010 21:09:02 +0100 (CET)
Received: from lo.gmane.org ([80.91.229.12]:52941 "EHLO lo.gmane.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493112Ab0AaUId (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 31 Jan 2010 21:08:33 +0100
Received: from list by lo.gmane.org with local (Exim 4.69)
        (envelope-from <sgi-linux-mips@m.gmane.org>)
        id 1Nbg5t-0006Iu-PP
        for linux-mips@linux-mips.org; Sun, 31 Jan 2010 21:08:29 +0100
Received: from chipmunk.wormnet.eu ([195.195.131.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2010 21:08:29 +0100
Received: from alex by chipmunk.wormnet.eu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2010 21:08:29 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mips@linux-mips.org
From:   Alexander Clouter <alex@digriz.org.uk>
Subject: [PATCH 3/3] MIPS: AR7 make ar7_register_devices much more durable
Date:   Sun, 31 Jan 2010 19:39:57 +0000
Message-ID: <dt2h37-ch6.ln1@chipmunk.wormnet.eu>
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: chipmunk.wormnet.eu
User-Agent: tin/1.9.3-20080506 ("Dalintober") (UNIX) (Linux/2.6.26-2-sparc64-smp (sparc64))
X-archive-position: 25793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 187

MIPS: AR7 make ar7_register_devices much more durable

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/mips/ar7/platform.c |  157 +++++++++++++++++++++++++---------------------
 1 files changed, 86 insertions(+), 71 deletions(-)

diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index 65facec..e654e73 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -529,115 +529,130 @@ static struct platform_device ar7_wdt = {
 /*****************************************************************************
  * Init
  ****************************************************************************/
-static int __init ar7_register_devices(void)
+static int __init ar7_register_uarts(void)
 {
-	u16 chip_id;
-	int res;
-	u32 *bootcr, val;
 #ifdef CONFIG_SERIAL_8250
-	static struct uart_port uart_port[2] __initdata;
+	static struct uart_port uart_port __initdata;
 	struct clk *bus_clk;
+	int res;
 
-	memset(uart_port, 0, sizeof(struct uart_port) * 2);
-
+	memset(&uart_port, 0, sizeof(struct uart_port));
+ 
 	bus_clk = clk_get(NULL, "bus");
 	if (IS_ERR(bus_clk))
 		panic("unable to get bus clk\n");
-
-	uart_port[0].type	= PORT_16550A;
-	uart_port[0].line	= 0;
-	uart_port[0].irq	= AR7_IRQ_UART0;
-	uart_port[0].uartclk	= clk_get_rate(bus_clk) / 2;
-	uart_port[0].iotype	= UPIO_MEM32;
-	uart_port[0].mapbase	= AR7_REGS_UART0;
-	uart_port[0].membase	= ioremap(uart_port[0].mapbase, 256);
-	uart_port[0].regshift	= 2;
-	res = early_serial_setup(&uart_port[0]);
+ 
+	uart_port.type		= PORT_16550A;
+	uart_port.uartclk	= clk_get_rate(bus_clk) / 2;
+	uart_port.iotype	= UPIO_MEM32;
+	uart_port.regshift	= 2;
+
+	uart_port.line		= 0;
+	uart_port.irq		= AR7_IRQ_UART0;
+	uart_port.mapbase	= AR7_REGS_UART0;
+	uart_port.membase	= ioremap(uart_port.mapbase, 256);
+
+	res = early_serial_setup(&uart_port);
 	if (res)
 		return res;
-
+ 
 	/* Only TNETD73xx have a second serial port */
 	if (ar7_has_second_uart()) {
-		uart_port[1].type	= PORT_16550A;
-		uart_port[1].line	= 1;
-		uart_port[1].irq	= AR7_IRQ_UART1;
-		uart_port[1].uartclk	= clk_get_rate(bus_clk) / 2;
-		uart_port[1].iotype	= UPIO_MEM32;
-		uart_port[1].mapbase	= UR8_REGS_UART1;
-		uart_port[1].membase 	= ioremap(uart_port[1].mapbase, 256);
-		uart_port[1].regshift	= 2;
-		res = early_serial_setup(&uart_port[1]);
+		uart_port.line		= 1;
+		uart_port.irq		= AR7_IRQ_UART1;
+		uart_port.mapbase	= UR8_REGS_UART1;
+		uart_port.membase	= ioremap(uart_port.mapbase, 256);
+
+		res = early_serial_setup(&uart_port);
 		if (res)
 			return res;
-	}
-#endif /* CONFIG_SERIAL_8250 */
+ 	}
+#endif
+
+	return 0;
+}
+
+static int __init ar7_register_devices(void)
+{
+	void __iomem *bootcr;
+	u32 val;
+	u16 chip_id;
+	int res;
+
+	res = ar7_register_uarts();
+	if (res)
+		printk(KERN_ERR "unable to setup uart(s): %d\n", res);
+
 	res = platform_device_register(&physmap_flash);
 	if (res)
-		return res;
+		printk(KERN_WARNING "unable to register physmap-flash: %d\n", res);
 
 	ar7_device_disable(vlynq_low_data.reset_bit);
 	res = platform_device_register(&vlynq_low);
 	if (res)
-		return res;
+		printk(KERN_WARNING "unable to register vlynq-low: %d\n", res);
 
 	if (ar7_has_high_vlynq()) {
 		ar7_device_disable(vlynq_high_data.reset_bit);
 		res = platform_device_register(&vlynq_high);
 		if (res)
-			return res;
+			printk(KERN_WARNING "unable to register vlynq-high: %d\n", res);
 	}
 
 	if (ar7_has_high_cpmac()) {
-		res = fixed_phy_add(PHY_POLL, cpmac_high.id, &fixed_phy_status);
-		if (res && res != -ENODEV)
-			return res;
-		cpmac_get_mac(1, cpmac_high_data.dev_addr);
-		res = platform_device_register(&cpmac_high);
-		if (res)
-			return res;
-	} else {
+		if (!res) {
+			cpmac_get_mac(1, cpmac_high_data.dev_addr);
+
+			res = platform_device_register(&cpmac_high);
+			if (res)
+				printk(KERN_WARNING "unable to register cpmac-high: %d\n", res);
+		} else
+			printk(KERN_WARNING "unable to add cpmac-high phy: %d\n", res);
+	} else
 		cpmac_low_data.phy_mask = 0xffffffff;
-	}
 
 	res = fixed_phy_add(PHY_POLL, cpmac_low.id, &fixed_phy_status);
-	if (res && res != -ENODEV)
-		return res;
-
-	cpmac_get_mac(0, cpmac_low_data.dev_addr);
-	res = platform_device_register(&cpmac_low);
-	if (res)
-		return res;
+	if (!res) {
+		cpmac_get_mac(0, cpmac_low_data.dev_addr);
+		res = platform_device_register(&cpmac_low);
+		if (res)
+			printk(KERN_WARNING "unable to register cpmac-low: %d\n", res);
+	} else
+		printk(KERN_WARNING "unable to add cpmac-low phy: %d\n", res);
 
 	detect_leds();
 	res = platform_device_register(&ar7_gpio_leds);
 	if (res)
-		return res;
+		printk(KERN_WARNING "unable to register leds: %d\n", res);
 
 	res = platform_device_register(&ar7_udc);
-
-	chip_id = ar7_chip_id();
-	switch (chip_id) {
-	case AR7_CHIP_7100:
-	case AR7_CHIP_7200:
-		ar7_wdt_res.start = AR7_REGS_WDT;
-		break;
-	case AR7_CHIP_7300:
-		ar7_wdt_res.start = UR8_REGS_WDT;
-		break;
-	default:
-		break;
-	}
-
-	ar7_wdt_res.end = ar7_wdt_res.start + 0x20;
-
-	bootcr = (u32 *)ioremap_nocache(AR7_REGS_DCL, 4);
-	val = *bootcr;
-	iounmap(bootcr);
+	if (res)
+		printk(KERN_WARNING "unable to register usb slave: %d\n", res);
 
 	/* Register watchdog only if enabled in hardware */
-	if (val & AR7_WDT_HW_ENA)
-		res = platform_device_register(&ar7_wdt);
+	bootcr = ioremap_nocache(AR7_REGS_DCL, 4);
+	val = readl(bootcr);
+ 	iounmap(bootcr);
+	if (val & AR7_WDT_HW_ENA) {
+		chip_id = ar7_chip_id();
+		switch (chip_id) {
+		case AR7_CHIP_7100:
+		case AR7_CHIP_7200:
+			ar7_wdt_res.start = AR7_REGS_WDT;
+			break;
+		case AR7_CHIP_7300:
+			ar7_wdt_res.start = UR8_REGS_WDT;
+			break;
+		default:
+			break;
+		}
+
+		ar7_wdt_res.end = ar7_wdt_res.start + 0x20;
+ 		res = platform_device_register(&ar7_wdt);
+		if (res)
+			printk(KERN_WARNING "unable to register watchdog: %d\n", res);
+	}
 
-	return res;
+	return 0;
 }
 arch_initcall(ar7_register_devices);
-- 
1.6.6
