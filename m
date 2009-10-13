Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 20:46:45 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4618 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493321AbZJMSqh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2009 20:46:37 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ad4c63c0000>; Tue, 13 Oct 2009 11:26:09 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 13 Oct 2009 11:26:07 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 13 Oct 2009 11:26:07 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n9DIQ4Cj009013;
	Tue, 13 Oct 2009 11:26:05 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n9DIQ3rv009011;
	Tue, 13 Oct 2009 11:26:03 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Octeon: Use lockless interrupt controller operations when possible.
Date:	Tue, 13 Oct 2009 11:26:03 -0700
Message-Id: <1255458363-8987-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <20091013162018.GB27508@linux-mips.org>
References: <20091013162018.GB27508@linux-mips.org>
X-OriginalArrivalTime: 13 Oct 2009 18:26:07.0390 (UTC) FILETIME=[A16E0BE0:01CA4C32]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Some newer Octeon chips have registers that allow lockless operation
of the interrupt controller.  Take advantage of them.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---

This version gets rid of some redundant CONFIG_SMP code as noticed by Ralf.

 arch/mips/cavium-octeon/octeon-irq.c |  214 ++++++++++++++++++++++++++++------
 1 files changed, 178 insertions(+), 36 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 0bda5c5..6f2acf0 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -17,6 +17,15 @@ DEFINE_RWLOCK(octeon_irq_ciu0_rwlock);
 DEFINE_RWLOCK(octeon_irq_ciu1_rwlock);
 DEFINE_SPINLOCK(octeon_irq_msi_lock);
 
+static int octeon_coreid_for_cpu(int cpu)
+{
+#ifdef CONFIG_SMP
+	return cpu_logical_map(cpu);
+#else
+	return cvmx_get_core_num();
+#endif
+}
+
 static void octeon_irq_core_ack(unsigned int irq)
 {
 	unsigned int bit = irq - OCTEON_IRQ_SW0;
@@ -152,11 +161,10 @@ static void octeon_irq_ciu0_disable(unsigned int irq)
 	int bit = irq - OCTEON_IRQ_WORKQ0;	/* Bit 0-63 of EN0 */
 	unsigned long flags;
 	uint64_t en0;
-#ifdef CONFIG_SMP
 	int cpu;
 	write_lock_irqsave(&octeon_irq_ciu0_rwlock, flags);
 	for_each_online_cpu(cpu) {
-		int coreid = cpu_logical_map(cpu);
+		int coreid = octeon_coreid_for_cpu(cpu);
 		en0 = cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2));
 		en0 &= ~(1ull << bit);
 		cvmx_write_csr(CVMX_CIU_INTX_EN0(coreid * 2), en0);
@@ -167,15 +175,45 @@ static void octeon_irq_ciu0_disable(unsigned int irq)
 	 */
 	cvmx_read_csr(CVMX_CIU_INTX_EN0(cvmx_get_core_num() * 2));
 	write_unlock_irqrestore(&octeon_irq_ciu0_rwlock, flags);
