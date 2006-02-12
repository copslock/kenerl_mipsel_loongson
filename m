Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Feb 2006 17:04:33 +0000 (GMT)
Received: from i-83-67-53-76.freedom2surf.net ([83.67.53.76]:44763 "EHLO
	nephila.localnet") by ftp.linux-mips.org with ESMTP
	id S8133433AbWBLREX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 12 Feb 2006 17:04:23 +0000
Received: from pdh by nephila.localnet with local (Exim 4.50)
	id 1F8Kjx-0000Pd-Qx; Sun, 12 Feb 2006 17:10:25 +0000
Date:	Sun, 12 Feb 2006 17:10:25 +0000
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 2.6.X] Early console for Cobalt
Message-ID: <20060212171025.GB1562@colonel-panic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From:	Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

Adds early console support for Cobalts.

Signed-off-by: Peter Horton <pdh@colonel-panic.org>

P.

Index: linux.git/arch/mips/cobalt/setup.c
===================================================================
--- linux.git.orig/arch/mips/cobalt/setup.c	2006-02-12 14:33:51.000000000 +0000
+++ linux.git/arch/mips/cobalt/setup.c	2006-02-12 16:40:54.000000000 +0000
@@ -31,6 +31,7 @@
 extern void cobalt_machine_restart(char *command);
 extern void cobalt_machine_halt(void);
 extern void cobalt_machine_power_off(void);
+extern void cobalt_early_console(void);
 
 int cobalt_board_id;
 
@@ -109,14 +110,6 @@
 	/* I/O port resource must include UART and LCD/buttons */
 	ioport_resource.end = 0x0fffffff;
 
-	/*
-	 * This is a prom style console. We just poke at the
-	 *  UART to make it talk.
-	 * Only use this console if you really screw up and can't
-	 *  get to the stage of setting up a real serial console.
-	 */
-	/*ns16550_setup_console();*/
-
 	/* request I/O space for devices used on all i[345]86 PCs */
 	for (i = 0; i < COBALT_IO_RESOURCES; i++)
 		request_resource(&ioport_resource, cobalt_io_resources + i);
@@ -136,6 +129,10 @@
 #ifdef CONFIG_SERIAL_8250
 	if (cobalt_board_id > COBALT_BRD_ID_RAQ1) {
 
+#ifdef CONFIG_COBALT_EARLY_CONSOLE
+		cobalt_early_console();
+#endif
+
 		uart.line	= 0;
 		uart.type	= PORT_UNKNOWN;
 		uart.uartclk	= 18432000;
Index: linux.git/arch/mips/cobalt/Makefile
===================================================================
--- linux.git.orig/arch/mips/cobalt/Makefile	2006-02-12 14:33:51.000000000 +0000
+++ linux.git/arch/mips/cobalt/Makefile	2006-02-12 16:39:25.000000000 +0000
@@ -4,4 +4,6 @@
 
 obj-y	 := irq.o int-handler.o reset.o setup.o
 
+obj-$(CONFIG_COBALT_EARLY_CONSOLE)	+= console.o
+
 EXTRA_AFLAGS := $(CFLAGS)
Index: linux.git/arch/mips/cobalt/console.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux.git/arch/mips/cobalt/console.c	2006-02-12 16:42:05.000000000 +0000
@@ -0,0 +1,60 @@
+/*
+ * (C) P. Horton 2006
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/console.h>
+#include <linux/serial_reg.h>
+#include <asm/addrspace.h>
+#include <asm/mach-cobalt/cobalt.h>
+
+#if 0
+
+static int kbhit(void)
+{
+	return COBALT_UART[UART_LSR] & UART_LSR_DR;
+}
+
+static int getch(void)
+{
+	while(!kbhit())
+		;
+
+	return (unsigned char) COBALT_UART[UART_RX];
+}
+
+#endif
+
+static void putchar(int c)
+{
+	if(c == '\n')
+		putchar('\r');
+
+	while(!(COBALT_UART[UART_LSR] & UART_LSR_THRE))
+		;
+
+	COBALT_UART[UART_TX] = c;
+}
+
+static void cons_write(struct console *c, const char *s, unsigned n)
+{
+	while(n-- && *s)
+		putchar(*s++);
+}
+
+static struct console cons_info =
+{
+	.name	= "uart",
+	.write	= cons_write,
+	.flags	= CON_PRINTBUFFER | CON_BOOT,
+	.index	= -1,
+};
+
+void __init cobalt_early_console(void)
+{
+	register_console(&cons_info);
+
+	printk("Cobalt: early console registered\n");
+}
Index: linux.git/include/asm/mach-cobalt/cobalt.h
===================================================================
--- linux.git.orig/include/asm/mach-cobalt/cobalt.h	2006-02-12 14:34:12.000000000 +0000
+++ linux.git/include/asm/mach-cobalt/cobalt.h	2006-02-12 15:54:51.000000000 +0000
@@ -113,4 +113,6 @@
 # define COBALT_KEY_SELECT	(1 << 7)
 # define COBALT_KEY_MASK	0xfe
 
+#define COBALT_UART		((volatile unsigned char *) CKSEG1ADDR(0x1c800000))
+
 #endif /* __ASM_COBALT_H */
Index: linux.git/arch/mips/Kconfig
===================================================================
--- linux.git.orig/arch/mips/Kconfig	2006-02-12 14:33:51.000000000 +0000
+++ linux.git/arch/mips/Kconfig	2006-02-12 16:33:25.000000000 +0000
@@ -787,6 +787,7 @@
 source "arch/mips/tx4938/Kconfig"
 source "arch/mips/vr41xx/Kconfig"
 source "arch/mips/philips/pnx8550/common/Kconfig"
+source "arch/mips/cobalt/Kconfig"
 
 endmenu
 
Index: linux.git/arch/mips/cobalt/Kconfig
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux.git/arch/mips/cobalt/Kconfig	2006-02-12 16:45:14.000000000 +0000
@@ -0,0 +1,7 @@
+config COBALT_EARLY_CONSOLE
+	bool "Early console support"
+	depends on MIPS_COBALT
+	help
+	  Provide early console support by direct access to the
+	  on board UART. The UART must have been previously
+	  initialised by the boot loader.
