Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jun 2009 01:24:29 +0200 (CEST)
Received: from fw1-az.mvista.com ([65.200.49.156]:4921 "EHLO
	shomer.az.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by ftp.linux-mips.org with ESMTP id S1492156AbZFQXYY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 18 Jun 2009 01:24:24 +0200
Received: from shomer.az.mvista.com (localhost.localdomain [127.0.0.1])
	by shomer.az.mvista.com (8.14.2/8.14.2) with ESMTP id n5HNMrcx010753
	for <linux-mips@linux-mips.org>; Wed, 17 Jun 2009 16:22:53 -0700
Received: (from tsa@localhost)
	by shomer.az.mvista.com (8.14.2/8.14.2/Submit) id n5HNMrQY010752
	for linux-mips@linux-mips.org; Wed, 17 Jun 2009 16:22:53 -0700
Date:	Wed, 17 Jun 2009 16:22:53 -0700
From:	Tim Anderson <tanderson@mvista.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH 3/5] activate CMP support
Message-ID: <20090617232253.GD10714@shomer.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsa@shomer.az.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tanderson@mvista.com
Precedence: bulk
X-list: linux-mips

Most of the CMP support was added before, this
mostly correct compile problems but adds a platform
specific translation for the interrupt number based
on cpu number.

Signed-off-by: Tim Anderson <tanderson@mvista.com>
---
 arch/mips/Kconfig               |    2 +-
 arch/mips/include/asm/amon.h    |    7 ++++
 arch/mips/include/asm/gic.h     |    2 +
 arch/mips/kernel/smp-cmp.c      |   66 +++------------------------------------
 arch/mips/mti-malta/malta-int.c |   10 ++++++
 5 files changed, 25 insertions(+), 62 deletions(-)
 create mode 100644 arch/mips/include/asm/amon.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b29f028..7e8ecf6 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -209,7 +209,7 @@ config MIPS_MALTA
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_SUPPORTS_MIPS_CMP if BROKEN	# because SYNC_R4K is broken
+	select SYS_SUPPORTS_MIPS_CMP
 	select SYS_SUPPORTS_MULTITHREADING
 	select SYS_SUPPORTS_SMARTMIPS
 	help
diff --git a/arch/mips/include/asm/amon.h b/arch/mips/include/asm/amon.h
new file mode 100644
index 0000000..c3dc1a6
--- /dev/null
+++ b/arch/mips/include/asm/amon.h
@@ -0,0 +1,7 @@
+/*
+ * Amon support
+ */
+
+int amon_cpu_avail(int);
+void amon_cpu_start(int, unsigned long, unsigned long,
+		    unsigned long, unsigned long);
diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index e8fdd92..10292e3 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -487,5 +487,7 @@ extern void gic_init(unsigned long gic_base_addr,
 
 extern unsigned int gic_get_int(void);
 extern void gic_send_ipi(unsigned int intr);
+extern unsigned int plat_ipi_call_int_xlate(unsigned int);
+extern unsigned int plat_ipi_resched_int_xlate(unsigned int);
 
 #endif /* _ASM_GICREGS_H */
diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
index f27beca..8cf7e76 100644
--- a/arch/mips/kernel/smp-cmp.c
+++ b/arch/mips/kernel/smp-cmp.c
@@ -36,80 +36,24 @@
 #include <asm/mipsregs.h>
 #include <asm/mipsmtregs.h>
 #include <asm/mips_mt.h>
-
-/*
- * Crude manipulation of the CPU masks to control which
- * which CPU's are brought online during initialisation
- *
- * Beware... this needs to be called after CPU discovery
- * but before CPU bringup
- */
-static int __init allowcpus(char *str)
-{
-	cpumask_t cpu_allow_map;
-	char buf[256];
-	int len;
-
-	cpus_clear(cpu_allow_map);
-	if (cpulist_parse(str, &cpu_allow_map) == 0) {
-		cpu_set(0, cpu_allow_map);
-		cpus_and(cpu_possible_map, cpu_possible_map, cpu_allow_map);
-		len = cpulist_scnprintf(buf, sizeof(buf)-1, &cpu_possible_map);
-		buf[len] = '\0';
-		pr_debug("Allowable CPUs: %s\n", buf);
-		return 1;
-	} else
-		return 0;
-}
-__setup("allowcpus=", allowcpus);
+#include <asm/amon.h>
+#include <asm/gic.h>
 
 static void ipi_call_function(unsigned int cpu)
 {
-	unsigned int action = 0;
-
 	pr_debug("CPU%d: %s cpu %d status %08x\n",
 		 smp_processor_id(), __func__, cpu, read_c0_status());
 
-	switch (cpu) {
-	case 0:
-		action = GIC_IPI_EXT_INTR_CALLFNC_VPE0;
-		break;
-	case 1:
-		action = GIC_IPI_EXT_INTR_CALLFNC_VPE1;
-		break;
-	case 2:
-		action = GIC_IPI_EXT_INTR_CALLFNC_VPE2;
-		break;
-	case 3:
-		action = GIC_IPI_EXT_INTR_CALLFNC_VPE3;
-		break;
-	}
-	gic_send_ipi(action);
+	gic_send_ipi(plat_ipi_call_int_xlate(cpu));
 }
 
 
 static void ipi_resched(unsigned int cpu)
 {
-	unsigned int action = 0;
-
 	pr_debug("CPU%d: %s cpu %d status %08x\n",
 		 smp_processor_id(), __func__, cpu, read_c0_status());
 
-	switch (cpu) {
-	case 0:
-		action = GIC_IPI_EXT_INTR_RESCHED_VPE0;
-		break;
-	case 1:
-		action = GIC_IPI_EXT_INTR_RESCHED_VPE1;
-		break;
-	case 2:
-		action = GIC_IPI_EXT_INTR_RESCHED_VPE2;
-		break;
-	case 3:
-		action = GIC_IPI_EXT_INTR_RESCHED_VPE3;
-		break;
-	}
-	gic_send_ipi(action);
+	gic_send_ipi(plat_ipi_resched_int_xlate(cpu));
 }
 
 /*
@@ -205,7 +149,7 @@ static void cmp_boot_secondary(int cpu, struct task_struct *idle)
 			   (unsigned long)(gp + sizeof(struct thread_info)));
 #endif
 
-	amon_cpu_start(cpu, pc, sp, gp, a0);
+	amon_cpu_start(cpu, pc, sp, (unsigned long)gp, a0);
 }
 
 /*
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index 1c23548..44b23bf 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -335,6 +335,16 @@ static int gic_resched_int_base;
 static int gic_call_int_base;
 #define GIC_RESCHED_INT(cpu) (gic_resched_int_base+(cpu))
 #define GIC_CALL_INT(cpu) (gic_call_int_base+(cpu))
+
+unsigned int plat_ipi_call_int_xlate(unsigned int cpu)
+{
+	return GIC_CALL_INT(cpu);
+}
+
+unsigned int plat_ipi_resched_int_xlate(unsigned int cpu)
+{
+	return GIC_RESCHED_INT(cpu);
+}
 #endif /* CONFIG_MIPS_MT_SMP */
 
 static struct irqaction i8259irq = {
-- 
1.6.2.5.175.g7c84
