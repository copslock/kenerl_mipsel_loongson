Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 May 2006 16:42:32 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:11393 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S8133502AbWEEPmS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 5 May 2006 16:42:18 +0100
Received: from ala-mail04.corp.ad.wrs.com (ala-mail04 [147.11.57.145])
	by mail.wrs.com (8.13.6/8.13.3) with ESMTP id k45FgAPY015620;
	Fri, 5 May 2006 08:42:12 -0700 (PDT)
Received: from ism-mail01.corp.ad.wrs.com ([147.11.96.20]) by ala-mail04.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 5 May 2006 08:42:09 -0700
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 1/2] Wind River 4KC PPMC Eval Board Support
Date:	Fri, 5 May 2006 17:42:04 +0200
Message-ID: <6A3254532ACD7A42805B4E1BFD18080EB307A0@ism-mail01.corp.ad.wrs.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/2] Wind River 4KC PPMC Eval Board Support
Thread-Index: AcZwWnVbR80JPDvUTRCyPwJUbl9MWA==
From:	"Zhan, Rongkai" <rongkai.zhan@windriver.com>
To:	<linux-mips@linux-mips.org>
Cc:	<ralf@linux-mips.org>
X-OriginalArrivalTime: 05 May 2006 15:42:09.0826 (UTC) FILETIME=[78892820:01C6705A]
Return-Path: <rongkai.zhan@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rongkai.zhan@windriver.com
Precedence: bulk
X-list: linux-mips

Hello,

Here is a patch to add the support for Wind River 4KC PPMC Evaluation
board, which is based on the GT64120 bridge chip.

Mark. Zhan

Signed-off-by: Rongkai.Zhan <Rongkai.zhan@windriver.com>

