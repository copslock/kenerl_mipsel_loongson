Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 11:36:45 +0200 (CEST)
Received: from smtpbgau1.qq.com ([54.206.16.166]:35159 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994810AbdFPJgitl-Sh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Jun 2017 11:36:38 +0200
X-QQ-mid: bizesmtp9t1497605753tzr7dm5mk
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Fri, 16 Jun 2017 17:34:01 +0800 (CST)
X-QQ-SSF: 01100000002000F0FLF2000A0000000
X-QQ-FEAT: 0ESs8nxzjD+1XOUqmM8/UBbDl0JnAe3bxB5+iyHy+IygvqEOE6KKm4XqSFiyY
        CA2+rjSodkLzBWu8KcR3KZlLyvmEQb4h++MZ2l5/11+ISofxBtvz+eLUg8bzjcnEpEHd3v9
        Q3kQXuUjZ0CpYyprS+cAToLdCZULzYXa/cI0wdAJZek/b55i6CnJxJNb4QOFfonb3F3M1O+
        VVZ4Po7joDyolJcil14mIndguhxMakq1n9MZCYZcM4eQxeDD51wUt2tWspbB3Il+5cGIFYa
        N3+xKt5cjx5V3/kWISWlfqXcnnwzBmEpiu5COVxpNxrj3n
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V6 6/9] MIPS: Loongson-3: support irq_set_affinity() in i8259 chip
Date:   Fri, 16 Jun 2017 17:28:59 +0800
Message-Id: <1497605342-5030-7-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1497605342-5030-1-git-send-email-chenhc@lemote.com>
References: <1497605342-5030-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58519
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
 arch/mips/loongson64/loongson-3/irq.c | 67 ++++++++++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 13 deletions(-)

diff --git a/arch/mips/loongson64/loongson-3/irq.c b/arch/mips/loongson64/loongson-3/irq.c
index 2e6e205..7202e52 100644
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
 
@@ -135,11 +171,16 @@ void irq_router_init(void)
 
 void __init mach_init_irq(void)
 {
+	struct irq_chip *chip;
+
 	clear_c0_status(ST0_IM | ST0_BEV);
 
 	irq_router_init();
 	mips_cpu_irq_init();
 	init_i8259_irqs();
+	chip = irq_get_chip(I8259A_IRQ_BASE);
+	chip->irq_set_affinity = plat_set_irq_affinity;
+
 	irq_set_chip_and_handler(LOONGSON_UART_IRQ,
 			&loongson_irq_chip, handle_level_irq);
 
-- 
2.7.0
