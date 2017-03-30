Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Mar 2017 21:07:31 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41101 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992289AbdC3THTfZoSr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Mar 2017 21:07:19 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5E25A7497C843;
        Thu, 30 Mar 2017 20:07:09 +0100 (IST)
Received: from localhost (10.20.1.33) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 30 Mar 2017 20:07:12
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 2/5] irqchip: mips-cpu: Prepare for non-legacy IRQ domains
Date:   Thu, 30 Mar 2017 12:06:10 -0700
Message-ID: <20170330190614.14844-3-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.12.1
In-Reply-To: <20170330190614.14844-1-paul.burton@imgtec.com>
References: <20170330190614.14844-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57488
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
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 drivers/irqchip/irq-mips-cpu.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-mips-cpu.c b/drivers/irqchip/irq-mips-cpu.c
index e6b413669e57..338de924b269 100644
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
2.12.1