diff -urN linux-2.6.16.11/arch/mips/gt64120/wrppmc/int-handler.S
linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/int-handler.S
--- linux-2.6.16.11/arch/mips/gt64120/wrppmc/int-handler.S
1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/int-handler.S
2006-05-05 16:38:12.000000000 +0800
@@ -0,0 +1,37 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General
Public
+ * License.  See the file "COPYING" in the main directory of this
archive
+ * for more details.
+ *
+ * Copyright (C) 1995, 1996, 1997, 2003 by Ralf Baechle
+ * Copyright (C) Wind River System Inc. Rongkai.Zhan
<rongkai.zhan@windriver.com>
+ */
+#include <asm/asm.h>
+#include <asm/mipsregs.h>
+#include <asm/addrspace.h>
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+
+	.align	5
+	.set	noat
+NESTED(handle_IRQ, PT_SIZE, sp)
+	SAVE_ALL
+	CLI				# Important: mark KERNEL mode !
+
+	mfc0	t0, CP0_CAUSE		# get pending interrupts
+	mfc0	t1, CP0_STATUS		# get enabled interrupts
+	and	t0, t0, t1		# get allowed interrupts
+	andi	t0, t0, 0xFF00
+	beqz	t0, 1f
+
+	move	a0, sp			# Prepare 'struct pt_regs *regs'
pointer
+	jal	do_wrppmc_IRQ
+	nop
+	j	ret_from_irq
+	nop
+
+	/* wrong alarm or masked ... */
+1:	j	spurious_interrupt
+	nop
+END(handle_IRQ)
+
diff -urN linux-2.6.16.11/arch/mips/gt64120/wrppmc/irq.c
linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/irq.c
--- linux-2.6.16.11/arch/mips/gt64120/wrppmc/irq.c	1970-01-01
08:00:00.000000000 +0800
+++ linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/irq.c	2006-05-05
17:30:57.000000000 +0800
@@ -0,0 +1,76 @@
+/*
+ * irq.c: GT64120 Interrupt Controller
+ * 
+ * Copyright (C) 2006, Wind River System Inc.
+ * Author: Rongkai.Zhan, <rongkai.zhan@windriver.com>
+ *
+ * This program is free software; you can redistribute  it and/or
modify it
+ * under  the terms of  the GNU General  Public License as published by
the
+ * Free Software Foundation;  either version 2 of the  License, or (at
your
+ * option) any later version.
+ */
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel_stat.h>
+#include <linux/module.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/timex.h>
+#include <linux/slab.h>
+#include <linux/random.h>
+#include <linux/bitops.h>
+#include <asm/bootinfo.h>
+#include <asm/io.h>
+#include <asm/bitops.h>
+#include <asm/mipsregs.h>
+#include <asm/system.h>
+#include <asm/irq_cpu.h>
+#include <asm/gt64120.h>
+
+extern asmlinkage void handle_IRQ(void);
+
+asmlinkage void do_wrppmc_IRQ(struct pt_regs *regs)
+{
+	unsigned long pending;
+	int irq;
+	
+	pending = read_c0_cause();
+	pending &= read_c0_status();
+	pending = (pending & 0xFF00) >> 8;
+	irq = ffs(pending) - 1;
+	
+	do_IRQ(irq, regs);
+}
+
+/**
+ * Initialize GT64120 Interrupt Controller
+ */
+void gt64120_init_pic(void)
+{
+	/* clear CPU Interrupt Cause Registers */
+	GT_WRITE(GT_INTRCAUSE_OFS, (0x1F << 21));
+	GT_WRITE(GT_HINTRCAUSE_OFS, 0x00);
+	
+	/* Disable all interrupts from GT64120 bridge chip */
+	GT_WRITE(GT_INTRMASK_OFS, 0x00);
+	GT_WRITE(GT_HINTRMASK_OFS, 0x00);
+	GT_WRITE(GT_PCI0_ICMASK_OFS, 0x00);
+	GT_WRITE(GT_PCI0_HICMASK_OFS, 0x00);
+}
+
+void __init arch_init_irq(void)
+{
+	/* enable all CPU interrupt bits. */
+	set_c0_status(ST0_IM);	/* IE bit is still 0 */
+
+	/* Install MIPS Interrupt Trap Vector */
+	set_except_vector(0, handle_IRQ);
+
+	/* IRQ 0 - 7 are for MIPS common irq_cpu controller */
+	mips_cpu_irq_init(0);
+	
+	gt64120_init_pic();
+}
diff -urN linux-2.6.16.11/arch/mips/gt64120/wrppmc/Makefile
linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/Makefile
--- linux-2.6.16.11/arch/mips/gt64120/wrppmc/Makefile	1970-01-01
08:00:00.000000000 +0800
+++ linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/Makefile
2006-04-14 15:25:48.000000000 +0800
@@ -0,0 +1,14 @@
+#
+# This file is subject to the terms and conditions of the GNU General
Public
+# License.  See the file "COPYING" in the main directory of this
archive
+# for more details.
+#
+# Copyright 2006 Wind River System, Inc.
+# Author: Rongkai.Zhan <rongkai.zhan@windriver.com>
+#
+# Makefile for the Wind River MIPS 4KC PPMC Eval Board
+#
+
+obj-y	+= int-handler.o irq.o reset.o setup.o time.o pci.o
+
+EXTRA_AFLAGS := $(CFLAGS)
diff -urN linux-2.6.16.11/arch/mips/gt64120/wrppmc/pci.c
linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/pci.c
--- linux-2.6.16.11/arch/mips/gt64120/wrppmc/pci.c	1970-01-01
08:00:00.000000000 +0800
+++ linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/pci.c	2006-05-05
17:25:48.000000000 +0800
@@ -0,0 +1,53 @@
+/*
+ * pci.c: GT64120 PCI support.
+ *
+ * Copyright (C) 2006, Wind River System Inc. Rongkai.Zhan
<rongkai.zhan@windriver.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General
Public
+ * License.  See the file "COPYING" in the main directory of this
archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <asm/gt64120.h>
+
+extern struct pci_ops gt64120_pci_ops;
+
+static struct resource pci0_io_resource = {
+	.name  = "pci_0 io",
+	.start = GT_PCI_IO_BASE,
+	.end   = GT_PCI_IO_BASE + GT_PCI_IO_SIZE - 1,
+	.flags = IORESOURCE_IO,
+};
+
+static struct resource pci0_mem_resource = {
+	.name  = "pci_0 memory", 
+	.start = GT_PCI_MEM_BASE,
+	.end   = GT_PCI_MEM_BASE + GT_PCI_MEM_SIZE - 1,
+	.flags = IORESOURCE_MEM,
+};
+
+static struct pci_controller hose_0 = {
+	.pci_ops	= &gt64120_pci_ops,
+	.io_resource	= &pci0_io_resource,
+	.mem_resource	= &pci0_mem_resource,
+};
+
+static int __init gt64120_pci_init(void)
+{
+	u32 tmp;
+
+	tmp = GT_READ(GT_PCI0_CMD_OFS);		/* Huh??? -- Ralf  */
+	tmp = GT_READ(GT_PCI0_BARE_OFS);
+
+	/* reset the whole PCI I/O space range */
+	ioport_resource.start = GT_PCI_IO_BASE;
+	ioport_resource.end = GT_PCI_IO_BASE + GT_PCI_IO_SIZE - 1;
+
+	register_pci_controller(&hose_0);
+	return 0;
+}
+
+arch_initcall(gt64120_pci_init);
diff -urN linux-2.6.16.11/arch/mips/gt64120/wrppmc/reset.c
linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/reset.c
--- linux-2.6.16.11/arch/mips/gt64120/wrppmc/reset.c	1970-01-01
08:00:00.000000000 +0800
+++ linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/reset.c
2006-04-13 22:24:56.000000000 +0800
@@ -0,0 +1,50 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General
Public
+ * License.  See the file "COPYING" in the main directory of this
archive
+ * for more details.
+ *
+ * Copyright (C) 1997 Ralf Baechle
+ */
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include <asm/processor.h>
+#include <asm/reboot.h>
+#include <asm/system.h>
+#include <asm/cacheflush.h>
+
+void wrppmc_machine_restart(char *command)
+{
+	/*
+	 * Ouch, we're still alive ... This time we take the silver
bullet ...
+	 * ... and find that we leave the hardware in a state in which
the
+	 * kernel in the flush locks up somewhen during of after the PCI
+	 * detection stuff.
+	 */
+	local_irq_disable();
+	set_c0_status(ST0_BEV | ST0_ERL);
+	change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
+	flush_cache_all();
+	write_c0_wired(0);
+	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
+}
+
+void wrppmc_machine_halt(void)
+{
+	local_irq_disable();
+	
+	printk(KERN_NOTICE "You can safely turn off the power\n");
+	while (1) {
+		__asm__(
+			".set\tmips3\n\t"
+			"wait\n\t"
+			".set\tmips0"
+		);
+	}
+}
+
+void wrppmc_machine_power_off(void)
+{
+	wrppmc_machine_halt();
+}
diff -urN linux-2.6.16.11/arch/mips/gt64120/wrppmc/setup.c
linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/setup.c
--- linux-2.6.16.11/arch/mips/gt64120/wrppmc/setup.c	1970-01-01
08:00:00.000000000 +0800
+++ linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/setup.c
2006-05-05 17:08:27.000000000 +0800
@@ -0,0 +1,173 @@
+/*
+ * setup.c: Setup pointers to hardware dependent routines.
+ *
+ * This file is subject to the terms and conditions of the GNU General
Public
+ * License.  See the file "COPYING" in the main directory of this
archive
+ * for more details.
+ *
+ * Copyright (C) 1996, 1997, 2004 by Ralf Baechle (ralf@linux-mips.org)
+ * Copyright (C) 2006, Wind River System Inc. Rongkai.zhan
<rongkai.zhan@windriver.com>
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/pm.h>
+
+#include <asm/io.h>
+#include <asm/bootinfo.h>
+#include <asm/reboot.h>
+#include <asm/time.h>
+#include <asm/gt64120.h>
+
+unsigned long gt64120_base = KSEG1ADDR(0x14000000);
+
+#ifdef WRPPMC_EARLY_DEBUG
+
+static volatile unsigned char * wrppmc_led = \
+	(volatile unsigned char *)KSEG1ADDR(WRPPMC_LED_BASE);
+
+/*
+ * PPMC LED control register:
+ * -) bit[0] controls DS1 LED (1 - OFF, 0 - ON)
+ * -) bit[1] controls DS2 LED (1 - OFF, 0 - ON)
+ * -) bit[2] controls DS4 LED (1 - OFF, 0 - ON)
+ */
+void wrppmc_led_on(int mask)
+{
+	unsigned char value = *wrppmc_led;
+	
+	value &= (0xF8 | mask);
+	*wrppmc_led = value;
+}
+
+/* If mask = 0, turn off all LEDs */
+void wrppmc_led_off(int mask)
+{
+	unsigned char value = *wrppmc_led;
+
+	value |= (0x7 & mask);
+	*wrppmc_led = value;
+}
+
+/*
+ * We assume that bootloader has initialized UART16550 correctly
+ */
+void __init wrppmc_early_putc(char ch)
+{
+	static volatile unsigned char *wrppmc_uart = \
+		(volatile unsigned char
*)KSEG1ADDR(WRPPMC_UART16550_BASE);
+	unsigned char value;
+
+	/* Wait until Transmit-Holding-Register is empty */
+	while (1) {
+		value = *(wrppmc_uart + 5);
+		if (value & 0x20)
+			break;
+	}
+	
+	*wrppmc_uart = ch;
+}
+
+void __init wrppmc_early_printk(const char *fmt, ...)
+{
+	static char pbuf[256] = {'\0', };
+	char *ch = pbuf;
+	va_list args;
+	unsigned int i;
+
+	memset(pbuf, 0, 256);
+	va_start(args, fmt);
+	i = vsprintf(pbuf, fmt, args);
+	va_end(args);
+
+	/* Print the string */
+	while (*ch != '\0') {
+		wrppmc_early_putc(*ch);
+		/* if print '\n', also print '\r' */
+		if (*ch++ == '\n')
+			wrppmc_early_putc('\r');
+	}
+}
+#endif /* WRPPMC_EARLY_DEBUG */
+
+unsigned long __init prom_free_prom_memory(void)
+{
+	return 0;
+}
+
+#ifdef CONFIG_SERIAL_8250
+static void wrppmc_setup_serial(void)
+{
+	struct uart_port up;
+	
+	memset(&up, 0x00, sizeof(struct uart_port));
+
+	/*
+	 * A note about mapbase/membase
+	 * -) mapbase is the physical address of the IO port.
+	 * -) membase is an 'ioremapped' cookie.
+	 */
+	up.line = 0;
+	up.type = PORT_16550;
+	up.iotype = UPIO_MEM;
+	up.mapbase = WRPPMC_UART16550_BASE;
+	up.membase = ioremap(up.mapbase, 8);
+	up.irq = WRPPMC_UART16550_IRQ;
+	up.uartclk = WRPPMC_UART16550_CLOCK;
+	up.flags = UPF_SKIP_TEST/* | UPF_BOOT_AUTOCONF */;
+	up.regshift = 0;
+	
+	early_serial_setup(&up);
+}
+#endif
+
+void __init plat_setup(void)
+{
+	extern void wrppmc_time_init(void);
+	extern void wrppmc_timer_setup(struct irqaction *);
+	extern void wrppmc_machine_restart(char *command);
+	extern void wrppmc_machine_halt(void);
+	extern void wrppmc_machine_power_off(void);
+	
+	_machine_restart = wrppmc_machine_restart;
+	_machine_halt	 = wrppmc_machine_halt;
+	pm_power_off	 = wrppmc_machine_power_off;
+	
+	/* Use MIPS Count/Compare Timer */
+	board_time_init   = wrppmc_time_init;
+	board_timer_setup = wrppmc_timer_setup;
+
+	/* This makes the operations of 'in/out[bwl]' to the
+	 * physical address ( < KSEG0) can work via KSEG1
+	 */
+	set_io_port_base(KSEG1);
+
+#ifdef CONFIG_SERIAL_8250
+	wrppmc_setup_serial();
+#endif
+}
+
+const char *get_system_type(void)
+{
+	return "Wind River PPMC (GT64120)";
+}
+
+/*
+ * Initializes basic routines and structures pointers, memory size (as
+ * given by the bios and saves the command line.
+ */
+void __init prom_init(void)
+{
+	mips_machgroup = MACH_GROUP_GALILEO;
+	mips_machtype = MACH_EV64120A;
+
+	add_memory_region(WRPPMC_SDRAM_SCS0_BASE,
WRPPMC_SDRAM_SCS0_SIZE, BOOT_MEM_RAM);
+	add_memory_region(WRPPMC_BOOTROM_BASE, WRPPMC_BOOTROM_SIZE,
BOOT_MEM_ROM_DATA);
+	
+	wrppmc_early_printk("prom_init: GT64120 SDRAM Bank 0: 0x%x -
0x%08lx\n",
+			WRPPMC_SDRAM_SCS0_BASE, (WRPPMC_SDRAM_SCS0_BASE
+ WRPPMC_SDRAM_SCS0_SIZE));
+}
diff -urN linux-2.6.16.11/arch/mips/gt64120/wrppmc/time.c
linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/time.c
--- linux-2.6.16.11/arch/mips/gt64120/wrppmc/time.c	1970-01-01
08:00:00.000000000 +0800
+++ linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/time.c
2006-05-05 16:39:32.000000000 +0800
@@ -0,0 +1,57 @@
+/*
+ * time.c: MIPS CPU Count/Compare timer hookup
+ *
+ * Author: Mark.Zhan, <rongkai.zhan@windriver.com>
+ * 
+ * This file is subject to the terms and conditions of the GNU General
Public
+ * License.  See the file "COPYING" in the main directory of this
archive
+ * for more details.
+ *
+ * Copyright (C) 1996, 1997, 2004 by Ralf Baechle (ralf@linux-mips.org)
+ * Copyright (C) 2006, Wind River System Inc.
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/param.h>	/* for HZ */
+#include <linux/irq.h>
+#include <linux/timex.h>
+#include <linux/interrupt.h>
+
+#include <asm/reboot.h>
+#include <asm/time.h>
+#include <asm/io.h>
+#include <asm/bootinfo.h>
+#include <asm/gt64120.h>
+
+#define WRPPMC_CPU_CLK_FREQ 40000000 /* 40MHZ */
+
+void __init wrppmc_timer_setup(struct irqaction *irq)
+{
+	/* Install ISR for timer interrupt */
+	setup_irq(WRPPMC_MIPS_TIMER_IRQ, irq);
+
+	/* to generate the first timer interrupt */
+	write_c0_compare(mips_hpt_frequency/HZ);
+	write_c0_count(0);
+}
+
+/*
+ * Estimate CPU frequency.  Sets mips_hpt_frequency as a side-effect
+ * 
+ * NOTE: We disable all GT64120 timers, and use MIPS processor internal
+ * timer as the source of kernel clock tick.
+ */
+void __init wrppmc_time_init(void)
+{
+	/* Disable GT64120 timers */
+	GT_WRITE(GT_TC_CONTROL_OFS, 0x00);
+	GT_WRITE(GT_TC0_OFS, 0x00);
+	GT_WRITE(GT_TC1_OFS, 0x00);
+	GT_WRITE(GT_TC2_OFS, 0x00);
+	GT_WRITE(GT_TC3_OFS, 0x00);
+
+	/* Use MIPS compare/count internal timer */
+	mips_hpt_frequency = WRPPMC_CPU_CLK_FREQ;
+}
diff -urN linux-2.6.16.11/arch/mips/Kconfig
linux-2.6.16.11-ppmc/arch/mips/Kconfig
--- linux-2.6.16.11/arch/mips/Kconfig	2006-04-25 04:20:24.000000000
+0800
+++ linux-2.6.16.11-ppmc/arch/mips/Kconfig	2006-05-05
10:53:40.000000000 +0800
@@ -326,6 +326,27 @@
 	  This enables support for the MIPS Technologies SEAD evaluation
 	  board.
 