-#else
-	int coreid = cvmx_get_core_num();
-	local_irq_save(flags);
-	en0 = cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2));
-	en0 &= ~(1ull << bit);
-	cvmx_write_csr(CVMX_CIU_INTX_EN0(coreid * 2), en0);
-	cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2));
-	local_irq_restore(flags);
-#endif
+}
+
+/*
+ * Enable the irq on the current core for chips that have the EN*_W1{S,C}
+ * registers.
+ */
+static void octeon_irq_ciu0_enable_v2(unsigned int irq)
+{
+	int index = cvmx_get_core_num() * 2;
+	u64 mask = 1ull << (irq - OCTEON_IRQ_WORKQ0);
+
+	cvmx_write_csr(CVMX_CIU_INTX_EN0_W1S(index), mask);
+}
+
+/*
+ * Disable the irq on the current core for chips that have the EN*_W1{S,C}
+ * registers.
+ */
+static void octeon_irq_ciu0_disable_v2(unsigned int irq)
+{
+	int index = cvmx_get_core_num() * 2;
+	u64 mask = 1ull << (irq - OCTEON_IRQ_WORKQ0);
+
+	cvmx_write_csr(CVMX_CIU_INTX_EN0_W1C(index), mask);
+}
+
+/*
+ * Disable the irq on the all cores for chips that have the EN*_W1{S,C}
+ * registers.
+ */
+static void octeon_irq_ciu0_disable_all_v2(unsigned int irq)
+{
+	u64 mask = 1ull << (irq - OCTEON_IRQ_WORKQ0);
+	int index;
+	int cpu;
+	for_each_online_cpu(cpu) {
+		index = octeon_coreid_for_cpu(cpu) * 2;
+		cvmx_write_csr(CVMX_CIU_INTX_EN0_W1C(index), mask);
+	}
 }
 
 #ifdef CONFIG_SMP
@@ -187,7 +225,7 @@ static int octeon_irq_ciu0_set_affinity(unsigned int irq, const struct cpumask *
 
 	write_lock_irqsave(&octeon_irq_ciu0_rwlock, flags);
 	for_each_online_cpu(cpu) {
-		int coreid = cpu_logical_map(cpu);
+		int coreid = octeon_coreid_for_cpu(cpu);
 		uint64_t en0 =
 			cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2));
 		if (cpumask_test_cpu(cpu, dest))
@@ -205,8 +243,42 @@ static int octeon_irq_ciu0_set_affinity(unsigned int irq, const struct cpumask *
 
 	return 0;
 }
+
+/*
+ * Set affinity for the irq for chips that have the EN*_W1{S,C}
+ * registers.
+ */
+static int octeon_irq_ciu0_set_affinity_v2(unsigned int irq,
+					   const struct cpumask *dest)
+{
+	int cpu;
+	int index;
+	u64 mask = 1ull << (irq - OCTEON_IRQ_WORKQ0);
+	for_each_online_cpu(cpu) {
+		index = octeon_coreid_for_cpu(cpu) * 2;
+		if (cpumask_test_cpu(cpu, dest))
+			cvmx_write_csr(CVMX_CIU_INTX_EN0_W1S(index), mask);
+		else
+			cvmx_write_csr(CVMX_CIU_INTX_EN0_W1C(index), mask);
+	}
+	return 0;
+}
 #endif
 
+/*
+ * Newer octeon chips have support for lockless CIU operation.
+ */
+static struct irq_chip octeon_irq_chip_ciu0_v2 = {
+	.name = "CIU0",
+	.enable = octeon_irq_ciu0_enable_v2,
+	.disable = octeon_irq_ciu0_disable_all_v2,
+	.ack = octeon_irq_ciu0_disable_v2,
+	.eoi = octeon_irq_ciu0_enable_v2,
+#ifdef CONFIG_SMP
+	.set_affinity = octeon_irq_ciu0_set_affinity_v2,
+#endif
+};
+
 static struct irq_chip octeon_irq_chip_ciu0 = {
 	.name = "CIU0",
 	.enable = octeon_irq_ciu0_enable,
@@ -270,11 +342,10 @@ static void octeon_irq_ciu1_disable(unsigned int irq)
 	int bit = irq - OCTEON_IRQ_WDOG0;	/* Bit 0-63 of EN1 */
 	unsigned long flags;
 	uint64_t en1;
-#ifdef CONFIG_SMP
 	int cpu;
 	write_lock_irqsave(&octeon_irq_ciu1_rwlock, flags);
 	for_each_online_cpu(cpu) {
-		int coreid = cpu_logical_map(cpu);
+		int coreid = octeon_coreid_for_cpu(cpu);
 		en1 = cvmx_read_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1));
 		en1 &= ~(1ull << bit);
 		cvmx_write_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1), en1);
