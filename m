Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 12:37:10 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:13833 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022999AbXGKLhG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jul 2007 12:37:06 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id CD3A0E1CBD;
	Wed, 11 Jul 2007 13:36:31 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1CCRNqZUCT2e; Wed, 11 Jul 2007 13:36:31 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 2C7F4E1C66;
	Wed, 11 Jul 2007 13:36:31 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l6BBaY5g020385;
	Wed, 11 Jul 2007 13:36:34 +0200
Date:	Wed, 11 Jul 2007 12:36:32 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	linux-mips@linux-mips.org, sibyte-users@bitmover.com
cc:	Mark Mason <mason@broadcom.com>
Subject: [PATCH][CFT] Move SB1250 DUART support to the serial subsystem
Message-ID: <Pine.LNX.4.64N.0707111206200.26459@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.3/3634/Wed Jul 11 03:14:01 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hello,

 This is a patch that replaces our old-fashioned SB1250 DUART driver with 
one interfacing to the serial subsystem.  It works for my SWARM, but as I 
suspect it has a little bit wider active audience than the zs.c driver I 
have reimplemented recently I am asking for it to be tested by whoever is 
interested.  I plan to submit it upstream shortly -- the larger the 
response the sooner that will happen.

 Apart from the move itself, the new driver add functionality missing from 
the old one:

- BREAK is now recognised and handled including the Magic SysRq (this is 
  actually what pushed me to write this code),

- modem lines are now handled (no hardware flow control at the moment
  though) as far as hardware provides support -- somebody "forgot" to add 
  edge detectors on the DCD and RI lines, so changes happening on them do 
  not trigger appropriate actions (I may consider adding a timer to deal 
  with this problem).

The driver has been rewritten from scratch -- only some comments and 
general software configuration bits (I think the "max_lines" variable 
qualifies here) may have survived -- so I am afraid any old bugs that may 
have been lurking around have been replaced with entirely new ones.

 This driver has not been attempted with the BCM1480 -- not even compiled. 
No hardware, no documentation -- no incentive, sorry.  I have made some 
changes which I think should be enough to make it work, but that's all 
about it.  If there are problems with this configuration, then patches are 
welcome before submission of course (the usual conditions from 
Documentation/Submit* apply).

  Maciej

patch-mips-2.6.22-20070710-serial-sb1250-duart-26
diff -up --recursive --new-file linux-mips-2.6.22-20070710.macro/arch/mips/sibyte/bcm1480/setup.c linux-mips-2.6.22-20070710/arch/mips/sibyte/bcm1480/setup.c
--- linux-mips-2.6.22-20070710.macro/arch/mips/sibyte/bcm1480/setup.c	2007-05-02 04:55:34.000000000 +0000
+++ linux-mips-2.6.22-20070710/arch/mips/sibyte/bcm1480/setup.c	2007-07-11 01:39:46.000000000 +0000
@@ -31,6 +31,7 @@
 unsigned int sb1_pass;
 unsigned int soc_pass;
 unsigned int soc_type;
+EXPORT_SYMBOL(soc_type);
 unsigned int periph_rev;
 unsigned int zbbus_mhz;
 
diff -up --recursive --new-file linux-mips-2.6.22-20070710.macro/arch/mips/sibyte/sb1250/setup.c linux-mips-2.6.22-20070710/arch/mips/sibyte/sb1250/setup.c
--- linux-mips-2.6.22-20070710.macro/arch/mips/sibyte/sb1250/setup.c	2007-05-02 04:55:34.000000000 +0000
+++ linux-mips-2.6.22-20070710/arch/mips/sibyte/sb1250/setup.c	2007-07-11 01:39:57.000000000 +0000
@@ -31,6 +31,7 @@
 unsigned int sb1_pass;
 unsigned int soc_pass;
 unsigned int soc_type;
+EXPORT_SYMBOL(soc_type);
 unsigned int periph_rev;
 unsigned int zbbus_mhz;
 EXPORT_SYMBOL(zbbus_mhz);
diff -up --recursive --new-file linux-mips-2.6.22-20070710.macro/drivers/char/Kconfig linux-mips-2.6.22-20070710/drivers/char/Kconfig
--- linux-mips-2.6.22-20070710.macro/drivers/char/Kconfig	2007-07-10 04:55:52.000000000 +0000
+++ linux-mips-2.6.22-20070710/drivers/char/Kconfig	2007-07-11 01:02:52.000000000 +0000
@@ -378,14 +378,6 @@ config AU1X00_GPIO
 	tristate "Alchemy Au1000 GPIO device support"
 	depends on MIPS && SOC_AU1X00
 
-config SIBYTE_SB1250_DUART
-	bool "Support for BCM1xxx onchip DUART"
-	depends on MIPS && SIBYTE_SB1xxx_SOC=y
-
-config SIBYTE_SB1250_DUART_CONSOLE
-	bool "Console on BCM1xxx DUART"
-	depends on SIBYTE_SB1250_DUART
-
 config SERIAL_DEC
 	bool "DECstation serial support"
 	depends on MACH_DECSTATION
diff -up --recursive --new-file linux-mips-2.6.22-20070710.macro/drivers/char/Makefile linux-mips-2.6.22-20070710/drivers/char/Makefile
--- linux-mips-2.6.22-20070710.macro/drivers/char/Makefile	2007-07-10 04:55:52.000000000 +0000
+++ linux-mips-2.6.22-20070710/drivers/char/Makefile	2007-07-11 01:02:00.000000000 +0000
@@ -32,7 +32,6 @@ obj-$(CONFIG_A2232)		+= ser_a2232.o gene
 obj-$(CONFIG_ATARI_DSP56K)	+= dsp56k.o
 obj-$(CONFIG_MOXA_SMARTIO)	+= mxser.o
 obj-$(CONFIG_MOXA_SMARTIO_NEW)	+= mxser_new.o
-obj-$(CONFIG_SIBYTE_SB1250_DUART) += sb1250_duart.o
 obj-$(CONFIG_COMPUTONE)		+= ip2/
 obj-$(CONFIG_RISCOM8)		+= riscom8.o
 obj-$(CONFIG_ISI)		+= isicom.o