+config WR_PPMC
+	bool "Support for Wind River PPMC board"
+	select IRQ_CPU
+	select BOOT_ELF32
+	select DMA_NONCOHERENT
+	select HW_HAS_PCI
+	select MIPS_GT64120
+	select SWAP_IO_SPACE
+	select SYS_HAS_CPU_MIPS32_R1
+	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_HAS_CPU_MIPS64_R1
+	select SYS_HAS_CPU_NEVADA
+	select SYS_HAS_CPU_RM7000
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	help
+	  This enables support for the Wind River MIPS32 4KC PPMC
evaluation
+	  board, which is based on GT64120 bridge chip.
+
 config MIPS_SIM
 	bool 'Support for MIPS simulator (MIPSsim)'
 	select DMA_NONCOHERENT
diff -urN linux-2.6.16.11/arch/mips/Makefile
linux-2.6.16.11-ppmc/arch/mips/Makefile
--- linux-2.6.16.11/arch/mips/Makefile	2006-04-25 04:20:24.000000000
+0800
+++ linux-2.6.16.11-ppmc/arch/mips/Makefile	2006-05-05
12:42:16.000000000 +0800
@@ -419,6 +419,13 @@
 load-$(CONFIG_MIPS_EV96100)	+= 0xffffffff80100000
 
 #
