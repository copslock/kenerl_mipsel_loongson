Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 14:00:43 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:2705 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825756Ab2JaM6ufTKVl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 Oct 2012 13:58:50 +0100
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 31 Oct 2012 05:56:54 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Wed, 31 Oct 2012 05:58:12 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 0EF2140FE3; Wed, 31
 Oct 2012 05:58:40 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 12/15] MIPS: Netlogic: Introduce support for multi-node
Date:   Wed, 31 Oct 2012 18:31:38 +0530
Message-ID: <995719ada6db71c86b332df4698c1dbf748686c0.1351687453.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1351687453.git.jchandra@broadcom.com>
References: <cover.1351687453.git.jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7C8FFF9C3QC1968458-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 34801
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

Upto 4 Netlogic XLP SoCs can be connected over ICI links to form a
coherent multi-node system.  Each SoC has its own set of on-chip
devices including PIC.  To support this, add a per SoC stucture and
use it for the PIC and SYS block addresses instead of using global
variables.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/common.h      |   42 +++++++++++++++++---
 arch/mips/include/asm/netlogic/mips-extns.h  |    5 +++
 arch/mips/include/asm/netlogic/xlp-hal/pic.h |    1 -
 arch/mips/include/asm/netlogic/xlp-hal/sys.h |    1 -
 arch/mips/include/asm/netlogic/xlr/pic.h     |    2 -
 arch/mips/netlogic/common/irq.c              |   55 +++++++++++++++++---------
 arch/mips/netlogic/common/smp.c              |   47 +++++++++++++---------
 arch/mips/netlogic/xlp/nlm_hal.c             |   29 +++++++-------
 arch/mips/netlogic/xlp/setup.c               |   17 ++++----
 arch/mips/netlogic/xlp/wakeup.c              |   22 +++++++----
 arch/mips/netlogic/xlr/setup.c               |   20 ++++++----
 arch/mips/netlogic/xlr/wakeup.c              |   20 +++++++++-
 12 files changed, 175 insertions(+), 86 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/common.h b/arch/mips/include/asm/netlogic/common.h
index fd735bc..2eb39fa 100644
--- a/arch/mips/include/asm/netlogic/common.h
+++ b/arch/mips/include/asm/netlogic/common.h
@@ -46,10 +46,10 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/cpumask.h>
+#include <linux/spinlock.h>
+#include <asm/irq.h>
 
 struct irq_desc;
-extern struct plat_smp_ops nlm_smp_ops;
-extern char nlm_reset_entry[], nlm_reset_entry_end[];
 void nlm_smp_function_ipi_handler(unsigned int irq, struct irq_desc *desc);
 void nlm_smp_resched_ipi_handler(unsigned int irq, struct irq_desc *desc);
 void nlm_smp_irq_init(void);
@@ -70,10 +70,42 @@ nlm_set_nmi_handler(void *handler)
  * Misc.
  */
 unsigned int nlm_get_cpu_frequency(void);
+void nlm_node_init(int node);
+extern struct plat_smp_ops nlm_smp_ops;
+extern char nlm_reset_entry[], nlm_reset_entry_end[];
 
-extern unsigned long nlm_common_ebase;
-extern int nlm_threads_per_core;
-extern uint32_t nlm_coremask;
+extern unsigned int nlm_threads_per_core;
 extern cpumask_t nlm_cpumask;
+
+struct nlm_soc_info {
+	unsigned long coremask;	/* cores enabled on the soc */
+	unsigned long ebase;
+	uint64_t irqmask;
+	uint64_t sysbase;	/* only for XLP */
+	uint64_t picbase;
+	spinlock_t piclock;
+};
+
+#define NLM_CORES_PER_NODE	8
+#define NLM_THREADS_PER_CORE	4
+#define NLM_CPUS_PER_NODE	(NLM_CORES_PER_NODE * NLM_THREADS_PER_CORE)
+#define	nlm_get_node(i)		(&nlm_nodes[i])
+#define NLM_NR_NODES		1
+#define	nlm_current_node()	(&nlm_nodes[0])
+
+struct irq_data;
+uint64_t nlm_pci_irqmask(int node);
+void nlm_set_pic_extra_ack(int node, int irq,  void (*xack)(struct irq_data *));
+
+/*
+ * The NR_IRQs is divided between nodes, each of them has a separate irq space
+ */
+static inline int nlm_irq_to_xirq(int node, int irq)
+{
+	return node * NR_IRQS / NLM_NR_NODES + irq;
+}
+
+extern struct nlm_soc_info nlm_nodes[NLM_NR_NODES];
+extern int nlm_cpu_ready[];
 #endif
 #endif /* _NETLOGIC_COMMON_H_ */
