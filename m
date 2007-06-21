Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jun 2007 07:07:44 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:19207 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20024948AbXFUGHl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 Jun 2007 07:07:41 +0100
Received: by mo.po.2iij.net (mo31) id l5L66NWj064972; Thu, 21 Jun 2007 15:06:23 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox302) id l5L66L0O024849
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 21 Jun 2007 15:06:21 +0900
Date:	Thu, 21 Jun 2007 15:06:21 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove EV64120 support
Message-Id: <20070621150621.2af8daf8.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has removed EV64120 support.
It has been a candidate of removal board for a year.
Also, it is broken.

http://www.linux-mips.org/archives/linux-mips/2006-06/msg00158.html

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

---

remove EV64120 support

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Kconfig mips/arch/mips/Kconfig
--- mips-orig/arch/mips/Kconfig	2007-06-21 13:55:10.025624250 +0900
+++ mips/arch/mips/Kconfig	2007-06-21 14:11:10.471963250 +0900
@@ -88,24 +88,6 @@ config MACH_DECSTATION
 
 	  otherwise choose R3000.
 
-config MIPS_EV64120
-	bool "Galileo EV64120 Evaluation board (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	select DMA_NONCOHERENT
-	select HW_HAS_PCI
-	select PCI_GT64XXX_PCI0
-	select SYS_HAS_CPU_R5000
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_64BIT_KERNEL
-	select SYS_SUPPORTS_BIG_ENDIAN
-	select SYS_SUPPORTS_KGDB
-	help
-	  This is an evaluation board based on the Galileo GT-64120
-	  single-chip system controller that contains a MIPS R5000 compatible
-	  core running at 75/100MHz.  Their website is located at
-	  <http://www.marvell.com/>.  Say Y here if you wish to build a
-	  kernel for this platform.
-
 config MACH_JAZZ
 	bool "Jazz family of machines"
 	select ARC
@@ -660,7 +642,6 @@ endchoice
 
 source "arch/mips/au1000/Kconfig"
 source "arch/mips/ddb5xxx/Kconfig"
-source "arch/mips/gt64120/ev64120/Kconfig"
 source "arch/mips/jazz/Kconfig"
 source "arch/mips/lasat/Kconfig"
 source "arch/mips/pmc-sierra/Kconfig"
@@ -876,19 +857,11 @@ config SERIAL_RM9000
 #
 choice
 	prompt "Galileo Chip Clock"
-	#default SYSCLK_83 if MIPS_EV64120
-	depends on MIPS_EV64120 || MOMENCO_OCELOT
-	default SYSCLK_83 if MIPS_EV64120
+	depends on MOMENCO_OCELOT
 	default SYSCLK_100 if MOMENCO_OCELOT
 
-config SYSCLK_75
-	bool "75" if MIPS_EV64120
-
-config SYSCLK_83
-	bool "83.3" if MIPS_EV64120
-
 config SYSCLK_100
-	bool "100" if MIPS_EV64120 || MOMENCO_OCELOT
+	bool "100" if MOMENCO_OCELOT
 
 endchoice
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Makefile mips/arch/mips/Makefile
--- mips-orig/arch/mips/Makefile	2007-06-21 13:55:10.093628500 +0900
+++ mips/arch/mips/Makefile	2007-06-21 13:54:42.147882000 +0900
@@ -283,14 +283,6 @@ load-$(CONFIG_MACH_DECSTATION)	+= 0xffff
 CLEAN_FILES			+= drivers/tc/lk201-map.c
 
 #
