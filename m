Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2015 13:27:54 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25667 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011975AbbLBMWlmVLVA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Dec 2015 13:22:41 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 330FD881EF86E;
        Wed,  2 Dec 2015 12:22:31 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 2 Dec 2015 12:22:33 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 2 Dec 2015 12:22:32 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH v3 16/19] MIPS: Add generic SMP IPI support
Date:   Wed, 2 Dec 2015 12:21:57 +0000
Message-ID: <1449058920-21011-17-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1449058920-21011-1-git-send-email-qais.yousef@imgtec.com>
References: <1449058920-21011-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

Use the new generic IPI layer to provide generic SMP IPI support if the irqchip
supports it.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 arch/mips/kernel/smp.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index bd4385a8e6e8..c012e1903f6b 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -33,12 +33,16 @@
 #include <linux/cpu.h>
 #include <linux/err.h>
 #include <linux/ftrace.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
 
 #include <linux/atomic.h>
 #include <asm/cpu.h>
 #include <asm/processor.h>
 #include <asm/idle.h>
 #include <asm/r4k-timer.h>
+#include <asm/mips-cpc.h>
 #include <asm/mmu_context.h>
 #include <asm/time.h>
 #include <asm/setup.h>
@@ -79,6 +83,11 @@ static cpumask_t cpu_core_setup_map;
 
 cpumask_t cpu_coherent_mask;
 
+#ifdef CONFIG_GENERIC_IRQ_IPI
+static struct irq_desc *call_desc;
+static struct irq_desc *sched_desc;
+#endif
+
 static inline void set_cpu_sibling_map(int cpu)
 {
 	int i;
@@ -145,6 +154,133 @@ void register_smp_ops(struct plat_smp_ops *ops)
 	mp_ops = ops;
 }
 
+#ifdef CONFIG_GENERIC_IRQ_IPI
+void mips_smp_send_ipi_single(int cpu, unsigned int action)
+{
+	mips_smp_send_ipi_mask(cpumask_of(cpu), action);
+}
+
+void mips_smp_send_ipi_mask(const struct cpumask *mask, unsigned int action)
+{
+	unsigned long flags;
+	unsigned int core;
+	int cpu;
+
+	local_irq_save(flags);
+
+	switch (action) {
+	case SMP_CALL_FUNCTION:
+		__ipi_send_mask(call_desc, mask);
+		break;
+
+	case SMP_RESCHEDULE_YOURSELF:
+		__ipi_send_mask(sched_desc, mask);
+		break;
+
+	default:
+		BUG();
+	}
+
+	if (mips_cpc_present()) {
+		for_each_cpu(cpu, mask) {
+			core = cpu_data[cpu].core;
+
+			if (core == current_cpu_data.core)
+				continue;
+
+			while (!cpumask_test_cpu(cpu, &cpu_coherent_mask)) {
+				mips_cpc_lock_other(core);
+				write_cpc_co_cmd(CPC_Cx_CMD_PWRUP);
+				mips_cpc_unlock_other();
+			}
+		}
+	}
+
+	local_irq_restore(flags);
+}
+
+
+static irqreturn_t ipi_resched_interrupt(int irq, void *dev_id)
+{
+	scheduler_ipi();
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ipi_call_interrupt(int irq, void *dev_id)
+{
+	generic_smp_call_function_interrupt();
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction irq_resched = {
+	.handler	= ipi_resched_interrupt,
+	.flags		= IRQF_PERCPU,
+	.name		= "IPI resched"
+};
+
+static struct irqaction irq_call = {
+	.handler	= ipi_call_interrupt,
+	.flags		= IRQF_PERCPU,
+	.name		= "IPI call"
+};
+
+static __init void smp_ipi_init_one(unsigned int virq,
+				    struct irqaction *action)
+{
+	int ret;
+
+	irq_set_handler(virq, handle_percpu_irq);
+	ret = setup_irq(virq, action);
+	BUG_ON(ret);
+}
+
+static int __init mips_smp_ipi_init(void)
+{
+	unsigned int call_virq, sched_virq;
+	struct irq_domain *ipidomain;
+	struct device_node *node;
+
+	node = of_irq_find_parent(of_root);
+	ipidomain = irq_find_matching_host(node, DOMAIN_BUS_IPI);
+
+	/*
+	 * Some platforms have half DT setup. So if we found irq node but
+	 * didn't find an ipidomain, try to search for one that is not in the
+	 * DT.
+	 */
+	if (node && !ipidomain)
+		ipidomain = irq_find_matching_host(NULL, DOMAIN_BUS_IPI);
+
+	BUG_ON(!ipidomain);
+
+	call_virq = irq_reserve_ipi(ipidomain, cpu_possible_mask);
+	BUG_ON(!call_virq);
+
+	sched_virq = irq_reserve_ipi(ipidomain, cpu_possible_mask);
+	BUG_ON(!sched_virq);
+
+	if (irq_domain_is_ipi_per_cpu(ipidomain)) {
+		int cpu;
+
+		for_each_cpu(cpu, cpu_possible_mask) {
+			smp_ipi_init_one(call_virq + cpu, &irq_call);
+			smp_ipi_init_one(sched_virq + cpu, &irq_resched);
+		}
+	} else {
+		smp_ipi_init_one(call_virq, &irq_call);
+		smp_ipi_init_one(sched_virq, &irq_resched);
+	}
+
+	call_desc = irq_to_desc(call_virq);
+	sched_desc = irq_to_desc(sched_virq);
+
+	return 0;
+}
+early_initcall(mips_smp_ipi_init);
+#endif
+
 /*
  * First C code run on the secondary CPUs after being started up by
  * the master.
-- 
2.1.0
