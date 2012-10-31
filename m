Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 14:01:24 +0100 (CET)
Received: from mms1.broadcom.com ([216.31.210.17]:2573 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825875Ab2JaM6ve4bZ2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 Oct 2012 13:58:51 +0100
Received: from [10.9.200.133] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 31 Oct 2012 05:57:33 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Wed, 31 Oct 2012 05:58:11 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 6D42440FE3; Wed, 31
 Oct 2012 05:58:39 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 11/15] MIPS: Netlogic: Move from u32 cpumask to
 cpumask_t
Date:   Wed, 31 Oct 2012 18:31:37 +0530
Message-ID: <6d9a5a673f67ac25424121c2fa63d4714556e445.1351688140.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1351688140.git.jchandra@broadcom.com>
References: <cover.1351688140.git.jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7C8FFFB72102191074-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 34803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Initial code to support more than 32 cpus. The platform CPU mask
is updated from 32-bit mask to cpumask_t. Convert places that use
cpu_/cpus_ functions to use cpumask_* functions.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/common.h |    7 ++-
 arch/mips/netlogic/common/smp.c         |   39 ++++++++--------
 arch/mips/netlogic/xlp/setup.c          |    6 ++-
 arch/mips/netlogic/xlp/wakeup.c         |   77 ++++++++++++++++++++-----------
 arch/mips/netlogic/xlr/setup.c          |   10 ++--
 arch/mips/netlogic/xlr/wakeup.c         |    2 +-
 6 files changed, 86 insertions(+), 55 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/common.h b/arch/mips/include/asm/netlogic/common.h
index fdd2f44..fd735bc 100644
--- a/arch/mips/include/asm/netlogic/common.h
+++ b/arch/mips/include/asm/netlogic/common.h
@@ -45,6 +45,8 @@
 #define	BOOT_NMI_HANDLER	8
 
 #ifndef __ASSEMBLY__
+#include <linux/cpumask.h>
+
 struct irq_desc;
 extern struct plat_smp_ops nlm_smp_ops;
 extern char nlm_reset_entry[], nlm_reset_entry_end[];
@@ -52,7 +54,7 @@ void nlm_smp_function_ipi_handler(unsigned int irq, struct irq_desc *desc);
 void nlm_smp_resched_ipi_handler(unsigned int irq, struct irq_desc *desc);
 void nlm_smp_irq_init(void);
 void nlm_boot_secondary_cpus(void);
-int nlm_wakeup_secondary_cpus(u32 wakeup_mask);
+int nlm_wakeup_secondary_cpus(void);
 void nlm_rmiboot_preboot(void);
 
 static inline void
@@ -71,6 +73,7 @@ unsigned int nlm_get_cpu_frequency(void);
 
 extern unsigned long nlm_common_ebase;
 extern int nlm_threads_per_core;
-extern uint32_t nlm_cpumask, nlm_coremask;
+extern uint32_t nlm_coremask;
+extern cpumask_t nlm_cpumask;
 #endif
 #endif /* _NETLOGIC_COMMON_H_ */
diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index cd39f54..4fe8992 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -160,9 +160,9 @@ void __init nlm_smp_setup(void)
 	int num_cpus, i;
 
 	boot_cpu = hard_smp_processor_id();
-	cpus_clear(phys_cpu_present_map);
+	cpumask_clear(&phys_cpu_present_map);
 
-	cpu_set(boot_cpu, phys_cpu_present_map);
+	cpumask_set_cpu(boot_cpu, &phys_cpu_present_map);
 	__cpu_number_map[boot_cpu] = 0;
 	__cpu_logical_map[0] = boot_cpu;
 	set_cpu_possible(0, true);