diff --git a/arch/mips/include/asm/netlogic/mips-extns.h b/arch/mips/include/asm/netlogic/mips-extns.h
index 8c53d0b..c9f6de5 100644
--- a/arch/mips/include/asm/netlogic/mips-extns.h
+++ b/arch/mips/include/asm/netlogic/mips-extns.h
@@ -73,4 +73,9 @@ static inline int hard_smp_processor_id(void)
 	return __read_32bit_c0_register($15, 1) & 0x3ff;
 }
 
+static inline int nlm_nodeid(void)
+{
+	return (__read_32bit_c0_register($15, 1) >> 5) & 0x3;
+}
+
 #endif /*_ASM_NLM_MIPS_EXTS_H */
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/pic.h b/arch/mips/include/asm/netlogic/xlp-hal/pic.h
index 061e071..857a967 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/pic.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/pic.h
@@ -381,7 +381,6 @@ nlm_pic_init_irt(uint64_t base, int irt, int irq, int hwt)
 	nlm_pic_write_irt_direct(base, irt, 0, 0, 0, irq, hwt);
 }
 
-extern uint64_t nlm_pic_base;
 int nlm_irq_to_irt(int irq);
 int nlm_irt_to_irq(int irt);
 
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/sys.h b/arch/mips/include/asm/netlogic/xlp-hal/sys.h
index 21432f7..258e8cc 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/sys.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/sys.h
@@ -124,6 +124,5 @@
 #define	nlm_get_sys_pcibase(node) nlm_pcicfg_base(XLP_IO_SYS_OFFSET(node))
 #define	nlm_get_sys_regbase(node) (nlm_get_sys_pcibase(node) + XLP_IO_PCI_HDRSZ)
 
-extern uint64_t nlm_sys_base;
 #endif
 #endif
diff --git a/arch/mips/include/asm/netlogic/xlr/pic.h b/arch/mips/include/asm/netlogic/xlr/pic.h
index 868013e..9a691b1 100644
--- a/arch/mips/include/asm/netlogic/xlr/pic.h
+++ b/arch/mips/include/asm/netlogic/xlr/pic.h
@@ -258,7 +258,5 @@ nlm_pic_init_irt(uint64_t base, int irt, int irq, int hwt)
 	nlm_write_reg(base, PIC_IRT_1(irt),
 		(1 << 30) | (1 << 6) | irq);
 }
-
-extern uint64_t nlm_pic_base;
 #endif
 #endif /* _ASM_NLM_XLR_PIC_H */
diff --git a/arch/mips/netlogic/common/irq.c b/arch/mips/netlogic/common/irq.c
index e52bfcb..4d6bd8f 100644
--- a/arch/mips/netlogic/common/irq.c
+++ b/arch/mips/netlogic/common/irq.c
@@ -70,33 +70,34 @@
  */
 
 /* Globals */
-static uint64_t nlm_irq_mask;
-static DEFINE_SPINLOCK(nlm_pic_lock);
-
 static void xlp_pic_enable(struct irq_data *d)
 {
 	unsigned long flags;
+	struct nlm_soc_info *nodep;
 	int irt;
 
+	nodep = nlm_current_node();
 	irt = nlm_irq_to_irt(d->irq);
 	if (irt == -1)
 		return;
-	spin_lock_irqsave(&nlm_pic_lock, flags);
-	nlm_pic_enable_irt(nlm_pic_base, irt);
-	spin_unlock_irqrestore(&nlm_pic_lock, flags);
+	spin_lock_irqsave(&nodep->piclock, flags);
+	nlm_pic_enable_irt(nodep->picbase, irt);
+	spin_unlock_irqrestore(&nodep->piclock, flags);
 }
 
 static void xlp_pic_disable(struct irq_data *d)
 {
+	struct nlm_soc_info *nodep;
 	unsigned long flags;
 	int irt;
 
+	nodep = nlm_current_node();
 	irt = nlm_irq_to_irt(d->irq);
 	if (irt == -1)
 		return;
-	spin_lock_irqsave(&nlm_pic_lock, flags);
-	nlm_pic_disable_irt(nlm_pic_base, irt);
-	spin_unlock_irqrestore(&nlm_pic_lock, flags);
+	spin_lock_irqsave(&nodep->piclock, flags);
+	nlm_pic_disable_irt(nodep->picbase, irt);
+	spin_unlock_irqrestore(&nodep->piclock, flags);
 }
 
 static void xlp_pic_mask_ack(struct irq_data *d)
