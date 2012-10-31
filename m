Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 14:02:23 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:2705 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825751Ab2JaM6zfqBiU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 Oct 2012 13:58:55 +0100
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 31 Oct 2012 05:56:59 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Wed, 31 Oct 2012 05:58:17 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id E021740FE3; Wed, 31
 Oct 2012 05:58:45 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 14/15] MIPS: Netlogic: PIC IRQ handling update for
 multi-chip
Date:   Wed, 31 Oct 2012 18:31:41 +0530
Message-ID: <4d185b6939d74daeb3868bfd2c9457b36e174267.1351688140.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1351688140.git.jchandra@broadcom.com>
References: <cover.1351688140.git.jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7C8FFF913QC1968471-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 34806
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

Create struct nlm_pic_irq for interrupts handled by the PIC.
This simplifies IRQ handling for multi-SoC as well as
the single SoC cases. Also split the setup of percpu and PIC
interrupts so that we can configure the PIC interrupts for
every node.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/common.h      |    2 +-
 arch/mips/include/asm/netlogic/xlp-hal/pic.h |    1 -
 arch/mips/netlogic/common/irq.c              |  170 +++++++++++++++-----------
 arch/mips/netlogic/common/smp.c              |    7 +-
 arch/mips/netlogic/xlp/nlm_hal.c             |   38 ------
 5 files changed, 103 insertions(+), 115 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/common.h b/arch/mips/include/asm/netlogic/common.h
index 3c6814e..1fee7ef 100644
--- a/arch/mips/include/asm/netlogic/common.h
+++ b/arch/mips/include/asm/netlogic/common.h
@@ -53,7 +53,7 @@
 struct irq_desc;
 void nlm_smp_function_ipi_handler(unsigned int irq, struct irq_desc *desc);
 void nlm_smp_resched_ipi_handler(unsigned int irq, struct irq_desc *desc);
-void nlm_smp_irq_init(void);
+void nlm_smp_irq_init(int hwcpuid);
 void nlm_boot_secondary_cpus(void);
 int nlm_wakeup_secondary_cpus(void);
 void nlm_rmiboot_preboot(void);
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/pic.h b/arch/mips/include/asm/netlogic/xlp-hal/pic.h
index 857a967..b2e53a5 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/pic.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/pic.h
@@ -382,7 +382,6 @@ nlm_pic_init_irt(uint64_t base, int irt, int irq, int hwt)
 }
 
 int nlm_irq_to_irt(int irq);
-int nlm_irt_to_irq(int irt);
 
 #endif /* __ASSEMBLY__ */
 #endif /* _NLM_HAL_PIC_H */
diff --git a/arch/mips/netlogic/common/irq.c b/arch/mips/netlogic/common/irq.c
index 4d6bd8f..b89d5a6 100644
--- a/arch/mips/netlogic/common/irq.c
+++ b/arch/mips/netlogic/common/irq.c
@@ -36,7 +36,6 @@
 #include <linux/init.h>
 #include <linux/linkage.h>
 #include <linux/interrupt.h>
-#include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/irq.h>
@@ -62,68 +61,66 @@
 #else
 #error "Unknown CPU"
 #endif
-/*
- * These are the routines that handle all the low level interrupt stuff.
- * Actions handled here are: initialization of the interrupt map, requesting of
- * interrupt lines by handlers, dispatching if interrupts to handlers, probing
- * for interrupt lines
- */
 
