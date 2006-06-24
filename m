Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jun 2006 02:57:33 +0100 (BST)
Received: from mother.pmc-sierra.com ([216.241.224.12]:56246 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S8133862AbWFXB5P (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Jun 2006 02:57:15 +0100
Received: (qmail 8288 invoked by uid 101); 24 Jun 2006 01:57:08 -0000
Received: from unknown (HELO ogyruan.pmc-sierra.bc.ca) (216.241.226.236)
  by mother.pmc-sierra.com with SMTP; 24 Jun 2006 01:57:08 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogyruan.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id k5O1v7nt005477;
	Fri, 23 Jun 2006 18:57:08 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <JPF7KJLQ>; Fri, 23 Jun 2006 18:57:07 -0700
Message-ID: <C28979E4F697C249ABDA83AC0C33CDF8143EF7@sjc1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Kiran Thota <Kiran_Thota@pmc-sierra.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	Raj Palani <Rajesh_Palani@pmc-sierra.com>
Subject: [Patch 3/6] Sequoia Platform
Date:	Fri, 23 Jun 2006 18:56:54 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Kiran_Thota@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Kiran_Thota@pmc-sierra.com
Precedence: bulk
X-list: linux-mips



- Add IRQ controller (hacked from irq-rm9000.c)
- Add Interrupt handlers
- Add Sequoia platform compile to Makefile
- Add PMON2000 (boot loader) hand-over code
- Add Sequoia setup code
- Add flags for platform
- Add reg defns and macros for RM915x/MSP85x0

Signed-off-by: Kiran Kumar Thota <kiran_thota@pmc-sierra.com>

diff -Naur a/arch/mips/pmc-sierra/sequoia/irq.c b/arch/mips/pmc-sierra/sequoia/irq.c
--- a/arch/mips/pmc-sierra/sequoia/irq.c	1969-12-31 16:00:00.000000000 -0800
+++ b/arch/mips/pmc-sierra/sequoia/irq.c	2006-06-23 14:35:21.000000000 -0700
@@ -0,0 +1,224 @@
+/*
+ * Copyright (C) 2003 Ralf Baechle
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * Handler for RM9000 extended interrupts.  These are a non-standard
+ * feature so we handle them separately from standard interrupts.
+ */
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include <asm/irq_cpu.h>
+#include <asm/mipsregs.h>
+#include <asm/system.h>
+#include <asm/pmc_sequoia.h>
+
+static int irq_base;
+
+static inline void unmask_rm9k_irq(unsigned int irq)
+{
+	set_c0_intcontrol(0x1000 << (irq - irq_base));
+}
+
+static inline void mask_rm9k_irq(unsigned int irq)
+{
+	clear_c0_intcontrol(0x1000 << (irq - irq_base));
+}
+
+static inline void rm9k_cpu_irq_enable(unsigned int irq)
+{
+	unsigned long flags;
+
+	/* convert PCI irq numbers to cp0_intmask bit */
+	irq = (10 < irq < 15)? 11 : irq;
+	local_irq_save(flags);
+	if (irq == 11)
+		set_c0_intcontrol(0x100 << 3);
+	else
+		unmask_rm9k_irq(irq);
+
+	local_irq_restore(flags);
+}
+
+static void rm9k_cpu_irq_disable(unsigned int irq)
+{
+	unsigned long flags;
+
+	/* convert PCI irq numbers to cp0_intmask bit */
+	irq = (10 < irq < 15)? 11 : irq;
+	local_irq_save(flags);
+	if (irq == 11)
+		clear_c0_intcontrol(0x100 << 3);
+	else
+		mask_rm9k_irq(irq);
+
+	local_irq_restore(flags);
+}
+
+static unsigned int rm9k_cpu_irq_startup(unsigned int irq)
+{
+	rm9k_cpu_irq_enable(irq);
+
+	return 0;
+}
+
+#define	rm9k_cpu_irq_shutdown	rm9k_cpu_irq_disable
+
+/*
+ * Performance counter interrupts are global on all processors.
+ */
+static void local_rm9k_perfcounter_irq_startup(void *args)
+{
+	unsigned int irq = (unsigned int) args;
+
+	rm9k_cpu_irq_enable(irq);
+}
+
+static unsigned int rm9k_perfcounter_irq_startup(unsigned int irq)
+{
+	on_each_cpu(local_rm9k_perfcounter_irq_startup, (void *) irq, 0, 1);
+
+	return 0;
+}
+
+static void local_rm9k_perfcounter_irq_shutdown(void *args)
+{
+	unsigned int irq = (unsigned int) args;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	mask_rm9k_irq(irq);
+	local_irq_restore(flags);
+}
+
+static void rm9k_perfcounter_irq_shutdown(unsigned int irq)
+{
+	on_each_cpu(local_rm9k_perfcounter_irq_shutdown, (void *) irq, 0, 1);
+}
+
+
+/*
+ * While we ack the interrupt interrupts are disabled and thus we don't need
+ * to deal with concurrency issues.  Same for rm9k_cpu_irq_end.
+ */
+static void rm9k_cpu_irq_ack(unsigned int irq)
+{
+	/* convert PCI irq numbers to cp0_intmask bit */
+	irq = (10 < irq < 15)? 11 : irq;
+	if (irq == 11)
+		clear_c0_intcontrol(0x100 << 3);
+	else
+		mask_rm9k_irq(irq);
+}
+
+static void rm9k_cpu_irq_end(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
+		/* convert PCI irq numbers to cp0_intmask bit */
+		irq = (10 < irq < 15)? 11 : irq;
+		if (irq == 11)
+			set_c0_intcontrol(0x100 << 3);
+		else
+			unmask_rm9k_irq(irq);
+	}
+}
+
+static hw_irq_controller rm9k_irq_controller = {
+	.typename = "RM9000",
+	.startup = rm9k_cpu_irq_startup,
+	.shutdown = rm9k_cpu_irq_shutdown,
+	.enable = rm9k_cpu_irq_enable,
+	.disable = rm9k_cpu_irq_disable,
+	.ack = rm9k_cpu_irq_ack,
+	.end = rm9k_cpu_irq_end,
+};
+
+static hw_irq_controller rm9k_perfcounter_irq = {
+	.typename = "RM9000",
+	.startup = rm9k_perfcounter_irq_startup,
+	.shutdown = rm9k_perfcounter_irq_shutdown,
+	.enable = rm9k_cpu_irq_enable,
+	.disable = rm9k_cpu_irq_disable,
+	.ack = rm9k_cpu_irq_ack,
+	.end = rm9k_cpu_irq_end,
+};
+
+unsigned int rm9000_perfcount_irq;
+
+EXPORT_SYMBOL(rm9000_perfcount_irq);
+
+void __init rm9k_cpu_irq_init(int base)
+{
+	int i;
+
+	clear_c0_intcontrol(0x0000f000);		/* Mask all */
+
+	for (i = base; i < base + 4; i++) {
+		irq_desc[i].status = IRQ_DISABLED;
+		irq_desc[i].action = NULL;
+		irq_desc[i].depth = 1;
+		irq_desc[i].handler = &rm9k_irq_controller;
+	}
+
+	rm9000_perfcount_irq = base + 1;
+	irq_desc[rm9000_perfcount_irq].handler = &rm9k_perfcounter_irq;
+
+	irq_base = base;
+}
+
+
+extern asmlinkage void sequoia_handle_int(void);
+
+/*
+ * Handle PCI interrupts.
+ */
+asmlinkage void pmc_sequoia_pci_isr(int irq, struct pt_regs *regs)
+{
+        u_int8_t status;
+
+        /* check FPGA intr status register to determine the intr source */
+        status = SEQUOIA_FPGA_READ(SEQUOIA_FPGA_INTR_STATUS);
+
+        if (~status & (0x3 << 0)) {             /* bus 0, slot 0 */
+                do_IRQ(11, regs);
+        }
+        if (~status & (0x3 << 2)) {             /* bus 0, slot 1 */
+                do_IRQ(12, regs);
+        }
+
+        if (~status & (0x3 << 4)) {             /* bus 1, slot 0 */
+                do_IRQ(13, regs);
+        }
+        if (~status & (0x3 << 6)) {             /* bus 1, slot 1 */
+                do_IRQ(14, regs);
+        }
+}
+
+static struct irqaction unused_irq =
+	{ no_action, SA_INTERRUPT, 0, "unused", NULL, NULL };
+
+extern unsigned long exception_handlers[32];
+
+/*
+ * Initialize the next level interrupt handler
+ */
+void __init arch_init_irq(void)
+{
+	int i;
+
+	clear_c0_status(ST0_IM);
+	set_c0_status(ST0_IM);
+
+      set_except_vector(0, sequoia_handle_int);
+      mips_cpu_irq_init(0);
+      rm7k_cpu_irq_init(8);
+  	 rm9k_cpu_irq_init(12);
+}
+
+
diff -Naur a/arch/mips/pmc-sierra/sequoia/irq-handler.S b/arch/mips/pmc-sierra/sequoia/irq-handler.S
--- a/arch/mips/pmc-sierra/sequoia/irq-handler.S	1969-12-31 16:00:00.000000000 -0800
+++ b/arch/mips/pmc-sierra/sequoia/irq-handler.S	2006-06-22 14:55:16.000000000 -0700
@@ -0,0 +1,99 @@
+/*
+ * Copyright 2006 PMC-Sierra Inc.
+ * Author: PMC SIerra Inc (thotakir@pmc-sierra.com)
+ *
+ * First-level interrupt router for the PMC-Sierra Sequoia board
+ *
+ */
+
+#define __ASSEMBLY__
+#include <linux/config.h>
+#include <asm/asm.h>
+#include <asm/mipsregs.h>
+#include <asm/addrspace.h>
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+
+		.align	5
+		NESTED(sequoia_handle_int, PT_SIZE, sp)
+		SAVE_ALL
+		CLI
+		.set	at
+		.set	noreorder
+		mfc0	t0, CP0_CAUSE
+		mfc0	t2, CP0_STATUS
+
+		and	t0, t2
+
+		andi    t1, t0, STATUSF_IP0     /* sw0 software interrupt */
+           bnez    t1, ll_sw0_irq
+           andi    t1, t0, STATUSF_IP1     /* sw1 software interrupt */
+           bnez    t1, ll_sw1_irq	
+		/* IP4 reserved for DUART */
+		andi    t1, t0, STATUSF_IP5	/* XDMA interrupts */
+		bnez    t1, ll_xdma_irq
+		/* IP6 reserved for HyperTransport, not supported */
+		andi	t1, t0, STATUSF_IP7	/* INTB5 hardware line */
+		bnez	t1, ll_timer_irq	/* Timer */
+
+		nop
+		nop
+
+		/* Extended interrupts */
+           mfc0    t0, CP0_CAUSE
+           cfc0    t1, CP0_S1_INTCONTROL
+
+           sll     t2, t1, 8
+
+           and     t0, t2
+           srl     t0, t0, 16
+
+		andi	t1, t0, STATUSF_IP10	/* Local Bus */
+		bnez	t1, ll_lb_irq
+		andi	t1, t0, STATUSF_IP11	/* PCI0 and PCI1 */
+		bnez	t1, ll_pci_irq
+		nop /* delay slot */		
+		.set	reorder
+
+		j	spurious_interrupt
+		nop
+		END(sequoia_handle_int)
+
+		.align	5
+
+ll_sw0_irq:
+		li	a0, 0 
+		move	a1, sp
+		jal	do_IRQ
+		j	ret_from_irq
+
+ll_sw1_irq:
+		li	a0, 1
+		move	a1, sp
+		jal	do_IRQ
+		j	ret_from_irq
+
+ll_lb_irq:
+		li      a0, 10
+                move    a1, sp
+		jal	do_IRQ
+                j       ret_from_irq
+
+ll_pci_irq:
+		li	a0, 11
+		move	a1, sp
+		jal	pmc_sequoia_pci_isr	
+		j	ret_from_irq
+
+ll_xdma_irq:
+		li	a0, 5
+		move	a1, sp
+		jal	do_IRQ
+		j	ret_from_irq
+
+ll_timer_irq:
+		li	a0, 7
+		move	a1, sp
+		jal	do_IRQ
+		j	ret_from_irq
+
diff -Naur a/arch/mips/pmc-sierra/sequoia/Makefile b/arch/mips/pmc-sierra/sequoia/Makefile
--- a/arch/mips/pmc-sierra/sequoia/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ b/arch/mips/pmc-sierra/sequoia/Makefile	2006-06-22 11:55:42.000000000 -0700
@@ -0,0 +1,7 @@
+#
+# Makefile for the PMC-Sierra Sequoia 
+#
+
+obj-y    += irq-handler.o irq.o prom.o py-console.o setup.o
+
+
diff -Naur a/arch/mips/pmc-sierra/sequoia/prom.c b/arch/mips/pmc-sierra/sequoia/prom.c
--- a/arch/mips/pmc-sierra/sequoia/prom.c	1969-12-31 16:00:00.000000000 -0800
+++ b/arch/mips/pmc-sierra/sequoia/prom.c	2006-06-22 14:57:08.000000000 -0700
@@ -0,0 +1,140 @@
+/*
+ * Copyright (C) 2006 PMC-Sierra Inc.
+ * Author: PMC Sierra Inc (thotakir@pmc-sierra.com)
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include <asm/processor.h>
+#include <asm/reboot.h>
+#include <asm/system.h>
+#include <linux/delay.h>
+#include <linux/smp.h>
+#include <asm/bootinfo.h>
+
+#include <asm/pmc_sequoia.h>
+
+/* Call Vectors */
+struct callvectors {
+        int     (*open) (char*, int, int);
+        int     (*close) (int);
+        int     (*read) (int, void*, int);
+        int     (*write) (int, void*, int);
+        off_t   (*lseek) (int, off_t, int);
+        int     (*printf) (const char*, ...);
+        void    (*cacheflush) (void);
+        char*   (*gets) (char*);
+	   int     (*cpustart) (int, int, int, int);
+};
+
+struct callvectors* debug_vectors;
+
+extern unsigned long sequoia_memsize;
+extern unsigned long cpu_clock;
+
+unsigned char titan_ge_mac_addr_base[6] = {
+	0x30, 0x30, 0x3a, 0x31, 0x31, 0x31
+};
+
+const char *get_system_type(void)
+{
+        return "PMC-Sierra Sequoia";
+}
+
+static void prom_cpu0_exit(void)
+{
+        printk(KERN_NOTICE "SW reset not implemented yet\n");
+}
+
+/*
+ * Reset the NVRAM over the local bus
+ */
+static void prom_exit(void)
+{
+	prom_cpu0_exit();
+}
+
+/*
+ * Get the MAC address from the EEPROM using the I2C protocol
+ */
+void get_mac_address(char dest[6])
+{
+	/* Use the I2C command code in the i2c-sequoia */
+}
+
+/*
+ * Halt the system 
+ */
+void prom_halt(void)
+{
+	printk(KERN_NOTICE "\n** You can safely turn off the power\n");
+	while (1)
+                __asm__(".set\tmips3\n\t"
+                        "wait\n\t"
+                        ".set\tmips0");
+}
+
+/*
+ * Init routine which accepts the variables from PMON
+ */
+void __init prom_init(void)
+{
+	int	i = 0;
+	int argc = fw_arg0;
+     char **arg = (char **) fw_arg1;
+     char **env = (char **) fw_arg2;
+     struct callvectors *cv = (struct callvectors *) fw_arg3;
+
+	/* Callbacks for halt, restart */
+	_machine_restart = (void (*)(char *))prom_exit;	
+	_machine_halt = prom_halt;
+	_machine_power_off = prom_halt;
+
+	debug_vectors = cv;
+	arcs_cmdline[0] = '\0';
+
+	/* Get the boot parameters */
+	for (i = 1; i < argc; i++) {
+                if (strlen(arcs_cmdline) + strlen(arg[i] + 1) >= sizeof(arcs_cmdline))
+                        break;
+
+		strcat(arcs_cmdline, arg[i]);
+		strcat(arcs_cmdline, " ");
+	}
+
+	while (*env) {
+		if (strncmp("memsize", *env, strlen("memsize")) == 0) {
+			sequoia_memsize = simple_strtol(*env + strlen("memsize="),
+							NULL, 10);
+
+			printk("PMON reports memory size %dMB\n", sequoia_memsize);
+		}
+		if (strncmp("cpuclock", *env, strlen("cpuclock")) == 0) { 
+			cpu_clock = simple_strtol(*env + strlen("cpuclock="),
+							NULL, 10);
+		
+			printk("cpu_clock set to %d\n", cpu_clock);
+		}
+		
+		env++;
+	}
+
+
+	mips_machgroup = MACH_GROUP_TITAN;
+	mips_machtype = MACH_TITAN_SEQUOIA;
+
+	get_mac_address(titan_ge_mac_addr_base);
+
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
+
+void __init prom_fixup_mem_map(unsigned long start, unsigned long end)
+{
+}
diff -Naur a/arch/mips/pmc-sierra/sequoia/py-console.c b/arch/mips/pmc-sierra/sequoia/py-console.c
--- a/arch/mips/pmc-sierra/sequoia/py-console.c	1969-12-31 16:00:00.000000000 -0800
+++ b/arch/mips/pmc-sierra/sequoia/py-console.c	2006-06-22 11:48:21.000000000 -0700
@@ -0,0 +1,123 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2001, 2002, 2004 Ralf Baechle
+ */
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/kdev_t.h>
+#include <linux/major.h>
+#include <linux/termios.h>
+#include <linux/sched.h>
+#include <linux/tty.h>
+
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <asm/serial.h>
+#include <asm/io.h>
+
+/* SUPERIO uart register map */
+struct se_uartregs {
+	union {
+		volatile u8	rbr;	/* read only, DLAB == 0 */
+		volatile u8	thr;	/* write only, DLAB == 0 */
+		volatile u8	dll;	/* DLAB == 1 */
+	} u1;
+	union {
+		volatile u8	ier;	/* DLAB == 0 */
+		volatile u8	dlm;	/* DLAB == 1 */
+	} u2;
+	union {
+		volatile u8	iir;	/* read only */
+		volatile u8	fcr;	/* write only */
+	} u3;
+	volatile u8	iu_lcr;
+	volatile u8	iu_mcr;
+	volatile u8	iu_lsr;
+	volatile u8	iu_msr;
+	volatile u8	iu_scr;
+} se_uregs_t;
+
+#define iu_rbr u1.rbr
+#define iu_thr u1.thr
+#define iu_dll u1.dll
+#define iu_ier u2.ier
+#define iu_dlm u2.dlm
+#define iu_iir u3.iir
+#define iu_fcr u3.fcr
+
+#define IO_BASE_64	0x9000000000000000ULL
+
+static unsigned char readb_outer_space(unsigned long phys)
+{
+	unsigned long long vaddr = IO_BASE_64 | phys;
+	unsigned char res;
+	unsigned int sr;
+
+	sr = read_c0_status();
+	write_c0_status((sr | ST0_KX) & ~ ST0_IE);
+	__asm__("sll	$0, $0, 2\n");
+	__asm__("sll	$0, $0, 2\n");
+	__asm__("sll	$0, $0, 2\n");
+	__asm__("sll	$0, $0, 2\n");
+
+	__asm__ __volatile__ (
+	"	.set	mips3		\n"
+	"	ld	%0, (%0)	\n"
+	"	lbu	%0, (%0)	\n"
+	"	.set	mips0		\n"
+	: "=r" (res)
+	: "0" (&vaddr));
+
+	write_c0_status(sr);
+	__asm__("sll	$0, $0, 2\n");
+	__asm__("sll	$0, $0, 2\n");
+	__asm__("sll	$0, $0, 2\n");
+	__asm__("sll	$0, $0, 2\n");
+
+	return res;
+}
+
+static void writeb_outer_space(unsigned long phys, unsigned char c)
+{
+	unsigned long long vaddr = IO_BASE_64 | phys;
+	unsigned long tmp;
+	unsigned int sr;
+
+	sr = read_c0_status();
+	write_c0_status((sr | ST0_KX) & ~ ST0_IE);
+	__asm__("sll	$0, $0, 2\n");
+	__asm__("sll	$0, $0, 2\n");
+	__asm__("sll	$0, $0, 2\n");
+	__asm__("sll	$0, $0, 2\n");
+
+	__asm__ __volatile__ (
+	"	.set	mips3		\n"
+	"	ld	%0, (%1)	\n"
+	"	sb	%2, (%0)	\n"
+	"	.set	mips0		\n"
+	: "=r" (tmp)
+	: "r" (&vaddr), "r" (c));
+
+	write_c0_status(sr);
+	__asm__("sll	$0, $0, 2\n");
+	__asm__("sll	$0, $0, 2\n");
+	__asm__("sll	$0, $0, 2\n");
+	__asm__("sll	$0, $0, 2\n");
+}
+
+void prom_putchar(char c)
+{
+	unsigned long lsr = 0xfd000008UL + offsetof(struct se_uartregs, iu_lsr);
+	unsigned long thr = 0xfd000008UL + offsetof(struct se_uartregs, iu_thr);
+
+	while ((readb_outer_space(lsr) & 0x20) == 0);
+	writeb_outer_space(thr, c);
+}
+
+char __init prom_getchar(void)
+{
+	return 0;
+}
diff -Naur a/arch/mips/pmc-sierra/sequoia/setup.c b/arch/mips/pmc-sierra/sequoia/setup.c
--- a/arch/mips/pmc-sierra/sequoia/setup.c	1969-12-31 16:00:00.000000000 -0800
+++ b/arch/mips/pmc-sierra/sequoia/setup.c	2006-06-22 14:57:38.000000000 -0700
@@ -0,0 +1,258 @@
+/*
+ *  arch/mip/pmc-sierra/sequoia/setup.c
+ *
+ *  Copyright (C) 2006 PMC-Sierra Inc.
+ *  Author: PMC Sierra Inc (thotakir@pmc-sierra.com)
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/mc146818rtc.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/ioport.h>
+#include <linux/console.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/timex.h>
+#include <linux/vmalloc.h>
+#include <asm/time.h>
+#include <asm/bootinfo.h>
+#include <asm/page.h>
+#include <asm/bootinfo.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/processor.h>
+#include <asm/ptrace.h>
+#include <asm/reboot.h>
+#include <asm/traps.h>
+#include <linux/version.h>
+#include <linux/bootmem.h>
+
+#include <asm/serial.h>
+#include <linux/termios.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+
+#include <linux/mm.h>
+
+#include <asm/pmc_sequoia.h>
+
+#include "setup.h"
+
+unsigned long titan_ge_base;
+unsigned long cpu_clock;
+unsigned long sequoia_memsize;
+
+/* Real Time Clock base */
+#define CONV_BCD_TO_BIN(val)	(((val) & 0xf) + (((val) >> 4) * 10))
+#define CONV_BIN_TO_BCD(val)	(((val) % 10) + (((val) / 10) << 4))
+
+static unsigned long ENTRYLO(unsigned long paddr)
+{
+        return ((paddr & PAGE_MASK) |
+               (_PAGE_PRESENT | __READABLE | __WRITEABLE | _PAGE_GLOBAL |
+                _CACHE_UNCACHED)) >> 6;
+}
+
+
+void __init bus_error_init(void) 
+{ 
+	/* Do nothing */ 
+}
+
+unsigned long m48t37y_get_time(void)
+{
+	unsigned char	*rtc_base = SEQUOIA_RTC_BASE_ADDR;
+	unsigned int	year, month, day, hour, min, sec;
+
+	/* Stop the update to the time */
+	rtc_base[0x7ff8] = 0x40;
+
+	year = CONV_BCD_TO_BIN(rtc_base[0x7fff]);
+	year += CONV_BCD_TO_BIN(rtc_base[0x7ff1]) * 100;
+
+	month = CONV_BCD_TO_BIN(rtc_base[0x7ffe]);
+	day = CONV_BCD_TO_BIN(rtc_base[0x7ffd]);
+	hour = CONV_BCD_TO_BIN(rtc_base[0x7ffb]);
+	min = CONV_BCD_TO_BIN(rtc_base[0x7ffa]);
+	sec = CONV_BCD_TO_BIN(rtc_base[0x7ff9]);
+
+	/* Start the update to the time again */
+	rtc_base[0x7ff8] = 0x00;
+
+	return mktime(year, month, day, hour, min, sec);
+}
+
+int m48t37y_set_time(unsigned long sec)
+{
+	unsigned char	*rtc_base = SEQUOIA_RTC_BASE_ADDR;
+        struct rtc_time tm;
+
+        /* convert to a more useful format -- note months count from 0 */
+        to_tm(sec, &tm);
+        tm.tm_mon += 1;
+
+        /* enable writing */
+        rtc_base[0x7ff8] = 0x80;
+
+        /* year */
+        rtc_base[0x7fff] = CONV_BIN_TO_BCD(tm.tm_year % 100);
+        rtc_base[0x7ff1] = CONV_BIN_TO_BCD(tm.tm_year / 100);
+
+        /* month */
+        rtc_base[0x7ffe] = CONV_BIN_TO_BCD(tm.tm_mon);
+
+        /* day */
+        rtc_base[0x7ffd] = CONV_BIN_TO_BCD(tm.tm_mday);
+
+        /* hour/min/sec */
+        rtc_base[0x7ffb] = CONV_BIN_TO_BCD(tm.tm_hour);
+        rtc_base[0x7ffa] = CONV_BIN_TO_BCD(tm.tm_min);
+        rtc_base[0x7ff9] = CONV_BIN_TO_BCD(tm.tm_sec);
+
+        /* day of week -- not really used, but let's keep it up-to-date */
+        rtc_base[0x7ffc] = CONV_BIN_TO_BCD(tm.tm_wday + 1);
+
+        /* disable writing */
+        rtc_base[0x7ff8] = 0x00;
+
+        return 0;
+}
+
+void sequoia_timer_setup(struct irqaction *irq)
+{
+	setup_irq(7, irq);
+}
+
+void sequoia_time_init(void)
+{
+	mips_hpt_frequency = cpu_clock / 2;
+	board_timer_setup = sequoia_timer_setup;
+}
+
+/* workaround for PCI, need to return MIPS_BE_DISCARD */
+int sequoia_be_handler(struct pt_regs *regs, int is_fixup)
+{
+	int data = regs->cp0_cause & 4;
+
+	/* check for data bus error */
+	if ((regs->cp0_cause & 0x7c) == 0x1c) {
+		unsigned long badvaddr;
+		unsigned long instruction;
+		int reg;
+
+		instruction = *(u32 *)regs->cp0_epc;
+		reg = (instruction >> 21)& 0x1f;
+		badvaddr = regs->regs[reg] + (instruction & 0xffff);		
+		if (((badvaddr & ~0x3) == SEQUOIA_PCI_0_CONFIG_DATA)
+			|| ((badvaddr & ~0x3) == SEQUOIA_PCI_1_CONFIG_DATA)) {
+
+			/* skip the PCI load instruction */
+			regs->cp0_epc += 4;
+
+			/*
+			 * Return all 1's for disallowed accesses
+ 			 * for a kludgy but adequate simulation of 
+			 * master aborts.
+			 */
+			reg = (instruction >> 16)& 0x1f;
+			regs->regs[reg] = 0xffffffff;	
+       			return MIPS_BE_DISCARD;
+		}
+	}
+	return MIPS_BE_FATAL;
+}
+
+extern void sequoia_serial_init(void);
+
+/* No other usable initialization hook than this ...  */
+extern void (*late_time_init)(void);
+
+unsigned long rm9150_pci0_base, rm9150_pci1_base, rm9150_dma_base, sequoia_fpga_base;
+
+/*
+ * Common setup before any secondaries are started
+ */
+#define SEQUOIA_UART_CLK	  125000000
+
+static void __init py_map_ocd(void)
+{
+     struct uart_port up;
+
+	unsigned long val = 0;
+
+     add_wired_entry(ENTRYLO(0xff000000), ENTRYLO(0xff000000), 0xff000000, PM_4M);	
+     add_wired_entry(ENTRYLO(0xf8000000), ENTRYLO(0xf8000000), 0xf8000000, PM_4M);	
+	add_wired_entry(ENTRYLO(0xf9000000), ENTRYLO(0xf9000000), 0xf9000000, PM_4M);
+	titan_ge_base = (unsigned long) ioremap(TITAN_GE_BASE, TITAN_GE_SIZE);
+
+	rm9150_pci0_base = (unsigned long) ioremap(RM9150_PCI0_DCR, RM9150_PCI0_SIZE);
+	rm9150_pci1_base = (unsigned long) ioremap(RM9150_PCI1_DCR, RM9150_PCI1_SIZE );
+
+	rm9150_dma_base = (unsigned long) ioremap(RM9150_DMA_DCR, RM9150_DMA_SIZE );
+
+	sequoia_fpga_base = (unsigned long) ioremap(FPGA_BASE, FPGA_SIZE);
+
+	printk(KERN_INFO "%08x = %08x\n", titan_ge_base, (unsigned long)*(unsigned long*)titan_ge_base);
+	printk(KERN_INFO "%08x\n", rm9150_pci0_base);
+	printk(KERN_INFO "%08x\n", rm9150_pci1_base);
+	printk(KERN_INFO "%08x\n", rm9150_dma_base);
+	printk(KERN_INFO "%08x\n", sequoia_fpga_base);
+	dump_tlb_all();
+
+     /* enable the internal UART */
+     printk(KERN_INFO "Internal UART Support for PMC-Sierra Sequoia\n ");
+
+	/* initialize the UART */
+	/* Take UART out of reset */
+	SEQUOIA_GELA_WRITE(RM9150_UACFG, 3);         
+
+	/* UART interrupt disable */
+	val = SEQUOIA_GELA_READ(RM9150_CPGIG0ER);      
+     val &= 0;
+     SEQUOIA_GELA_WRITE(RM9150_CPGIG0ER, val);        
+
+	/*
+	 * Register to interrupt zero because we share the interrupt with
+	 * the serial driver which we don't properly support yet.
+	 */
+	memset(&up, 0, sizeof(up));
+
+	up.membase      = (unsigned long *) titan_ge_base;
+	up.irq          = SEQUOIA_SERIAL_IRQ;
+	up.uartclk      = SEQUOIA_UART_CLK;
+	up.regshift     = 0;
+	up.iotype       = UPIO_MEM;
+	up.flags        = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
+	up.line         = 0;
+
+	if (early_serial_setup(&up))
+		printk(KERN_ERR "Early serial init of port 0 failed\n");
+}
+
+void __init plat_setup(void)
+{	
+
+	unsigned long   val = 0;
+
+     printk("PMC-Sierra Sequoia Board Setup  \n");
+
+
+#ifdef CONFIG_MIPS64
+     printk("64-bit support \n");
+#else
+     printk("32-bit support \n");
+#endif
+
+	board_time_init = sequoia_time_init;
+	late_time_init = py_map_ocd;
+	board_be_handler = sequoia_be_handler;			
+	
+	add_memory_region(0x00000000, 0x08000000, BOOT_MEM_RAM);
+}
+
diff -Naur a/arch/mips/pmc-sierra/sequoia/setup.h b/arch/mips/pmc-sierra/sequoia/setup.h
--- a/arch/mips/pmc-sierra/sequoia/setup.h	1969-12-31 16:00:00.000000000 -0800
+++ b/arch/mips/pmc-sierra/sequoia/setup.h	2006-06-22 11:48:21.000000000 -0700
@@ -0,0 +1,17 @@
+/*
+ * Copyright 2006 PMC-Sierra
+ * Author: PMC Sierra Inc (thotakir@pmc-sierra.com)
+ *
+ * Board specific definititions for the PMC-Sierra Sequoia
+ *
+ */
+
+#ifndef __SETUP_H__
+#define __SETUP_H__
+
+/* Real Time Clock base */
+#define CONV_BCD_TO_BIN(val)    (((val) & 0xf) + (((val) >> 4) * 10))
+#define CONV_BIN_TO_BCD(val)    (((val) % 10) + (((val) / 10) << 4))
+
+#endif /* __SETUP_H__ */
+
diff -Naur a/include/asm-mips/bootinfo.h b/include/asm-mips/bootinfo.h
--- a/include/asm-mips/bootinfo.h	2005-07-11 11:28:10.000000000 -0700
+++ b/include/asm-mips/bootinfo.h	2006-06-22 11:48:21.000000000 -0700
@@ -215,6 +215,8 @@
  */
 #define MACH_GROUP_TITAN       22	/* PMC-Sierra Titan		*/
 #define  MACH_TITAN_YOSEMITE	1	/* PMC-Sierra Yosemite		*/
+#define MACH_TITAN_SEQUOIA      2       /* PMC-Sierra Sequoia */
+
 
 #define CL_SIZE			COMMAND_LINE_SIZE
 
diff -Naur a/include/asm-mips/mach-sequoia/cpu-feature-overrides.h b/include/asm-mips/mach-sequoia/cpu-feature-overrides.h
--- a/include/asm-mips/mach-sequoia/cpu-feature-overrides.h	1969-12-31 16:00:00.000000000 -0800
+++ b/include/asm-mips/mach-sequoia/cpu-feature-overrides.h	2006-06-22 11:48:21.000000000 -0700
@@ -0,0 +1,45 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003, 2004 Ralf Baechle
+ */
+#ifndef __ASM_MACH_SEQUOIA_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_SEQUOIA_CPU_FEATURE_OVERRIDES_H
+
+/*
+ * Momentum Jaguar ATX always has the RM9000 processor.
+ */
+#define cpu_has_watch		1
+#define cpu_has_mips16		0
+#define cpu_has_divec		0
+#define cpu_has_vce		0
+#define cpu_has_cache_cdex_p	0
+#define cpu_has_cache_cdex_s	0
+#define cpu_has_prefetch	1
+#define cpu_has_mcheck		0
+#define cpu_has_ejtag		0
+
+#define cpu_has_llsc		1
+#define cpu_has_vtag_icache	0
+#define cpu_has_dc_aliases	0
+#define cpu_has_ic_fills_f_dc	0
+#define cpu_icache_snoops_remote_store	0
+
+#define cpu_has_nofpuex		0
+#define cpu_has_64bits		1
+
+#define cpu_has_subset_pcaches	0
+
+#define cpu_dcache_line_size()	32
+#define cpu_icache_line_size()	32
+#define cpu_scache_line_size()	32
+
+/*
+ * On the RM9000 we need to ensure that I-cache lines being fetches only
+ * contain valid instructions are funny things will happen.
+ */
+#define PLAT_TRAMPOLINE_STUFF_LINE	32UL
+
+#endif /* __ASM_MACH_SEQUOIA_CPU_FEATURE_OVERRIDES_H */
diff -Naur a/include/asm-mips/pmc_sequoia.h b/include/asm-mips/pmc_sequoia.h
--- a/include/asm-mips/pmc_sequoia.h	1969-12-31 16:00:00.000000000 -0800
+++ b/include/asm-mips/pmc_sequoia.h	2006-06-22 14:58:46.000000000 -0700
@@ -0,0 +1,296 @@
+/*
+ * Copyright 2006 PMC-Sierra
+ * Author: PMC Sierra Inc (thotakir@pmc-sierra.com)
+ *
+ * Board specific definititions for the PMC-Sierra Sequoia (MSP85x0)
+ *
+ */
+
+#ifndef __PMC_SEQUOIA_H__
+#define __PMC_SEQUOIA_H__
+
+#include <linux/config.h>
+#include <asm/addrspace.h>              /* for KSEG1ADDR() */
+#include <asm/byteorder.h>              /* for cpu_to_le32() */
+#include <asm/io.h>			/* for ioswab	*/
+
+/* The base address of the system */
+extern unsigned long sequoia_base;
+
+extern unsigned long rm9150_pci0_base;
+extern unsigned long rm9150_pci1_base;
+extern unsigned long rm9150_dma_base;
+extern unsigned long titan_ge_base;
+extern unsigned long sequoia_fpga_base;
+
+/* FDB ports base addresses , from PMON */
+#define BOOT_BASE		0xfc000000
+#define FLASH_BASE		0xfc000000
+#define RTC_BASE			0xfc200000
+#define FPGA_BASE		(RTC_BASE + 0x10000)
+#define FPGA_SIZE            0x10000
+#define RM9150_PCI0_DCR	0xff000000
+#define RM9150_PCI1_DCR	0xff010000
+#define RM9150_DDR_DCR		0xff020000
+#define RM9150_FDB_DCR		0xff030000
+#define RM9150_DMA_DCR		0xff040000
+#define RM9150_OCM_DCR		0xff050000
+#define RM9150_LOCALBUS_DCR	0xff070000
+#define RM9150_GE_DCR		0xff080000
+
+#define RM9150_PCI0_SIZE       	0x10000
+#define RM9150_PCI1_SIZE       	0x10000
+#define RM9150_DMA_SIZE         0x10000
+#define RM9150_LOCALBUS_SIZE         0x10000
+
+/* FPGA interrupt status and mask registers */
+#define SEQUOIA_FPGA_INTR_STATUS        (0x6)
+#define SEQUOIA_FPGA_INTR_MASK          (0x8)
+
+#define SEQUOIA_FPGA_READ(reg)           (*(volatile u8 *)(sequoia_fpga_base + (reg)))
+#define SEQUOIA_FPGA_WRITE(reg, val)                                     \
+        do { *(volatile u8 *)(sequoia_fpga_base + (reg)) = (val); } while (0)
+
+/* RTC and NVRAM Base */
+#define SEQUOIA_RTC_BASE_ADDR		RTC_BASE
+#define SEQUOIA_NVRAM_BASE_ADDR		RTC_BASE
+
+/*
+ *  RM9150 on-chip RAM
+ */
+#define RM9150_SRAM_BASE              0xfb000000
+#define RM9150_SRAM_SIZE              0x00008000      /* 32 KB */
+
+/* low-speed I/O registers base */
+#define	SEQUOIA_GELA_BASE	RM9150_GE_DCR
+
+
+
+#define TITAN_GE_BASE   (RM9150_GE_DCR)
+#define TITAN_GE_SIZE   0x10000UL
+
+#define TITAN_GE_WRITE(offset, data) \
+                *(volatile u32 *)(titan_ge_base + (offset)) = (data)
+
+#define TITAN_GE_READ(offset) *(volatile u32 *)(titan_ge_base + (offset))
+
+/* UART definitions, offset from GELA */
+#define RM9150_UACFG		(0x500)
+#define RM9150_UAINTS		(0x504)
+
+/* CPGIG0SR: UART interrupt status register, p. 334 */
+#define RM9150_CPGIG0SR		(0x0024)
+#define RM9150_CPGIG0SR_UINT	0x18000000
+
+/* CPGIG0SR: UART interrupt enable register, p. 346 */
+#define RM9150_CPGIG0ER		(0x0034)
+#define RM9150_CPGIG0ER_UINTE	0x18000000
+
+/* UART Interrupt Vector Message register, p. 355 */
+#define RM9150_UART_INTVEC	(0x0054)
+#define RM9150_UART0_INTVEC	0x40	
+#define RM9150_UART1_INTVEC	0x41
+
+/* Interrupt Set Message Resend register, p. 364 */
+#define RM9150_CPINTSMR1R	(0x0078)
+#define RM9150_CPINTSMR1R_UART0		0x0400
+#define RM9150_CPINTSMR1R_UART1		0x0800
+
+/* CPIF2 Interrupt Set Message Resend Mode register, p. 368 */
+#define RM9150_CPINTSMR		(0x007c)
+#define RM9150_CPINTSMR_SWEOIACK_MODE		0x01
+#define RM9150_CPINTSMR_TX_ACK_MOD		0x08
+#define RM9150_CPINTSMR_RX_ACK_MOD		0x10
+
+/* GPIO registers for CF/PCMCIA */
+#define RM9150_CPGPISR1 0xA4
+#define RM9150_CPGPIMR1	0xA8
+
+#define SEQUOIA_GELA_READ(reg)           (*(volatile unsigned int *)(titan_ge_base + (reg)))
+#define SEQUOIA_GELA_WRITE(reg, val)                                     \
+        do { *(volatile unsigned int *)(titan_ge_base + (reg)) = (val); } while (0)
+
+#define RM9150_GDMA_BASE	RM9150_DMA_DCR	
+#define RM9150_GCIC_BASE	(RM9150_GDMA_BASE + 0x8000)
+
+#define RM9150_GCIC_INTMSG		(0x10)
+#define RM9150_GCIC_INT0_STATUS		(0x30)
+#define RM9150_GCIC_INT0_MASK		(0x34)
+#define RM9150_GCIC_INT0_SET		(0x38)
+#define RM9150_GCIC_INT0_CLEAR		(0x3c)
+#define RM9150_GCIC_INT1_STATUS		(0x40)
+#define RM9150_GCIC_INT1_MASK		(0x44)
+#define RM9150_GCIC_INT1_SET		(0x48)
+#define RM9150_GCIC_INT1_CLEAR		(0x4c)
+#define RM9150_GCIC_INT2_STATUS		(0x50)
+#define RM9150_GCIC_INT2_MASK		(0x54)
+#define RM9150_GCIC_INT2_SET		(0x58)
+#define RM9150_GCIC_INT2_CLEAR		(0x5c)
+#define RM9150_GCIC_INT3_STATUS		(0x60)
+#define RM9150_GCIC_INT3_MASK		(0x64)
+#define RM9150_GCIC_INT3_SET		(0x68)
+#define RM9150_GCIC_INT3_CLEAR		(0x6c)
+#define RM9150_GCIC_INT4_STATUS		(0x70)
+#define RM9150_GCIC_INT4_MASK		(0x74)
+#define RM9150_GCIC_INT4_SET		(0x78)
+#define RM9150_GCIC_INT4_CLEAR		(0x7c)
+#define RM9150_GCIC_INT5_STATUS		(0x80)
+#define RM9150_GCIC_INT5_MASK		(0x84)
+#define RM9150_GCIC_INT5_SET		(0x88)
+#define RM9150_GCIC_INT5_CLEAR		(0x8c)
+#define RM9150_GCIC_INT6_STATUS		(0x90)
+#define RM9150_GCIC_INT6_MASK		(0x94)
+#define RM9150_GCIC_INT6_SET		(0x98)
+#define RM9150_GCIC_INT6_CLEAR		(0x9c)
+#define RM9150_GCIC_INT7_STATUS		(0xa0)
+#define RM9150_GCIC_INT7_MASK		(0xa4)
+#define RM9150_GCIC_INT7_SET		(0xa8)
+#define RM9150_GCIC_INT7_CLEAR		(0xac)
+
+#define SEQUOIA_CICA_READ(reg)           (*(volatile unsigned int *)(rm9150_dma_base + 0x8000 + (reg)))
+#define SEQUOIA_CICA_WRITE(reg, val)                                     \
+        do { *(volatile unsigned int *)(rm9150_dma_base + 0x8000 + (reg)) = (val); } while (0)
+
+
+/* PCI */
+
+/* 
+ *  PCI configuration registers 
+ *  pmon2000/src/Targets/Sequoia/compile/SEQUOIA-EB/machine/rm9150_pci.h
+ */
+#define RM9150_PCI_GDI_IDENT				0x0000
+#define RM9150_PCI_IAM_CONFIG_STATUS			0x0004
+#define RM9150_PCI_CONFIG_ADDR				0x0010
+#define RM9150_PCI_CONFIG_DATA				0x0014
+#define RM9150_PCI_CONFIG_STATUS			0x0018
+#define RM9150_PCI_GDI_BAR0				0x001c
+#define RM9150_PCI_GDI_BAR0_ATTRIBUTES			0x0020
+#define RM9150_PCI_GDI_BAR1				0x0024
+#define RM9150_PCI_GDI_BAR1_ATTRIBUTES			0x0028
+#define RM9150_PCI_GDI_BAR2				0x002c
+#define RM9150_PCI_GDI_BAR2_ATTRIBUTES			0x0030
+#define RM9150_PCI_GDI_BAR3				0x0034
+#define RM9150_PCI_GDI_BAR3_ATTRIBUTES			0x0038
+#define RM9150_PCI_GDI_BAR4				0x003c
+#define RM9150_PCI_GDI_BAR4_ATTRIBUTES			0x0040
+#define RM9150_PCI_GDI_BAR5				0x0044
+#define RM9150_PCI_GDI_BAR5_ATTRIBUTES			0x0048
+#define RM9150_PCI_MASTER_GDI_VIRT_IOBASE		0x004c
+#define RM9150_PCI_MASTER_GDI_VIRT_IOMASK		0x0050
+#define RM9150_PCI_MASTER_GDI_VIRT_PREFETCH_BASE	0x0054
+#define RM9150_PCI_MASTER_GDI_VIRT_PREFETCH_SIZE	0x0058
+#define RM9150_PCI_MASTER_WRITE_REQ_DATA_SWAP		0x0080
+#define RM9150_PCI_MASTER_READ_RESP_DATA_SWAP		0x0084
+#define RM9150_PCI_RESET				0x008c
+#define RM9150_PCI_RESPONSE_ERROR_MASK			0x0090
+#define RM9150_PCI_TRANSACTION_COMBINING		0x0094
+#define RM9150_PCI_ECC_STATUS				0x00a8
+#define RM9150_PCI_ECC_ERROR_INJECTION			0x00ac
+#define RM9150_PCI_DEVICE_VENDOR_ID			0x0100
+#define RM9150_PCI_COMMAND_STATUS			0x0104
+#define RM9150_PCI_CLASS_CODE_REV_ID			0x0108
+#define RM9150_PCI_BIST_HEADER_TYPE			0x010c
+#define RM9150_PCI_TARGET_BAR0				0x0110
+#define RM9150_PCI_TARGET_BAR1				0x0114
+#define RM9150_PCI_TARGET_BAR2				0x0118
+#define RM9150_PCI_TARGET_BAR3				0x011c
+#define RM9150_PCI_TARGET_BAR4				0x0120
+#define RM9150_PCI_TARGET_BAR5				0x0124
+#define RM9150_PCI_SUBSYSTEM_DEVICE_VENDOR_ID		0x012c
+#define RM9150_PCI_EXPANSION_ROM_BASE_ADDR		0x0130
+#define RM9150_PCI_CAPABILITIES_POINTER			0x0134
+#define RM9150_PCI_INTERRUPT_LINE			0x013c
+#define RM9150_PCI_CONFIG_STATUS_1			0x0140
+#define RM9150_PCI_TARGET_DELAYED_TRANSACTIONS		0x0148
+#define RM9150_PCI_CONFIG_STATUS_2			0x014c
+#define RM9150_PCI_MASTER_DEFERRED_TRANSACTIONS		0x0148
+#define RM9150_PCI_CONFIG_STATUS_3			0x0158
+#define RM9150_PCI_CONFIGURATION_HOLD_0			0x0200
+#define RM9150_PCI_CONFIGURATION_HOLD_1			0x0204
+#define RM9150_PCI_CONFIGURATION_HOLD_2			0x0208
+#define RM9150_PCI_CONFIGURATION_HOLD_3			0x020c
+#define RM9150_PCI_CONFIGURATION_HOLD_4			0x0210
+#define RM9150_PCI_CONFIGURATION_HOLD_5			0x0214
+#define RM9150_PCI_CONFIGURATION_HOLD_6			0x0218
+#define RM9150_PCI_CONFIGURATION_HOLD_7			0x021c
+#define RM9150_PCI_CONFIGURATION_HOLD_8			0x0220
+#define RM9150_PCI_CONFIGURATION_HOLD_9			0x0224
+#define RM9150_PCI_CONFIGURATION_HOLD_10		0x0228
+#define RM9150_PCI_CONFIGURATION_HOLD_11		0x022c
+#define RM9150_PCI_CONFIGURATION_HOLD_12		0x0230
+#define RM9150_PCI_CONFIGURATION_HOLD_13		0x0234
+#define RM9150_PCI_INTERRUPT_MSG_HANDSHAKE		0x0238
+#define RM9150_PCI_ERROR_STATUS_FAULT_INTERRUPT		0x0254
+#define RM9150_PCI_SERR_CAUSE_ENABLE			0x0258
+#define RM9150_PCI_FAULT_INTERRUPT_ENABLE		0x025c
+#define RM9150_PCI_ERROR_ADDRESS_EVENT			0x0260
+#define RM9150_PCI_ERROR_ADDRESS			0x0264
+#define RM9150_PCI_GDI_DIAGNOSTIC_ERRORS		0x0268
+
+/*
+ *  PCI Bus 0
+ */
+#define SEQUOIA_PCI0_MEM_BASE             0xe0000000
+#define SEQUOIA_PCI0_MEM_SIZE             0x08000000
+#define SEQUOIA_PCI0_IO_BASE              0xf8000000
+#define SEQUOIA_PCI0_IO_SIZE              0x01000000
+
+/*
+ *  PCI Bus 1
+ */
+#define SEQUOIA_PCI1_MEM_BASE             0xe8000000
+#define SEQUOIA_PCI1_MEM_SIZE             0x08000000
+#define SEQUOIA_PCI1_IO_BASE              0xf9000000
+#define SEQUOIA_PCI1_IO_SIZE              0x01000000
+
+#define SEQUOIA_PCI_MEM_BASE            0xe0000000
+#define SEQUOIA_PCI_MEM_SIZE            0x18000000
+#define SEQUOIA_PCI_IO_BASE             0xf8000000
+#define SEQUOIA_PCI_IO_SIZE             0x02000000
+
+/*
+ * PCI 0 specific defines
+ */
+#define	SEQUOIA_PCI0_BASE		RM9150_PCI0_DCR
+#define	SEQUOIA_PCI_0_CONFIG_ADDRESS	(RM9150_PCI0_DCR + RM9150_PCI_CONFIG_ADDR)
+#define	SEQUOIA_PCI_0_CONFIG_DATA	(rm9150_pci0_base + RM9150_PCI_CONFIG_DATA)
+
+/*
+ * PCI 1 specific defines
+ */
+#define	SEQUOIA_PCI1_BASE		RM9150_PCI1_DCR
+#define	SEQUOIA_PCI_1_CONFIG_ADDRESS	(RM9150_PCI1_DCR + RM9150_PCI_CONFIG_ADDR)
+#define	SEQUOIA_PCI_1_CONFIG_DATA	(rm9150_pci1_base + RM9150_PCI_CONFIG_DATA)
+
+#define SEQUOIA_PCI0_WRITE(ofs, data)  \
+        do { *(volatile u32 *)( rm9150_pci0_base + (ofs)) = (data); } while(0)
+#define SEQUOIA_PCI0_READ(ofs)   \
+        *(volatile u32 *)(rm9150_pci0_base +(ofs))
+
+#define SEQUOIA_PCI0_WRITE_16(ofs, data)  \
+        do { *(volatile u16 *)(rm9150_pci0_base + (ofs)) = (data); } while(0)
+#define SEQUOIA_PCI0_READ_16(ofs)   \
+        *(volatile u16 *)(rm9150_pci0_base +(ofs))
+
+#define SEQUOIA_PCI0_WRITE_8(ofs, data)  \
+        do { *(volatile u8 *)(rm9150_pci0_base + (ofs)) = (data); } while(0)
+#define SEQUOIA_PCI0_READ_8(ofs)   \
+        *(volatile u8 *)(rm9150_pci0_base +(ofs))
+
+
+#define SEQUOIA_PCI1_WRITE(ofs, data)  \
+        do { *(volatile u32 *)(rm9150_pci1_base + (ofs)) = (data); } while(0)
+#define SEQUOIA_PCI1_READ(ofs)   \
+        *(volatile u32 *)(rm9150_pci1_base +(ofs))
+
+#define SEQUOIA_PCI1_WRITE_16(ofs, data)  \
+        do { *(volatile u16 *)(rm9150_pci1_base + (ofs)) = (data); } while(0)
+#define SEQUOIA_PCI1_READ_16(ofs)   \
+        *(volatile u16 *)(rm9150_pci1_base +(ofs))
+
+#define SEQUOIA_PCI1_WRITE_8(ofs, data)  \
+        do { *(volatile u8 *)(rm9150_pci1_base + (ofs)) = (data); } while(0)
+#define SEQUOIA_PCI1_READ_8(ofs)   \
+        *(volatile u8 *)(rm9150_pci1_base +(ofs))
+
+#endif