@@ -109,8 +110,10 @@ static void xlp_pic_mask_ack(struct irq_data *d)
 static void xlp_pic_unmask(struct irq_data *d)
 {
 	void *hd = irq_data_get_irq_handler_data(d);
+	struct nlm_soc_info *nodep;
 	int irt;
 
+	nodep = nlm_current_node();
 	irt = nlm_irq_to_irt(d->irq);
 	if (irt == -1)
 		return;
@@ -120,7 +123,7 @@ static void xlp_pic_unmask(struct irq_data *d)
 		extra_ack(d);
 	}
 	/* Ack is a single write, no need to lock */
-	nlm_pic_ack(nlm_pic_base, irt);
+	nlm_pic_ack(nodep->picbase, irt);
 }
 
 static struct irq_chip xlp_pic = {
@@ -177,7 +180,11 @@ struct irq_chip nlm_cpu_intr = {
 void __init init_nlm_common_irqs(void)
 {
 	int i, irq, irt;
+	uint64_t irqmask;
+	struct nlm_soc_info *nodep;
 
+	nodep = nlm_current_node();
+	irqmask = (1ULL << IRQ_TIMER);
 	for (i = 0; i < PIC_IRT_FIRST_IRQ; i++)
 		irq_set_chip_and_handler(i, &nlm_cpu_intr, handle_percpu_irq);
 
@@ -189,7 +196,7 @@ void __init init_nlm_common_irqs(void)
 			 nlm_smp_function_ipi_handler);
 	irq_set_chip_and_handler(IRQ_IPI_SMP_RESCHEDULE, &nlm_cpu_intr,
 			 nlm_smp_resched_ipi_handler);
-	nlm_irq_mask |=
+	irqmask |=
 	    ((1ULL << IRQ_IPI_SMP_FUNCTION) | (1ULL << IRQ_IPI_SMP_RESCHEDULE));
 #endif
 
@@ -197,11 +204,11 @@ void __init init_nlm_common_irqs(void)
 		irt = nlm_irq_to_irt(irq);
 		if (irt == -1)
 			continue;
-		nlm_irq_mask |= (1ULL << irq);
-		nlm_pic_init_irt(nlm_pic_base, irt, irq, 0);
+		irqmask |= (1ULL << irq);
+		nlm_pic_init_irt(nodep->picbase, irt, irq, 0);
 	}
 
-	nlm_irq_mask |= (1ULL << IRQ_TIMER);
+	nodep->irqmask = irqmask;
 }
 
 void __init arch_init_irq(void)
@@ -209,29 +216,39 @@ void __init arch_init_irq(void)
 	/* Initialize the irq descriptors */
 	init_nlm_common_irqs();
 
-	write_c0_eimr(nlm_irq_mask);
+	write_c0_eimr(nlm_current_node()->irqmask);
 }
 
 void __cpuinit nlm_smp_irq_init(void)
 {
 	/* set interrupt mask for non-zero cpus */
-	write_c0_eimr(nlm_irq_mask);
+	write_c0_eimr(nlm_current_node()->irqmask);
 }
 
 asmlinkage void plat_irq_dispatch(void)
 {
 	uint64_t eirr;
-	int i;
+	int i, node;
 
+	node = nlm_nodeid();
 	eirr = read_c0_eirr() & read_c0_eimr();
 	if (eirr & (1 << IRQ_TIMER)) {
 		do_IRQ(IRQ_TIMER);
 		return;
 	}
-
+#ifdef CONFIG_SMP
+	if (eirr & IRQ_IPI_SMP_FUNCTION) {
+		do_IRQ(IRQ_IPI_SMP_FUNCTION);
+		return;
+	}
+	if (eirr & IRQ_IPI_SMP_RESCHEDULE) {
+		do_IRQ(IRQ_IPI_SMP_RESCHEDULE);
+		return;
+	}
+#endif
 	i = __ilog2_u64(eirr);
 	if (i == -1)
 		return;
 
-	do_IRQ(i);
+	do_IRQ(nlm_irq_to_xirq(node, i));
 }
diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index 4fe8992..e40b467 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -59,12 +59,17 @@
 
 void nlm_send_ipi_single(int logical_cpu, unsigned int action)
 {
-	int cpu = cpu_logical_map(logical_cpu);
+	int cpu, node;
+	uint64_t picbase;
+
+	cpu = cpu_logical_map(logical_cpu);
+	node = cpu / NLM_CPUS_PER_NODE;
+	picbase = nlm_get_node(node)->picbase;
 
 	if (action & SMP_CALL_FUNCTION)
-		nlm_pic_send_ipi(nlm_pic_base, cpu, IRQ_IPI_SMP_FUNCTION, 0);
+		nlm_pic_send_ipi(picbase, cpu, IRQ_IPI_SMP_FUNCTION, 0);
 	if (action & SMP_RESCHEDULE_YOURSELF)
-		nlm_pic_send_ipi(nlm_pic_base, cpu, IRQ_IPI_SMP_RESCHEDULE, 0);
+		nlm_pic_send_ipi(picbase, cpu, IRQ_IPI_SMP_RESCHEDULE, 0);
 }
 
 void nlm_send_ipi_mask(const struct cpumask *mask, unsigned int action)
@@ -96,11 +101,12 @@ void nlm_smp_resched_ipi_handler(unsigned int irq, struct irq_desc *desc)
 void nlm_early_init_secondary(int cpu)
 {
 	change_c0_config(CONF_CM_CMASK, 0x3);
-	write_c0_ebase((uint32_t)nlm_common_ebase);
 #ifdef CONFIG_CPU_XLP
-	if (cpu % 4 == 0)
+	/* mmu init, once per core */
+	if (cpu % NLM_THREADS_PER_CORE == 0)
 		xlp_mmu_init();
 #endif
+	write_c0_ebase(nlm_current_node()->ebase);
 }
 
 /*
@@ -108,7 +114,7 @@ void nlm_early_init_secondary(int cpu)
  */
 static void __cpuinit nlm_init_secondary(void)
 {
-	current_cpu_data.core = hard_smp_processor_id() / 4;
+	current_cpu_data.core = hard_smp_processor_id() / NLM_THREADS_PER_CORE;
 	nlm_smp_irq_init();
 }
 
@@ -142,22 +148,22 @@ cpumask_t phys_cpu_present_map;
 
 void nlm_boot_secondary(int logical_cpu, struct task_struct *idle)
 {
-	unsigned long gp = (unsigned long)task_thread_info(idle);
-	unsigned long sp = (unsigned long)__KSTK_TOS(idle);
-	int cpu = cpu_logical_map(logical_cpu);
+	int cpu, node;
 
-	nlm_next_sp = sp;
-	nlm_next_gp = gp;
+	cpu = cpu_logical_map(logical_cpu);
+	node = cpu / NLM_CPUS_PER_NODE;
+	nlm_next_sp = (unsigned long)__KSTK_TOS(idle);
+	nlm_next_gp = (unsigned long)task_thread_info(idle);
 
-	/* barrier */
+	/* barrier for sp/gp store above */
 	__sync();
-	nlm_pic_send_ipi(nlm_pic_base, cpu, 1, 1);
+	nlm_pic_send_ipi(nlm_get_node(node)->picbase, cpu, 1, 1);  /* NMI */
 }
 
 void __init nlm_smp_setup(void)
 {
 	unsigned int boot_cpu;
-	int num_cpus, i;
+	int num_cpus, i, ncore;
 
 	boot_cpu = hard_smp_processor_id();
 	cpumask_clear(&phys_cpu_present_map);
@@ -182,11 +188,16 @@ void __init nlm_smp_setup(void)
 		}
 	}
 