diff -up --recursive --new-file linux-mips-2.6.22-20070710.macro/drivers/char/sb1250_duart.c linux-mips-2.6.22-20070710/drivers/char/sb1250_duart.c
--- linux-mips-2.6.22-20070710.macro/drivers/char/sb1250_duart.c	2007-05-02 04:55:45.000000000 +0000
+++ linux-mips-2.6.22-20070710/drivers/char/sb1250_duart.c	1970-01-01 00:00:00.000000000 +0000
@@ -1,979 +0,0 @@
-/*
- * Copyright (C) 2000,2001,2002,2003,2004 Broadcom Corporation
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- */
-
-/*
- * Driver support for the on-chip sb1250 dual-channel serial port,
- * running in asynchronous mode.  Also, support for doing a serial console
- * on one of those ports
- */
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/serial.h>
-#include <linux/interrupt.h>
-#include <linux/module.h>
-#include <linux/console.h>
-#include <linux/kdev_t.h>
-#include <linux/major.h>
-#include <linux/termios.h>
-#include <linux/spinlock.h>
-#include <linux/irq.h>
-#include <linux/errno.h>
-#include <linux/tty.h>
-#include <linux/sched.h>
-#include <linux/tty_flip.h>
-#include <linux/timer.h>
-#include <linux/init.h>
-#include <linux/mm.h>
-#include <asm/delay.h>
-#include <asm/io.h>
-#include <asm/uaccess.h>
-#include <asm/sibyte/swarm.h>
-#include <asm/sibyte/sb1250.h>
-#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
-#include <asm/sibyte/bcm1480_regs.h>
-#include <asm/sibyte/bcm1480_int.h>
-#elif defined(CONFIG_SIBYTE_SB1250) || defined(CONFIG_SIBYTE_BCM112X)
-#include <asm/sibyte/sb1250_regs.h>
-#include <asm/sibyte/sb1250_int.h>
-#else
-#error invalid SiByte UART configuation
-#endif
-#include <asm/sibyte/sb1250_uart.h>
-#include <asm/war.h>
-
-#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
-#define UNIT_CHANREG(n,reg)	A_BCM1480_DUART_CHANREG((n),(reg))
-#define UNIT_IMRREG(n)		A_BCM1480_DUART_IMRREG(n)
-#define UNIT_INT(n)		(K_BCM1480_INT_UART_0 + (n))
-#elif defined(CONFIG_SIBYTE_SB1250) || defined(CONFIG_SIBYTE_BCM112X)
-#define UNIT_CHANREG(n,reg)	A_DUART_CHANREG((n),(reg))
-#define UNIT_IMRREG(n)		A_DUART_IMRREG(n)
-#define UNIT_INT(n)		(K_INT_UART_0 + (n))
-#else
-#error invalid SiByte UART configuation
-#endif
-
-/* Toggle spewing of debugging output */
-#undef DEBUG
-
-#define DEFAULT_CFLAGS          (CS8 | B115200)
-
-#define TX_INTEN          1
-#define DUART_INITIALIZED 2
-
-#define DUART_MAX_LINE 4
-char sb1250_duart_present[DUART_MAX_LINE];
-EXPORT_SYMBOL(sb1250_duart_present);
-
-/*
- * In bug 1956, we get glitches that can mess up uart registers.  This
- * "read-mode-reg after any register access" is an accepted workaround.
- */
-#if SIBYTE_1956_WAR
-# define SB1_SER1956_WAR {							\
-	u32 ignore;										\
-	ignore = csr_in32(uart_states[line].mode_1);	\
-	ignore = csr_in32(uart_states[line].mode_2);	\
-	}
-#else
-# define SB1_SER1956_WAR
-#endif
-
-/*
- * Still not sure what the termios structures set up here are for,
- *  but we have to supply pointers to them to register the tty driver
- */
-static struct tty_driver *sb1250_duart_driver; //, sb1250_duart_callout_driver;
-
-/*
- * This lock protects both the open flags for all the uart states as
- * well as the reference count for the module
- */
-static DEFINE_SPINLOCK(open_lock);
-
-typedef struct {
-	unsigned char		outp_buf[SERIAL_XMIT_SIZE];
-	unsigned int		outp_head;
-	unsigned int		outp_tail;
-	unsigned int		outp_count;
-	spinlock_t		outp_lock;
-	unsigned int		open;
-	unsigned int		line;
-	unsigned int		last_cflags;
-	unsigned long		flags;
-	struct tty_struct	*tty;
-
-	/* CSR addresses */
-	unsigned int		*status;
-	unsigned int		*imr;
-	unsigned int		*tx_hold;
-	unsigned int		*rx_hold;
-	unsigned int		*mode_1;
-	unsigned int		*mode_2;
-	unsigned int		*clk_sel;
-	unsigned int		*cmd;
-} uart_state_t;
-
-static uart_state_t uart_states[DUART_MAX_LINE];
-
-/*
- * Inline functions local to this module
- */
-
-static inline u32 READ_SERCSR(volatile u32 *addr, int line)
-{
-	u32 val = csr_in32(addr);
-	SB1_SER1956_WAR;
-	return val;
-}
-
-static inline void WRITE_SERCSR(u32 val, volatile u32 *addr, int line)
-{
-	csr_out32(val, addr);
-	SB1_SER1956_WAR;
-}
-
-static void init_duart_port(uart_state_t *port, int line)
-{
-	if (!(port->flags & DUART_INITIALIZED)) {
-		port->line = line;
-		port->status = IOADDR(UNIT_CHANREG(line, R_DUART_STATUS));
-		port->imr = IOADDR(UNIT_IMRREG(line));
-		port->tx_hold = IOADDR(UNIT_CHANREG(line, R_DUART_TX_HOLD));
-		port->rx_hold = IOADDR(UNIT_CHANREG(line, R_DUART_RX_HOLD));
-		port->mode_1 = IOADDR(UNIT_CHANREG(line, R_DUART_MODE_REG_1));
-		port->mode_2 = IOADDR(UNIT_CHANREG(line, R_DUART_MODE_REG_2));
-		port->clk_sel = IOADDR(UNIT_CHANREG(line, R_DUART_CLK_SEL));
-		port->cmd = IOADDR(UNIT_CHANREG(line, R_DUART_CMD));
-		port->last_cflags = DEFAULT_CFLAGS;
-		spin_lock_init(&port->outp_lock);
-		port->flags |= DUART_INITIALIZED;
-	}
-}
-
-/*
- * Mask out the passed interrupt lines at the duart level.  This should be
- * called while holding the associated outp_lock.
- */
-static inline void duart_mask_ints(unsigned int line, unsigned int mask)
-{
-	uart_state_t *port = uart_states + line;
-	u64 tmp = READ_SERCSR(port->imr, line);
-	WRITE_SERCSR(tmp & ~mask, port->imr, line);
-}
-
-
-/* Unmask the passed interrupt lines at the duart level */
-static inline void duart_unmask_ints(unsigned int line, unsigned int mask)
-{
-	uart_state_t *port = uart_states + line;
-	u64 tmp = READ_SERCSR(port->imr, line);
-	WRITE_SERCSR(tmp | mask, port->imr, line);
-}
-
-static inline void transmit_char_pio(uart_state_t *us)
-{
-	struct tty_struct *tty = us->tty;
-	int blocked = 0;
-
-	if (spin_trylock(&us->outp_lock)) {
-		for (;;) {
-			if (!(READ_SERCSR(us->status, us->line) & M_DUART_TX_RDY))
-				break;
-			if (us->outp_count <= 0 || tty->stopped || tty->hw_stopped) {
-				break;
-			} else {
-				WRITE_SERCSR(us->outp_buf[us->outp_head],
-					     us->tx_hold, us->line);
-				us->outp_head = (us->outp_head + 1) & (SERIAL_XMIT_SIZE-1);
-				if (--us->outp_count <= 0)
-					break;
-			}
-			udelay(10);
-		}
-		spin_unlock(&us->outp_lock);
-	} else {
-		blocked = 1;
-	}
-
-	if (!us->outp_count || tty->stopped ||
-	    tty->hw_stopped || blocked) {
-		us->flags &= ~TX_INTEN;
-		duart_mask_ints(us->line, M_DUART_IMR_TX);
-	}
-
-	if (us->open &&
-	    (us->outp_count < (SERIAL_XMIT_SIZE/2))) {
-		/*
-		 * We told the discipline at one point that we had no
-		 * space, so it went to sleep.  Wake it up when we hit
-		 * half empty
-		 */
-		if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
-		    tty->ldisc.write_wakeup)
-			tty->ldisc.write_wakeup(tty);
-		wake_up_interruptible(&tty->write_wait);
-	}
-}
-
-/*
- * Generic interrupt handler for both channels.  dev_id is a pointer
- * to the proper uart_states structure, so from that we can derive
- * which port interrupted
- */
-
-static irqreturn_t duart_int(int irq, void *dev_id)
-{
-	uart_state_t *us = (uart_state_t *)dev_id;
-	struct tty_struct *tty = us->tty;
-	unsigned int status = READ_SERCSR(us->status, us->line);
-
-	pr_debug("DUART INT\n");
-
-	if (status & M_DUART_RX_RDY) {
-		int counter = 2048;
-		unsigned int ch;
-
-		if (status & M_DUART_OVRUN_ERR)
-			tty_insert_flip_char(tty, 0, TTY_OVERRUN);
-		if (status & M_DUART_PARITY_ERR) {
-			printk("Parity error!\n");
-		} else if (status & M_DUART_FRM_ERR) {
-			printk("Frame error!\n");
-		}
-
-		while (counter > 0) {
-			if (!(READ_SERCSR(us->status, us->line) & M_DUART_RX_RDY))
-				break;
-			ch = READ_SERCSR(us->rx_hold, us->line);
-			tty_insert_flip_char(tty, ch, 0);
-			udelay(1);
-			counter--;
-		}
-		tty_flip_buffer_push(tty);
-	}
-
-	if (status & M_DUART_TX_RDY) {
-		transmit_char_pio(us);
-	}
-
-	return IRQ_HANDLED;
-}
-
-/*
- *  Actual driver functions
- */
-
-/* Return the number of characters we can accomodate in a write at this instant */
-static int duart_write_room(struct tty_struct *tty)
-{
-	uart_state_t *us = (uart_state_t *) tty->driver_data;
-	int retval;
-
-	retval = SERIAL_XMIT_SIZE - us->outp_count;
-
-	pr_debug("duart_write_room called, returning %i\n", retval);
-
-	return retval;
-}
-
-/* memcpy the data from src to destination, but take extra care if the
-   data is coming from user space */
-static inline int copy_buf(char *dest, const char *src, int size, int from_user)
-{
-	if (from_user) {
-		(void) copy_from_user(dest, src, size);
-	} else {
-		memcpy(dest, src, size);
-	}
-	return size;
-}
-
-/*
- * Buffer up to count characters from buf to be written.  If we don't have
- * other characters buffered, enable the tx interrupt to start sending
- */
-static int duart_write(struct tty_struct *tty, const unsigned char *buf,
-		       int count)
-{
-	uart_state_t *us;
-	int c, t, total = 0;
-	unsigned long flags;
-
-	if (!tty) return 0;
-
-	us = tty->driver_data;
-	if (!us) return 0;
-
-	pr_debug("duart_write called for %i chars by %i (%s)\n", count,
-			current->pid, current->comm);
-
-	spin_lock_irqsave(&us->outp_lock, flags);
-
-	for (;;) {
-		c = count;
-
-		t = SERIAL_XMIT_SIZE - us->outp_tail;
-		if (t < c) c = t;
-
-		t = SERIAL_XMIT_SIZE - 1 - us->outp_count;
-		if (t < c) c = t;
-
-		if (c <= 0) break;
-
-		memcpy(us->outp_buf + us->outp_tail, buf, c);
-
-		us->outp_count += c;
-		us->outp_tail = (us->outp_tail + c) & (SERIAL_XMIT_SIZE - 1);
-		buf += c;
-		count -= c;
-		total += c;
-	}
-
-	spin_unlock_irqrestore(&us->outp_lock, flags);
-
-	if (us->outp_count && !tty->stopped &&
-	    !tty->hw_stopped && !(us->flags & TX_INTEN)) {
-		us->flags |= TX_INTEN;
-		duart_unmask_ints(us->line, M_DUART_IMR_TX);
-	}
-
-	return total;
-}
-
-
-/* Buffer one character to be written.  If there's not room for it, just drop
-   it on the floor.  This is used for echo, among other things */
-static void duart_put_char(struct tty_struct *tty, u_char ch)
-{
-	uart_state_t *us = (uart_state_t *) tty->driver_data;
-	unsigned long flags;
-
-	pr_debug("duart_put_char called.  Char is %x (%c)\n", (int)ch, ch);
-
-	spin_lock_irqsave(&us->outp_lock, flags);
-
-	if (us->outp_count == SERIAL_XMIT_SIZE) {
-		spin_unlock_irqrestore(&us->outp_lock, flags);
-		return;
-	}
-
-	us->outp_buf[us->outp_tail] = ch;
-	us->outp_tail = (us->outp_tail + 1) &(SERIAL_XMIT_SIZE-1);
-	us->outp_count++;
-
-	spin_unlock_irqrestore(&us->outp_lock, flags);
-}
-
-static void duart_flush_chars(struct tty_struct * tty)
-{
-	uart_state_t *port;
-
-	if (!tty)
-		return;
-
-	port = tty->driver_data;
-
-	if (!port)
-		return;
-
-	if (port->outp_count <= 0 || tty->stopped || tty->hw_stopped) {
-		return;
-	}
-
-	port->flags |= TX_INTEN;
-	duart_unmask_ints(port->line, M_DUART_IMR_TX);
-}
-
-/* Return the number of characters in the output buffer that have yet to be
-   written */
-static int duart_chars_in_buffer(struct tty_struct *tty)
-{
-	uart_state_t *us = (uart_state_t *) tty->driver_data;
-	int retval;
-
-	retval = us->outp_count;
-
-	pr_debug("duart_chars_in_buffer returning %i\n", retval);
-
-	return retval;
-}
-
-/* Kill everything we haven't yet shoved into the FIFO.  Turn off the
-   transmit interrupt since we've nothing more to transmit */
-static void duart_flush_buffer(struct tty_struct *tty)
-{
-	uart_state_t *us = (uart_state_t *) tty->driver_data;
-	unsigned long flags;
-
-	pr_debug("duart_flush_buffer called\n");
-	spin_lock_irqsave(&us->outp_lock, flags);
-	us->outp_head = us->outp_tail = us->outp_count = 0;
-	spin_unlock_irqrestore(&us->outp_lock, flags);
-
-	wake_up_interruptible(&us->tty->write_wait);
-	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
-	    tty->ldisc.write_wakeup)
-		tty->ldisc.write_wakeup(tty);
-}
-
-
-/* See sb1250 user manual for details on these registers */
-static inline void duart_set_cflag(unsigned int line, unsigned int cflag)
-{
-	unsigned int mode_reg1 = 0, mode_reg2 = 0;
-	unsigned int clk_divisor;
-	uart_state_t *port = uart_states + line;
-
-	switch (cflag & CSIZE) {
-	case CS7:
-		mode_reg1 |= V_DUART_BITS_PER_CHAR_7;
-
-	default:
-		/* We don't handle CS5 or CS6...is there a way we're supposed to
-		 * flag this?  right now we just force them to CS8 */
-		mode_reg1 |= 0x0;
-		break;
-	}
-	if (cflag & CSTOPB) {
-	        mode_reg2 |= M_DUART_STOP_BIT_LEN_2;
-	}
-	if (!(cflag & PARENB)) {
-	        mode_reg1 |= V_DUART_PARITY_MODE_NONE;
-	}
-	if (cflag & PARODD) {
-		mode_reg1 |= M_DUART_PARITY_TYPE_ODD;
-	}
-
-	/* Formula for this is (5000000/baud)-1, but we saturate
-	   at 12 bits, which means we can't actually do anything less
-	   that 1200 baud */
-	switch (cflag & CBAUD) {
-	case B200:
-	case B300:
-	case B1200:	clk_divisor = 4095;		break;
-	case B1800:	clk_divisor = 2776;		break;
-	case B2400:	clk_divisor = 2082;		break;
-	case B4800:	clk_divisor = 1040;		break;
-	case B9600:	clk_divisor = 519;		break;
-	case B19200:	clk_divisor = 259;		break;
-	case B38400:	clk_divisor = 129;		break;
-	default:
-	case B57600:	clk_divisor = 85;		break;
-	case B115200:	clk_divisor = 42;		break;
-	}
-	WRITE_SERCSR(mode_reg1, port->mode_1, port->line);
-	WRITE_SERCSR(mode_reg2, port->mode_2, port->line);
-	WRITE_SERCSR(clk_divisor, port->clk_sel, port->line);
-	port->last_cflags = cflag;
-}
-
-
-/* Handle notification of a termios change.  */
-static void duart_set_termios(struct tty_struct *tty, struct termios *old)
-{
-	uart_state_t *us = (uart_state_t *) tty->driver_data;
-
-	pr_debug("duart_set_termios called by %i (%s)\n", current->pid,
-		current->comm);
-	if (old && tty->termios->c_cflag == old->c_cflag)
-		return;
-	duart_set_cflag(us->line, tty->termios->c_cflag);
-}
-
-static int get_serial_info(uart_state_t *us, struct serial_struct * retinfo)
-{
-	struct serial_struct tmp;
-
-	memset(&tmp, 0, sizeof(tmp));
-
-	tmp.type = PORT_SB1250;
-	tmp.line = us->line;
-	tmp.port = UNIT_CHANREG(tmp.line,0);
-	tmp.irq = UNIT_INT(tmp.line);
-	tmp.xmit_fifo_size = 16; /* fixed by hw */
-	tmp.baud_base = 5000000;
-	tmp.io_type = SERIAL_IO_MEM;
-
-	if (copy_to_user(retinfo,&tmp,sizeof(*retinfo)))
-		return -EFAULT;
-
-	return 0;
-}
-
-static int duart_ioctl(struct tty_struct *tty, struct file * file,
-		       unsigned int cmd, unsigned long arg)
-{
-	uart_state_t *us = (uart_state_t *) tty->driver_data;
-
-/*	if (serial_paranoia_check(info, tty->device, "rs_ioctl"))
-	return -ENODEV;*/
-	switch (cmd) {
-	case TIOCMGET:
-		printk("Ignoring TIOCMGET\n");
-		break;
-	case TIOCMBIS:
-		printk("Ignoring TIOCMBIS\n");
-		break;
-	case TIOCMBIC:
-		printk("Ignoring TIOCMBIC\n");
-		break;
-	case TIOCMSET:
-		printk("Ignoring TIOCMSET\n");
-		break;
-	case TIOCGSERIAL:
-		return get_serial_info(us,(struct serial_struct *) arg);
-	case TIOCSSERIAL:
-		printk("Ignoring TIOCSSERIAL\n");
-		break;
-	case TIOCSERCONFIG:
-		printk("Ignoring TIOCSERCONFIG\n");
-		break;
-	case TIOCSERGETLSR: /* Get line status register */
-		printk("Ignoring TIOCSERGETLSR\n");
-		break;
-	case TIOCSERGSTRUCT:
-		printk("Ignoring TIOCSERGSTRUCT\n");
-		break;
-	case TIOCMIWAIT:
-		printk("Ignoring TIOCMIWAIT\n");
-		break;
-	case TIOCGICOUNT:
-		printk("Ignoring TIOCGICOUNT\n");
-		break;
-	case TIOCSERGWILD:
-		printk("Ignoring TIOCSERGWILD\n");
-		break;
-	case TIOCSERSWILD:
-		printk("Ignoring TIOCSERSWILD\n");
-		break;
-	default:
-		break;
-	}
-//	printk("Ignoring IOCTL %x from pid %i (%s)\n", cmd, current->pid, current->comm);
-	return -ENOIOCTLCMD;
-}
-
-/* XXXKW locking? */
-static void duart_start(struct tty_struct *tty)
-{
-	uart_state_t *us = (uart_state_t *) tty->driver_data;
-
-	pr_debug("duart_start called\n");
-
-	if (us->outp_count && !(us->flags & TX_INTEN)) {
-		us->flags |= TX_INTEN;
-		duart_unmask_ints(us->line, M_DUART_IMR_TX);
-	}
-}
-
-/* XXXKW locking? */
-static void duart_stop(struct tty_struct *tty)
-{
-	uart_state_t *us = (uart_state_t *) tty->driver_data;
-
-	pr_debug("duart_stop called\n");
-
-	if (us->outp_count && (us->flags & TX_INTEN)) {
-		us->flags &= ~TX_INTEN;
-		duart_mask_ints(us->line, M_DUART_IMR_TX);
-	}
-}
-
-/* Not sure on the semantics of this; are we supposed to wait until the stuff
- * already in the hardware FIFO drains, or are we supposed to wait until
- * we've drained the output buffer, too?  I'm assuming the former, 'cause thats
- * what the other drivers seem to assume
- */
-
-static void duart_wait_until_sent(struct tty_struct *tty, int timeout)
-{
-	uart_state_t *us = (uart_state_t *) tty->driver_data;
-	unsigned long orig_jiffies;
-
-	orig_jiffies = jiffies;
-	pr_debug("duart_wait_until_sent(%d)+\n", timeout);
-	while (!(READ_SERCSR(us->status, us->line) & M_DUART_TX_EMT)) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(1);
-		if (signal_pending(current))
-			break;
-		if (timeout && time_after(jiffies, orig_jiffies + timeout))
-			break;
-	}
-	pr_debug("duart_wait_until_sent()-\n");
-}
-
-/*
- * duart_hangup() --- called by tty_hangup() when a hangup is signaled.
- */
-static void duart_hangup(struct tty_struct *tty)
-{
-	uart_state_t *us = (uart_state_t *) tty->driver_data;
-
-	duart_flush_buffer(tty);
-	us->open = 0;
-	us->tty = 0;
-}
-
-/*
- * Open a tty line.  Note that this can be called multiple times, so ->open can
- * be >1.  Only set up the tty struct if this is a "new" open, e.g. ->open was
- * zero
- */
-static int duart_open(struct tty_struct *tty, struct file *filp)
-{
-	uart_state_t *us;
-	unsigned int line = tty->index;
-	unsigned long flags;
-
-	if ((line >= tty->driver->num) || !sb1250_duart_present[line])
-		return -ENODEV;
-
-	pr_debug("duart_open called by %i (%s), tty is %p, rw is %p, ww is %p\n",
-	       current->pid, current->comm, tty, (void *)&tty->read_wait,
-	       (void *)&tty->write_wait);
-
-	us = uart_states + line;
-	tty->driver_data = us;
-
-	spin_lock_irqsave(&open_lock, flags);
-	if (!us->open) {
-		us->tty = tty;
-		us->tty->termios->c_cflag = us->last_cflags;
-	}
-	us->open++;
-	us->flags &= ~TX_INTEN;
-	duart_unmask_ints(line, M_DUART_IMR_RX);
-	spin_unlock_irqrestore(&open_lock, flags);
-
-	return 0;
-}
-
-
-/*
- * Close a reference count out.  If reference count hits zero, null the
- * tty, kill the interrupts.  The tty_io driver is responsible for making
- * sure we've cleared out our internal buffers before calling close()
- */
-static void duart_close(struct tty_struct *tty, struct file *filp)
-{
-	uart_state_t *us = (uart_state_t *) tty->driver_data;
-	unsigned long flags;
-
-	pr_debug("duart_close called by %i (%s)\n", current->pid, current->comm);
-
-	if (!us || !us->open)
-		return;
-
-	spin_lock_irqsave(&open_lock, flags);
-	if (tty_hung_up_p(filp)) {
-		spin_unlock_irqrestore(&open_lock, flags);
-		return;
-	}
-
-	if (--us->open < 0) {
-		us->open = 0;
-		printk(KERN_ERR "duart: bad open count: %d\n", us->open);
-	}
-	if (us->open) {
-		spin_unlock_irqrestore(&open_lock, flags);
-		return;
-	}
-
-	spin_unlock_irqrestore(&open_lock, flags);
-
-	tty->closing = 1;
-
-	/* Stop accepting input */
-	duart_mask_ints(us->line, M_DUART_IMR_RX);
-	/* Wait for FIFO to drain */
-	while (!(READ_SERCSR(us->status, us->line) & M_DUART_TX_EMT))
-		;
-
-	if (tty->driver->flush_buffer)
-		tty->driver->flush_buffer(tty);
-	if (tty->ldisc.flush_buffer)
-		tty->ldisc.flush_buffer(tty);
-	tty->closing = 0;
-}
-
-
-static struct tty_operations duart_ops = {
-        .open   = duart_open,
-        .close = duart_close,
-        .write = duart_write,
-        .put_char = duart_put_char,
-        .flush_chars = duart_flush_chars,
-        .write_room = duart_write_room,
-        .chars_in_buffer = duart_chars_in_buffer,
-        .flush_buffer = duart_flush_buffer,
-        .ioctl = duart_ioctl,
-//        .throttle = duart_throttle,
-//        .unthrottle = duart_unthrottle,
-        .set_termios = duart_set_termios,
-        .stop = duart_stop,
-        .start = duart_start,
-        .hangup = duart_hangup,
-	.wait_until_sent = duart_wait_until_sent,
-};
-
-/* Initialize the sb1250_duart_present array based on SOC type.  */
-static void __init sb1250_duart_init_present_lines(void)
-{
-	int i, max_lines;
-
-	/* Set the number of available units based on the SOC type.  */
-	switch (soc_type) {
-	case K_SYS_SOC_TYPE_BCM1x55:
-	case K_SYS_SOC_TYPE_BCM1x80:
-		max_lines = 4;
-		break;
-	default:
-		/* Assume at least two serial ports at the normal address.  */
-		max_lines = 2;
-		break;
-	}
-	if (max_lines > DUART_MAX_LINE)
-		max_lines = DUART_MAX_LINE;
-
-	for (i = 0; i < max_lines; i++)
-		sb1250_duart_present[i] = 1;
-}
-
-/* Set up the driver and register it, register the UART interrupts.  This
-   is called from tty_init, or as a part of the module init */
-static int __init sb1250_duart_init(void)
-{
-	int i;
-
-	sb1250_duart_init_present_lines();
-
-	sb1250_duart_driver = alloc_tty_driver(DUART_MAX_LINE);
-	if (!sb1250_duart_driver)
-		return -ENOMEM;
-
-	sb1250_duart_driver->owner = THIS_MODULE;
-	sb1250_duart_driver->name = "duart";
-	sb1250_duart_driver->major = TTY_MAJOR;
-	sb1250_duart_driver->minor_start = SB1250_DUART_MINOR_BASE;
-	sb1250_duart_driver->type            = TTY_DRIVER_TYPE_SERIAL;
-	sb1250_duart_driver->subtype         = SERIAL_TYPE_NORMAL;
-	sb1250_duart_driver->init_termios    = tty_std_termios;
-	sb1250_duart_driver->flags           = TTY_DRIVER_REAL_RAW;
-	tty_set_operations(sb1250_duart_driver, &duart_ops);
-
-	for (i = 0; i < DUART_MAX_LINE; i++) {
-		uart_state_t *port = uart_states + i;
-
-		if (!sb1250_duart_present[i])
-			continue;
-
-		init_duart_port(port, i);
-		duart_mask_ints(i, M_DUART_IMR_ALL);
-		if (request_irq(UNIT_INT(i), duart_int, 0, "uart", port)) {
-			panic("Couldn't get uart0 interrupt line");
-		}
-		/*
-		 * this generic write to a register does not implement the 1956
-		 * WAR and sometimes output gets corrupted afterwards,
-		 * especially if the port was in use as a console.
-		 */
-		__raw_writel(M_DUART_RX_EN|M_DUART_TX_EN, port->cmd);
-
-		/*
-		 * we should really check to see if it's registered as a console
-		 * before trashing those settings
-		 */
-		duart_set_cflag(i, port->last_cflags);
-	}
-
-	/* Interrupts are now active, our ISR can be called. */
-
-	if (tty_register_driver(sb1250_duart_driver)) {
-		printk(KERN_ERR "Couldn't register sb1250 duart serial driver\n");
-		put_tty_driver(sb1250_duart_driver);
-		return 1;
-	}
-	return 0;
-}
-
-/* Unload the driver.  Unregister stuff, get ready to go away */
-static void __exit sb1250_duart_fini(void)
-{
-	unsigned long flags;
-	int i;
-
-	local_irq_save(flags);
-	tty_unregister_driver(sb1250_duart_driver);
-	put_tty_driver(sb1250_duart_driver);
-
-	for (i = 0; i < DUART_MAX_LINE; i++) {
-		if (!sb1250_duart_present[i])
-			continue;
-		free_irq(UNIT_INT(i), &uart_states[i]);
-		disable_irq(UNIT_INT(i));
-	}
-	local_irq_restore(flags);
-}
-
-module_init(sb1250_duart_init);
-module_exit(sb1250_duart_fini);
-MODULE_DESCRIPTION("SB1250 Duart serial driver");
-MODULE_AUTHOR("Broadcom Corp.");
-
-#ifdef CONFIG_SIBYTE_SB1250_DUART_CONSOLE
-
-/*
- * Serial console stuff.  Very basic, polling driver for doing serial
- * console output.  The console_sem is held by the caller, so we
- * shouldn't be interrupted for more console activity.
- * XXXKW What about getting interrupted by uart driver activity?
- */
-
-void serial_outc(unsigned char c, int line)
-{
-	uart_state_t *port = uart_states + line;
-	while (!(READ_SERCSR(port->status, line) & M_DUART_TX_RDY)) ;
-	WRITE_SERCSR(c, port->tx_hold, line);
-	while (!(READ_SERCSR(port->status, port->line) & M_DUART_TX_EMT)) ;
-}
-
-static void ser_console_write(struct console *cons, const char *s,
-	unsigned int count)
-{
-	int line = cons->index;
-	uart_state_t *port = uart_states + line;
-	u32 imr;
-
-	imr = READ_SERCSR(port->imr, line);
-	WRITE_SERCSR(0, port->imr, line);
-	while (count--) {
-		if (*s == '\n')
-			serial_outc('\r', line);
-		serial_outc(*s++, line);
-	}
-	WRITE_SERCSR(imr, port->imr, line);
-}
-
-static struct tty_driver *ser_console_device(struct console *c, int *index)
-{
-	*index = c->index;
-	return sb1250_duart_driver;
-}
-
-static int ser_console_setup(struct console *cons, char *str)
-{
-	int i;
-
-	sb1250_duart_init_present_lines();
-
-	for (i = 0; i < DUART_MAX_LINE; i++) {
-		uart_state_t *port = uart_states + i;
-		u32 cflags = DEFAULT_CFLAGS;
-
-		if (!sb1250_duart_present[i])
-			continue;
-
-		init_duart_port(port, i);
-		if (str) {
-			int speed;
-			char par = 'n';
-			int cbits = 8;
-
-			cflags = 0;
-
-			/*
-			 * format is in Documentation/serial_console.txt
-			 */
-			sscanf(str, "%d%c%d", &speed, &par, &cbits);
-
-			switch (speed) {
-			case 200:
-			case 300:
-			case 1200:
-				cflags |= B1200;
-				break;
-			case 1800:
-				cflags |= B1800;
-				break;
-			case 2400:
-				cflags |= B2400;
-				break;
-			case 4800:
-				cflags |= B4800;
-				break;
-			default:
-			case 9600:
-				cflags |= B9600;
-				break;
-			case 19200:
-				cflags |= B19200;
-				break;
-			case 38400:
-				cflags |= B38400;
-				break;
-			case 57600:
-				cflags |= B57600;
-				break;
-			case 115200:
-				cflags |= B115200;
-				break;
-			}
-			switch (par) {
-			case 'o':
-				cflags |= PARODD;
-			case 'e':
-				cflags |= PARENB;
-			}
-			switch (cbits) {
-			default:	// we only do 7 or 8
-			case 8:
-				cflags |= CS8;
-				break;
-			case 7:
-				cflags |= CS7;
-				break;
-			}
-		}
-		duart_set_cflag(i, cflags);
-		WRITE_SERCSR(M_DUART_RX_EN | M_DUART_TX_EN, port->cmd, i);
-	}
-
-	return 0;
-}
-
-static struct console sb1250_ser_cons = {
-	.name		= "duart",
-	.write		= ser_console_write,
-	.device		= ser_console_device,
-	.setup		= ser_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-};
-
-static int __init sb1250_serial_console_init(void)
-{
-	//add_preferred_console("duart", 0, "57600n8");
-	register_console(&sb1250_ser_cons);
-	return 0;
-}
-
-console_initcall(sb1250_serial_console_init);
-
-#endif /* CONFIG_SIBYTE_SB1250_DUART_CONSOLE */
diff -up --recursive --new-file linux-mips-2.6.22-20070710.macro/drivers/serial/Kconfig linux-mips-2.6.22-20070710/drivers/serial/Kconfig
--- linux-mips-2.6.22-20070710.macro/drivers/serial/Kconfig	2007-07-10 04:56:36.000000000 +0000
+++ linux-mips-2.6.22-20070710/drivers/serial/Kconfig	2007-07-11 01:02:00.000000000 +0000
@@ -324,6 +324,34 @@ config SERIAL_AMBA_PL011_CONSOLE
 	  your boot loader (lilo or loadlin) about how to pass options to the
 	  kernel at boot time.)
 
