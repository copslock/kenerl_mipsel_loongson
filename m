Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2007 13:44:21 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:15371 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022612AbXEKMoT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2007 13:44:19 +0100
Received: by mo.po.2iij.net (mo30) id l4BCiGaC040705; Fri, 11 May 2007 21:44:16 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox33) id l4BCiF62077191
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 11 May 2007 21:44:15 +0900 (JST)
Date:	Fri, 11 May 2007 21:29:59 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS][1/3] use platform_device for Cobalt UART
Message-Id: <20070511212959.6558d88e.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has changed using platform_device for Cobalt UART.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/Makefile mips/arch/mips/cobalt/Makefile
--- mips-orig/arch/mips/cobalt/Makefile	2007-05-10 23:57:43.326652250 +0900
+++ mips/arch/mips/cobalt/Makefile	2007-05-10 23:53:48.103951750 +0900
@@ -2,7 +2,7 @@
 # Makefile for the Cobalt micro systems family specific parts of the kernel
 #
 
-obj-y	 := irq.o reset.o setup.o buttons.o
+obj-y := buttons.o irq.o reset.o serial.o setup.o
 
 obj-$(CONFIG_PCI)		+= pci.o
 obj-$(CONFIG_EARLY_PRINTK)	+= console.o
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/serial.c mips/arch/mips/cobalt/serial.c
--- mips-orig/arch/mips/cobalt/serial.c	1970-01-01 09:00:00.000000000 +0900
+++ mips/arch/mips/cobalt/serial.c	2007-05-10 23:54:24.650235750 +0900
@@ -0,0 +1,85 @@
+/*
+ *  Registration of Cobalt UART platform device.
+ *
+ *  Copyright (C) 2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/platform_device.h>
+#include <linux/serial_8250.h>
+
+#include <cobalt.h>
+
+static struct resource cobalt_uart_resource[] __initdata = {
+	{
+		.start	= 0x1c800000,
+		.end	= 0x1c800007,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= COBALT_SERIAL_IRQ,
+		.end	= COBALT_SERIAL_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct plat_serial8250_port cobalt_serial8250_port[] = {
+	{
+		.irq		= COBALT_SERIAL_IRQ,
+		.uartclk	= 18432000,
+		.iotype		= UPIO_MEM,
+		.flags		= UPF_IOREMAP | UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+		.mapbase	= 0x1c800000,
+	},
+	{},
+};
+
+static __init int cobalt_uart_add(void)
+{
+	struct platform_device *pdev;
+	int retval;
+
+	/*
+	 * Cobalt Qube1 and RAQ1 have no UART.
+	 */
+	if (cobalt_board_id <= COBALT_BRD_ID_RAQ1)
+		return 0;
+
+	pdev = platform_device_alloc("serial8250", -1);
+	if (!pdev)
+		return -ENOMEM;
+
+	pdev->id = PLAT8250_DEV_PLATFORM;
+	pdev->dev.platform_data = cobalt_serial8250_port;
+
+	retval = platform_device_add_resources(pdev, cobalt_uart_resource, ARRAY_SIZE(cobalt_uart_resource));
+	if (retval)
+		goto err_free_device;
+
+	retval = platform_device_add(pdev);
+	if (retval)
+		goto err_free_device;
+
+	return 0;
+
+err_free_device:
+	platform_device_put(pdev);
+
+	return retval;
+}
+device_initcall(cobalt_uart_add);
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/setup.c mips/arch/mips/cobalt/setup.c
--- mips-orig/arch/mips/cobalt/setup.c	2007-05-10 23:57:43.354654000 +0900
+++ mips/arch/mips/cobalt/setup.c	2007-05-10 23:53:48.175956250 +0900
@@ -13,8 +13,6 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/pm.h>
-#include <linux/serial.h>
-#include <linux/serial_core.h>
 
 #include <asm/bootinfo.h>
 #include <asm/time.h>
@@ -27,7 +25,6 @@
 extern void cobalt_machine_restart(char *command);
 extern void cobalt_machine_halt(void);
 extern void cobalt_machine_power_off(void);
-extern void cobalt_early_console(void);
 
 int cobalt_board_id;
 
@@ -95,7 +92,6 @@ static struct resource cobalt_reserved_r
 
 void __init plat_mem_setup(void)
 {
-	static struct uart_port uart;
 	unsigned int devfn = PCI_DEVFN(COBALT_PCICONF_VIA, 0);
 	int i;
 
@@ -119,21 +115,6 @@ void __init plat_mem_setup(void)
         cobalt_board_id = VIA_COBALT_BRD_REG_to_ID(cobalt_board_id);
 
 	printk("Cobalt board ID: %d\n", cobalt_board_id);
-
-	if (cobalt_board_id > COBALT_BRD_ID_RAQ1) {
-#ifdef CONFIG_SERIAL_8250
-		uart.line	= 0;
-		uart.type	= PORT_UNKNOWN;
-		uart.uartclk	= 18432000;
-		uart.irq	= COBALT_SERIAL_IRQ;
-		uart.flags	= UPF_IOREMAP | UPF_BOOT_AUTOCONF |
-				  UPF_SKIP_TEST;
-		uart.iotype	= UPIO_MEM;
-		uart.mapbase	= 0x1c800000;
-
-		early_serial_setup(&uart);
-#endif
-	}
 }
 
 /*
