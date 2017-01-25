Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2017 15:08:44 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1048 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992111AbdAYOIgfHr8q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jan 2017 15:08:36 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8350175602315;
        Wed, 25 Jan 2017 14:08:26 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 25 Jan 2017 14:08:29 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 1/1] irqchip/mips-gic: Fix local interrupts
Date:   Wed, 25 Jan 2017 15:08:25 +0100
Message-ID: <1485353305-23672-1-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

Some local interrupts are not initialised properly at the moment and
cannot be used since the domain's alloc method is never called for them.

This has been observed earlier and partially fixed in commit
e875bd66dfb ("irqchip/mips-gic: Fix local interrupts"), but that change
still relied on the interrupt to be requested by an external driver (eg.
drivers/clocksource/mips-gic-timer.c).

This does however not solve the issue for interrupts that are not
referenced by any driver through the device tree and results in
request_irq() calls returning -ENOSYS. It can be observed when attempting
to use perf tool to access hardware performance counters.

Fix this by explicitly calling irq_create_fwspec_mapping() for local
interrupts.

Fixes: e875bd66dfb ("irqchip/mips-gic: Fix local interrupts")
Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-mips@linux-mips.org
---
 drivers/irqchip/irq-mips-gic.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index c01c09e..11d12bc 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -968,6 +968,34 @@ static struct irq_domain_ops gic_ipi_domain_ops = {
 	.match = gic_ipi_domain_match,
 };
 
+static void __init gic_map_single_int(struct device_node *node,
+				      unsigned int irq)
+{
+	unsigned int linux_irq;
+	struct irq_fwspec local_int_fwspec = {
+		.fwnode         = &node->fwnode,
+		.param_count    = 3,
+		.param          = {
+			[0]     = GIC_LOCAL,
+			[1]     = irq,
+			[2]     = IRQ_TYPE_NONE,
+		},
+	};
+
+	if (!gic_local_irq_is_routable(irq))
+		return;
+
+	linux_irq = irq_create_fwspec_mapping(&local_int_fwspec);
+	WARN_ON(!linux_irq);
+}
+
+static void __init gic_map_interrupts(struct device_node *node)
+{
+	gic_map_single_int(node, GIC_LOCAL_INT_TIMER);
+	gic_map_single_int(node, GIC_LOCAL_INT_PERFCTR);
+	gic_map_single_int(node, GIC_LOCAL_INT_FDC);
+}
+
 static void __init __gic_init(unsigned long gic_base_addr,
 			      unsigned long gic_addrspace_size,
 			      unsigned int cpu_vec, unsigned int irqbase,
@@ -1067,6 +1095,7 @@ static void __init __gic_init(unsigned long gic_base_addr,
 	}
 
 	gic_basic_init();
+	gic_map_interrupts(node);
 }
 
 void __init gic_init(unsigned long gic_base_addr,
-- 
2.7.4