+config SERIAL_SB1250_DUART
+	tristate "BCM1xxx on-chip DUART serial support"
+	depends on SIBYTE_SB1xxx_SOC=y
+	select SERIAL_CORE
+	default y
+	---help---
+	  Support for the asynchronous serial interface (DUART) included in
+	  the BCM1250 and derived System-On-a-Chip (SOC) devices.  Note that
+	  the letter D in DUART stands for "dual" which used to be appropriate,
+	  but it is a misnomer nowadays as newer implementations provide a quad
+	  interface.
+
+	  If unsure, say Y.  To compile this driver as a module, choose M here:
+	  the module will be called sb1250-duart.
+
+config SERIAL_SB1250_DUART_CONSOLE
+	bool "Support for console on a BCM1xxx DUART serial port"
+	depends on SERIAL_SB1250_DUART=y
+	select SERIAL_CORE_CONSOLE
+	default y
+	---help---
+	  If you say Y here, it will be possible to use a serial port as the
+	  system console (the system console is the device which receives all
+	  kernel messages and warnings and which allows logins in single user
+	  mode).
+
+	  If unsure, say Y.
+
 config SERIAL_ATMEL
 	bool "AT91 / AT32 on-chip serial port support"
 	depends on (ARM && ARCH_AT91) || AVR32
