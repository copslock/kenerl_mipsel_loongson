Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2006 17:22:32 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:18068 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S20038572AbWHUQWa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 21 Aug 2006 17:22:30 +0100
Received: (qmail 9402 invoked from network); 21 Aug 2006 16:22:32 -0000
Received: from laja.dev.rtsoft.ru.dev.rtsoft.ru (HELO dev.rtsoft.ru.) (192.168.1.205)
  by mail.dev.rtsoft.ru with SMTP; 21 Aug 2006 16:22:32 -0000
Date:	Mon, 21 Aug 2006 20:22:21 +0400
From:	Vitaly Wool <vitalywool@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH/RFC] fix compilation breakage for PNX8550
Message-Id: <20060821202221.591b9e9a.vitalywool@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <vitalywool@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vitalywool@gmail.com
Precedence: bulk
X-list: linux-mips

Hello folks,

taken into account Sergey's comments and my recent rework of PNX8550's UART/console driver, I'm posting now the (hopefully) final version of the patch that revives PNX8550. Please note that it should be applied together with the UART patch I've sent recently to LKML (and which seems to be adopted by rmk ;) ).
So, now my PNX8550 is up and running happily. The patch is inlined below.

This patch fixes the compilation errors on PNX8550 and hard-to-track
bug in interrupt handling.
It also corresponds to the latest changes in PNX8550 serial driver.

 Signed-off-by: Vitaly Wool <vitalywool@gmail.com>

 arch/mips/Kconfig                           |    2 --
 arch/mips/philips/pnx8550/common/int.c      |    2 +-
 arch/mips/philips/pnx8550/common/platform.c |   16 ++++++----------
 arch/mips/philips/pnx8550/common/prom.c     |    4 ++--
 arch/mips/philips/pnx8550/common/setup.c    |    6 +++---
 include/asm-mips/mach-pnx8550/uart.h        |   14 ++++++++++++++
 6 files changed, 26 insertions(+), 18 deletions(-)
      
Index: powerpc.git/arch/mips/Kconfig
===================================================================
--- powerpc.git.orig/arch/mips/Kconfig
+++ powerpc.git/arch/mips/Kconfig
@@ -493,13 +493,11 @@ config MIPS_XXS1500
 
 config PNX8550_V2PCI
 	bool "Philips PNX8550 based Viper2-PCI board"
-	depends on BROKEN
 	select PNX8550
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config PNX8550_JBS
 	bool "Philips PNX8550 based JBS board"
-	depends on BROKEN
 	select PNX8550
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
Index: powerpc.git/arch/mips/philips/pnx8550/common/setup.c
===================================================================
--- powerpc.git.orig/arch/mips/philips/pnx8550/common/setup.c
+++ powerpc.git/arch/mips/philips/pnx8550/common/setup.c
@@ -24,7 +24,7 @@
 #include <linux/mm.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-#include <linux/serial_ip3106.h>
+#include <linux/serial_pnx8xxx.h>
 #include <linux/pm.h>
 
 #include <asm/cpu.h>