@@ -285,19 +356,50 @@ static void octeon_irq_ciu1_disable(unsigned int irq)
 	 */
 	cvmx_read_csr(CVMX_CIU_INTX_EN1(cvmx_get_core_num() * 2 + 1));
 	write_unlock_irqrestore(&octeon_irq_ciu1_rwlock, flags);
-#else
-	int coreid = cvmx_get_core_num();
-	local_irq_save(flags);
-	en1 = cvmx_read_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1));
-	en1 &= ~(1ull << bit);
-	cvmx_write_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1), en1);
-	cvmx_read_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1));
-	local_irq_restore(flags);
-#endif
+}
+
+/*
+ * Enable the irq on the current core for chips that have the EN*_W1{S,C}
+ * registers.
+ */
+static void octeon_irq_ciu1_enable_v2(unsigned int irq)
+{
+	int index = cvmx_get_core_num() * 2 + 1;
+	u64 mask = 1ull << (irq - OCTEON_IRQ_WDOG0);
+
+	cvmx_write_csr(CVMX_CIU_INTX_EN1_W1S(index), mask);
+}
+
+/*
+ * Disable the irq on the current core for chips that have the EN*_W1{S,C}
+ * registers.
+ */
+static void octeon_irq_ciu1_disable_v2(unsigned int irq)
+{
+	int index = cvmx_get_core_num() * 2 + 1;
+	u64 mask = 1ull << (irq - OCTEON_IRQ_WDOG0);
+
+	cvmx_write_csr(CVMX_CIU_INTX_EN1_W1C(index), mask);
+}
+
+/*
+ * Disable the irq on the all cores for chips that have the EN*_W1{S,C}
+ * registers.
+ */
+static void octeon_irq_ciu1_disable_all_v2(unsigned int irq)
+{
+	u64 mask = 1ull << (irq - OCTEON_IRQ_WDOG0);
+	int index;
+	int cpu;
+	for_each_online_cpu(cpu) {
+		index = octeon_coreid_for_cpu(cpu) * 2 + 1;
+		cvmx_write_csr(CVMX_CIU_INTX_EN1_W1C(index), mask);
+	}
 }
 
 #ifdef CONFIG_SMP
