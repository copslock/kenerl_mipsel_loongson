Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Dec 2013 12:15:32 +0100 (CET)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:63752 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6867258Ab3LULLFg6-VQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Dec 2013 12:11:05 +0100
X-IronPort-AV: E=Sophos;i="4.95,527,1384329600"; 
   d="scan'208";a="4638693"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw1-out.broadcom.com with ESMTP; 21 Dec 2013 03:17:11 -0800
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.1.438.0; Sat, 21 Dec 2013 03:11:04 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP Server id
 14.1.438.0; Sat, 21 Dec 2013 03:11:04 -0800
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 10908246A9;    Sat, 21 Dec 2013 03:11:02 -0800 (PST)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>
Subject: [PATCH 14/18] MIPS: Netlogic: Add cpu to node mapping for XLP9XX
Date:   Sat, 21 Dec 2013 16:52:26 +0530
Message-ID: <1387624950-31297-15-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1387624950-31297-1-git-send-email-jchandra@broadcom.com>
References: <1387624950-31297-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38787
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

XLP9XX has 20 cores per node, opposed to 8 on earlier XLP8XX.
Update code that calculates node id from cpu id to handle this.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/mach-netlogic/multi-node.h |   11 +++++++++--
 arch/mips/include/asm/netlogic/mips-extns.h      |    7 ++++++-
 arch/mips/netlogic/common/irq.c                  |    6 +++---
 arch/mips/netlogic/common/smp.c                  |    8 +++++---
 arch/mips/netlogic/xlp/setup.c                   |    5 +++++
 arch/mips/netlogic/xlp/wakeup.c                  |    4 ++--
 arch/mips/netlogic/xlr/wakeup.c                  |    2 +-
 arch/mips/pci/msi-xlp.c                          |    4 ++--
 8 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/arch/mips/include/asm/mach-netlogic/multi-node.h b/arch/mips/include/asm/mach-netlogic/multi-node.h
index df9869d..9ed8dac 100644
--- a/arch/mips/include/asm/mach-netlogic/multi-node.h
+++ b/arch/mips/include/asm/mach-netlogic/multi-node.h
@@ -47,9 +47,16 @@
 #endif
 #endif
 
-#define NLM_CORES_PER_NODE	8
 #define NLM_THREADS_PER_CORE	4
-#define NLM_CPUS_PER_NODE	(NLM_CORES_PER_NODE * NLM_THREADS_PER_CORE)
+#ifdef CONFIG_CPU_XLR
+#define nlm_cores_per_node()	8
+#else
+extern unsigned int xlp_cores_per_node;
+#define nlm_cores_per_node()	xlp_cores_per_node
+#endif
+
+#define nlm_threads_per_node()	(nlm_cores_per_node() * NLM_THREADS_PER_CORE)
+#define nlm_cpuid_to_node(c)	((c) / nlm_threads_per_node())
 
 struct nlm_soc_info {
 	unsigned long	coremask;	/* cores enabled on the soc */
diff --git a/arch/mips/include/asm/netlogic/mips-extns.h b/arch/mips/include/asm/netlogic/mips-extns.h
index f299d31..de9aada 100644
--- a/arch/mips/include/asm/netlogic/mips-extns.h
+++ b/arch/mips/include/asm/netlogic/mips-extns.h
@@ -146,7 +146,12 @@ static inline int hard_smp_processor_id(void)
 
 static inline int nlm_nodeid(void)
 {
-	return (__read_32bit_c0_register($15, 1) >> 5) & 0x3;
+	uint32_t prid = read_c0_prid();
+
+	if ((prid & 0xff00) == PRID_IMP_NETLOGIC_XLP9XX)
+		return (__read_32bit_c0_register($15, 1) >> 7) & 0x7;
+	else
+		return (__read_32bit_c0_register($15, 1) >> 5) & 0x3;
 }
 
 static inline unsigned int nlm_core_id(void)
diff --git a/arch/mips/netlogic/common/irq.c b/arch/mips/netlogic/common/irq.c
index 3800bf6..8092bb3 100644
--- a/arch/mips/netlogic/common/irq.c
+++ b/arch/mips/netlogic/common/irq.c
@@ -223,7 +223,7 @@ static void nlm_init_node_irqs(int node)
 			continue;
 
 		nlm_pic_init_irt(nodep->picbase, irt, i,
-					node * NLM_CPUS_PER_NODE, 0);
+				node * nlm_threads_per_node(), 0);
 		nlm_setup_pic_irq(node, i, i, irt);
 	}
 }
