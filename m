Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 07:59:30 +0100 (BST)
Received: from mms3.broadcom.com ([216.31.210.19]:41225 "EHLO
	MMS3.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S3465582AbVJTG44 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 07:56:56 +0100
Received: from 10.10.64.121 by MMS3.broadcom.com with SMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Wed, 19 Oct 2005 23:56:40 -0700
X-Server-Uuid: B238DE4C-2139-4D32-96A8-DD564EF2313E
Received: from mail-irva-8.broadcom.com ([10.10.64.221]) by
 mail-irva-1.broadcom.com (Post.Office MTA v3.5.3 release 223 ID#
 0-72233U7200L2200S0V35) with ESMTP id com for
 <linux-mips@linux-mips.org>; Wed, 19 Oct 2005 23:56:38 -0700
Received: from mon-irva-10.broadcom.com (mon-irva-10.broadcom.com
 [10.10.64.171]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id CAW10850; Wed, 19 Oct 2005 23:56:39 -0700 (PDT)
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-10.broadcom.com (8.9.1/8.9.1) with ESMTP
 id XAA28200 for <linux-mips@linux-mips.org>; Wed, 19 Oct 2005 23:56:38
 -0700 (PDT)
Received: from localhost.localdomain (ldt-sj3-054 [10.21.3.41]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 j9K6ucov008704 for <linux-mips@linux-mips.org>; Wed, 19 Oct 2005
 23:56:38 -0700 (PDT)
Received: (from adi@localhost) by localhost.localdomain (8.11.6/8.9.3)
 id j9K6ucR23967 for linux-mips@linux-mips.org; Wed, 19 Oct 2005
 23:56:38 -0700
Date:	Wed, 19 Oct 2005 23:56:38 -0700
From:	"Andrew Isaacson" <adi@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH 5/12]  1480-support
Message-ID: <20051020065638.GE23899@broadcom.com>
References: <20051020065320.GA23857@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <20051020065320.GA23857@broadcom.com>
User-Agent: Mutt/1.4.2.1i
X-WSS-ID: 6F49E0224NK4416181-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <adi@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@broadcom.com
Precedence: bulk
X-list: linux-mips

Add support for BCM1480 family of chips.
 - Kconfig and Makefile changes
 - arch/mips/sibyte/bcm1480/
 - changes to sibyte common code to support 1480

Signed-Off-By: Andy Isaacson <adi@broadcom.com>

 arch/mips/Kconfig                      |    2 
 arch/mips/Makefile                     |   14 
 arch/mips/sibyte/Kconfig               |   10 
 arch/mips/sibyte/bcm1480/Makefile      |    5 
 arch/mips/sibyte/bcm1480/irq.c         |  476 +++++++++++++++++++++++++++++++++
 arch/mips/sibyte/bcm1480/irq_handler.S |  165 +++++++++++
 arch/mips/sibyte/bcm1480/setup.c       |  136 +++++++++
 arch/mips/sibyte/bcm1480/smp.c         |  110 +++++++
 arch/mips/sibyte/bcm1480/time.c        |  138 +++++++++
 arch/mips/sibyte/cfe/smp.c             |   14 
 arch/mips/sibyte/swarm/setup.c         |   28 +
 drivers/char/sb1250_duart.c            |   90 ++++--
 drivers/net/sb1250-mac.c               |  109 ++++---
 13 files changed, 1230 insertions(+), 67 deletions(-)

Index: lmo/arch/mips/Makefile
===================================================================
--- lmo.orig/arch/mips/Makefile	2005-10-19 22:34:07.000000000 -0700
+++ lmo/arch/mips/Makefile	2005-10-19 22:34:12.000000000 -0700
@@ -647,10 +647,20 @@
 # removed (as happens, even if they have __initcall/module_init)
 #
 core-$(CONFIG_SIBYTE_BCM112X)	+= arch/mips/sibyte/sb1250/
-cflags-$(CONFIG_SIBYTE_BCM112X)	+= -Iinclude/asm-mips/mach-sibyte
+cflags-$(CONFIG_SIBYTE_BCM112X)	+= -Iinclude/asm-mips/mach-sibyte \
+			-DSIBYTE_HDR_FEATURES=SIBYTE_HDR_FMASK_1250_112x_ALL
 
 core-$(CONFIG_SIBYTE_SB1250)	+= arch/mips/sibyte/sb1250/
-cflags-$(CONFIG_SIBYTE_SB1250)	+= -Iinclude/asm-mips/mach-sibyte
+cflags-$(CONFIG_SIBYTE_SB1250)	+= -Iinclude/asm-mips/mach-sibyte \
+			-DSIBYTE_HDR_FEATURES=SIBYTE_HDR_FMASK_1250_112x_ALL
+
+core-$(CONFIG_SIBYTE_BCM1x55)	+= arch/mips/sibyte/bcm1480/
+cflags-$(CONFIG_SIBYTE_BCM1x55)	+= -Iinclude/asm-mips/mach-sibyte \
+			-DSIBYTE_HDR_FEATURES=SIBYTE_HDR_FMASK_1480_ALL
+
+core-$(CONFIG_SIBYTE_BCM1x80)	+= arch/mips/sibyte/bcm1480/
+cflags-$(CONFIG_SIBYTE_BCM1x80)	+= -Iinclude/asm-mips/mach-sibyte \
+			-DSIBYTE_HDR_FEATURES=SIBYTE_HDR_FMASK_1480_ALL
 
 #
 # Sibyte BCM91120x (Carmel) board
Index: lmo/arch/mips/sibyte/bcm1480/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ lmo/arch/mips/sibyte/bcm1480/Makefile	2005-10-19 22:34:12.000000000 -0700
@@ -0,0 +1,5 @@
+obj-y := setup.o irq.o irq_handler.o time.o
+
+obj-$(CONFIG_SMP)			+= smp.o
+
+EXTRA_AFLAGS := $(CFLAGS)
Index: lmo/arch/mips/sibyte/bcm1480/irq.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ lmo/arch/mips/sibyte/bcm1480/irq.c	2005-10-19 22:34:12.000000000 -0700
@@ -0,0 +1,476 @@
+/*
+ * Copyright (C) 2000,2001,2002,2003,2004 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/kernel_stat.h>
+
+#include <asm/errno.h>
+#include <asm/signal.h>
+#include <asm/system.h>
+#include <asm/ptrace.h>
+#include <asm/io.h>
+
+#include <asm/sibyte/bcm1480_regs.h>
+#include <asm/sibyte/bcm1480_int.h>
+#include <asm/sibyte/bcm1480_scd.h>
+
+#include <asm/sibyte/sb1250_uart.h>
+#include <asm/sibyte/sb1250.h>
+
+/*
+ * These are the routines that handle all the low level interrupt stuff.
+ * Actions handled here are: initialization of the interrupt map, requesting of
+ * interrupt lines by handlers, dispatching if interrupts to handlers, probing
+ * for interrupt lines
+ */
+
+
+#define shutdown_bcm1480_irq	disable_bcm1480_irq
+static void end_bcm1480_irq(unsigned int irq);
+static void enable_bcm1480_irq(unsigned int irq);
+static void disable_bcm1480_irq(unsigned int irq);
+static unsigned int startup_bcm1480_irq(unsigned int irq);
+static void ack_bcm1480_irq(unsigned int irq);
+#ifdef CONFIG_SMP
+static void bcm1480_set_affinity(unsigned int irq, cpumask_t mask);
+#endif
+
+#ifdef CONFIG_PCI
+extern unsigned long ht_eoi_space;
+#endif
+
+#ifdef CONFIG_KGDB
+#include <asm/gdb-stub.h>
+extern void breakpoint(void);
+static int kgdb_irq;
+#ifdef CONFIG_GDB_CONSOLE
+extern void register_gdb_console(void);
+#endif
+
+/* kgdb is on when configured.  Pass "nokgdb" kernel arg to turn it off */
+static int kgdb_flag = 1;
+static int __init nokgdb(char *str)
+{
+	kgdb_flag = 0;
+	return 1;
+}
+__setup("nokgdb", nokgdb);
+
+/* Default to UART1 */
+int kgdb_port = 1;
+#ifdef CONFIG_SIBYTE_SB1250_DUART
+extern char sb1250_duart_present[];
+#endif
+#endif
+
+static struct hw_interrupt_type bcm1480_irq_type = {
+	.typename = "BCM1480-IMR",
+	.startup = startup_bcm1480_irq,
+	.shutdown = shutdown_bcm1480_irq,
+	.enable = enable_bcm1480_irq,
+	.disable = disable_bcm1480_irq,
+	.ack = ack_bcm1480_irq,
+	.end = end_bcm1480_irq,
+#ifdef CONFIG_SMP
+	.set_affinity = bcm1480_set_affinity
+#endif
+};
+
+/* Store the CPU id (not the logical number) */
+int bcm1480_irq_owner[BCM1480_NR_IRQS];
+
+DEFINE_SPINLOCK(bcm1480_imr_lock);
+
+void bcm1480_mask_irq(int cpu, int irq)
+{
+	unsigned long flags;
+	u64 cur_ints,hl_spacing;
+
+	spin_lock_irqsave(&bcm1480_imr_lock, flags);
+	hl_spacing = 0;
+	if ((irq >= BCM1480_NR_IRQS_HALF) && (irq <= BCM1480_NR_IRQS)) {
+		hl_spacing = BCM1480_IMR_HL_SPACING;
+		irq -= BCM1480_NR_IRQS_HALF;
+	}
+	cur_ints = ____raw_readq(IOADDR(A_BCM1480_IMR_MAPPER(cpu) + R_BCM1480_IMR_INTERRUPT_MASK_H + hl_spacing));
+	cur_ints |= (((u64) 1) << irq);
+	____raw_writeq(cur_ints, IOADDR(A_BCM1480_IMR_MAPPER(cpu) + R_BCM1480_IMR_INTERRUPT_MASK_H + hl_spacing));
+	spin_unlock_irqrestore(&bcm1480_imr_lock, flags);
+}
+
+void bcm1480_unmask_irq(int cpu, int irq)
+{
+	unsigned long flags;
+	u64 cur_ints,hl_spacing;
+
+	spin_lock_irqsave(&bcm1480_imr_lock, flags);
+	hl_spacing = 0;
+	if ((irq >= BCM1480_NR_IRQS_HALF) && (irq <= BCM1480_NR_IRQS)) {
+		hl_spacing = BCM1480_IMR_HL_SPACING;
+		irq -= BCM1480_NR_IRQS_HALF;
+	}
+	cur_ints = ____raw_readq(IOADDR(A_BCM1480_IMR_MAPPER(cpu) + R_BCM1480_IMR_INTERRUPT_MASK_H + hl_spacing));
+	cur_ints &= ~(((u64) 1) << irq);
+	____raw_writeq(cur_ints, IOADDR(A_BCM1480_IMR_MAPPER(cpu) + R_BCM1480_IMR_INTERRUPT_MASK_H + hl_spacing));
+	spin_unlock_irqrestore(&bcm1480_imr_lock, flags);
+}
+
+#ifdef CONFIG_SMP
+static void bcm1480_set_affinity(unsigned int irq, cpumask_t mask)
+{
+	int i = 0, old_cpu, cpu, int_on;
+	u64 cur_ints;
+	irq_desc_t *desc = irq_desc + irq;
+	unsigned long flags;
+	unsigned int irq_dirty;
+
+	i = first_cpu(mask);
+	if (next_cpu(i, mask) <= NR_CPUS) {
+		printk("attempted to set irq affinity for irq %d to multiple CPUs\n", irq);
+		return;
+	}
+
+	/* Convert logical CPU to physical CPU */
+	cpu = cpu_logical_map(i);
+
+	/* Protect against other affinity changers and IMR manipulation */
+	spin_lock_irqsave(&desc->lock, flags);
+	spin_lock(&bcm1480_imr_lock);
+
+	/* Swizzle each CPU's IMR (but leave the IP selection alone) */
+	old_cpu = bcm1480_irq_owner[irq];
+	irq_dirty = irq;
+	if ((irq_dirty >= BCM1480_NR_IRQS_HALF) && (irq_dirty <= BCM1480_NR_IRQS)) {
+		irq_dirty -= BCM1480_NR_IRQS_HALF;
+	}
+
+	int k;
+	for (k=0; k<2; k++) { /* Loop through high and low interrupt mask register */
+		cur_ints = ____raw_readq(IOADDR(A_BCM1480_IMR_MAPPER(old_cpu) + R_BCM1480_IMR_INTERRUPT_MASK_H + (k*BCM1480_IMR_HL_SPACING)));
+		int_on = !(cur_ints & (((u64) 1) << irq_dirty));
+		if (int_on) {
+			/* If it was on, mask it */
+			cur_ints |= (((u64) 1) << irq_dirty);
+			____raw_writeq(cur_ints, IOADDR(A_BCM1480_IMR_MAPPER(old_cpu) + R_BCM1480_IMR_INTERRUPT_MASK_H + (k*BCM1480_IMR_HL_SPACING)));
+		}
+		bcm1480_irq_owner[irq] = cpu;
+		if (int_on) {
+			/* unmask for the new CPU */
+			cur_ints = ____raw_readq(IOADDR(A_BCM1480_IMR_MAPPER(cpu) + R_BCM1480_IMR_INTERRUPT_MASK_H + (k*BCM1480_IMR_HL_SPACING)));
+			cur_ints &= ~(((u64) 1) << irq_dirty);
+			____raw_writeq(cur_ints, IOADDR(A_BCM1480_IMR_MAPPER(cpu) + R_BCM1480_IMR_INTERRUPT_MASK_H + (k*BCM1480_IMR_HL_SPACING)));
+		}
+	}
+	spin_unlock(&bcm1480_imr_lock);
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
+#endif
+
+
+/* Defined in arch/mips/sibyte/bcm1480/irq_handler.S */
+extern void bcm1480_irq_handler(void);
+
+/*****************************************************************************/
+
+static unsigned int startup_bcm1480_irq(unsigned int irq)
+{
+	bcm1480_unmask_irq(bcm1480_irq_owner[irq], irq);
+
+	return 0;		/* never anything pending */
+}
+
+
+static void disable_bcm1480_irq(unsigned int irq)
+{
+	bcm1480_mask_irq(bcm1480_irq_owner[irq], irq);
+}
+
+static void enable_bcm1480_irq(unsigned int irq)
+{
+	bcm1480_unmask_irq(bcm1480_irq_owner[irq], irq);
+}
+
+
+static void ack_bcm1480_irq(unsigned int irq)
+{
+	u64 pending;
+	unsigned int irq_dirty;
+
+	/*
+	 * If the interrupt was an HT interrupt, now is the time to
+	 * clear it.  NOTE: we assume the HT bridge was set up to
+	 * deliver the interrupts to all CPUs (which makes affinity
+	 * changing easier for us)
+	 */
+	irq_dirty = irq;
+	if ((irq_dirty >= BCM1480_NR_IRQS_HALF) && (irq_dirty <= BCM1480_NR_IRQS)) {
+		irq_dirty -= BCM1480_NR_IRQS_HALF;
+	}
+	int k;
+	for (k=0; k<2; k++) { /* Loop through high and low LDT interrupts */
+		pending = __raw_readq(IOADDR(A_BCM1480_IMR_REGISTER(bcm1480_irq_owner[irq],
+						R_BCM1480_IMR_LDT_INTERRUPT_H + (k*BCM1480_IMR_HL_SPACING))));
+		pending &= ((u64)1 << (irq_dirty));
+		if (pending) {
+#ifdef CONFIG_SMP
+			int i;
+			for (i=0; i<NR_CPUS; i++) {
+				/*
+				 * Clear for all CPUs so an affinity switch
+				 * doesn't find an old status
+				 */
+				__raw_writeq(pending, IOADDR(A_BCM1480_IMR_REGISTER(cpu_logical_map(i),
+								R_BCM1480_IMR_LDT_INTERRUPT_CLR_H + (k*BCM1480_IMR_HL_SPACING))));
+			}
+#else
+			__raw_writeq(pending, IOADDR(A_BCM1480_IMR_REGISTER(0, R_BCM1480_IMR_LDT_INTERRUPT_CLR_H + (k*BCM1480_IMR_HL_SPACING))));
+#endif
+
+			/*
+			 * Generate EOI.  For Pass 1 parts, EOI is a nop.  For
+			 * Pass 2, the LDT world may be edge-triggered, but
+			 * this EOI shouldn't hurt.  If they are
+			 * level-sensitive, the EOI is required.
+			 */
+#ifdef CONFIG_PCI
+			if (ht_eoi_space)
+				*(uint32_t *)(ht_eoi_space+(irq<<16)+(7<<2)) = 0;
+#endif
+		}
+	}
+	bcm1480_mask_irq(bcm1480_irq_owner[irq], irq);
+}
+
+
+static void end_bcm1480_irq(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
+		bcm1480_unmask_irq(bcm1480_irq_owner[irq], irq);
+	}
+}
+
+
+void __init init_bcm1480_irqs(void)
+{
+	int i;
+
+	for (i = 0; i < NR_IRQS; i++) {
+		irq_desc[i].status = IRQ_DISABLED;
+		irq_desc[i].action = 0;
+		irq_desc[i].depth = 1;
+		if (i < BCM1480_NR_IRQS) {
+			irq_desc[i].handler = &bcm1480_irq_type;
+			bcm1480_irq_owner[i] = 0;
+		} else {
+			irq_desc[i].handler = &no_irq_type;
+		}
+	}
+}
+
+
+static irqreturn_t bcm1480_dummy_handler(int irq, void *dev_id,
+	struct pt_regs *regs)
+{
+	return IRQ_NONE;
+}
+
+static struct irqaction bcm1480_dummy_action = {
+	.handler = bcm1480_dummy_handler,
+	.flags   = 0,
+	.mask    = CPU_MASK_NONE,
+	.name    = "bcm1480-private",
+	.next    = NULL,
+	.dev_id  = 0
+};
+
+int bcm1480_steal_irq(int irq)
+{
+	irq_desc_t *desc = irq_desc + irq;
+	unsigned long flags;
+	int retval = 0;
+
+	if (irq >= BCM1480_NR_IRQS)
+		return -EINVAL;
+
+	spin_lock_irqsave(&desc->lock,flags);
+	/* Don't allow sharing at all for these */
+	if (desc->action != NULL)
+		retval = -EBUSY;
+	else {
+		desc->action = &bcm1480_dummy_action;
+		desc->depth = 0;
+	}
+	spin_unlock_irqrestore(&desc->lock,flags);
+	return 0;
+}
+
+/*
+ *  init_IRQ is called early in the boot sequence from init/main.c.  It
+ *  is responsible for setting up the interrupt mapper and installing the
+ *  handler that will be responsible for dispatching interrupts to the
+ *  "right" place.
+ */
+/*
+ * For now, map all interrupts to IP[2].  We could save
+ * some cycles by parceling out system interrupts to different
+ * IP lines, but keep it simple for bringup.  We'll also direct
+ * all interrupts to a single CPU; we should probably route
+ * PCI and LDT to one cpu and everything else to the other
+ * to balance the load a bit.
+ *
+ * On the second cpu, everything is set to IP5, which is
+ * ignored, EXCEPT the mailbox interrupt.  That one is
+ * set to IP[2] so it is handled.  This is needed so we
+ * can do cross-cpu function calls, as requred by SMP
+ */
+
+#define IMR_IP2_VAL	K_BCM1480_INT_MAP_I0
+#define IMR_IP3_VAL	K_BCM1480_INT_MAP_I1
+#define IMR_IP4_VAL	K_BCM1480_INT_MAP_I2
+#define IMR_IP5_VAL	K_BCM1480_INT_MAP_I3
+#define IMR_IP6_VAL	K_BCM1480_INT_MAP_I4
+
+void __init arch_init_irq(void)
+{
+
+	unsigned int i, cpu;
+	u64 tmp;
+	unsigned int imask = STATUSF_IP4 | STATUSF_IP3 | STATUSF_IP2 |
+		STATUSF_IP1 | STATUSF_IP0;
+
+	/* Default everything to IP2 */
+	/* Start with _high registers which has no bit 0 interrupt source */
+	for (i = 1; i < BCM1480_NR_IRQS_HALF; i++) {	/* was I0 */
+		for (cpu = 0; cpu < 4; cpu++) {
+			__raw_writeq(IMR_IP2_VAL,
+				     IOADDR(A_BCM1480_IMR_REGISTER(cpu,
+								   R_BCM1480_IMR_INTERRUPT_MAP_BASE_H) + (i << 3)));
+		}
+	}
+
+	/* Now do _low registers */
+	for (i = 0; i < BCM1480_NR_IRQS_HALF; i++) {
+		for (cpu = 0; cpu < 4; cpu++) {
+			__raw_writeq(IMR_IP2_VAL,
+				     IOADDR(A_BCM1480_IMR_REGISTER(cpu,
+								   R_BCM1480_IMR_INTERRUPT_MAP_BASE_L) + (i << 3)));
+		}
+	}
+
+	init_bcm1480_irqs();
+
+	/*
+	 * Map the high 16 bits of mailbox_0 registers to IP[3], for
+	 * inter-cpu messages
+	 */
+	/* Was I1 */
+	for (cpu = 0; cpu < 4; cpu++) {
+		__raw_writeq(IMR_IP3_VAL, IOADDR(A_BCM1480_IMR_REGISTER(cpu, R_BCM1480_IMR_INTERRUPT_MAP_BASE_H) +
+						 (K_BCM1480_INT_MBOX_0_0 << 3)));
+        }
+
+
+	/* Clear the mailboxes.  The firmware may leave them dirty */
+	for (cpu = 0; cpu < 4; cpu++) {
+		__raw_writeq(0xffffffffffffffffULL,
+			     IOADDR(A_BCM1480_IMR_REGISTER(cpu, R_BCM1480_IMR_MAILBOX_0_CLR_CPU)));
+		__raw_writeq(0xffffffffffffffffULL,
+			     IOADDR(A_BCM1480_IMR_REGISTER(cpu, R_BCM1480_IMR_MAILBOX_1_CLR_CPU)));
+	}
+
+
+	/* Mask everything except the high 16 bit of mailbox_0 registers for all cpus */
+	tmp = ~((u64) 0) ^ ( (((u64) 1) << K_BCM1480_INT_MBOX_0_0));
+	for (cpu = 0; cpu < 4; cpu++) {
+		__raw_writeq(tmp, IOADDR(A_BCM1480_IMR_REGISTER(cpu, R_BCM1480_IMR_INTERRUPT_MASK_H)));
+	}
+	tmp = ~((u64) 0);
+	for (cpu = 0; cpu < 4; cpu++) {
+		__raw_writeq(tmp, IOADDR(A_BCM1480_IMR_REGISTER(cpu, R_BCM1480_IMR_INTERRUPT_MASK_L)));
+	}
+
+	bcm1480_steal_irq(K_BCM1480_INT_MBOX_0_0);
+
+	/*
+	 * Note that the timer interrupts are also mapped, but this is
+	 * done in bcm1480_time_init().  Also, the profiling driver
+	 * does its own management of IP7.
+	 */
+
+#ifdef CONFIG_KGDB
+	imask |= STATUSF_IP6;
+#endif
+	/* Enable necessary IPs, disable the rest */
+	change_c0_status(ST0_IM, imask);
+	set_except_vector(0, bcm1480_irq_handler);
+
+#ifdef CONFIG_KGDB
+	if (kgdb_flag) {
+		kgdb_irq = K_BCM1480_INT_UART_0 + kgdb_port;
+
+#ifdef CONFIG_SIBYTE_SB1250_DUART
+		sb1250_duart_present[kgdb_port] = 0;
+#endif
+		/* Setup uart 1 settings, mapper */
+		/* QQQ FIXME */
+		__raw_writeq(M_DUART_IMR_BRK, IO_SPACE_BASE + A_DUART_IMRREG(kgdb_port));
+
+		bcm1480_steal_irq(kgdb_irq);
+		__raw_writeq(IMR_IP6_VAL,
+			     IO_SPACE_BASE + A_BCM1480_IMR_REGISTER(0, R_BCM1480_IMR_INTERRUPT_MAP_BASE_H) +
+			     (kgdb_irq<<3));
+		bcm1480_unmask_irq(0, kgdb_irq);
+
+#ifdef CONFIG_GDB_CONSOLE
+		register_gdb_console();
+#endif
+		prom_printf("Waiting for GDB on UART port %d\n", kgdb_port);
+		set_debug_traps();
+		breakpoint();
+	}
+#endif
+}
+
+#ifdef CONFIG_KGDB
+
+#include <linux/delay.h>
+
+#define duart_out(reg, val)     csr_out32(val, IOADDR(A_DUART_CHANREG(kgdb_port,reg)))
+#define duart_in(reg)           csr_in32(IOADDR(A_DUART_CHANREG(kgdb_port,reg)))
+
+void bcm1480_kgdb_interrupt(struct pt_regs *regs)
+{
+	/*
+	 * Clear break-change status (allow some time for the remote
+	 * host to stop the break, since we would see another
+	 * interrupt on the end-of-break too)
+	 */
+	kstat.irqs[smp_processor_id()][kgdb_irq]++;
+	mdelay(500);
+	duart_out(R_DUART_CMD, V_DUART_MISC_CMD_RESET_BREAK_INT |
+				M_DUART_RX_EN | M_DUART_TX_EN);
+	set_async_breakpoint(&regs->cp0_epc);
+}
+
+#endif 	/* CONFIG_KGDB */
Index: lmo/arch/mips/sibyte/bcm1480/irq_handler.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ lmo/arch/mips/sibyte/bcm1480/irq_handler.S	2005-10-19 22:34:12.000000000 -0700
@@ -0,0 +1,165 @@
+/*
+ * Copyright (C) 2000,2001,2002,2003,2004 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+/*
+ * bcm1480_irq_handler() is the routine that is actually called when an
+ * interrupt occurs.  It is installed as the exception vector handler in
+ * init_IRQ() in arch/mips/sibyte/bcm1480/irq.c
+ *
+ * In the handle we figure out which interrupts need handling, and use that
+ * to call the dispatcher, which will take care of actually calling
+ * registered handlers
+ *
+ * Note that we take care of all raised interrupts in one go at the handler.
+ * This is more BSDish than the Indy code, and also, IMHO, more sane.
+ */
+#include <linux/config.h>
+
+#include <asm/addrspace.h>
+#include <asm/asm.h>
+#include <asm/mipsregs.h>
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+#include <asm/sibyte/sb1250_defs.h>
+#include <asm/sibyte/bcm1480_regs.h>
+#include <asm/sibyte/bcm1480_int.h>
+
+/*
+ * What a pain. We have to be really careful saving the upper 32 bits of any
+ * register across function calls if we don't want them trashed--since were
+ * running in -o32, the calling routing never saves the full 64 bits of a
+ * register across a function call.  Being the interrupt handler, we're
+ * guaranteed that interrupts are disabled during this code so we don't have
+ * to worry about random interrupts blasting the high 32 bits.
+ */
+
+	.text
+	.set	push
+	.set	noreorder
+	.set	noat
+	.set	mips64
+	#.set	mips4
+	.align	5
+	NESTED(bcm1480_irq_handler, PT_SIZE, sp)
+	SAVE_ALL
+	CLI
+
+#ifdef CONFIG_SIBYTE_BCM1480_PROF
+	/* Set compare to count to silence count/compare timer interrupts */
+	mfc0	t1, CP0_COUNT
+	mtc0	t1, CP0_COMPARE /* pause to clear IP[7] bit of cause ? */
+#endif
+	/* Read cause */
+	mfc0	s0, CP0_CAUSE
+
+#ifdef CONFIG_SIBYTE_BCM1480_PROF
+	/* Cpu performance counter interrupt is routed to IP[7] */
+	andi	t1, s0, CAUSEF_IP7
+	beqz	t1, 0f
+	 srl	t1, s0, (CAUSEB_BD-2)	/* Shift BD bit to bit 2 */
+	and	t1, t1, 0x4		/* mask to get just BD bit */
+#ifdef CONFIG_MIPS64
+	dmfc0	a0, CP0_EPC
+	daddu	a0, a0, t1		/* a0 = EPC + (BD ? 4 :	0) */
+#else
+	mfc0	a0, CP0_EPC
+	addu	a0, a0, t1		/* a0 = EPC + (BD ? 4 :	0) */
+#endif
+	jal	sbprof_cpu_intr
+	 nop
+	j	ret_from_irq
+	 nop
+0:
+#endif
+
+	/* Timer interrupt is routed to IP[4] */
+	andi	t1, s0, CAUSEF_IP4
+	beqz	t1, 1f
+	 nop
+	jal	bcm1480_timer_interrupt
+	 move	a0, sp			/* Pass the registers along */
+	j	ret_from_irq
+	 nop				/* delay slot  */
+1:
+
+#ifdef CONFIG_SMP
+	/* Mailbox interrupt is routed to IP[3] */
+	andi	 t1, s0, CAUSEF_IP3
+	beqz	 t1, 2f
+	 nop
+	jal	 bcm1480_mailbox_interrupt
+	 move	 a0, sp
+	j	 ret_from_irq
+	 nop				/* delay slot  */
+2:
+#endif
+
+#ifdef CONFIG_KGDB
+	/* KGDB (uart 1) interrupt is routed to IP[6] */
+	andi	 t1, s0, CAUSEF_IP6
+	beqz	 t1, 3f
+	 nop				/* delay slot  */
+	jal	 bcm1480_kgdb_interrupt
+	 move	 a0, sp
+	j	 ret_from_irq
+	 nop				/* delay slot  */
+3:
+#endif
+
+	and	 t1, s0, CAUSEF_IP2
+	beqz	 t1, 9f
+	 nop
+
+	/*
+	 * Default...we've hit an IP[2] interrupt, which means we've got
+	 * to check the 1480 interrupt registers to figure out what to do
+	 * Need to detect which CPU we're on, now that smp_affinity is
+	 * supported.
+	 */
+	PTR_LA	 v0, CKSEG1 + A_BCM1480_IMR_CPU0_BASE
+#ifdef CONFIG_SMP
+	lw	 t1, TI_CPU($28)
+	sll	 t1, t1, BCM1480_IMR_REGISTER_SPACING_SHIFT
+	addu	 v0, v0, t1
+#endif
+
+	/* Read IP[2] status (get both high and low halves of status) */
+	ld	 s0, R_BCM1480_IMR_INTERRUPT_STATUS_BASE_H(v0)
+	ld	 s1, R_BCM1480_IMR_INTERRUPT_STATUS_BASE_L(v0)
+
+	move	 s2, zero	/* intr number  */
+	li	 s3, 64
+
+	beqz	 s0, 9f		/* No interrupts.  Return.  */
+	 move	 a1, sp
+
+	xori	 s4, s0, 1	/* if s0 (_H) == 1, it's a low intr, so...  */
+	movz	 s2, s3, s4	/* start the intr number at 64, and  */
+	movz	 s0, s1, s4	/* look at the low status value.  */
+
+	dclz	 s1, s0		/* Find the next interrupt.  */
+	dsubu	 a0, zero, s1
+	daddiu	 a0, a0, 63
+	jal	 do_IRQ
+	 daddu	 a0, a0, s2
+
+9:	j	 ret_from_irq
+	 nop
+
+	.set pop
+	END(bcm1480_irq_handler)
Index: lmo/arch/mips/sibyte/bcm1480/setup.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ lmo/arch/mips/sibyte/bcm1480/setup.c	2005-10-19 22:34:12.000000000 -0700
@@ -0,0 +1,136 @@
+/*
+ * Copyright (C) 2000,2001,2002,2003,2004 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/reboot.h>
+#include <linux/string.h>
+
+#include <asm/bootinfo.h>
+#include <asm/mipsregs.h>
+#include <asm/io.h>
+#include <asm/sibyte/sb1250.h>
+
+#include <asm/sibyte/bcm1480_regs.h>
+#include <asm/sibyte/bcm1480_scd.h>
+#include <asm/sibyte/sb1250_scd.h>
+
+unsigned int sb1_pass;
+unsigned int soc_pass;
+unsigned int soc_type;
+unsigned int periph_rev;
+unsigned int zbbus_mhz;
+
+static unsigned int part_type;
+
+static char *soc_str;
+static char *pass_str;
+
+static inline int setup_bcm1x80_bcm1x55(void);
+
+/* Setup code likely to be common to all SiByte platforms */
+
+static inline int sys_rev_decode(void)
+{
+	int ret = 0;
+
+	switch (soc_type) {
+	    case K_SYS_SOC_TYPE_BCM1x80:
+		if (part_type == K_SYS_PART_BCM1480)
+		    soc_str = "BCM1480";
+		else if (part_type == K_SYS_PART_BCM1280)
+		    soc_str = "BCM1280";
+		else
+		    soc_str = "BCM1x80";
+		ret = setup_bcm1x80_bcm1x55();
+		break;
+
+	    case K_SYS_SOC_TYPE_BCM1x55:
+		if (part_type == K_SYS_PART_BCM1455)
+		    soc_str = "BCM1455";
+		else if (part_type == K_SYS_PART_BCM1255)
+		    soc_str = "BCM1255";
+		else
+		    soc_str = "BCM1x55";
+		ret = setup_bcm1x80_bcm1x55();
+		break;
+
+	    default:
+		prom_printf("Unknown part type %x\n", part_type);
+		ret = 1;
+		break;
+	}
+	return ret;
+}
+
+static inline int setup_bcm1x80_bcm1x55(void)
+{
+	int ret = 0;
+
+	switch (soc_pass) {
+	    case K_SYS_REVISION_BCM1480_S0:
+		periph_rev = 1;
+		pass_str = "S0 (pass1)";
+		break;
+	    case K_SYS_REVISION_BCM1480_A1:
+		periph_rev = 1;
+		pass_str = "A1 (pass1)";
+		break;
+	    case K_SYS_REVISION_BCM1480_A2:
+		periph_rev = 1;
+		pass_str = "A2 (pass1)";
+		break;
+	    case K_SYS_REVISION_BCM1480_A3:
+		periph_rev = 1;
+		pass_str = "A3 (pass1)";
+		break;
+	    case K_SYS_REVISION_BCM1480_B0:
+		periph_rev = 1;
+		pass_str = "B0 (pass2)";
+		break;
+	    default:
+		prom_printf("Unknown %s rev %x\n", soc_str, soc_pass);
+		periph_rev = 1;
+		pass_str = "Unknown Revision";
+		break;
+	}
+	return ret;
+}
+
+void bcm1480_setup(void)
+{
+	uint64_t sys_rev;
+	int plldiv;
+
+	sb1_pass = read_c0_prid() & 0xff;
+	sys_rev = __raw_readq(IOADDR(A_SCD_SYSTEM_REVISION));
+	soc_type = SYS_SOC_TYPE(sys_rev);
+	part_type = G_SYS_PART(sys_rev);
+	soc_pass = G_SYS_REVISION(sys_rev);
+
+	if (sys_rev_decode()) {
+		prom_printf("Restart after failure to identify SiByte chip\n");
+		machine_restart(NULL);
+	}
+
+	plldiv = G_BCM1480_SYS_PLL_DIV(__raw_readq(IOADDR(A_SCD_SYSTEM_CFG)));
+	zbbus_mhz = ((plldiv >> 1) * 50) + ((plldiv & 1) * 25);
+
+	prom_printf("Broadcom SiByte %s %s @ %d MHz (SB-1A rev %d)\n",
+		    soc_str, pass_str, zbbus_mhz * 2, sb1_pass);
+	prom_printf("Board type: %s\n", get_system_type());
+}
Index: lmo/arch/mips/sibyte/bcm1480/smp.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ lmo/arch/mips/sibyte/bcm1480/smp.c	2005-10-19 22:34:12.000000000 -0700
@@ -0,0 +1,110 @@
+/*
+ * Copyright (C) 2001,2002,2004 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/smp.h>
+#include <linux/kernel_stat.h>
+
+#include <asm/mmu_context.h>
+#include <asm/io.h>
+#include <asm/sibyte/sb1250.h>
+#include <asm/sibyte/bcm1480_regs.h>
+#include <asm/sibyte/bcm1480_int.h>
+
+extern void smp_call_function_interrupt(void);
+
+/*
+ * These are routines for dealing with the bcm1480 smp capabilities
+ * independent of board/firmware
+ */
+
+static void *mailbox_0_set_regs[] = {
+	IOADDR(A_BCM1480_IMR_CPU0_BASE + R_BCM1480_IMR_MAILBOX_0_SET_CPU),
+	IOADDR(A_BCM1480_IMR_CPU1_BASE + R_BCM1480_IMR_MAILBOX_0_SET_CPU),
+	IOADDR(A_BCM1480_IMR_CPU2_BASE + R_BCM1480_IMR_MAILBOX_0_SET_CPU),
+	IOADDR(A_BCM1480_IMR_CPU3_BASE + R_BCM1480_IMR_MAILBOX_0_SET_CPU),
+};
+
+static void *mailbox_0_clear_regs[] = {
+	IOADDR(A_BCM1480_IMR_CPU0_BASE + R_BCM1480_IMR_MAILBOX_0_CLR_CPU),
+	IOADDR(A_BCM1480_IMR_CPU1_BASE + R_BCM1480_IMR_MAILBOX_0_CLR_CPU),
+	IOADDR(A_BCM1480_IMR_CPU2_BASE + R_BCM1480_IMR_MAILBOX_0_CLR_CPU),
+	IOADDR(A_BCM1480_IMR_CPU3_BASE + R_BCM1480_IMR_MAILBOX_0_CLR_CPU),
+};
+
+static void *mailbox_0_regs[] = {
+	IOADDR(A_BCM1480_IMR_CPU0_BASE + R_BCM1480_IMR_MAILBOX_0_CPU),
+	IOADDR(A_BCM1480_IMR_CPU1_BASE + R_BCM1480_IMR_MAILBOX_0_CPU),
+	IOADDR(A_BCM1480_IMR_CPU2_BASE + R_BCM1480_IMR_MAILBOX_0_CPU),
+	IOADDR(A_BCM1480_IMR_CPU3_BASE + R_BCM1480_IMR_MAILBOX_0_CPU),
+};
+
+/*
+ * SMP init and finish on secondary CPUs
+ */
+void bcm1480_smp_init(void)
+{
+	unsigned int imask = STATUSF_IP4 | STATUSF_IP3 | STATUSF_IP2 |
+		STATUSF_IP1 | STATUSF_IP0;
+
+	/* Set interrupt mask, but don't enable */
+	change_c0_status(ST0_IM, imask);
+}
+
+void bcm1480_smp_finish(void)
+{
+	extern void bcm1480_time_init(void);
+	bcm1480_time_init();
+	local_irq_enable();
+}
+
+/*
+ * These are routines for dealing with the sb1250 smp capabilities
+ * independent of board/firmware
+ */
+
+/*
+ * Simple enough; everything is set up, so just poke the appropriate mailbox
+ * register, and we should be set
+ */
+void core_send_ipi(int cpu, unsigned int action)
+{
+	__raw_writeq((((u64)action)<< 48), mailbox_0_set_regs[cpu]);
+}
+
+void bcm1480_mailbox_interrupt(struct pt_regs *regs)
+{
+	int cpu = smp_processor_id();
+	unsigned int action;
+
+	kstat_this_cpu.irqs[K_BCM1480_INT_MBOX_0_0]++;
+	/* Load the mailbox register to figure out what we're supposed to do */
+	action = (__raw_readq(mailbox_0_regs[cpu]) >> 48) & 0xffff;
+
+	/* Clear the mailbox to clear the interrupt */
+	__raw_writeq(((u64)action)<<48, mailbox_0_clear_regs[cpu]);
+
+	/*
+	 * Nothing to do for SMP_RESCHEDULE_YOURSELF; returning from the
+	 * interrupt will do the reschedule for us
+	 */
+
+	if (action & SMP_CALL_FUNCTION)
+		smp_call_function_interrupt();
+}
Index: lmo/arch/mips/sibyte/bcm1480/time.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ lmo/arch/mips/sibyte/bcm1480/time.c	2005-10-19 22:34:12.000000000 -0700
@@ -0,0 +1,138 @@
+/*
+ * Copyright (C) 2000,2001,2004 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+/*
+ * These are routines to set up and handle interrupts from the
+ * bcm1480 general purpose timer 0.  We're using the timer as a
+ * system clock, so we set it up to run at 100 Hz.  On every
+ * interrupt, we update our idea of what the time of day is,
+ * then call do_timer() in the architecture-independent kernel
+ * code to do general bookkeeping (e.g. update jiffies, run
+ * bottom halves, etc.)
+ */
+#include <linux/config.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/kernel_stat.h>
+
+#include <asm/irq.h>
+#include <asm/ptrace.h>
+#include <asm/addrspace.h>
+#include <asm/time.h>
+#include <asm/io.h>
+
+#include <asm/sibyte/bcm1480_regs.h>
+#include <asm/sibyte/sb1250_regs.h>
+#include <asm/sibyte/bcm1480_int.h>
+#include <asm/sibyte/bcm1480_scd.h>
+
+#include <asm/sibyte/sb1250.h>
+
+
+#define IMR_IP2_VAL	K_BCM1480_INT_MAP_I0
+#define IMR_IP3_VAL	K_BCM1480_INT_MAP_I1
+#define IMR_IP4_VAL	K_BCM1480_INT_MAP_I2
+
+extern int bcm1480_steal_irq(int irq);
+
+void bcm1480_time_init(void)
+{
+	int cpu = smp_processor_id();
+	int irq = K_BCM1480_INT_TIMER_0+cpu;
+
+	/* Only have 4 general purpose timers */
+	if (cpu > 3) {
+		BUG();
+	}
+
+	if (!cpu) {
+		/* Use our own gettimeoffset() routine */
+		do_gettimeoffset = bcm1480_gettimeoffset;
+	}
+
+	bcm1480_mask_irq(cpu, irq);
+
+	/* Map the timer interrupt to ip[4] of this cpu */
+	__raw_writeq(IMR_IP4_VAL, IOADDR(A_BCM1480_IMR_REGISTER(cpu, R_BCM1480_IMR_INTERRUPT_MAP_BASE_H)
+	      + (irq<<3)));
+
+	/* the general purpose timer ticks at 1 Mhz independent of the rest of the system */
+	/* Disable the timer and set up the count */
+	__raw_writeq(0, IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG)));
+	__raw_writeq(
+#ifndef CONFIG_SIMULATION
+		1000000/HZ
+#else
+		50000/HZ
+#endif
+		, IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_INIT)));
+
+	/* Set the timer running */
+	__raw_writeq(M_SCD_TIMER_ENABLE|M_SCD_TIMER_MODE_CONTINUOUS,
+	      IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG)));
+
+	bcm1480_unmask_irq(cpu, irq);
+	bcm1480_steal_irq(irq);
+	/*
+	 * This interrupt is "special" in that it doesn't use the request_irq
+	 * way to hook the irq line.  The timer interrupt is initialized early
+	 * enough to make this a major pain, and it's also firing enough to
+	 * warrant a bit of special case code.  bcm1480_timer_interrupt is
+	 * called directly from irq_handler.S when IP[4] is set during an
+	 * interrupt
+	 */
+}
+
+#include <asm/sibyte/sb1250.h>
+
+void bcm1480_timer_interrupt(struct pt_regs *regs)
+{
+	int cpu = smp_processor_id();
+	int irq = K_BCM1480_INT_TIMER_0+cpu;
+
+	/* Reset the timer */
+	__raw_writeq(M_SCD_TIMER_ENABLE|M_SCD_TIMER_MODE_CONTINUOUS,
+	      IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG)));
+
+	/*
+	 * CPU 0 handles the global timer interrupt job
+	 */
+	if (cpu == 0) {
+		ll_timer_interrupt(irq, regs);
+	}
+
+	/*
+	 * every CPU should do profiling and process accouting
+	 */
+	ll_local_timer_interrupt(irq, regs);
+}
+
+/*
+ * We use our own do_gettimeoffset() instead of the generic one,
+ * because the generic one does not work for SMP case.
+ * In addition, since we use general timer 0 for system time,
+ * we can get accurate intra-jiffy offset without calibration.
+ */
+unsigned long bcm1480_gettimeoffset(void)
+{
+	unsigned long count =
+		__raw_readq(IOADDR(A_SCD_TIMER_REGISTER(0, R_SCD_TIMER_CNT)));
+
+	return 1000000/HZ - count;
+}
Index: lmo/arch/mips/sibyte/cfe/smp.c
===================================================================
--- lmo.orig/arch/mips/sibyte/cfe/smp.c	2005-10-19 22:34:07.000000000 -0700
+++ lmo/arch/mips/sibyte/cfe/smp.c	2005-10-19 22:34:12.000000000 -0700
@@ -70,8 +70,15 @@
  */
 void prom_init_secondary(void)
 {
+#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
+	extern void bcm1480_smp_init(void);
+	bcm1480_smp_init();
+#elif defined(CONFIG_SIBYTE_SB1250)
 	extern void sb1250_smp_init(void);
 	sb1250_smp_init();
+#else
+#error invalid SMP configuration
+#endif
 }
 
 /*
@@ -80,8 +87,15 @@
  */
 void prom_smp_finish(void)
 {
+#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
+	extern void bcm1480_smp_finish(void);
+	bcm1480_smp_finish();
+#elif defined(CONFIG_SIBYTE_SB1250)
 	extern void sb1250_smp_finish(void);
 	sb1250_smp_finish();
+#else
+#error invalid SMP configuration
+#endif
 }
 
 /*
Index: lmo/arch/mips/sibyte/swarm/setup.c
===================================================================
--- lmo.orig/arch/mips/sibyte/swarm/setup.c	2005-10-19 22:34:07.000000000 -0700
+++ lmo/arch/mips/sibyte/swarm/setup.c	2005-10-19 22:34:12.000000000 -0700
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2000, 2001, 2002, 2003 Broadcom Corporation
+ * Copyright (C) 2000, 2001, 2002, 2003, 2004 Broadcom Corporation
  * Copyright (C) 2004 by Ralf Baechle (ralf@linux-mips.org)
  *
  * This program is free software; you can redistribute it and/or
@@ -39,11 +39,23 @@
 #include <asm/time.h>
 #include <asm/traps.h>
 #include <asm/sibyte/sb1250.h>
+#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
+#include <asm/sibyte/bcm1480_regs.h>
+#elif defined(CONFIG_SIBYTE_SB1250) || defined(CONFIG_SIBYTE_BCM112X)
 #include <asm/sibyte/sb1250_regs.h>
+#else
+#error invalid SiByte board configuation
+#endif
 #include <asm/sibyte/sb1250_genbus.h>
 #include <asm/sibyte/board.h>
 
+#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
+extern void bcm1480_setup(void);
+#elif defined(CONFIG_SIBYTE_SB1250) || defined(CONFIG_SIBYTE_BCM112X)
 extern void sb1250_setup(void);
+#else
+#error invalid SiByte board configuation
+#endif
 
 extern int xicor_probe(void);
 extern int xicor_set_time(unsigned long);
@@ -66,7 +78,13 @@
          */
 
         /* We only need to setup the generic timer */