diff -up --recursive --new-file linux-mips-2.6.22-20070710.macro/drivers/serial/Makefile linux-mips-2.6.22-20070710/drivers/serial/Makefile
--- linux-mips-2.6.22-20070710.macro/drivers/serial/Makefile	2007-07-10 04:56:36.000000000 +0000
+++ linux-mips-2.6.22-20070710/drivers/serial/Makefile	2007-07-11 01:02:00.000000000 +0000
@@ -23,6 +23,7 @@ obj-$(CONFIG_SERIAL_8250_MCA) += 8250_mc
 obj-$(CONFIG_SERIAL_8250_AU1X00) += 8250_au1x00.o
 obj-$(CONFIG_SERIAL_AMBA_PL010) += amba-pl010.o
 obj-$(CONFIG_SERIAL_AMBA_PL011) += amba-pl011.o
+obj-$(CONFIG_SERIAL_SB1250_DUART) += sb1250-duart.o
 obj-$(CONFIG_SERIAL_CLPS711X) += clps711x.o
 obj-$(CONFIG_SERIAL_PXA) += pxa.o
 obj-$(CONFIG_SERIAL_PNX8XXX) += pnx8xxx_uart.o
diff -up --recursive --new-file linux-mips-2.6.22-20070710.macro/drivers/serial/sb1250-duart.c linux-mips-2.6.22-20070710/drivers/serial/sb1250-duart.c
--- linux-mips-2.6.22-20070710.macro/drivers/serial/sb1250-duart.c	1970-01-01 00:00:00.000000000 +0000
+++ linux-mips-2.6.22-20070710/drivers/serial/sb1250-duart.c	2007-07-11 02:17:35.000000000 +0000
@@ -0,0 +1,972 @@
+/*
+ *	drivers/serial/sb1250-duart.c
+ *
+ *	Support for the asynchronous serial interface (DUART) included
+ *	in the BCM1250 and derived System-On-a-Chip (SOC) devices.
+ *
+ *	Copyright (c) 2007  Maciej W. Rozycki
+ *
+ *	Derived from drivers/char/sb1250_duart.c for which the following
+ *	copyright applies:
+ *
+ *	Copyright (c) 2000, 2001, 2002, 2003, 2004  Broadcom Corporation
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ *	References:
+ *
+ *	"BCM1250/BCM1125/BCM1125H User Manual", Broadcom Corporation
+ */
+
+#if defined(CONFIG_SERIAL_SB1250_DUART_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/major.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/spinlock.h>
+#include <linux/sysrq.h>
+#include <linux/tty.h>
+#include <linux/types.h>
+
+#include <asm/atomic.h>
+#include <asm/io.h>
+#include <asm/war.h>
+
+#include <asm/sibyte/sb1250.h>
+#include <asm/sibyte/sb1250_uart.h>
+#include <asm/sibyte/swarm.h>
+
+
+#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
+#include <asm/sibyte/bcm1480_regs.h>
+#include <asm/sibyte/bcm1480_int.h>
+
+#define SBD_CHANREGS(line)	A_BCM1480_DUART_CHANREG((line), 0)
+#define SBD_CTRLREGS(line)	A_BCM1480_DUART_CTRLREG((line), 0)
+#define SBD_INT(line)		(K_BCM1480_INT_UART_0 + (line))
+
+#elif defined(CONFIG_SIBYTE_SB1250) || defined(CONFIG_SIBYTE_BCM112X)
+#include <asm/sibyte/sb1250_regs.h>
+#include <asm/sibyte/sb1250_int.h>
+
+#define SBD_CHANREGS(line)	A_DUART_CHANREG((line), 0)
+#define SBD_CTRLREGS(line)	A_DUART_CTRLREG(0)
+#define SBD_INT(line)		(K_INT_UART_0 + (line))
+
+#else
+#error invalid SB1250 UART configuration
+
+#endif
+
+
+MODULE_AUTHOR("Maciej W. Rozycki <macro@linux-mips.org>");
+MODULE_DESCRIPTION("BCM1xxx on-chip DUART serial driver");
+MODULE_LICENSE("GPL");
+
+
+#define DUART_MAX_CHIP 2
+#define DUART_MAX_SIDE 2
+
+/*
+ * Per-port state.
+ */
+struct sbd_port {
+	struct sbd_duart	*duart;
+	struct uart_port	port;
+	unsigned char __iomem	*memctrl;
+	int			tx_stopped;
+	int			initialised;
+};
+
+/*
+ * Per-DUART state for the shared register space.
+ */
+struct sbd_duart {
+	struct sbd_port		sport[2];
+	unsigned long		mapctrl;
+	atomic_t		map_guard;
+};
+
+#define to_sport(uport) container_of(uport, struct sbd_port, port)
+
+static struct sbd_duart sbd_duarts[DUART_MAX_CHIP];
+
+#define __unused __attribute__((__unused__))
+
+
+/*
+ * Reading and writing SB1250 DUART registers.
+ *
+ * There are three register spaces: two per-channel ones and
+ * a shared one.  We have to define accessors appropriately.
+ * All registers are 64-bit and all but the Baud Rate Clock
+ * registers only define 8 least significant bits.  There is
+ * also a workaround to take into account.  Raw accessors use
+ * the full register width, but cooked ones truncate it
+ * intentionally so that the rest of the driver does not care.
+ */
+static u64 __read_sbdchn(struct sbd_port *sport, int reg)
+{
+	void __iomem *csr = sport->port.membase + reg;
+
+	return __raw_readq(csr);
+}
+
+static u64 __read_sbdshr(struct sbd_port *sport, int reg)
+{
+	void __iomem *csr = sport->memctrl + reg;
+
+	return __raw_readq(csr);
+}
+
+static void __write_sbdchn(struct sbd_port *sport, int reg, u64 value)
+{
+	void __iomem *csr = sport->port.membase + reg;
+
+	__raw_writeq(value, csr);
+}
+
+static void __write_sbdshr(struct sbd_port *sport, int reg, u64 value)
+{
+	void __iomem *csr = sport->memctrl + reg;
+
+	__raw_writeq(value, csr);
+}
+
+/*
+ * In bug 1956, we get glitches that can mess up uart registers.  This
+ * "read-mode-reg after any register access" is an accepted workaround.
+ */
+static void __war_sbd1956(struct sbd_port *sport)
+{
+	__read_sbdchn(sport, R_DUART_MODE_REG_1);
+	__read_sbdchn(sport, R_DUART_MODE_REG_2);
+}
+
+static unsigned char read_sbdchn(struct sbd_port *sport, int reg)
+{
+	unsigned char retval;
+
+	retval = __read_sbdchn(sport, reg);
+	if (SIBYTE_1956_WAR)
+		__war_sbd1956(sport);
+	return retval;
+}
+
+static unsigned char read_sbdshr(struct sbd_port *sport, int reg)
+{
+	unsigned char retval;
+
+	retval = __read_sbdshr(sport, reg);
+	if (SIBYTE_1956_WAR)
+		__war_sbd1956(sport);
+	return retval;
+}
+
+static void write_sbdchn(struct sbd_port *sport, int reg, unsigned int value)
+{
+	__write_sbdchn(sport, reg, value);
+	if (SIBYTE_1956_WAR)
+		__war_sbd1956(sport);
+}
+
+static void write_sbdshr(struct sbd_port *sport, int reg, unsigned int value)
+{
+	__write_sbdshr(sport, reg, value);
+	if (SIBYTE_1956_WAR)
+		__war_sbd1956(sport);
+}
+
+
+static int sbd_receive_ready(struct sbd_port *sport)
+{
+	return read_sbdchn(sport, R_DUART_STATUS) & M_DUART_RX_RDY;
+}
+
+static int sbd_receive_drain(struct sbd_port *sport)
+{
+	int loops = 10000;
+
+	while (sbd_receive_ready(sport) && loops--)
+		read_sbdchn(sport, R_DUART_RX_HOLD);
+	return loops;
+}
+
+static int __unused sbd_transmit_ready(struct sbd_port *sport)
+{
+	return read_sbdchn(sport, R_DUART_STATUS) & M_DUART_TX_RDY;
+}
+
+static int __unused sbd_transmit_drain(struct sbd_port *sport)
+{
+	int loops = 10000;
+
+	while (!sbd_transmit_ready(sport) && loops--)
+		udelay(2);
+	return loops;
+}
+
+static int sbd_transmit_empty(struct sbd_port *sport)
+{
+	return read_sbdchn(sport, R_DUART_STATUS) & M_DUART_TX_EMT;
+}
+
+static int sbd_line_drain(struct sbd_port *sport)
+{
+	int loops = 10000;
+
+	while (!sbd_transmit_empty(sport) && loops--)
+		udelay(2);
+	return loops;
+}
+
+
+static unsigned int sbd_tx_empty(struct uart_port *uport)
+{
+	struct sbd_port *sport = to_sport(uport);
+
+	return sbd_transmit_empty(sport) ? TIOCSER_TEMT : 0;
+}
+
+static unsigned int sbd_get_mctrl(struct uart_port *uport)
+{
+	struct sbd_port *sport = to_sport(uport);
+	unsigned int mctrl, status;
+
+	status = read_sbdshr(sport, R_DUART_IN_PORT);
+	status >>= (uport->line) % 2;
+	mctrl = (!(status & M_DUART_IN_PIN0_VAL) ? TIOCM_CTS : 0) |
+		(!(status & M_DUART_IN_PIN4_VAL) ? TIOCM_CAR : 0) |
+		(!(status & M_DUART_RIN0_PIN) ? TIOCM_RNG : 0) |
+		(!(status & M_DUART_IN_PIN2_VAL) ? TIOCM_DSR : 0);
+	return mctrl;
+}
+
+static void sbd_set_mctrl(struct uart_port *uport, unsigned int mctrl)
+{
+	struct sbd_port *sport = to_sport(uport);
+	unsigned int clr = 0, set = 0, mode2;
+
+	if (mctrl & TIOCM_DTR)
+		set |= M_DUART_SET_OPR2;
+	else
+		clr |= M_DUART_CLR_OPR2;
+	if (mctrl & TIOCM_RTS)
+		set |= M_DUART_SET_OPR0;
+	else
+		clr |= M_DUART_CLR_OPR0;
+	clr <<= (uport->line) % 2;
+	set <<= (uport->line) % 2;
+
+	mode2 = read_sbdchn(sport, R_DUART_MODE_REG_2);
+	mode2 &= ~M_DUART_CHAN_MODE;
+	if (mctrl & TIOCM_LOOP)
+		mode2 |= V_DUART_CHAN_MODE_LCL_LOOP;
+	else
+		mode2 |= V_DUART_CHAN_MODE_NORMAL;
+
+	write_sbdshr(sport, R_DUART_CLEAR_OPR, clr);
+	write_sbdshr(sport, R_DUART_SET_OPR, set);
+	write_sbdchn(sport, R_DUART_MODE_REG_2, mode2);
+}
+
+static void sbd_stop_tx(struct uart_port *uport)
+{
+	struct sbd_port *sport = to_sport(uport);
+
+	write_sbdchn(sport, R_DUART_CMD, M_DUART_TX_DIS);
+	sport->tx_stopped = 1;
+};
+
+static void sbd_start_tx(struct uart_port *uport)
+{
+	struct sbd_port *sport = to_sport(uport);
+	unsigned int mask;
+
+	/* Enable tx interrupts.  */
+	mask = read_sbdshr(sport, R_DUART_IMRREG((uport->line) % 2));
+	mask |= M_DUART_IMR_TX;
+	write_sbdshr(sport, R_DUART_IMRREG((uport->line) % 2), mask);
+
+	/* Go!, go!, go!...  */
+	write_sbdchn(sport, R_DUART_CMD, M_DUART_TX_EN);
+	sport->tx_stopped = 0;
+};
+
+static void sbd_stop_rx(struct uart_port *uport)
+{
+	struct sbd_port *sport = to_sport(uport);
+
+	write_sbdshr(sport, R_DUART_IMRREG((uport->line) % 2), 0);
+};
+
+static void sbd_enable_ms(struct uart_port *uport)
+{
+	struct sbd_port *sport = to_sport(uport);
+
+	write_sbdchn(sport, R_DUART_AUXCTL_X,
+		     M_DUART_CIN_CHNG_ENA | M_DUART_CTS_CHNG_ENA);
+}
+
+static void sbd_break_ctl(struct uart_port *uport, int break_state)
+{
+	struct sbd_port *sport = to_sport(uport);
+
+	if (break_state == -1)
+		write_sbdchn(sport, R_DUART_CMD, V_DUART_MISC_CMD_START_BREAK);
+	else
+		write_sbdchn(sport, R_DUART_CMD, V_DUART_MISC_CMD_STOP_BREAK);
+}
+
+
+static void sbd_receive_chars(struct sbd_port *sport)
+{
+	struct uart_port *uport = &sport->port;
+	struct uart_icount *icount;
+	unsigned int status, ch, flag;
+	int count;
+
+	for (count = 16; count; count--) {
+		status = read_sbdchn(sport, R_DUART_STATUS);
+		if (!(status & M_DUART_RX_RDY))
+			break;
+
+		ch = read_sbdchn(sport, R_DUART_RX_HOLD);
+
+		flag = TTY_NORMAL;
+
+		icount = &uport->icount;
+		icount->rx++;
+
+		if (unlikely(status &
+			     (M_DUART_RCVD_BRK | M_DUART_FRM_ERR |
+			      M_DUART_PARITY_ERR | M_DUART_OVRUN_ERR))) {
+			if (status & M_DUART_RCVD_BRK) {
+				icount->brk++;
+				if (uart_handle_break(uport))
+					continue;
+			} else if (status & M_DUART_FRM_ERR)
+				icount->frame++;
+			else if (status & M_DUART_PARITY_ERR)
+				icount->parity++;
+			if (status & M_DUART_OVRUN_ERR)
+				icount->overrun++;
+
+			status &= uport->read_status_mask;
+			if (status & M_DUART_RCVD_BRK)
+				flag = TTY_BREAK;
+			else if (status & M_DUART_FRM_ERR)
+				flag = TTY_FRAME;
+			else if (status & M_DUART_PARITY_ERR)
+				flag = TTY_PARITY;
+		}
+
+		if (uart_handle_sysrq_char(uport, ch))
+			continue;
+
+		uart_insert_char(uport, status, M_DUART_OVRUN_ERR, ch, flag);
+	}
+
+	tty_flip_buffer_push(uport->info->tty);
+}
+
+static void sbd_transmit_chars(struct sbd_port *sport)
+{
+	struct uart_port *uport = &sport->port;
+	struct circ_buf *xmit = &sport->port.info->xmit;
+	unsigned int mask;
+	int stop_tx;
+
+	/* XON/XOFF chars.  */
+	if (sport->port.x_char) {
+		write_sbdchn(sport, R_DUART_TX_HOLD, sport->port.x_char);
+		sport->port.icount.tx++;
+		sport->port.x_char = 0;
+		return;
+	}
+
+	/* If nothing to do or stopped or hardware stopped.  */
+	stop_tx = (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port));
+
+	/* Send char.  */
+	if (!stop_tx) {
+		write_sbdchn(sport, R_DUART_TX_HOLD, xmit->buf[xmit->tail]);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		sport->port.icount.tx++;
+
+		if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+			uart_write_wakeup(&sport->port);
+	}
+
+	/* Are we are done?  */
+	if (stop_tx || uart_circ_empty(xmit)) {
+		/* Disable tx interrupts.  */
+		mask = read_sbdshr(sport, R_DUART_IMRREG((uport->line) % 2));
+		mask &= ~M_DUART_IMR_TX;
+		write_sbdshr(sport, R_DUART_IMRREG((uport->line) % 2), mask);
+	}
+}
+
+static void sbd_status_handle(struct sbd_port *sport)
+{
+	struct uart_port *uport = &sport->port;
+	unsigned int delta;
+
+	delta = read_sbdshr(sport, R_DUART_INCHREG((uport->line) % 2));
+	delta >>= (uport->line) % 2;
+
+	if (delta & (M_DUART_IN_PIN0_VAL << S_DUART_IN_PIN_CHNG))
+		uart_handle_cts_change(uport, !(delta & M_DUART_IN_PIN0_VAL));
+
+	if (delta & (M_DUART_IN_PIN2_VAL << S_DUART_IN_PIN_CHNG))
+		uport->icount.dsr++;
+
+	if (delta & ((M_DUART_IN_PIN2_VAL | M_DUART_IN_PIN0_VAL) <<
+		     S_DUART_IN_PIN_CHNG))
+		wake_up_interruptible(&uport->info->delta_msr_wait);
+}
+
+static irqreturn_t sbd_interrupt(int irq, void *dev_id)
+{
+	struct sbd_port *sport = dev_id;
+	struct uart_port *uport = &sport->port;
+	irqreturn_t status = IRQ_NONE;
+	unsigned int intstat;
+	int count;
+
+	for (count = 16; count; count--) {
+		intstat = read_sbdshr(sport,
+				      R_DUART_ISRREG((uport->line) % 2));
+		intstat &= read_sbdshr(sport,
+				       R_DUART_IMRREG((uport->line) % 2));
+		intstat &= M_DUART_ISR_ALL;
+		if (!intstat)
+			break;
+
+		if (intstat & M_DUART_ISR_RX)
+			sbd_receive_chars(sport);
+		if (intstat & M_DUART_ISR_IN)
+			sbd_status_handle(sport);
+		if (intstat & M_DUART_ISR_TX)
+			sbd_transmit_chars(sport);
+
+		status = IRQ_HANDLED;
+	}
+
+	return status;
+}
+
+
+static int sbd_startup(struct uart_port *uport)
+{
+	struct sbd_port *sport = to_sport(uport);
+	unsigned int mode1;
+	int ret;
+
+	ret = request_irq(sport->port.irq, sbd_interrupt,
+			  IRQF_SHARED, "sb1250-duart", sport);
+	if (ret)
+		return ret;
+
+	/* Clear the receive FIFO.  */
+	sbd_receive_drain(sport);
+
+	/* Clear the interrupt registers.  */
+	write_sbdchn(sport, R_DUART_CMD, V_DUART_MISC_CMD_RESET_BREAK_INT);
+	read_sbdshr(sport, R_DUART_INCHREG((uport->line) % 2));
+
+	/* Set rx/tx interrupt to FIFO available.  */
+	mode1 = read_sbdchn(sport, R_DUART_MODE_REG_1);
+	mode1 &= ~(M_DUART_RX_IRQ_SEL_RXFULL | M_DUART_TX_IRQ_SEL_TXEMPT);
+	write_sbdchn(sport, R_DUART_MODE_REG_1, mode1);
+
+	/* Disable tx, enable rx.  */
+	write_sbdchn(sport, R_DUART_CMD, M_DUART_TX_DIS | M_DUART_RX_EN);
+	sport->tx_stopped = 1;
+
+	/* Enable interrupts.  */
+	write_sbdshr(sport, R_DUART_IMRREG((uport->line) % 2),
+		     M_DUART_IMR_IN | M_DUART_IMR_RX);
+
+	return 0;
+}
+
+static void sbd_shutdown(struct uart_port *uport)
+{
+	struct sbd_port *sport = to_sport(uport);
+
+	write_sbdchn(sport, R_DUART_CMD, M_DUART_TX_DIS | M_DUART_RX_DIS);
+	sport->tx_stopped = 1;
+	free_irq(sport->port.irq, sport);
+}
+
+
+static void sbd_init_port(struct sbd_port *sport)
+{
+	struct uart_port *uport = &sport->port;
+
+	if (sport->initialised)
+		return;
+
+	/* There is no DUART reset feature, so just set some sane defaults.  */
+	write_sbdchn(sport, R_DUART_CMD, V_DUART_MISC_CMD_RESET_TX);
+	write_sbdchn(sport, R_DUART_CMD, V_DUART_MISC_CMD_RESET_RX);
+	write_sbdchn(sport, R_DUART_MODE_REG_1, V_DUART_BITS_PER_CHAR_8);
+	write_sbdchn(sport, R_DUART_MODE_REG_2, 0);
+	write_sbdchn(sport, R_DUART_FULL_CTL,
+		     V_DUART_INT_TIME(0) | V_DUART_SIG_FULL(15));
+	write_sbdchn(sport, R_DUART_OPCR_X, 0);
+	write_sbdchn(sport, R_DUART_AUXCTL_X, 0);
+	write_sbdshr(sport, R_DUART_IMRREG((uport->line) % 2), 0);
+
+	sport->initialised = 1;
+}
+
+static void sbd_set_termios(struct uart_port *uport, struct ktermios *termios,
+			    struct ktermios *old_termios)
+{
+	struct sbd_port *sport = to_sport(uport);
+	unsigned int mode1 = 0, mode2 = 0, aux = 0;
+	unsigned int mode1mask = 0, mode2mask = 0, auxmask = 0;
+	unsigned int oldmode1, oldmode2, oldaux;
+	unsigned int baud, brg;
+	unsigned int command;
+
+	mode1mask |= ~(M_DUART_PARITY_MODE | M_DUART_PARITY_TYPE_ODD |
+		       M_DUART_BITS_PER_CHAR);
+	mode2mask |= ~M_DUART_STOP_BIT_LEN_2;
+	auxmask |= ~M_DUART_CTS_CHNG_ENA;
+
+	/* Byte size.  */
+	switch (termios->c_cflag & CSIZE) {
+	case CS5:
+	case CS6:
+		/* Unsupported, leave unchanged.  */
+		mode1mask |= M_DUART_PARITY_MODE;
+		break;
+	case CS7:
+		mode1 |= V_DUART_BITS_PER_CHAR_7;
+		break;
+	case CS8:
+	default:
+		mode1 |= V_DUART_BITS_PER_CHAR_8;
+		break;
+	}
+
+	/* Parity and stop bits.  */
+	if (termios->c_cflag & CSTOPB)
+		mode2 |= M_DUART_STOP_BIT_LEN_2;
+	else
+		mode2 |= M_DUART_STOP_BIT_LEN_1;
+	if (termios->c_cflag & PARENB)
+		mode1 |= V_DUART_PARITY_MODE_ADD;
+	else
+		mode1 |= V_DUART_PARITY_MODE_NONE;
+	if (termios->c_cflag & PARODD)
+		mode1 |= M_DUART_PARITY_TYPE_ODD;
+	else
+		mode1 |= M_DUART_PARITY_TYPE_EVEN;
+
+	baud = uart_get_baud_rate(uport, termios, old_termios, 1200, 5000000);
+	brg = V_DUART_BAUD_RATE(baud);
+	/* The actual lower bound is 1221bps, so compensate.  */
+	if (brg > M_DUART_CLK_COUNTER)
+		brg = M_DUART_CLK_COUNTER;
+
+	uart_update_timeout(uport, termios->c_cflag, baud);
+
+	uport->read_status_mask = M_DUART_OVRUN_ERR;
+	if (termios->c_iflag & INPCK)
+		uport->read_status_mask |= M_DUART_FRM_ERR |
+					   M_DUART_PARITY_ERR;
+	if (termios->c_iflag & (BRKINT | PARMRK))
+		uport->read_status_mask |= M_DUART_RCVD_BRK;
+
+	uport->ignore_status_mask = 0;
+	if (termios->c_iflag & IGNPAR)
+		uport->ignore_status_mask |= M_DUART_FRM_ERR |
+					     M_DUART_PARITY_ERR;
+	if (termios->c_iflag & IGNBRK) {
+		uport->ignore_status_mask |= M_DUART_RCVD_BRK;
+		if (termios->c_iflag & IGNPAR)
+			uport->ignore_status_mask |= M_DUART_OVRUN_ERR;
+	}
+
+	if (termios->c_cflag & CREAD)
+		command = M_DUART_RX_EN;
+	else
+		command = M_DUART_RX_DIS;
+
+	if (termios->c_cflag & CRTSCTS)
+		aux |= M_DUART_CTS_CHNG_ENA;
+	else
+		aux &= ~M_DUART_CTS_CHNG_ENA;
+
+	spin_lock(&uport->lock);
+
+	if (sport->tx_stopped)
+		command |= M_DUART_TX_DIS;
+	else
+		command |= M_DUART_TX_EN;
+
+	oldmode1 = read_sbdchn(sport, R_DUART_MODE_REG_1) & mode1mask;
+	oldmode2 = read_sbdchn(sport, R_DUART_MODE_REG_2) & mode2mask;
+	oldaux = read_sbdchn(sport, R_DUART_AUXCTL_X) & auxmask;
+
+	if (!sport->tx_stopped)
+		sbd_line_drain(sport);
+	write_sbdchn(sport, R_DUART_CMD, M_DUART_TX_DIS | M_DUART_RX_DIS);
+
+	write_sbdchn(sport, R_DUART_MODE_REG_1, mode1 | oldmode1);
+	write_sbdchn(sport, R_DUART_MODE_REG_2, mode2 | oldmode2);
+	write_sbdchn(sport, R_DUART_CLK_SEL, brg);
+	write_sbdchn(sport, R_DUART_AUXCTL_X, aux | oldaux);
+
+	write_sbdchn(sport, R_DUART_CMD, command);
+
+	spin_unlock(&uport->lock);
+}
+
+
+static const char *sbd_type(struct uart_port *uport)
+{
+	return "SB1250 DUART";
+}
+
+static void sbd_release_port(struct uart_port *uport)
+{
+	struct sbd_port *sport = to_sport(uport);
+	struct sbd_duart *duart = sport->duart;
+	int map_guard;
+
+	iounmap(sport->memctrl);
+	sport->memctrl = NULL;
+	iounmap(uport->membase);
+	uport->membase = NULL;
+
+	map_guard = atomic_add_return(-1, &duart->map_guard);
+	if (!map_guard)
+		release_mem_region(duart->mapctrl, DUART_CHANREG_SPACING);
+	release_mem_region(uport->mapbase, DUART_CHANREG_SPACING);
+}
+
+static int sbd_map_port(struct uart_port *uport)
+{
+	static const char *err = KERN_ERR "sbd: Cannot map MMIO\n";
+	struct sbd_port *sport = to_sport(uport);
+	struct sbd_duart *duart = sport->duart;
+
+	if (!uport->membase)
+		uport->membase = ioremap_nocache(uport->mapbase,
+						 DUART_CHANREG_SPACING);
+	if (!uport->membase) {
+		printk(err);
+		return -ENOMEM;
+	}
+
+	if (!sport->memctrl)
+		sport->memctrl = ioremap_nocache(duart->mapctrl,
+						 DUART_CHANREG_SPACING);
+	if (!sport->memctrl) {
+		printk(err);
+		iounmap(uport->membase);
+		uport->membase = NULL;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int sbd_request_port(struct uart_port *uport)
+{
+	static const char *err = KERN_ERR
+				 "sbd: Unable to reserve MMIO resource\n";
+	struct sbd_duart *duart = to_sport(uport)->duart;
+	int map_guard;
+	int ret = 0;
+
+	if (!request_mem_region(uport->mapbase, DUART_CHANREG_SPACING,
+				"sb1250-duart")) {
+		printk(err);
+		return -EBUSY;
+	}
+	map_guard = atomic_add_return(1, &duart->map_guard);
+	if (map_guard == 1) {
+		if (!request_mem_region(duart->mapctrl, DUART_CHANREG_SPACING,
+					"sb1250-duart")) {
+			atomic_add(-1, &duart->map_guard);
+			printk(err);
+			ret = -EBUSY;
+		}
+	}
+	if (!ret) {
+		ret = sbd_map_port(uport);
+		if (ret) {
+			map_guard = atomic_add_return(-1, &duart->map_guard);
+			if (!map_guard)
+				release_mem_region(duart->mapctrl,
+						   DUART_CHANREG_SPACING);
+		}
+	}
+	if (ret) {
+		release_mem_region(uport->mapbase, DUART_CHANREG_SPACING);
+		return ret;
+	}
+	return 0;
+}
+
+static void sbd_config_port(struct uart_port *uport, int flags)
+{
+	struct sbd_port *sport = to_sport(uport);
+
+	if (flags & UART_CONFIG_TYPE) {
+		if (sbd_request_port(uport))
+			return;
+
+		uport->type = PORT_SB1250_DUART;
+
+		sbd_init_port(sport);
+	}
+}
+
+static int sbd_verify_port(struct uart_port *uport, struct serial_struct *ser)
+{
+	int ret = 0;
+
+	if (ser->type != PORT_UNKNOWN && ser->type != PORT_SB1250_DUART)
+		ret = -EINVAL;
+	if (ser->irq != uport->irq)
+		ret = -EINVAL;
+	if (ser->baud_base != uport->uartclk / 16)
+		ret = -EINVAL;
+	return ret;
+}
+
+
+static struct uart_ops sbd_ops = {
+	.tx_empty	= sbd_tx_empty,
+	.set_mctrl	= sbd_set_mctrl,
+	.get_mctrl	= sbd_get_mctrl,
+	.stop_tx	= sbd_stop_tx,
+	.start_tx	= sbd_start_tx,
+	.stop_rx	= sbd_stop_rx,
+	.enable_ms	= sbd_enable_ms,
+	.break_ctl	= sbd_break_ctl,
+	.startup	= sbd_startup,
+	.shutdown	= sbd_shutdown,
+	.set_termios	= sbd_set_termios,
+	.type		= sbd_type,
+	.release_port	= sbd_release_port,
+	.request_port	= sbd_request_port,
+	.config_port	= sbd_config_port,
+	.verify_port	= sbd_verify_port,
+};
+
+/* Initialize SB1250 DUART port structures.  */
+static void __init sbd_probe_duarts(void)
+{
+	static int probed;
+	int chip, side;
+	int max_lines, line;
+
+	if (probed)
+		return;
+
+	/* Set the number of available units based on the SOC type.  */
+	switch (soc_type) {
+	case K_SYS_SOC_TYPE_BCM1x55:
+	case K_SYS_SOC_TYPE_BCM1x80:
+		max_lines = 4;
+		break;
+	default:
+		/* Assume at least two serial ports at the normal address.  */
+		max_lines = 2;
+		break;
+	}
+
+	probed = 1;
+
+	for (chip = 0, line = 0; chip < DUART_MAX_CHIP && line < max_lines;
+	     chip++) {
+		sbd_duarts[chip].mapctrl = SBD_CTRLREGS(line);
+
+		for (side = 0; side < DUART_MAX_SIDE && line < max_lines;
+		     side++, line++) {
+			struct sbd_port *sport = &sbd_duarts[chip].sport[side];
+			struct uart_port *uport = &sport->port;
+
+			sport->duart	= &sbd_duarts[chip];
+
+			uport->irq	= SBD_INT(line);
+			uport->uartclk	= 100000000 / 20 * 16;
+			uport->fifosize	= 16;
+			uport->iotype	= UPIO_MEM;
+			uport->flags	= UPF_BOOT_AUTOCONF;
+			uport->ops	= &sbd_ops;
+			uport->line	= line;
+			uport->mapbase	= SBD_CHANREGS(line);
+		}
+	}
+}
+
+
+#ifdef CONFIG_SERIAL_SB1250_DUART_CONSOLE
+/*
+ * Serial console stuff.  Very basic, polling driver for doing serial
+ * console output.  The console_sem is held by the caller, so we
+ * shouldn't be interrupted for more console activity.
+ */
+static void sbd_console_putchar(struct uart_port *uport, int ch)
+{
+	struct sbd_port *sport = to_sport(uport);
+
+	sbd_transmit_drain(sport);
+	write_sbdchn(sport, R_DUART_TX_HOLD, ch);
+}
+
+static void sbd_console_write(struct console *co, const char *s,
+			      unsigned int count)
+{
+	int chip = co->index / DUART_MAX_SIDE;
+	int side = co->index % DUART_MAX_SIDE;
+	struct sbd_port *sport = &sbd_duarts[chip].sport[side];
+	struct uart_port *uport = &sport->port;
+	unsigned long flags;
+	unsigned int mask;
+
+	/* Disable transmit interrupts and enable the transmitter. */
+	spin_lock_irqsave(&uport->lock, flags);
+	mask = read_sbdshr(sport, R_DUART_IMRREG((uport->line) % 2));
+	write_sbdshr(sport, R_DUART_IMRREG((uport->line) % 2),
+		     mask & ~M_DUART_IMR_TX);
+	write_sbdchn(sport, R_DUART_CMD, M_DUART_TX_EN);
+	spin_unlock_irqrestore(&uport->lock, flags);
+
+	uart_console_write(&sport->port, s, count, sbd_console_putchar);
+
+	/* Restore transmit interrupts and the transmitter enable. */
+	spin_lock_irqsave(&uport->lock, flags);
+	sbd_line_drain(sport);
+	if (sport->tx_stopped)
+		write_sbdchn(sport, R_DUART_CMD, M_DUART_TX_DIS);
+	write_sbdshr(sport, R_DUART_IMRREG((uport->line) % 2), mask);
+	spin_unlock_irqrestore(&uport->lock, flags);
+}
+
+static int __init sbd_console_setup(struct console *co, char *options)
+{
+	int chip = co->index / DUART_MAX_SIDE;
+	int side = co->index % DUART_MAX_SIDE;
+	struct sbd_port *sport = &sbd_duarts[chip].sport[side];
+	struct uart_port *uport = &sport->port;
+	int baud = 115200;
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
+	int ret;
+
+	if (!sport->duart)
+		return -ENXIO;
+
+	ret = sbd_map_port(uport);
+	if (ret)
+		return ret;
+
+	sbd_init_port(sport);
+
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+	return uart_set_options(uport, co, baud, parity, bits, flow);
+}
+
+static struct uart_driver sbd_reg;
+static struct console sbd_console = {
+	.name	= "duart",
+	.write	= sbd_console_write,
+	.device	= uart_console_device,
+	.setup	= sbd_console_setup,
+	.flags	= CON_PRINTBUFFER,
+	.index	= -1,
+	.data	= &sbd_reg
+};
+
+static int __init sbd_serial_console_init(void)
+{
+	sbd_probe_duarts();
+	register_console(&sbd_console);
+
+	return 0;
+}
+
+console_initcall(sbd_serial_console_init);
+
+#define SERIAL_SB1250_DUART_CONSOLE	&sbd_console
+#else
+#define SERIAL_SB1250_DUART_CONSOLE	NULL
+#endif /* CONFIG_SERIAL_SB1250_DUART_CONSOLE */
+
+
+static struct uart_driver sbd_reg = {
+	.owner		= THIS_MODULE,
+	.driver_name	= "serial",
+	.dev_name	= "duart",
+	.major		= TTY_MAJOR,
+	.minor		= SB1250_DUART_MINOR_BASE,
+	.nr		= DUART_MAX_CHIP * DUART_MAX_SIDE,
+	.cons		= SERIAL_SB1250_DUART_CONSOLE,
+};
+
+/* Set up the driver and register it.  */
+static int __init sbd_init(void)
+{
+	int i, ret;
+
+	sbd_probe_duarts();
+
+	ret = uart_register_driver(&sbd_reg);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < DUART_MAX_CHIP * DUART_MAX_SIDE; i++) {
+		struct sbd_duart *duart = &sbd_duarts[i / DUART_MAX_SIDE];
+		struct sbd_port *sport = &duart->sport[i % DUART_MAX_SIDE];
+		struct uart_port *uport = &sport->port;
+
+		if (sport->duart)
+			uart_add_one_port(&sbd_reg, uport);
+	}
+
+	return 0;
+}
+
+/* Unload the driver.  Unregister stuff, get ready to go away.  */
+static void __exit sbd_exit(void)
+{
+	int i;
+
+	for (i = DUART_MAX_CHIP * DUART_MAX_SIDE - 1; i >= 0; i--) {
+		struct sbd_duart *duart = &sbd_duarts[i / DUART_MAX_SIDE];
+		struct sbd_port *sport = &duart->sport[i % DUART_MAX_SIDE];
+		struct uart_port *uport = &sport->port;
+
+		if (sport->duart)
+			uart_remove_one_port(&sbd_reg, uport);
+	}
+
+	uart_unregister_driver(&sbd_reg);
+}
+
+module_init(sbd_init);
+module_exit(sbd_exit);
diff -up --recursive --new-file linux-mips-2.6.22-20070710.macro/include/asm-mips/sibyte/bcm1480_regs.h linux-mips-2.6.22-20070710/include/asm-mips/sibyte/bcm1480_regs.h
--- linux-mips-2.6.22-20070710.macro/include/asm-mips/sibyte/bcm1480_regs.h	2007-07-10 04:56:54.000000000 +0000
+++ linux-mips-2.6.22-20070710/include/asm-mips/sibyte/bcm1480_regs.h	2007-07-11 01:09:49.000000000 +0000
@@ -220,17 +220,25 @@
 #define A_BCM1480_DUART(chan)               ((((chan)&2) == 0)? A_BCM1480_DUART0 : A_BCM1480_DUART1)
 
 #define BCM1480_DUART_CHANREG_SPACING       0x100
-#define A_BCM1480_DUART_CHANREG(chan,reg)   (A_BCM1480_DUART(chan) \
-                                     + BCM1480_DUART_CHANREG_SPACING*((chan)&1) \
-                                     + (reg))
-#define R_BCM1480_DUART_CHANREG(chan,reg)   (BCM1480_DUART_CHANREG_SPACING*((chan)&1) + (reg))
-
-#define R_BCM1480_DUART_IMRREG(chan)	    (R_DUART_IMR_A + ((chan)&1)*DUART_IMRISR_SPACING)
-#define R_BCM1480_DUART_ISRREG(chan)	    (R_DUART_ISR_A + ((chan)&1)*DUART_IMRISR_SPACING)
-
-#define A_BCM1480_DUART_IMRREG(chan)	    (A_BCM1480_DUART(chan) + R_BCM1480_DUART_IMRREG(chan))
-#define A_BCM1480_DUART_ISRREG(chan)	    (A_BCM1480_DUART(chan) + R_BCM1480_DUART_ISRREG(chan))
-#define A_BCM1480_DUART_IN_PORT(chan)       (A_BCM1480_DUART(chan) + R_DUART_INP_ORT)
+#define A_BCM1480_DUART_CHANREG(chan, reg)				\
+	(A_BCM1480_DUART(chan) +					\
+	 BCM1480_DUART_CHANREG_SPACING * (((chan) & 1) + 1) + (reg))
+#define A_BCM1480_DUART_CTRLREG(chan, reg)				\
+	(A_BCM1480_DUART(chan) +					\
+	 BCM1480_DUART_CHANREG_SPACING * 3 + (reg))
+
+#define R_BCM1480_DUART_IMRREG(chan)					\
+	(R_DUART_IMR_A + ((chan) & 1) * DUART_IMRISR_SPACING)
+#define R_BCM1480_DUART_ISRREG(chan)					\
+	(R_DUART_ISR_A + ((chan) & 1) * DUART_IMRISR_SPACING)
+
+#define A_BCM1480_DUART_IMRREG(chan)					\
+	(A_BCM1480_DUART_CTRLREG((chan), R_BCM1480_DUART_IMRREG(chan)))
+#define A_BCM1480_DUART_ISRREG(chan)					\
+	(A_BCM1480_DUART_CTRLREG((chan), R_BCM1480_DUART_ISRREG(chan)))
+
+#define A_BCM1480_DUART_IN_PORT(chan)					\
+	(A_BCM1480_DUART_CTRLREG((chan), R_DUART_IN_PORT))
 
 /*
  * These constants are the absolute addresses.
diff -up --recursive --new-file linux-mips-2.6.22-20070710.macro/include/asm-mips/sibyte/sb1250_regs.h linux-mips-2.6.22-20070710/include/asm-mips/sibyte/sb1250_regs.h
--- linux-mips-2.6.22-20070710.macro/include/asm-mips/sibyte/sb1250_regs.h	2007-07-10 04:56:54.000000000 +0000
+++ linux-mips-2.6.22-20070710/include/asm-mips/sibyte/sb1250_regs.h	2007-07-11 01:04:58.000000000 +0000
@@ -272,59 +272,69 @@
     ********************************************************************* */
 
 
