Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 11:05:40 +0100 (CET)
Received: from torg.zytor.com ([198.137.202.12]:44506 "EHLO terminus.zytor.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012712AbcBYKFiJIFzm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Feb 2016 11:05:38 +0100
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTP id u1PA5GUa003130;
        Thu, 25 Feb 2016 02:05:21 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.14.8/Submit) id u1PA5GNA003126;
        Thu, 25 Feb 2016 02:05:16 -0800
Date:   Thu, 25 Feb 2016 02:05:16 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qais Yousef <tipbot@zytor.com>
Message-ID: <tip-fbde2d7d8290d8c642d591a471356abda2446874@git.kernel.org>
Cc:     jiang.liu@linux.intel.com, mingo@kernel.org, marc.zyngier@arm.com,
        qais.yousef@imgtec.com, lisa.parratt@imgtec.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, linux-mips@linux-mips.org, hpa@zytor.com,
        jason@lakedaemon.net, qsyousef@gmail.com
Reply-To: linux-kernel@vger.kernel.org, ralf@linux-mips.org,
          linux-mips@linux-mips.org, hpa@zytor.com, jason@lakedaemon.net,
          qsyousef@gmail.com, mingo@kernel.org, jiang.liu@linux.intel.com,
          marc.zyngier@arm.com, qais.yousef@imgtec.com,
          lisa.parratt@imgtec.com, tglx@linutronix.de
In-Reply-To: <1449580830-23652-17-git-send-email-qais.yousef@imgtec.com>
References: <1449580830-23652-17-git-send-email-qais.yousef@imgtec.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] MIPS: Add generic SMP IPI support
Git-Commit-ID: fbde2d7d8290d8c642d591a471356abda2446874
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Precedence: bulk
Return-Path: <tipbot@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52251
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tipbot@zytor.com
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

Commit-ID:  fbde2d7d8290d8c642d591a471356abda2446874
Gitweb:     http://git.kernel.org/tip/fbde2d7d8290d8c642d591a471356abda2446874
Author:     Qais Yousef <qais.yousef@imgtec.com>
AuthorDate: Tue, 8 Dec 2015 13:20:27 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Feb 2016 10:56:58 +0100

MIPS: Add generic SMP IPI support

Use the new generic IPI layer to provide generic SMP IPI support if the irqchip
supports it.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
Cc: <jason@lakedaemon.net>
Cc: <marc.zyngier@arm.com>
Cc: <jiang.liu@linux.intel.com>
Cc: <linux-mips@linux-mips.org>
Cc: <lisa.parratt@imgtec.com>
Cc: Qais Yousef <qsyousef@gmail.com>
Link: http://lkml.kernel.org/r/1449580830-23652-17-git-send-email-qais.yousef@imgtec.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/kernel/smp.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index bd4385a..c012e19 100644
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
