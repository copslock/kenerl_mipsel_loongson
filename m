Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 19:34:37 +0200 (CEST)
Received: from mail-oi0-f74.google.com ([209.85.218.74]:54104 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025906AbaIERaokpDU1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 19:30:44 +0200
Received: by mail-oi0-f74.google.com with SMTP id e131so200446oig.3
        for <linux-mips@linux-mips.org>; Fri, 05 Sep 2014 10:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JAmytexZxGhB13eTWR4tz0UMxVqBuw73KYaO1Dl2434=;
        b=BhTmYxpYhKLlZ/jMQ8BKYd5JpWP14M3LF0qnsiKUxoazKNFjF8NMWh8efDK316QF+I
         vGwEzayQwMO61mZhWtnyew4r8wX8Gjg/qSBtI/IgnuRTUFlcRyWkYDfB5BhD73wdeR03
         Anr4UeOXa7Z5OeQGYWiRocByuj9GXxJQgrmHe/3o/FvlDqmYk8CLqJ1qjlzHwiV3gsaV
         xn5CIN5sOYgFNRCU2LhOOJRiZYL1Q4NJS+HK0GBFy1BmD1OWAkEXCtm1cBwJvk5zbHhy
         DDawePrAt/QpyTPd6b3GgNLigRLPLI1vocvPgQGenwycy9+HtcNvqpFPLMOtS/I5ub07
         1aeA==
X-Gm-Message-State: ALoCoQmVxWubjw7meGbZpG/fqzhg6NeWWpjvkOrm3v4zj3/ZvkVO1E/1pVhor9r8oRuOdf82kRUu
X-Received: by 10.42.133.200 with SMTP id i8mr7242453ict.14.1409938238727;
        Fri, 05 Sep 2014 10:30:38 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id d7si508245yho.2.2014.09.05.10.30.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Sep 2014 10:30:38 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6BB0A31C285;
        Fri,  5 Sep 2014 10:30:38 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 302962209EA; Fri,  5 Sep 2014 10:30:38 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/16] irqchip: mips-gic: Add generic IPI support when using DT
Date:   Fri,  5 Sep 2014 10:30:15 -0700
Message-Id: <1409938218-9026-14-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
References: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42443
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
Changes from v1:
 - removed open-coding of irq_set_type
---
 drivers/irqchip/irq-mips-gic.c | 81 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index d885749..82a35cf 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/interrupt.h>
 #include <linux/clocksource.h>
@@ -479,6 +480,84 @@ void __init gic_init(unsigned long gic_base_addr,
 static int gic_cpu_pin[GIC_NUM_CPU_INT];
 static int num_gic_cpu_pins;
 
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
+	GIC_SH_MAP_TO_VPE_SMASK(hwirq, cpu);
+	for (i = 0; i < NR_CPUS; i++)
+		clear_bit(hwirq, pcpu_masks[i].pcpu_mask);
+	set_bit(hwirq, pcpu_masks[cpu].pcpu_mask);
+
+	irq_set_irq_type(irq, IRQ_TYPE_EDGE_RISING);
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
@@ -563,6 +642,8 @@ int __init gic_of_init(struct device_node *node, struct device_node *parent)
 		irq_set_handler_data(irq, domain);
 	}
 
+	gic_ipi_init(domain);
+
 	return 0;
 }
 IRQCHIP_DECLARE(mips_gic, "mti,global-interrupt-controller", gic_of_init);
-- 
2.1.0.rc2.206.gedb03e5
