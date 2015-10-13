Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2015 12:21:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14728 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010867AbbJMKRJnp0ds (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2015 12:17:09 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id DAF9442A445C4;
        Tue, 13 Oct 2015 11:17:01 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 13 Oct 2015 11:17:03 +0100
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 13 Oct 2015 11:17:03 +0100
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [RFC v2 PATCH 14/14] irqchip: mips-gic: remove IPI init code
Date:   Tue, 13 Oct 2015 11:16:22 +0100
Message-ID: <1444731382-19313-15-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com>
References: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49510
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

It's now all handled in generic arch code.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 drivers/irqchip/irq-mips-gic.c   | 79 ----------------------------------------
 include/linux/irqchip/mips-gic.h |  3 --
 2 files changed, 82 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 764470375cd0..8a56965d5980 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -585,83 +585,6 @@ static void gic_irq_dispatch(struct irq_desc *desc)
 	gic_handle_shared_int(true);
 }
 
-#ifdef CONFIG_MIPS_GIC_IPI
-static int gic_resched_int_base;
-static int gic_call_int_base;
-
-unsigned int plat_ipi_resched_int_xlate(unsigned int cpu)
-{
-	return gic_resched_int_base + cpu;
-}
-
-unsigned int plat_ipi_call_int_xlate(unsigned int cpu)
-{
-	return gic_call_int_base + cpu;
-}
-
-static irqreturn_t ipi_resched_interrupt(int irq, void *dev_id)
-{
-	scheduler_ipi();
-
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t ipi_call_interrupt(int irq, void *dev_id)
-{
-	generic_smp_call_function_interrupt();
-
-	return IRQ_HANDLED;
-}
-
-static struct irqaction irq_resched = {
-	.handler	= ipi_resched_interrupt,
-	.flags		= IRQF_PERCPU,
-	.name		= "IPI resched"
-};
-
-static struct irqaction irq_call = {
-	.handler	= ipi_call_interrupt,
-	.flags		= IRQF_PERCPU,
-	.name		= "IPI call"
-};
-
-static __init void gic_ipi_init_one(unsigned int intr, int cpu,
-				    struct irqaction *action)
-{
-	int virq = irq_create_mapping(gic_irq_domain,
-				      GIC_SHARED_TO_HWIRQ(intr));
-	int i;
-
-	gic_map_to_vpe(intr, mips_cm_vp_id(cpu));
-	for (i = 0; i < NR_CPUS; i++)
-		clear_bit(intr, pcpu_masks[i].pcpu_mask);
-	set_bit(intr, pcpu_masks[cpu].pcpu_mask);
-
-	irq_set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
-
-	irq_set_handler(virq, handle_percpu_irq);
-	setup_irq(virq, action);
-}
-
-static __init void gic_ipi_init(void)
-{
-	int i;
-
-	/* Use last 2 * NR_CPUS interrupts as IPIs */
-	gic_resched_int_base = gic_shared_intrs - nr_cpu_ids;
-	gic_call_int_base = gic_resched_int_base - nr_cpu_ids;
-
-	for (i = 0; i < nr_cpu_ids; i++) {
-		gic_ipi_init_one(gic_call_int_base + i, i, &irq_call);
-		gic_ipi_init_one(gic_resched_int_base + i, i, &irq_resched);
-	}
-}
-#else
-static inline void gic_ipi_init(void)
-{
-}
-#endif
-
 static void __init gic_basic_init(void)
 {
 	unsigned int i;
@@ -979,8 +902,6 @@ static void __init __gic_init(unsigned long gic_base_addr,
 	bitmap_set(ipi_resrv, gic_shared_intrs - 2 * NR_CPUS, 2 * NR_CPUS);
 
 	gic_basic_init();
-
-	gic_ipi_init();
 }
 
 void __init gic_init(unsigned long gic_base_addr,
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index 4e6861605050..321278767506 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -258,9 +258,6 @@ extern void gic_write_compare(cycle_t cnt);
 extern void gic_write_cpu_compare(cycle_t cnt, int cpu);
 extern void gic_start_count(void);
 extern void gic_stop_count(void);
-extern void gic_send_ipi(unsigned int intr);
-extern unsigned int plat_ipi_call_int_xlate(unsigned int);
-extern unsigned int plat_ipi_resched_int_xlate(unsigned int);
 extern int gic_get_c0_compare_int(void);
 extern int gic_get_c0_perfcount_int(void);
 extern int gic_get_c0_fdc_int(void);
-- 
2.1.0