-        sb1250_time_init();
+#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
+	bcm1480_time_init();
+#elif defined(CONFIG_SIBYTE_SB1250) || defined(CONFIG_SIBYTE_BCM112X)
+	sb1250_time_init();
+#else
+#error invalid SiByte board configuation
+#endif
 }
 
 int swarm_be_handler(struct pt_regs *regs, int is_fixup)
@@ -81,7 +99,13 @@
 
 void __init plat_setup(void)
 {
+#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
+	bcm1480_setup();
+#elif defined(CONFIG_SIBYTE_SB1250) || defined(CONFIG_SIBYTE_BCM112X)
 	sb1250_setup();
+#else
+#error invalid SiByte board configuation
+#endif
 
 	panic_timeout = 5;  /* For debug.  */
 
Index: lmo/drivers/char/sb1250_duart.c
===================================================================
--- lmo.orig/drivers/char/sb1250_duart.c	2005-10-19 22:34:07.000000000 -0700
+++ lmo/drivers/char/sb1250_duart.c	2005-10-19 22:34:12.000000000 -0700
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2000, 2001, 2002, 2003 Broadcom Corporation
+ * Copyright (C) 2000,2001,2002,2003,2004 Broadcom Corporation
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -44,12 +44,31 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/sibyte/swarm.h>
+#include <asm/sibyte/sb1250.h>
+#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
+#include <asm/sibyte/bcm1480_regs.h>
+#include <asm/sibyte/bcm1480_int.h>
+#elif defined(CONFIG_SIBYTE_SB1250) || defined(CONFIG_SIBYTE_BCM112X)
 #include <asm/sibyte/sb1250_regs.h>
-#include <asm/sibyte/sb1250_uart.h>
 #include <asm/sibyte/sb1250_int.h>
-#include <asm/sibyte/sb1250.h>
+#else
+#error invalid SiByte UART configuation
+#endif
+#include <asm/sibyte/sb1250_uart.h>
 #include <asm/war.h>
 
+#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
+#define UNIT_CHANREG(n,reg)	A_BCM1480_DUART_CHANREG((n),(reg))
+#define UNIT_IMRREG(n)		A_BCM1480_DUART_IMRREG(n)
+#define UNIT_INT(n)		(K_BCM1480_INT_UART_0 + (n))
+#elif defined(CONFIG_SIBYTE_SB1250) || defined(CONFIG_SIBYTE_BCM112X)
+#define UNIT_CHANREG(n,reg)	A_DUART_CHANREG((n),(reg))
+#define UNIT_IMRREG(n)		A_DUART_IMRREG(n)
+#define UNIT_INT(n)		(K_INT_UART_0 + (n))
+#else
+#error invalid SiByte UART configuation
+#endif
+
 /* Toggle spewing of debugging output */
 #undef DEBUG
 
@@ -58,8 +77,8 @@
 #define TX_INTEN          1
 #define DUART_INITIALIZED 2
 
-#define DUART_MAX_LINE 2
-char sb1250_duart_present[DUART_MAX_LINE] = {1,1};
+#define DUART_MAX_LINE 4
+char sb1250_duart_present[DUART_MAX_LINE];
 EXPORT_SYMBOL(sb1250_duart_present);
 
 /*
@@ -132,16 +151,14 @@
 {
 	if (!(port->flags & DUART_INITIALIZED)) {
 		port->line = line;
-		port->status = IOADDR(A_DUART_CHANREG(line, R_DUART_STATUS));
-		port->imr = IOADDR(A_DUART_IMRREG(line));
-		port->tx_hold = IOADDR(A_DUART_CHANREG(line, R_DUART_TX_HOLD));
-		port->rx_hold = IOADDR(A_DUART_CHANREG(line, R_DUART_RX_HOLD));
-		port->mode_1 = IOADDR(A_DUART_CHANREG(line,
-						      R_DUART_MODE_REG_1));
-		port->mode_2 = IOADDR(A_DUART_CHANREG(line,
-						      R_DUART_MODE_REG_2));
-		port->clk_sel = IOADDR(A_DUART_CHANREG(line, R_DUART_CLK_SEL));
-		port->cmd = IOADDR(A_DUART_CHANREG(line, R_DUART_CMD));
+		port->status = IOADDR(UNIT_CHANREG(line, R_DUART_STATUS));
+		port->imr = IOADDR(UNIT_IMRREG(line));
+		port->tx_hold = IOADDR(UNIT_CHANREG(line, R_DUART_TX_HOLD));
+		port->rx_hold = IOADDR(UNIT_CHANREG(line, R_DUART_RX_HOLD));
+		port->mode_1 = IOADDR(UNIT_CHANREG(line, R_DUART_MODE_REG_1));
+		port->mode_2 = IOADDR(UNIT_CHANREG(line, R_DUART_MODE_REG_2));
+		port->clk_sel = IOADDR(UNIT_CHANREG(line, R_DUART_CLK_SEL));
+		port->cmd = IOADDR(UNIT_CHANREG(line, R_DUART_CMD));
 		port->flags |= DUART_INITIALIZED;
 	}
 }
@@ -484,8 +501,8 @@
 
 	tmp.type=PORT_SB1250;
 	tmp.line=us->line;
-	tmp.port=A_DUART_CHANREG(tmp.line,0);
-	tmp.irq=K_INT_UART_0 + tmp.line;
+	tmp.port=UNIT_CHANREG(tmp.line,0);
+	tmp.irq=UNIT_INT(tmp.line);
 	tmp.xmit_fifo_size=16; /* fixed by hw */
 	tmp.baud_base=5000000;
 	tmp.io_type=SERIAL_IO_MEM;
@@ -713,12 +730,37 @@
 	.wait_until_sent = duart_wait_until_sent,
 };
 
