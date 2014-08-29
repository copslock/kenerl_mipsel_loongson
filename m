Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Aug 2014 00:17:02 +0200 (CEST)
Received: from mail-ig0-f202.google.com ([209.85.213.202]:62032 "EHLO
        mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007484AbaH2WOyZKYUD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Aug 2014 00:14:54 +0200
Received: by mail-ig0-f202.google.com with SMTP id r2so653210igi.1
        for <linux-mips@linux-mips.org>; Fri, 29 Aug 2014 15:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oDA577mquj9oJnIg3oIfNnqFrU1UteV7AoN5RQAf5hE=;
        b=UmfbI2cLFaESV7NoRkhpndnU9WPT1RjM9YB2nVU+EVV1mb7WG5p6aF3n5bu6IeV7kk
         Jn6Zn6ava7emYyEzDBoZVudo2L7LnO1dKNb2Z3gUYEV+QgM4suUKC2nsLOTpw7w37ZC7
         LA352aPohtsEfjihy9BSthkR1HDvK9KUBUXOiITftxVGujTkSric+3oxekHcpkai9K31
         T1UC+i5qAb4zLsM5AYxtF/IzrOiDRpv0Rv3BSGUbvio/XIrdYiXuzOqEZSRrse9hSY2l
         BNfdOlzUj1tHMGZFEnONLdjXSxDXsrln0aePY+qDIMSXIN45S6ao5EHnYKtc4QalTipW
         G1Fg==
X-Gm-Message-State: ALoCoQlW3nQj5xAston19F2R7Ke5DeSbx30XtmpBbyYErRBYj/NShlEvQWlPTv1Jgs2VqyQ1KhNH
X-Received: by 10.50.80.111 with SMTP id q15mr2398401igx.0.1409350488226;
        Fri, 29 Aug 2014 15:14:48 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id t28si399yhb.4.2014.08.29.15.14.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Aug 2014 15:14:48 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 0ABDA5A43DD;
        Fri, 29 Aug 2014 15:14:45 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id C015B221060; Fri, 29 Aug 2014 15:14:44 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] MIPS: GIC: Add device-tree support
Date:   Fri, 29 Aug 2014 15:14:32 -0700
Message-Id: <1409350479-19108-6-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
References: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Add device-tree support for the MIPS GIC.  With DT, no per-platform
static device interrupt mapping is supplied and instead all device
interrupts are specified through the DT.  The GIC-to-CPU interrupts
must also be specified in the DT.

Platforms using DT-based probing of the GIC need only supply the
GIC_NUM_INTRS and, if necessary, MIPS_GIC_IRQ_BASE values and
call of_irq_init() with an of_device_id table including the GIC.

