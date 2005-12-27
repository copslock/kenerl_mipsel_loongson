Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Dec 2005 05:44:35 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:13333 "HELO
	topsns.toshiba-tops.co.jp") by ftp.linux-mips.org with SMTP
	id S8126497AbVL0FoP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Dec 2005 05:44:15 +0000
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 27 Dec 2005 05:45:56 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 1E67A201C3;
	Tue, 27 Dec 2005 14:45:53 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 0B6EE1D6D8;
	Tue, 27 Dec 2005 14:45:53 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id jBR5jp4D041321;
	Tue, 27 Dec 2005 14:45:52 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 27 Dec 2005 14:45:51 +0900 (JST)
Message-Id: <20051227.144551.79070832.nemoto@toshiba-tops.co.jp>
To:	sshtylyov@ru.mvista.com
Cc:	rmk+serial@arm.linux.org.uk, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] serial_txx9: forcibly init the spinlock for PCI UART
 used as a console
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <43B06DB4.409@ru.mvista.com>
References: <43B06DB4.409@ru.mvista.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 27 Dec 2005 01:24:52 +0300, Sergei Shtylylov <sshtylyov@ru.mvista.com> said:
sshtylyov>         When a system console gets assigned to the UART
sshtylyov> located on the Toshiba GOKU-S PCI card, the port spinlock
sshtylyov> is not initialized at all -- uart_add_one_port() thinks
sshtylyov> it's been initialized by the console setup code which is
sshtylyov> called too early for being able to do that, before the PCI
sshtylyov> card is even detected by the driver, and therefore
sshtylyov> fails.

The problem is not just only spin_lock_init.  The parameters of
"console=" option (baudrate, etc.) are not passed for PCI UART.  Also,
if console setup failed, the console never enabled.  So the console
can not be used anyway.

I have an another fix.  Call register_console() again for PCI UART if
the console was not enabled.  This fixes spin_lock_init issue and
makes PCI UART really usable as console.

Also, I have some other pending changes for this driver.

 * More strict check in verify_port.  Cleanup.
 * Do not insert a char caused previous overrun.
 * Fix some spin_locks.
 * Call register_console again for PCI ports.

This is a patch against linux-mips GIT.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>


diff --git a/drivers/serial/serial_txx9.c b/drivers/serial/serial_txx9.c
index f10c86d..c24e0c3 100644
--- a/drivers/serial/serial_txx9.c
+++ b/drivers/serial/serial_txx9.c
@@ -33,6 +33,10 @@
  *	1.02	Cleanup. (import 8250.c changes)
  *	1.03	Fix low-latency mode. (import 8250.c changes)
  *	1.04	Remove usage of deprecated functions, cleanup.
+ *	1.05	More strict check in verify_port.  Cleanup.
+ *	1.06	Do not insert a char caused previous overrun.
+ *		Fix some spin_locks.
+ *		Call register_console again for PCI ports.
  */
 #include <linux/config.h>
 
@@ -56,7 +60,7 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-static char *serial_version = "1.04";
+static char *serial_version = "1.06";
 static char *serial_name = "TX39/49 Serial driver";
 
 #define PASS_LIMIT	256
