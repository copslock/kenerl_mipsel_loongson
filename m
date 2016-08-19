Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 19:08:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53463 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992474AbcHSRH7fxlir (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2016 19:07:59 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id EACB08A502492;
        Fri, 19 Aug 2016 18:07:39 +0100 (IST)
Received: from localhost (10.100.200.126) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 19 Aug
 2016 18:07:43 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, <stable@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 2/2] irqchip: mips-gic: Implement activate op for device domain
Date:   Fri, 19 Aug 2016 18:07:15 +0100
Message-ID: <20160819170715.27820-2-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160819170715.27820-1-paul.burton@imgtec.com>
References: <20160819170715.27820-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.126]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54690
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

If an IRQ is setup using __setup_irq(), which is used by the
request_irq() family of functions, and we are using an SMP kernel then
the affinity of the IRQ will be set via setup_affinity() immediately
after the IRQ is enabled. This call to gic_set_affinity() will lead to
the interrupt being mapped to a VPE. However there are other ways to use
IRQs which don't cause affinity to be set, for example if it is used to
chain to another IRQ controller with irq_set_chained_handler_and_data().
The irq_set_chained_handler_and_data() code path will enable the IRQ,
but will not trigger a call to gic_set_affinity() and in this case
nothing will map the interrupt to a VPE, meaning that the interrupt is
never received.

Fix this by implementing the activate operation for the GIC device IRQ
domain, using gic_shared_irq_domain_map() to map the interrupt to the
correct pin of cpu 0.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: c98c1822ee13 ("irqchip/mips-gic: Add device hierarchy domain")
Cc: stable@vger.kernel.org # v4.6+
---
This one would be great to get in ASAP, for v4.8 if possible, as it breaks
certain uses of GIC interrupts.
---
 drivers/irqchip/irq-mips-gic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index d7ec984..d3ef0fc 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -893,10 +893,17 @@ void gic_dev_domain_free(struct irq_domain *d, unsigned int virq,
 	return;
 }
 
+static void gic_dev_domain_activate(struct irq_domain *domain,
+				    struct irq_data *d)
+{
+	gic_shared_irq_domain_map(domain, d->irq, d->hwirq, 0);
+}
+
 static struct irq_domain_ops gic_dev_domain_ops = {
 	.xlate = gic_dev_domain_xlate,
 	.alloc = gic_dev_domain_alloc,
 	.free = gic_dev_domain_free,
+	.activate = gic_dev_domain_activate,
 };
 
 static int gic_ipi_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
-- 
2.9.3
