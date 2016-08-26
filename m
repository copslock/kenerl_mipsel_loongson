Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 17:45:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58453 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992578AbcHZPm2m0U3I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 17:42:28 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 09BC3E63BB62;
        Fri, 26 Aug 2016 16:42:08 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 16:42:11 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 17/26] irqchip: mips-cpu: Introduce IPI IRQ domain support
Date:   Fri, 26 Aug 2016 16:37:16 +0100
Message-ID: <20160826153725.11629-18-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160826153725.11629-1-paul.burton@imgtec.com>
References: <20160826153725.11629-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54801
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

Introduce support for registering an IPI IRQ domain suitable for use by
systems using the MIPS MT (multithreading) ASE within a single core.
This will allow for such systems to be supported generically, without
the current kludge of IPI code split between the MIPS arch & the malta
board support code.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 drivers/irqchip/Kconfig        |   2 +
 drivers/irqchip/irq-mips-cpu.c | 128 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 122 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7f87289..8af8704 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -127,7 +127,9 @@ config IMGPDC_IRQ
 config IRQ_MIPS_CPU
 	bool
 	select GENERIC_IRQ_CHIP
+	select GENERIC_IRQ_IPI if SYS_SUPPORTS_MULTITHREADING
 	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY if GENERIC_IRQ_IPI
 
 config CLPS711X_IRQCHIP
 	bool
diff --git a/drivers/irqchip/irq-mips-cpu.c b/drivers/irqchip/irq-mips-cpu.c
index 338de92..8108257 100644
--- a/drivers/irqchip/irq-mips-cpu.c
+++ b/drivers/irqchip/irq-mips-cpu.c
@@ -17,15 +17,14 @@
 /*
  * Almost all MIPS CPUs define 8 interrupt sources.  They are typically
  * level triggered (i.e., cannot be cleared from CPU; must be cleared from
- * device).  The first two are software interrupts which we don't really
- * use or support.  The last one is usually the CPU timer interrupt if
- * counter register is present or, for CPUs with an external FPU, by
- * convention it's the FPU exception interrupt.
+ * device).
  *
- * Don't even think about using this on SMP.  You have been warned.
+ * The first two are software interrupts (i.e. not exposed as pins) which
+ * may be used for IPIs in multi-threaded single-core systems.
  *
- * This file exports one global function:
- *	void mips_cpu_irq_init(void);
+ * The last one is usually the CPU timer interrupt if the counter register
+ * is present, or for old CPUs with an external FPU by convention it's the
+ * FPU exception interrupt.
  */
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -40,6 +39,7 @@
 #include <asm/setup.h>
 
 static struct irq_domain *irq_domain;
+static struct irq_domain *ipi_domain;
 
 static inline void unmask_mips_irq(struct irq_data *d)
 {
@@ -90,6 +90,29 @@ static void mips_mt_cpu_irq_ack(struct irq_data *d)
 	mask_mips_irq(d);
 }
 
