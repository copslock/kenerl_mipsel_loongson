Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 11:34:26 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:10834 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827345AbaAOKeNcWWdJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 11:34:13 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 05/15] MIPS: move GIC IPI functions out of smp-cmp.c
Date:   Wed, 15 Jan 2014 10:31:50 +0000
Message-ID: <1389781920-31151-6-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
References: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_15_10_34_08
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The GIC IPI functions aren't necessarily specific to the "CMP
framework" SMP implementation, and will be used elsewhere in a
subsequent commit. This patch adds cleaned up GIC IPI functions to a
separate file which is compiled when a new CONFIG_MIPS_GIC_IPI Kconfig
symbol is selected, and selects that symbol for CONFIG_MIPS_CMP.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/Kconfig               |  4 ++++
 arch/mips/include/asm/smp-ops.h |  3 +++
 arch/mips/kernel/Makefile       |  1 +
 arch/mips/kernel/smp-cmp.c      | 52 ++--------------------------------------
 arch/mips/kernel/smp-gic.c      | 53 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 63 insertions(+), 50 deletions(-)
 create mode 100644 arch/mips/kernel/smp-gic.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 868a1a5..e40c255 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1977,12 +1977,16 @@ config MIPS_VPE_APSP_API_MT
 config MIPS_CMP
 	bool "MIPS CMP support"
 	depends on SYS_SUPPORTS_MIPS_CMP && MIPS_MT_SMP
+	select MIPS_GIC_IPI
 	select SYNC_R4K
 	select WEAK_ORDERING
 	default n
 	help
 	  Enable Coherency Manager processor (CMP) support.
 
+config MIPS_GIC_IPI
+	bool
+
 config SB1_PASS_1_WORKAROUNDS
 	bool
 	depends on CPU_SB1_PASS_1
diff --git a/arch/mips/include/asm/smp-ops.h b/arch/mips/include/asm/smp-ops.h
index ef2a804..51458bb 100644
--- a/arch/mips/include/asm/smp-ops.h
+++ b/arch/mips/include/asm/smp-ops.h
@@ -58,6 +58,9 @@ static inline void register_smp_ops(struct plat_smp_ops *ops)
 
 #endif /* !CONFIG_SMP */
 
+extern void gic_send_ipi_single(int cpu, unsigned int action);
+extern void gic_send_ipi_mask(const struct cpumask *mask, unsigned int action);
+
 static inline int register_up_smp_ops(void)
 {
 #ifdef CONFIG_SMP_UP
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 26c6175..786a51d 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_MIPS_MT_FPAFF)	+= mips-mt-fpaff.o
 obj-$(CONFIG_MIPS_MT_SMTC)	+= smtc.o smtc-asm.o smtc-proc.o
 obj-$(CONFIG_MIPS_MT_SMP)	+= smp-mt.o
 obj-$(CONFIG_MIPS_CMP)		+= smp-cmp.o
+obj-$(CONFIG_MIPS_GIC_IPI)	+= smp-gic.o
 obj-$(CONFIG_CPU_MIPSR2)	+= spram.o
 
 obj-$(CONFIG_MIPS_VPE_LOADER)	+= vpe.o
diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
index 1b925d8..594660e 100644
--- a/arch/mips/kernel/smp-cmp.c
+++ b/arch/mips/kernel/smp-cmp.c
@@ -39,54 +39,6 @@
 #include <asm/amon.h>
 #include <asm/gic.h>
 
-static void ipi_call_function(unsigned int cpu)
-{
-	pr_debug("CPU%d: %s cpu %d status %08x\n",
-		 smp_processor_id(), __func__, cpu, read_c0_status());
-
-	gic_send_ipi(plat_ipi_call_int_xlate(cpu));
-}
-
-
-static void ipi_resched(unsigned int cpu)
-{
-	pr_debug("CPU%d: %s cpu %d status %08x\n",
-		 smp_processor_id(), __func__, cpu, read_c0_status());
-
-	gic_send_ipi(plat_ipi_resched_int_xlate(cpu));
-}
-
-/*
- * FIXME: This isn't restricted to CMP
- * The SMVP kernel could use GIC interrupts if available
- */
-void cmp_send_ipi_single(int cpu, unsigned int action)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-
-	switch (action) {
-	case SMP_CALL_FUNCTION:
-		ipi_call_function(cpu);
-		break;
-
-	case SMP_RESCHEDULE_YOURSELF:
-		ipi_resched(cpu);
-		break;
-	}
-
-	local_irq_restore(flags);
-}
-
-static void cmp_send_ipi_mask(const struct cpumask *mask, unsigned int action)
-{
-	unsigned int i;
-
-	for_each_cpu(i, mask)
-		cmp_send_ipi_single(i, action);
-}
-
 static void cmp_init_secondary(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
@@ -210,8 +162,8 @@ void __init cmp_prepare_cpus(unsigned int max_cpus)
 }
 
 struct plat_smp_ops cmp_smp_ops = {
-	.send_ipi_single	= cmp_send_ipi_single,
-	.send_ipi_mask		= cmp_send_ipi_mask,
+	.send_ipi_single	= gic_send_ipi_single,
+	.send_ipi_mask		= gic_send_ipi_mask,
 	.init_secondary		= cmp_init_secondary,
 	.smp_finish		= cmp_smp_finish,
 	.cpus_done		= cmp_cpus_done,
diff --git a/arch/mips/kernel/smp-gic.c b/arch/mips/kernel/smp-gic.c
new file mode 100644
index 0000000..3bb1f92
--- /dev/null
+++ b/arch/mips/kernel/smp-gic.c
@@ -0,0 +1,53 @@
+/*
+ * Copyright (C) 2013 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * Based on smp-cmp.c:
+ *  Copyright (C) 2007 MIPS Technologies, Inc.
+ *  Author: Chris Dearman (chris@mips.com)
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/printk.h>
+
+#include <asm/gic.h>
+#include <asm/smp-ops.h>
+
+void gic_send_ipi_single(int cpu, unsigned int action)
+{
+	unsigned long flags;
+	unsigned int intr;
+
+	pr_debug("CPU%d: %s cpu %d action %u status %08x\n",
+		 smp_processor_id(), __func__, cpu, action, read_c0_status());
+
+	local_irq_save(flags);
+
+	switch (action) {
+	case SMP_CALL_FUNCTION:
+		intr = plat_ipi_call_int_xlate(cpu);
+		break;
+
+	case SMP_RESCHEDULE_YOURSELF:
+		intr = plat_ipi_resched_int_xlate(cpu);
+		break;
+
+	default:
+		BUG();
+	}
+
+	gic_send_ipi(intr);
+	local_irq_restore(flags);
+}
+
+void gic_send_ipi_mask(const struct cpumask *mask, unsigned int action)
+{
+	unsigned int i;
+
+	for_each_cpu(i, mask)
+		gic_send_ipi_single(i, action);
+}
-- 
1.8.4.2
