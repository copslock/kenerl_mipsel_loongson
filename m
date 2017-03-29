Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Mar 2017 10:28:54 +0200 (CEST)
Received: from smtpbg65.qq.com ([103.7.28.233]:59659 "EHLO smtpbg65.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993612AbdC2I2rN43KX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Mar 2017 10:28:47 +0200
X-QQ-mid: bizesmtp1t1490776100tqnk4y4vu
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 29 Mar 2017 16:27:16 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK82000A0000000
X-QQ-FEAT: AoS+/v7jDMa+bS/SIiG7ywG+K2a+AS9Wf3psngXZecPB0C39GKKXcvdHfbldd
        EXDa+/tqCAelti1fIE+KzZt3T2hoc7YewbIqDvbUKTyaN6ELmQFCTxyx+6UVKfEyCFFzvQt
        +LgvexWmjMZ4HD+LLX8tuJmSEYZVfNuIZqjwWAozkyCA4+OCbnayKmvs8tBI/ZtXg+JXvqL
        kGGtQLROktXuFjnNoOk7lZodz4vcmM+7aVA3FxRVduHTLHXCxY9/ECcH/aTbbL6N3u0bWGR
        TTChWN4HB4FRsMmE1/dMVEwuCMtz54purfVQ1fCZnTXvTl
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V3 5/8] MIPS: Loongson-3: support irq_set_affinity() in i8259 chip
Date:   Wed, 29 Mar 2017 16:24:33 +0800
Message-Id: <1490775876-29918-6-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1490775876-29918-1-git-send-email-chenhc@lemote.com>
References: <1490775876-29918-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

With this patch we can set irq affinity via procfs, so as to improve
network performance.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/irq.h           |  3 ++
 arch/mips/loongson64/loongson-3/irq.c | 62 +++++++++++++++++++++++++++--------
 drivers/irqchip/irq-i8259.c           |  3 ++
 3 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index ddd1c91..47ff7c6 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -53,6 +53,7 @@ static inline int irq_canonicalize(int irq)
 #define irq_canonicalize(irq) (irq)	/* Sane hardware, sane code ... */
 #endif
 
+struct irq_data;
 asmlinkage void plat_irq_dispatch(void);
 
 extern void do_IRQ(unsigned int irq);
@@ -63,6 +64,8 @@ extern void spurious_interrupt(void);
 extern int allocate_irqno(void);
 extern void alloc_legacy_irqno(void);
 extern void free_irqno(unsigned int irq);
+extern int plat_set_irq_affinity(struct irq_data *d,
+				 const struct cpumask *affinity, bool force);
 
 /*
  * Before R2 the timer and performance counter interrupts were both fixed to
diff --git a/arch/mips/loongson64/loongson-3/irq.c b/arch/mips/loongson64/loongson-3/irq.c
index 2e6e205..e8b7a47 100644
--- a/arch/mips/loongson64/loongson-3/irq.c
+++ b/arch/mips/loongson64/loongson-3/irq.c
@@ -10,32 +10,68 @@
 #include "smp.h"
 
 extern void loongson3_send_irq_by_ipi(int cpu, int irqs);
+
+unsigned int irq_cpu[16] = {[0 ... 15] = -1};
 unsigned int ht_irq[] = {0, 1, 3, 4, 5, 6, 7, 8, 12, 14, 15};
 unsigned int local_irq = 1<<0 | 1<<1 | 1<<2 | 1<<7 | 1<<8 | 1<<12;
 
+int plat_set_irq_affinity(struct irq_data *d, const struct cpumask *affinity,
+			  bool force)
+{
+	unsigned int cpu;
+	struct cpumask new_affinity;
+
+	/* I/O devices are connected on package-0 */
+	cpumask_copy(&new_affinity, affinity);
+	for_each_cpu(cpu, affinity)
+		if (cpu_data[cpu].package > 0)
+			cpumask_clear_cpu(cpu, &new_affinity);
+
+	if (cpumask_empty(&new_affinity))
+		return -EINVAL;
+
+	cpumask_copy(d->common->affinity, &new_affinity);
+
+	return IRQ_SET_MASK_OK_NOCOPY;
+}
+
 static void ht_irqdispatch(void)
 {
-	unsigned int i, irq, irq0, irq1;
-	static unsigned int dest_cpu = 0;
+	unsigned int i, irq;
+	struct irq_data *irqd;
+	struct cpumask affinity;
 
 	irq = LOONGSON_HT1_INT_VECTOR(0);
 	LOONGSON_HT1_INT_VECTOR(0) = irq; /* Acknowledge the IRQs */
 
-	irq0 = irq & local_irq;  /* handled by local core */
-	irq1 = irq & ~local_irq; /* balanced by other cores */
+	for (i = 0; i < ARRAY_SIZE(ht_irq); i++) {
+		if (!(irq & (0x1 << ht_irq[i])))
+			continue;
 
-	if (dest_cpu == 0 || !cpu_online(dest_cpu))
-		irq0 |= irq1;
-	else
-		loongson3_send_irq_by_ipi(dest_cpu, irq1);
+		/* handled by local core */
+		if (local_irq & (0x1 << ht_irq[i])) {
+			do_IRQ(ht_irq[i]);
+			continue;
+		}
 
-	dest_cpu = dest_cpu + 1;
-	if (dest_cpu >= num_possible_cpus() || cpu_data[dest_cpu].package > 0)
-		dest_cpu = 0;
+		irqd = irq_get_irq_data(ht_irq[i]);
+		cpumask_and(&affinity, irqd->common->affinity, cpu_active_mask);
+		if (cpumask_empty(&affinity)) {
+			do_IRQ(ht_irq[i]);
+			continue;
+		}
 
-	for (i = 0; i < ARRAY_SIZE(ht_irq); i++) {
-		if (irq0 & (0x1 << ht_irq[i]))
+		irq_cpu[ht_irq[i]] = cpumask_next(irq_cpu[ht_irq[i]], &affinity);
+		if (irq_cpu[ht_irq[i]] >= nr_cpu_ids)
+			irq_cpu[ht_irq[i]] = cpumask_first(&affinity);
+
+		if (irq_cpu[ht_irq[i]] == 0) {
 			do_IRQ(ht_irq[i]);
+			continue;
+		}
+
+		/* balanced by other cores */
+		loongson3_send_irq_by_ipi(irq_cpu[ht_irq[i]], (0x1 << ht_irq[i]));
 	}
 }
 
diff --git a/drivers/irqchip/irq-i8259.c b/drivers/irqchip/irq-i8259.c
index 1aec12c..95d21e3 100644
--- a/drivers/irqchip/irq-i8259.c
+++ b/drivers/irqchip/irq-i8259.c
@@ -46,6 +46,9 @@ static struct irq_chip i8259A_chip = {
 	.irq_disable		= disable_8259A_irq,
 	.irq_unmask		= enable_8259A_irq,
 	.irq_mask_ack		= mask_and_ack_8259A,
+#ifdef CONFIG_CPU_LOONGSON3
+	.irq_set_affinity	= plat_set_irq_affinity,
+#endif
 };
 
 /*
-- 
2.7.0
