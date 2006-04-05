Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Apr 2006 01:31:06 +0100 (BST)
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:65253 "EHLO
	mail8.fw-bc.sony.com") by ftp.linux-mips.org with ESMTP
	id S8133826AbWDEAaF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Apr 2006 01:30:05 +0100
Received: from mail3.sjc.in.sel.sony.com (mail3.sjc.in.sel.sony.com [43.134.1.211])
	by mail8.fw-bc.sony.com (8.12.11/8.12.11) with ESMTP id k350f9jt023758;
	Wed, 5 Apr 2006 00:41:09 GMT
Received: from [192.168.1.10] ([43.134.85.105])
	by mail3.sjc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id k350f9RN008817;
	Wed, 5 Apr 2006 00:41:09 GMT
Message-ID: <44331225.4040507@am.sony.com>
Date:	Tue, 04 Apr 2006 17:41:09 -0700
From:	Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	ralf@linux-mips.org, anemo@mba.ocn.ne.jp
CC:	linux-mips@linux-mips.org
Subject: [PATCH 1/4] rebase tx49 serial fixes
Content-Type: multipart/mixed;
 boundary="------------080503070606040209060902"
Return-Path: <geoffrey.levand@am.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoffrey.levand@am.sony.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------080503070606040209060902
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit




--------------080503070606040209060902
Content-Type: text/x-patch;
 name="serial-serial_txx9-driver-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serial-serial_txx9-driver-update.patch"

This is a rebase to 2.6.16.1 of the 2.6.16-rc1-mm5 patch
serial-serial_txx9-driver-update.patch.

http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm5/broken-out/serial-serial_txx9-driver-update.patch

From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Update the serial_txx9 driver.

 * More strict check in verify_port.  Cleanup.
 * Do not insert a char caused previous overrun.
 * Fix some spin_locks.
 * Do not call uart_add_one_port for absent ports.

Also, this patch removes a BROKEN tag from Kconfig.  This driver has been
marked as BROKEN by removal of uart_register_port, but it has been solved
already on Sep 2005.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>


Index: linux-2.6.16.1/drivers/serial/Kconfig
===================================================================
--- linux-2.6.16.1.orig/drivers/serial/Kconfig	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16.1/drivers/serial/Kconfig	2006-03-30 15:23:20.000000000 -0800
@@ -859,7 +859,7 @@
 
 config SERIAL_TXX9
 	bool "TMPTX39XX/49XX SIO support"
-	depends HAS_TXX9_SERIAL && BROKEN
+	depends HAS_TXX9_SERIAL
 	select SERIAL_CORE
 	default y
 
Index: linux-2.6.16.1/drivers/serial/serial_txx9.c
===================================================================
--- linux-2.6.16.1.orig/drivers/serial/serial_txx9.c	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16.1/drivers/serial/serial_txx9.c	2006-03-30 15:26:54.000000000 -0800
@@ -33,6 +33,10 @@
  *	1.02	Cleanup. (import 8250.c changes)
  *	1.03	Fix low-latency mode. (import 8250.c changes)
  *	1.04	Remove usage of deprecated functions, cleanup.
+ *	1.05	More strict check in verify_port.  Cleanup.
+ *	1.06	Do not insert a char caused previous overrun.
+ *		Fix some spin_locks.
+ *		Do not call uart_add_one_port for absent ports.
  */
 #include <linux/config.h>
 
@@ -57,7 +61,7 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-static char *serial_version = "1.04";
+static char *serial_version = "1.06";
 static char *serial_name = "TX39/49 Serial driver";
 
 #define PASS_LIMIT	256
@@ -94,6 +98,8 @@
 #define UART_NR  4
 #endif
 
