Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Apr 2006 17:11:17 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:26640 "HELO
	sorrow.cyrius.com") by ftp.linux-mips.org with SMTP
	id S8133545AbWDGQKo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Apr 2006 17:10:44 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 6118264D3E; Fri,  7 Apr 2006 16:22:03 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id DA12266B68; Fri,  7 Apr 2006 18:21:53 +0200 (CEST)
Date:	Fri, 7 Apr 2006 18:21:53 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Russell King <rmk@arm.linux.org.uk>
Cc:	linux-mips@linux-mips.org
Subject: Re: IP22 doesn't shutdown properly
Message-ID: <20060407162153.GK6869@deprecation.cyrius.com>
References: <20060217225824.GE20785@deprecation.cyrius.com> <20060223221350.GA5239@deprecation.cyrius.com> <20060224190517.GA28013@lst.de> <20060227105236.GI12044@deprecation.cyrius.com> <20060325173450.GC6100@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060325173450.GC6100@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11+cvs20060330
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Russell King <rmk@arm.linux.org.uk> [2006-03-25 17:34]:
> > -		if ((status & DCD) ^ up->prev_status)
> > +		if ((status ^ up->prev_status) ^ DCD)
> Shouldn't this be (status ^ up->prev_status) & DCD ?
> 
> > -		if ((status & CTS) ^ up->prev_status)
> > +		if ((status ^ up->prev_status) ^ CTS)
> Shouldn't this be (status ^ up->prev_status) & CTS ?

Thanks for catching this!  I obviously copied too much from sunzilog.c
without thinking.  Below is a new version which has this fix and which
has been updated so it apples to 2.6.17-rc1.


[PATCH] Sync ip22zilog with latest sunzilog driver

ip22zilog is based on the sunzilog driver, but there hasn't been a sync
since 2.6.0-test7.  Sync the relevant changes that have been made since
then.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- a/drivers/serial/ip22zilog.c
+++ b/drivers/serial/ip22zilog.c
@@ -2,7 +2,7 @@
  * Driver for Zilog serial chips found on SGI workstations and
  * servers.  This driver could actually be made more generic.
  *
- * This is based on the drivers/serial/sunzilog.c code as of 2.6.0-test7 and the
+ * This is based on the drivers/serial/sunzilog.c code as of 2.6.17-rc1 and the
  * old drivers/sgi/char/sgiserial.c code which itself is based of the original
  * drivers/sbus/char/zs.c code.  A lot of code has been simply moved over
  * directly from there but much has been rewritten.  Credits therefore go out
@@ -86,15 +86,11 @@ struct uart_ip22zilog_port {
 
 	unsigned int			cflag;
 
-	/* L1-A keyboard break state.  */
-	int				kbd_id;
-	int				l1_down;
-
 	unsigned char			parity_mask;
 	unsigned char			prev_status;
 };
 
-#define ZILOG_CHANNEL_FROM_PORT(PORT)	((struct zilog_channel *)((PORT)->membase))
+#define ZILOG_CHANNEL_FROM_PORT(PORT)	((struct zilog_channel __iomem *)((PORT)->membase))
 #define UART_ZILOG(PORT)		((struct uart_ip22zilog_port *)(PORT))
 #define IP22ZILOG_GET_CURR_REG(PORT, REGNUM)		\
 	(UART_ZILOG(PORT)->curregs[REGNUM])