-#if SIBYTE_HDR_FEATURE_1250_112x		/* This MC only on 1250 & 112x */
+#if SIBYTE_HDR_FEATURE_1250_112x    /* This MC only on 1250 & 112x */
 #define R_DUART_NUM_PORTS           2
 
 #define A_DUART                     0x0010060000
 
 #define DUART_CHANREG_SPACING       0x100
-#define A_DUART_CHANREG(chan,reg)   (A_DUART + DUART_CHANREG_SPACING*(chan) + (reg))
-#define R_DUART_CHANREG(chan,reg)   (DUART_CHANREG_SPACING*(chan) + (reg))
+
+#define A_DUART_CHANREG(chan, reg)					\
+	(A_DUART + DUART_CHANREG_SPACING * ((chan) + 1) + (reg))
 #endif	/* 1250 & 112x */
 
-#define R_DUART_MODE_REG_1	    0x100
-#define R_DUART_MODE_REG_2	    0x110
-#define R_DUART_STATUS              0x120
-#define R_DUART_CLK_SEL             0x130
-#define R_DUART_CMD                 0x150
-#define R_DUART_RX_HOLD             0x160
-#define R_DUART_TX_HOLD             0x170
+#define R_DUART_MODE_REG_1	    0x000
+#define R_DUART_MODE_REG_2	    0x010
+#define R_DUART_STATUS		    0x020
+#define R_DUART_CLK_SEL		    0x030
+#define R_DUART_CMD		    0x050
+#define R_DUART_RX_HOLD		    0x060
+#define R_DUART_TX_HOLD		    0x070
 
 #if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