-# Galileo EV64120 Board
-#
-core-$(CONFIG_MIPS_EV64120)	+= arch/mips/gt64120/ev64120/
-core-$(CONFIG_MIPS_EV64120)	+= arch/mips/gt64120/common/
-cflags-$(CONFIG_MIPS_EV64120)	+= -Iinclude/asm-mips/mach-ev64120
-load-$(CONFIG_MIPS_EV64120)	+= 0xffffffff80100000
-
-#
 # Wind River PPMC Board (4KC + GT64120)
 #
 core-$(CONFIG_WR_PPMC)		+= arch/mips/gt64120/wrppmc/
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/ev64120/Kconfig mips/arch/mips/gt64120/ev64120/Kconfig
--- mips-orig/arch/mips/gt64120/ev64120/Kconfig	2007-06-21 13:55:13.457838750 +0900
+++ mips/arch/mips/gt64120/ev64120/Kconfig	1970-01-01 09:00:00.000000000 +0900
@@ -1,3 +0,0 @@
-config EVB_PCI1
-	bool "Enable Second PCI (PCI1)"
-	depends on MIPS_EV64120
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/ev64120/Makefile mips/arch/mips/gt64120/ev64120/Makefile
--- mips-orig/arch/mips/gt64120/ev64120/Makefile	2007-06-21 13:55:13.457838750 +0900
+++ mips/arch/mips/gt64120/ev64120/Makefile	1970-01-01 09:00:00.000000000 +0900
@@ -1,9 +0,0 @@
-#
-#  Copyright 2000 RidgeRun, Inc.
-#  Author: RidgeRun, Inc.
-#     	glonnon@ridgerun.com, skranz@ridgerun.com, stevej@ridgerun.com
-#
-# Makefile for the Galileo EV64120 board.
-#
-
-obj-y	+= irq.o promcon.o reset.o serialGT.o setup.o
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/ev64120/irq.c mips/arch/mips/gt64120/ev64120/irq.c
--- mips-orig/arch/mips/gt64120/ev64120/irq.c	2007-06-21 13:55:13.457838750 +0900
+++ mips/arch/mips/gt64120/ev64120/irq.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,116 +0,0 @@
-/*
- * BRIEF MODULE DESCRIPTION
- * Code to handle irqs on GT64120A boards
- *  Derived from mips/orion and Cort <cort@fsmlabs.com>
- *
- * Copyright (C) 2000 RidgeRun, Inc.
- * Author: RidgeRun, Inc.
- *   glonnon@ridgerun.com, skranz@ridgerun.com, stevej@ridgerun.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/kernel_stat.h>
-#include <linux/module.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/timex.h>
-#include <linux/slab.h>
-#include <linux/random.h>
-#include <linux/bitops.h>
-#include <asm/bootinfo.h>
-#include <asm/io.h>
-#include <asm/mipsregs.h>
-#include <asm/system.h>
-#include <asm/gt64120.h>
-
-asmlinkage void plat_irq_dispatch(void)
-{
-	unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
-
-	if (pending & STATUSF_IP4)		/* int2 hardware line (timer) */
-		do_IRQ(4);
-	else if (pending & STATUSF_IP2)		/* int0 hardware line */
-		do_IRQ(GT_INTA);
-	else if (pending & STATUSF_IP5)		/* int3 hardware line */
-		do_IRQ(GT_INTD);
-	else if (pending & STATUSF_IP6)		/* int4 hardware line */
-		do_IRQ(6);
-	else if (pending & STATUSF_IP7)		/* compare int */
-		do_IRQ(7);
-	else
-		spurious_interrupt();
-}
-
-static void disable_ev64120_irq(unsigned int irq_nr)
-{
-	if (irq_nr >= 8) {	// All PCI interrupts are on line 5 or 2
-		clear_c0_status(9 << 10);
-	} else {
-		clear_c0_status(1 << (irq_nr + 8));
-	}
-}
-
-static void enable_ev64120_irq(unsigned int irq_nr)
-{
-	if (irq_nr >= 8)	// All PCI interrupts are on line 5 or 2
-		set_c0_status(9 << 10);
-	else
-		set_c0_status(1 << (irq_nr + 8));
-}
-
-static void end_ev64120_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		enable_ev64120_irq(irq);
-}
-
-static struct irq_chip ev64120_irq_type = {
-	.name		= "EV64120",
-	.ack		= disable_ev64120_irq,
-	.mask		= disable_ev64120_irq,
-	.mask_ack	= disable_ev64120_irq,
-	.unmask		= enable_ev64120_irq,
-	.end		= end_ev64120_irq,
-};
-
-void gt64120_irq_setup(void)
-{
-	/*
-	 * Clear all of the interrupts while we change the able around a bit.
-	 */
-	clear_c0_status(ST0_IM);
-
-	/*
-	 * Enable timer.  Other interrupts will be enabled as they are
-	 * registered.
-	 */
-	set_c0_status(IE_IRQ2);
-}
-
-void __init arch_init_irq(void)
-{
-	gt64120_irq_setup();
-}
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/ev64120/promcon.c mips/arch/mips/gt64120/ev64120/promcon.c
--- mips-orig/arch/mips/gt64120/ev64120/promcon.c	2007-06-21 13:55:13.461839000 +0900
+++ mips/arch/mips/gt64120/ev64120/promcon.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,48 +0,0 @@
-/*
- * Wrap-around code for a console using the
- * SGI PROM io-routines.
- *
- * Copyright (c) 1999 Ulf Carlsson
- *
- * Derived from DECstation promcon.c
- * Copyright (c) 1998 Harald Koerfgen
- */
-#include <linux/tty.h>
-#include <linux/init.h>
-#include <linux/console.h>
-
-static void prom_console_write(struct console *co, const char *s,
-			       unsigned count)
-{
-	extern int CONSOLE_CHANNEL;	// The default serial port
-	unsigned i;
-
-	for (i = 0; i < count; i++) {
-		if (*s == 10)
-			serial_putc(CONSOLE_CHANNEL, 13);
-		serial_putc(CONSOLE_CHANNEL, *s++);
-	}
-}
-
-static struct console sercons = {
-    .name	= "ttyS",
-    .write	= prom_console_write,
-    .flags	= CON_PRINTBUFFER,
-    .index	= -1,
-};
-
-/*
- *    Register console.
- */
-
-static int gal_serial_console_init(void)
-{
-	//  serial_init();
-	//serial_set(115200);
-
-	register_console(&sercons);
-
-	return 0;
-}
-
-console_initcall(gal_serial_console_init);
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/ev64120/reset.c mips/arch/mips/gt64120/ev64120/reset.c
--- mips-orig/arch/mips/gt64120/ev64120/reset.c	2007-06-21 13:55:13.461839000 +0900
+++ mips/arch/mips/gt64120/ev64120/reset.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,45 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1997 Ralf Baechle
- */
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <asm/io.h>
-#include <asm/pgtable.h>
-#include <asm/processor.h>
-#include <asm/reboot.h>
-#include <asm/system.h>
-
-void galileo_machine_restart(char *command)
-{
-	*(volatile char *) 0xbc000000 = 0x0f;
-	/*
-	 * Ouch, we're still alive ... This time we take the silver bullet ...
-	 * ... and find that we leave the hardware in a state in which the
-	 * kernel in the flush locks up somewhen during of after the PCI
-	 * detection stuff.
-	 */
-	set_c0_status(ST0_BEV | ST0_ERL);
-	change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
-	flush_cache_all();
-	write_c0_wired(0);
-	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
-}
-
-void galileo_machine_halt(void)
-{
-	printk(KERN_NOTICE "You can safely turn off the power\n");
-	while (1)
-		__asm__(".set\tmips3\n\t"
-	                "wait\n\t"
-			".set\tmips0");
-
-}
-
-void galileo_machine_power_off(void)
-{
-	galileo_machine_halt();
-}
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/ev64120/serialGT.c mips/arch/mips/gt64120/ev64120/serialGT.c
--- mips-orig/arch/mips/gt64120/ev64120/serialGT.c	2007-06-21 13:55:13.461839000 +0900
+++ mips/arch/mips/gt64120/ev64120/serialGT.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,212 +0,0 @@
-/*
- * serialGT.c
- *
- * BRIEF MODULE DESCRIPTION
- *  Low Level Serial Port control for use
- *  with the Galileo EVB64120A MIPS eval board and
- *  its on board two channel 16552 Uart.
- *
- * Copyright (C) 2000 RidgeRun, Inc.
- * Author: RidgeRun, Inc.
- *   glonnon@ridgerun.com, skranz@ridgerun.com, stevej@ridgerun.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-// Note:
-//   Serial CHANNELS - 0 is the bottom connector of evb64120A.
-//                       (The one that maps to the "B" channel of the
-//                       board's uart)
-//                     1 is the top connector of evb64120A.
-//                       (The one that maps to the "A" channel of the
-//                       board's uart)
-int DEBUG_CHANNEL = 0;		// See Note Above
-int CONSOLE_CHANNEL = 1;	// See Note Above
-
-#define DUART 0xBD000000	/* Base address of Uart. */
-#define CHANNELOFFSET 0x20	/* DUART+CHANNELOFFSET gets you to the ChanA
-				   register set of the 16552 Uart device.
-				   DUART+0 gets you to the ChanB register set.
-				 */
-#define DUART_DELTA 0x4
-#define FIFO_ENABLE 0x07
-#define INT_ENABLE  0x04	/* default interrupt mask */
-
-#define RBR 0x00
-#define THR 0x00
-#define DLL 0x00
-#define IER 0x01
-#define DLM 0x01
-#define IIR 0x02
-#define FCR 0x02
-#define LCR 0x03
-#define MCR 0x04
-#define LSR 0x05
-#define MSR 0x06
-#define SCR 0x07
-
-#define LCR_DLAB 0x80
-#define XTAL 1843200
-#define LSR_THRE 0x20
-#define LSR_BI   0x10
-#define LSR_DR   0x01
-#define MCR_LOOP 0x10
-#define ACCESS_DELAY 0x10000
-
-/******************************
- Routine:
- Description:
- ******************************/
-int inreg(int channel, int reg)
-{
-	int val;
-	val =
-	    *((volatile unsigned char *) DUART +
-	      (channel * CHANNELOFFSET) + (reg * DUART_DELTA));
-	return val;
-}
-
-/******************************
- Routine:
- Description:
- ******************************/
-void outreg(int channel, int reg, unsigned char val)
-{
-	*((volatile unsigned char *) DUART + (channel * CHANNELOFFSET)
-	  + (reg * DUART_DELTA)) = val;
-}
-
-/******************************
- Routine:
- Description:
-   Initialize the device driver.
- ******************************/
-void serial_init(int channel)
-{
-	/*
-	 * Configure active port, (CHANNELOFFSET already set.)
-	 *
-	 * Set 8 bits, 1 stop bit, no parity.
-	 *
-	 * LCR<7>       0       divisor latch access bit
-	 * LCR<6>       0       break control (1=send break)
-	 * LCR<5>       0       stick parity (0=space, 1=mark)
-	 * LCR<4>       0       parity even (0=odd, 1=even)
-	 * LCR<3>       0       parity enable (1=enabled)
-	 * LCR<2>       0       # stop bits (0=1, 1=1.5)
-	 * LCR<1:0>     11      bits per character(00=5, 01=6, 10=7, 11=8)
-	 */
-	outreg(channel, LCR, 0x3);
-
-	outreg(channel, FCR, FIFO_ENABLE);	/* Enable the FIFO */
-
-	outreg(channel, IER, INT_ENABLE);	/* Enable appropriate interrupts */
-}
-
-/******************************
- Routine:
- Description:
-   Set the baud rate.
- ******************************/
-void serial_set(int channel, unsigned long baud)
-{
-	unsigned char sav_lcr;
-
-	/*
-	 * Enable access to the divisor latches by setting DLAB in LCR.
-	 *
-	 */
-	sav_lcr = inreg(channel, LCR);
-
-#if 0
-	/*
-	 * Set baud rate
-	 */
-	outreg(channel, LCR, LCR_DLAB | sav_lcr);
-	//  outreg(DLL,(XTAL/(16*2*(baud))-2));
-	outreg(channel, DLL, XTAL / (16 * baud));
-	//  outreg(DLM,(XTAL/(16*2*(baud))-2)>>8);
-	outreg(channel, DLM, (XTAL / (16 * baud)) >> 8);
-#else
-	/*
-	 * Note: Set baud rate, hardcoded here for rate of 115200
-	 * since became unsure of above "baud rate" algorithm (??).
-	 */
-	outreg(channel, LCR, 0x83);
-	outreg(channel, DLM, 0x00);	// See note above
-	outreg(channel, DLL, 0x02);	// See note above.
-	outreg(channel, LCR, 0x03);
-#endif
-
-	/*
-	 * Restore line control register
-	 */
-	outreg(channel, LCR, sav_lcr);
-}
-
-
-/******************************
- Routine:
- Description:
-   Transmit a character.
- ******************************/
-void serial_putc(int channel, int c)
-{
-	while ((inreg(channel, LSR) & LSR_THRE) == 0);
-	outreg(channel, THR, c);
-}
-
-/******************************
- Routine:
- Description:
-    Read a received character if one is
-    available.  Return -1 otherwise.
- ******************************/
-int serial_getc(int channel)
-{
-	if (inreg(channel, LSR) & LSR_DR) {
-		return inreg(channel, RBR);
-	}
-	return -1;
-}
-
-/******************************
- Routine:
- Description:
-   Used by embedded gdb client. (example; gdb-stub.c)
- ******************************/
-char getDebugChar()
-{
-	int val;
-	while ((val = serial_getc(DEBUG_CHANNEL)) == -1);	// loop until we get a character in.
-	return (char) val;
-}
-
-/******************************
- Routine:
- Description:
-   Used by embedded gdb target. (example; gdb-stub.c)
- ******************************/
-void putDebugChar(char c)
-{
-	serial_putc(DEBUG_CHANNEL, (int) c);
-}
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/ev64120/setup.c mips/arch/mips/gt64120/ev64120/setup.c
--- mips-orig/arch/mips/gt64120/ev64120/setup.c	2007-06-21 13:55:13.461839000 +0900
+++ mips/arch/mips/gt64120/ev64120/setup.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,99 +0,0 @@
-/*
- * Copyright (C) 2000 RidgeRun, Inc.
- * Author: RidgeRun, Inc.
- *   glonnon@ridgerun.com, skranz@ridgerun.com, stevej@ridgerun.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/mm.h>
-#include <linux/swap.h>
-#include <linux/ioport.h>
-#include <linux/sched.h>
-#include <linux/interrupt.h>
-#include <linux/pci.h>
-#include <linux/timex.h>
-#include <linux/pm.h>
-
-#include <asm/bootinfo.h>
-#include <asm/page.h>
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/pci.h>
-#include <asm/processor.h>
-#include <asm/time.h>
-#include <asm/reboot.h>
-#include <asm/traps.h>
-#include <linux/bootmem.h>
-
-unsigned long gt64120_base = KSEG1ADDR(0x14000000);
-
-/* These functions are used for rebooting or halting the machine*/
-extern void galileo_machine_restart(char *command);
-extern void galileo_machine_halt(void);
-extern void galileo_machine_power_off(void);
-/*
- *This structure holds pointers to the pci configuration space accesses
- *and interrupts allocating routine for device over the PCI
- */
-extern struct pci_ops galileo_pci_ops;
-
-void __init prom_free_prom_memory(void)
-{
-}
-
-/*
- * Initializes basic routines and structures pointers, memory size (as
- * given by the bios and saves the command line.
- */
-
-void __init plat_mem_setup(void)
-{
-	_machine_restart = galileo_machine_restart;
-	_machine_halt = galileo_machine_halt;
-	pm_power_off = galileo_machine_power_off;
-
-	set_io_port_base(KSEG1);
-}
-
-const char *get_system_type(void)
-{
-	return "Galileo EV64120A";
-}
-
-/*
- * Kernel arguments passed by the firmware
- *
- * $a0 - nothing
- * $a1 - holds a pointer to the eprom parameters
- * $a2 - nothing
- */
-
-void __init prom_init(void)
-{
-	mips_machgroup = MACH_GROUP_GALILEO;
-	mips_machtype = MACH_EV64120A;
-
-	add_memory_region(0, 32 << 20, BOOT_MEM_RAM);
-}
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/pci/Makefile mips/arch/mips/pci/Makefile
--- mips-orig/arch/mips/pci/Makefile	2007-06-21 13:55:19.154194750 +0900
+++ mips/arch/mips/pci/Makefile	2007-06-21 13:56:41.819361000 +0900
@@ -25,7 +25,6 @@ obj-$(CONFIG_DDB5477)		+= fixup-ddb5477.
 obj-$(CONFIG_LASAT)		+= pci-lasat.o
 obj-$(CONFIG_MIPS_ATLAS)	+= fixup-atlas.o
 obj-$(CONFIG_MIPS_COBALT)	+= fixup-cobalt.o