+	/* check with the cores we have worken up */
+	for (ncore = 0, i = 0; i < NLM_NR_NODES; i++)
+		ncore += hweight32(nlm_get_node(i)->coremask);
+
 	pr_info("Phys CPU present map: %lx, possible map %lx\n",
 		(unsigned long)cpumask_bits(&phys_cpu_present_map)[0],
 		(unsigned long)cpumask_bits(cpu_possible_mask)[0]);
 
-	pr_info("Detected %i Slave CPU(s)\n", num_cpus);
+	pr_info("Detected (%dc%dt) %d Slave CPU(s)\n", ncore,
+		nlm_threads_per_core, num_cpus);
 	nlm_set_nmi_handler(nlm_boot_secondary_cpus);
 }
 
@@ -196,7 +207,7 @@ static int nlm_parse_cpumask(cpumask_t *wakeup_mask)
 	int threadmode, i, j;
 
 	core0_thr_mask = 0;
-	for (i = 0; i < 4; i++)
+	for (i = 0; i < NLM_THREADS_PER_CORE; i++)
 		if (cpumask_test_cpu(i, wakeup_mask))
 			core0_thr_mask |= (1 << i);
 	switch (core0_thr_mask) {
@@ -217,9 +228,9 @@ static int nlm_parse_cpumask(cpumask_t *wakeup_mask)
 	}
 
 	/* Verify other cores CPU masks */
-	for (i = 0; i < NR_CPUS; i += 4) {
+	for (i = 0; i < NR_CPUS; i += NLM_THREADS_PER_CORE) {
 		core_thr_mask = 0;
-		for (j = 0; j < 4; j++)
+		for (j = 0; j < NLM_THREADS_PER_CORE; j++)
 			if (cpumask_test_cpu(i + j, wakeup_mask))
 				core_thr_mask |= (1 << j);
 		if (core_thr_mask != 0 && core_thr_mask != core0_thr_mask)
diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index 6c65ac7..d3a26e7 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -40,23 +40,23 @@
 #include <asm/mipsregs.h>
 #include <asm/time.h>
 
+#include <asm/netlogic/common.h>
 #include <asm/netlogic/haldefs.h>
 #include <asm/netlogic/xlp-hal/iomap.h>
 #include <asm/netlogic/xlp-hal/xlp.h>
 #include <asm/netlogic/xlp-hal/pic.h>
 #include <asm/netlogic/xlp-hal/sys.h>
 
-/* These addresses are computed by the nlm_hal_init() */
-uint64_t nlm_io_base;
-uint64_t nlm_sys_base;
-uint64_t nlm_pic_base;
-
 /* Main initialization */
-void nlm_hal_init(void)
+void nlm_node_init(int node)
 {
-	nlm_io_base = CKSEG1ADDR(XLP_DEFAULT_IO_BASE);
-	nlm_sys_base = nlm_get_sys_regbase(0);	/* node 0 */
-	nlm_pic_base = nlm_get_pic_regbase(0);	/* node 0 */
+	struct nlm_soc_info *nodep;
+
+	nodep = nlm_get_node(node);
+	nodep->sysbase = nlm_get_sys_regbase(node);
+	nodep->picbase = nlm_get_pic_regbase(node);
+	nodep->ebase = read_c0_ebase() & (~((1 << 12) - 1));
+	spin_lock_init(&nodep->piclock);
 }
 
 int nlm_irq_to_irt(int irq)
@@ -138,14 +138,15 @@ int nlm_irt_to_irq(int irt)
 	}
 }
 