-#define R_DUART_FULL_CTL	    0x140
-#define R_DUART_OPCR_X		    0x180
-#define R_DUART_AUXCTL_X	    0x190
-#endif /* 1250 PASS2 || 112x PASS1 || 1480*/
+#define R_DUART_FULL_CTL	    0x040
+#define R_DUART_OPCR_X		    0x080
+#define R_DUART_AUXCTL_X	    0x090
+#endif /* 1250 PASS2 || 112x PASS1 || 1480 */
 
 
 /*
  * The IMR and ISR can't be addressed with A_DUART_CHANREG,
- * so use this macro instead.
+ * so use these macros instead.
  */
 
-#define R_DUART_AUX_CTRL            0x310
-#define R_DUART_ISR_A               0x320
-#define R_DUART_IMR_A               0x330
-#define R_DUART_ISR_B               0x340
-#define R_DUART_IMR_B               0x350
-#define R_DUART_OUT_PORT            0x360
-#define R_DUART_OPCR                0x370
-#define R_DUART_IN_PORT             0x380
-
-#define R_DUART_SET_OPR		    0x3B0
-#define R_DUART_CLEAR_OPR	    0x3C0
-
-#define DUART_IMRISR_SPACING        0x20
-
-#if SIBYTE_HDR_FEATURE_1250_112x		/* This MC only on 1250 & 112x */
-#define R_DUART_IMRREG(chan)	    (R_DUART_IMR_A + (chan)*DUART_IMRISR_SPACING)
-#define R_DUART_ISRREG(chan)	    (R_DUART_ISR_A + (chan)*DUART_IMRISR_SPACING)
-
-#define A_DUART_IMRREG(chan)	    (A_DUART + R_DUART_IMRREG(chan))
-#define A_DUART_ISRREG(chan)	    (A_DUART + R_DUART_ISRREG(chan))
+#if SIBYTE_HDR_FEATURE_1250_112x    /* This MC only on 1250 & 112x */
+#define DUART_IMRISR_SPACING	    0x20
+#define DUART_INCHNG_SPACING	    0x10
+
+#define A_DUART_CTRLREG(reg)						\
+	(A_DUART + DUART_CHANREG_SPACING * 3 + (reg))
+
+#define R_DUART_IMRREG(chan)						\
+	(R_DUART_IMR_A + (chan) * DUART_IMRISR_SPACING)
+#define R_DUART_ISRREG(chan)						\
+	(R_DUART_ISR_A + (chan) * DUART_IMRISR_SPACING)
+#define R_DUART_INCHREG(chan)						\
+	(R_DUART_IN_CHNG_A + (chan) * DUART_INCHNG_SPACING)
+
+#define A_DUART_IMRREG(chan)	    A_DUART_CTRLREG(R_DUART_IMRREG(chan))
+#define A_DUART_ISRREG(chan)	    A_DUART_CTRLREG(R_DUART_ISRREG(chan))
+#define A_DUART_INCHREG(chan)	    A_DUART_CTRLREG(R_DUART_INCHREG(chan))
 #endif	/* 1250 & 112x */
 
