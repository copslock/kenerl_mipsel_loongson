Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2007 16:09:31 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:27842 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20039114AbXKZQJT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Nov 2007 16:09:19 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IwgTH-0006qF-00; Mon, 26 Nov 2007 17:06:07 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 507EAC2B22; Mon, 26 Nov 2007 17:05:38 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:	linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
cc:	ralf@linux-mips.org, akpm@linux-foundation.org
Date:	Mon, 26 Nov 2007 16:58:03 +0100
Subject: [UPDATED PATCH] IP22ZILOG: fix lockup and sysrq
Message-Id: <20071126160538.507EAC2B22@solo.franken.de>
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

- fix lockup when switching from early console to real console
- make sysrq reliable
- fix panic, if sysrq is issued before console is opened

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/sgi-ip22/ip22-setup.c |   19 ---
 drivers/serial/ip22zilog.c      |  247 +++++++++++++++++----------------------
 include/asm-mips/system.h       |    2 -
 include/linux/serial_core.h     |    2 +-
 4 files changed, 107 insertions(+), 163 deletions(-)

diff --git a/arch/mips/sgi-ip22/ip22-setup.c b/arch/mips/sgi-ip22/ip22-setup.c
index 174f09e..5f389ee 100644
--- a/arch/mips/sgi-ip22/ip22-setup.c
+++ b/arch/mips/sgi-ip22/ip22-setup.c
@@ -31,25 +31,6 @@
 unsigned long sgi_gfxaddr;
 EXPORT_SYMBOL_GPL(sgi_gfxaddr);
 
-/*
- * Stop-A is originally a Sun thing that isn't standard on IP22 so to avoid
- * accidents it's disabled by default on IP22.
- *
- * FIXME: provide a mechanism to change the value of stop_a_enabled.
- */
-int stop_a_enabled;
-
-void ip22_do_break(void)
-{
-	if (!stop_a_enabled)
-		return;
-
-	printk("\n");
-	ArcEnterInteractiveMode();
-}
-
-EXPORT_SYMBOL(ip22_do_break);
-
 extern void ip22_be_init(void) __init;
 
 void __init plat_mem_setup(void)
diff --git a/drivers/serial/ip22zilog.c b/drivers/serial/ip22zilog.c
index f3257f7..9c95bc0 100644
--- a/drivers/serial/ip22zilog.c
+++ b/drivers/serial/ip22zilog.c
@@ -45,8 +45,6 @@
 
 #include "ip22zilog.h"
 
-void ip22_do_break(void);
-
 /*
  * On IP22 we need to delay after register accesses but we do not need to
  * flush writes.
@@ -81,12 +79,9 @@ struct uart_ip22zilog_port {
 #define IP22ZILOG_FLAG_REGS_HELD	0x00000040
 #define IP22ZILOG_FLAG_TX_STOPPED	0x00000080
 #define IP22ZILOG_FLAG_TX_ACTIVE	0x00000100
+#define IP22ZILOG_FLAG_RESET_DONE	0x00000200
 
-	unsigned int			cflag;
-
-	/* L1-A keyboard break state.  */
-	int				kbd_id;
-	int				l1_down;
+	unsigned int			tty_break;
 
 	unsigned char			parity_mask;
 	unsigned char			prev_status;
@@ -250,13 +245,26 @@ static void ip22zilog_maybe_update_regs(struct uart_ip22zilog_port *up,
 	}
 }
 