@@ -232,8 +232,8 @@ void nlm_smp_irq_init(int hwcpuid)
 {
 	int node, cpu;
 
-	node = hwcpuid / NLM_CPUS_PER_NODE;
-	cpu  = hwcpuid % NLM_CPUS_PER_NODE;
+	node = nlm_cpuid_to_node(hwcpuid);
+	cpu  = hwcpuid % nlm_threads_per_node();
 
 	if (cpu == 0 && node != 0)
 		nlm_init_node_irqs(node);
diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index c0eded0..6baae15 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -63,7 +63,7 @@ void nlm_send_ipi_single(int logical_cpu, unsigned int action)
 	uint64_t picbase;
 
 	cpu = cpu_logical_map(logical_cpu);
-	node = cpu / NLM_CPUS_PER_NODE;
+	node = nlm_cpuid_to_node(cpu);
 	picbase = nlm_get_node(node)->picbase;
 
 	if (action & SMP_CALL_FUNCTION)
@@ -152,7 +152,7 @@ void nlm_boot_secondary(int logical_cpu, struct task_struct *idle)
 	int cpu, node;
 
 	cpu = cpu_logical_map(logical_cpu);
-	node = cpu / NLM_CPUS_PER_NODE;
+	node = nlm_cpuid_to_node(logical_cpu);
 	nlm_next_sp = (unsigned long)__KSTK_TOS(idle);
 	nlm_next_gp = (unsigned long)task_thread_info(idle);
 
@@ -164,7 +164,7 @@ void nlm_boot_secondary(int logical_cpu, struct task_struct *idle)
 void __init nlm_smp_setup(void)
 {
 	unsigned int boot_cpu;
-	int num_cpus, i, ncore;
+	int num_cpus, i, ncore, node;
 	volatile u32 *cpu_ready = nlm_get_boot_data(BOOT_CPU_READY);
 	char buf[64];
 
@@ -187,6 +187,8 @@ void __init nlm_smp_setup(void)
 			__cpu_number_map[i] = num_cpus;
 			__cpu_logical_map[num_cpus] = i;
 			set_cpu_possible(num_cpus, true);
+			node = nlm_cpuid_to_node(i);
+			cpumask_set_cpu(num_cpus, &nlm_get_node(node)->cpumask);
 			++num_cpus;
 		}
 	}
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index d739c5d..c3af2d8 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -51,6 +51,7 @@ uint64_t nlm_io_base;
 struct nlm_soc_info nlm_nodes[NLM_NR_NODES];
 cpumask_t nlm_cpumask = CPU_MASK_CPU0;
 unsigned int nlm_threads_per_core;
+unsigned int xlp_cores_per_node;
 
 static void nlm_linux_exit(void)
 {
@@ -162,6 +163,10 @@ void __init prom_init(void)
 	void *reset_vec;
 
 	nlm_io_base = CKSEG1ADDR(XLP_DEFAULT_IO_BASE);
+	if (cpu_is_xlp9xx())
+		xlp_cores_per_node = 32;
+	else
+		xlp_cores_per_node = 8;
 	nlm_init_boot_cpu();
 	xlp_mmu_init();
 	nlm_node_init(0);
diff --git a/arch/mips/netlogic/xlp/wakeup.c b/arch/mips/netlogic/xlp/wakeup.c
index 7e3c5b9..4eb7cdb 100644
--- a/arch/mips/netlogic/xlp/wakeup.c
+++ b/arch/mips/netlogic/xlp/wakeup.c
@@ -165,7 +165,7 @@ static void xlp_enable_secondary_cores(const cpumask_t *wakeup_mask)
 			nodep->coremask = 1;
 
 		pr_info("Node %d - SYS/FUSE coremask %x\n", n, syscoremask);
-		for (core = 0; core < NLM_CORES_PER_NODE; core++) {
+		for (core = 0; core < nlm_cores_per_node(); core++) {
 			/* we will be on node 0 core 0 */
 			if (n == 0 && core == 0)
 				continue;
@@ -175,7 +175,7 @@ static void xlp_enable_secondary_cores(const cpumask_t *wakeup_mask)
 				continue;
 
 			/* see if at least the first hw thread is enabled */
-			cpu = (n * NLM_CORES_PER_NODE + core)
+			cpu = (n * nlm_cores_per_node() + core)
 						* NLM_THREADS_PER_CORE;
 			if (!cpumask_test_cpu(cpu, wakeup_mask))
 				continue;
diff --git a/arch/mips/netlogic/xlr/wakeup.c b/arch/mips/netlogic/xlr/wakeup.c
index 9fb81fa..ec60e71 100644
--- a/arch/mips/netlogic/xlr/wakeup.c
+++ b/arch/mips/netlogic/xlr/wakeup.c
@@ -70,7 +70,7 @@ int xlr_wakeup_secondary_cpus(void)
 
 	/* Fill up the coremask early */
 	nodep->coremask = 1;
-	for (i = 1; i < NLM_CORES_PER_NODE; i++) {
+	for (i = 1; i < nlm_cores_per_node(); i++) {
 		for (j = 1000000; j > 0; j--) {
 			if (cpu_ready[i * NLM_THREADS_PER_CORE])
 				break;
diff --git a/arch/mips/pci/msi-xlp.c b/arch/mips/pci/msi-xlp.c
index 66a244a..afd8405 100644
--- a/arch/mips/pci/msi-xlp.c
+++ b/arch/mips/pci/msi-xlp.c
@@ -280,7 +280,7 @@ static int xlp_setup_msi(uint64_t lnkbase, int node, int link,
 		irt = PIC_IRT_PCIE_LINK_INDEX(link);
 		nlm_setup_pic_irq(node, lirq, lirq, irt);
 		nlm_pic_init_irt(nlm_get_node(node)->picbase, irt, lirq,
-				 node * NLM_CPUS_PER_NODE, 1 /*en */);
+				 node * nlm_threads_per_node(), 1 /*en */);
 	}
 
 	/* allocate a MSI vec, and tell the bridge about it */
@@ -443,7 +443,7 @@ void __init xlp_init_node_msi_irqs(int node, int link)
 		msixvec = link * XLP_MSIXVEC_PER_LINK + i;
 		irt = PIC_IRT_PCIE_MSIX_INDEX(msixvec);
 		nlm_pic_init_irt(nodep->picbase, irt, PIC_PCIE_MSIX_IRQ(link),
-			node * NLM_CPUS_PER_NODE, 1 /* enable */);
+			node * nlm_threads_per_node(), 1 /* enable */);
 
 		/* Initialize MSI-X extended irq space for the link  */
 		irq = nlm_irq_to_xirq(node, nlm_link_msixirq(link, i));
-- 
1.7.9.5
