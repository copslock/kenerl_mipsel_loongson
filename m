Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Dec 2005 15:34:15 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:37315 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133538AbVL0Pdy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Dec 2005 15:33:54 +0000
Received: from localhost (p8078-ipad25funabasi.chiba.ocn.ne.jp [220.104.86.78])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A774F9B88; Wed, 28 Dec 2005 00:35:36 +0900 (JST)
Date:	Wed, 28 Dec 2005 00:34:57 +0900 (JST)
Message-Id: <20051228.003457.74752441.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	rmk+serial@arm.linux.org.uk, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] serial_txx9: forcibly init the spinlock for PCI UART
 used as a console
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <43B143EE.6070700@ru.mvista.com>
References: <43B06DB4.409@ru.mvista.com>
	<20051227.144551.79070832.nemoto@toshiba-tops.co.jp>
	<43B143EE.6070700@ru.mvista.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Thanks for your comment.

>>>>> On Tue, 27 Dec 2005 16:38:54 +0300, Sergei Shtylylov <sshtylyov@ru.mvista.com> said:

>> The problem is not just only spin_lock_init.  The parameters of
>> "console=" option (baudrate, etc.) are not passed for PCI UART.

sshtylyov>     They are -- uart_add_one_port() calls console setup
sshtylyov> once more when registering PCI UART with serial code.

Yes, you are right.  I missed the register_console call in
uart_add_one_port().  So your patch will fix the problem.  But I
suppose the spinlock should be initialized in serial_core.  How about
this?

--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -2233,7 +2233,7 @@ int uart_add_one_port(struct uart_driver
 	 * If this port is a console, then the spinlock is already
 	 * initialised.
 	 */
-	if (!uart_console(port))
+	if (!(uart_console(port) && (port->cons->flags & CON_ENABLED)))
 		spin_lock_init(&port->lock);
 
 	uart_configure_port(drv, state, port);


>> --- a/drivers/serial/serial_txx9.c
>> +++ b/drivers/serial/serial_txx9.c
>> @@ -937,11 +942,6 @@ static int serial_txx9_console_setup(str
>> return -ENODEV;
>> 
>> /*
>> -	 * Temporary fix.
>> -	 */
>> -	spin_lock_init(&port->lock);
>> -
>> -	/*
>> *	Disable UART interrupts, set DTR and RTS high
>> *	and set speed.
>> */

sshtylyov> Can you tell me, how this is supposed to work with TX49xx
sshtylyov> SOC UARTs? When that spinlock will be init'ed for the
sshtylyov> console port? uart_add_one_port() won't do it, and your
sshtylyov> added code below won't do it either, so I disagree with
sshtylyov> this change (though with "empty" spinlock it will no doubt
sshtylyov> work) since there's nothing to init.

The spinlock is initialized in uart_set_options() which is called
from console setup function.

And this is a revised patch.

 * More strict check in verify_port.  Cleanup.
 * Do not insert a char caused previous overrun.
 * Fix some spin_locks.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/drivers/serial/serial_txx9.c b/drivers/serial/serial_txx9.c
index f10c86d..7f484ad 100644
--- a/drivers/serial/serial_txx9.c
+++ b/drivers/serial/serial_txx9.c
@@ -33,6 +33,9 @@
  *	1.02	Cleanup. (import 8250.c changes)
  *	1.03	Fix low-latency mode. (import 8250.c changes)
  *	1.04	Remove usage of deprecated functions, cleanup.
+ *	1.05	More strict check in verify_port.  Cleanup.
+ *	1.06	Do not insert a char caused previous overrun.
+ *		Fix some spin_locks.
  */
 #include <linux/config.h>
 
@@ -56,7 +59,7 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-static char *serial_version = "1.04";
+static char *serial_version = "1.06";
 static char *serial_name = "TX39/49 Serial driver";
 
 #define PASS_LIMIT	256
@@ -209,7 +212,7 @@ static inline unsigned int sio_in(struct
 {
 	switch (up->port.iotype) {
 	default:
-		return *(volatile u32 *)(up->port.membase + offset);
+		return __raw_readl(up->port.membase + offset);
 	case UPIO_PORT:
 		return inl(up->port.iobase + offset);
 	}
@@ -220,7 +223,7 @@ sio_out(struct uart_txx9_port *up, int o
 {
 	switch (up->port.iotype) {
 	default:
-		*(volatile u32 *)(up->port.membase + offset) = value;
+		__raw_writel(value, up->port.membase + offset);
 		break;
 	case UPIO_PORT:
 		outl(value, up->port.iobase + offset);
@@ -258,34 +261,19 @@ sio_quot_set(struct uart_txx9_port *up, 
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
@@ -301,6 +289,7 @@ receive_chars(struct uart_txx9_port *up,
 	unsigned int disr = *status;
 	int max_count = 256;
 	char flag;
+	unsigned int next_ignore_status_mask;
 
 	do {
 		/* The following is not allowed by the tty layer and
@@ -318,6 +307,9 @@ receive_chars(struct uart_txx9_port *up,
 		flag = TTY_NORMAL;
 		up->port.icount.rx++;
 
+		/* mask out RFDN_MASK bit added by previous overrun */
+		next_ignore_status_mask =
+			up->port.ignore_status_mask & ~TXX9_SIDISR_RFDN_MASK;
 		if (unlikely(disr & (TXX9_SIDISR_UBRK | TXX9_SIDISR_UPER |
 				     TXX9_SIDISR_UFER | TXX9_SIDISR_UOER))) {
 			/*
@@ -338,8 +330,17 @@ receive_chars(struct uart_txx9_port *up,
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
@@ -359,6 +360,7 @@ receive_chars(struct uart_txx9_port *up,
 		uart_insert_char(&up->port, disr, TXX9_SIDISR_UOER, ch, flag);
 
 	ignore_char:
+		up->port.ignore_status_mask = next_ignore_status_mask;
 		disr = sio_in(up, TXX9_SIDISR);
 	} while (!(disr & TXX9_SIDISR_UVALID) && (max_count-- > 0));
 	spin_unlock(&up->port.lock);
@@ -460,14 +462,11 @@ static unsigned int serial_txx9_get_mctr
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
@@ -794,8 +793,13 @@ static void serial_txx9_config_port(stru
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
@@ -937,11 +941,6 @@ static int serial_txx9_console_setup(str
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
@@ -1090,7 +1089,7 @@ static void __devexit serial_txx9_unregi
 	uart->port.type = PORT_UNKNOWN;
 	uart->port.iobase = 0;
 	uart->port.mapbase = 0;
-	uart->port.membase = 0;
+	uart->port.membase = NULL;
 	uart->port.dev = NULL;
 	uart_add_one_port(&serial_txx9_reg, &uart->port);
 	up(&serial_txx9_sem);
@@ -1195,7 +1194,7 @@ static int __init serial_txx9_init(void)
 		serial_txx9_register_ports(&serial_txx9_reg);
 
 #ifdef ENABLE_SERIAL_TXX9_PCI
-		ret = pci_module_init(&serial_txx9_pci_driver);
+		ret = pci_register_driver(&serial_txx9_pci_driver);
 #endif
 	}
 	return ret;