+# Wind River PPMC Board (4KC + GT64120)
+#
+core-$(CONFIG_WR_PPMC)		+= arch/mips/gt64120/wrppmc/
+cflags-$(CONFIG_WR_PPMC)		+=
-Iinclude/asm-mips/mach-wrppmc
+load-$(CONFIG_WR_PPMC)		+= 0xffffffff80100000
+
+#
 # Globespan IVR eval board with QED 5231 CPU
 #
 core-$(CONFIG_ITE_BOARD_GEN)	+= arch/mips/ite-boards/generic/
diff -urN linux-2.6.16.11/arch/mips/pci/fixup-wrppmc.c
linux-2.6.16.11-ppmc/arch/mips/pci/fixup-wrppmc.c
--- linux-2.6.16.11/arch/mips/pci/fixup-wrppmc.c	1970-01-01
08:00:00.000000000 +0800
+++ linux-2.6.16.11-ppmc/arch/mips/pci/fixup-wrppmc.c	2006-05-05
16:40:01.000000000 +0800
@@ -0,0 +1,37 @@
+/*
+ * fixup-wrppmc.c: PPMC board specific PCI fixup
+ * 
+ * This file is subject to the terms and conditions of the GNU General
Public
+ * License.  See the file "COPYING" in the main directory of this
archive
+ * for more details.
+ *
+ * Copyright (C) 2006, Wind River Inc. Rongkai.zhan
(rongkai.zhan@windriver.com)
+ */
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <asm/gt64120.h>
+
+/* PCI interrupt pins */
+#define PCI_INTA		1
+#define PCI_INTB		2
+#define PCI_INTC		3
+#define PCI_INTD		4
+
+#define PCI_SLOT_MAXNR	32 /* Each PCI bus has 32 physical slots */
+
+static char pci_irq_tab[PCI_SLOT_MAXNR][5] __initdata = {
+	/* 0    INTA   INTB   INTC   INTD */
+	[0] = {0, 0, 0, 0, 0},		/* Slot 0: GT64120 PCI bridge */
+	[6] = {0, WRPPMC_PCI_INTA, 0, 0, 0},
+};
+
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	return pci_irq_tab[slot][pin];
+}
+
+/* Do platform specific device initialization at pci_enable_device()
time */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
diff -urN linux-2.6.16.11/arch/mips/pci/Makefile
linux-2.6.16.11-ppmc/arch/mips/pci/Makefile
--- linux-2.6.16.11/arch/mips/pci/Makefile	2006-04-25
04:20:24.000000000 +0800
+++ linux-2.6.16.11-ppmc/arch/mips/pci/Makefile	2006-05-05
11:30:44.000000000 +0800
@@ -57,3 +57,4 @@
 obj-$(CONFIG_TOSHIBA_RBTX4938)	+= fixup-tx4938.o ops-tx4938.o
 obj-$(CONFIG_VICTOR_MPC30X)	+= fixup-mpc30x.o
 obj-$(CONFIG_ZAO_CAPCELLA)	+= fixup-capcella.o
