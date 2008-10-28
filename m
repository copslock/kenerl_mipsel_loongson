Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 00:04:53 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:6420 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22533307AbYJ1AEN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Oct 2008 00:04:13 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B490656f60002>; Mon, 27 Oct 2008 20:04:06 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 17:03:07 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 17:03:07 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9S033hL003256;
	Mon, 27 Oct 2008 17:03:03 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9S032Yb003255;
	Mon, 27 Oct 2008 17:03:02 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: [PATCH 03/36] Add Cavium OCTEON processor support files to arch/mips/kernel.
Date:	Mon, 27 Oct 2008 17:02:35 -0700
Message-Id: <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com>
References: <490655B6.4030406@caviumnetworks.com>
 <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 28 Oct 2008 00:03:07.0757 (UTC) FILETIME=[8EB6F1D0:01C93890]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/irq-octeon.c    |  464 ++++++++++++++++++++++++++++++++++
 arch/mips/kernel/octeon_switch.S |  506 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 970 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/kernel/irq-octeon.c
 create mode 100644 arch/mips/kernel/octeon_switch.S

diff --git a/arch/mips/kernel/irq-octeon.c b/arch/mips/kernel/irq-octeon.c
new file mode 100644
index 0000000..738f3c6
--- /dev/null
+++ b/arch/mips/kernel/irq-octeon.c
@@ -0,0 +1,464 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004-2007 Cavium Networks
+ */
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+
+#include <asm/irq_cpu.h>
+#include <asm/mipsregs.h>
+#include <asm/system.h>
+
+#include "../cavium-octeon/hal.h"
+
+DEFINE_RWLOCK(octeon_irq_ciu0_rwlock);
+DEFINE_RWLOCK(octeon_irq_ciu1_rwlock);
+DEFINE_SPINLOCK(octeon_irq_msi_lock);
+
+static void octeon_irq_core_ack(unsigned int irq)
+{
+	/* We don't need to disable IRQs to make these atomic since they are
+	   already disabled earlier in the low level interrupt code */
+	clear_c0_status(0x100 << irq);
+	/* The two user interrupts must be cleared manually */
+	if (irq < 2)
+		clear_c0_cause(0x100 << irq);
+}
+
+static void octeon_irq_core_eoi(unsigned int irq)
+{
+	irq_desc_t *desc = irq_desc + irq;
+	/* If an IRQ is being processed while we are disabling it the handler
+	   will attempt to unmask the interrupt after it has been disabled */
+	if (desc->status & IRQ_DISABLED)
+		return;
+	/* We don't need to disable IRQs to make these atomic since they are
+	   already disabled earlier in the low level interrupt code */
+	set_c0_status(0x100 << irq);
+}
+
+static void octeon_irq_core_enable(unsigned int irq)
+{
+	/* We need to disable interrupts to make sure our updates are atomic */
+	unsigned long flags;
+	local_irq_save(flags);
+	set_c0_status(0x100 << irq);
+	local_irq_restore(flags);
+}
+
+static void octeon_irq_core_disable_local(unsigned int irq)
+{
+	/* We need to disable interrupts to make sure our updates are atomic */
+	unsigned long flags;
+	local_irq_save(flags);
+	clear_c0_status(0x100 << irq);
+	local_irq_restore(flags);
+}
+
+static void octeon_irq_core_disable(unsigned int irq)
+{
+#ifdef CONFIG_SMP
+	on_each_cpu((void (*)(void *)) octeon_irq_core_disable_local,
+		    (void *) (long) irq, 1);
+#else
+	octeon_irq_core_disable_local(irq);
+#endif
+}
+
+struct irq_chip octeon_irq_chip_core = {
+	.name = "Core",
+	.enable = octeon_irq_core_enable,
+	.disable = octeon_irq_core_disable,
+	.ack = octeon_irq_core_ack,
+	.eoi = octeon_irq_core_eoi,
+};
+
+
+static void octeon_irq_ciu0_ack(unsigned int irq)
+{
+	/* In order to avoid any locking accessing the CIU, we acknowledge CIU
+	   interrupts by disabling all of them. This way we can use a per core
+	   register and avoid any out of core locking requirements. This has
+	   the side affect that CIU interrupts can't be processed recursively */
+	/* We don't need to disable IRQs to make these atomic since they are
+	   already disabled earlier in the low level interrupt code */
+	clear_c0_status(0x100 << 2);
+}
+
+static void octeon_irq_ciu0_eoi(unsigned int irq)
+{
+	/* Enable all CIU interrupts again */
+	/* We don't need to disable IRQs to make these atomic since they are
+	   already disabled earlier in the low level interrupt code */
+	set_c0_status(0x100 << 2);
+}
+
+static void octeon_irq_ciu0_enable(unsigned int irq)
+{
+	int coreid = cvmx_get_core_num();
+	unsigned long flags;
+	uint64_t en0;
+	int bit = irq - OCTEON_IRQ_WORKQ0;	/* Bit 0-63 of EN0 */
+
+	/* A read lock is used here to make sure only one core is ever updating
+	   the CIU enable bits at a time. During an enable the cores don't
+	   interfere with each other. During a disable the write lock stops any
+	   enables that might cause a problem */
+	read_lock_irqsave(&octeon_irq_ciu0_rwlock, flags);
+	en0 = cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2));
+	en0 |= 1ull << bit;
+	cvmx_write_csr(CVMX_CIU_INTX_EN0(coreid * 2), en0);
+	cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2));
+	read_unlock_irqrestore(&octeon_irq_ciu0_rwlock, flags);
+}
+
+static void octeon_irq_ciu0_disable(unsigned int irq)
+{
+	int bit = irq - OCTEON_IRQ_WORKQ0;	/* Bit 0-63 of EN0 */
+	unsigned long flags;
+	uint64_t en0;
+#ifdef CONFIG_SMP
+	int cpu;
+	write_lock_irqsave(&octeon_irq_ciu0_rwlock, flags);
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		if (cpu_present(cpu)) {
+			int coreid = cpu_logical_map(cpu);
+			en0 = cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2));
+			en0 &= ~(1ull << bit);
+			cvmx_write_csr(CVMX_CIU_INTX_EN0(coreid * 2), en0);
+		}
+	}
+	/* We need to do a read after the last update to make sure all of them
+	   are done */
+	cvmx_read_csr(CVMX_CIU_INTX_EN0(cvmx_get_core_num() * 2));
+	write_unlock_irqrestore(&octeon_irq_ciu0_rwlock, flags);
+#else
+	int coreid = cvmx_get_core_num();
+	local_irq_save(flags);
+	en0 = cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2));
+	en0 &= ~(1ull << bit);
+	cvmx_write_csr(CVMX_CIU_INTX_EN0(coreid * 2), en0);
+	cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2));
+	local_irq_restore(flags);
+#endif
+}
+
+#ifdef CONFIG_SMP
+static void octeon_irq_ciu0_set_affinity(unsigned int irq, cpumask_t dest)
+{
+	int cpu;
+	int bit = irq - OCTEON_IRQ_WORKQ0;	/* Bit 0-63 of EN0 */
+
+	write_lock(&octeon_irq_ciu0_rwlock);
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		if (cpu_present(cpu)) {
+			int coreid = cpu_logical_map(cpu);
+			uint64_t en0 =
+				cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2));
+			if (cpu_isset(cpu, dest))
+				en0 |= 1ull << bit;
+			else
+				en0 &= ~(1ull << bit);
+			cvmx_write_csr(CVMX_CIU_INTX_EN0(coreid * 2), en0);
+		}
+	}
+	/* We need to do a read after the last update to make sure all of them
+	   are done */
+	cvmx_read_csr(CVMX_CIU_INTX_EN0(cvmx_get_core_num() * 2));
+	write_unlock(&octeon_irq_ciu0_rwlock);
+}
+#endif
+
+struct irq_chip octeon_irq_chip_ciu0 = {
+	.name = "CIU0",
+	.enable = octeon_irq_ciu0_enable,
+	.disable = octeon_irq_ciu0_disable,
+	.ack = octeon_irq_ciu0_ack,
+	.eoi = octeon_irq_ciu0_eoi,
+#ifdef CONFIG_SMP
+	.set_affinity = octeon_irq_ciu0_set_affinity,
+#endif
+};
+
+
+static void octeon_irq_ciu1_ack(unsigned int irq)
+{
+	/* In order to avoid any locking accessing the CIU, we acknowledge CIU
+	   interrupts by disabling all of them. This way we can use a per core
+	   register and avoid any out of core locking requirements. This has
+	   the side affect that CIU interrupts can't be processed recursively */
+	/* We don't need to disable IRQs to make these atomic since they are
+	   already disabled earlier in the low level interrupt code */
+	clear_c0_status(0x100 << 3);
+}
+
+static void octeon_irq_ciu1_eoi(unsigned int irq)
+{
+	/* Enable all CIU interrupts again */
+	/* We don't need to disable IRQs to make these atomic since they are
+	   already disabled earlier in the low level interrupt code */
+	set_c0_status(0x100 << 3);
+}
+
+static void octeon_irq_ciu1_enable(unsigned int irq)
+{
+	int coreid = cvmx_get_core_num();
+	unsigned long flags;
+	uint64_t en1;
+	int bit = irq - OCTEON_IRQ_WDOG0;	/* Bit 0-63 of EN1 */
+
+	/* A read lock is used here to make sure only one core is ever updating
+	   the CIU enable bits at a time. During an enable the cores don't
+	   interfere with each other. During a disable the write lock stops any
+	   enables that might cause a problem */
+	read_lock_irqsave(&octeon_irq_ciu1_rwlock, flags);
+	en1 = cvmx_read_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1));
+	en1 |= 1ull << bit;
+	cvmx_write_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1), en1);
+	cvmx_read_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1));
+	read_unlock_irqrestore(&octeon_irq_ciu1_rwlock, flags);
+}
+
+static void octeon_irq_ciu1_disable(unsigned int irq)
+{
+	int bit = irq - OCTEON_IRQ_WDOG0;	/* Bit 0-63 of EN1 */
+	unsigned long flags;
+	uint64_t en1;
+#ifdef CONFIG_SMP
+	int cpu;
+	write_lock_irqsave(&octeon_irq_ciu1_rwlock, flags);
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		if (cpu_present(cpu)) {
+			int coreid = cpu_logical_map(cpu);
+			en1 = cvmx_read_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1));
+			en1 &= ~(1ull << bit);
+			cvmx_write_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1), en1);
+		}
+	}
+	/* We need to do a read after the last update to make sure all of them
+	   are done */
+	cvmx_read_csr(CVMX_CIU_INTX_EN1(cvmx_get_core_num() * 2 + 1));
+	write_unlock_irqrestore(&octeon_irq_ciu1_rwlock, flags);
+#else
+	int coreid = cvmx_get_core_num();
+	local_irq_save(flags);
+	en1 = cvmx_read_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1));
+	en1 &= ~(1ull << bit);
+	cvmx_write_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1), en1);
+	cvmx_read_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1));
+	local_irq_restore(flags);
+#endif
+}
+
+#ifdef CONFIG_SMP
+static void octeon_irq_ciu1_set_affinity(unsigned int irq, cpumask_t dest)
+{
+	int cpu;
+	int bit = irq - OCTEON_IRQ_WDOG0;	/* Bit 0-63 of EN1 */
+
+	write_lock(&octeon_irq_ciu1_rwlock);
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		if (cpu_present(cpu)) {
+			int coreid = cpu_logical_map(cpu);
+			uint64_t en1 =
+				cvmx_read_csr(CVMX_CIU_INTX_EN1
+					      (coreid * 2 + 1));
+			if (cpu_isset(cpu, dest))
+				en1 |= 1ull << bit;
+			else
+				en1 &= ~(1ull << bit);
+			cvmx_write_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1), en1);
+		}
+	}
+	/* We need to do a read after the last update to make sure all of them
+	   are done */
+	cvmx_read_csr(CVMX_CIU_INTX_EN1(cvmx_get_core_num() * 2 + 1));
+	write_unlock(&octeon_irq_ciu1_rwlock);
+}
+#endif
+
+struct irq_chip octeon_irq_chip_ciu1 = {
+	.name = "CIU1",
+	.enable = octeon_irq_ciu1_enable,
+	.disable = octeon_irq_ciu1_disable,
+	.ack = octeon_irq_ciu1_ack,
+	.eoi = octeon_irq_ciu1_eoi,
+#ifdef CONFIG_SMP
+	.set_affinity = octeon_irq_ciu1_set_affinity,
+#endif
+};
+
+
+static void octeon_irq_i8289_master_unmask(unsigned int irq)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+	outb(inb(0x21) & ~(1 << (irq - OCTEON_IRQ_I8259M0)), 0x21);
+	local_irq_restore(flags);
+}
+
+static void octeon_irq_i8289_master_mask(unsigned int irq)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+	outb(inb(0x21) | (1 << (irq - OCTEON_IRQ_I8259M0)), 0x21);
+	local_irq_restore(flags);
+}
+
+struct irq_chip octeon_irq_chip_i8259_master = {
+	.name = "i8259M",
+	.mask = octeon_irq_i8289_master_mask,
+	.mask_ack = octeon_irq_i8289_master_mask,
+	.unmask = octeon_irq_i8289_master_unmask,
+	.eoi = octeon_irq_i8289_master_unmask,
+};
+
+
+static void octeon_irq_i8289_slave_unmask(unsigned int irq)
+{
+	outb(inb(0xa1) & ~(1 << (irq - OCTEON_IRQ_I8259S0)), 0xa1);
+}
+
+static void octeon_irq_i8289_slave_mask(unsigned int irq)
+{
+	outb(inb(0xa1) | (1 << (irq - OCTEON_IRQ_I8259S0)), 0xa1);
+}
+
+struct irq_chip octeon_irq_chip_i8259_slave = {
+	.name = "i8259S",
+	.mask = octeon_irq_i8289_slave_mask,
+	.mask_ack = octeon_irq_i8289_slave_mask,
+	.unmask = octeon_irq_i8289_slave_unmask,
+	.eoi = octeon_irq_i8289_slave_unmask,
+};
+
+#ifdef CONFIG_PCI_MSI
+
+static void octeon_irq_msi_ack(unsigned int irq)
+{
+	if (!octeon_has_feature(OCTEON_FEATURE_PCIE)) {
+		/* These chips have PCI */
+		cvmx_write_csr(CVMX_NPI_NPI_MSI_RCV,
+			       1ull << (irq - OCTEON_IRQ_MSI_BIT0));
+	} else {
+		/* These chips have PCIe. Thankfully the ACK doesn't need any
+		   locking */
+		cvmx_write_csr(CVMX_PEXP_NPEI_MSI_RCV0,
+			       1ull << (irq - OCTEON_IRQ_MSI_BIT0));
+	}
+}
+
+static void octeon_irq_msi_eoi(unsigned int irq)
+{
+	/* Nothing needed */
+}
+
+static void octeon_irq_msi_enable(unsigned int irq)
+{
+	if (!octeon_has_feature(OCTEON_FEATURE_PCIE)) {
+		/* Octeon PCI doesn't have the ability to mask/unmask MSI
+		   interrupts individually. Instead of masking/unmasking them
+		   in groups of 16, we simple assume MSI devices are well
+		   behaved. MSI interrupts are always enable and the ACK is
+		   assumed to be enough */
+	} else {
+		/* These chips have PCIe. Note that we only support the first
+		   64 MSI interrupts. Unfortunately all the MSI enables are in
+		   the same register. We use MSI0's lock to control access to
+		   them all. */
+		uint64_t en;
+		unsigned long flags;
+		spin_lock_irqsave(&octeon_irq_msi_lock, flags);
+		en = cvmx_read_csr(CVMX_PEXP_NPEI_MSI_ENB0);
+		en |= 1ull << (irq - OCTEON_IRQ_MSI_BIT0);
+		cvmx_write_csr(CVMX_PEXP_NPEI_MSI_ENB0, en);
+		cvmx_read_csr(CVMX_PEXP_NPEI_MSI_ENB0);
+		spin_unlock_irqrestore(&octeon_irq_msi_lock, flags);
+	}
+}
+
+static void octeon_irq_msi_disable(unsigned int irq)
+{
+	if (!octeon_has_feature(OCTEON_FEATURE_PCIE)) {
+		/* See comment in enable */
+	} else {
+		/* These chips have PCIe. Note that we only support the first
+		   64 MSI interrupts. Unfortunately all the MSI enables are in
+		   the same register. We use MSI0's lock to control access to
+		   them all. */
+		uint64_t en;
+		unsigned long flags;
+		spin_lock_irqsave(&octeon_irq_msi_lock, flags);
+		en = cvmx_read_csr(CVMX_PEXP_NPEI_MSI_ENB0);
+		en &= ~(1ull << (irq - OCTEON_IRQ_MSI_BIT0));
+		cvmx_write_csr(CVMX_PEXP_NPEI_MSI_ENB0, en);
+		cvmx_read_csr(CVMX_PEXP_NPEI_MSI_ENB0);
+		spin_unlock_irqrestore(&octeon_irq_msi_lock, flags);
+	}
+}
+
+struct irq_chip octeon_irq_chip_msi = {
+	.name = "MSI",
+	.enable = octeon_irq_msi_enable,
+	.disable = octeon_irq_msi_disable,
+	.ack = octeon_irq_msi_ack,
+	.eoi = octeon_irq_msi_eoi,
+};
+#endif
+
+void __init arch_init_irq(void)
+{
+	int irq;
+
+	if (NR_IRQS < OCTEON_IRQ_LAST)
+		pr_err("octeon_irq_init: NR_IRQS is set too low\n");
+
+	/* 0-7 Mips internal */
+	for (irq = OCTEON_IRQ_SW0; irq <= OCTEON_IRQ_TIMER; irq++) {
+		set_irq_chip_and_handler(irq, &octeon_irq_chip_core,
+					 handle_percpu_irq);
+	}
+
+	/* 8-71 CIU_INT_SUM0 */
+	for (irq = OCTEON_IRQ_WORKQ0; irq <= OCTEON_IRQ_BOOTDMA; irq++) {
+		set_irq_chip_and_handler(irq, &octeon_irq_chip_ciu0,
+					 handle_percpu_irq);
+	}
+
+	/* 72-135 CIU_INT_SUM1 */
+	for (irq = OCTEON_IRQ_WDOG0; irq <= OCTEON_IRQ_RESERVED135; irq++) {
+		set_irq_chip_and_handler(irq, &octeon_irq_chip_ciu1,
+					 handle_percpu_irq);
+	}
+
+	/* 136 - 143 are reserved to align the i8259 in a multiple of 16. This
+	   alignment is necessary since old style ISA interrupts hanging off
+	   the i8259 have internal alignment assumptions */
+
+	/* 144-151 i8259 master controller */
+	for (irq = OCTEON_IRQ_I8259M0; irq <= OCTEON_IRQ_I8259M7; irq++) {
+		set_irq_chip_and_handler(irq, &octeon_irq_chip_i8259_master,
+					 handle_level_irq);
+	}
+
+	/* 152-159 i8259 slave controller */
+	for (irq = OCTEON_IRQ_I8259S0; irq <= OCTEON_IRQ_I8259S7; irq++) {
+		set_irq_chip_and_handler(irq, &octeon_irq_chip_i8259_slave,
+					 handle_level_irq);
+	}
+
+#ifdef CONFIG_PCI_MSI
+	/* 160-223 PCI/PCIe MSI interrupts */
+	for (irq = OCTEON_IRQ_MSI_BIT0; irq <= OCTEON_IRQ_MSI_BIT63; irq++) {
+		set_irq_chip_and_handler(irq, &octeon_irq_chip_msi,
+					 handle_percpu_irq);
+	}
+#endif
+
+	set_c0_status(0x300 << 2);
+}
diff --git a/arch/mips/kernel/octeon_switch.S b/arch/mips/kernel/octeon_switch.S
new file mode 100644
index 0000000..d523896
--- /dev/null
+++ b/arch/mips/kernel/octeon_switch.S
@@ -0,0 +1,506 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1994, 1995, 1996, 1998, 1999, 2002, 2003 Ralf Baechle
+ * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
+ * Copyright (C) 1994, 1995, 1996, by Andreas Busse
+ * Copyright (C) 1999 Silicon Graphics, Inc.
+ * Copyright (C) 2000 MIPS Technologies, Inc.
+ *    written by Carsten Langgaard, carstenl@mips.com
+ */
+#include <asm/asm.h>
+#include <asm/cachectl.h>
+#include <asm/fpregdef.h>
+#include <asm/mipsregs.h>
+#include <asm/asm-offsets.h>
+#include <asm/page.h>
+#include <asm/pgtable-bits.h>
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+#include <asm/thread_info.h>
+
+#include <asm/asmmacro.h>
+
+/*
+ * Offset to the current process status flags, the first 32 bytes of the
+ * stack are not used.
+ */
+#define ST_OFF (_THREAD_SIZE - 32 - PT_SIZE + PT_STATUS)
+
+/*
+ * task_struct *resume(task_struct *prev, task_struct *next,
+ *                     struct thread_info *next_ti)
+ */
+	.align	7
+	LEAF(resume)
+	.set arch=octeon
+#ifndef CONFIG_CPU_HAS_LLSC
+	sw	zero, ll_bit
+#endif
+	mfc0	t1, CP0_STATUS
+	LONG_S	t1, THREAD_STATUS(a0)
+	cpu_save_nonscratch a0
+	LONG_S	ra, THREAD_REG31(a0)
+
+	/* check if we need to save COP2 registers */
+	PTR_L	t2, TASK_THREAD_INFO(a0)
+	LONG_L	t0, ST_OFF(t2)
+	bbit0	t0, 30, 1f
+
+	/* Disable COP2 in the stored process state */
+	li	t1, ST0_CU2
+	xor	t0, t1
+	LONG_S	t0, ST_OFF(t2)
+
+	/* Enable COP2 so we can save it */
+	mfc0	t0, CP0_STATUS
+	or	t0, t1
+	mtc0	t0, CP0_STATUS
+
+	/* Save COP2 */
+	daddu	a0, THREAD_CP2
+	jal octeon_cop2_save
+	dsubu	a0, THREAD_CP2
+
+	/* Disable COP2 now that we are done */
+	mfc0	t0, CP0_STATUS
+	li	t1, ST0_CU2
+	xor	t0, t1
+	mtc0	t0, CP0_STATUS
+
+1:
+#if CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0
+	/* Check if we need to store CVMSEG state */
+	mfc0	t0, $11,7 	/* CvmMemCtl */
+	bbit0	t0, 6, 3f	/* Is user access enabled? */
+
+	/* Store the CVMSEG state */
+	/* Extract the size of CVMSEG */
+	andi	t0, 0x3f
+	/* Multiply * (cache line size/sizeof(long)/2) */
+	sll	t0, 7-LONGLOG-1
+	li	t1, -32768 	/* Base address of CVMSEG */
+	LONG_ADDI t2, a0, THREAD_CVMSEG	/* Where to store CVMSEG to */
+	synciobdma
+2:
+	.set noreorder
+	LONG_L	t8, 0(t1)	/* Load from CVMSEG */
+	subu	t0, 1		/* Decrement loop var */
+	LONG_L	t9, LONGSIZE(t1)/* Load from CVMSEG */
+	LONG_ADDU t1, LONGSIZE*2 /* Increment loc in CVMSEG */
+	LONG_S	t8, 0(t2)	/* Store CVMSEG to thread storage */
+	LONG_ADDU t2, LONGSIZE*2 /* Increment loc in thread storage */
+	bnez	t0, 2b		/* Loop until we've copied it all */
+	 LONG_S	t9, -LONGSIZE(t2)/* Store CVMSEG to thread storage */
+	.set reorder
+
+	/* Disable access to CVMSEG */
+	mfc0	t0, $11,7 	/* CvmMemCtl */
+	xori	t0, t0, 0x40	/* Bit 6 is CVMSEG user enable */
+	mtc0	t0, $11,7 	/* CvmMemCtl */
+#endif
+3:
+	/*
+	 * The order of restoring the registers takes care of the race
+	 * updating $28, $29 and kernelsp without disabling ints.
+	 */
+	move	$28, a2
+	cpu_restore_nonscratch a1
+
+#if (_THREAD_SIZE - 32) < 0x8000
+	PTR_ADDIU	t0, $28, _THREAD_SIZE - 32
+#else
+	PTR_LI		t0, _THREAD_SIZE - 32
+	PTR_ADDU	t0, $28
+#endif
+	set_saved_sp	t0, t1, t2
+
+	mfc0	t1, CP0_STATUS		/* Do we really need this? */
+	li	a3, 0xff01
+	and	t1, a3
+	LONG_L	a2, THREAD_STATUS(a1)
+	nor	a3, $0, a3
+	and	a2, a3
+	or	a2, t1
+	mtc0	a2, CP0_STATUS
+	move	v0, a0
+	jr	ra
+	END(resume)
+
+/*
+ * void octeon_cop2_save(struct octeon_cop2_state *a0)
+ */
+	.align	7
+	LEAF(octeon_cop2_save)
+
+	dmfc0	t9, $9,7	/* CvmCtl register. */
+
+        /* Save the COP2 CRC state */
+	dmfc2	t0, 0x0201
+	dmfc2	t1, 0x0202
+	dmfc2	t2, 0x0200
+	sd	t0, OCTEON_CP2_CRC_IV(a0)
+	sd	t1, OCTEON_CP2_CRC_LENGTH(a0)
+	sd	t2, OCTEON_CP2_CRC_POLY(a0)
+	/* Skip next instructions if CvmCtl[NODFA_CP2] set */
+	bbit1	t9, 28, 1f
+
+	/* Save the LLM state */
+	dmfc2	t0, 0x0402
+	dmfc2	t1, 0x040A
+	sd	t0, OCTEON_CP2_LLM_DAT(a0)
+	sd	t1, OCTEON_CP2_LLM_DAT+8(a0)
+
+1:      bbit1	t9, 26, 3f	/* done if CvmCtl[NOCRYPTO] set */
+
+	/* Save the COP2 crypto state */
+        /* this part is mostly common to both pass 1 and later revisions */
+	dmfc2 	t0, 0x0084
+	dmfc2 	t1, 0x0080
+	dmfc2 	t2, 0x0081
+	dmfc2 	t3, 0x0082
+	sd	t0, OCTEON_CP2_3DES_IV(a0)
+	dmfc2 	t0, 0x0088
+	sd	t1, OCTEON_CP2_3DES_KEY(a0)
+	dmfc2 	t1, 0x0111                      /* only necessary for pass 1 */
+	sd	t2, OCTEON_CP2_3DES_KEY+8(a0)
+	dmfc2 	t2, 0x0102
+	sd	t3, OCTEON_CP2_3DES_KEY+16(a0)
+	dmfc2 	t3, 0x0103
+	sd	t0, OCTEON_CP2_3DES_RESULT(a0)
+	dmfc2 	t0, 0x0104
+	sd	t1, OCTEON_CP2_AES_INP0(a0)     /* only necessary for pass 1 */
+	dmfc2 	t1, 0x0105
+	sd	t2, OCTEON_CP2_AES_IV(a0)
+	dmfc2	t2, 0x0106
+	sd	t3, OCTEON_CP2_AES_IV+8(a0)
+	dmfc2 	t3, 0x0107
+	sd	t0, OCTEON_CP2_AES_KEY(a0)
+	dmfc2	t0, 0x0110
+	sd	t1, OCTEON_CP2_AES_KEY+8(a0)
+	dmfc2	t1, 0x0100
+	sd	t2, OCTEON_CP2_AES_KEY+16(a0)
+	dmfc2	t2, 0x0101
+	sd	t3, OCTEON_CP2_AES_KEY+24(a0)
+	mfc0	t3, $15,0 	/* Get the processor ID register */
+	sd	t0, OCTEON_CP2_AES_KEYLEN(a0)
+	li	t0, 0x000d0000	/* This is the processor ID of Octeon Pass1 */
+	sd	t1, OCTEON_CP2_AES_RESULT(a0)
+	sd	t2, OCTEON_CP2_AES_RESULT+8(a0)
+	/* Skip to the Pass1 version of the remainder of the COP2 state */
+	beq	t3, t0, 2f
+
+        /* the non-pass1 state when !CvmCtl[NOCRYPTO] */
+	dmfc2	t1, 0x0240
+	dmfc2	t2, 0x0241
+	dmfc2	t3, 0x0242
+	dmfc2	t0, 0x0243
+	sd	t1, OCTEON_CP2_HSH_DATW(a0)
+	dmfc2	t1, 0x0244
+	sd	t2, OCTEON_CP2_HSH_DATW+8(a0)
+	dmfc2	t2, 0x0245
+	sd	t3, OCTEON_CP2_HSH_DATW+16(a0)
+	dmfc2	t3, 0x0246
+	sd	t0, OCTEON_CP2_HSH_DATW+24(a0)
+	dmfc2	t0, 0x0247
+	sd	t1, OCTEON_CP2_HSH_DATW+32(a0)
+	dmfc2	t1, 0x0248
+	sd	t2, OCTEON_CP2_HSH_DATW+40(a0)
+	dmfc2	t2, 0x0249
+	sd	t3, OCTEON_CP2_HSH_DATW+48(a0)
+	dmfc2	t3, 0x024A
+	sd	t0, OCTEON_CP2_HSH_DATW+56(a0)
+	dmfc2	t0, 0x024B
+	sd	t1, OCTEON_CP2_HSH_DATW+64(a0)
+	dmfc2	t1, 0x024C
+	sd	t2, OCTEON_CP2_HSH_DATW+72(a0)
+	dmfc2	t2, 0x024D
+	sd	t3, OCTEON_CP2_HSH_DATW+80(a0)
+	dmfc2 	t3, 0x024E
+	sd	t0, OCTEON_CP2_HSH_DATW+88(a0)
+	dmfc2	t0, 0x0250
+	sd	t1, OCTEON_CP2_HSH_DATW+96(a0)
+	dmfc2	t1, 0x0251
+	sd	t2, OCTEON_CP2_HSH_DATW+104(a0)
+	dmfc2	t2, 0x0252
+	sd	t3, OCTEON_CP2_HSH_DATW+112(a0)
+	dmfc2	t3, 0x0253
+	sd	t0, OCTEON_CP2_HSH_IVW(a0)
+	dmfc2	t0, 0x0254
+	sd	t1, OCTEON_CP2_HSH_IVW+8(a0)
+	dmfc2	t1, 0x0255
+	sd	t2, OCTEON_CP2_HSH_IVW+16(a0)
+	dmfc2	t2, 0x0256
+	sd	t3, OCTEON_CP2_HSH_IVW+24(a0)
+	dmfc2	t3, 0x0257
+	sd	t0, OCTEON_CP2_HSH_IVW+32(a0)
+	dmfc2 	t0, 0x0258
+	sd	t1, OCTEON_CP2_HSH_IVW+40(a0)
+	dmfc2 	t1, 0x0259
+	sd	t2, OCTEON_CP2_HSH_IVW+48(a0)
+	dmfc2	t2, 0x025E
+	sd	t3, OCTEON_CP2_HSH_IVW+56(a0)
+	dmfc2	t3, 0x025A
+	sd	t0, OCTEON_CP2_GFM_MULT(a0)
+	dmfc2	t0, 0x025B
+	sd	t1, OCTEON_CP2_GFM_MULT+8(a0)
+	sd	t2, OCTEON_CP2_GFM_POLY(a0)
+	sd	t3, OCTEON_CP2_GFM_RESULT(a0)
+	sd	t0, OCTEON_CP2_GFM_RESULT+8(a0)
+	jr	ra
+
+2:      /* pass 1 special stuff when !CvmCtl[NOCRYPTO] */
+	dmfc2	t3, 0x0040
+	dmfc2	t0, 0x0041
+	dmfc2	t1, 0x0042
+	dmfc2	t2, 0x0043
+	sd	t3, OCTEON_CP2_HSH_DATW(a0)
+	dmfc2	t3, 0x0044
+	sd	t0, OCTEON_CP2_HSH_DATW+8(a0)
+	dmfc2	t0, 0x0045
+	sd	t1, OCTEON_CP2_HSH_DATW+16(a0)
+	dmfc2	t1, 0x0046
+	sd	t2, OCTEON_CP2_HSH_DATW+24(a0)
+	dmfc2	t2, 0x0048
+	sd	t3, OCTEON_CP2_HSH_DATW+32(a0)
+	dmfc2	t3, 0x0049
+	sd	t0, OCTEON_CP2_HSH_DATW+40(a0)
+	dmfc2	t0, 0x004A
+	sd	t1, OCTEON_CP2_HSH_DATW+48(a0)
+	sd	t2, OCTEON_CP2_HSH_IVW(a0)
+	sd	t3, OCTEON_CP2_HSH_IVW+8(a0)
+	sd	t0, OCTEON_CP2_HSH_IVW+16(a0)
+
+3:      /* pass 1 or CvmCtl[NOCRYPTO] set */
+	jr	ra
+	END(octeon_cop2_save)
+
+/*
+ * void octeon_cop2_restore(struct octeon_cop2_state *a0)
+ */
+	.align	7
+	.set push
+	.set noreorder
+	LEAF(octeon_cop2_restore)
+        /* First cache line was prefetched before the call */
+        pref    4,  128(a0)
+	dmfc0	t9, $9,7	/* CvmCtl register. */
+
+        pref    4,  256(a0)
+	ld	t0, OCTEON_CP2_CRC_IV(a0)
+        pref    4,  384(a0)
+	ld	t1, OCTEON_CP2_CRC_LENGTH(a0)
+	ld	t2, OCTEON_CP2_CRC_POLY(a0)
+
+	/* Restore the COP2 CRC state */
+	dmtc2	t0, 0x0201
+	dmtc2 	t1, 0x1202
+	bbit1	t9, 28, 2f	/* Skip LLM if CvmCtl[NODFA_CP2] is set */
+	 dmtc2	t2, 0x4200
+
+	/* Restore the LLM state */
+	ld	t0, OCTEON_CP2_LLM_DAT(a0)
+	ld	t1, OCTEON_CP2_LLM_DAT+8(a0)
+	dmtc2	t0, 0x0402
+	dmtc2	t1, 0x040A
+
+2:
+	bbit1	t9, 26, done_restore	/* done if CvmCtl[NOCRYPTO] set */
+	 nop
+
+	/* Restore the COP2 crypto state common to pass 1 and pass 2 */
+	ld	t0, OCTEON_CP2_3DES_IV(a0)
+	ld	t1, OCTEON_CP2_3DES_KEY(a0)
+	ld	t2, OCTEON_CP2_3DES_KEY+8(a0)
+	dmtc2 	t0, 0x0084
+	ld	t0, OCTEON_CP2_3DES_KEY+16(a0)
+	dmtc2 	t1, 0x0080
+	ld	t1, OCTEON_CP2_3DES_RESULT(a0)
+	dmtc2 	t2, 0x0081
+	ld	t2, OCTEON_CP2_AES_INP0(a0) /* only really needed for pass 1 */
+	dmtc2	t0, 0x0082
+	ld	t0, OCTEON_CP2_AES_IV(a0)
+	dmtc2 	t1, 0x0098
+	ld	t1, OCTEON_CP2_AES_IV+8(a0)
+	dmtc2 	t2, 0x010A                  /* only really needed for pass 1 */
+	ld	t2, OCTEON_CP2_AES_KEY(a0)
+	dmtc2 	t0, 0x0102
+	ld	t0, OCTEON_CP2_AES_KEY+8(a0)
+	dmtc2	t1, 0x0103
+	ld	t1, OCTEON_CP2_AES_KEY+16(a0)
+	dmtc2	t2, 0x0104
+	ld	t2, OCTEON_CP2_AES_KEY+24(a0)
+	dmtc2	t0, 0x0105
+	ld	t0, OCTEON_CP2_AES_KEYLEN(a0)
+	dmtc2	t1, 0x0106
+	ld	t1, OCTEON_CP2_AES_RESULT(a0)
+	dmtc2	t2, 0x0107
+	ld	t2, OCTEON_CP2_AES_RESULT+8(a0)
+	mfc0	t3, $15,0 	/* Get the processor ID register */
+	dmtc2	t0, 0x0110
+	li	t0, 0x000d0000	/* This is the processor ID of Octeon Pass1 */
+	dmtc2	t1, 0x0100
+	bne	t0, t3, 3f	/* Skip the next stuff for non-pass1 */
+	 dmtc2	t2, 0x0101
+
+        /* this code is specific for pass 1 */
+	ld	t0, OCTEON_CP2_HSH_DATW(a0)
+	ld	t1, OCTEON_CP2_HSH_DATW+8(a0)
+	ld	t2, OCTEON_CP2_HSH_DATW+16(a0)
+	dmtc2	t0, 0x0040
+	ld	t0, OCTEON_CP2_HSH_DATW+24(a0)
+	dmtc2	t1, 0x0041
+	ld	t1, OCTEON_CP2_HSH_DATW+32(a0)
+	dmtc2	t2, 0x0042
+	ld	t2, OCTEON_CP2_HSH_DATW+40(a0)
+	dmtc2	t0, 0x0043
+	ld	t0, OCTEON_CP2_HSH_DATW+48(a0)
+	dmtc2	t1, 0x0044
+	ld	t1, OCTEON_CP2_HSH_IVW(a0)
+	dmtc2	t2, 0x0045
+	ld	t2, OCTEON_CP2_HSH_IVW+8(a0)
+	dmtc2	t0, 0x0046
+	ld	t0, OCTEON_CP2_HSH_IVW+16(a0)
+	dmtc2	t1, 0x0048
+	dmtc2	t2, 0x0049
+        b done_restore   /* unconditional branch */
+	 dmtc2	t0, 0x004A
+
+3:      /* this is post-pass1 code */
+	ld	t2, OCTEON_CP2_HSH_DATW(a0)
+	ld	t0, OCTEON_CP2_HSH_DATW+8(a0)
+	ld	t1, OCTEON_CP2_HSH_DATW+16(a0)
+	dmtc2	t2, 0x0240
+	ld	t2, OCTEON_CP2_HSH_DATW+24(a0)
+	dmtc2	t0, 0x0241
+	ld	t0, OCTEON_CP2_HSH_DATW+32(a0)
+	dmtc2	t1, 0x0242
+	ld	t1, OCTEON_CP2_HSH_DATW+40(a0)
+	dmtc2	t2, 0x0243
+	ld	t2, OCTEON_CP2_HSH_DATW+48(a0)
+	dmtc2	t0, 0x0244
+	ld	t0, OCTEON_CP2_HSH_DATW+56(a0)
+	dmtc2	t1, 0x0245
+	ld	t1, OCTEON_CP2_HSH_DATW+64(a0)
+	dmtc2	t2, 0x0246
+	ld	t2, OCTEON_CP2_HSH_DATW+72(a0)
+	dmtc2	t0, 0x0247
+	ld	t0, OCTEON_CP2_HSH_DATW+80(a0)
+	dmtc2	t1, 0x0248
+	ld	t1, OCTEON_CP2_HSH_DATW+88(a0)
+	dmtc2	t2, 0x0249
+	ld	t2, OCTEON_CP2_HSH_DATW+96(a0)
+	dmtc2	t0, 0x024A
+	ld	t0, OCTEON_CP2_HSH_DATW+104(a0)
+	dmtc2	t1, 0x024B
+	ld	t1, OCTEON_CP2_HSH_DATW+112(a0)
+	dmtc2	t2, 0x024C
+	ld	t2, OCTEON_CP2_HSH_IVW(a0)
+	dmtc2	t0, 0x024D
+	ld	t0, OCTEON_CP2_HSH_IVW+8(a0)
+	dmtc2	t1, 0x024E
+	ld	t1, OCTEON_CP2_HSH_IVW+16(a0)
+	dmtc2	t2, 0x0250
+	ld	t2, OCTEON_CP2_HSH_IVW+24(a0)
+	dmtc2	t0, 0x0251
+	ld	t0, OCTEON_CP2_HSH_IVW+32(a0)
+	dmtc2	t1, 0x0252
+	ld	t1, OCTEON_CP2_HSH_IVW+40(a0)
+	dmtc2	t2, 0x0253
+	ld	t2, OCTEON_CP2_HSH_IVW+48(a0)
+	dmtc2	t0, 0x0254
+	ld	t0, OCTEON_CP2_HSH_IVW+56(a0)
+	dmtc2	t1, 0x0255
+	ld	t1, OCTEON_CP2_GFM_MULT(a0)
+	dmtc2	t2, 0x0256
+	ld	t2, OCTEON_CP2_GFM_MULT+8(a0)
+	dmtc2	t0, 0x0257
+	ld	t0, OCTEON_CP2_GFM_POLY(a0)
+	dmtc2	t1, 0x0258
+	ld	t1, OCTEON_CP2_GFM_RESULT(a0)
+	dmtc2	t2, 0x0259
+	ld	t2, OCTEON_CP2_GFM_RESULT+8(a0)
+	dmtc2	t0, 0x025E
+	dmtc2	t1, 0x025A
+	dmtc2	t2, 0x025B
+
+done_restore:
+	jr	ra
+	 nop
+	END(octeon_cop2_restore)
+	.set pop
+
+/*
+ * void octeon_mult_save()
+ * sp is assumed to point to a struct pt_regs
+ *
+ * NOTE: This is called in SAVE_SOME in stackframe.h. It can only
+ *       safely modify k0 and k1.
+ */
+	.align	7
+	.set push
+	.set noreorder
+	LEAF(octeon_mult_save)
+	dmfc0	k0, $9,7	/* CvmCtl register. */
+	bbit1	k0, 27, 1f	/* Skip CvmCtl[NOMUL] */
+	 nop
+
+	/* Save the multiplier state */
+	v3mulu	k0, $0, $0
+	v3mulu	k1, $0, $0
+	sd	k0, PT_MTP(sp)        /* PT_MTP    has P0 */
+	v3mulu	k0, $0, $0
+	sd	k1, PT_MTP+8(sp)      /* PT_MTP+8  has P1 */
+	ori	k1, $0, 1
+	v3mulu	k1, k1, $0
+	sd	k0, PT_MTP+16(sp)     /* PT_MTP+16 has P2 */
+	v3mulu	k0, $0, $0
+	sd	k1, PT_MPL(sp)        /* PT_MPL    has MPL0 */
+	v3mulu	k1, $0, $0
+	sd	k0, PT_MPL+8(sp)      /* PT_MPL+8  has MPL1 */
+	jr	ra
+	 sd	k1, PT_MPL+16(sp)     /* PT_MPL+16 has MPL2 */
+
+1:	/* Resume here if CvmCtl[NOMUL] */
+	jr	ra
+	END(octeon_mult_save)
+	.set pop
+
+/*
+ * void octeon_mult_restore()
+ * sp is assumed to point to a struct pt_regs
+ *
+ * NOTE: This is called in RESTORE_SOME in stackframe.h.
+ */
+	.align	7
+	.set push
+	.set noreorder
+	LEAF(octeon_mult_restore)
+	dmfc0	k1, $9,7		/* CvmCtl register. */
+	ld	v0, PT_MPL(sp)        	/* MPL0 */
+	ld	v1, PT_MPL+8(sp)      	/* MPL1 */
+	ld	k0, PT_MPL+16(sp)     	/* MPL2 */
+	bbit1	k1, 27, 1f		/* Skip CvmCtl[NOMUL] */
+	/* Normally falls through, so no time wasted here */
+	nop
+
+	/* Restore the multiplier state */
+	ld	k1, PT_MTP+16(sp)     	/* P2 */
+	MTM0	v0			/* MPL0 */
+	ld	v0, PT_MTP+8(sp)	/* P1 */
+	MTM1	v1			/* MPL1 */
+	ld	v1, PT_MTP(sp)   	/* P0 */
+	MTM2	k0			/* MPL2 */
+	MTP2	k1			/* P2 */
+	MTP1	v0			/* P1 */
+	jr	ra
+	 MTP0	v1			/* P0 */
+
+1:	/* Resume here if CvmCtl[NOMUL] */
+	jr	ra
+	 nop
+	END(octeon_mult_restore)
+	.set pop
+
-- 
1.5.6.5