+#ifdef CONFIG_GENERIC_IRQ_IPI
+
+static void mips_mt_send_ipi(struct irq_data *d, unsigned int cpu)
+{
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	unsigned long flags;
+	int vpflags;
+
+	local_irq_save(flags);
+
+	/* We can only send IPIs to VPEs within the local core */
+	BUG_ON(cpu_data[cpu].core != current_cpu_data.core);
+
+	vpflags = dvpe();
+	settc(cpu_vpe_id(&cpu_data[cpu]));
+	write_vpe_c0_cause(read_vpe_c0_cause() | (C_SW0 << hwirq));
+	evpe(vpflags);
+
+	local_irq_restore(flags);
+}
+
+#endif /* CONFIG_GENERIC_IRQ_IPI */
+
 static struct irq_chip mips_mt_cpu_irq_controller = {
 	.name		= "MIPS",
 	.irq_startup	= mips_mt_cpu_irq_startup,
@@ -100,6 +123,9 @@ static struct irq_chip mips_mt_cpu_irq_controller = {
 	.irq_eoi	= unmask_mips_irq,
 	.irq_disable	= mask_mips_irq,
 	.irq_enable	= unmask_mips_irq,
+#ifdef CONFIG_GENERIC_IRQ_IPI
+	.ipi_send_single= mips_mt_send_ipi,
+#endif
 };
 
 asmlinkage void __weak plat_irq_dispatch(void)
@@ -116,7 +142,10 @@ asmlinkage void __weak plat_irq_dispatch(void)
 	pending >>= CAUSEB_IP;
 	while (pending) {
 		irq = fls(pending) - 1;
-		virq = irq_linear_revmap(irq_domain, irq);
+		if (IS_ENABLED(CONFIG_GENERIC_IRQ_IPI) && irq < 2)
+			virq = irq_linear_revmap(ipi_domain, irq);
+		else
+			virq = irq_linear_revmap(irq_domain, irq);
 		do_IRQ(virq);
 		pending &= ~BIT(irq);
 	}
@@ -147,6 +176,82 @@ static const struct irq_domain_ops mips_cpu_intc_irq_domain_ops = {
 	.xlate = irq_domain_xlate_onecell,
 };
 
+#ifdef CONFIG_GENERIC_IRQ_IPI
+
+struct cpu_ipi_domain_state {
+	DECLARE_BITMAP(allocated, 2);
+};
+
+static int mips_cpu_ipi_alloc(struct irq_domain *domain, unsigned int virq,
+			      unsigned int nr_irqs, void *arg)
+{
+	struct cpu_ipi_domain_state *state = domain->host_data;
+	unsigned int i, hwirq;
+	int ret;
+
+	for (i = 0; i < nr_irqs; i++) {
+		hwirq = find_first_zero_bit(state->allocated, 2);
+		if (hwirq == 2)
+			return -EBUSY;
+		bitmap_set(state->allocated, hwirq, 1);
+
+		ret = irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq,
+						    &mips_mt_cpu_irq_controller,
+						    NULL);
+		if (ret)
+			return ret;
+
+		ret = irq_set_irq_type(virq + i, IRQ_TYPE_LEVEL_HIGH);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int mips_cpu_ipi_match(struct irq_domain *d, struct device_node *node,
+			      enum irq_domain_bus_token bus_token)
+{
+	bool is_ipi;
+
+	switch (bus_token) {
+	case DOMAIN_BUS_IPI:
+		is_ipi = d->bus_token == bus_token;
+		return (!node || (to_of_node(d->fwnode) == node)) && is_ipi;
+	default:
+		return 0;
+	}
+}
+
+static const struct irq_domain_ops mips_cpu_ipi_chip_ops = {
+	.alloc	= mips_cpu_ipi_alloc,
+	.match	= mips_cpu_ipi_match,
+};
+
+static void mips_cpu_register_ipi_domain(struct device_node *of_node)
+{
+	struct cpu_ipi_domain_state *ipi_domain_state;
+
+	ipi_domain_state = kzalloc(sizeof(*ipi_domain_state), GFP_KERNEL);
+	if (!ipi_domain_state)
+		panic("Failed to alloc IPI domain state");
+
+	ipi_domain = irq_domain_add_hierarchy(irq_domain,
+					      IRQ_DOMAIN_FLAG_IPI_SINGLE,
+					      2, of_node,
+					      &mips_cpu_ipi_chip_ops,
+					      ipi_domain_state);
+	if (!ipi_domain)
+		panic("Failed to add MIPS CPU IPI domain");
+	ipi_domain->bus_token = DOMAIN_BUS_IPI;
+}
+
+#else /* !CONFIG_GENERIC_IRQ_IPI */
+
+static inline void mips_cpu_register_ipi_domain(struct device_node *of_node) {}
+
+#endif /* !CONFIG_GENERIC_IRQ_IPI */
+
 static void __init __mips_cpu_irq_init(struct device_node *of_node)
 {
 	/* Mask interrupts. */
@@ -158,6 +263,13 @@ static void __init __mips_cpu_irq_init(struct device_node *of_node)
 					   NULL);
 	if (!irq_domain)
 		panic("Failed to add irqdomain for MIPS CPU");
+
+	/*
+	 * Only proceed to register the software interrupt IPI implementation
+	 * for CPUs which implement the MIPS MT (multi-threading) ASE.
+	 */
+	if (cpu_has_mipsmt)
+		mips_cpu_register_ipi_domain(of_node);
 }
 
 void __init mips_cpu_irq_init(void)
-- 
2.9.3
