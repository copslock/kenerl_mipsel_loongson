Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2009 14:38:54 +0000 (GMT)
Received: from orbit.nwl.cc ([91.121.169.95]:24014 "EHLO mail.nwl.cc")
	by ftp.linux-mips.org with ESMTP id S21365139AbZAOOiv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Jan 2009 14:38:51 +0000
Received: from base (localhost [127.0.0.1])
	by mail.nwl.cc (Postfix) with ESMTP id 5F0CF4043837;
	Thu, 15 Jan 2009 15:38:46 +0100 (CET)
From:	Phil Sutter <n0-1@freewrt.org>
To:	Linux-Mips List <linux-mips@linux-mips.org>
Cc:	florian@openwrt.org, ralf@linux-mips.org, ddaney@caviumnetworks.com
Subject: [PATCH] MIPS: rb532: detect uart type, add platform device
Date:	Thu, 15 Jan 2009 15:38:38 +0100
X-Mailer: git-send-email 1.5.6.4
Message-Id: <20090115143846.5F0CF4043837@mail.nwl.cc>
Return-Path: <n0-1@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

Auto-detection works just fine, so use it instead of specifying the type
manually. Also define a platform device for the uart, as suggested by
David Daney.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 arch/mips/rb532/devices.c |   26 ++++++++++++++++++++++++++
 arch/mips/rb532/serial.c  |    2 +-
 2 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
index c1c2918..9b6b744 100644
--- a/arch/mips/rb532/devices.c
+++ b/arch/mips/rb532/devices.c
@@ -24,6 +24,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
+#include <linux/serial_8250.h>
 
 #include <asm/bootinfo.h>
 
@@ -39,6 +40,8 @@
 #define ETH0_RX_DMA_ADDR  (DMA0_BASE_ADDR + 0 * DMA_CHAN_OFFSET)
 #define ETH0_TX_DMA_ADDR  (DMA0_BASE_ADDR + 1 * DMA_CHAN_OFFSET)
 
+extern unsigned int idt_cpu_freq;
+
 static struct resource korina_dev0_res[] = {
 	{
 		.name = "korina_regs",
@@ -214,12 +217,32 @@ static struct platform_device rb532_wdt = {
 	.num_resources	= ARRAY_SIZE(rb532_wdt_res),
 };
 
+static struct plat_serial8250_port rb532_uart_res[] = {
+	{
+		.membase	= (char *)KSEG1ADDR(REGBASE + UART0BASE),
+		.irq		= UART0_IRQ,
+		.regshift	= 2,
+		.iotype		= UPIO_MEM,
+		.flags		= UPF_BOOT_AUTOCONF,
+	},
+	{
+		.flags		= 0,
+	}
+};
+
+static struct platform_device rb532_uart = {
+	.name              = "serial8250",
+	.id                = PLAT8250_DEV_PLATFORM,
+	.dev.platform_data = &rb532_uart_res,
+};
+
 static struct platform_device *rb532_devs[] = {
 	&korina_dev0,
 	&nand_slot0,
 	&cf_slot0,
 	&rb532_led,
 	&rb532_button,
+	&rb532_uart,
 	&rb532_wdt
 };
 
@@ -294,6 +317,9 @@ static int __init plat_setup_devices(void)
 	/* Initialise the NAND device */
 	rb532_nand_setup();
 
+	/* set the uart clock to the current cpu frequency */
+	rb532_uart_res[0].uartclk = idt_cpu_freq;
+
 	return platform_add_devices(rb532_devs, ARRAY_SIZE(rb532_devs));
 }
 
diff --git a/arch/mips/rb532/serial.c b/arch/mips/rb532/serial.c
index 3e0d7ec..00ed19f 100644
--- a/arch/mips/rb532/serial.c
+++ b/arch/mips/rb532/serial.c
@@ -36,7 +36,7 @@
 extern unsigned int idt_cpu_freq;
 
 static struct uart_port rb532_uart = {
-	.type = PORT_16550A,
+	.flags = UPF_BOOT_AUTOCONF,
 	.line = 0,
 	.irq = UART0_IRQ,
 	.iotype = UPIO_MEM,
-- 
1.5.6.4