-/* Set up the driver and register it, register the 2 1250 UART interrupts.  This
+/* Initialize the sb1250_duart_present array based on SOC type.  */
+static void __init sb1250_duart_init_present_lines(void)
+{
+	int i, max_lines;
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
+	if (max_lines > DUART_MAX_LINE)
+		max_lines = DUART_MAX_LINE;
+
+	for (i = 0; i < max_lines; i++)
+		sb1250_duart_present[i] = 1;
+}
+
+/* Set up the driver and register it, register the UART interrupts.  This
    is called from tty_init, or as a part of the module init */
 static int __init sb1250_duart_init(void) 
 {
 	int i;
 
+	sb1250_duart_init_present_lines();
+
 	sb1250_duart_driver = alloc_tty_driver(DUART_MAX_LINE);
 	if (!sb1250_duart_driver)
 		return -ENOMEM;
@@ -743,11 +785,11 @@
 		init_duart_port(port, i);
 		spin_lock_init(&port->outp_lock);
 		duart_mask_ints(i, M_DUART_IMR_ALL);
-		if (request_irq(K_INT_UART_0+i, duart_int, 0, "uart", port)) {
+		if (request_irq(UNIT_INT(i), duart_int, 0, "uart", port)) {
 			panic("Couldn't get uart0 interrupt line");
 		}
 		__raw_writeq(M_DUART_RX_EN|M_DUART_TX_EN,
-			     IOADDR(A_DUART_CHANREG(i, R_DUART_CMD)));
+			     IOADDR(UNIT_CHANREG(i, R_DUART_CMD)));
 		duart_set_cflag(i, DEFAULT_CFLAGS);
 	}
 
