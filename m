Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 11:03:24 +0100 (CET)
Received: from torg.zytor.com ([198.137.202.12]:44300 "EHLO terminus.zytor.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010007AbcBYKDWzfr0m (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Feb 2016 11:03:22 +0100
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTP id u1PA2vCK000953;
        Thu, 25 Feb 2016 02:03:02 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.14.8/Submit) id u1PA2vP5000948;
        Thu, 25 Feb 2016 02:02:57 -0800
Date:   Thu, 25 Feb 2016 02:02:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qais Yousef <tipbot@zytor.com>
Message-ID: <tip-f9bce791ae2a1a10a965b30427f5507c1a77669f@git.kernel.org>
Cc:     lisa.parratt@imgtec.com, qsyousef@gmail.com, mingo@kernel.org,
        tglx@linutronix.de, linux-mips@linux-mips.org,
        jason@lakedaemon.net, linux-kernel@vger.kernel.org, hpa@zytor.com,
        marc.zyngier@arm.com, jiang.liu@linux.intel.com,
        qais.yousef@imgtec.com, ralf@linux-mips.org
Reply-To: lisa.parratt@imgtec.com, qsyousef@gmail.com, mingo@kernel.org,
          tglx@linutronix.de, jason@lakedaemon.net,
          linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
          hpa@zytor.com, marc.zyngier@arm.com, jiang.liu@linux.intel.com,
          qais.yousef@imgtec.com, ralf@linux-mips.org
In-Reply-To: <1449580830-23652-10-git-send-email-qais.yousef@imgtec.com>
References: <1449580830-23652-10-git-send-email-qais.yousef@imgtec.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Add a new function to get IPI reverse
 mapping
Git-Commit-ID: f9bce791ae2a1a10a965b30427f5507c1a77669f
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
X-archive-position: 52244
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

Commit-ID:  f9bce791ae2a1a10a965b30427f5507c1a77669f
Gitweb:     http://git.kernel.org/tip/f9bce791ae2a1a10a965b30427f5507c1a77669f
Author:     Qais Yousef <qais.yousef@imgtec.com>
AuthorDate: Tue, 8 Dec 2015 13:20:20 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Feb 2016 10:56:56 +0100

genirq: Add a new function to get IPI reverse mapping

When dealing with coprocessors we need to find out the actual hwirqs values to
pass on to the firmware so that it knows what it needs to use to receive IPIs
from and send IPIs to Linux cpus.

[ tglx: Fixed the single hwirq IPI case. The hardware irq number does not
  	change due to the cpu number ]

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Cc: <jason@lakedaemon.net>
Cc: <marc.zyngier@arm.com>
Cc: <jiang.liu@linux.intel.com>
Cc: <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
Cc: <lisa.parratt@imgtec.com>
Cc: Qais Yousef <qsyousef@gmail.com>
Link: http://lkml.kernel.org/r/1449580830-23652-10-git-send-email-qais.yousef@imgtec.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h |  1 +
 kernel/irq/ipi.c    | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 95f4f66..10273dc 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -942,5 +942,6 @@ static inline u32 irq_reg_readl(struct irq_chip_generic *gc,
 
 /* Contrary to Linux irqs, for hardware irqs the irq number 0 is valid */
 #define INVALID_HWIRQ	(~0UL)
+irq_hw_number_t ipi_get_hwirq(unsigned int irq, unsigned int cpu);
 
 #endif /* _LINUX_IRQ_H */
diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
index 340af27..6f34f29 100644
--- a/kernel/irq/ipi.c
+++ b/kernel/irq/ipi.c
@@ -135,3 +135,37 @@ void irq_destroy_ipi(unsigned int irq)
 
 	irq_domain_free_irqs(irq, nr_irqs);
 }
+
+/**
+ * ipi_get_hwirq - Get the hwirq associated with an IPI to a cpu
+ * @irq:	linux irq number
+ * @cpu:	the target cpu
+ *
+ * When dealing with coprocessors IPI, we need to inform the coprocessor of
+ * the hwirq it needs to use to receive and send IPIs.
+ *
+ * Returns hwirq value on success and INVALID_HWIRQ on failure.
+ */
+irq_hw_number_t ipi_get_hwirq(unsigned int irq, unsigned int cpu)
+{
+	struct irq_data *data = irq_get_irq_data(irq);
+	struct cpumask *ipimask = data ? irq_data_get_affinity_mask(data) : NULL;
+
+	if (!data || !ipimask || cpu > nr_cpu_ids)
+		return INVALID_HWIRQ;
+
+	if (!cpumask_test_cpu(cpu, ipimask))
+		return INVALID_HWIRQ;
+
+	/*
+	 * Get the real hardware irq number if the underlying implementation
+	 * uses a seperate irq per cpu. If the underlying implementation uses
+	 * a single hardware irq for all cpus then the IPI send mechanism
+	 * needs to take care of this.
+	 */
+	if (irq_domain_is_ipi_per_cpu(data->domain))
+		data = irq_get_irq_data(irq + cpu - data->common->ipi_offset);
+
+	return data ? irqd_to_hwirq(data) : INVALID_HWIRQ;
+}
+EXPORT_SYMBOL_GPL(ipi_get_hwirq);