@@ -174,7 +174,7 @@ void __init nlm_smp_setup(void)
 		 * it is only set for ASPs (see smpboot.S)
 		 */
 		if (nlm_cpu_ready[i]) {
-			cpu_set(i, phys_cpu_present_map);
+			cpumask_set_cpu(i, &phys_cpu_present_map);
 			__cpu_number_map[i] = num_cpus;
 			__cpu_logical_map[num_cpus] = i;
 			set_cpu_possible(num_cpus, true);
@@ -183,19 +183,22 @@ void __init nlm_smp_setup(void)
 	}
 
 	pr_info("Phys CPU present map: %lx, possible map %lx\n",
-		(unsigned long)phys_cpu_present_map.bits[0],
+		(unsigned long)cpumask_bits(&phys_cpu_present_map)[0],
 		(unsigned long)cpumask_bits(cpu_possible_mask)[0]);
 
 	pr_info("Detected %i Slave CPU(s)\n", num_cpus);
 	nlm_set_nmi_handler(nlm_boot_secondary_cpus);
 }
 
-static int nlm_parse_cpumask(u32 cpu_mask)
+static int nlm_parse_cpumask(cpumask_t *wakeup_mask)
 {
 	uint32_t core0_thr_mask, core_thr_mask;
-	int threadmode, i;
+	int threadmode, i, j;
 
-	core0_thr_mask = cpu_mask & 0xf;
+	core0_thr_mask = 0;
+	for (i = 0; i < 4; i++)
+		if (cpumask_test_cpu(i, wakeup_mask))
+			core0_thr_mask |= (1 << i);
 	switch (core0_thr_mask) {
 	case 1:
 		nlm_threads_per_core = 1;
@@ -214,25 +217,23 @@ static int nlm_parse_cpumask(u32 cpu_mask)
 	}
 
 	/* Verify other cores CPU masks */
-	nlm_coremask = 1;
-	nlm_cpumask = core0_thr_mask;
-	for (i = 1; i < 8; i++) {
-		core_thr_mask = (cpu_mask >> (i * 4)) & 0xf;
-		if (core_thr_mask) {
-			if (core_thr_mask != core0_thr_mask)
+	for (i = 0; i < NR_CPUS; i += 4) {
+		core_thr_mask = 0;
+		for (j = 0; j < 4; j++)
+			if (cpumask_test_cpu(i + j, wakeup_mask))
+				core_thr_mask |= (1 << j);
+		if (core_thr_mask != 0 && core_thr_mask != core0_thr_mask)
 				goto unsupp;
-			nlm_coremask |= 1 << i;
-			nlm_cpumask |= core0_thr_mask << (4 * i);
-		}
 	}
 	return threadmode;
 
 unsupp:
-	panic("Unsupported CPU mask %x\n", cpu_mask);
+	panic("Unsupported CPU mask %lx\n",
+		(unsigned long)cpumask_bits(wakeup_mask)[0]);
 	return 0;
 }
 
-int __cpuinit nlm_wakeup_secondary_cpus(u32 wakeup_mask)
+int __cpuinit nlm_wakeup_secondary_cpus(void)
 {
 	unsigned long reset_vec;
 	char *reset_data;
@@ -244,7 +245,7 @@ int __cpuinit nlm_wakeup_secondary_cpus(u32 wakeup_mask)
 			(nlm_reset_entry_end - nlm_reset_entry));
 
 	/* verify the mask and setup core config variables */
-	threadmode = nlm_parse_cpumask(wakeup_mask);
+	threadmode = nlm_parse_cpumask(&nlm_cpumask);
 
 	/* Setup CPU init parameters */
 	reset_data = (char *)CKSEG1ADDR(RESET_DATA_PHYS);
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index b886a50..9f8d360 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -55,7 +55,8 @@
 unsigned long nlm_common_ebase = 0x0;
 
 /* default to uniprocessor */
-uint32_t nlm_coremask = 1, nlm_cpumask  = 1;
+uint32_t nlm_coremask = 1;
+cpumask_t nlm_cpumask = CPU_MASK_CPU0;
 int  nlm_threads_per_core = 1;
 extern u32 __dtb_start[];
 
@@ -115,7 +116,8 @@ void __init prom_init(void)
 	nlm_common_ebase = read_c0_ebase() & (~((1 << 12) - 1));
 
 #ifdef CONFIG_SMP
-	nlm_wakeup_secondary_cpus(0xffffffff);
+	cpumask_setall(&nlm_cpumask);
+	nlm_wakeup_secondary_cpus();
 
 	/* update TLB size after waking up threads */
 	current_cpu_data.tlbsize = ((read_c0_config6() >> 16) & 0xffff) + 1;
diff --git a/arch/mips/netlogic/xlp/wakeup.c b/arch/mips/netlogic/xlp/wakeup.c
index 44d923f..88ce38d 100644
--- a/arch/mips/netlogic/xlp/wakeup.c
+++ b/arch/mips/netlogic/xlp/wakeup.c
@@ -51,45 +51,66 @@
 #include <asm/netlogic/xlp-hal/xlp.h>
 #include <asm/netlogic/xlp-hal/sys.h>
 
-static void xlp_enable_secondary_cores(void)
+static int xlp_wakeup_core(uint64_t sysbase, int core)
 {
-	uint32_t core, value, coremask, syscoremask;
+	uint32_t coremask, value;
 	int count;
 
-	/* read cores in reset from SYS block */
-	syscoremask = nlm_read_sys_reg(nlm_sys_base, SYS_CPU_RESET);
+	coremask = (1 << core);
 
-	/* update user specified */
-	nlm_coremask = nlm_coremask & (syscoremask | 1);
+	/* Enable CPU clock */
+	value = nlm_read_sys_reg(sysbase, SYS_CORE_DFS_DIS_CTRL);
+	value &= ~coremask;
+	nlm_write_sys_reg(sysbase, SYS_CORE_DFS_DIS_CTRL, value);
 
-	for (core = 1; core < 8; core++) {
-		coremask = 1 << core;
-		if ((nlm_coremask & coremask) == 0)
-			continue;
+	/* Remove CPU Reset */
+	value = nlm_read_sys_reg(sysbase, SYS_CPU_RESET);
+	value &= ~coremask;
+	nlm_write_sys_reg(sysbase, SYS_CPU_RESET, value);
 
-		/* Enable CPU clock */
-		value = nlm_read_sys_reg(nlm_sys_base, SYS_CORE_DFS_DIS_CTRL);
-		value &= ~coremask;
-		nlm_write_sys_reg(nlm_sys_base, SYS_CORE_DFS_DIS_CTRL, value);
+	/* Poll for CPU to mark itself coherent */
+	count = 100000;
+	do {
+		value = nlm_read_sys_reg(sysbase, SYS_CPU_NONCOHERENT_MODE);
+	} while ((value & coremask) != 0 && --count > 0);
 
-		/* Remove CPU Reset */
-		value = nlm_read_sys_reg(nlm_sys_base, SYS_CPU_RESET);
-		value &= ~coremask;
-		nlm_write_sys_reg(nlm_sys_base, SYS_CPU_RESET, value);
+	return count != 0;
+}
+
+static void xlp_enable_secondary_cores(const cpumask_t *wakeup_mask)
+{
+	uint64_t syspcibase, sysbase;
+	uint32_t syscoremask;
+	int core, n;
+
+	for (n = 0; n < 4; n++) {
+		syspcibase = nlm_get_sys_pcibase(n);
+		if (nlm_read_reg(syspcibase, 0) == 0xffffffff)
+			break;
+
+		/* read cores in reset from SYS and account for boot cpu */
+		sysbase = nlm_get_sys_regbase(n);
+		syscoremask = nlm_read_sys_reg(sysbase, SYS_CPU_RESET);
+		if (n == 0)
+			syscoremask |= 1;
+
+		for (core = 0; core < 8; core++) {
+			/* see if the core exists */
+			if ((syscoremask & (1 << core)) == 0)
+				continue;
 
-		/* Poll for CPU to mark itself coherent */
-		count = 100000;
-		do {
-			value = nlm_read_sys_reg(nlm_sys_base,
-			    SYS_CPU_NONCOHERENT_MODE);
-		} while ((value & coremask) != 0 && count-- > 0);
+			/* see if at least the first thread is enabled */
+			if (!cpumask_test_cpu((n * 8 + core) * 4, wakeup_mask))
+				continue;
 
-		if (count == 0)
-			pr_err("Failed to enable core %d\n", core);
+			/* wake up the core */
+			if (!xlp_wakeup_core(sysbase, core))
+				pr_err("Failed to enable core %d\n", core);
+		}
 	}
 }
 
-void xlp_wakeup_secondary_cpus(void)
+void xlp_wakeup_secondary_cpus()
 {
 	/*
 	 * In case of u-boot, the secondaries are in reset
@@ -98,5 +119,5 @@ void xlp_wakeup_secondary_cpus(void)
 	xlp_boot_core0_siblings();
 
 	/* now get other cores out of reset */
-	xlp_enable_secondary_cores();
+	xlp_enable_secondary_cores(&nlm_cpumask);
 }
diff --git a/arch/mips/netlogic/xlr/setup.c b/arch/mips/netlogic/xlr/setup.c
index 81b1d31..8fca680 100644
--- a/arch/mips/netlogic/xlr/setup.c
+++ b/arch/mips/netlogic/xlr/setup.c
@@ -57,8 +57,9 @@ struct psb_info nlm_prom_info;
 unsigned long nlm_common_ebase = 0x0;
 
 /* default to uniprocessor */
-uint32_t nlm_coremask = 1, nlm_cpumask  = 1;
+uint32_t nlm_coremask = 1;
 int  nlm_threads_per_core = 1;
+cpumask_t nlm_cpumask = CPU_MASK_CPU0;
 
 static void __init nlm_early_serial_setup(void)
 {
@@ -178,7 +179,7 @@ static void prom_add_memory(void)
 
 void __init prom_init(void)
 {
-	int *argv, *envp;		/* passed as 32 bit ptrs */
+	int i, *argv, *envp;		/* passed as 32 bit ptrs */
 	struct psb_info *prom_infop;
 
 	/* truncate to 32 bit and sign extend all args */
@@ -195,7 +196,10 @@ void __init prom_init(void)
 	prom_add_memory();
 
 #ifdef CONFIG_SMP
-	nlm_wakeup_secondary_cpus(nlm_prom_info.online_cpu_map);
+	for (i = 0; i < 32; i++)
+		if (nlm_prom_info.online_cpu_map & (1 << i))
+			cpumask_set_cpu(i, &nlm_cpumask);
+	nlm_wakeup_secondary_cpus();
 	register_smp_ops(&nlm_smp_ops);
 #endif
 }
diff --git a/arch/mips/netlogic/xlr/wakeup.c b/arch/mips/netlogic/xlr/wakeup.c
index db5d987..0878924 100644
--- a/arch/mips/netlogic/xlr/wakeup.c
+++ b/arch/mips/netlogic/xlr/wakeup.c
@@ -59,7 +59,7 @@ int __cpuinit xlr_wakeup_secondary_cpus(void)
 	boot_cpu = hard_smp_processor_id();
 	nlm_set_nmi_handler(nlm_rmiboot_preboot);
 	for (i = 0; i < NR_CPUS; i++) {
-		if (i == boot_cpu || (nlm_cpumask & (1u << i)) == 0)
+		if (i == boot_cpu || !cpumask_test_cpu(i, &nlm_cpumask))
 			continue;
 		nlm_pic_send_ipi(nlm_pic_base, i, 1, 1); /* send NMI */
 	}
-- 
1.7.9.5
