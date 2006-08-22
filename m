Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Aug 2006 14:59:40 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:32826 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038726AbWHVN6r (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Aug 2006 14:58:47 +0100
Received: by mo.po.2iij.net (mo30) id k7MDwiGS013049; Tue, 22 Aug 2006 22:58:44 +0900 (JST)
Received: from localhost.localdomain (191.28.30.125.dy.iij4u.or.jp [125.30.28.191])
	by mbox.po.2iij.net (mbox33) id k7MDwgB8012175
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 Aug 2006 22:58:43 +0900 (JST)
Date:	Tue, 22 Aug 2006 22:36:45 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 3/12] Cobalt is moved under gt64120 directory
Message-Id: <20060822223645.5735c990.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has moved cobalt directory under gt64120 directory.
Cobalt servers are using GT64111. It's almost same as GT64120.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Kconfig mips/arch/mips/Kconfig
--- mips-orig/arch/mips/Kconfig	2006-08-18 23:10:49.041972250 +0900
+++ mips/arch/mips/Kconfig	2006-08-18 23:08:01.511502250 +0900
@@ -830,7 +830,7 @@ source "arch/mips/tx4927/Kconfig"
 source "arch/mips/tx4938/Kconfig"
 source "arch/mips/vr41xx/Kconfig"
 source "arch/mips/philips/pnx8550/common/Kconfig"
-source "arch/mips/cobalt/Kconfig"
+source "arch/mips/gt64120/cobalt/Kconfig"
 
 endmenu
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Makefile mips/arch/mips/Makefile
--- mips-orig/arch/mips/Makefile	2006-08-18 23:04:38.033555000 +0900
+++ mips/arch/mips/Makefile	2006-08-18 23:08:01.515502500 +0900
@@ -258,7 +258,7 @@ load-$(CONFIG_MIPS_XXS1500)	+= 0xfffffff
 #
 # Cobalt Server
 #
