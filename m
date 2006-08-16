Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Aug 2006 14:29:06 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:61074 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S20037523AbWHPN3E (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Aug 2006 14:29:04 +0100
Received: (qmail 7472 invoked from network); 16 Aug 2006 13:29:00 -0000
Received: from laja.dev.rtsoft.ru.dev.rtsoft.ru (HELO dev.rtsoft.ru.) (192.168.1.205)
  by mail.dev.rtsoft.ru with SMTP; 16 Aug 2006 13:29:00 -0000
Date:	Wed, 16 Aug 2006 17:29:06 +0400
From:	Vitaly Wool <vitalywool@gmail.com>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] fix compilation breakage for PNX8550
Message-Id: <20060816172906.5a2cafb1.vitalywool@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <vitalywool@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vitalywool@gmail.com
Precedence: bulk
X-list: linux-mips

Hello Ralf,

finally I've got some time to poke around PNX8550 compilation issue I've signalled some time ago. 
This patch fixes the compilation errors on PNX8550. It also starts migration to using standard 8250 serial driver iso the custom driver for IP3106 Philips UART.

 Signed-off-by: Vitaly Wool <vitalywool@gmail.com>

 arch/mips/Kconfig                           |    2 
 arch/mips/philips/pnx8550/common/Makefile   |    1 
 arch/mips/philips/pnx8550/common/gdb_hook.c |  109 ----------------------------
 arch/mips/philips/pnx8550/common/platform.c |   80 +++++---------------
 arch/mips/philips/pnx8550/common/prom.c     |    7 -
 arch/mips/philips/pnx8550/common/setup.c    |   19 ----
 include/asm-mips/mach-pnx8550/uart.h        |    6 +
 7 files changed, 32 insertions(+), 192 deletions(-)

Index: linux-2.6.git/arch/mips/Kconfig
===================================================================
--- linux-2.6.git.orig/arch/mips/Kconfig
+++ linux-2.6.git/arch/mips/Kconfig
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
 
Index: linux-2.6.git/arch/mips/philips/pnx8550/common/platform.c
===================================================================
--- linux-2.6.git.orig/arch/mips/philips/pnx8550/common/platform.c
+++ linux-2.6.git/arch/mips/philips/pnx8550/common/platform.c
@@ -17,15 +17,13 @@
 #include <linux/init.h>
 #include <linux/resource.h>
 #include <linux/serial.h>
-#include <linux/serial_ip3106.h>
+#include <linux/serial_8250.h>
 #include <linux/platform_device.h>
 
 #include <int.h>
 #include <usb.h>
 #include <uart.h>
 
-extern struct uart_ops ip3106_pops;
-
 static struct resource pnx8550_usb_ohci_resources[] = {
 	[0] = {
 		.start		= PNX8550_USB_OHCI_OP_BASE,
@@ -40,58 +38,24 @@ static struct resource pnx8550_usb_ohci_
 	},
 };
 
