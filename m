Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Oct 2007 12:18:08 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:48290 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20027093AbXJZLR7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 26 Oct 2007 12:17:59 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id E942F400DE;
	Fri, 26 Oct 2007 13:17:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id sXfpzyNb3WpU; Fri, 26 Oct 2007 13:17:21 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 6DFD84007F;
	Fri, 26 Oct 2007 13:17:21 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9QBHNUY024690;
	Fri, 26 Oct 2007 13:17:25 +0200
Date:	Fri, 26 Oct 2007 12:17:20 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
cc:	linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dz.c: Resource management
Message-ID: <Pine.LNX.4.64N.0710261038150.26339@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4598/Fri Oct 26 08:52:26 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 This is a set of changes to implement proper resource management in the 
driver, including iomem space reservation and operating on physical 
addresses ioremap()ped appropriately using accessory functions rather than 
unportable direct assignments.  Some adjustments to code are made to 
reflect the architecture of the interface, which is a centrally controlled 
multiport (or, as referred to from DEC documentation, a serial line 
multiplexer, going up to 8 lines originally) rather than a bundle of 
separate ports.  Types are changed, where applicable, to specify the width 
of hardware registers explicitly.  The interrupt handler is now managed in 
the ->startup() and ->shutdown() calls for consistency with other drivers 
and also in preparation to handle the handover from the initial 
firmware-based console gracefully.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 Tested with checkpatch.pl and at the run-time -- MIPS/Linux on a
DECstation 5000/200.

 Please apply,

  Maciej

patch-mips-2.6.23-rc5-20070904-dz-resource-11
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/drivers/serial/dz.c linux-mips-2.6.23-rc5-20070904/drivers/serial/dz.c
--- linux-mips-2.6.23-rc5-20070904.macro/drivers/serial/dz.c	2007-10-13 22:26:49.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/drivers/serial/dz.c	2007-10-14 00:49:58.000000000 +0000
@@ -39,6 +39,7 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/major.h>
 #include <linux/module.h>
@@ -47,7 +48,9 @@
 #include <linux/sysrq.h>
 #include <linux/tty.h>
 
+#include <asm/atomic.h>
 #include <asm/bootinfo.h>
+#include <asm/io.h>
 #include <asm/system.h>
 
 #include <asm/dec/interrupts.h>
@@ -55,18 +58,32 @@
 #include <asm/dec/kn02.h>
 #include <asm/dec/machtype.h>
 #include <asm/dec/prom.h>
+#include <asm/dec/system.h>
 
 #include "dz.h"
 
-static char *dz_name = "DECstation DZ serial driver version ";
-static char *dz_version = "1.03";
+
+MODULE_DESCRIPTION("DECstation DZ serial driver");
+MODULE_LICENSE("GPL");
+
+
+static char dz_name[] __initdata = "DECstation DZ serial driver version ";
+static char dz_version[] __initdata = "1.04";
 
 struct dz_port {
+	struct dz_mux		*mux;
 	struct uart_port	port;
 	unsigned int		cflag;
 };
 