-unsigned int nlm_get_core_frequency(int core)
+unsigned int nlm_get_core_frequency(int node, int core)
 {
 	unsigned int pll_divf, pll_divr, dfs_div, ext_div;
 	unsigned int rstval, dfsval, denom;
-	uint64_t num;
+	uint64_t num, sysbase;
 
-	rstval = nlm_read_sys_reg(nlm_sys_base, SYS_POWER_ON_RESET_CFG);
-	dfsval = nlm_read_sys_reg(nlm_sys_base, SYS_CORE_DFS_DIV_VALUE);
+	sysbase = nlm_get_node(node)->sysbase;
+	rstval = nlm_read_sys_reg(sysbase, SYS_POWER_ON_RESET_CFG);
+	dfsval = nlm_read_sys_reg(sysbase, SYS_CORE_DFS_DIV_VALUE);
 	pll_divf = ((rstval >> 10) & 0x7f) + 1;
 	pll_divr = ((rstval >> 8)  & 0x3) + 1;
 	ext_div  = ((rstval >> 30) & 0x3) + 1;
@@ -159,5 +160,5 @@ unsigned int nlm_get_core_frequency(int core)
 
 unsigned int nlm_get_cpu_frequency(void)
 {
-	return nlm_get_core_frequency(0);
+	return nlm_get_core_frequency(0, 0);
 }
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index 9f8d360..465b8d6 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -52,17 +52,17 @@
 #include <asm/netlogic/xlp-hal/xlp.h>
 #include <asm/netlogic/xlp-hal/sys.h>
 
-unsigned long nlm_common_ebase = 0x0;
-
-/* default to uniprocessor */
-uint32_t nlm_coremask = 1;
+uint64_t nlm_io_base;
+struct nlm_soc_info nlm_nodes[NLM_NR_NODES];
 cpumask_t nlm_cpumask = CPU_MASK_CPU0;
-int  nlm_threads_per_core = 1;
+unsigned int nlm_threads_per_core;
 extern u32 __dtb_start[];
 
 static void nlm_linux_exit(void)
 {
-	nlm_write_sys_reg(nlm_sys_base, SYS_CHIP_RESET, 1);
+	uint64_t sysbase = nlm_get_node(0)->sysbase;
+
+	nlm_write_sys_reg(sysbase, SYS_CHIP_RESET, 1);
 	for ( ; ; )
 		cpu_wait();
 }
@@ -110,10 +110,9 @@ void xlp_mmu_init(void)
 
 void __init prom_init(void)
 {
+	nlm_io_base = CKSEG1ADDR(XLP_DEFAULT_IO_BASE);
 	xlp_mmu_init();
-	nlm_hal_init();
-
-	nlm_common_ebase = read_c0_ebase() & (~((1 << 12) - 1));
+	nlm_node_init(0);
 
 #ifdef CONFIG_SMP
 	cpumask_setall(&nlm_cpumask);
diff --git a/arch/mips/netlogic/xlp/wakeup.c b/arch/mips/netlogic/xlp/wakeup.c
index 88ce38d..cb90106 100644
--- a/arch/mips/netlogic/xlp/wakeup.c
+++ b/arch/mips/netlogic/xlp/wakeup.c
@@ -79,32 +79,38 @@ static int xlp_wakeup_core(uint64_t sysbase, int core)
 
 static void xlp_enable_secondary_cores(const cpumask_t *wakeup_mask)
 {
-	uint64_t syspcibase, sysbase;
+	struct nlm_soc_info *nodep;
+	uint64_t syspcibase;
 	uint32_t syscoremask;
-	int core, n;
+	int core, n, cpu;
 
-	for (n = 0; n < 4; n++) {
+	for (n = 0; n < NLM_NR_NODES; n++) {
 		syspcibase = nlm_get_sys_pcibase(n);
 		if (nlm_read_reg(syspcibase, 0) == 0xffffffff)
 			break;
 
 		/* read cores in reset from SYS and account for boot cpu */
-		sysbase = nlm_get_sys_regbase(n);
-		syscoremask = nlm_read_sys_reg(sysbase, SYS_CPU_RESET);
+		nlm_node_init(n);
+		nodep = nlm_get_node(n);
+		syscoremask = nlm_read_sys_reg(nodep->sysbase, SYS_CPU_RESET);
 		if (n == 0)
 			syscoremask |= 1;
 
-		for (core = 0; core < 8; core++) {
+		for (core = 0; core < NLM_CORES_PER_NODE; core++) {
 			/* see if the core exists */
 			if ((syscoremask & (1 << core)) == 0)
 				continue;
 
 			/* see if at least the first thread is enabled */
-			if (!cpumask_test_cpu((n * 8 + core) * 4, wakeup_mask))
+			cpu = (n * NLM_CORES_PER_NODE + core)
+						* NLM_THREADS_PER_CORE;
+			if (!cpumask_test_cpu(cpu, wakeup_mask))
 				continue;
 
 			/* wake up the core */
-			if (!xlp_wakeup_core(sysbase, core))
+			if (xlp_wakeup_core(nodep->sysbase, core))
+				nodep->coremask |= 1u << core;
+			else
 				pr_err("Failed to enable core %d\n", core);
 		}
 	}
diff --git a/arch/mips/netlogic/xlr/setup.c b/arch/mips/netlogic/xlr/setup.c
index 8fca680..696d424 100644
--- a/arch/mips/netlogic/xlr/setup.c
+++ b/arch/mips/netlogic/xlr/setup.c
@@ -51,14 +51,11 @@
 #include <asm/netlogic/xlr/gpio.h>
 
 uint64_t nlm_io_base = DEFAULT_NETLOGIC_IO_BASE;
-uint64_t nlm_pic_base;
 struct psb_info nlm_prom_info;
 
-unsigned long nlm_common_ebase = 0x0;
-
 /* default to uniprocessor */
-uint32_t nlm_coremask = 1;
-int  nlm_threads_per_core = 1;
+unsigned int  nlm_threads_per_core = 1;
+struct nlm_soc_info nlm_nodes[NLM_NR_NODES];
 cpumask_t nlm_cpumask = CPU_MASK_CPU0;
 
 static void __init nlm_early_serial_setup(void)
@@ -177,6 +174,16 @@ static void prom_add_memory(void)
 	}
 }
 
+static void nlm_init_node(void)
+{
+	struct nlm_soc_info *nodep;
+
+	nodep = nlm_current_node();
+	nodep->picbase = nlm_mmio_base(NETLOGIC_IO_PIC_OFFSET);
+	nodep->ebase = read_c0_ebase() & (~((1 << 12) - 1));
+	spin_lock_init(&nodep->piclock);
+}
+
 void __init prom_init(void)
 {
 	int i, *argv, *envp;		/* passed as 32 bit ptrs */
@@ -188,11 +195,10 @@ void __init prom_init(void)
 	prom_infop = (struct psb_info *)(long)(int)fw_arg3;
 
 	nlm_prom_info = *prom_infop;
-	nlm_pic_base = nlm_mmio_base(NETLOGIC_IO_PIC_OFFSET);
+	nlm_init_node();
 
 	nlm_early_serial_setup();
 	build_arcs_cmdline(argv);
-	nlm_common_ebase = read_c0_ebase() & (~((1 << 12) - 1));
 	prom_add_memory();
 
 #ifdef CONFIG_SMP
diff --git a/arch/mips/netlogic/xlr/wakeup.c b/arch/mips/netlogic/xlr/wakeup.c
index 0878924..0cc40b6 100644
--- a/arch/mips/netlogic/xlr/wakeup.c
+++ b/arch/mips/netlogic/xlr/wakeup.c
@@ -50,18 +50,34 @@
 
 int __cpuinit xlr_wakeup_secondary_cpus(void)
 {
-	unsigned int i, boot_cpu;
+	struct nlm_soc_info *nodep;
+	unsigned int i, j, boot_cpu;
 
 	/*
 	 *  In case of RMI boot, hit with NMI to get the cores
 	 *  from bootloader to linux code.
 	 */
+	nodep = nlm_get_node(0);
 	boot_cpu = hard_smp_processor_id();
 	nlm_set_nmi_handler(nlm_rmiboot_preboot);
 	for (i = 0; i < NR_CPUS; i++) {
 		if (i == boot_cpu || !cpumask_test_cpu(i, &nlm_cpumask))
 			continue;
-		nlm_pic_send_ipi(nlm_pic_base, i, 1, 1); /* send NMI */
+		nlm_pic_send_ipi(nodep->picbase, i, 1, 1); /* send NMI */
+	}
+
+	/* Fill up the coremask early */
+	nodep->coremask = 1;
+	for (i = 1; i < NLM_CORES_PER_NODE; i++) {
+		for (j = 1000000; j > 0; j--) {
+			if (nlm_cpu_ready[i * NLM_THREADS_PER_CORE])
+				break;
+			udelay(10);
+		}
+		if (j != 0)
+			nodep->coremask |= (1u << i);
+		else
+			pr_err("Failed to wakeup core %d\n", i);
 	}
 
 	return 0;
-- 
1.7.9.5