-
+#define R_DUART_AUX_CTRL	    0x010
+#define R_DUART_ISR_A		    0x020
+#define R_DUART_IMR_A		    0x030
+#define R_DUART_ISR_B		    0x040
+#define R_DUART_IMR_B		    0x050
+#define R_DUART_OUT_PORT	    0x060
+#define R_DUART_OPCR		    0x070
+#define R_DUART_IN_PORT		    0x080
+
+#define R_DUART_SET_OPR		    0x0B0
+#define R_DUART_CLEAR_OPR	    0x0C0
+#define R_DUART_IN_CHNG_A	    0x0D0
+#define R_DUART_IN_CHNG_B	    0x0E0
 
 
 /*
diff -up --recursive --new-file linux-mips-2.6.22-20070710.macro/include/asm-mips/sibyte/sb1250_uart.h linux-mips-2.6.22-20070710/include/asm-mips/sibyte/sb1250_uart.h
--- linux-mips-2.6.22-20070710.macro/include/asm-mips/sibyte/sb1250_uart.h	2005-11-04 17:03:32.000000000 +0000
+++ linux-mips-2.6.22-20070710/include/asm-mips/sibyte/sb1250_uart.h	2007-07-10 23:41:56.000000000 +0000
@@ -75,7 +75,8 @@
 #define V_DUART_PARITY_MODE_ADD_FIXED V_DUART_PARITY_MODE(K_DUART_PARITY_MODE_ADD_FIXED)
 #define V_DUART_PARITY_MODE_NONE      V_DUART_PARITY_MODE(K_DUART_PARITY_MODE_NONE)
 
-#define M_DUART_ERR_MODE            _SB_MAKEMASK1(5)    /* must be zero */
+#define M_DUART_TX_IRQ_SEL_TXRDY    0
+#define M_DUART_TX_IRQ_SEL_TXEMPT   _SB_MAKEMASK1(5)
 
 #define M_DUART_RX_IRQ_SEL_RXRDY    0
 #define M_DUART_RX_IRQ_SEL_RXFULL   _SB_MAKEMASK1(6)