@@ -774,8 +816,8 @@
 	for (i=0; i<DUART_MAX_LINE; i++) {
 		if (!sb1250_duart_present[i])
 			continue;
-		free_irq(K_INT_UART_0+i, &uart_states[i]);
-		disable_irq(K_INT_UART_0+i);
+		free_irq(UNIT_INT(i), &uart_states[i]);
+		disable_irq(UNIT_INT(i));
 	}
 	local_irq_restore(flags);
 }
@@ -783,7 +825,7 @@
 module_init(sb1250_duart_init);
 module_exit(sb1250_duart_fini);
 MODULE_DESCRIPTION("SB1250 Duart serial driver");
-MODULE_AUTHOR("Justin Carlson, Broadcom Corp.");
+MODULE_AUTHOR("Broadcom Corp.");
 
 #ifdef CONFIG_SIBYTE_SB1250_DUART_CONSOLE
 
@@ -829,6 +871,8 @@
 {
 	int i;
 
+	sb1250_duart_init_present_lines();
+
 	for (i=0; i<DUART_MAX_LINE; i++) {
 		uart_state_t *port = uart_states + i;
 
Index: lmo/drivers/net/sb1250-mac.c
===================================================================
--- lmo.orig/drivers/net/sb1250-mac.c	2005-10-19 22:34:07.000000000 -0700
+++ lmo/drivers/net/sb1250-mac.c	2005-10-19 22:34:12.000000000 -0700
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2001,2002,2003 Broadcom Corporation
+ * Copyright (C) 2001,2002,2003,2004 Broadcom Corporation
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -43,6 +43,7 @@
 #define SBMAC_ETH0_HWADDR "40:00:00:00:01:00"
 #define SBMAC_ETH1_HWADDR "40:00:00:00:01:01"
 #define SBMAC_ETH2_HWADDR "40:00:00:00:01:02"
+#define SBMAC_ETH3_HWADDR "40:00:00:00:01:03"
 #endif
 
 
@@ -57,7 +58,7 @@
 
 #define CONFIG_SBMAC_COALESCE
 
-#define MAX_UNITS 3		/* More are supported, limit only on options */
+#define MAX_UNITS 4		/* More are supported, limit only on options */
 
 /* Time in jiffies before concluding the transmitter is hung. */
 #define TX_TIMEOUT  (2*HZ)
@@ -85,11 +86,11 @@
    The media type is usually passed in 'options[]'.
 */
 #ifdef MODULE
-static int options[MAX_UNITS] = {-1, -1, -1};
+static int options[MAX_UNITS] = {-1, -1, -1, -1};
 module_param_array(options, int, NULL, S_IRUGO);
 MODULE_PARM_DESC(options, "1-" __MODULE_STRING(MAX_UNITS));
 
-static int full_duplex[MAX_UNITS] = {-1, -1, -1};
+static int full_duplex[MAX_UNITS] = {-1, -1, -1, -1};
 module_param_array(full_duplex, int, NULL, S_IRUGO);
 MODULE_PARM_DESC(full_duplex, "1-" __MODULE_STRING(MAX_UNITS));
 #endif
@@ -105,13 +106,26 @@
 #endif
 
 #include <asm/sibyte/sb1250.h>
-#include <asm/sibyte/sb1250_defs.h>
+#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
+#include <asm/sibyte/bcm1480_regs.h>
+#include <asm/sibyte/bcm1480_int.h>
+#elif defined(CONFIG_SIBYTE_SB1250) || defined(CONFIG_SIBYTE_BCM112X)
 #include <asm/sibyte/sb1250_regs.h>
-#include <asm/sibyte/sb1250_mac.h>
-#include <asm/sibyte/sb1250_dma.h>
 #include <asm/sibyte/sb1250_int.h>
+#else
+#error invalid SiByte MAC configuation
+#endif
 #include <asm/sibyte/sb1250_scd.h>
+#include <asm/sibyte/sb1250_mac.h>
+#include <asm/sibyte/sb1250_dma.h>
 
+#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
+#define UNIT_INT(n)		(K_BCM1480_INT_MAC_0 + ((n) * 2))
+#elif defined(CONFIG_SIBYTE_SB1250) || defined(CONFIG_SIBYTE_BCM112X)
+#define UNIT_INT(n)		(K_INT_MAC_0 + (n))
+#else
+#error invalid SiByte MAC configuation
+#endif
 
 /**********************************************************************
  *  Simple types
@@ -1476,10 +1490,10 @@
 	 * and make sure that RD_THRSH + WR_THRSH <=128 for pass2 and above
 	 * Use a larger RD_THRSH for gigabit
 	 */
-	if (periph_rev >= 2)
-		th_value = 64;
-	else
+	if (soc_type == K_SYS_SOC_TYPE_BCM1250 && periph_rev < 2)
 		th_value = 28;
+	else
+		th_value = 64;
 
 	fifo = V_MAC_TX_WR_THRSH(4) |	/* Must be '4' or '8' */
 		((s->sbm_speed == sbmac_speed_1000)
@@ -1589,13 +1603,17 @@
 	 * Turn on the rest of the bits in the enable register
 	 */
 
+#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
+	__raw_writeq(M_MAC_RXDMA_EN0 |
+		       M_MAC_TXDMA_EN0, s->sbm_macenable);
+#elif defined(CONFIG_SIBYTE_SB1250) || defined(CONFIG_SIBYTE_BCM112X)
 	__raw_writeq(M_MAC_RXDMA_EN0 |
 		       M_MAC_TXDMA_EN0 |
 		       M_MAC_RX_ENABLE |
 		       M_MAC_TX_ENABLE, s->sbm_macenable);
-
-
-
+#else
+#error invalid SiByte MAC configuation
+#endif
 
 #ifdef CONFIG_SBMAC_COALESCE
 	/*
@@ -1786,11 +1804,12 @@
 	reg &= ~M_MAC_IPHDR_OFFSET | V_MAC_IPHDR_OFFSET(15);
 	__raw_writeq(reg, sc->sbm_rxfilter);
 
-	/* read system identification to determine revision */
-	if (periph_rev >= 2) {
-		sc->rx_hw_checksum = ENABLE;
-	} else {
+	/* BCM1250 pass1 didn't have hardware checksum.  Everything
+	   later does.  */
+	if (soc_type == K_SYS_SOC_TYPE_BCM1250 && periph_rev < 2) {
 		sc->rx_hw_checksum = DISABLE;
+	} else {
+		sc->rx_hw_checksum = ENABLE;
 	}
 }
 
@@ -2220,7 +2239,7 @@
 
 
 
-#if defined(SBMAC_ETH0_HWADDR) || defined(SBMAC_ETH1_HWADDR) || defined(SBMAC_ETH2_HWADDR)
+#if defined(SBMAC_ETH0_HWADDR) || defined(SBMAC_ETH1_HWADDR) || defined(SBMAC_ETH2_HWADDR) || defined(SBMAC_ETH3_HWADDR)
 /**********************************************************************
  *  SBMAC_PARSE_XDIGIT(str)
  *
@@ -2765,7 +2784,7 @@
 
 
 
-#if defined(SBMAC_ETH0_HWADDR) || defined(SBMAC_ETH1_HWADDR) || defined(SBMAC_ETH2_HWADDR)
+#if defined(SBMAC_ETH0_HWADDR) || defined(SBMAC_ETH1_HWADDR) || defined(SBMAC_ETH2_HWADDR) || defined(SBMAC_ETH3_HWADDR)
 static void
 sbmac_setup_hwaddr(int chan,char *addr)
 {
@@ -2791,25 +2810,7 @@
 	unsigned long port;
 	int chip_max_units;
 
-	/*
-	 * For bringup when not using the firmware, we can pre-fill
-	 * the MAC addresses using the environment variables
-	 * specified in this file (or maybe from the config file?)
-	 */
-#ifdef SBMAC_ETH0_HWADDR
-	sbmac_setup_hwaddr(0,SBMAC_ETH0_HWADDR);
-#endif
-#ifdef SBMAC_ETH1_HWADDR
-	sbmac_setup_hwaddr(1,SBMAC_ETH1_HWADDR);
-#endif
-#ifdef SBMAC_ETH2_HWADDR
-	sbmac_setup_hwaddr(2,SBMAC_ETH2_HWADDR);
-#endif
-
-	/*
-	 * Walk through the Ethernet controllers and find
-	 * those who have their MAC addresses set.
-	 */
+	/* Set the number of available units based on the SOC type.  */
 	switch (soc_type) {
 	case K_SYS_SOC_TYPE_BCM1250:
 	case K_SYS_SOC_TYPE_BCM1250_ALT:
@@ -2821,6 +2822,10 @@
 	case K_SYS_SOC_TYPE_BCM1250_ALT2: /* Hybrid */
 		chip_max_units = 2;
 		break;
+	case K_SYS_SOC_TYPE_BCM1x55:
+	case K_SYS_SOC_TYPE_BCM1x80:
+		chip_max_units = 4;
+		break;
 	default:
 		chip_max_units = 0;
 		break;
@@ -2828,6 +2833,32 @@
 	if (chip_max_units > MAX_UNITS)
 		chip_max_units = MAX_UNITS;
 
+	/*
+	 * For bringup when not using the firmware, we can pre-fill
+	 * the MAC addresses using the environment variables
+	 * specified in this file (or maybe from the config file?)
+	 */
+#ifdef SBMAC_ETH0_HWADDR
+	if (chip_max_units > 0)
+	  sbmac_setup_hwaddr(0,SBMAC_ETH0_HWADDR);
+#endif
+#ifdef SBMAC_ETH1_HWADDR
+	if (chip_max_units > 1)
+	  sbmac_setup_hwaddr(1,SBMAC_ETH1_HWADDR);
+#endif
+#ifdef SBMAC_ETH2_HWADDR
+	if (chip_max_units > 2)
+	  sbmac_setup_hwaddr(2,SBMAC_ETH2_HWADDR);
+#endif
+#ifdef SBMAC_ETH3_HWADDR
+	if (chip_max_units > 3)
+	  sbmac_setup_hwaddr(3,SBMAC_ETH3_HWADDR);
+#endif
+
+	/*
+	 * Walk through the Ethernet controllers and find
+	 * those who have their MAC addresses set.
+	 */
 	for (idx = 0; idx < chip_max_units; idx++) {
 
 	        /*
@@ -2859,7 +2890,7 @@
 
 		printk(KERN_DEBUG "sbmac: configuring MAC at %lx\n", port);
 
-		dev->irq = K_INT_MAC_0 + idx;
+		dev->irq = UNIT_INT(idx);
 		dev->base_addr = port;
 		dev->mem_end = 0;
 		if (sbmac_init(dev, idx)) {
Index: lmo/arch/mips/Kconfig
===================================================================
--- lmo.orig/arch/mips/Kconfig	2005-10-19 22:34:07.000000000 -0700
+++ lmo/arch/mips/Kconfig	2005-10-19 22:34:12.000000000 -0700
@@ -1430,7 +1430,7 @@
 
 config SMP
 	bool "Multi-Processing support"
-	depends on CPU_RM9000 || (SIBYTE_SB1250 && !SIBYTE_STANDALONE) || SGI_IP27 || MIPS_MT_SMP
+	depends on CPU_RM9000 || ((SIBYTE_BCM1x80 || SIBYTE_BCM1x55 || SIBYTE_SB1250) && !SIBYTE_STANDALONE) || SGI_IP27 || MIPS_MT_SMP
 	---help---
 	  This enables support for systems with more than one CPU. If you have
 	  a system with only one CPU, like most personal computers, say N. If
Index: lmo/arch/mips/sibyte/Kconfig
===================================================================
--- lmo.orig/arch/mips/sibyte/Kconfig	2005-10-19 22:34:07.000000000 -0700
+++ lmo/arch/mips/sibyte/Kconfig	2005-10-19 22:34:12.000000000 -0700
@@ -26,6 +26,16 @@
 	bool
 	select SIBYTE_SB1xxx_SOC
 
+config SIBYTE_BCM1x80
+	bool
+	select HW_HAS_PCI
+	select SIBYTE_SB1xxx_SOC
+
+config SIBYTE_BCM1x55
+	bool
+	select HW_HAS_PCI
+	select SIBYTE_SB1xxx_SOC
+
 config SIBYTE_SB1xxx_SOC
 	bool
 	depends on EXPERIMENTAL