-static struct dz_port dz_ports[DZ_NB_PORT];
+struct dz_mux {
+	struct dz_port		dport[DZ_NB_PORT];
+	atomic_t		map_guard;
+	atomic_t		irq_guard;
+	int			initialised;
+};
+
+static struct dz_mux dz_mux;
 
 static inline struct dz_port *to_dport(struct uart_port *uport)
 {
@@ -82,21 +99,18 @@ static inline struct dz_port *to_dport(s
  * ------------------------------------------------------------
  */
 
-static inline unsigned short dz_in(struct dz_port *dport, unsigned offset)
+static u16 dz_in(struct dz_port *dport, unsigned offset)
 {
-	volatile unsigned short *addr =
-		(volatile unsigned short *) (dport->port.membase + offset);
+	void __iomem *addr = dport->port.membase + offset;
 
-	return *addr;
+	return readw(addr);
 }
 
-static inline void dz_out(struct dz_port *dport, unsigned offset,
-                          unsigned short value)
+static void dz_out(struct dz_port *dport, unsigned offset, u16 value)
 {
-	volatile unsigned short *addr =
-		(volatile unsigned short *) (dport->port.membase + offset);
+	void __iomem *addr = dport->port.membase + offset;
 
-	*addr = value;
+	writew(value, addr);
 }
 
 /*
@@ -112,7 +126,7 @@ static inline void dz_out(struct dz_port
 static void dz_stop_tx(struct uart_port *uport)
 {
 	struct dz_port *dport = to_dport(uport);
-	unsigned short tmp, mask = 1 << dport->port.line;
+	u16 tmp, mask = 1 << dport->port.line;
 
 	tmp = dz_in(dport, DZ_TCR);	/* read the TX flag */
 	tmp &= ~mask;			/* clear the TX flag */
@@ -122,7 +136,7 @@ static void dz_stop_tx(struct uart_port 
 static void dz_start_tx(struct uart_port *uport)
 {
 	struct dz_port *dport = to_dport(uport);
-	unsigned short tmp, mask = 1 << dport->port.line;
+	u16 tmp, mask = 1 << dport->port.line;
 
 	tmp = dz_in(dport, DZ_TCR);	/* read the TX flag */
 	tmp |= mask;			/* set the TX flag */
@@ -137,7 +151,7 @@ static void dz_stop_rx(struct uart_port 
 	dz_out(dport, DZ_LPR, dport->cflag | dport->port.line);
 }
 
-static void dz_enable_ms(struct uart_port *port)
+static void dz_enable_ms(struct uart_port *uport)
 {
 	/* nothing to do */
 }
@@ -169,19 +183,19 @@ static void dz_enable_ms(struct uart_por
  * This routine deals with inputs from any lines.
  * ------------------------------------------------------------
  */
-static inline void dz_receive_chars(struct dz_port *dport_in)
+static inline void dz_receive_chars(struct dz_mux *mux)
 {
 	struct uart_port *uport;
-	struct dz_port *dport;
+	struct dz_port *dport = &mux->dport[0];
 	struct tty_struct *tty = NULL;
 	struct uart_icount *icount;
 	int lines_rx[DZ_NB_PORT] = { [0 ... DZ_NB_PORT - 1] = 0 };
-	unsigned short status;
 	unsigned char ch, flag;
+	u16 status;
 	int i;
 
-	while ((status = dz_in(dport_in, DZ_RBUF)) & DZ_DVAL) {
-		dport = &dz_ports[LINE(status)];
+	while ((status = dz_in(dport, DZ_RBUF)) & DZ_DVAL) {
+		dport = &mux->dport[LINE(status)];
 		uport = &dport->port;
 		tty = uport->info->tty;		/* point to the proper dev */
 
@@ -235,7 +249,7 @@ static inline void dz_receive_chars(stru
 	}
 	for (i = 0; i < DZ_NB_PORT; i++)
 		if (lines_rx[i])
-			tty_flip_buffer_push(dz_ports[i].port.info->tty);
+			tty_flip_buffer_push(mux->dport[i].port.info->tty);
 }
 
 /*
@@ -245,15 +259,15 @@ static inline void dz_receive_chars(stru
  * This routine deals with outputs to any lines.
  * ------------------------------------------------------------
  */
-static inline void dz_transmit_chars(struct dz_port *dport_in)
+static inline void dz_transmit_chars(struct dz_mux *mux)
 {
-	struct dz_port *dport;
+	struct dz_port *dport = &mux->dport[0];
 	struct circ_buf *xmit;
-	unsigned short status;
 	unsigned char tmp;
+	u16 status;
 
-	status = dz_in(dport_in, DZ_CSR);
-	dport = &dz_ports[LINE(status)];
+	status = dz_in(dport, DZ_CSR);
+	dport = &mux->dport[LINE(status)];
 	xmit = &dport->port.info->xmit;
 
 	if (dport->port.x_char) {		/* XON/XOFF chars */
@@ -305,7 +319,7 @@ static inline void check_modem_status(st
 	 * 1. No status change interrupt; use a timer.
 	 * 2. Handle the 3100/5000 as appropriate. --macro
 	 */
-	unsigned short status;
+	u16 status;
 
 	/* If not the modem line just return.  */
 	if (dport->port.line != DZ_MODEM)
@@ -326,19 +340,20 @@ static inline void check_modem_status(st
  * It deals with the multiple ports.
  * ------------------------------------------------------------
  */
-static irqreturn_t dz_interrupt(int irq, void *dev)
+static irqreturn_t dz_interrupt(int irq, void *dev_id)
 {
-	struct dz_port *dport = (struct dz_port *)dev;
-	unsigned short status;
+	struct dz_mux *mux = dev_id;
+	struct dz_port *dport = &mux->dport[0];
+	u16 status;
 
 	/* get the reason why we just got an irq */
 	status = dz_in(dport, DZ_CSR);
 
 	if ((status & (DZ_RDONE | DZ_RIE)) == (DZ_RDONE | DZ_RIE))
-		dz_receive_chars(dport);
+		dz_receive_chars(mux);
 
 	if ((status & (DZ_TRDY | DZ_TIE)) == (DZ_TRDY | DZ_TIE))
-		dz_transmit_chars(dport);
+		dz_transmit_chars(mux);
 
 	return IRQ_HANDLED;
 }
@@ -371,7 +386,7 @@ static void dz_set_mctrl(struct uart_por
 	 * FIXME: Handle the 3100/5000 as appropriate. --macro
 	 */
 	struct dz_port *dport = to_dport(uport);
-	unsigned short tmp;
+	u16 tmp;
 
 	if (dport->port.line == DZ_MODEM) {
 		tmp = dz_in(dport, DZ_TCR);
@@ -393,14 +408,29 @@ static void dz_set_mctrl(struct uart_por
 static int dz_startup(struct uart_port *uport)
 {
 	struct dz_port *dport = to_dport(uport);
+	struct dz_mux *mux = dport->mux;
 	unsigned long flags;
-	unsigned short tmp;
+	int irq_guard;
+	int ret;
+	u16 tmp;
+
+	irq_guard = atomic_add_return(1, &mux->irq_guard);
+	if (irq_guard != 1)
+		return 0;
+
+	ret = request_irq(dport->port.irq, dz_interrupt,
+			  IRQF_SHARED, "dz", mux);
+	if (ret) {
+		atomic_add(-1, &mux->irq_guard);
+		printk(KERN_ERR "dz: Cannot get IRQ %d!\n", dport->port.irq);
+		return ret;
+	}
 
 	spin_lock_irqsave(&dport->port.lock, flags);
 
-	/* enable the interrupt and the scanning */
+	/* Enable interrupts.  */
 	tmp = dz_in(dport, DZ_CSR);
-	tmp |= DZ_RIE | DZ_TIE | DZ_MSE;
+	tmp |= DZ_RIE | DZ_TIE;
 	dz_out(dport, DZ_CSR, tmp);
 
 	spin_unlock_irqrestore(&dport->port.lock, flags);
@@ -419,11 +449,24 @@ static int dz_startup(struct uart_port *
 static void dz_shutdown(struct uart_port *uport)
 {
 	struct dz_port *dport = to_dport(uport);
+	struct dz_mux *mux = dport->mux;
 	unsigned long flags;
+	int irq_guard;
+	u16 tmp;
 
 	spin_lock_irqsave(&dport->port.lock, flags);
 	dz_stop_tx(&dport->port);
 	spin_unlock_irqrestore(&dport->port.lock, flags);
+
+	irq_guard = atomic_add_return(-1, &mux->irq_guard);
+	if (!irq_guard) {
+		/* Disable interrupts.  */
+		tmp = dz_in(dport, DZ_CSR);
+		tmp &= ~(DZ_RIE | DZ_TIE);
+		dz_out(dport, DZ_CSR, tmp);
+
+		free_irq(dport->port.irq, mux);
+	}
 }
 
 /*
@@ -469,6 +512,24 @@ static void dz_break_ctl(struct uart_por
 	spin_unlock_irqrestore(&uport->lock, flags);
 }
 
+
+static void dz_reset(struct dz_port *dport)
+{
+	struct dz_mux *mux = dport->mux;
+
+	if (mux->initialised)
+		return;
+
+	dz_out(dport, DZ_CSR, DZ_CLR);
+	while (dz_in(dport, DZ_CSR) & DZ_CLR);
+	iob();
+
+	/* Enable scanning.  */
+	dz_out(dport, DZ_CSR, DZ_MSE);
+
+	mux->initialised = 1;
+}
+
 static void dz_set_termios(struct uart_port *uport, struct ktermios *termios,
 			   struct ktermios *old_termios)
 {
@@ -576,36 +637,86 @@ static void dz_set_termios(struct uart_p
 	spin_unlock_irqrestore(&dport->port.lock, flags);
 }
 
-static const char *dz_type(struct uart_port *port)
+static const char *dz_type(struct uart_port *uport)
 {
 	return "DZ";
 }
 
-static void dz_release_port(struct uart_port *port)
+static void dz_release_port(struct uart_port *uport)
 {
-	/* nothing to do */
+	struct dz_mux *mux = to_dport(uport)->mux;
+	int map_guard;
+
+	iounmap(uport->membase);
+	uport->membase = NULL;
+
+	map_guard = atomic_add_return(-1, &mux->map_guard);
+	if (!map_guard)
+		release_mem_region(uport->mapbase, dec_kn_slot_size);
 }
 
-static int dz_request_port(struct uart_port *port)
+static int dz_map_port(struct uart_port *uport)
 {
+	if (!uport->membase)
+		uport->membase = ioremap_nocache(uport->mapbase,
+						 dec_kn_slot_size);
+	if (!uport->membase) {
+		printk(KERN_ERR "dz: Cannot map MMIO\n");
+		return -ENOMEM;
+	}
 	return 0;
 }
 
-static void dz_config_port(struct uart_port *port, int flags)
+static int dz_request_port(struct uart_port *uport)
 {
-	if (flags & UART_CONFIG_TYPE)
-		port->type = PORT_DZ;
+	struct dz_mux *mux = to_dport(uport)->mux;
+	int map_guard;
+	int ret;
+
+	map_guard = atomic_add_return(1, &mux->map_guard);
+	if (map_guard == 1) {
+		if (!request_mem_region(uport->mapbase, dec_kn_slot_size,
+					"dz")) {
+			atomic_add(-1, &mux->map_guard);
+			printk(KERN_ERR
+			       "dz: Unable to reserve MMIO resource\n");
+			return -EBUSY;
+		}
+	}
+	ret = dz_map_port(uport);
+	if (ret) {
+		map_guard = atomic_add_return(-1, &mux->map_guard);
+		if (!map_guard)
+			release_mem_region(uport->mapbase, dec_kn_slot_size);
+		return ret;
+	}
+	return 0;
+}
+
+static void dz_config_port(struct uart_port *uport, int flags)
+{
+	struct dz_port *dport = to_dport(uport);
+
+	if (flags & UART_CONFIG_TYPE) {
+		if (dz_request_port(uport))
+			return;
+
+		uport->type = PORT_DZ;
+
+		dz_reset(dport);
+	}
 }
 
 /*
- * verify the new serial_struct (for TIOCSSERIAL).
+ * Verify the new serial_struct (for TIOCSSERIAL).
  */
-static int dz_verify_port(struct uart_port *port, struct serial_struct *ser)
+static int dz_verify_port(struct uart_port *uport, struct serial_struct *ser)
 {
 	int ret = 0;
+
 	if (ser->type != PORT_UNKNOWN && ser->type != PORT_DZ)
 		ret = -EINVAL;
-	if (ser->irq != port->irq)
+	if (ser->irq != uport->irq)
 		ret = -EINVAL;
 	return ret;
 }
@@ -632,42 +743,34 @@ static struct uart_ops dz_ops = {
 static void __init dz_init_ports(void)
 {
 	static int first = 1;
-	struct dz_port *dport;
 	unsigned long base;
-	int i;
+	int line;
 
 	if (!first)
 		return;
 	first = 0;
 
-	if (mips_machtype == MACH_DS23100 ||
-	    mips_machtype == MACH_DS5100)
-		base = CKSEG1ADDR(KN01_SLOT_BASE + KN01_DZ11);
+	if (mips_machtype == MACH_DS23100 || mips_machtype == MACH_DS5100)
+		base = dec_kn_slot_base + KN01_DZ11;
 	else
-		base = CKSEG1ADDR(KN02_SLOT_BASE + KN02_DZ11);
+		base = dec_kn_slot_base + KN02_DZ11;
 
-	for (i = 0, dport = dz_ports; i < DZ_NB_PORT; i++, dport++) {
-		spin_lock_init(&dport->port.lock);
-		dport->port.membase	= (char *) base;
-		dport->port.iotype	= UPIO_MEM;
-		dport->port.irq		= dec_interrupt[DEC_IRQ_DZ11];
-		dport->port.line	= i;
-		dport->port.fifosize	= 1;
-		dport->port.ops		= &dz_ops;
-		dport->port.flags	= UPF_BOOT_AUTOCONF;
+	for (line = 0; line < DZ_NB_PORT; line++) {
+		struct dz_port *dport = &dz_mux.dport[line];
+		struct uart_port *uport = &dport->port;
+
+		dport->mux	= &dz_mux;
+
+		uport->irq	= dec_interrupt[DEC_IRQ_DZ11];
+		uport->fifosize	= 1;
+		uport->iotype	= UPIO_MEM;
+		uport->flags	= UPF_BOOT_AUTOCONF;
+		uport->ops	= &dz_ops;
+		uport->line	= line;
+		uport->mapbase	= base;
 	}
 }
 
-static void dz_reset(struct dz_port *dport)
-{
-	dz_out(dport, DZ_CSR, DZ_CLR);
-	while (dz_in(dport, DZ_CSR) & DZ_CLR);
-	iob();
-
-	/* enable scanning */
-	dz_out(dport, DZ_CSR, DZ_MSE);
-}
-
 #ifdef CONFIG_SERIAL_DZ_CONSOLE
 /*
  * -------------------------------------------------------------------
@@ -732,7 +835,7 @@ static void dz_console_print(struct cons
 			     const char *str,
 			     unsigned int count)
 {
-	struct dz_port *dport = &dz_ports[co->index];
+	struct dz_port *dport = &dz_mux.dport[co->index];
 #ifdef DEBUG_DZ
 	prom_printf((char *) str);
 #endif
@@ -741,17 +844,23 @@ static void dz_console_print(struct cons
 
 static int __init dz_console_setup(struct console *co, char *options)
 {
-	struct dz_port *dport = &dz_ports[co->index];
+	struct dz_port *dport = &dz_mux.dport[co->index];
+	struct uart_port *uport = &dport->port;
 	int baud = 9600;
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
+	int ret;
 
-	if (options)
-		uart_parse_options(options, &baud, &parity, &bits, &flow);
+	ret = dz_map_port(uport);
+	if (ret)
+		return ret;
 
 	dz_reset(dport);
 
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+
 	return uart_set_options(&dport->port, co, baud, parity, bits, flow);
 }
 
@@ -804,36 +913,14 @@ static int __init dz_init(void)
 
 	dz_init_ports();
 
-#ifndef CONFIG_SERIAL_DZ_CONSOLE
-	/* reset the chip */
-	dz_reset(&dz_ports[0]);
-#endif
-
 	ret = uart_register_driver(&dz_reg);
-	if (ret != 0)
-		goto out;
-
-	ret = request_irq(dz_ports[0].port.irq, dz_interrupt, IRQF_DISABLED,
-			  "DZ", &dz_ports[0]);
-	if (ret != 0) {
-		printk(KERN_ERR "dz: Cannot get IRQ %d!\n",
-		       dz_ports[0].port.irq);
-		goto out_unregister;
-	}
+	if (ret)
+		return ret;
 
 	for (i = 0; i < DZ_NB_PORT; i++)
-		uart_add_one_port(&dz_reg, &dz_ports[i].port);
-
-	return ret;
+		uart_add_one_port(&dz_reg, &dz_mux.dport[i].port);
 
-out_unregister:
-	uart_unregister_driver(&dz_reg);
-
-out:
-	return ret;
+	return 0;
 }
 
 module_init(dz_init);
-
-MODULE_DESCRIPTION("DECstation DZ serial driver");
-MODULE_LICENSE("GPL");