@@ -246,10 +247,13 @@
 
 #define M_DUART_ISR_BRK_A           _SB_MAKEMASK1(2)
 #define M_DUART_ISR_IN_A            _SB_MAKEMASK1(3)
+#define M_DUART_ISR_ALL_A	    _SB_MAKEMASK(4,0)
+
 #define M_DUART_ISR_TX_B            _SB_MAKEMASK1(4)
 #define M_DUART_ISR_RX_B            _SB_MAKEMASK1(5)
 #define M_DUART_ISR_BRK_B           _SB_MAKEMASK1(6)
 #define M_DUART_ISR_IN_B            _SB_MAKEMASK1(7)
+#define M_DUART_ISR_ALL_B	    _SB_MAKEMASK(4,4)
 
 /*
  * DUART Channel A Interrupt Status Register (Table 10-17)
@@ -262,6 +266,7 @@
 #define M_DUART_ISR_RX              _SB_MAKEMASK1(1)
 #define M_DUART_ISR_BRK             _SB_MAKEMASK1(2)
 #define M_DUART_ISR_IN              _SB_MAKEMASK1(3)
+#define M_DUART_ISR_ALL		    _SB_MAKEMASK(4,0)
 #define M_DUART_ISR_RESERVED        _SB_MAKEMASK(4,4)
 
 /*
diff -up --recursive --new-file linux-mips-2.6.22-20070710.macro/include/linux/serial.h linux-mips-2.6.22-20070710/include/linux/serial.h
--- linux-mips-2.6.22-20070710.macro/include/linux/serial.h	2005-11-04 17:03:40.000000000 +0000
+++ linux-mips-2.6.22-20070710/include/linux/serial.h	2007-06-16 16:53:48.000000000 +0000
@@ -76,8 +76,7 @@ struct serial_struct {
 #define PORT_16654	11
 #define PORT_16850	12
 #define PORT_RSA	13	/* RSA-DV II/S card */
-#define PORT_SB1250	14
-#define PORT_MAX	14
+#define PORT_MAX	13
 
 #define SERIAL_IO_PORT	0
 #define SERIAL_IO_HUB6	1
diff -up --recursive --new-file linux-mips-2.6.22-20070710.macro/include/linux/serial_core.h linux-mips-2.6.22-20070710/include/linux/serial_core.h
--- linux-mips-2.6.22-20070710.macro/include/linux/serial_core.h	2007-07-10 04:56:58.000000000 +0000
+++ linux-mips-2.6.22-20070710/include/linux/serial_core.h	2007-07-11 01:02:00.000000000 +0000
@@ -143,6 +143,9 @@
 #define PORT_KS8695	76
 
 
+/* Broadcom SB1250, etc. SOC */
+#define PORT_SB1250_DUART	75
+
 #ifdef __KERNEL__
 
 #include <linux/compiler.h>