@@ -209,7 +213,7 @@ static inline unsigned int sio_in(struct
 {
 	switch (up->port.iotype) {
 	default:
-		return *(volatile u32 *)(up->port.membase + offset);
+		return __raw_readl(up->port.membase + offset);
 	case UPIO_PORT:
 		return inl(up->port.iobase + offset);
 	}
@@ -220,7 +224,7 @@ sio_out(struct uart_txx9_port *up, int o
 {
 	switch (up->port.iotype) {
 	default:
-		*(volatile u32 *)(up->port.membase + offset) = value;
+		__raw_writel(value, up->port.membase + offset);
 		break;
 	case UPIO_PORT:
 		outl(value, up->port.iobase + offset);
@@ -258,34 +262,19 @@ sio_quot_set(struct uart_txx9_port *up, 
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
@@ -301,6 +290,7 @@ receive_chars(struct uart_txx9_port *up,
 	unsigned int disr = *status;
 	int max_count = 256;
 	char flag;
+	unsigned int next_ignore_status_mask;
 
 	do {
 		/* The following is not allowed by the tty layer and
@@ -318,6 +308,9 @@ receive_chars(struct uart_txx9_port *up,
 		flag = TTY_NORMAL;
 		up->port.icount.rx++;
 
+		/* mask out RFDN_MASK bit added by previous overrun */
+		next_ignore_status_mask =
+			up->port.ignore_status_mask & ~TXX9_SIDISR_RFDN_MASK;
 		if (unlikely(disr & (TXX9_SIDISR_UBRK | TXX9_SIDISR_UPER |
 				     TXX9_SIDISR_UFER | TXX9_SIDISR_UOER))) {
 			/*
@@ -338,8 +331,17 @@ receive_chars(struct uart_txx9_port *up,
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
@@ -359,6 +361,7 @@ receive_chars(struct uart_txx9_port *up,
 		uart_insert_char(&up->port, disr, TXX9_SIDISR_UOER, ch, flag);
 
 	ignore_char:
+		up->port.ignore_status_mask = next_ignore_status_mask;
 		disr = sio_in(up, TXX9_SIDISR);
 	} while (!(disr & TXX9_SIDISR_UVALID) && (max_count-- > 0));
 	spin_unlock(&up->port.lock);
@@ -460,14 +463,11 @@ static unsigned int serial_txx9_get_mctr
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
@@ -794,8 +794,13 @@ static void serial_txx9_config_port(stru
 static int
 serial_txx9_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
-	if (ser->irq < 0 ||
-	    ser->baud_base < 9600 || ser->type != PORT_TXX9)
+	unsigned long new_port = (unsigned long)ser->port +
+		((unsigned long)ser->port_high << ((sizeof(long) - sizeof(int)) * 8));
+	if (ser->type != port->type ||
+	    ser->irq != port->irq ||
+	    ser->io_type != port->iotype ||
+	    new_port != port->iobase ||
+	    (unsigned long)ser->iomem_base != port->mapbase)
 		return -EINVAL;
 	return 0;
 }
@@ -937,11 +942,6 @@ static int serial_txx9_console_setup(str
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
@@ -1065,6 +1065,14 @@ static int __devinit serial_txx9_registe
 		uart->port.mapbase  = port->mapbase;
 		if (port->dev)
 			uart->port.dev = port->dev;
+#ifdef CONFIG_SERIAL_TXX9_CONSOLE
+		/*
+		 * The 'early' register_console fails for PCI ports.
+		 * Do it again.
+		 */
+		if (!(serial_txx9_console.flags & CON_ENABLED))
+			register_console(&serial_txx9_console);
+#endif
 		ret = uart_add_one_port(&serial_txx9_reg, &uart->port);
 		if (ret == 0)
 			ret = uart->port.line;
@@ -1090,7 +1098,7 @@ static void __devexit serial_txx9_unregi
 	uart->port.type = PORT_UNKNOWN;
 	uart->port.iobase = 0;
 	uart->port.mapbase = 0;
-	uart->port.membase = 0;
+	uart->port.membase = NULL;
 	uart->port.dev = NULL;
 	uart_add_one_port(&serial_txx9_reg, &uart->port);
 	up(&serial_txx9_sem);
@@ -1195,7 +1203,7 @@ static int __init serial_txx9_init(void)
 		serial_txx9_register_ports(&serial_txx9_reg);
 
 #ifdef ENABLE_SERIAL_TXX9_PCI
-		ret = pci_module_init(&serial_txx9_pci_driver);
+		ret = pci_register_driver(&serial_txx9_pci_driver);
 #endif
 	}
 	return ret;
