Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Dec 2005 04:24:40 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:24353 "HELO
	topsns.toshiba-tops.co.jp") by ftp.linux-mips.org with SMTP
	id S8133349AbVL1EYE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Dec 2005 04:24:04 +0000
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 28 Dec 2005 04:25:50 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id CEB59201B9;
	Wed, 28 Dec 2005 13:25:46 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id BAB6F1FF17;
	Wed, 28 Dec 2005 13:25:46 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id jBS4Pi4D046215;
	Wed, 28 Dec 2005 13:25:44 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 28 Dec 2005 13:25:44 +0900 (JST)
Message-Id: <20051228.132544.96684396.nemoto@toshiba-tops.co.jp>
To:	sshtylyov@dev.rtsoft.ru
Cc:	rmk@arm.linux.org.uk, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] serial_txx9: forcibly init the spinlock for PCI UART
 used as a console
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <43B196A9.8010608@dev.rtsoft.ru>
	<20051227184152.GA4474@flint.arm.linux.org.uk>
References: <20051227184152.GA4474@flint.arm.linux.org.uk>
	<43B18DD2.3090206@ru.mvista.com>
	<43B196A9.8010608@dev.rtsoft.ru>
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
X-archive-position: 9746
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 27 Dec 2005 18:41:52 +0000, Russell King <rmk@arm.linux.org.uk> said:
rmk> This should result in a cleaner implementation, and the console
rmk> will not be started until you detect the PCI card.  Which is the
rmk> behaviour you desire in any case.

Thanks for your advise.  Though this is not fix the problem as Sergei
said, I would refine the driver.

>>>>> On Tue, 27 Dec 2005 22:31:53 +0300, Sergei Shtylyov <sshtylyov@dev.rtsoft.ru> said:
sshtylyov>     All in all, the problem of uninit'ed PCI port spinlock
sshtylyov> will remain unless serial core is fixed (ot at least the
sshtylyov> driver). Proposed driver re-design wouldn't help as this is
sshtylyov> actually chicken-before-egg type problem --
sshtylyov> uart_add_one_port() assumes that the console is setup
sshtylyov> beforehand, and this just can't happen in case of a PCI
sshtylyov> card.

I agree.  Let me clarify a situation.

* The serial_txx9 driver handles both SOC UARTs and PCI UARTs.

* We want to use console_initcall to register console for SOC UARTs.

* PCI UARTs were not detected when console_initcall function was called.

* For PCI UARTs, uart_add_one_port() calls register_console (again)
  _after_ configuring the port.  The spinlock must be initialized
  before configure the port.

* By first register_console, port->cons->index has been
  initialized. (even if console setup function failed)

* The uart_console() returns 1 even if the console was not
  successfully configured (CON_ENABLED was not set and spinlock did
  not initialized).  So uart_add_one_port() does not initialize the
  spinlock for the console.

There would be 3 solutions:

1. uart_add_one_port() initialize the spinlock for console port
   without CON_ENABLED.

2. lowlevel driver initialize the spinlock somewhere.

3. register_console() revert console->index to -1 when console->setup
   function failed.  (But register_console is already too complex for
   me ...)

I would prefer (1), but if not acceptable, I do not object to (2).


This is a refined patch following Russell's advise.  This does not
include Sergei's fix.

 * More strict check in verify_port.  Cleanup.
 * Do not insert a char caused previous overrun.
 * Fix some spin_locks.
 * Do not call uart_add_one_port for absent ports.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/drivers/serial/serial_txx9.c b/drivers/serial/serial_txx9.c
index f10c86d..37fa0aa 100644
--- a/drivers/serial/serial_txx9.c
+++ b/drivers/serial/serial_txx9.c
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
@@ -837,7 +842,8 @@ static void __init serial_txx9_register_
 
 		up->port.line = i;
 		up->port.ops = &serial_txx9_pops;
-		uart_add_one_port(drv, &up->port);
+		if (up->port.iobase || up->port.mapbase)
+			uart_add_one_port(drv, &up->port);
 	}
 }
 
@@ -937,11 +943,6 @@ static int serial_txx9_console_setup(str
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
@@ -1051,11 +1052,10 @@ static int __devinit serial_txx9_registe
 	down(&serial_txx9_sem);
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
@@ -1090,9 +1090,8 @@ static void __devexit serial_txx9_unregi
 	uart->port.type = PORT_UNKNOWN;
 	uart->port.iobase = 0;
 	uart->port.mapbase = 0;
-	uart->port.membase = 0;
+	uart->port.membase = NULL;
 	uart->port.dev = NULL;
-	uart_add_one_port(&serial_txx9_reg, &uart->port);
 	up(&serial_txx9_sem);
 }
 
@@ -1195,7 +1194,7 @@ static int __init serial_txx9_init(void)
 		serial_txx9_register_ports(&serial_txx9_reg);
 
 #ifdef ENABLE_SERIAL_TXX9_PCI
-		ret = pci_module_init(&serial_txx9_pci_driver);
+		ret = pci_register_driver(&serial_txx9_pci_driver);
 #endif
 	}
 	return ret;
@@ -1208,8 +1207,11 @@ static void __exit serial_txx9_exit(void
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