@@ -56,7 +56,7 @@ extern char *prom_getcmdline(void);
 
 struct resource standard_io_resources[] = {
 	{
-		.start	= .0x00,
+		.start	= 0x00,
 		.end	= 0x1f,
 		.name	= "dma1",
 		.flags	= IORESOURCE_BUSY
@@ -144,7 +144,7 @@ void __init plat_mem_setup(void)
 		/* We must initialize the UART (console) before prom_printf */
 		/* Set LCR to 8-bit and BAUD to 38400 (no 5)                */
 		ip3106_lcr(UART_BASE, pnx8550_console_port) =
-			IP3106_UART_LCR_8BIT;
+			PNX8XXX_UART_LCR_8BIT;
 		ip3106_baud(UART_BASE, pnx8550_console_port) = 5;
 	}
 
Index: powerpc.git/arch/mips/philips/pnx8550/common/int.c
===================================================================
--- powerpc.git.orig/arch/mips/philips/pnx8550/common/int.c
+++ powerpc.git/arch/mips/philips/pnx8550/common/int.c
@@ -90,7 +90,7 @@ asmlinkage void plat_irq_dispatch(struct
 	unsigned int pending = read_c0_status() & read_c0_cause();
 
 	if (pending & STATUSF_IP2)
-		do_IRQ(2, regs);
+		hw0_irqdispatch(2, regs);
 	else if (pending & STATUSF_IP7) {
 		if (read_c0_config7() & 0x01c0)
 			timer_irqdispatch(7, regs);
Index: powerpc.git/arch/mips/philips/pnx8550/common/platform.c
===================================================================
--- powerpc.git.orig/arch/mips/philips/pnx8550/common/platform.c
+++ powerpc.git/arch/mips/philips/pnx8550/common/platform.c
@@ -17,15 +17,13 @@
 #include <linux/init.h>
 #include <linux/resource.h>
 #include <linux/serial.h>
-#include <linux/serial_ip3106.h>
+#include <linux/serial_pnx8xxx.h>
 #include <linux/platform_device.h>
 
 #include <int.h>
 #include <usb.h>
 #include <uart.h>
 
-extern struct uart_ops ip3106_pops;
-
 static struct resource pnx8550_usb_ohci_resources[] = {
 	[0] = {
 		.start		= PNX8550_USB_OHCI_OP_BASE,
@@ -63,31 +61,29 @@ static struct resource pnx8550_uart_reso
 	},
 };
 
-struct ip3106_port ip3106_ports[] = {
+struct pnx8xxx_port pnx8xxx_ports[] = {
 	[0] = {
 		.port   = {
-			.type		= PORT_IP3106,
+			.type		= PORT_PNX8XXX,
 			.iotype		= UPIO_MEM,
 			.membase	= (void __iomem *)PNX8550_UART_PORT0,
 			.mapbase	= PNX8550_UART_PORT0,
 			.irq		= PNX8550_UART_INT(0),
 			.uartclk	= 3692300,
 			.fifosize	= 16,
-			.ops		= &ip3106_pops,
 			.flags		= UPF_BOOT_AUTOCONF,
 			.line		= 0,
 		},
 	},
 	[1] = {
 		.port   = {
-			.type		= PORT_IP3106,
+			.type		= PORT_PNX8XXX,
 			.iotype		= UPIO_MEM,
 			.membase	= (void __iomem *)PNX8550_UART_PORT1,
 			.mapbase	= PNX8550_UART_PORT1,
 			.irq		= PNX8550_UART_INT(1),
 			.uartclk	= 3692300,
 			.fifosize	= 16,
-			.ops		= &ip3106_pops,
 			.flags		= UPF_BOOT_AUTOCONF,
 			.line		= 1,
 		},
@@ -111,12 +107,12 @@ static struct platform_device pnx8550_us
 };
 
 static struct platform_device pnx8550_uart_device = {
-	.name		= "ip3106-uart",
+	.name		= "pnx8xxx-uart",
 	.id		= -1,
 	.dev = {
 		.dma_mask		= &uart_dmamask,
 		.coherent_dma_mask	= 0xffffffff,
-		.platform_data = ip3106_ports,
+		.platform_data = pnx8xxx_ports,
 	},
 	.num_resources	= ARRAY_SIZE(pnx8550_uart_resources),
 	.resource	= pnx8550_uart_resources,
Index: powerpc.git/include/asm-mips/mach-pnx8550/uart.h
===================================================================
--- powerpc.git.orig/include/asm-mips/mach-pnx8550/uart.h
+++ powerpc.git/include/asm-mips/mach-pnx8550/uart.h
@@ -13,4 +13,18 @@
 #define PNX8550_UART_INT(x)		(PNX8550_INT_GIC_MIN+19+x)
 #define IRQ_TO_UART(x)			(x-PNX8550_INT_GIC_MIN-19)
 
+/* early macros needed for prom/kgdb */
+
+#define ip3106_lcr(base,port)    *(volatile u32 *)(base+(port*0x1000) + 0x000)
+#define ip3106_mcr(base, port)   *(volatile u32 *)(base+(port*0x1000) + 0x004)
+#define ip3106_baud(base, port)  *(volatile u32 *)(base+(port*0x1000) + 0x008)
+#define ip3106_cfg(base, port)   *(volatile u32 *)(base+(port*0x1000) + 0x00C)
+#define ip3106_fifo(base, port)	 *(volatile u32 *)(base+(port*0x1000) + 0x028)
+#define ip3106_istat(base, port) *(volatile u32 *)(base+(port*0x1000) + 0xFE0)
+#define ip3106_ien(base, port)   *(volatile u32 *)(base+(port*0x1000) + 0xFE4)
+#define ip3106_iclr(base, port)  *(volatile u32 *)(base+(port*0x1000) + 0xFE8)
+#define ip3106_iset(base, port)  *(volatile u32 *)(base+(port*0x1000) + 0xFEC)
+#define ip3106_pd(base, port)    *(volatile u32 *)(base+(port*0x1000) + 0xFF4)
+#define ip3106_mid(base, port)   *(volatile u32 *)(base+(port*0x1000) + 0xFFC)
+
 #endif
Index: powerpc.git/arch/mips/philips/pnx8550/common/prom.c
===================================================================
--- powerpc.git.orig/arch/mips/philips/pnx8550/common/prom.c
+++ powerpc.git/arch/mips/philips/pnx8550/common/prom.c
@@ -13,7 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/string.h>
-#include <linux/serial_ip3106.h>
+#include <linux/serial_pnx8xxx.h>
 
 #include <asm/bootinfo.h>
 #include <uart.h>
@@ -126,7 +126,7 @@ void prom_putchar(char c)
 {
 	if (pnx8550_console_port != -1) {
 		/* Wait until FIFO not full */
-		while( ((ip3106_fifo(UART_BASE, pnx8550_console_port) & IP3106_UART_FIFO_TXFIFO) >> 16) >= 16)
+		while( ((ip3106_fifo(UART_BASE, pnx8550_console_port) & PNX8XXX_UART_FIFO_TXFIFO) >> 16) >= 16)
 			;
 		/* Send one char */
 		ip3106_fifo(UART_BASE, pnx8550_console_port) = c;