-core-$(CONFIG_MIPS_COBALT)	+= arch/mips/cobalt/
+core-$(CONFIG_MIPS_COBALT)	+= arch/mips/gt64120/cobalt/
 cflags-$(CONFIG_MIPS_COBALT)	+= -Iinclude/asm-mips/mach-cobalt
 load-$(CONFIG_MIPS_COBALT)	+= 0xffffffff80080000
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/Kconfig mips/arch/mips/cobalt/Kconfig
--- mips-orig/arch/mips/cobalt/Kconfig	2006-08-18 23:04:38.069539250 +0900
+++ mips/arch/mips/cobalt/Kconfig	1970-01-01 09:00:00.000000000 +0900
@@ -1,7 +0,0 @@
-config EARLY_PRINTK
-	bool "Early console support"
-	depends on MIPS_COBALT
-	help
-	  Provide early console support by direct access to the
-	  on board UART. The UART must have been previously
-	  initialised by the boot loader.
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/Makefile mips/arch/mips/cobalt/Makefile
--- mips-orig/arch/mips/cobalt/Makefile	2006-08-18 23:04:38.069539250 +0900
+++ mips/arch/mips/cobalt/Makefile	1970-01-01 09:00:00.000000000 +0900
@@ -1,9 +0,0 @@
-#
-# Makefile for the Cobalt micro systems family specific parts of the kernel
-#
-
-obj-y	 := irq.o reset.o setup.o
-
-obj-$(CONFIG_EARLY_PRINTK)	+= console.o
-
-EXTRA_AFLAGS := $(CFLAGS)
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/console.c mips/arch/mips/cobalt/console.c
--- mips-orig/arch/mips/cobalt/console.c	2006-08-18 23:04:38.069539250 +0900
+++ mips/arch/mips/cobalt/console.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,47 +0,0 @@
-/*
- * (C) P. Horton 2006
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/console.h>
-#include <linux/serial_reg.h>
-#include <asm/addrspace.h>
-#include <asm/mach-cobalt/cobalt.h>
-
-static void putchar(int c)
-{
-	if(c == '\n')
-		putchar('\r');
-
-	while(!(COBALT_UART[UART_LSR] & UART_LSR_THRE))
-		;
-
-	COBALT_UART[UART_TX] = c;
-}
-
-static void cons_write(struct console *c, const char *s, unsigned n)
-{
-	while(n-- && *s)
-		putchar(*s++);
-}
-
-static struct console cons_info =
-{
-	.name	= "uart",
-	.write	= cons_write,
-	.flags	= CON_PRINTBUFFER | CON_BOOT,
-	.index	= -1,
-};
-
-void __init cobalt_early_console(void)
-{
-	register_console(&cons_info);
-
-	printk("Cobalt: early console registered\n");
-}
-
-void __init disable_early_printk(void)
-{
-	unregister_console(&cons_info);
-}
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/irq.c mips/arch/mips/cobalt/irq.c
--- mips-orig/arch/mips/cobalt/irq.c	2006-08-18 23:10:49.017970750 +0900
+++ mips/arch/mips/cobalt/irq.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,133 +0,0 @@
-/*
- * IRQ vector handles
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1995, 1996, 1997, 2003 by Ralf Baechle
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
-#include <linux/pci.h>
-
-#include <asm/i8259.h>
-#include <asm/irq_cpu.h>
-#include <asm/gt64120.h>
-#include <asm/ptrace.h>
-
-#include <asm/mach-cobalt/cobalt.h>
-
-/*
- * We have two types of interrupts that we handle, ones that come in through
- * the CPU interrupt lines, and ones that come in on the via chip. The CPU
- * mappings are:
- *
- *    16   - Software interrupt 0 (unused)	IE_SW0
- *    17   - Software interrupt 1 (unused)	IE_SW1
- *    18   - Galileo chip (timer)		IE_IRQ0
- *    19   - Tulip 0 + NCR SCSI			IE_IRQ1
- *    20   - Tulip 1				IE_IRQ2
- *    21   - 16550 UART				IE_IRQ3
- *    22   - VIA southbridge PIC		IE_IRQ4
- *    23   - unused				IE_IRQ5
- *
- * The VIA chip is a master/slave 8259 setup and has the following interrupts:
- *
- *     8  - RTC
- *     9  - PCI
- *    14  - IDE0
- *    15  - IDE1
- */
-
-static inline void galileo_irq(struct pt_regs *regs)
-{
-	unsigned int mask, pending, devfn;
-
-	mask = GT_READ(GT_INTRMASK_OFS);
-	pending = GT_READ(GT_INTRCAUSE_OFS) & mask;
-
-	if (pending & GALILEO_INTR_T0EXP) {
-
-		GT_WRITE(GT_INTRCAUSE_OFS, ~GALILEO_INTR_T0EXP);
-		do_IRQ(COBALT_GALILEO_IRQ, regs);
-
-	} else if (pending & GALILEO_INTR_RETRY_CTR) {
-
-		devfn = GT_READ(GT_PCI0_CFGADDR_OFS) >> 8;
-		GT_WRITE(GT_INTRCAUSE_OFS, ~GALILEO_INTR_RETRY_CTR);
-		printk(KERN_WARNING "Galileo: PCI retry count exceeded (%02x.%u)\n",
-			PCI_SLOT(devfn), PCI_FUNC(devfn));
-
-	} else {
-
-		GT_WRITE(GT_INTRMASK_OFS, mask & ~pending);
-		printk(KERN_WARNING "Galileo: masking unexpected interrupt %08x\n", pending);
-	}
-}
-
-static inline void via_pic_irq(struct pt_regs *regs)
-{
-	int irq;
-
-	irq = i8259_irq();
-	if (irq >= 0)
-		do_IRQ(irq, regs);
-}
-
-asmlinkage void plat_irq_dispatch(struct pt_regs *regs)
-{
-	unsigned pending;
-
-	pending = read_c0_status() & read_c0_cause();
-
-	if (pending & CAUSEF_IP2)			/* COBALT_GALILEO_IRQ (18) */
-
-		galileo_irq(regs);
-
-	else if (pending & CAUSEF_IP6)			/* COBALT_VIA_IRQ (22) */
-
-		via_pic_irq(regs);
-
-	else if (pending & CAUSEF_IP3)			/* COBALT_ETH0_IRQ (19) */
-
-		do_IRQ(COBALT_CPU_IRQ + 3, regs);
-
-	else if (pending & CAUSEF_IP4)			/* COBALT_ETH1_IRQ (20) */
-
-		do_IRQ(COBALT_CPU_IRQ + 4, regs);
-
-	else if (pending & CAUSEF_IP5)			/* COBALT_SERIAL_IRQ (21) */
-
-		do_IRQ(COBALT_CPU_IRQ + 5, regs);
-
-	else if (pending & CAUSEF_IP7)			/* IRQ 23 */
-
-		do_IRQ(COBALT_CPU_IRQ + 7, regs);
-}
-
-static struct irqaction irq_via = {
-	no_action, 0, { { 0, } }, "cascade", NULL, NULL
-};
-
-void __init arch_init_irq(void)
-{
-	/*
-	 * Mask all Galileo interrupts. The Galileo
-	 * handler is set in cobalt_timer_setup()
-	 */
-	GT_WRITE(GT_INTRMASK_OFS, 0);
-
-	init_i8259_irqs();				/*  0 ... 15 */
-	mips_cpu_irq_init(COBALT_CPU_IRQ);		/* 16 ... 23 */
-
-	/*
-	 * Mask all cpu interrupts
-	 *  (except IE4, we already masked those at VIA level)
-	 */
-	change_c0_status(ST0_IM, IE_IRQ4);
-
-	setup_irq(COBALT_VIA_IRQ, &irq_via);
-}
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/reset.c mips/arch/mips/cobalt/reset.c
--- mips-orig/arch/mips/cobalt/reset.c	2006-08-18 23:04:38.069539250 +0900
+++ mips/arch/mips/cobalt/reset.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,65 +0,0 @@
-/*
- * Cobalt Reset operations
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1995, 1996, 1997 by Ralf Baechle
- * Copyright (C) 2001 by Liam Davies (ldavies@agile.tv)
- */
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <asm/cacheflush.h>
-#include <asm/io.h>
-#include <asm/processor.h>
-#include <asm/reboot.h>
-#include <asm/system.h>
-#include <asm/mipsregs.h>
-#include <asm/mach-cobalt/cobalt.h>
-
-void cobalt_machine_halt(void)
-{
-	int state, last, diff;
-	unsigned long mark;
-
-	/*
-	 * turn off bar on Qube, flash power off LED on RaQ (0.5Hz)
-	 *
-	 * restart if ENTER and SELECT are pressed
-	 */
-
-	last = COBALT_KEY_PORT;
-
-	for (state = 0;;) {
-
-		state ^= COBALT_LED_POWER_OFF;
-		COBALT_LED_PORT = state;
-
-		diff = COBALT_KEY_PORT ^ last;
-		last ^= diff;
-
-		if((diff & (COBALT_KEY_ENTER | COBALT_KEY_SELECT)) && !(~last & (COBALT_KEY_ENTER | COBALT_KEY_SELECT)))
-			COBALT_LED_PORT = COBALT_LED_RESET;
-
-		for (mark = jiffies; jiffies - mark < HZ;)
-			;
-	}
-}
-
-void cobalt_machine_restart(char *command)
-{
-	COBALT_LED_PORT = COBALT_LED_RESET;
-
-	/* we should never get here */
-	cobalt_machine_halt();
-}
-
-/*
- * This triggers the luser mode device driver for the power switch ;-)
- */
-void cobalt_machine_power_off(void)
-{
-	printk("You can switch the machine off now.\n");
-	cobalt_machine_halt();
-}
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/setup.c mips/arch/mips/cobalt/setup.c
--- mips-orig/arch/mips/cobalt/setup.c	2006-08-18 23:10:49.045972500 +0900
+++ mips/arch/mips/cobalt/setup.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,212 +0,0 @@
-/*
- * Setup pointers to hardware dependent routines.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1996, 1997, 2004, 05 by Ralf Baechle (ralf@linux-mips.org)
- * Copyright (C) 2001, 2002, 2003 by Liam Davies (ldavies@agile.tv)
- *
- */
-#include <linux/interrupt.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-#include <linux/pm.h>
-#include <linux/serial.h>
-#include <linux/serial_core.h>
-
-#include <asm/bootinfo.h>
-#include <asm/time.h>
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/processor.h>
-#include <asm/reboot.h>
-#include <asm/gt64120.h>
-#include <asm/serial.h>
-
-#include <asm/mach-cobalt/cobalt.h>
-
-extern void cobalt_machine_restart(char *command);
-extern void cobalt_machine_halt(void);
-extern void cobalt_machine_power_off(void);
-extern void cobalt_early_console(void);
-
-int cobalt_board_id;
-
-const char *get_system_type(void)
-{
-	switch (cobalt_board_id) {
-		case COBALT_BRD_ID_QUBE1:
-			return "Cobalt Qube";
-		case COBALT_BRD_ID_RAQ1:
-			return "Cobalt RaQ";
-		case COBALT_BRD_ID_QUBE2:
-			return "Cobalt Qube2";
-		case COBALT_BRD_ID_RAQ2:
-			return "Cobalt RaQ2";
-	}
-	return "MIPS Cobalt";
-}
-
-void __init plat_timer_setup(struct irqaction *irq)
-{
-	/* Load timer value for 1KHz (TCLK is 50MHz) */
-	GT_WRITE(GT_TC0_OFS, 50*1000*1000 / 1000);
-
-	/* Enable timer */
-	GT_WRITE(GT_TC_CONTROL_OFS, GALILEO_ENTC0 | GALILEO_SELTC0);
-
-	/* Register interrupt */
-	setup_irq(COBALT_GALILEO_IRQ, irq);
-
-	/* Enable interrupt */
-	GT_WRITE(GT_INTRMASK_OFS, GALILEO_INTR_T0EXP | GT_READ(GT_INTRMASK_OFS));
-}
-
-extern struct pci_ops gt64120_pci_ops;
-
-static struct resource cobalt_mem_resource = {
-	.start	= GT_DEF_PCI0_MEM0_BASE,
-	.end	= GT_DEF_PCI0_MEM0_BASE + GT_DEF_PCI0_MEM0_SIZE - 1,
-	.name	= "PCI memory",
-	.flags	= IORESOURCE_MEM
-};
-
-static struct resource cobalt_io_resource = {
-	.start	= 0x1000,
-	.end	= 0xffff,
-	.name	= "PCI I/O",
-	.flags	= IORESOURCE_IO
-};
-
-static struct resource cobalt_io_resources[] = {
-	{
-		.start	= 0x00,
-		.end	= 0x1f,
-		.name	= "dma1",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x40,
-		.end	= 0x5f,
-		.name	= "timer",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x60,
-		.end	= 0x6f,
-		.name	= "keyboard",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x80,
-		.end	= 0x8f,
-		.name	= "dma page reg",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0xc0,
-		.end	= 0xdf,
-		.name	= "dma2",
-		.flags	= IORESOURCE_BUSY
-	},
-};
-
-#define COBALT_IO_RESOURCES (sizeof(cobalt_io_resources)/sizeof(struct resource))
-
-static struct pci_controller cobalt_pci_controller = {
-	.pci_ops	= &gt64120_pci_ops,
-	.mem_resource	= &cobalt_mem_resource,
-	.mem_offset	= 0,
-	.io_resource	= &cobalt_io_resource,
-	.io_offset	= 0 - GT_DEF_PCI0_IO_BASE,
-};
-
-void __init plat_mem_setup(void)
-{
-	static struct uart_port uart;
-	unsigned int devfn = PCI_DEVFN(COBALT_PCICONF_VIA, 0);
-	int i;
-
-	_machine_restart = cobalt_machine_restart;
-	_machine_halt = cobalt_machine_halt;
-	pm_power_off = cobalt_machine_power_off;
-
-        set_io_port_base(CKSEG1ADDR(GT_DEF_PCI0_IO_BASE));
-
-	/* I/O port resource must include UART and LCD/buttons */
-	ioport_resource.end = 0x0fffffff;
-
-	/* request I/O space for devices used on all i[345]86 PCs */
-	for (i = 0; i < COBALT_IO_RESOURCES; i++)
-		request_resource(&ioport_resource, cobalt_io_resources + i);
-
-        /* Read the cobalt id register out of the PCI config space */
-        PCI_CFG_SET(devfn, (VIA_COBALT_BRD_ID_REG & ~0x3));
-        cobalt_board_id = GT_READ(GT_PCI0_CFGDATA_OFS);
-        cobalt_board_id >>= ((VIA_COBALT_BRD_ID_REG & 3) * 8);
-        cobalt_board_id = VIA_COBALT_BRD_REG_to_ID(cobalt_board_id);
-
-	printk("Cobalt board ID: %d\n", cobalt_board_id);
-
-#ifdef CONFIG_PCI
-	register_pci_controller(&cobalt_pci_controller);
-#endif
-
-#ifdef CONFIG_SERIAL_8250
-	if (cobalt_board_id > COBALT_BRD_ID_RAQ1) {
-
-#ifdef CONFIG_EARLY_PRINTK
-		cobalt_early_console();
-#endif
-
-		uart.line	= 0;
-		uart.type	= PORT_UNKNOWN;
-		uart.uartclk	= 18432000;
-		uart.irq	= COBALT_SERIAL_IRQ;
-		uart.flags	= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
-		uart.iobase	= 0xc800000;
-		uart.iotype	= UPIO_PORT;
-
-		early_serial_setup(&uart);
-	}
-#endif
-}
-
-/*
- * Prom init. We read our one and only communication with the firmware.
- * Grab the amount of installed memory.
- * Better boot loaders (CoLo) pass a command line too :-)
- */
-
-void __init prom_init(void)
-{
-	int narg, indx, posn, nchr;
-	unsigned long memsz;
-	char **argv;
-
-	mips_machgroup = MACH_GROUP_COBALT;
-
-	memsz = fw_arg0 & 0x7fff0000;
-	narg = fw_arg0 & 0x0000ffff;
-
-	if (narg) {
-		arcs_cmdline[0] = '\0';
-		argv = (char **) fw_arg1;
-		posn = 0;
-		for (indx = 1; indx < narg; ++indx) {
-			nchr = strlen(argv[indx]);
-			if (posn + 1 + nchr + 1 > sizeof(arcs_cmdline))
-				break;
-			if (posn)
-				arcs_cmdline[posn++] = ' ';
-			strcpy(arcs_cmdline + posn, argv[indx]);
-			posn += nchr;
-		}
-	}
-
-	add_memory_region(0x0, memsz, BOOT_MEM_RAM);
-}
-
-unsigned long __init prom_free_prom_memory(void)
-{
-	/* Nothing to do! */
-	return 0;
-}
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/cobalt/Kconfig mips/arch/mips/gt64120/cobalt/Kconfig
--- mips-orig/arch/mips/gt64120/cobalt/Kconfig	1970-01-01 09:00:00.000000000 +0900
+++ mips/arch/mips/gt64120/cobalt/Kconfig	2006-08-18 23:08:01.519502750 +0900
@@ -0,0 +1,7 @@
+config EARLY_PRINTK
+	bool "Early console support"
+	depends on MIPS_COBALT
+	help
+	  Provide early console support by direct access to the
+	  on board UART. The UART must have been previously
+	  initialised by the boot loader.
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/cobalt/Makefile mips/arch/mips/gt64120/cobalt/Makefile
--- mips-orig/arch/mips/gt64120/cobalt/Makefile	1970-01-01 09:00:00.000000000 +0900
+++ mips/arch/mips/gt64120/cobalt/Makefile	2006-08-18 23:08:01.519502750 +0900
@@ -0,0 +1,9 @@
+#
+# Makefile for the Cobalt micro systems family specific parts of the kernel
+#
+
+obj-y	 := irq.o reset.o setup.o
+
+obj-$(CONFIG_EARLY_PRINTK)	+= console.o
+
+EXTRA_AFLAGS := $(CFLAGS)
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/cobalt/console.c mips/arch/mips/gt64120/cobalt/console.c
--- mips-orig/arch/mips/gt64120/cobalt/console.c	1970-01-01 09:00:00.000000000 +0900
+++ mips/arch/mips/gt64120/cobalt/console.c	2006-08-18 23:08:01.519502750 +0900
@@ -0,0 +1,47 @@
+/*
+ * (C) P. Horton 2006
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/console.h>
+#include <linux/serial_reg.h>
+#include <asm/addrspace.h>
+#include <asm/mach-cobalt/cobalt.h>
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
+
+void __init disable_early_printk(void)
+{
+	unregister_console(&cons_info);
+}
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/cobalt/irq.c mips/arch/mips/gt64120/cobalt/irq.c
--- mips-orig/arch/mips/gt64120/cobalt/irq.c	1970-01-01 09:00:00.000000000 +0900
+++ mips/arch/mips/gt64120/cobalt/irq.c	2006-08-18 23:08:01.519502750 +0900
@@ -0,0 +1,133 @@
+/*
+ * IRQ vector handles
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1995, 1996, 1997, 2003 by Ralf Baechle
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+
+#include <asm/i8259.h>
+#include <asm/irq_cpu.h>
+#include <asm/gt64120.h>
+#include <asm/ptrace.h>
+
+#include <asm/mach-cobalt/cobalt.h>
+
+/*
+ * We have two types of interrupts that we handle, ones that come in through
+ * the CPU interrupt lines, and ones that come in on the via chip. The CPU
+ * mappings are:
+ *
+ *    16   - Software interrupt 0 (unused)	IE_SW0
+ *    17   - Software interrupt 1 (unused)	IE_SW1
+ *    18   - Galileo chip (timer)		IE_IRQ0
+ *    19   - Tulip 0 + NCR SCSI			IE_IRQ1
+ *    20   - Tulip 1				IE_IRQ2
+ *    21   - 16550 UART				IE_IRQ3
+ *    22   - VIA southbridge PIC		IE_IRQ4
+ *    23   - unused				IE_IRQ5
+ *
+ * The VIA chip is a master/slave 8259 setup and has the following interrupts:
+ *
+ *     8  - RTC
+ *     9  - PCI
+ *    14  - IDE0
+ *    15  - IDE1
+ */
+
+static inline void galileo_irq(struct pt_regs *regs)
+{
+	unsigned int mask, pending, devfn;
+
+	mask = GT_READ(GT_INTRMASK_OFS);
+	pending = GT_READ(GT_INTRCAUSE_OFS) & mask;
+
+	if (pending & GALILEO_INTR_T0EXP) {
+
+		GT_WRITE(GT_INTRCAUSE_OFS, ~GALILEO_INTR_T0EXP);
+		do_IRQ(COBALT_GALILEO_IRQ, regs);
+
+	} else if (pending & GALILEO_INTR_RETRY_CTR) {
+
+		devfn = GT_READ(GT_PCI0_CFGADDR_OFS) >> 8;
+		GT_WRITE(GT_INTRCAUSE_OFS, ~GALILEO_INTR_RETRY_CTR);
+		printk(KERN_WARNING "Galileo: PCI retry count exceeded (%02x.%u)\n",
+			PCI_SLOT(devfn), PCI_FUNC(devfn));
+
+	} else {
+
+		GT_WRITE(GT_INTRMASK_OFS, mask & ~pending);
+		printk(KERN_WARNING "Galileo: masking unexpected interrupt %08x\n", pending);
+	}
+}
+
+static inline void via_pic_irq(struct pt_regs *regs)
+{
+	int irq;
+
+	irq = i8259_irq();
+	if (irq >= 0)
+		do_IRQ(irq, regs);
+}
+
+asmlinkage void plat_irq_dispatch(struct pt_regs *regs)
+{
+	unsigned pending;
+
+	pending = read_c0_status() & read_c0_cause();
+
+	if (pending & CAUSEF_IP2)			/* COBALT_GALILEO_IRQ (18) */
+
+		galileo_irq(regs);
+
+	else if (pending & CAUSEF_IP6)			/* COBALT_VIA_IRQ (22) */
+
+		via_pic_irq(regs);
+
+	else if (pending & CAUSEF_IP3)			/* COBALT_ETH0_IRQ (19) */
+
+		do_IRQ(COBALT_CPU_IRQ + 3, regs);
+
+	else if (pending & CAUSEF_IP4)			/* COBALT_ETH1_IRQ (20) */
+
+		do_IRQ(COBALT_CPU_IRQ + 4, regs);
+
+	else if (pending & CAUSEF_IP5)			/* COBALT_SERIAL_IRQ (21) */
+
+		do_IRQ(COBALT_CPU_IRQ + 5, regs);
+
+	else if (pending & CAUSEF_IP7)			/* IRQ 23 */
+
+		do_IRQ(COBALT_CPU_IRQ + 7, regs);
+}
+
+static struct irqaction irq_via = {
+	no_action, 0, { { 0, } }, "cascade", NULL, NULL
+};
+
+void __init arch_init_irq(void)
+{
+	/*
+	 * Mask all Galileo interrupts. The Galileo
+	 * handler is set in cobalt_timer_setup()
+	 */
+	GT_WRITE(GT_INTRMASK_OFS, 0);
+
+	init_i8259_irqs();				/*  0 ... 15 */
+	mips_cpu_irq_init(COBALT_CPU_IRQ);		/* 16 ... 23 */
+
+	/*
+	 * Mask all cpu interrupts
+	 *  (except IE4, we already masked those at VIA level)
+	 */
+	change_c0_status(ST0_IM, IE_IRQ4);
+
+	setup_irq(COBALT_VIA_IRQ, &irq_via);
+}
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/cobalt/reset.c mips/arch/mips/gt64120/cobalt/reset.c
--- mips-orig/arch/mips/gt64120/cobalt/reset.c	1970-01-01 09:00:00.000000000 +0900
+++ mips/arch/mips/gt64120/cobalt/reset.c	2006-08-18 23:08:01.519502750 +0900
@@ -0,0 +1,65 @@
+/*
+ * Cobalt Reset operations
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1995, 1996, 1997 by Ralf Baechle
+ * Copyright (C) 2001 by Liam Davies (ldavies@agile.tv)
+ */
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <asm/cacheflush.h>
+#include <asm/io.h>
+#include <asm/processor.h>
+#include <asm/reboot.h>
+#include <asm/system.h>
+#include <asm/mipsregs.h>
+#include <asm/mach-cobalt/cobalt.h>
+
+void cobalt_machine_halt(void)
+{
+	int state, last, diff;
+	unsigned long mark;
+
+	/*
+	 * turn off bar on Qube, flash power off LED on RaQ (0.5Hz)
+	 *
+	 * restart if ENTER and SELECT are pressed
+	 */
+
+	last = COBALT_KEY_PORT;
+
+	for (state = 0;;) {
+
+		state ^= COBALT_LED_POWER_OFF;
+		COBALT_LED_PORT = state;
+
+		diff = COBALT_KEY_PORT ^ last;
+		last ^= diff;
+
+		if((diff & (COBALT_KEY_ENTER | COBALT_KEY_SELECT)) && !(~last & (COBALT_KEY_ENTER | COBALT_KEY_SELECT)))
+			COBALT_LED_PORT = COBALT_LED_RESET;
+
+		for (mark = jiffies; jiffies - mark < HZ;)
+			;
+	}
+}
+
+void cobalt_machine_restart(char *command)
+{
+	COBALT_LED_PORT = COBALT_LED_RESET;
+
+	/* we should never get here */
+	cobalt_machine_halt();
+}
+
+/*
+ * This triggers the luser mode device driver for the power switch ;-)
+ */
+void cobalt_machine_power_off(void)
+{
+	printk("You can switch the machine off now.\n");
+	cobalt_machine_halt();
+}
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/cobalt/setup.c mips/arch/mips/gt64120/cobalt/setup.c
--- mips-orig/arch/mips/gt64120/cobalt/setup.c	1970-01-01 09:00:00.000000000 +0900
+++ mips/arch/mips/gt64120/cobalt/setup.c	2006-08-18 23:08:01.519502750 +0900
@@ -0,0 +1,212 @@
+/*
+ * Setup pointers to hardware dependent routines.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1996, 1997, 2004, 05 by Ralf Baechle (ralf@linux-mips.org)
+ * Copyright (C) 2001, 2002, 2003 by Liam Davies (ldavies@agile.tv)
+ *
+ */
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/pm.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+
+#include <asm/bootinfo.h>
+#include <asm/time.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/processor.h>
+#include <asm/reboot.h>
+#include <asm/gt64120.h>
+#include <asm/serial.h>
+
+#include <asm/mach-cobalt/cobalt.h>
+
+extern void cobalt_machine_restart(char *command);
+extern void cobalt_machine_halt(void);
+extern void cobalt_machine_power_off(void);
+extern void cobalt_early_console(void);
+
+int cobalt_board_id;
+
+const char *get_system_type(void)
+{
+	switch (cobalt_board_id) {
+		case COBALT_BRD_ID_QUBE1:
+			return "Cobalt Qube";
+		case COBALT_BRD_ID_RAQ1:
+			return "Cobalt RaQ";
+		case COBALT_BRD_ID_QUBE2:
+			return "Cobalt Qube2";
+		case COBALT_BRD_ID_RAQ2:
+			return "Cobalt RaQ2";
+	}
+	return "MIPS Cobalt";
+}
+
+void __init plat_timer_setup(struct irqaction *irq)
+{
+	/* Load timer value for 1KHz (TCLK is 50MHz) */
+	GT_WRITE(GT_TC0_OFS, 50*1000*1000 / 1000);
+
+	/* Enable timer */
+	GT_WRITE(GT_TC_CONTROL_OFS, GALILEO_ENTC0 | GALILEO_SELTC0);
+
+	/* Register interrupt */
+	setup_irq(COBALT_GALILEO_IRQ, irq);
+
+	/* Enable interrupt */
+	GT_WRITE(GT_INTRMASK_OFS, GALILEO_INTR_T0EXP | GT_READ(GT_INTRMASK_OFS));
+}
+
+extern struct pci_ops gt64120_pci_ops;
+
+static struct resource cobalt_mem_resource = {
+	.start	= GT_DEF_PCI0_MEM0_BASE,
+	.end	= GT_DEF_PCI0_MEM0_BASE + GT_DEF_PCI0_MEM0_SIZE - 1,
+	.name	= "PCI memory",
+	.flags	= IORESOURCE_MEM
+};
+
+static struct resource cobalt_io_resource = {
+	.start	= 0x1000,
+	.end	= 0xffff,
+	.name	= "PCI I/O",
+	.flags	= IORESOURCE_IO
+};
+
+static struct resource cobalt_io_resources[] = {
+	{
+		.start	= 0x00,
+		.end	= 0x1f,
+		.name	= "dma1",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0x40,
+		.end	= 0x5f,
+		.name	= "timer",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0x60,
+		.end	= 0x6f,
+		.name	= "keyboard",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0x80,
+		.end	= 0x8f,
+		.name	= "dma page reg",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0xc0,
+		.end	= 0xdf,
+		.name	= "dma2",
+		.flags	= IORESOURCE_BUSY
+	},
+};
+
+#define COBALT_IO_RESOURCES (sizeof(cobalt_io_resources)/sizeof(struct resource))
+
+static struct pci_controller cobalt_pci_controller = {
+	.pci_ops	= &gt64120_pci_ops,
+	.mem_resource	= &cobalt_mem_resource,
+	.mem_offset	= 0,
+	.io_resource	= &cobalt_io_resource,
+	.io_offset	= 0 - GT_DEF_PCI0_IO_BASE,
+};
+
+void __init plat_mem_setup(void)
+{
+	static struct uart_port uart;
+	unsigned int devfn = PCI_DEVFN(COBALT_PCICONF_VIA, 0);
+	int i;
+
+	_machine_restart = cobalt_machine_restart;
+	_machine_halt = cobalt_machine_halt;
+	pm_power_off = cobalt_machine_power_off;
+
+        set_io_port_base(CKSEG1ADDR(GT_DEF_PCI0_IO_BASE));
+
+	/* I/O port resource must include UART and LCD/buttons */
+	ioport_resource.end = 0x0fffffff;
+
+	/* request I/O space for devices used on all i[345]86 PCs */
+	for (i = 0; i < COBALT_IO_RESOURCES; i++)
+		request_resource(&ioport_resource, cobalt_io_resources + i);
+
+        /* Read the cobalt id register out of the PCI config space */
+        PCI_CFG_SET(devfn, (VIA_COBALT_BRD_ID_REG & ~0x3));
+        cobalt_board_id = GT_READ(GT_PCI0_CFGDATA_OFS);
+        cobalt_board_id >>= ((VIA_COBALT_BRD_ID_REG & 3) * 8);
+        cobalt_board_id = VIA_COBALT_BRD_REG_to_ID(cobalt_board_id);
+
+	printk("Cobalt board ID: %d\n", cobalt_board_id);
+
+#ifdef CONFIG_PCI
+	register_pci_controller(&cobalt_pci_controller);
+#endif
+
+#ifdef CONFIG_SERIAL_8250
+	if (cobalt_board_id > COBALT_BRD_ID_RAQ1) {
+
+#ifdef CONFIG_EARLY_PRINTK
+		cobalt_early_console();
+#endif
+
+		uart.line	= 0;
+		uart.type	= PORT_UNKNOWN;
+		uart.uartclk	= 18432000;
+		uart.irq	= COBALT_SERIAL_IRQ;
+		uart.flags	= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
+		uart.iobase	= 0xc800000;
+		uart.iotype	= UPIO_PORT;
+
+		early_serial_setup(&uart);
+	}
+#endif
+}
+
+/*
+ * Prom init. We read our one and only communication with the firmware.
+ * Grab the amount of installed memory.
+ * Better boot loaders (CoLo) pass a command line too :-)
+ */
+
+void __init prom_init(void)
+{
+	int narg, indx, posn, nchr;
+	unsigned long memsz;
+	char **argv;
+
+	mips_machgroup = MACH_GROUP_COBALT;
+
+	memsz = fw_arg0 & 0x7fff0000;
+	narg = fw_arg0 & 0x0000ffff;
+
+	if (narg) {
+		arcs_cmdline[0] = '\0';
+		argv = (char **) fw_arg1;
+		posn = 0;
+		for (indx = 1; indx < narg; ++indx) {
+			nchr = strlen(argv[indx]);
+			if (posn + 1 + nchr + 1 > sizeof(arcs_cmdline))
+				break;
+			if (posn)
+				arcs_cmdline[posn++] = ' ';
+			strcpy(arcs_cmdline + posn, argv[indx]);
+			posn += nchr;
+		}
+	}
+
+	add_memory_region(0x0, memsz, BOOT_MEM_RAM);
+}
+
+unsigned long __init prom_free_prom_memory(void)
+{
+	/* Nothing to do! */
+	return 0;
+}
