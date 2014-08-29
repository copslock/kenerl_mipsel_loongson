Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Aug 2014 00:17:54 +0200 (CEST)
Received: from mail-qa0-f74.google.com ([209.85.216.74]:39263 "EHLO
        mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007476AbaH2WO7M4MWq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Aug 2014 00:14:59 +0200
Received: by mail-qa0-f74.google.com with SMTP id j15so416489qaq.5
        for <linux-mips@linux-mips.org>; Fri, 29 Aug 2014 15:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AmWzSILPgCQNWGot0s4QEi6+DOiXAtF80W8nm+yse64=;
        b=DQ48UIDSFPUi1ugZ5fF+hJWBAH84I9dTu8haPRHxzGe3Nv9KXYmc6601tyJfosIzjV
         mBqnVnAaJTW7bXSjZwYp74BtsYtn/DDgv99rStDrDaRnHQRuDX+xtzGln2yUekNtiWMD
         IC0OUUkNy8isjXDXYN8jJ79rK7JMpqW4//zyDqqfKA3k0TUqZolaIg6XtlQeSXQroeTv
         lpXZ0F2Am+tlVivCkaCodMH7q28iJI4Ewxl3+hryow6txpN/E3a8hz5gyTYeA2e+bFoz
         1f6g4Ua+nMKpHDl6r0biX3QStnW0+OfSyXUNSih/gdzPKP5p+DaAB9o22bp/jC1Zj9la
         +APA==
X-Gm-Message-State: ALoCoQk43w3ZIhDJSBpQUy2yBmbU/kzbkQHMhqoFkWgZplcFAI0Wwb77loq2BdP8qhsOhibSLENi
X-Received: by 10.236.112.234 with SMTP id y70mr7427359yhg.32.1409350491437;
        Fri, 29 Aug 2014 15:14:51 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id tr5si24065igb.1.2014.08.29.15.14.51
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Aug 2014 15:14:51 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id C07F431C514;
        Fri, 29 Aug 2014 15:14:45 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 81235221060; Fri, 29 Aug 2014 15:14:45 -0700 (PDT)
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
Subject: [PATCH 06/12] MIPS: GIC: Add generic IPI support when using DT
Date:   Fri, 29 Aug 2014 15:14:33 -0700
Message-Id: <1409350479-19108-7-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
References: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42334
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

When DT-based probing is used for the GIC and the GIC is also used
for IPIs (i.e. MIPS_GIC_IPI=y), set up the last 2 * NR_CPUs GIC
interrupts as the reschedule and call IPIs.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/kernel/irq-gic.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/mips/kernel/irq-gic.c b/arch/mips/kernel/irq-gic.c
index be8bea4..42558eb 100644
--- a/arch/mips/kernel/irq-gic.c
+++ b/arch/mips/kernel/irq-gic.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/interrupt.h>
 #include <linux/clocksource.h>
@@ -417,6 +418,89 @@ static inline int gic_irq_to_cpu_pin(unsigned int hwirq)
 		GIC_CPU_PIN_OFFSET;
 }
 
+#ifdef CONFIG_MIPS_GIC_IPI
+static int gic_resched_int_base;
+static int gic_call_int_base;
+
+unsigned int plat_ipi_resched_int_xlate(unsigned int cpu)
+{
+	return gic_resched_int_base + cpu;
+}
+
+unsigned int plat_ipi_call_int_xlate(unsigned int cpu)
+{
+	return gic_call_int_base + cpu;
+}
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
+	smp_call_function_interrupt();
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
+static __init void gic_ipi_init_one(struct irq_domain *domain,
+				    unsigned int hwirq, int cpu,
+				    struct irqaction *action)
+{
+	int irq = irq_create_mapping(domain, hwirq);
+	int i;
+
+	GIC_SET_POLARITY(hwirq, GIC_POL_POS);
+	GIC_SET_TRIGGER(hwirq, GIC_TRIG_EDGE);
+	GIC_SH_MAP_TO_VPE_SMASK(hwirq, cpu);
+	GICWRITE(GIC_REG_ADDR(SHARED, GIC_SH_MAP_TO_PIN(hwirq)),
+		 GIC_MAP_TO_PIN_MSK | gic_irq_to_cpu_pin(hwirq));
+	GIC_CLR_INTR_MASK(hwirq);
+	gic_irq_flags[hwirq] |= GIC_TRIG_EDGE;
+
+	for (i = 0; i < ARRAY_SIZE(pcpu_masks); i++)
+		clear_bit(hwirq, pcpu_masks[i].pcpu_mask);
+	set_bit(hwirq, pcpu_masks[cpu].pcpu_mask);
+
+	irq_set_chip_and_handler(irq, &gic_irq_controller, handle_percpu_irq);
+	setup_irq(irq, action);
+}
+
+static __init void gic_ipi_init(struct irq_domain *domain)
+{
+	int i;
+
+	/* Use last 2 * NR_CPUS interrupts as IPIs */
+	gic_resched_int_base = GIC_NUM_INTRS - nr_cpu_ids;
+	gic_call_int_base = gic_resched_int_base - nr_cpu_ids;
+
+	for (i = 0; i < nr_cpu_ids; i++) {
+		gic_ipi_init_one(domain, gic_call_int_base + i, i, &irq_call);
+		gic_ipi_init_one(domain, gic_resched_int_base + i, i,
+				 &irq_resched);
+	}
+}
+#else
+static inline void gic_ipi_init(struct irq_domain *domain)
+{
+}
+#endif
+
 static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hw)
 {
@@ -515,6 +599,8 @@ int __init gic_of_init(struct device_node *node, struct device_node *parent)
 		irq_set_handler_data(gic_cpu_pin[i], domain);
 	}
 
+	gic_ipi_init(domain);
+
 	return 0;
 }
 #endif
-- 
2.1.0.rc2.206.gedb03e5