-obj-$(CONFIG_MIPS_EV64120)	+= pci-ev64120.o
 obj-$(CONFIG_SOC_AU1500)	+= fixup-au1000.o ops-au1000.o
 obj-$(CONFIG_SOC_AU1550)	+= fixup-au1000.o ops-au1000.o
 obj-$(CONFIG_SOC_PNX8550)	+= fixup-pnx8550.o ops-pnx8550.o
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/pci/pci-ev64120.c mips/arch/mips/pci/pci-ev64120.c
--- mips-orig/arch/mips/pci/pci-ev64120.c	2007-06-21 13:55:19.562220250 +0900
+++ mips/arch/mips/pci/pci-ev64120.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,22 +0,0 @@
-#include <linux/pci.h>
-#include <asm/irq.h>
-
-int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
-{
-	int irq;
-
-	if (!pin)
-		return 0;
-
-	irq = allocate_irqno();
-	if (irq < 0)
-		return 0;
-
-	return irq;
-}
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/bootinfo.h mips/include/asm-mips/bootinfo.h
--- mips-orig/include/asm-mips/bootinfo.h	2007-06-21 14:00:14.394961000 +0900
+++ mips/include/asm-mips/bootinfo.h	2007-06-21 13:59:29.897865250 +0900
@@ -109,12 +109,6 @@
 #define  MACH_COSINE_ORION	0
 
 /*
- * Valid machtype for group GALILEO
- */
-#define MACH_GROUP_GALILEO     11	/* Galileo Eval Boards		*/
-#define  MACH_EV64120A		0	/* EV64120A */
-
-/*
  * Valid machtype for group MOMENCO
  */
 #define MACH_GROUP_MOMENCO	12	/* Momentum Boards		*/
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mach-ev64120/mach-gt64120.h mips/include/asm-mips/mach-ev64120/mach-gt64120.h
--- mips-orig/include/asm-mips/mach-ev64120/mach-gt64120.h	2007-06-21 14:00:15.435026000 +0900
+++ mips/include/asm-mips/mach-ev64120/mach-gt64120.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,62 +0,0 @@
-/*
- *  This is a direct copy of the ev96100.h file, with a global
- * search and replace.  The numbers are the same.
- *
- *  The reason I'm duplicating this is so that the 64120/96100
- * defines won't be confusing in the source code.
- */
-#ifndef __ASM_GALILEO_BOARDS_MIPS_EV64120_H
-#define __ASM_GALILEO_BOARDS_MIPS_EV64120_H
-
-/*
- *   GT64120 config space base address
- */
-extern unsigned long gt64120_base;
-
-#define GT64120_BASE	(gt64120_base)
-
-/*
- *   PCI Bus allocation
- */
-#define GT_PCI_MEM_BASE	0x12000000UL
-#define GT_PCI_MEM_SIZE	0x02000000UL
-#define GT_PCI_IO_BASE	0x10000000UL
-#define GT_PCI_IO_SIZE	0x02000000UL
-#define GT_ISA_IO_BASE	PCI_IO_BASE
-
-/*
- *   Duart I/O ports.
- */
-#define EV64120_COM1_BASE_ADDR	(0x1d000000 + 0x20)
-#define EV64120_COM2_BASE_ADDR	(0x1d000000 + 0x00)
-
-
-/*
- *   EV64120 interrupt controller register base.
- */
-#define EV64120_ICTRL_REGS_BASE	(KSEG1ADDR(0x1f000000))
-
-/*
- *   EV64120 UART register base.
- */
-#define EV64120_UART0_REGS_BASE	(KSEG1ADDR(EV64120_COM1_BASE_ADDR))
-#define EV64120_UART1_REGS_BASE	(KSEG1ADDR(EV64120_COM2_BASE_ADDR))
-#define EV64120_BASE_BAUD ( 3686400 / 16 )
-#define EV64120_UART_IRQ	6
-
-/*
- * PCI interrupts will come in on either the INTA or INTD interrups lines,
- * which are mapped to the #2 and #5 interrupt pins of the MIPS.  On our
- * boards, they all either come in on IntD or they all come in on IntA, they
- * aren't mixed. There can be numerous PCI interrupts, so we keep a list of the
- * "requested" interrupt numbers and go through the list whenever we get an
- * IntA/D.
- *
- * Interrupts < 8 are directly wired to the processor; PCI INTA is 8 and
- * INTD is 11.
- */
-#define GT_TIMER	4
-#define GT_INTA		2
-#define GT_INTD		5
-
-#endif /* __ASM_GALILEO_BOARDS_MIPS_EV64120_H */
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/serial.h mips/include/asm-mips/serial.h
--- mips-orig/include/asm-mips/serial.h	2007-06-21 14:00:18.775234750 +0900
+++ mips/include/asm-mips/serial.h	2007-06-21 14:01:49.088879000 +0900
@@ -51,24 +51,6 @@
 #define JAZZ_SERIAL_PORT_DEFNS
 #endif
 