Currenlty only legacy and vecotred interrupt modes are supported.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/include/asm/gic.h |  15 ++++++
 arch/mips/kernel/irq-gic.c  | 122 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 135 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index d7699cf..1146803 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -339,6 +339,10 @@ struct gic_shared_intr_map {
 #define GIC_CPU_INT3		3 /* .		      */
 #define GIC_CPU_INT4		4 /* .		      */
 #define GIC_CPU_INT5		5 /* Core Interrupt 7 */
+#define GIC_NUM_CPU_INT		6
+
+/* Add 2 to convert GIC CPU pin to core interrupt */
+#define GIC_CPU_PIN_OFFSET	2
 
 /* Local GIC interrupts. */
 #define GIC_INT_TMR		(GIC_CPU_INT5)
@@ -381,4 +385,15 @@ extern void gic_disable_interrupt(int irq_vec);
 extern void gic_irq_ack(struct irq_data *d);
 extern void gic_finish_irq(struct irq_data *d);
 extern void gic_platform_init(int irqs, struct irq_chip *irq_controller);
+
+#ifdef CONFIG_IRQ_DOMAIN
+extern int gic_of_init(struct device_node *node, struct device_node *parent);
+#else
+static inline int gic_of_init(struct device_node *node,
+			      struct device_node *parent)
+{
+	return 0;
+}
+#endif
+
 #endif /* _ASM_GICREGS_H */
diff --git a/arch/mips/kernel/irq-gic.c b/arch/mips/kernel/irq-gic.c
index 9e9d8b9..be8bea4 100644
--- a/arch/mips/kernel/irq-gic.c
+++ b/arch/mips/kernel/irq-gic.c
@@ -8,8 +8,10 @@
  */
 #include <linux/bitmap.h>
 #include <linux/init.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/smp.h>
-#include <linux/irq.h>
+#include <linux/interrupt.h>
 #include <linux/clocksource.h>
 
 #include <asm/io.h>
@@ -243,7 +245,7 @@ static DEFINE_SPINLOCK(gic_lock);
 static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 			    bool force)
 {
-	unsigned int irq = (d->irq - gic_irq_base);
+	unsigned int irq = d->irq - gic_irq_base;
 	cpumask_t	tmp = CPU_MASK_NONE;
 	unsigned long	flags;
 	int		i;
@@ -400,3 +402,119 @@ void __init gic_init(unsigned long gic_base_addr,
 
 	gic_platform_init(numintrs, &gic_irq_controller);
 }
+
+#ifdef CONFIG_IRQ_DOMAIN
+/* CPU core IRQs used by GIC */
+static int gic_cpu_pin[GIC_NUM_CPU_INT];
+static int num_gic_cpu_pins;
+
+/* Index of core IRQ used by a particular GIC IRQ */
+static int gic_irq_pin[GIC_NUM_INTRS];
+
+static inline int gic_irq_to_cpu_pin(unsigned int hwirq)
+{
+	return gic_cpu_pin[gic_irq_pin[hwirq]] - MIPS_CPU_IRQ_BASE -
+		GIC_CPU_PIN_OFFSET;
+}
+
+static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
+			      irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(irq, &gic_irq_controller, handle_level_irq);
+
+	GICWRITE(GIC_REG_ADDR(SHARED, GIC_SH_MAP_TO_PIN(hw)),
+		 GIC_MAP_TO_PIN_MSK | gic_irq_to_cpu_pin(hw));
+	/* Map to VPE 0 by default */
+	GIC_SH_MAP_TO_VPE_SMASK(hw, 0);
+	set_bit(hw, pcpu_masks[0].pcpu_mask);
+
+	return 0;
+}
+
+static int gic_irq_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
+				const u32 *intspec, unsigned int intsize,
+				unsigned long *out_hwirq,
+				unsigned int *out_type)
+{
+	if (intsize != 2 && intsize != 3)
+		return -EINVAL;
+
+	if (intspec[0] >= GIC_NUM_INTRS)
+		return -EINVAL;
+	*out_hwirq = intspec[0];
+
+	*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
+
+	if (intsize == 3) {
+		if (intspec[2] >= num_gic_cpu_pins)
+			return -EINVAL;
+		gic_irq_pin[intspec[0]] = intspec[2];
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops gic_irq_domain_ops = {
+	.map = gic_irq_domain_map,
+	.xlate = gic_irq_domain_xlate,
+};
+
+static void gic_irq_dispatch(unsigned int irq, struct irq_desc *desc)
+{
+	struct irq_domain *domain = irq_get_handler_data(irq);
+	unsigned int hwirq;
+
+	while ((hwirq = gic_get_int()) != GIC_NUM_INTRS) {
+		irq = irq_linear_revmap(domain, hwirq);
+		generic_handle_irq(irq);
+	}
+}
+
+void __init __weak gic_platform_init(int irqs, struct irq_chip *irq_controller)
+{
+}
+
+int __init gic_of_init(struct device_node *node, struct device_node *parent)
+{
+	struct irq_domain *domain;
+	struct resource res;
+	int i;
+
+	if (cpu_has_veic) {
+		pr_err("GIC EIC mode not supported with DT yet\n");
+		return -ENODEV;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(gic_cpu_pin); i++) {
+		gic_cpu_pin[i] = irq_of_parse_and_map(node, i);
+		if (!gic_cpu_pin[i])
+			break;
+		num_gic_cpu_pins++;
+	}
+	if (!num_gic_cpu_pins) {
+		pr_err("No GIC to CPU interrupts specified\n");
+		return -ENODEV;
+	}
+
+	if (of_address_to_resource(node, 0, &res)) {
+		pr_err("Failed to get GIC memory range\n");
+		return -ENODEV;
+	}
+
+	gic_init(res.start, resource_size(&res), NULL, 0, MIPS_GIC_IRQ_BASE);
+
+	domain = irq_domain_add_legacy(node, GIC_NUM_INTRS, MIPS_GIC_IRQ_BASE,
+				       0, &gic_irq_domain_ops, NULL);
+	if (!domain) {
+		pr_err("Failed to add GIC IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < num_gic_cpu_pins; i++) {
+		irq_set_chained_handler(gic_cpu_pin[i], gic_irq_dispatch);
+		irq_set_handler_data(gic_cpu_pin[i], domain);
+	}
+
+	return 0;
+}
+#endif
-- 
2.1.0.rc2.206.gedb03e5