@@ -116,7 +112,7 @@ struct uart_ip22zilog_port {
  * The port lock must be held and local IRQs must be disabled
  * when {read,write}_zsreg is invoked.
  */
-static unsigned char read_zsreg(struct zilog_channel *channel,
+static unsigned char read_zsreg(struct zilog_channel __iomem *channel,
 				unsigned char reg)
 {
 	unsigned char retval;
@@ -129,7 +125,7 @@ static unsigned char read_zsreg(struct z
 	return retval;
 }
 
-static void write_zsreg(struct zilog_channel *channel,
+static void write_zsreg(struct zilog_channel __iomem *channel,
 			unsigned char reg, unsigned char value)
 {
 	writeb(reg, &channel->control);
@@ -138,7 +134,7 @@ static void write_zsreg(struct zilog_cha
 	ZSDELAY();
 }
 
-static void ip22zilog_clear_fifo(struct zilog_channel *channel)
+static void ip22zilog_clear_fifo(struct zilog_channel __iomem *channel)
 {
 	int i;
 
@@ -165,7 +161,7 @@ static void ip22zilog_clear_fifo(struct 
 /* This function must only be called when the TX is not busy.  The UART
  * port lock must be held and local interrupts disabled.
  */
-static void __load_zsregs(struct zilog_channel *channel, unsigned char *regs)
+static void __load_zsregs(struct zilog_channel __iomem *channel, unsigned char *regs)
 {
 	int i;
 
@@ -241,7 +237,7 @@ static void __load_zsregs(struct zilog_c
  * The UART port lock must be held and local interrupts disabled.
  */
 static void ip22zilog_maybe_update_regs(struct uart_ip22zilog_port *up,
-				       struct zilog_channel *channel)
+				       struct zilog_channel __iomem *channel)
 {
 	if (!ZS_REGS_HELD(up)) {
 		if (ZS_TX_ACTIVE(up)) {
@@ -252,14 +248,20 @@ static void ip22zilog_maybe_update_regs(
 	}
 }
 
-static void ip22zilog_receive_chars(struct uart_ip22zilog_port *up,
-				   struct zilog_channel *channel,
-				   struct pt_regs *regs)
-{
-	struct tty_struct *tty = up->port.info->tty;	/* XXX info==NULL? */
+static struct tty_struct *
+ip22zilog_receive_chars(struct uart_ip22zilog_port *up,
+			struct zilog_channel __iomem *channel,
+			struct pt_regs *regs)
+{
+	struct tty_struct *tty;
+	unsigned char ch, r1, flag;
+
+	tty = NULL;
+	if (up->port.info != NULL &&		/* Unopened serial console */
+	    up->port.info->tty != NULL)		/* Keyboard || mouse */
+		tty = up->port.info->tty;
 
 	while (1) {
-		unsigned char ch, r1, flag;
 
 		r1 = read_zsreg(channel, R1);
 		if (r1 & (PAR_ERR | Rx_OVR | CRC_ERR)) {
@@ -277,23 +279,17 @@ static void ip22zilog_receive_chars(stru
 		if (ch & BRK_ABRT)
 			r1 |= BRK_ABRT;
 
+		if (!(ch & Rx_CH_AV))
+			break;
+
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
+		if (tty == NULL) {
+			uart_handle_sysrq_char(&up->port, ch, regs);
+			continue;
 		}
 
 		/* A real serial line, record the character and status.  */
@@ -304,7 +300,7 @@ static void ip22zilog_receive_chars(stru
 				r1 &= ~(PAR_ERR | CRC_ERR);
 				up->port.icount.brk++;
 				if (uart_handle_break(&up->port))
-					goto next_char;
+					continue;
 			}
 			else if (r1 & PAR_ERR)
 				up->port.icount.parity++;
@@ -321,7 +317,7 @@ static void ip22zilog_receive_chars(stru
 				flag = TTY_FRAME;
 		}
 		if (uart_handle_sysrq_char(&up->port, ch, regs))
-			goto next_char;
+			continue;
 
 		if (up->port.ignore_status_mask == 0xff ||
 		    (r1 & up->port.ignore_status_mask) == 0)
@@ -329,18 +325,13 @@ static void ip22zilog_receive_chars(stru
 
 		if (r1 & Rx_OVR)
 			tty_insert_flip_char(tty, 0, TTY_OVERRUN);
-	next_char:
-		ch = readb(&channel->control);
-		ZSDELAY();
-		if (!(ch & Rx_CH_AV))
-			break;
 	}
 
-	tty_flip_buffer_push(tty);
+	return tty;
 }
 
 static void ip22zilog_status_handle(struct uart_ip22zilog_port *up,
-				   struct zilog_channel *channel,
+				   struct zilog_channel __iomem *channel,
 				   struct pt_regs *regs)
 {
 	unsigned char status;
@@ -352,6 +343,22 @@ static void ip22zilog_status_handle(stru
 	ZSDELAY();
 	ZS_WSYNC(channel);
 
+	if (status & BRK_ABRT) {
+		if (ZS_IS_CONS(up)) {
+			/* Wait for BREAK to deassert to avoid potentially
+			 * confusing the PROM.
+			 */
+			while (1) {
+				status = readb(&channel->control);
+				ZSDELAY();
+				if (!(status & BRK_ABRT))
+					break;
+			}
+			ip22_do_break();
+			return;
+		}
+	}
+
 	if (ZS_WANTS_MODEM_STATUS(up)) {
 		if (status & SYNC)
 			up->port.icount.dsr++;
@@ -360,10 +367,10 @@ static void ip22zilog_status_handle(stru
 		 * But it does not tell us which bit has changed, we have to keep
 		 * track of this ourselves.
 		 */
-		if ((status & DCD) ^ up->prev_status)
+		if ((status ^ up->prev_status) & DCD)
 			uart_handle_dcd_change(&up->port,
 					       (status & DCD));
-		if ((status & CTS) ^ up->prev_status)
+		if ((status ^ up->prev_status) & CTS)
 			uart_handle_cts_change(&up->port,
 					       (status & CTS));
 
@@ -374,7 +381,7 @@ static void ip22zilog_status_handle(stru
 }
 
 static void ip22zilog_transmit_chars(struct uart_ip22zilog_port *up,
-				    struct zilog_channel *channel)
+				    struct zilog_channel __iomem *channel)
 {
 	struct circ_buf *xmit;
 
@@ -449,21 +456,23 @@ static irqreturn_t ip22zilog_interrupt(i
 	struct uart_ip22zilog_port *up = dev_id;
 
 	while (up) {
-		struct zilog_channel *channel
+		struct zilog_channel __iomem *channel
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
-				ip22zilog_receive_chars(up, channel, regs);
+				tty = ip22zilog_receive_chars(up, channel, regs);
 			if (r3 & CHAEXT)
 				ip22zilog_status_handle(up, channel, regs);
 			if (r3 & CHATxIP)
@@ -471,18 +480,22 @@ static irqreturn_t ip22zilog_interrupt(i
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
-				ip22zilog_receive_chars(up, channel, regs);
+				tty = ip22zilog_receive_chars(up, channel, regs);
 			if (r3 & CHBEXT)
 				ip22zilog_status_handle(up, channel, regs);
 			if (r3 & CHBTxIP)
@@ -490,6 +503,9 @@ static irqreturn_t ip22zilog_interrupt(i
 		}
 		spin_unlock(&up->port.lock);
 
+		if (tty)
+			tty_flip_buffer_push(tty);
+
 		up = up->next;
 	}
 
@@ -501,7 +517,7 @@ static irqreturn_t ip22zilog_interrupt(i
  */
 static __inline__ unsigned char ip22zilog_read_channel_status(struct uart_port *port)
 {
-	struct zilog_channel *channel;
+	struct zilog_channel __iomem *channel;
 	unsigned char status;
 
 	channel = ZILOG_CHANNEL_FROM_PORT(port);
@@ -555,7 +571,7 @@ static unsigned int ip22zilog_get_mctrl(
 static void ip22zilog_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	struct uart_ip22zilog_port *up = (struct uart_ip22zilog_port *) port;
-	struct zilog_channel *channel = ZILOG_CHANNEL_FROM_PORT(port);
+	struct zilog_channel __iomem *channel = ZILOG_CHANNEL_FROM_PORT(port);
 	unsigned char set_bits, clear_bits;
 
 	set_bits = clear_bits = 0;
@@ -587,7 +603,7 @@ static void ip22zilog_stop_tx(struct uar
 static void ip22zilog_start_tx(struct uart_port *port)
 {
 	struct uart_ip22zilog_port *up = (struct uart_ip22zilog_port *) port;
-	struct zilog_channel *channel = ZILOG_CHANNEL_FROM_PORT(port);
+	struct zilog_channel __iomem *channel = ZILOG_CHANNEL_FROM_PORT(port);
 	unsigned char status;
 
 	up->flags |= IP22ZILOG_FLAG_TX_ACTIVE;
@@ -629,7 +645,7 @@ static void ip22zilog_start_tx(struct ua
 static void ip22zilog_stop_rx(struct uart_port *port)
 {
 	struct uart_ip22zilog_port *up = UART_ZILOG(port);
-	struct zilog_channel *channel;
+	struct zilog_channel __iomem *channel;
 
 	if (ZS_IS_CONS(up))
 		return;
@@ -645,7 +661,7 @@ static void ip22zilog_stop_rx(struct uar
 static void ip22zilog_enable_ms(struct uart_port *port)
 {
 	struct uart_ip22zilog_port *up = (struct uart_ip22zilog_port *) port;
-	struct zilog_channel *channel = ZILOG_CHANNEL_FROM_PORT(port);
+	struct zilog_channel __iomem *channel = ZILOG_CHANNEL_FROM_PORT(port);
 	unsigned char new_reg;
 
 	new_reg = up->curregs[R15] | (DCDIE | SYNCIE | CTSIE);
@@ -661,7 +677,7 @@ static void ip22zilog_enable_ms(struct u
 static void ip22zilog_break_ctl(struct uart_port *port, int break_state)
 {
 	struct uart_ip22zilog_port *up = (struct uart_ip22zilog_port *) port;
-	struct zilog_channel *channel = ZILOG_CHANNEL_FROM_PORT(port);
+	struct zilog_channel __iomem *channel = ZILOG_CHANNEL_FROM_PORT(port);
 	unsigned char set_bits, clear_bits, new_reg;
 	unsigned long flags;
 
@@ -687,7 +703,7 @@ static void ip22zilog_break_ctl(struct u
 
 static void __ip22zilog_startup(struct uart_ip22zilog_port *up)
 {
-	struct zilog_channel *channel;
+	struct zilog_channel __iomem *channel;
 
 	channel = ZILOG_CHANNEL_FROM_PORT(&up->port);
 	up->prev_status = readb(&channel->control);
@@ -742,7 +758,7 @@ static int ip22zilog_startup(struct uart
 static void ip22zilog_shutdown(struct uart_port *port)
 {
 	struct uart_ip22zilog_port *up = UART_ZILOG(port);
-	struct zilog_channel *channel;
+	struct zilog_channel __iomem *channel;
 	unsigned long flags;
 
 	if (ZS_IS_CONS(up))
@@ -918,7 +934,7 @@ static struct uart_ops ip22zilog_pops = 
 };
 
 static struct uart_ip22zilog_port *ip22zilog_port_table;
-static struct zilog_layout **ip22zilog_chip_regs;
+static struct zilog_layout __iomem **ip22zilog_chip_regs;
 
 static struct uart_ip22zilog_port *ip22zilog_irq_chain;
 static int zilog_irq = -1;
@@ -936,10 +952,10 @@ static void * __init alloc_one_table(uns
 
 static void __init ip22zilog_alloc_tables(void)
 {
-	ip22zilog_port_table = (struct uart_ip22zilog_port *)
+	ip22zilog_port_table =
 		alloc_one_table(NUM_CHANNELS * sizeof(struct uart_ip22zilog_port));
-	ip22zilog_chip_regs = (struct zilog_layout **)
-		alloc_one_table(NUM_IP22ZILOG * sizeof(struct zilog_layout *));
+	ip22zilog_chip_regs =
+		alloc_one_table(NUM_IP22ZILOG * sizeof(struct zilog_layout __iomem *));
 
 	if (ip22zilog_port_table == NULL || ip22zilog_chip_regs == NULL) {
 		panic("IP22-Zilog: Cannot allocate IP22-Zilog tables.");
@@ -947,7 +963,7 @@ static void __init ip22zilog_alloc_table
 }
 
 /* Get the address of the registers for IP22-Zilog instance CHIP.  */
-static struct zilog_layout * __init get_zs(int chip)
+static struct zilog_layout __iomem * __init get_zs(int chip)
 {
 	unsigned long base;
 
@@ -961,13 +977,13 @@ static struct zilog_layout * __init get_
 	zilog_irq = SGI_SERIAL_IRQ;
 	request_mem_region(base, 8, "IP22-Zilog");
 
-	return (struct zilog_layout *) base;
+	return (struct zilog_layout __iomem *) base;
 }
 
 #define ZS_PUT_CHAR_MAX_DELAY	2000	/* 10 ms */
 
 #ifdef CONFIG_SERIAL_IP22_ZILOG_CONSOLE
-static void ip22zilog_put_char(struct uart_port *port, int ch)
+static void ip22zilog_putchar(struct uart_port *port, int ch)
 {
 	struct zilog_channel *channel = ZILOG_CHANNEL_FROM_PORT(port);
 	int loops = ZS_PUT_CHAR_MAX_DELAY;
@@ -996,7 +1012,7 @@ ip22zilog_console_write(struct console *
 	unsigned long flags;
 
 	spin_lock_irqsave(&up->port.lock, flags);
-	uart_console_write(&up->port, s, count, ip22zilog_put_char);
+	uart_console_write(&up->port, s, count, ip22zilog_putchar);
 	udelay(2);
 	spin_unlock_irqrestore(&up->port.lock, flags);
 }
@@ -1098,7 +1114,7 @@ static struct uart_driver ip22zilog_reg 
 static void __init ip22zilog_prepare(void)
 {
 	struct uart_ip22zilog_port *up;
-	struct zilog_layout *rp;
+	struct zilog_layout __iomem *rp;
 	int channel, chip;
 
 	/*
@@ -1117,8 +1133,8 @@ static void __init ip22zilog_prepare(voi
 		if (!ip22zilog_chip_regs[chip]) {
 			ip22zilog_chip_regs[chip] = rp = get_zs(chip);
 
-			up[(chip * 2) + 0].port.membase = (char *) &rp->channelB;
-			up[(chip * 2) + 1].port.membase = (char *) &rp->channelA;
+			up[(chip * 2) + 0].port.membase = (void __iomem *) &rp->channelB;
+			up[(chip * 2) + 1].port.membase = (void __iomem *) &rp->channelA;
 
 			/* In theory mapbase is the physical address ...  */
 			up[(chip * 2) + 0].port.mapbase =
@@ -1157,7 +1173,7 @@ static void __init ip22zilog_init_hw(voi
 
 	for (i = 0; i < NUM_CHANNELS; i++) {
 		struct uart_ip22zilog_port *up = &ip22zilog_port_table[i];
-		struct zilog_channel *channel = ZILOG_CHANNEL_FROM_PORT(&up->port);
+		struct zilog_channel __iomem *channel = ZILOG_CHANNEL_FROM_PORT(&up->port);
 		unsigned long flags;
 		int baud, brg;
 

-- 
Martin Michlmayr
http://www.cyrius.com/