-/*
- * Galileo EV64120 evaluation board
- */
-#ifdef CONFIG_MIPS_EV64120
-#include <mach-gt64120.h>
-#define EV64120_SERIAL_PORT_DEFNS                                  \
-    { .baud_base = EV64120_BASE_BAUD, .irq = EV64120_UART_IRQ, \
-      .flags = STD_COM_FLAGS,  \
-      .iomem_base = EV64120_UART0_REGS_BASE, .iomem_reg_shift = 2, \
-      .io_type = SERIAL_IO_MEM }, \
-    { .baud_base = EV64120_BASE_BAUD, .irq = EV64120_UART_IRQ, \
-      .flags = STD_COM_FLAGS, \
-      .iomem_base = EV64120_UART1_REGS_BASE, .iomem_reg_shift = 2, \
-      .io_type = SERIAL_IO_MEM },
-#else
-#define EV64120_SERIAL_PORT_DEFNS
-#endif
-
 #ifdef CONFIG_HAVE_STD_PC_SERIAL_PORT
 #define STD_SERIAL_PORT_DEFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
@@ -166,7 +148,6 @@
 
 #define SERIAL_PORT_DFNS				\
 	DDB5477_SERIAL_PORT_DEFNS			\
-	EV64120_SERIAL_PORT_DEFNS			\
 	IP32_SERIAL_PORT_DEFNS                          \
 	JAZZ_SERIAL_PORT_DEFNS				\
 	STD_SERIAL_PORT_DEFNS				\