-static void ip22zilog_receive_chars(struct uart_ip22zilog_port *up,
-				   struct zilog_channel *channel)
+#define Rx_BRK 0x0100                   /* BREAK event software flag.  */
+#define Rx_SYS 0x0200                   /* SysRq event software flag.  */
+
+static struct tty_struct *ip22zilog_receive_chars(struct uart_ip22zilog_port *up,
+						  struct zilog_channel *channel)
 {
-	struct tty_struct *tty = up->port.info->tty;	/* XXX info==NULL? */
+	struct tty_struct *tty;
+	unsigned char ch, flag;
+	unsigned int r1;
+
+	tty = NULL;
+	if (up->port.info != NULL &&
+	    up->port.info->tty != NULL)
+		tty = up->port.info->tty;
 
-	while (1) {
-		unsigned char ch, r1, flag;
+	for (;;) {
+		ch = readb(&channel->control);
+		ZSDELAY();
+		if (!(ch & Rx_CH_AV))
+			break;
 
 		r1 = read_zsreg(channel, R1);
 		if (r1 & (PAR_ERR | Rx_OVR | CRC_ERR)) {
@@ -265,43 +273,26 @@ static void ip22zilog_receive_chars(struct uart_ip22zilog_port *up,
 			ZS_WSYNC(channel);
 		}
 
-		ch = readb(&channel->control);
-		ZSDELAY();
-
-		/* This funny hack depends upon BRK_ABRT not interfering
-		 * with the other bits we care about in R1.
-		 */
-		if (ch & BRK_ABRT)
-			r1 |= BRK_ABRT;
-
 		ch = readb(&channel->data);
 		ZSDELAY();
 
 		ch &= up->parity_mask;
 
-		if (ZS_IS_CONS(up) && (r1 & BRK_ABRT)) {
-			/* Wait for BREAK to deassert to avoid potentially
-			 * confusing the PROM.
-			 */
-			while (1) {
-				ch = readb(&channel->control);
-				ZSDELAY();
-				if (!(ch & BRK_ABRT))
-					break;
-			}
-			ip22_do_break();
-			return;
-		}
+		/* Handle the null char got when BREAK is removed.  */
+		if (!ch)
+			r1 |= up->tty_break;
 
 		/* A real serial line, record the character and status.  */
 		flag = TTY_NORMAL;
 		up->port.icount.rx++;
-		if (r1 & (BRK_ABRT | PAR_ERR | Rx_OVR | CRC_ERR)) {
-			if (r1 & BRK_ABRT) {
-				r1 &= ~(PAR_ERR | CRC_ERR);
+		if (r1 & (PAR_ERR | Rx_OVR | CRC_ERR | Rx_SYS | Rx_BRK)) {
+			up->tty_break = 0;
+
+			if (r1 & (Rx_SYS | Rx_BRK)) {
 				up->port.icount.brk++;
-				if (uart_handle_break(&up->port))
-					goto next_char;
+				if (r1 & Rx_SYS)
+					continue;
+				r1 &= ~(PAR_ERR | CRC_ERR);
 			}
 			else if (r1 & PAR_ERR)
 				up->port.icount.parity++;
@@ -310,30 +301,21 @@ static void ip22zilog_receive_chars(struct uart_ip22zilog_port *up,
 			if (r1 & Rx_OVR)
 				up->port.icount.overrun++;
 			r1 &= up->port.read_status_mask;
-			if (r1 & BRK_ABRT)
+			if (r1 & Rx_BRK)
 				flag = TTY_BREAK;
 			else if (r1 & PAR_ERR)
 				flag = TTY_PARITY;
 			else if (r1 & CRC_ERR)
 				flag = TTY_FRAME;
 		}
-		if (uart_handle_sysrq_char(&up->port, ch))
-			goto next_char;
 
-		if (up->port.ignore_status_mask == 0xff ||
-		    (r1 & up->port.ignore_status_mask) == 0)
-		    	tty_insert_flip_char(tty, ch, flag);
+		if (uart_handle_sysrq_char(&up->port, ch))
+			continue;
 
-		if (r1 & Rx_OVR)
-			tty_insert_flip_char(tty, 0, TTY_OVERRUN);
-	next_char:
-		ch = readb(&channel->control);
-		ZSDELAY();
-		if (!(ch & Rx_CH_AV))
-			break;
+		if (tty)
+			uart_insert_char(&up->port, r1, Rx_OVR, ch, flag);
 	}
-
-	tty_flip_buffer_push(tty);
+	return tty;
 }
 
 static void ip22zilog_status_handle(struct uart_ip22zilog_port *up,
@@ -348,6 +330,15 @@ static void ip22zilog_status_handle(struct uart_ip22zilog_port *up,
 	ZSDELAY();
 	ZS_WSYNC(channel);
 
+	if (up->curregs[R15] & BRKIE) {
+		if ((status & BRK_ABRT) && !(up->prev_status & BRK_ABRT)) {
+			if (uart_handle_break(&up->port))
+				up->tty_break = Rx_SYS;
+			else
+				up->tty_break = Rx_BRK;
+		}
+	}
+
 	if (ZS_WANTS_MODEM_STATUS(up)) {
 		if (status & SYNC)
 			up->port.icount.dsr++;
@@ -356,10 +347,10 @@ static void ip22zilog_status_handle(struct uart_ip22zilog_port *up,
 		 * But it does not tell us which bit has changed, we have to keep
 		 * track of this ourselves.
 		 */
-		if ((status & DCD) ^ up->prev_status)
+		if ((status ^ up->prev_status) ^ DCD)
 			uart_handle_dcd_change(&up->port,
 					       (status & DCD));
-		if ((status & CTS) ^ up->prev_status)
+		if ((status ^ up->prev_status) ^ CTS)
 			uart_handle_cts_change(&up->port,
 					       (status & CTS));
 
@@ -447,19 +438,21 @@ static irqreturn_t ip22zilog_interrupt(int irq, void *dev_id)
 	while (up) {
 		struct zilog_channel *channel
 			= ZILOG_CHANNEL_FROM_PORT(&up->port);
+		struct tty_struct *tty;
 		unsigned char r3;
 
 		spin_lock(&up->port.lock);
 		r3 = read_zsreg(channel, R3);
 
 		/* Channel A */
+		tty = NULL;
 		if (r3 & (CHAEXT | CHATxIP | CHARxIP)) {
 			writeb(RES_H_IUS, &channel->control);
 			ZSDELAY();
 			ZS_WSYNC(channel);
 
 			if (r3 & CHARxIP)
-				ip22zilog_receive_chars(up, channel);
+				tty = ip22zilog_receive_chars(up, channel);
 			if (r3 & CHAEXT)
 				ip22zilog_status_handle(up, channel);
 			if (r3 & CHATxIP)
@@ -467,18 +460,22 @@ static irqreturn_t ip22zilog_interrupt(int irq, void *dev_id)
 		}
 		spin_unlock(&up->port.lock);
 
+		if (tty)
+			tty_flip_buffer_push(tty);
+
 		/* Channel B */
 		up = up->next;
 		channel = ZILOG_CHANNEL_FROM_PORT(&up->port);
 
 		spin_lock(&up->port.lock);
+		tty = NULL;
 		if (r3 & (CHBEXT | CHBTxIP | CHBRxIP)) {
 			writeb(RES_H_IUS, &channel->control);
 			ZSDELAY();
 			ZS_WSYNC(channel);
 
 			if (r3 & CHBRxIP)
-				ip22zilog_receive_chars(up, channel);
+				tty = ip22zilog_receive_chars(up, channel);
 			if (r3 & CHBEXT)
 				ip22zilog_status_handle(up, channel);
 			if (r3 & CHBTxIP)
@@ -486,6 +483,9 @@ static irqreturn_t ip22zilog_interrupt(int irq, void *dev_id)
 		}
 		spin_unlock(&up->port.lock);
 
+		if (tty)
+			tty_flip_buffer_push(tty);
+
 		up = up->next;
 	}
 
@@ -681,11 +681,46 @@ static void ip22zilog_break_ctl(struct uart_port *port, int break_state)
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
+static void __ip22zilog_reset(struct uart_ip22zilog_port *up)
+{
+	struct zilog_channel *channel;
+	int i;
+
+	if (up->flags & IP22ZILOG_FLAG_RESET_DONE)
+		return;
+
+	/* Let pending transmits finish.  */
+	channel = ZILOG_CHANNEL_FROM_PORT(&up->port);
+	for (i = 0; i < 1000; i++) {
+		unsigned char stat = read_zsreg(channel, R1);
+		if (stat & ALL_SNT)
+			break;
+		udelay(100);
+	}
+
+	if (!ZS_IS_CHANNEL_A(up)) {
+		up++;
+		channel = ZILOG_CHANNEL_FROM_PORT(&up->port);
+	}
+	write_zsreg(channel, R9, FHWRES);
+	ZSDELAY_LONG();
+	(void) read_zsreg(channel, R0);
+
+	up->flags |= IP22ZILOG_FLAG_RESET_DONE;
+	up->next->flags |= IP22ZILOG_FLAG_RESET_DONE;
+}
+
 static void __ip22zilog_startup(struct uart_ip22zilog_port *up)
 {
 	struct zilog_channel *channel;
 
 	channel = ZILOG_CHANNEL_FROM_PORT(&up->port);
+
+	__ip22zilog_reset(up);
+
+	__load_zsregs(channel, up->curregs);
+	/* set master interrupt enable */
+	write_zsreg(channel, R9, up->curregs[R9]);
 	up->prev_status = readb(&channel->control);
 
 	/* Enable receiver and transmitter.  */
@@ -859,8 +894,6 @@ ip22zilog_set_termios(struct uart_port *port, struct ktermios *termios,
 	else
 		up->flags &= ~IP22ZILOG_FLAG_MODEM_STATUS;
 
-	up->cflag = termios->c_cflag;
-
 	ip22zilog_maybe_update_regs(up, ZILOG_CHANNEL_FROM_PORT(port));
 	uart_update_timeout(port, termios->c_cflag, baud);
 
@@ -992,74 +1025,29 @@ ip22zilog_console_write(struct console *con, const char *s, unsigned int count)
 	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
-void
-ip22serial_console_termios(struct console *con, char *options)
-{
-	int baud = 9600, bits = 8, cflag;
-	int parity = 'n';
-	int flow = 'n';
-
-	if (options)
-		uart_parse_options(options, &baud, &parity, &bits, &flow);
-
-	cflag = CREAD | HUPCL | CLOCAL;
-
-	switch (baud) {
-		case 150: cflag |= B150; break;
-		case 300: cflag |= B300; break;
-		case 600: cflag |= B600; break;
-		case 1200: cflag |= B1200; break;
-		case 2400: cflag |= B2400; break;
-		case 4800: cflag |= B4800; break;
-		case 9600: cflag |= B9600; break;
-		case 19200: cflag |= B19200; break;
-		case 38400: cflag |= B38400; break;
-		default: baud = 9600; cflag |= B9600; break;
-	}
-
-	con->cflag = cflag | CS8;			/* 8N1 */
-
-	uart_update_timeout(&ip22zilog_port_table[con->index].port, cflag, baud);
-}
-
 static int __init ip22zilog_console_setup(struct console *con, char *options)
 {
 	struct uart_ip22zilog_port *up = &ip22zilog_port_table[con->index];
 	unsigned long flags;
-	int baud, brg;
-
-	printk("Console: ttyS%d (IP22-Zilog)\n", con->index);
+	int baud = 9600, bits = 8;
+	int parity = 'n';
+	int flow = 'n';
 
-	/* Get firmware console settings.  */
-	ip22serial_console_termios(con, options);
+	up->flags |= IP22ZILOG_FLAG_IS_CONS;
 
-	/* Firmware console speed is limited to 150-->38400 baud so
-	 * this hackish cflag thing is OK.
-	 */
-	switch (con->cflag & CBAUD) {
-	case B150: baud = 150; break;
-	case B300: baud = 300; break;
-	case B600: baud = 600; break;
-	case B1200: baud = 1200; break;
-	case B2400: baud = 2400; break;
-	case B4800: baud = 4800; break;
-	default: case B9600: baud = 9600; break;
-	case B19200: baud = 19200; break;
-	case B38400: baud = 38400; break;
-	};
-
-	brg = BPS_TO_BRG(baud, ZS_CLOCK / ZS_CLOCK_DIVISOR);
+	printk(KERN_INFO "Console: ttyS%d (IP22-Zilog)\n", con->index);
 
 	spin_lock_irqsave(&up->port.lock, flags);
 
-	up->curregs[R15] = BRKIE;
-	ip22zilog_convert_to_zs(up, con->cflag, 0, brg);
+	up->curregs[R15] |= BRKIE;
 
 	__ip22zilog_startup(up);
 
 	spin_unlock_irqrestore(&up->port.lock, flags);
 
-	return 0;
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+	return uart_set_options(&up->port, con, baud, parity, bits, flow);
 }
 
 static struct uart_driver ip22zilog_reg;
@@ -1140,25 +1128,10 @@ static void __init ip22zilog_prepare(void)
 		up[(chip * 2) + 1].port.line = (chip * 2) + 1;
 		up[(chip * 2) + 1].flags |= IP22ZILOG_FLAG_IS_CHANNEL_A;
 	}
-}
-
-static void __init ip22zilog_init_hw(void)
-{
-	int i;
-
-	for (i = 0; i < NUM_CHANNELS; i++) {
-		struct uart_ip22zilog_port *up = &ip22zilog_port_table[i];
-		struct zilog_channel *channel = ZILOG_CHANNEL_FROM_PORT(&up->port);
-		unsigned long flags;
-		int baud, brg;
 
-		spin_lock_irqsave(&up->port.lock, flags);
-
-		if (ZS_IS_CHANNEL_A(up)) {
-			write_zsreg(channel, R9, FHWRES);
-			ZSDELAY_LONG();
-			(void) read_zsreg(channel, R0);
-		}
+	for (channel = 0; channel < NUM_CHANNELS; channel++) {
+		struct uart_ip22zilog_port *up = &ip22zilog_port_table[channel];
+		int brg;
 
 		/* Normal serial TTY. */
 		up->parity_mask = 0xff;
@@ -1169,16 +1142,10 @@ static void __init ip22zilog_init_hw(void)
 		up->curregs[R9] = NV | MIE;
 		up->curregs[R10] = NRZ;
 		up->curregs[R11] = TCBR | RCBR;
-		baud = 9600;
-		brg = BPS_TO_BRG(baud, ZS_CLOCK / ZS_CLOCK_DIVISOR);
+		brg = BPS_TO_BRG(9600, ZS_CLOCK / ZS_CLOCK_DIVISOR);
 		up->curregs[R12] = (brg & 0xff);
 		up->curregs[R13] = (brg >> 8) & 0xff;
 		up->curregs[R14] = BRENAB;
-		__load_zsregs(channel, up->curregs);
-	        /* set master interrupt enable */
-	        write_zsreg(channel, R9, up->curregs[R9]);
-
-		spin_unlock_irqrestore(&up->port.lock, flags);
 	}
 }
 
@@ -1195,8 +1162,6 @@ static int __init ip22zilog_ports_init(void)
 		panic("IP22-Zilog: Unable to register zs interrupt handler.\n");
 	}
 
-	ip22zilog_init_hw();
-
 	ret = uart_register_driver(&ip22zilog_reg);
 	if (ret == 0) {
 		int i;
diff --git a/include/asm-mips/system.h b/include/asm-mips/system.h
index 1030562..a944eda 100644
--- a/include/asm-mips/system.h
+++ b/include/asm-mips/system.h
@@ -209,8 +209,6 @@ extern void *set_except_vector(int n, void *addr);
 extern unsigned long ebase;
 extern void per_cpu_trap_init(void);
 
-extern int stop_a_enabled;
-
 /*
  * See include/asm-ia64/system.h; prevents deadlock on SMP
  * systems.
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 6a5203f..9963f81 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -437,7 +437,7 @@ uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
 #ifdef SUPPORT_SYSRQ
 	if (port->sysrq) {
 		if (ch && time_before(jiffies, port->sysrq)) {
-			handle_sysrq(ch, port->info->tty);
+			handle_sysrq(ch, port->info ? port->info->tty : NULL);
 			port->sysrq = 0;
 			return 1;
 		}
-- 
1.4.4.4