-/* Globals */
+#ifdef CONFIG_SMP
+#define SMP_IRQ_MASK	((1ULL << IRQ_IPI_SMP_FUNCTION) | \
+				 (1ULL << IRQ_IPI_SMP_RESCHEDULE))
+#else
+#define SMP_IRQ_MASK	0
+#endif
+#define PERCPU_IRQ_MASK	(SMP_IRQ_MASK | (1ull << IRQ_TIMER))
+
+
+struct nlm_pic_irq {
+	void	(*extra_ack)(struct irq_data *);
+	struct	nlm_soc_info *node;
+	int	picirq;
+	int	irt;
+	int	flags;
+};
+
 static void xlp_pic_enable(struct irq_data *d)
 {
 	unsigned long flags;
-	struct nlm_soc_info *nodep;
-	int irt;
+	struct nlm_pic_irq *pd = irq_data_get_irq_handler_data(d);
 
-	nodep = nlm_current_node();
-	irt = nlm_irq_to_irt(d->irq);
-	if (irt == -1)
-		return;
-	spin_lock_irqsave(&nodep->piclock, flags);
-	nlm_pic_enable_irt(nodep->picbase, irt);
-	spin_unlock_irqrestore(&nodep->piclock, flags);
+	BUG_ON(!pd);
+	spin_lock_irqsave(&pd->node->piclock, flags);
+	nlm_pic_enable_irt(pd->node->picbase, pd->irt);
+	spin_unlock_irqrestore(&pd->node->piclock, flags);
 }
 
 static void xlp_pic_disable(struct irq_data *d)
 {
-	struct nlm_soc_info *nodep;
+	struct nlm_pic_irq *pd = irq_data_get_irq_handler_data(d);
 	unsigned long flags;
-	int irt;
 
-	nodep = nlm_current_node();
-	irt = nlm_irq_to_irt(d->irq);
-	if (irt == -1)
-		return;
-	spin_lock_irqsave(&nodep->piclock, flags);
-	nlm_pic_disable_irt(nodep->picbase, irt);
-	spin_unlock_irqrestore(&nodep->piclock, flags);
+	BUG_ON(!pd);
+	spin_lock_irqsave(&pd->node->piclock, flags);
+	nlm_pic_disable_irt(pd->node->picbase, pd->irt);
+	spin_unlock_irqrestore(&pd->node->piclock, flags);
 }
 
 static void xlp_pic_mask_ack(struct irq_data *d)
 {
-	uint64_t mask = 1ull << d->irq;
+	struct nlm_pic_irq *pd = irq_data_get_irq_handler_data(d);
+	uint64_t mask = 1ull << pd->picirq;
 
 	write_c0_eirr(mask);            /* ack by writing EIRR */
 }
 
 static void xlp_pic_unmask(struct irq_data *d)
 {
-	void *hd = irq_data_get_irq_handler_data(d);
-	struct nlm_soc_info *nodep;
-	int irt;
+	struct nlm_pic_irq *pd = irq_data_get_irq_handler_data(d);
 
-	nodep = nlm_current_node();
-	irt = nlm_irq_to_irt(d->irq);
-	if (irt == -1)
+	if (!pd)
 		return;
 
-	if (hd) {
-		void (*extra_ack)(void *) = hd;
-		extra_ack(d);
-	}
+	if (pd->extra_ack)
+		pd->extra_ack(d);
+
 	/* Ack is a single write, no need to lock */
-	nlm_pic_ack(nodep->picbase, irt);
+	nlm_pic_ack(pd->node->picbase, pd->irt);
 }
 
 static struct irq_chip xlp_pic = {
@@ -177,51 +174,84 @@ struct irq_chip nlm_cpu_intr = {
 	.irq_eoi	= cpuintr_ack,
 };
 
-void __init init_nlm_common_irqs(void)
+static void __init nlm_init_percpu_irqs(void)
 {
-	int i, irq, irt;
-	uint64_t irqmask;
-	struct nlm_soc_info *nodep;
+	int i;
 
-	nodep = nlm_current_node();
-	irqmask = (1ULL << IRQ_TIMER);
 	for (i = 0; i < PIC_IRT_FIRST_IRQ; i++)
 		irq_set_chip_and_handler(i, &nlm_cpu_intr, handle_percpu_irq);
-
-	for (i = PIC_IRT_FIRST_IRQ; i <= PIC_IRT_LAST_IRQ ; i++)
-		irq_set_chip_and_handler(i, &xlp_pic, handle_level_irq);
-
 #ifdef CONFIG_SMP
 	irq_set_chip_and_handler(IRQ_IPI_SMP_FUNCTION, &nlm_cpu_intr,
 			 nlm_smp_function_ipi_handler);
 	irq_set_chip_and_handler(IRQ_IPI_SMP_RESCHEDULE, &nlm_cpu_intr,
 			 nlm_smp_resched_ipi_handler);
-	irqmask |=
-	    ((1ULL << IRQ_IPI_SMP_FUNCTION) | (1ULL << IRQ_IPI_SMP_RESCHEDULE));
 #endif
+}
+
+void nlm_setup_pic_irq(int node, int picirq, int irq, int irt)
+{
+	struct nlm_pic_irq *pic_data;
+	int xirq;
+
+	xirq = nlm_irq_to_xirq(node, irq);
+	pic_data = kzalloc(sizeof(*pic_data), GFP_KERNEL);
+	BUG_ON(pic_data == NULL);
+	pic_data->irt = irt;
+	pic_data->picirq = picirq;
+	pic_data->node = nlm_get_node(node);
+	irq_set_chip_and_handler(xirq, &xlp_pic, handle_level_irq);
+	irq_set_handler_data(xirq, pic_data);
+}
 
-	for (irq = PIC_IRT_FIRST_IRQ; irq <= PIC_IRT_LAST_IRQ; irq++) {
-		irt = nlm_irq_to_irt(irq);
+void nlm_set_pic_extra_ack(int node, int irq, void (*xack)(struct irq_data *))
+{
+	struct nlm_pic_irq *pic_data;
+	int xirq;
+
+	xirq = nlm_irq_to_xirq(node, irq);
+	pic_data = irq_get_handler_data(xirq);
+	pic_data->extra_ack = xack;
+}
+
+static void nlm_init_node_irqs(int node)
+{
+	int i, irt;
+	uint64_t irqmask;
+	struct nlm_soc_info *nodep;
+
+	pr_info("Init IRQ for node %d\n", node);
+	nodep = nlm_get_node(node);
+	irqmask = PERCPU_IRQ_MASK;
+	for (i = PIC_IRT_FIRST_IRQ; i <= PIC_IRT_LAST_IRQ; i++) {
+		irt = nlm_irq_to_irt(i);
 		if (irt == -1)
 			continue;
-		irqmask |= (1ULL << irq);
-		nlm_pic_init_irt(nodep->picbase, irt, irq, 0);
+		nlm_setup_pic_irq(node, i, i, irt);
+		/* set interrupts to first cpu in node */
+		nlm_pic_init_irt(nodep->picbase, irt, i,
+					node * NLM_CPUS_PER_NODE);
+		irqmask |= (1ull << i);
 	}
-
 	nodep->irqmask = irqmask;
 }
 
 void __init arch_init_irq(void)
 {
 	/* Initialize the irq descriptors */
-	init_nlm_common_irqs();
-
+	nlm_init_percpu_irqs();
+	nlm_init_node_irqs(0);
 	write_c0_eimr(nlm_current_node()->irqmask);
 }
 
-void __cpuinit nlm_smp_irq_init(void)
+void nlm_smp_irq_init(int hwcpuid)
 {
-	/* set interrupt mask for non-zero cpus */
+	int node, cpu;
+
+	node = hwcpuid / NLM_CPUS_PER_NODE;
+	cpu  = hwcpuid % NLM_CPUS_PER_NODE;
+
+	if (cpu == 0 && node != 0)
+		nlm_init_node_irqs(node);
 	write_c0_eimr(nlm_current_node()->irqmask);
 }
 
@@ -232,23 +262,17 @@ asmlinkage void plat_irq_dispatch(void)
 
 	node = nlm_nodeid();
 	eirr = read_c0_eirr() & read_c0_eimr();
-	if (eirr & (1 << IRQ_TIMER)) {
-		do_IRQ(IRQ_TIMER);
-		return;
-	}
-#ifdef CONFIG_SMP
-	if (eirr & IRQ_IPI_SMP_FUNCTION) {
-		do_IRQ(IRQ_IPI_SMP_FUNCTION);
-		return;
-	}
-	if (eirr & IRQ_IPI_SMP_RESCHEDULE) {
-		do_IRQ(IRQ_IPI_SMP_RESCHEDULE);
-		return;
-	}
-#endif
+
 	i = __ilog2_u64(eirr);
 	if (i == -1)
 		return;
 
+	/* per-CPU IRQs don't need translation */
+	if (eirr & PERCPU_IRQ_MASK) {
+		do_IRQ(i);
+		return;
+	}
+
+	/* top level irq handling */
 	do_IRQ(nlm_irq_to_xirq(node, i));
 }
diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index e40b467..0315b29 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -114,8 +114,11 @@ void nlm_early_init_secondary(int cpu)
  */
 static void __cpuinit nlm_init_secondary(void)
 {
-	current_cpu_data.core = hard_smp_processor_id() / NLM_THREADS_PER_CORE;
-	nlm_smp_irq_init();
+	int hwtid;
+
+	hwtid = hard_smp_processor_id();
+	current_cpu_data.core = hwtid / NLM_THREADS_PER_CORE;
+	nlm_smp_irq_init(hwtid);
 }
 
 void nlm_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index d3a26e7..529e747 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -100,44 +100,6 @@ int nlm_irq_to_irt(int irq)
 	}
 }
 