+#define HIGH_BITS_OFFSET	((sizeof(long)-sizeof(int))*8)
+
 struct uart_txx9_port {
 	struct uart_port	port;
 
@@ -210,7 +216,7 @@
 {
 	switch (up->port.iotype) {
 	default:
-		return *(volatile u32 *)(up->port.membase + offset);
+		return __raw_readl(up->port.membase + offset);
 	case UPIO_PORT:
 		return inl(up->port.iobase + offset);
 	}
@@ -221,7 +227,7 @@
 {
 	switch (up->port.iotype) {
 	default:
-		*(volatile u32 *)(up->port.membase + offset) = value;
+		__raw_writel(value, up->port.membase + offset);
 		break;
 	case UPIO_PORT:
 		outl(value, up->port.iobase + offset);
@@ -259,34 +265,19 @@
 static void serial_txx9_stop_tx(struct uart_port *port)
 {
 	struct uart_txx9_port *up = (struct uart_txx9_port *)port;
-	unsigned long flags;
-
-	spin_lock_irqsave(&up->port.lock, flags);
 	sio_mask(up, TXX9_SIDICR, TXX9_SIDICR_TIE);
-	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
 static void serial_txx9_start_tx(struct uart_port *port)
 {
 	struct uart_txx9_port *up = (struct uart_txx9_port *)port;
-	unsigned long flags;
-
-	spin_lock_irqsave(&up->port.lock, flags);
 	sio_set(up, TXX9_SIDICR, TXX9_SIDICR_TIE);
-	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
 static void serial_txx9_stop_rx(struct uart_port *port)
 {
 	struct uart_txx9_port *up = (struct uart_txx9_port *)port;
-	unsigned long flags;
-
-	spin_lock_irqsave(&up->port.lock, flags);
 	up->port.read_status_mask &= ~TXX9_SIDISR_RDIS;
-#if 0
-	sio_mask(up, TXX9_SIDICR, TXX9_SIDICR_RIE);
-#endif
-	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
 static void serial_txx9_enable_ms(struct uart_port *port)
@@ -302,12 +293,16 @@
 	unsigned int disr = *status;
 	int max_count = 256;
 	char flag;
+	unsigned int next_ignore_status_mask;
 
 	do {
 		ch = sio_in(up, TXX9_SIRFIFO);
 		flag = TTY_NORMAL;
 		up->port.icount.rx++;
 
+		/* mask out RFDN_MASK bit added by previous overrun */
+		next_ignore_status_mask =
+			up->port.ignore_status_mask & ~TXX9_SIDISR_RFDN_MASK;
 		if (unlikely(disr & (TXX9_SIDISR_UBRK | TXX9_SIDISR_UPER |
 				     TXX9_SIDISR_UFER | TXX9_SIDISR_UOER))) {
 			/*
@@ -328,8 +323,17 @@
 				up->port.icount.parity++;
 			else if (disr & TXX9_SIDISR_UFER)
 				up->port.icount.frame++;
-			if (disr & TXX9_SIDISR_UOER)
+			if (disr & TXX9_SIDISR_UOER) {
 				up->port.icount.overrun++;
+				/*
+				 * The receiver read buffer still hold
+				 * a char which caused overrun.
+				 * Ignore next char by adding RFDN_MASK
+				 * to ignore_status_mask temporarily.
+				 */
+				next_ignore_status_mask |=
+					TXX9_SIDISR_RFDN_MASK;
+			}
 
 			/*
 			 * Mask off conditions which should be ingored.
@@ -349,6 +353,7 @@
 		uart_insert_char(&up->port, disr, TXX9_SIDISR_UOER, ch, flag);
 
 	ignore_char:
+		up->port.ignore_status_mask = next_ignore_status_mask;
 		disr = sio_in(up, TXX9_SIDISR);
 	} while (!(disr & TXX9_SIDISR_UVALID) && (max_count-- > 0));
 	spin_unlock(&up->port.lock);
@@ -450,14 +455,11 @@
 static void serial_txx9_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	struct uart_txx9_port *up = (struct uart_txx9_port *)port;
-	unsigned long flags;
 
-	spin_lock_irqsave(&up->port.lock, flags);
 	if (mctrl & TIOCM_RTS)
 		sio_mask(up, TXX9_SIFLCR, TXX9_SIFLCR_RTSSC);
 	else
 		sio_set(up, TXX9_SIFLCR, TXX9_SIFLCR_RTSSC);
-	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
 static void serial_txx9_break_ctl(struct uart_port *port, int break_state)
@@ -784,8 +786,14 @@
 static int
 serial_txx9_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
-	if (ser->irq < 0 ||
-	    ser->baud_base < 9600 || ser->type != PORT_TXX9)
+	unsigned long new_port = ser->port;
+	if (HIGH_BITS_OFFSET)
+		new_port += (unsigned long)ser->port_high << HIGH_BITS_OFFSET;
+	if (ser->type != port->type ||
+	    ser->irq != port->irq ||
+	    ser->io_type != port->iotype ||
+	    new_port != port->iobase ||
+	    (unsigned long)ser->iomem_base != port->mapbase)
 		return -EINVAL;
 	return 0;
 }
@@ -827,7 +835,8 @@
 
 		up->port.line = i;
 		up->port.ops = &serial_txx9_pops;
-		uart_add_one_port(drv, &up->port);
+		if (up->port.iobase || up->port.mapbase)
+			uart_add_one_port(drv, &up->port);
 	}
 }
 
@@ -927,11 +936,6 @@
 		return -ENODEV;
 
 	/*
-	 * Temporary fix.
-	 */
-	spin_lock_init(&port->lock);
-
-	/*
 	 *	Disable UART interrupts, set DTR and RTS high
 	 *	and set speed.
 	 */
@@ -1041,11 +1045,10 @@
 	mutex_lock(&serial_txx9_mutex);
 	for (i = 0; i < UART_NR; i++) {
 		uart = &serial_txx9_ports[i];
-		if (uart->port.type == PORT_UNKNOWN)
+		if (!(uart->port.iobase || uart->port.mapbase))
 			break;
 	}
 	if (i < UART_NR) {
-		uart_remove_one_port(&serial_txx9_reg, &uart->port);
 		uart->port.iobase = port->iobase;
 		uart->port.membase = port->membase;
 		uart->port.irq      = port->irq;
@@ -1080,9 +1083,8 @@
 	uart->port.type = PORT_UNKNOWN;
 	uart->port.iobase = 0;
 	uart->port.mapbase = 0;
-	uart->port.membase = 0;
+	uart->port.membase = NULL;
 	uart->port.dev = NULL;
-	uart_add_one_port(&serial_txx9_reg, &uart->port);
 	mutex_unlock(&serial_txx9_mutex);
 }
 
@@ -1198,8 +1200,11 @@
 #ifdef ENABLE_SERIAL_TXX9_PCI
 	pci_unregister_driver(&serial_txx9_pci_driver);
 #endif
-	for (i = 0; i < UART_NR; i++)
-		uart_remove_one_port(&serial_txx9_reg, &serial_txx9_ports[i].port);
+	for (i = 0; i < UART_NR; i++) {
+		struct uart_txx9_port *up = &serial_txx9_ports[i];
+		if (up->port.iobase || up->port.mapbase)
+			uart_remove_one_port(&serial_txx9_reg, &up->port);
+	}
 
 	uart_unregister_driver(&serial_txx9_reg);
 }






--------------080503070606040209060902--
