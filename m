Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2014 16:52:38 +0200 (CEST)
Received: from mail-bl2lp0205.outbound.protection.outlook.com ([207.46.163.205]:59443
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6855095AbaETOtcTmhLW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 May 2014 16:49:32 +0200
Received: from localhost.localdomain (46.78.192.208) by
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Tue, 20 May 2014 14:49:20 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     <linux-mips@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 10/15] MIPS: Add code for new system 'paravirt'.
Date:   Tue, 20 May 2014 16:47:11 +0200
Message-ID: <1400597236-11352-11-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [46.78.192.208]
X-ClientProxiedBy: AM3PR01CA004.eurprd01.prod.exchangelabs.com
 (10.242.240.14) To DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21)
X-Forefront-PRVS: 02176E2458
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6069001)(6009001)(428001)(22564002)(199002)(189002)(79102001)(36756003)(48376002)(66066001)(77982001)(92726001)(50466002)(74502001)(46102001)(64706001)(47776003)(80022001)(20776003)(50226001)(33646001)(101416001)(50986999)(76482001)(77156001)(89996001)(42186004)(81542001)(92566001)(62966002)(81342001)(87976001)(93916002)(87286001)(4396001)(19580395003)(83072002)(88136002)(85852003)(21056001)(76176999)(83322001)(31966008)(74662001)(86362001)(99396002)(102836001)(19580405001);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB398;H:localhost.localdomain;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreas.herrmann@caviumnetworks.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: David Daney <david.daney@cavium.com>

For para-virtualized guests running under KVM or other equivalent
hypervisor.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
---
 .../asm/mach-paravirt/cpu-feature-overrides.h      |   36 ++
 arch/mips/include/asm/mach-paravirt/irq.h          |   19 +
 .../include/asm/mach-paravirt/kernel-entry-init.h  |   49 +++
 arch/mips/include/asm/mach-paravirt/war.h          |   25 ++
 arch/mips/paravirt/Makefile                        |   14 +
 arch/mips/paravirt/Platform                        |    9 +
 arch/mips/paravirt/paravirt-irq.c                  |  388 ++++++++++++++++++++
 arch/mips/paravirt/paravirt-smp.c                  |  149 ++++++++
 arch/mips/paravirt/serial.c                        |   38 ++
 arch/mips/paravirt/setup.c                         |   60 +++
 10 files changed, 787 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-paravirt/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-paravirt/irq.h
 create mode 100644 arch/mips/include/asm/mach-paravirt/kernel-entry-init.h
 create mode 100644 arch/mips/include/asm/mach-paravirt/war.h
 create mode 100644 arch/mips/paravirt/Makefile
 create mode 100644 arch/mips/paravirt/Platform
 create mode 100644 arch/mips/paravirt/paravirt-irq.c
 create mode 100644 arch/mips/paravirt/paravirt-smp.c
 create mode 100644 arch/mips/paravirt/serial.c
 create mode 100644 arch/mips/paravirt/setup.c

