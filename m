Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jan 2015 12:24:00 +0100 (CET)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:25072 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010446AbbAGLVbUKeAp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Jan 2015 12:21:31 +0100
X-IronPort-AV: E=Sophos;i="5.07,714,1413270000"; 
   d="scan'208";a="54169607"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw3-out.broadcom.com with ESMTP; 07 Jan 2015 03:36:01 -0800
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Wed, 7 Jan 2015 03:21:45 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Wed, 7 Jan 2015 03:21:44 -0800
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 29CAB40FE8;    Wed,  7 Jan 2015 03:20:41 -0800 (PST)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>
Subject: [PATCH 09/17] MIPS: Netlogic: Move cores per node out of multi-node.h
Date:   Wed, 7 Jan 2015 16:58:30 +0530
Message-ID: <1420630118-17198-10-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1420630118-17198-1-git-send-email-jchandra@broadcom.com>
References: <1420630118-17198-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44993
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

Use the current_cpu_data package field to get the node of the current CPU.

This allows us to remove xlp_cores_per_node and move nlm_threads_per_node()
and nlm_cores_per_node() to netlogic/common.h, which simplifies code.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/mach-netlogic/multi-node.h |  9 --------
 arch/mips/include/asm/netlogic/common.h          | 21 ++++++++++++++++++-
 arch/mips/netlogic/common/irq.c                  | 10 ++++-----
 arch/mips/netlogic/common/smp.c                  | 26 +++++++++++++-----------
 arch/mips/netlogic/xlp/setup.c                   |  5 -----
 arch/mips/netlogic/xlp/wakeup.c                  |  8 ++++----
 6 files changed, 43 insertions(+), 36 deletions(-)

diff --git a/arch/mips/include/asm/mach-netlogic/multi-node.h b/arch/mips/include/asm/mach-netlogic/multi-node.h
index 9ed8dac..8bdf47e 100644
--- a/arch/mips/include/asm/mach-netlogic/multi-node.h
+++ b/arch/mips/include/asm/mach-netlogic/multi-node.h
@@ -48,15 +48,6 @@
 #endif
 
 #define NLM_THREADS_PER_CORE	4
-#ifdef CONFIG_CPU_XLR
-#define nlm_cores_per_node()	8
-#else
-extern unsigned int xlp_cores_per_node;
-#define nlm_cores_per_node()	xlp_cores_per_node
-#endif
-
-#define nlm_threads_per_node()	(nlm_cores_per_node() * NLM_THREADS_PER_CORE)
-#define nlm_cpuid_to_node(c)	((c) / nlm_threads_per_node())
 
 struct nlm_soc_info {
 	unsigned long	coremask;	/* cores enabled on the soc */
diff --git a/arch/mips/include/asm/netlogic/common.h b/arch/mips/include/asm/netlogic/common.h
index c281f03..2a4c128 100644
--- a/arch/mips/include/asm/netlogic/common.h
+++ b/arch/mips/include/asm/netlogic/common.h
@@ -111,6 +111,25 @@ static inline int nlm_irq_to_xirq(int node, int irq)
 	return node * NR_IRQS / NLM_NR_NODES + irq;
 }
 
-extern int nlm_cpu_ready[];
+#ifdef CONFIG_CPU_XLR
+#define nlm_cores_per_node()	8
+#else
+static inline int nlm_cores_per_node(void)
+{
+	return ((read_c0_prid() & PRID_IMP_MASK)
+				== PRID_IMP_NETLOGIC_XLP9XX) ? 32 : 8;
+}
 #endif
+static inline int nlm_threads_per_node(void)
+{
+	return nlm_cores_per_node() * NLM_THREADS_PER_CORE;
+}
+
+static inline int nlm_hwtid_to_node(int hwtid)
+{
+	return hwtid / nlm_threads_per_node();
+}
+
+extern int nlm_cpu_ready[];
+#endif /* __ASSEMBLY__ */
 #endif /* _NETLOGIC_COMMON_H_ */
diff --git a/arch/mips/netlogic/common/irq.c b/arch/mips/netlogic/common/irq.c
index c100b9a..5f5d18b 100644
--- a/arch/mips/netlogic/common/irq.c
+++ b/arch/mips/netlogic/common/irq.c
@@ -230,16 +230,16 @@ static void nlm_init_node_irqs(int node)
 	}
 }
 
-void nlm_smp_irq_init(int hwcpuid)
+void nlm_smp_irq_init(int hwtid)
 {
-	int node, cpu;
+	int cpu, node;
 
-	node = nlm_cpuid_to_node(hwcpuid);
-	cpu  = hwcpuid % nlm_threads_per_node();
+	cpu = hwtid % nlm_threads_per_node();
+	node = hwtid / nlm_threads_per_node();
 
 	if (cpu == 0 && node != 0)
 		nlm_init_node_irqs(node);
-	write_c0_eimr(nlm_current_node()->irqmask);
+	write_c0_eimr(nlm_get_node(node)->irqmask);
 }
 
 asmlinkage void plat_irq_dispatch(void)
diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index f23fe22..1f709db 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -59,17 +59,17 @@
 
 void nlm_send_ipi_single(int logical_cpu, unsigned int action)
 {
-	int cpu, node;
+	unsigned int hwtid;
 	uint64_t picbase;
 
-	cpu = cpu_logical_map(logical_cpu);
-	node = nlm_cpuid_to_node(cpu);
-	picbase = nlm_get_node(node)->picbase;
+	/* node id is part of hwtid, and needed for send_ipi */
+	hwtid = cpu_logical_map(logical_cpu);
+	picbase = nlm_get_node(nlm_hwtid_to_node(hwtid))->picbase;
 
 	if (action & SMP_CALL_FUNCTION)
-		nlm_pic_send_ipi(picbase, cpu, IRQ_IPI_SMP_FUNCTION, 0);
+		nlm_pic_send_ipi(picbase, hwtid, IRQ_IPI_SMP_FUNCTION, 0);
 	if (action & SMP_RESCHEDULE_YOURSELF)
-		nlm_pic_send_ipi(picbase, cpu, IRQ_IPI_SMP_RESCHEDULE, 0);
+		nlm_pic_send_ipi(picbase, hwtid, IRQ_IPI_SMP_RESCHEDULE, 0);
 }
 
 void nlm_send_ipi_mask(const struct cpumask *mask, unsigned int action)
@@ -120,7 +120,7 @@ static void nlm_init_secondary(void)
 
 	hwtid = hard_smp_processor_id();
 	current_cpu_data.core = hwtid / NLM_THREADS_PER_CORE;
-	current_cpu_data.package = nlm_cpuid_to_node(hwtid);
+	current_cpu_data.package = nlm_nodeid();
 	nlm_percpu_init(hwtid);
 	nlm_smp_irq_init(hwtid);
 }
@@ -146,16 +146,18 @@ static cpumask_t phys_cpu_present_mask;
 
 void nlm_boot_secondary(int logical_cpu, struct task_struct *idle)
 {
-	int cpu, node;
+	uint64_t picbase;
+	int hwtid;
+
+	hwtid = cpu_logical_map(logical_cpu);
+	picbase = nlm_get_node(nlm_hwtid_to_node(hwtid))->picbase;
 
-	cpu = cpu_logical_map(logical_cpu);
-	node = nlm_cpuid_to_node(logical_cpu);
 	nlm_next_sp = (unsigned long)__KSTK_TOS(idle);
 	nlm_next_gp = (unsigned long)task_thread_info(idle);
 
 	/* barrier for sp/gp store above */
 	__sync();
-	nlm_pic_send_ipi(nlm_get_node(node)->picbase, cpu, 1, 1);  /* NMI */
+	nlm_pic_send_ipi(picbase, hwtid, 1, 1);  /* NMI */
 }
 
 void __init nlm_smp_setup(void)
@@ -184,7 +186,7 @@ void __init nlm_smp_setup(void)
 			__cpu_number_map[i] = num_cpus;
 			__cpu_logical_map[num_cpus] = i;
 			set_cpu_possible(num_cpus, true);
-			node = nlm_cpuid_to_node(i);
+			node = nlm_hwtid_to_node(i);
 			cpumask_set_cpu(num_cpus, &nlm_get_node(node)->cpumask);
 			++num_cpus;
 		}
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index 4fdd9fd..27113a1 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -51,7 +51,6 @@ uint64_t nlm_io_base;
 struct nlm_soc_info nlm_nodes[NLM_NR_NODES];
 cpumask_t nlm_cpumask = CPU_MASK_CPU0;
 unsigned int nlm_threads_per_core;
-unsigned int xlp_cores_per_node;
 
 static void nlm_linux_exit(void)
 {
@@ -163,10 +162,6 @@ void __init prom_init(void)
 	void *reset_vec;
 
 	nlm_io_base = CKSEG1ADDR(XLP_DEFAULT_IO_BASE);
-	if (cpu_is_xlp9xx())
-		xlp_cores_per_node = 32;
-	else
-		xlp_cores_per_node = 8;
 	nlm_init_boot_cpu();
 	xlp_mmu_init();
 	nlm_node_init(0);
diff --git a/arch/mips/netlogic/xlp/wakeup.c b/arch/mips/netlogic/xlp/wakeup.c
index 26d82f7..87d7846 100644
--- a/arch/mips/netlogic/xlp/wakeup.c
+++ b/arch/mips/netlogic/xlp/wakeup.c
@@ -111,7 +111,7 @@ static void xlp_enable_secondary_cores(const cpumask_t *wakeup_mask)
 	struct nlm_soc_info *nodep;
 	uint64_t syspcibase, fusebase;
 	uint32_t syscoremask, mask, fusemask;
-	int core, n, cpu;
+	int core, n, cpu, ncores;
 
 	for (n = 0; n < NLM_NR_NODES; n++) {
 		if (n != 0) {
@@ -168,7 +168,8 @@ static void xlp_enable_secondary_cores(const cpumask_t *wakeup_mask)
 		syscoremask = (1 << hweight32(~fusemask & mask)) - 1;
 
 		pr_info("Node %d - SYS/FUSE coremask %x\n", n, syscoremask);
-		for (core = 0; core < nlm_cores_per_node(); core++) {
+		ncores = nlm_cores_per_node();
+		for (core = 0; core < ncores; core++) {
 			/* we will be on node 0 core 0 */
 			if (n == 0 && core == 0)
 				continue;
@@ -178,8 +179,7 @@ static void xlp_enable_secondary_cores(const cpumask_t *wakeup_mask)
 				continue;
 
 			/* see if at least the first hw thread is enabled */
-			cpu = (n * nlm_cores_per_node() + core)
-						* NLM_THREADS_PER_CORE;
+			cpu = (n * ncores + core) * NLM_THREADS_PER_CORE;
 			if (!cpumask_test_cpu(cpu, wakeup_mask))
 				continue;
 
-- 
1.9.1
