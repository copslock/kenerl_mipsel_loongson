Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jul 2015 14:24:31 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24651 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010433AbbGPMY3wJtHY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Jul 2015 14:24:29 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 85D4C7C03DF32;
        Thu, 16 Jul 2015 13:24:21 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 16 Jul 2015 13:24:23 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 16 Jul 2015 13:24:23 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH] drivers: irqchip: irq-mips-gic: Print some GIC setup information to aid debugging
Date:   Thu, 16 Jul 2015 13:24:11 +0100
Message-ID: <1437049451-4096-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Print total number of GIC IRQs and those allocated for IPIs in case we
are routing IPIs via GIC. Since this is not critical information we use
pr_debug() so it won't spam the normal bootlog.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 drivers/irqchip/irq-mips-gic.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 7fbbe8787660..4d83da8fe854 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -797,6 +797,21 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 	.xlate = gic_irq_domain_xlate,
 };
 
+static void __init gic_print_status(void)
+{
+	int i;
+
+	pr_debug("GIC IRQS:%d\n", gic_shared_intrs);
+	if (config_enabled(CONFIG_MIPS_GIC_IPI)) {
+		for (i = 0; i < nr_cpu_ids; i++) {
+			pr_debug("GIC call IPI:%d (CPU%d)\n",
+				 gic_call_int_base + i, i);
+			pr_debug("GIC resched IPI:%d (CPU%d)\n",
+				 gic_resched_int_base + i, i);
+		}
+	}
+}
+
 static void __init __gic_init(unsigned long gic_base_addr,
 			      unsigned long gic_addrspace_size,
 			      unsigned int cpu_vec, unsigned int irqbase,
@@ -859,6 +874,8 @@ static void __init __gic_init(unsigned long gic_base_addr,
 	gic_basic_init();
 
 	gic_ipi_init();
+
+	gic_print_status();
 }
 
 void __init gic_init(unsigned long gic_base_addr,
-- 
2.4.5