diff --git a/arch/mips/include/asm/mach-paravirt/cpu-feature-overrides.h b/arch/mips/include/asm/mach-paravirt/cpu-feature-overrides.h
new file mode 100644
index 0000000..725e1ed
--- /dev/null
+++ b/arch/mips/include/asm/mach-paravirt/cpu-feature-overrides.h
@@ -0,0 +1,36 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2013 Cavium, Inc.
+ */
+#ifndef __ASM_MACH_PARAVIRT_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_PARAVIRT_CPU_FEATURE_OVERRIDES_H
+
+#define cpu_has_4kex		1
+#define cpu_has_3k_cache	0
+#define cpu_has_tx39_cache	0
+#define cpu_has_counter		1
+#define cpu_has_llsc		1
+/*
+ * We Disable LL/SC on non SMP systems as it is faster to disable
+ * interrupts for atomic access than a LL/SC.
+ */
+#ifdef CONFIG_SMP
+# define kernel_uses_llsc	1
+#else
+# define kernel_uses_llsc	0
+#endif
+
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+#define cpu_dcache_line_size()	128
+#define cpu_icache_line_size()	128
+#define cpu_has_octeon_cache	1
+#define cpu_has_4k_cache	0
+#else
+#define cpu_has_octeon_cache	0
+#define cpu_has_4k_cache	1
+#endif
+
+#endif /* __ASM_MACH_PARAVIRT_CPU_FEATURE_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-paravirt/irq.h b/arch/mips/include/asm/mach-paravirt/irq.h
new file mode 100644
index 0000000..9b4d35e
--- /dev/null
+++ b/arch/mips/include/asm/mach-paravirt/irq.h
@@ -0,0 +1,19 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2013 Cavium, Inc.
+ */
+#ifndef __ASM_MACH_PARAVIRT_IRQ_H__
+#define  __ASM_MACH_PARAVIRT_IRQ_H__
+
+#define NR_IRQS 64
+#define MIPS_CPU_IRQ_BASE 1
+
+#define MIPS_IRQ_PCIA (MIPS_CPU_IRQ_BASE + 8)
+
+#define MIPS_IRQ_MBOX0 (MIPS_CPU_IRQ_BASE + 32)
+#define MIPS_IRQ_MBOX1 (MIPS_CPU_IRQ_BASE + 33)
+
+#endif /* __ASM_MACH_PARAVIRT_IRQ_H__ */
diff --git a/arch/mips/include/asm/mach-paravirt/kernel-entry-init.h b/arch/mips/include/asm/mach-paravirt/kernel-entry-init.h
new file mode 100644
index 0000000..c812efa
--- /dev/null
+++ b/arch/mips/include/asm/mach-paravirt/kernel-entry-init.h
@@ -0,0 +1,49 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2013 Cavium, Inc
+ */
+#ifndef __ASM_MACH_PARAVIRT_KERNEL_ENTRY_H
+#define __ASM_MACH_PARAVIRT_KERNEL_ENTRY_H
+
+#define CP0_EBASE $15, 1
+
+	.macro  kernel_entry_setup
+	mfc0	t0, CP0_EBASE
+	andi	t0, t0, 0x3ff		# CPUNum
+	beqz	t0, 1f
+	# CPUs other than zero goto smp_bootstrap
+	j	smp_bootstrap
+
+1:
+	.endm
+
+/*
+ * Do SMP slave processor setup necessary before we can safely execute
+ * C code.
+ */
+	.macro  smp_slave_setup
+	mfc0	t0, CP0_EBASE
+	andi	t0, t0, 0x3ff		# CPUNum
+	slti	t1, t0, NR_CPUS
+	bnez	t1, 1f
+2:
+	di
+	wait
+	b	2b			# Unknown CPU, loop forever.
+1:
+	PTR_LA	t1, paravirt_smp_sp
+	PTR_SLL	t0, PTR_SCALESHIFT
+	PTR_ADDU t1, t1, t0
+3:
+	PTR_L	sp, 0(t1)
+	beqz	sp, 3b			# Spin until told to proceed.
+
+	PTR_LA	t1, paravirt_smp_gp
+	PTR_ADDU t1, t1, t0
+	PTR_L	gp, 0(t1)
+	.endm
+
+#endif /* __ASM_MACH_PARAVIRT_KERNEL_ENTRY_H */
diff --git a/arch/mips/include/asm/mach-paravirt/war.h b/arch/mips/include/asm/mach-paravirt/war.h
new file mode 100644
index 0000000..36d3afb
--- /dev/null
+++ b/arch/mips/include/asm/mach-paravirt/war.h
@@ -0,0 +1,25 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
+ * Copyright (C) 2013 Cavium Networks <support@caviumnetworks.com>
+ */
+#ifndef __ASM_MIPS_MACH_PARAVIRT_WAR_H
+#define __ASM_MIPS_MACH_PARAVIRT_WAR_H
+
+#define R4600_V1_INDEX_ICACHEOP_WAR	0
+#define R4600_V1_HIT_CACHEOP_WAR	0
+#define R4600_V2_HIT_CACHEOP_WAR	0
+#define R5432_CP0_INTERRUPT_WAR		0
+#define BCM1250_M3_WAR			0
+#define SIBYTE_1956_WAR			0
+#define MIPS4K_ICACHE_REFILL_WAR	0
+#define MIPS_CACHE_SYNC_WAR		0
+#define TX49XX_ICACHE_INDEX_INV_WAR	0
+#define ICACHE_REFILLS_WORKAROUND_WAR	0
+#define R10000_LLSC_WAR			0
+#define MIPS34K_MISSED_ITLB_WAR		0
+
+#endif /* __ASM_MIPS_MACH_PARAVIRT_WAR_H */
diff --git a/arch/mips/paravirt/Makefile b/arch/mips/paravirt/Makefile
new file mode 100644
index 0000000..5023af7
--- /dev/null
+++ b/arch/mips/paravirt/Makefile
@@ -0,0 +1,14 @@
+#
+# Makefile for MIPS para-virtualized specific kernel interface routines
+# under Linux.
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright (C) 2013 Cavium, Inc.
+#
+
+obj-y := setup.o serial.o paravirt-irq.o
+
+obj-$(CONFIG_SMP)		+= paravirt-smp.o
diff --git a/arch/mips/paravirt/Platform b/arch/mips/paravirt/Platform
new file mode 100644
index 0000000..c3901fa
--- /dev/null
+++ b/arch/mips/paravirt/Platform
@@ -0,0 +1,9 @@
+#
+# Generic para-virtualized guest.
+#
+platform-$(CONFIG_MIPS_PARAVIRT)	+= paravirt/
+cflags-$(CONFIG_MIPS_PARAVIRT)		+=				\
+		-I$(srctree)/arch/mips/include/asm/mach-paravirt
+
+load-$(CONFIG_MIPS_PARAVIRT)	= 0xffffffff80010000
+
diff --git a/arch/mips/paravirt/paravirt-irq.c b/arch/mips/paravirt/paravirt-irq.c
new file mode 100644
index 0000000..e1603dd
--- /dev/null
+++ b/arch/mips/paravirt/paravirt-irq.c
@@ -0,0 +1,388 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2013 Cavium, Inc.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/cpumask.h>
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+
+#include <asm/io.h>
+
+#define MBOX_BITS_PER_CPU 2
+
+int cpunum_for_cpu(int cpu)
+{
+#ifdef CONFIG_SMP
+	return cpu_logical_map(cpu);
+#else
+	return mips_cpunum();
+#endif
+}
+
+struct core_chip_data {
+	struct mutex core_irq_mutex;
+	bool current_en;
+	bool desired_en;
+	u8 bit;
+};
+
+static struct core_chip_data irq_core_chip_data[8];
+
+static void irq_core_ack(struct irq_data *data)
+{
+	struct core_chip_data *cd = irq_data_get_irq_chip_data(data);
+	unsigned int bit = cd->bit;
+
+	/*
+	 * We don't need to disable IRQs to make these atomic since
+	 * they are already disabled earlier in the low level
+	 * interrupt code.
+	 */
+	clear_c0_status(0x100 << bit);
+	/* The two user interrupts must be cleared manually. */
+	if (bit < 2)
+		clear_c0_cause(0x100 << bit);
+}
+
+static void irq_core_eoi(struct irq_data *data)
+{
+	struct core_chip_data *cd = irq_data_get_irq_chip_data(data);
+
+	/*
+	 * We don't need to disable IRQs to make these atomic since
+	 * they are already disabled earlier in the low level
+	 * interrupt code.
+	 */
+	set_c0_status(0x100 << cd->bit);
+}
+
+static void irq_core_set_enable_local(void *arg)
+{
+	struct irq_data *data = arg;
+	struct core_chip_data *cd = irq_data_get_irq_chip_data(data);
+	unsigned int mask = 0x100 << cd->bit;
+
+	/*
+	 * Interrupts are already disabled, so these are atomic.
+	 */
+	if (cd->desired_en)
+		set_c0_status(mask);
+	else
+		clear_c0_status(mask);
+
+}
+
+static void irq_core_disable(struct irq_data *data)
+{
+	struct core_chip_data *cd = irq_data_get_irq_chip_data(data);
+	cd->desired_en = false;
+}
+
+static void irq_core_enable(struct irq_data *data)
+{
+	struct core_chip_data *cd = irq_data_get_irq_chip_data(data);
+	cd->desired_en = true;
+}
+
+static void irq_core_bus_lock(struct irq_data *data)
+{
+	struct core_chip_data *cd = irq_data_get_irq_chip_data(data);
+
+	mutex_lock(&cd->core_irq_mutex);
+}
+
+static void irq_core_bus_sync_unlock(struct irq_data *data)
+{
+	struct core_chip_data *cd = irq_data_get_irq_chip_data(data);
+
+	if (cd->desired_en != cd->current_en) {
+		/*
+		 * Can be called in early init when on_each_cpu() will
+		 * unconditionally enable irqs, so handle the case
+		 * where only a single CPU is online specially, and
+		 * directly call.
+		 */
+		if (num_online_cpus() == 1)
+			irq_core_set_enable_local(data);
+		else
+			on_each_cpu(irq_core_set_enable_local, data, 1);
+
+		cd->current_en = cd->desired_en;
+	}
+
+	mutex_unlock(&cd->core_irq_mutex);
+}
+
+static struct irq_chip irq_chip_core = {
+	.name = "Core",
+	.irq_enable = irq_core_enable,
+	.irq_disable = irq_core_disable,
+	.irq_ack = irq_core_ack,
+	.irq_eoi = irq_core_eoi,
+	.irq_bus_lock = irq_core_bus_lock,
+	.irq_bus_sync_unlock = irq_core_bus_sync_unlock,
+
+	.irq_cpu_online = irq_core_eoi,
+	.irq_cpu_offline = irq_core_ack,
+	.flags = IRQCHIP_ONOFFLINE_ENABLED,
+};
+
+static void __init irq_init_core(void)
+{
+	int i;
+	int irq;
+	struct core_chip_data *cd;
+
+	/* Start with a clean slate */
+	clear_c0_status(ST0_IM);
+	clear_c0_cause(CAUSEF_IP0 | CAUSEF_IP1);
+
+	for (i = 0; i < ARRAY_SIZE(irq_core_chip_data); i++) {
+		cd = irq_core_chip_data + i;
+		cd->current_en = false;
+		cd->desired_en = false;
+		cd->bit = i;
+		mutex_init(&cd->core_irq_mutex);
+
+		irq = MIPS_CPU_IRQ_BASE + i;
+
+		switch (i) {
+		case 0: /* SW0 */
+		case 1: /* SW1 */
+		case 5: /* IP5 */
+		case 6: /* IP6 */
+		case 7: /* IP7 */
+			irq_set_chip_data(irq, cd);
+			irq_set_chip_and_handler(irq, &irq_chip_core,
+						 handle_percpu_irq);
+			break;
+		default:
+			irq_reserve_irq(irq);
+		}
+	}
+}
+
+static void __iomem *mips_irq_chip;
+#define MIPS_IRQ_CHIP_NUM_BITS 0
+#define MIPS_IRQ_CHIP_REGS 8
+
+static int mips_irq_cpu_stride;
+static int mips_irq_chip_reg_raw;
+static int mips_irq_chip_reg_src;
+static int mips_irq_chip_reg_en;
+static int mips_irq_chip_reg_raw_w1s;
+static int mips_irq_chip_reg_raw_w1c;
+static int mips_irq_chip_reg_en_w1s;
+static int mips_irq_chip_reg_en_w1c;
+
+static void irq_pci_enable(struct irq_data *data)
+{
+	u32 mask = 1u << data->irq;
+
+	__raw_writel(mask, mips_irq_chip + mips_irq_chip_reg_en_w1s);
+}
+
+static void irq_pci_disable(struct irq_data *data)
+{
+	u32 mask = 1u << data->irq;
+
+	__raw_writel(mask, mips_irq_chip + mips_irq_chip_reg_en_w1c);
+}
+
+static void irq_pci_ack(struct irq_data *data)
+{
+}
+
+static void irq_pci_mask(struct irq_data *data)
+{
+	u32 mask = 1u << data->irq;
+
+	__raw_writel(mask, mips_irq_chip + mips_irq_chip_reg_en_w1c);
+}
+
+static void irq_pci_unmask(struct irq_data *data)
+{
+	u32 mask = 1u << data->irq;
+
+	__raw_writel(mask, mips_irq_chip + mips_irq_chip_reg_en_w1s);
+}
+
+static int irq_pci_set_affinity(struct irq_data *data, const struct cpumask *dest, bool force)
+{
+	return 0;
+}
+
+static void irq_pci_cpu_offline(struct irq_data *data)
+{
+}
+
+static struct irq_chip irq_chip_pci = {
+	.name = "PCI",
+	.irq_enable = irq_pci_enable,
+	.irq_disable = irq_pci_disable,
+	.irq_ack = irq_pci_ack,
+	.irq_mask = irq_pci_mask,
+	.irq_unmask = irq_pci_unmask,
+	.irq_set_affinity = irq_pci_set_affinity,
+	.irq_cpu_offline = irq_pci_cpu_offline,
+};
+
+static void irq_mbox_all(struct irq_data *data,  void __iomem *base)
+{
+	int cpu;
+	unsigned int mbox = data->irq - MIPS_IRQ_MBOX0;
+	u32 mask;
+
+	WARN_ON(mbox >= MBOX_BITS_PER_CPU);
+
+	for_each_online_cpu(cpu) {
+		unsigned int cpuid = cpunum_for_cpu(cpu);
+		mask = 1 << (cpuid * MBOX_BITS_PER_CPU + mbox);
+		__raw_writel(mask, base + (cpuid * mips_irq_cpu_stride));
+	}
+}
+
+static void irq_mbox_enable(struct irq_data *data)
+{
+	irq_mbox_all(data, mips_irq_chip + mips_irq_chip_reg_en_w1s + sizeof(u32));
+}
+
+static void irq_mbox_disable(struct irq_data *data)
+{
+	irq_mbox_all(data, mips_irq_chip + mips_irq_chip_reg_en_w1c + sizeof(u32));
+}
+
+static void irq_mbox_ack(struct irq_data *data)
+{
+	u32 mask;
+	unsigned int mbox = data->irq - MIPS_IRQ_MBOX0;
+
+	WARN_ON(mbox >= MBOX_BITS_PER_CPU);
+
+	mask = 1 << (mips_cpunum() * MBOX_BITS_PER_CPU + mbox);
+	__raw_writel(mask, mips_irq_chip + mips_irq_chip_reg_raw_w1c + sizeof(u32));
+}
+
+void irq_mbox_ipi(int cpu, unsigned int actions)
+{
+	unsigned int cpuid = cpunum_for_cpu(cpu);
+	u32 mask;
+
+	WARN_ON(actions >= (1 << MBOX_BITS_PER_CPU));
+
+	mask = actions << (cpuid * MBOX_BITS_PER_CPU);
+	__raw_writel(mask, mips_irq_chip + mips_irq_chip_reg_raw_w1s + sizeof(u32));
+}
+
+static void irq_mbox_cpu_onoffline(struct irq_data *data,  void __iomem *base)
+{
+	unsigned int mbox = data->irq - MIPS_IRQ_MBOX0;
+	unsigned int cpuid = mips_cpunum();
+	u32 mask;
+
+	WARN_ON(mbox >= MBOX_BITS_PER_CPU);
+
+	mask = 1 << (cpuid * MBOX_BITS_PER_CPU + mbox);
+	__raw_writel(mask, base + (cpuid * mips_irq_cpu_stride));
+
+}
+
+static void irq_mbox_cpu_online(struct irq_data *data)
+{
+	irq_mbox_cpu_onoffline(data, mips_irq_chip + mips_irq_chip_reg_en_w1s + sizeof(u32));
+}
+
+static void irq_mbox_cpu_offline(struct irq_data *data)
+{
+	irq_mbox_cpu_onoffline(data, mips_irq_chip + mips_irq_chip_reg_en_w1c + sizeof(u32));
+}
+
+static struct irq_chip irq_chip_mbox = {
+	.name = "MBOX",
+	.irq_enable = irq_mbox_enable,
+	.irq_disable = irq_mbox_disable,
+	.irq_ack = irq_mbox_ack,
+	.irq_cpu_online = irq_mbox_cpu_online,
+	.irq_cpu_offline = irq_mbox_cpu_offline,
+	.flags = IRQCHIP_ONOFFLINE_ENABLED,
+};
+
+static void __init irq_pci_init(void)
+{
+	int i, stride;
+	u32 num_bits;
+
+	mips_irq_chip = ioremap(0x1e010000, 4096);
+
+	num_bits = __raw_readl(mips_irq_chip + MIPS_IRQ_CHIP_NUM_BITS);
+	stride = 8 * (1 + ((num_bits - 1) / 64));
+
+
+	pr_notice("mips_irq_chip: %u bits, reg stride: %d\n", num_bits, stride);
+	mips_irq_chip_reg_raw		= MIPS_IRQ_CHIP_REGS + 0 * stride;
+	mips_irq_chip_reg_raw_w1s	= MIPS_IRQ_CHIP_REGS + 1 * stride;
+	mips_irq_chip_reg_raw_w1c	= MIPS_IRQ_CHIP_REGS + 2 * stride;
+	mips_irq_chip_reg_src		= MIPS_IRQ_CHIP_REGS + 3 * stride;
+	mips_irq_chip_reg_en		= MIPS_IRQ_CHIP_REGS + 4 * stride;
+	mips_irq_chip_reg_en_w1s	= MIPS_IRQ_CHIP_REGS + 5 * stride;
+	mips_irq_chip_reg_en_w1c	= MIPS_IRQ_CHIP_REGS + 6 * stride;
+	mips_irq_cpu_stride		= stride * 4;
+
+	for (i = 0; i < 4; i++)
+		irq_set_chip_and_handler(i + MIPS_IRQ_PCIA, &irq_chip_pci, handle_level_irq);
+
+	for (i = 0; i < 2; i++)
+		irq_set_chip_and_handler(i + MIPS_IRQ_MBOX0, &irq_chip_mbox, handle_percpu_irq);
+
+
+	set_c0_status(STATUSF_IP2);
+}
+
+static void irq_pci_dispatch(void)
+{
+	unsigned int cpuid = mips_cpunum();
+
+	u32 en = __raw_readl(mips_irq_chip + mips_irq_chip_reg_src + (cpuid * mips_irq_cpu_stride));
+
+	if (!en) {
+		en = __raw_readl(mips_irq_chip + mips_irq_chip_reg_src + (cpuid * mips_irq_cpu_stride) + sizeof(u32));
+		en = (en >> (2 * cpuid)) & 3;
+
+		if (!en)
+			spurious_interrupt();
+		else
+			do_IRQ(__ffs(en) + MIPS_IRQ_MBOX0);	/* MBOX type */
+	} else {
+		do_IRQ(__ffs(en));
+	}
+}
+
+
+void __init arch_init_irq(void)
+{
+	irq_init_core();
+	irq_pci_init();
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
+	int ip;
+
+	if (unlikely(!pending)) {
+		spurious_interrupt();
+		return;
+	}
+
+	ip = ffs(pending) - 1 - STATUSB_IP0;
+	if (ip == 2)
+		irq_pci_dispatch();
+	else
+		do_IRQ(MIPS_CPU_IRQ_BASE + ip);
+}
+
diff --git a/arch/mips/paravirt/paravirt-smp.c b/arch/mips/paravirt/paravirt-smp.c
new file mode 100644
index 0000000..52f86eb
--- /dev/null
+++ b/arch/mips/paravirt/paravirt-smp.c
@@ -0,0 +1,149 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2013 Cavium, Inc.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/cpumask.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+
+#include <asm/mipsregs.h>
+#include <asm/setup.h>
+#include <asm/time.h>
+#include <asm/smp.h>
+
+/*
+ * Writing the sp releases the CPU, so writes must be ordered, gp
+ * first, then sp.
+ */
+unsigned long paravirt_smp_sp[NR_CPUS];
+unsigned long paravirt_smp_gp[NR_CPUS];
+
+static int numcpus = 1;
+
+static int __init set_numcpus(char *str)
+{
+	int newval;
+
+	if (get_option(&str, &newval)) {
+		if (newval < 1 || newval >= NR_CPUS)
+			goto bad;
+		numcpus = newval;
+		return 0;
+	}
+bad:
+	return -EINVAL;
+}
+early_param("numcpus", set_numcpus);
+
+
+static void paravirt_smp_setup(void)
+{
+	int id;
+	unsigned int cpunum = mips_cpunum();
+
+	if (WARN_ON(cpunum >= NR_CPUS))
+		return;
+
+	/* The present CPUs are initially just the boot cpu (CPU 0). */
+	for (id = 0; id < NR_CPUS; id++) {
+		set_cpu_possible(id, id == 0);
+		set_cpu_present(id, id == 0);
+	}
+	__cpu_number_map[cpunum] = 0;
+	__cpu_logical_map[0] = cpunum;
+
+	for (id = 0; id < numcpus; id++) {
+		set_cpu_possible(id, true);
+		set_cpu_present(id, true);
+		__cpu_number_map[id] = id;
+		__cpu_logical_map[id] = id;
+	}
+}
+
+void irq_mbox_ipi(int cpu, unsigned int actions);
+static void paravirt_send_ipi_single(int cpu, unsigned int action)
+{
+	irq_mbox_ipi(cpu, action);
+}
+
+static void paravirt_send_ipi_mask(const struct cpumask *mask, unsigned int action)
+{
+	unsigned int cpu;
+
+	for_each_cpu_mask(cpu, *mask)
+		paravirt_send_ipi_single(cpu, action);
+}
+
+static void paravirt_init_secondary(void)
+{
+	unsigned int sr;
+
+	sr = set_c0_status(ST0_BEV);
+	write_c0_ebase((u32)ebase);
+
+	sr |= STATUSF_IP2; /* Interrupt controller on IP2 */
+	write_c0_status(sr);
+
+	irq_cpu_online();
+}
+
+static void paravirt_smp_finish(void)
+{
+	/* to generate the first CPU timer interrupt */
+	write_c0_compare(read_c0_count() + mips_hpt_frequency / HZ);
+	local_irq_enable();
+}
+
+static void paravirt_cpus_done(void)
+{
+}
+
+static void paravirt_boot_secondary(int cpu, struct task_struct *idle)
+{
+	paravirt_smp_gp[cpu] = (unsigned long)(task_thread_info(idle));
+	wmb();
+	paravirt_smp_sp[cpu] = __KSTK_TOS(idle);
+	mb();
+}
+
+static irqreturn_t paravirt_reched_interrupt(int irq, void *dev_id)
+{
+	scheduler_ipi();
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t paravirt_function_interrupt(int irq, void *dev_id)
+{
+	smp_call_function_interrupt();
+	return IRQ_HANDLED;
+}
+
+static void paravirt_prepare_cpus(unsigned int max_cpus)
+{
+	if (request_irq(MIPS_IRQ_MBOX0, paravirt_reched_interrupt,
+			IRQF_PERCPU | IRQF_NO_THREAD, "Scheduler",
+			paravirt_reched_interrupt)) {
+		panic("Cannot request_irq for SchedulerIPI");
+	}
+	if (request_irq(MIPS_IRQ_MBOX1, paravirt_function_interrupt,
+			IRQF_PERCPU | IRQF_NO_THREAD, "SMP-Call",
+			paravirt_function_interrupt)) {
+		panic("Cannot request_irq for SMP-Call");
+	}
+}
+
+struct plat_smp_ops paravirt_smp_ops = {
+	.send_ipi_single	= paravirt_send_ipi_single,
+	.send_ipi_mask		= paravirt_send_ipi_mask,
+	.init_secondary		= paravirt_init_secondary,
+	.smp_finish		= paravirt_smp_finish,
+	.cpus_done		= paravirt_cpus_done,
+	.boot_secondary		= paravirt_boot_secondary,
+	.smp_setup		= paravirt_smp_setup,
+	.prepare_cpus		= paravirt_prepare_cpus,
+};
diff --git a/arch/mips/paravirt/serial.c b/arch/mips/paravirt/serial.c
new file mode 100644
index 0000000..e3f98b2
--- /dev/null
+++ b/arch/mips/paravirt/serial.c
@@ -0,0 +1,38 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2013 Cavium, Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/virtio_console.h>
+
+#include <asm/mipsregs.h>
+
+/*
+ * Emit one character to the boot console.
+ */
+int prom_putchar(char c)
+{
+	hypcall3(0 /* Console output */, 0 /*  port 0 */, (unsigned long)&c, 1 /* len == 1 */);
+
+	return 1;
+}
+
+#ifdef CONFIG_VIRTIO_CONSOLE
+static int paravirt_put_chars(u32 vtermno, const char *buf, int count)
+{
+	hypcall3(0 /* Console output */, vtermno, (unsigned long)buf, count);
+	return count;
+}
+
+static int __init paravirt_cons_init(void)
+{
+	virtio_cons_early_init(paravirt_put_chars);
+	return 0;
+}
+core_initcall(paravirt_cons_init);
+
+#endif
diff --git a/arch/mips/paravirt/setup.c b/arch/mips/paravirt/setup.c
new file mode 100644
index 0000000..f80c3bc
--- /dev/null
+++ b/arch/mips/paravirt/setup.c
@@ -0,0 +1,60 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2013 Cavium, Inc.
+ */
+
+#include <linux/kernel.h>
+
+#include <asm/bootinfo.h>
+#include <asm/mipsregs.h>
+#include <asm/smp-ops.h>
+#include <asm/time.h>
+
+extern struct plat_smp_ops paravirt_smp_ops;
+
+const char *get_system_type(void)
+{
+	return "MIPS Para-Virtualized Guest";
+}
+
+void __init plat_time_init(void)
+{
+	mips_hpt_frequency = hypcall0(2 /* get cp0 clock freq. */);
+
+	preset_lpj = mips_hpt_frequency / (2 * HZ);
+}
+
+/*
+ * Early entry point for arch setup
+ */
+void __init prom_init(void)
+{
+	int i;
+	int argc = fw_arg0;
+	char **argv = (char **)fw_arg1;
+
+#ifdef CONFIG_32BIT
+	set_io_port_base(KSEG1ADDR(0x1e000000));
+#else /* CONFIG_64BIT */
+	set_io_port_base(PHYS_TO_XKSEG_UNCACHED(0x1e000000));
+#endif
+
+	for (i = 0; i < argc; i++) {
+		strlcat(arcs_cmdline, argv[i], COMMAND_LINE_SIZE);
+		if (i < argc - 1)
+			strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
+	}
+	register_smp_ops(&paravirt_smp_ops);
+}
+
+void __init plat_mem_setup(void)
+{
+	/* Do nothing, the "mem=???" parser handles our memory. */
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
-- 
1.7.9.5
