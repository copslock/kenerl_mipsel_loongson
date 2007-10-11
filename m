Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Oct 2007 14:55:42 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:25645 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021571AbXJKNze (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 11 Oct 2007 14:55:34 +0100
Received: by mo.po.2iij.net (mo30) id l9BDsF0K015954; Thu, 11 Oct 2007 22:54:15 +0900 (JST)
Received: from delta (221.25.30.125.dy.iij4u.or.jp [125.30.25.221])
	by mbox.po.2iij.net (po-mbox302) id l9BDsEYi021931
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 11 Oct 2007 22:54:14 +0900
Date:	Thu, 11 Oct 2007 22:54:13 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] WRPPMC serial support move to platform device
Message-Id: <20071011225413.e9bff979.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.0 (GTK+ 2.10.11; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

WRPPMC serial support move to platform device.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/wrppmc/Makefile mips/arch/mips/gt64120/wrppmc/Makefile
--- mips-orig/arch/mips/gt64120/wrppmc/Makefile	2007-10-01 17:03:49.454725750 +0900
+++ mips/arch/mips/gt64120/wrppmc/Makefile	2007-10-01 18:24:04.947682250 +0900
@@ -9,6 +9,6 @@
 # Makefile for the Wind River MIPS 4KC PPMC Eval Board
 #
 
-obj-y += irq.o reset.o setup.o time.o pci.o
+obj-y += irq.o pci.o reset.o serial.o setup.o time.o
 
 EXTRA_CFLAGS += -Werror
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/wrppmc/serial.c mips/arch/mips/gt64120/wrppmc/serial.c
--- mips-orig/arch/mips/gt64120/wrppmc/serial.c	1970-01-01 09:00:00.000000000 +0900
+++ mips/arch/mips/gt64120/wrppmc/serial.c	2007-10-01 18:24:04.967683500 +0900
@@ -0,0 +1,80 @@
+/*
+ *  Registration of WRPPMC UART platform device.
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
+#include <asm/gt64120.h>
+
+static struct resource wrppmc_uart_resource[] __initdata = {
+	{
+		.start	= WRPPMC_UART16550_BASE,
+		.end	= WRPPMC_UART16550_BASE + 7,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= WRPPMC_UART16550_IRQ,
+		.end	= WRPPMC_UART16550_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct plat_serial8250_port wrppmc_serial8250_port[] = {
+	{
+		.irq		= WRPPMC_UART16550_IRQ,
+		.uartclk	= WRPPMC_UART16550_CLOCK,
+		.iotype		= UPIO_MEM,
+		.flags		= UPF_IOREMAP | UPF_SKIP_TEST,
+		.mapbase	= WRPPMC_UART16550_BASE,
+	},
+	{},
+};
+
+static __init int wrppmc_uart_add(void)
+{
+	struct platform_device *pdev;
+	int retval;
+
+	pdev = platform_device_alloc("serial8250", -1);
+	if (!pdev)
+		return -ENOMEM;
+
+	pdev->id = PLAT8250_DEV_PLATFORM;
+	pdev->dev.platform_data = wrppmc_serial8250_port;
+
+	retval = platform_device_add_resources(pdev, wrppmc_uart_resource,
+					ARRAY_SIZE(wrppmc_uart_resource));
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
+device_initcall(wrppmc_uart_add);
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/wrppmc/setup.c mips/arch/mips/gt64120/wrppmc/setup.c
--- mips-orig/arch/mips/gt64120/wrppmc/setup.c	2007-10-01 17:03:49.454725750 +0900
+++ mips/arch/mips/gt64120/wrppmc/setup.c	2007-10-01 18:24:04.967683500 +0900
@@ -11,10 +11,6 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
-#include <linux/tty.h>
-#include <linux/serial.h>
-#include <linux/serial_core.h>
-#include <linux/serial_8250.h>
 #include <linux/pm.h>
 
 #include <asm/io.h>
@@ -98,32 +94,6 @@ void __init prom_free_prom_memory(void)
 {
 }
 
-#ifdef CONFIG_SERIAL_8250
-static void wrppmc_setup_serial(void)
-{
-	struct uart_port up;
-
-	memset(&up, 0x00, sizeof(struct uart_port));
-
-	/*
-	 * A note about mapbase/membase
-	 * -) mapbase is the physical address of the IO port.
-	 * -) membase is an 'ioremapped' cookie.
-	 */
-	up.line = 0;
-	up.type = PORT_16550;
-	up.iotype = UPIO_MEM;
-	up.mapbase = WRPPMC_UART16550_BASE;
-	up.membase = ioremap(up.mapbase, 8);
-	up.irq = WRPPMC_UART16550_IRQ;
-	up.uartclk = WRPPMC_UART16550_CLOCK;
-	up.flags = UPF_SKIP_TEST/* | UPF_BOOT_AUTOCONF */;
-	up.regshift = 0;
-
-	early_serial_setup(&up);
-}
-#endif
-
 void __init plat_mem_setup(void)
 {
 	extern void wrppmc_machine_restart(char *command);
@@ -138,10 +108,6 @@ void __init plat_mem_setup(void)
 	 * physical address ( < KSEG0) can work via KSEG1
 	 */
 	set_io_port_base(KSEG1);
-
-#ifdef CONFIG_SERIAL_8250
-	wrppmc_setup_serial();
-#endif
 }
 
 const char *get_system_type(void)
