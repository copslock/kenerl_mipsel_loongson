Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2016 19:36:35 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18417 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992316AbcH3RePbH380 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Aug 2016 19:34:15 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 99D49489605E5;
        Tue, 30 Aug 2016 18:33:55 +0100 (IST)
Received: from localhost (10.100.200.118) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 30 Aug
 2016 18:33:58 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 16/26] irqchip: mips-cpu: Prepare for non-legacy IRQ domains
Date:   Tue, 30 Aug 2016 18:29:19 +0100
Message-ID: <20160830172929.16948-17-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160830172929.16948-1-paul.burton@imgtec.com>
References: <20160830172929.16948-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.118]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54857
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

The various struct irq_chip callbacks in the MIPS CPU interrupt
controller driver have been calculating the hardware interrupt number by
subtracting MIPS_CPU_IRQ_BASE from the virq number. This presumes a
linear mapping beginning from MIPS_CPU_IRQ_BASE, and this will not hold
once an IPI IRQ domain is introduced. Switch to using the hwirq field of
struct irq_data which already contains the hardware interrupt number
instead of attempting to calculate it.

Similarly, plat_irq_dispatch calculated the virq number by adding
MIPS_CPU_IRQ_BASE to the hardware interrupt number. Ready this for the
introduction of an IPI IRQ domain by instead using irq_linear_revmap.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v2: None

 drivers/irqchip/irq-mips-cpu.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-mips-cpu.c b/drivers/irqchip/irq-mips-cpu.c
index e6b4136..338de92 100644
--- a/drivers/irqchip/irq-mips-cpu.c
+++ b/drivers/irqchip/irq-mips-cpu.c
@@ -39,15 +39,17 @@
 #include <asm/mipsmtregs.h>
 #include <asm/setup.h>
 
+static struct irq_domain *irq_domain;
+
 static inline void unmask_mips_irq(struct irq_data *d)
 {
-	set_c0_status(IE_SW0 << (d->irq - MIPS_CPU_IRQ_BASE));
+	set_c0_status(IE_SW0 << d->hwirq);
 	irq_enable_hazard();
 }
 
 static inline void mask_mips_irq(struct irq_data *d)
 {
-	clear_c0_status(IE_SW0 << (d->irq - MIPS_CPU_IRQ_BASE));
+	clear_c0_status(IE_SW0 << d->hwirq);
 	irq_disable_hazard();
 }
 
@@ -70,7 +72,7 @@ static unsigned int mips_mt_cpu_irq_startup(struct irq_data *d)
 {
 	unsigned int vpflags = dvpe();
 
-	clear_c0_cause(C_SW0 << (d->irq - MIPS_CPU_IRQ_BASE));
+	clear_c0_cause(C_SW0 << d->hwirq);
 	evpe(vpflags);
 	unmask_mips_irq(d);
 	return 0;
@@ -83,7 +85,7 @@ static unsigned int mips_mt_cpu_irq_startup(struct irq_data *d)
 static void mips_mt_cpu_irq_ack(struct irq_data *d)
 {
 	unsigned int vpflags = dvpe();
-	clear_c0_cause(C_SW0 << (d->irq - MIPS_CPU_IRQ_BASE));
+	clear_c0_cause(C_SW0 << d->hwirq);
 	evpe(vpflags);
 	mask_mips_irq(d);
 }
@@ -103,6 +105,7 @@ static struct irq_chip mips_mt_cpu_irq_controller = {
 asmlinkage void __weak plat_irq_dispatch(void)
 {
 	unsigned long pending = read_c0_cause() & read_c0_status() & ST0_IM;
+	unsigned int virq;
 	int irq;
 
 	if (!pending) {
@@ -113,7 +116,8 @@ asmlinkage void __weak plat_irq_dispatch(void)
 	pending >>= CAUSEB_IP;
 	while (pending) {
 		irq = fls(pending) - 1;
-		do_IRQ(MIPS_CPU_IRQ_BASE + irq);
+		virq = irq_linear_revmap(irq_domain, irq);
+		do_IRQ(virq);
 		pending &= ~BIT(irq);
 	}
 }
@@ -145,15 +149,14 @@ static const struct irq_domain_ops mips_cpu_intc_irq_domain_ops = {
 
 static void __init __mips_cpu_irq_init(struct device_node *of_node)
 {
-	struct irq_domain *domain;
-
 	/* Mask interrupts. */
 	clear_c0_status(ST0_IM);
 	clear_c0_cause(CAUSEF_IP);
 
-	domain = irq_domain_add_legacy(of_node, 8, MIPS_CPU_IRQ_BASE, 0,
-				       &mips_cpu_intc_irq_domain_ops, NULL);
-	if (!domain)
+	irq_domain = irq_domain_add_legacy(of_node, 8, MIPS_CPU_IRQ_BASE, 0,
+					   &mips_cpu_intc_irq_domain_ops,
+					   NULL);
+	if (!irq_domain)
 		panic("Failed to add irqdomain for MIPS CPU");
 }
 
-- 
2.9.3