-int nlm_irt_to_irq(int irt)
-{
-	switch (irt) {
-	case PIC_IRT_UART_0_INDEX:
-		return PIC_UART_0_IRQ;
-	case PIC_IRT_UART_1_INDEX:
-		return PIC_UART_1_IRQ;
-	case PIC_IRT_PCIE_LINK_0_INDEX:
-	       return PIC_PCIE_LINK_0_IRQ;
-	case PIC_IRT_PCIE_LINK_1_INDEX:
-	       return PIC_PCIE_LINK_1_IRQ;
-	case PIC_IRT_PCIE_LINK_2_INDEX:
-	       return PIC_PCIE_LINK_2_IRQ;
-	case PIC_IRT_PCIE_LINK_3_INDEX:
-	       return PIC_PCIE_LINK_3_IRQ;
-	case PIC_IRT_EHCI_0_INDEX:
-		return PIC_EHCI_0_IRQ;
-	case PIC_IRT_EHCI_1_INDEX:
-		return PIC_EHCI_1_IRQ;
-	case PIC_IRT_OHCI_0_INDEX:
-		return PIC_OHCI_0_IRQ;
-	case PIC_IRT_OHCI_1_INDEX:
-		return PIC_OHCI_1_IRQ;
-	case PIC_IRT_OHCI_2_INDEX:
-		return PIC_OHCI_2_IRQ;
-	case PIC_IRT_OHCI_3_INDEX:
-		return PIC_OHCI_3_IRQ;
-	case PIC_IRT_MMC_INDEX:
-	       return PIC_MMC_IRQ;
-	case PIC_IRT_I2C_0_INDEX:
-		return PIC_I2C_0_IRQ;
-	case PIC_IRT_I2C_1_INDEX:
-		return PIC_I2C_1_IRQ;
-	default:
-		return -1;
-	}
-}
-
 unsigned int nlm_get_core_frequency(int node, int core)
 {
 	unsigned int pll_divf, pll_divr, dfs_div, ext_div;
-- 
1.7.9.5