-static int octeon_irq_ciu1_set_affinity(unsigned int irq, const struct cpumask *dest)
+static int octeon_irq_ciu1_set_affinity(unsigned int irq,
+					const struct cpumask *dest)
 {
 	int cpu;
 	unsigned long flags;
@@ -305,7 +407,7 @@ static int octeon_irq_ciu1_set_affinity(unsigned int irq, const struct cpumask *
 
 	write_lock_irqsave(&octeon_irq_ciu1_rwlock, flags);
 	for_each_online_cpu(cpu) {
-		int coreid = cpu_logical_map(cpu);
+		int coreid = octeon_coreid_for_cpu(cpu);
 		uint64_t en1 =
 			cvmx_read_csr(CVMX_CIU_INTX_EN1
 				(coreid * 2 + 1));
@@ -324,8 +426,42 @@ static int octeon_irq_ciu1_set_affinity(unsigned int irq, const struct cpumask *
 
 	return 0;
 }
+
+/*
+ * Set affinity for the irq for chips that have the EN*_W1{S,C}
+ * registers.
+ */
+static int octeon_irq_ciu1_set_affinity_v2(unsigned int irq,
+					   const struct cpumask *dest)
+{
+	int cpu;
+	int index;
+	u64 mask = 1ull << (irq - OCTEON_IRQ_WDOG0);
+	for_each_online_cpu(cpu) {
+		index = octeon_coreid_for_cpu(cpu) * 2 + 1;
+		if (cpumask_test_cpu(cpu, dest))
+			cvmx_write_csr(CVMX_CIU_INTX_EN1_W1S(index), mask);
+		else
+			cvmx_write_csr(CVMX_CIU_INTX_EN1_W1C(index), mask);
+	}
+	return 0;
+}
 #endif
 
+/*
+ * Newer octeon chips have support for lockless CIU operation.
+ */
+static struct irq_chip octeon_irq_chip_ciu1_v2 = {
+	.name = "CIU0",
+	.enable = octeon_irq_ciu1_enable_v2,
+	.disable = octeon_irq_ciu1_disable_all_v2,
+	.ack = octeon_irq_ciu1_disable_v2,
+	.eoi = octeon_irq_ciu1_enable_v2,
+#ifdef CONFIG_SMP
+	.set_affinity = octeon_irq_ciu1_set_affinity_v2,
+#endif
+};
+
 static struct irq_chip octeon_irq_chip_ciu1 = {
 	.name = "CIU1",
 	.enable = octeon_irq_ciu1_enable,
@@ -422,6 +558,8 @@ static struct irq_chip octeon_irq_chip_msi = {
 void __init arch_init_irq(void)
 {
 	int irq;
+	struct irq_chip *chip0;
+	struct irq_chip *chip1;
 
 #ifdef CONFIG_SMP
 	/* Set the default affinity to the boot cpu. */
@@ -432,6 +570,16 @@ void __init arch_init_irq(void)
 	if (NR_IRQS < OCTEON_IRQ_LAST)
 		pr_err("octeon_irq_init: NR_IRQS is set too low\n");
 
+	if (OCTEON_IS_MODEL(OCTEON_CN58XX_PASS2_X) ||
+	    OCTEON_IS_MODEL(OCTEON_CN56XX_PASS2_X) ||
+	    OCTEON_IS_MODEL(OCTEON_CN52XX_PASS2_X)) {
+		chip0 = &octeon_irq_chip_ciu0_v2;
+		chip1 = &octeon_irq_chip_ciu1_v2;
+	} else {
+		chip0 = &octeon_irq_chip_ciu0;
+		chip1 = &octeon_irq_chip_ciu1;
+	}
+
 	/* 0 - 15 reserved for i8259 master and slave controller. */
 
 	/* 17 - 23 Mips internal */
@@ -442,14 +590,12 @@ void __init arch_init_irq(void)
 
 	/* 24 - 87 CIU_INT_SUM0 */
 	for (irq = OCTEON_IRQ_WORKQ0; irq <= OCTEON_IRQ_BOOTDMA; irq++) {
-		set_irq_chip_and_handler(irq, &octeon_irq_chip_ciu0,
-					 handle_percpu_irq);
+		set_irq_chip_and_handler(irq, chip0, handle_percpu_irq);
 	}
 
 	/* 88 - 151 CIU_INT_SUM1 */
 	for (irq = OCTEON_IRQ_WDOG0; irq <= OCTEON_IRQ_RESERVED151; irq++) {
-		set_irq_chip_and_handler(irq, &octeon_irq_chip_ciu1,
-					 handle_percpu_irq);
+		set_irq_chip_and_handler(irq, chip1, handle_percpu_irq);
 	}
 
 #ifdef CONFIG_PCI_MSI
@@ -507,14 +653,10 @@ asmlinkage void plat_irq_dispatch(void)
 #ifdef CONFIG_HOTPLUG_CPU
 static int is_irq_enabled_on_cpu(unsigned int irq, unsigned int cpu)
 {
-       unsigned int isset;
-#ifdef CONFIG_SMP
-       int coreid = cpu_logical_map(cpu);
-#else
-	int coreid = cvmx_get_core_num();
-#endif
+	unsigned int isset;
+	int coreid = octeon_coreid_for_cpu(cpu);
 	int bit = (irq < OCTEON_IRQ_WDOG0) ?
-		irq - OCTEON_IRQ_WORKQ0 : irq - OCTEON_IRQ_WDOG0;
+		   irq - OCTEON_IRQ_WORKQ0 : irq - OCTEON_IRQ_WDOG0;
        if (irq < 64) {
 		isset = (cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2)) &
 			(1ull << bit)) >> bit;
-- 
1.6.0.6