-static struct resource pnx8550_uart_resources[] = {
-	[0] = {
-		.start		= PNX8550_UART_PORT0,
-		.end		= PNX8550_UART_PORT0 + 0xfff,
-		.flags		= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= PNX8550_UART_INT(0),
-		.end		= PNX8550_UART_INT(0),
-		.flags		= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start		= PNX8550_UART_PORT1,
-		.end		= PNX8550_UART_PORT1 + 0xfff,
-		.flags		= IORESOURCE_MEM,
-	},
-	[3] = {
-		.start		= PNX8550_UART_INT(1),
-		.end		= PNX8550_UART_INT(1),
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-struct ip3106_port ip3106_ports[] = {
-	[0] = {
-		.port   = {
-			.type		= PORT_IP3106,
-			.iotype		= UPIO_MEM,
-			.membase	= (void __iomem *)PNX8550_UART_PORT0,
-			.mapbase	= PNX8550_UART_PORT0,
-			.irq		= PNX8550_UART_INT(0),
-			.uartclk	= 3692300,
-			.fifosize	= 16,
-			.ops		= &ip3106_pops,
-			.flags		= UPF_BOOT_AUTOCONF,
-			.line		= 0,
-		},
-	},
-	[1] = {
-		.port   = {
-			.type		= PORT_IP3106,
-			.iotype		= UPIO_MEM,
-			.membase	= (void __iomem *)PNX8550_UART_PORT1,
-			.mapbase	= PNX8550_UART_PORT1,
-			.irq		= PNX8550_UART_INT(1),
-			.uartclk	= 3692300,
-			.fifosize	= 16,
-			.ops		= &ip3106_pops,
-			.flags		= UPF_BOOT_AUTOCONF,
-			.line		= 1,
-		},
+static struct plat_serial8250_port platform_serial_ports[] = {
+	{
+		.iotype		= UPIO_MEM,
+		.membase	= (void *)__iomem(PNX8550_UART_PORT0),
+		.mapbase	= PNX8550_UART_PORT0,
+		.irq		= PNX8550_UART_INT(0),
+		.uartclk	= 3692300,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+	},
+	{
+		.iotype		= UPIO_MEM,
+		.membase	= (void *)__iomem(PNX8550_UART_PORT1),
+		.mapbase	= PNX8550_UART_PORT1,
+		.irq		= PNX8550_UART_INT(1),
+		.uartclk	= 3692300,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
 	},
+	{ }
 };
 
 /* The dmamask must be set for OHCI to work */
@@ -111,15 +75,13 @@ static struct platform_device pnx8550_us
 };
 
 static struct platform_device pnx8550_uart_device = {
-	.name		= "ip3106-uart",
-	.id		= -1,
+	.name		= "serial8250",
+	.id		= PLAT8250_DEV_PLATFORM,
 	.dev = {
 		.dma_mask		= &uart_dmamask,
 		.coherent_dma_mask	= 0xffffffff,
-		.platform_data = ip3106_ports,
+		.platform_data = &platform_serial_ports,
 	},
-	.num_resources	= ARRAY_SIZE(pnx8550_uart_resources),
-	.resource	= pnx8550_uart_resources,
 };
 
 static struct platform_device *pnx8550_platform_devices[] __initdata = {
Index: linux-2.6.git/arch/mips/philips/pnx8550/common/prom.c
===================================================================
--- linux-2.6.git.orig/arch/mips/philips/pnx8550/common/prom.c
+++ linux-2.6.git/arch/mips/philips/pnx8550/common/prom.c
@@ -13,7 +13,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/string.h>
-#include <linux/serial_ip3106.h>
 
 #include <asm/bootinfo.h>
 #include <uart.h>
@@ -126,13 +125,11 @@ void prom_putchar(char c)
 {
 	if (pnx8550_console_port != -1) {
 		/* Wait until FIFO not full */
-		while( ((ip3106_fifo(UART_BASE, pnx8550_console_port) & IP3106_UART_FIFO_TXFIFO) >> 16) >= 16)
-			;
+		while( ((IP3106_FIFO(UART_BASE, pnx8550_console_port) & 0x001F0000) >> 16) >= 16);
 		/* Send one char */
-		ip3106_fifo(UART_BASE, pnx8550_console_port) = c;
+		IP3106_FIFO(UART_BASE, pnx8550_console_port) = c;
 	}
 }
-
 EXPORT_SYMBOL(prom_getcmdline);
 EXPORT_SYMBOL(get_ethernet_addr);
 EXPORT_SYMBOL(str2eaddr);
Index: linux-2.6.git/arch/mips/philips/pnx8550/common/setup.c
===================================================================
--- linux-2.6.git.orig/arch/mips/philips/pnx8550/common/setup.c
+++ linux-2.6.git/arch/mips/philips/pnx8550/common/setup.c
@@ -24,7 +24,6 @@
 #include <linux/mm.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-#include <linux/serial_ip3106.h>
 #include <linux/pm.h>
 
 #include <asm/cpu.h>
@@ -56,7 +55,7 @@ extern char *prom_getcmdline(void);
 
 struct resource standard_io_resources[] = {
 	{
-		.start	= .0x00,
+		.start	= 0x00,
 		.end	= 0x1f,
 		.name	= "dma1",
 		.flags	= IORESOURCE_BUSY
@@ -143,21 +142,9 @@ void __init plat_mem_setup(void)
 
 		/* We must initialize the UART (console) before prom_printf */
 		/* Set LCR to 8-bit and BAUD to 38400 (no 5)                */
-		ip3106_lcr(UART_BASE, pnx8550_console_port) =
-			IP3106_UART_LCR_8BIT;
-		ip3106_baud(UART_BASE, pnx8550_console_port) = 5;
+		IP3106_LCR(UART_BASE, pnx8550_console_port) = 0x01000000;
+		IP3106_BAUD(UART_BASE, pnx8550_console_port) = 5;
 	}
 
-#ifdef CONFIG_KGDB
-	argptr = prom_getcmdline();
-	if ((argptr = strstr(argptr, "kgdb=ttyS")) != NULL) {
-		int line;
-		argptr += strlen("kgdb=ttyS");
-		line = *argptr == '0' ? 0 : 1;
-		rs_kgdb_hook(line);
-		prom_printf("KGDB: Using ttyS%i for session, "
-				"please connect your debugger\n", line ? 1 : 0);
-	}
-#endif
 	return;
 }
Index: linux-2.6.git/arch/mips/philips/pnx8550/common/Makefile
===================================================================
--- linux-2.6.git.orig/arch/mips/philips/pnx8550/common/Makefile
+++ linux-2.6.git/arch/mips/philips/pnx8550/common/Makefile
@@ -24,4 +24,3 @@
 
 obj-y := setup.o prom.o int.o reset.o time.o proc.o platform.o
 obj-$(CONFIG_PCI) += pci.o
-obj-$(CONFIG_KGDB) += gdb_hook.o
Index: linux-2.6.git/arch/mips/philips/pnx8550/common/gdb_hook.c
===================================================================
--- linux-2.6.git.orig/arch/mips/philips/pnx8550/common/gdb_hook.c
+++ /dev/null
@@ -1,109 +0,0 @@
-/*
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
- *
- * ########################################################################
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * ########################################################################
- *
- * This is the interface to the remote debugger stub.
- *
- */
-#include <linux/types.h>
-#include <linux/serial.h>
-#include <linux/serialP.h>
-#include <linux/serial_reg.h>
-#include <linux/serial_ip3106.h>
-
-#include <asm/serial.h>
-#include <asm/io.h>
-
-#include <uart.h>
-
-static struct serial_state rs_table[IP3106_NR_PORTS] = {
-};
-static struct async_struct kdb_port_info = {0};
-
-void rs_kgdb_hook(int tty_no)
-{
-	struct serial_state *ser = &rs_table[tty_no];
-
-	kdb_port_info.state = ser;
-	kdb_port_info.magic = SERIAL_MAGIC;
-	kdb_port_info.port  = tty_no;
-	kdb_port_info.flags = ser->flags;
-
-	/*
-	 * Clear all interrupts
-	 */
-	/* Clear all the transmitter FIFO counters (pointer and status) */
-	ip3106_lcr(UART_BASE, tty_no) |= IP3106_UART_LCR_TX_RST;
-	/* Clear all the receiver FIFO counters (pointer and status) */
-	ip3106_lcr(UART_BASE, tty_no) |= IP3106_UART_LCR_RX_RST;
-	/* Clear all interrupts */
-	ip3106_iclr(UART_BASE, tty_no) = IP3106_UART_INT_ALLRX |
-		IP3106_UART_INT_ALLTX;
-
-	/*
-	 * Now, initialize the UART
-	 */
-	ip3106_lcr(UART_BASE, tty_no) = IP3106_UART_LCR_8BIT;
-	ip3106_baud(UART_BASE, tty_no) = 5; // 38400 Baud
-}
-
-int putDebugChar(char c)
-{
-	/* Wait until FIFO not full */
-	while (((ip3106_fifo(UART_BASE, kdb_port_info.port) & IP3106_UART_FIFO_TXFIFO) >> 16) >= 16)
-		;
-	/* Send one char */
-	ip3106_fifo(UART_BASE, kdb_port_info.port) = c;
-
-	return 1;
-}
-
-char getDebugChar(void)
-{
-	char ch;
-
-	/* Wait until there is a char in the FIFO */
-	while (!((ip3106_fifo(UART_BASE, kdb_port_info.port) &
-					IP3106_UART_FIFO_RXFIFO) >> 8))
-		;
-	/* Read one char */
-	ch = ip3106_fifo(UART_BASE, kdb_port_info.port) &
-		IP3106_UART_FIFO_RBRTHR;
-	/* Advance the RX FIFO read pointer */
-	ip3106_lcr(UART_BASE, kdb_port_info.port) |= IP3106_UART_LCR_RX_NEXT;
-	return (ch);
-}
-
-void rs_disable_debug_interrupts(void)
-{
-	ip3106_ien(UART_BASE, kdb_port_info.port) = 0; /* Disable all interrupts */
-}
-
-void rs_enable_debug_interrupts(void)
-{
-	/* Clear all the transmitter FIFO counters (pointer and status) */
-	ip3106_lcr(UART_BASE, kdb_port_info.port) |= IP3106_UART_LCR_TX_RST;
-	/* Clear all the receiver FIFO counters (pointer and status) */
-	ip3106_lcr(UART_BASE, kdb_port_info.port) |= IP3106_UART_LCR_RX_RST;
-	/* Clear all interrupts */
-	ip3106_iclr(UART_BASE, kdb_port_info.port) = IP3106_UART_INT_ALLRX |
-		IP3106_UART_INT_ALLTX;
-	ip3106_ien(UART_BASE, kdb_port_info.port)  = IP3106_UART_INT_ALLRX; /* Enable RX interrupts */
-}
Index: linux-2.6.git/include/asm-mips/mach-pnx8550/uart.h
===================================================================
--- linux-2.6.git.orig/include/asm-mips/mach-pnx8550/uart.h
+++ linux-2.6.git/include/asm-mips/mach-pnx8550/uart.h
@@ -13,4 +13,10 @@
 #define PNX8550_UART_INT(x)		(PNX8550_INT_GIC_MIN+19+x)
 #define IRQ_TO_UART(x)			(x-PNX8550_INT_GIC_MIN-19)
 
+/* macros for prom_XXX thingie */
+
+#define IP3106_LCR(b, p)	(*(volatile u32 *)((b) + (p) * 0x1000 + 0x00))
+#define IP3106_BAUD(b, p)	(*(volatile u32 *)((b) + (p) * 0x1000 + 0x08))
+#define IP3106_FIFO(b, p)	(*(volatile u32 *)((b) + (p) * 0x1000 + 0x28))
+
 #endif
