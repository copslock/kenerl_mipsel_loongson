Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 06:50:31 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56488 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994815AbdHMErqp0uJd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 06:47:46 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 7CD55188D7F55;
        Sun, 13 Aug 2017 05:47:38 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 05:47:40 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 34/38] irqchip: mips-gic: Make pcpu_masks a per-cpu variable
Date:   Sat, 12 Aug 2017 21:36:42 -0700
Message-ID: <20170813043646.25821-35-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170813043646.25821-1-paul.burton@imgtec.com>
References: <20170813043646.25821-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.142]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Define the pcpu_masks variable using the kernel's standard per-cpu
variable support, rather than an open-coded array of structs containing
bitmaps.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---

 drivers/irqchip/irq-mips-gic.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index feff4bf97577..00153231376a 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -13,6 +13,7 @@
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/of_address.h>
+#include <linux/percpu.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
 
@@ -23,6 +24,7 @@
 #include <dt-bindings/interrupt-controller/mips-gic.h>
 
 #define GIC_MAX_INTRS		256
+#define GIC_MAX_LONGS		BITS_TO_LONGS(GIC_MAX_INTRS)
 
 /* Add 2 to convert GIC CPU pin to core interrupt */
 #define GIC_CPU_PIN_OFFSET	2
@@ -40,11 +42,8 @@
 
 void __iomem *mips_gic_base;
 
-struct gic_pcpu_mask {
-	DECLARE_BITMAP(pcpu_mask, GIC_MAX_INTRS);
-};
+DEFINE_PER_CPU_READ_MOSTLY(unsigned long[GIC_MAX_LONGS], pcpu_masks);
 
-static struct gic_pcpu_mask pcpu_masks[NR_CPUS];
 static DEFINE_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
 static struct irq_domain *gic_ipi_domain;
@@ -137,7 +136,7 @@ static void gic_handle_shared_int(bool chained)
 	DECLARE_BITMAP(intrmask, GIC_MAX_INTRS);
 
 	/* Get per-cpu bitmaps */
-	pcpu_mask = pcpu_masks[smp_processor_id()].pcpu_mask;
+	pcpu_mask = this_cpu_ptr(pcpu_masks);
 
 	if (mips_cm_is64) {
 		__ioread64_copy(pending, addr_gic_pend(),
@@ -254,8 +253,8 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 
 	/* Update the pcpu_masks */
 	for (i = 0; i < min(gic_vpes, NR_CPUS); i++)
-		clear_bit(irq, pcpu_masks[i].pcpu_mask);
-	set_bit(irq, pcpu_masks[cpumask_first(&tmp)].pcpu_mask);
+		clear_bit(irq, per_cpu_ptr(pcpu_masks, i));
+	set_bit(irq, per_cpu_ptr(pcpu_masks, cpumask_first(&tmp)));
 
 	cpumask_copy(irq_data_get_affinity_mask(d), cpumask);
 	spin_unlock_irqrestore(&gic_lock, flags);
@@ -416,8 +415,8 @@ static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
 	write_gic_map_vp(intr, BIT(mips_cm_vp_id(vpe)));
 	for (i = 0; i < min(gic_vpes, NR_CPUS); i++)
-		clear_bit(intr, pcpu_masks[i].pcpu_mask);
-	set_bit(intr, pcpu_masks[vpe].pcpu_mask);
+		clear_bit(intr, per_cpu_ptr(pcpu_masks, i));
+	set_bit(intr, per_cpu_ptr(pcpu_masks, vpe));
 	spin_unlock_irqrestore(&gic_lock, flags);
 
 	return 0;
-- 
2.14.0