+obj-$(CONFIG_WR_PPMC)		+= fixup-wrppmc.o
diff -urN linux-2.6.16.11/include/asm-mips/mach-wrppmc/mach-gt64120.h
linux-2.6.16.11-ppmc/include/asm-mips/mach-wrppmc/mach-gt64120.h
--- linux-2.6.16.11/include/asm-mips/mach-wrppmc/mach-gt64120.h
1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.16.11-ppmc/include/asm-mips/mach-wrppmc/mach-gt64120.h
2006-05-05 16:56:33.000000000 +0800
@@ -0,0 +1,81 @@
+/*
+ * This is a direct copy of the ev96100.h file, with a global
+ * search and replace.  The numbers are the same.
+ *
+ * The reason I'm duplicating this is so that the 64120/96100
+ * defines won't be confusing in the source code.
+ */
+#ifndef __ASM_MIPS_GT64120_H
+#define __ASM_MIPS_GT64120_H
+
+/*
+ * GT64120 config space base address
+ */
+extern unsigned long gt64120_base;
+
+#define GT64120_BASE	(gt64120_base)
+
+/*
+ * This is the CPU physical memory map of PPMC Board:
+ *
+ *    0x00000000-0x03FFFFFF      - 64MB SDRAM (SCS[0]#)
+ *    0x1C000000-0x1C000000      - LED (CS0)
+ *    0x1C800000-0x1C800007      - UART 16550 port (CS1)
+ *    0x1F000000-0x1F000000      - MailBox (CS3)
+ *    0x1FC00000-0x20000000      - 4MB Flash (BOOT CS)
+ */
+
+#define WRPPMC_SDRAM_SCS0_BASE	0x00000000
+#define WRPPMC_SDRAM_SCS0_SIZE	0x04000000
+
+#define WRPPMC_UART16550_BASE	0x1C800000
+#define WRPPMC_UART16550_CLOCK	3686400 /* 3.68MHZ */
+
+#define WRPPMC_LED_BASE		0x1C000000
+#define WRPPMC_MBOX_BASE	0x1F000000
+
+#define WRPPMC_BOOTROM_BASE	0x1FC00000
+#define WRPPMC_BOOTROM_SIZE	0x00400000 /* 4M Flash */
+
+#define WRPPMC_MIPS_TIMER_IRQ	7 /* MIPS compare/count timer interrupt
*/
+#define WRPPMC_UART16550_IRQ	6
+#define WRPPMC_PCI_INTA		3
+
+/*
+ * PCI Bus I/O and Memory resources allocation
+ *
+ * NOTE: We only have PCI_0 hose interface
+ */
+#define GT_PCI_MEM_BASE	0x13000000UL
+#define GT_PCI_MEM_SIZE	0x02000000UL
+#define GT_PCI_IO_BASE	0x11000000UL
+#define GT_PCI_IO_SIZE	0x02000000UL
+#define GT_ISA_IO_BASE	PCI_IO_BASE
+
+/*
+ * PCI interrupts will come in on either the INTA or INTD interrups
lines,
+ * which are mapped to the #2 and #5 interrupt pins of the MIPS.  On
our
+ * boards, they all either come in on IntD or they all come in on IntA,
they
+ * aren't mixed. There can be numerous PCI interrupts, so we keep a
list of the
+ * "requested" interrupt numbers and go through the list whenever we
get an
+ * IntA/D.
+ *
+ * Interrupts < 8 are directly wired to the processor; PCI INTA is 8
and
+ * INTD is 11.
+ */
+#define GT_TIMER	4
+#define GT_INTA		2
+#define GT_INTD		5
+
+/* define WRPPMC_EARLY_DEBUG to enable early output something to UART
*/
+#undef WRPPMC_EARLY_DEBUG
+
+#ifdef WRPPMC_EARLY_DEBUG
+extern void wrppmc_led_on(int mask);
+extern void wrppmc_led_off(int mask);
+extern void wrppmc_early_printk(const char *fmt, ...);
+#else
+#define wrppmc_early_printk(fmt, ...) do {} while (0)
+#endif /* WRPPMC_EARLY_DEBUG */
+
+#endif /* __ASM_MIPS_GT64120_H */
