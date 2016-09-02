Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 17:50:26 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57012 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992087AbcIBPuMMP2WA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 17:50:12 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 1F1C13629D3DA;
        Fri,  2 Sep 2016 16:49:53 +0100 (IST)
Received: from localhost (10.100.200.40) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Sep
 2016 16:49:55 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/12] irqchip: i8259: Add domain before mapping parent irq
Date:   Fri, 2 Sep 2016 16:48:47 +0100
Message-ID: <20160902154859.24269-2-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160902154859.24269-1-paul.burton@imgtec.com>
References: <20160902154859.24269-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.40]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55005
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

Mapping the parent IRQ will use a virq number which may conflict with
the hardcoded I8259A_IRQ_BASE..I8259A_IRQ_BASE+15 range that the i8259
driver expects to be free. If this occurs then we'll hit errors when
adding the i8259 IRQ domain, since one of its virq numbers will already
be in use.

Avoid this by adding the i8259 domain before mapping the parent IRQ,
such that the i8259 virq numbers become used before the parent interrupt
controller gets a chance to use any of them.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 drivers/irqchip/irq-i8259.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-i8259.c b/drivers/irqchip/irq-i8259.c
index 6b304eb..85897fd 100644
--- a/drivers/irqchip/irq-i8259.c
+++ b/drivers/irqchip/irq-i8259.c
@@ -370,13 +370,15 @@ int __init i8259_of_init(struct device_node *node, struct device_node *parent)
 	struct irq_domain *domain;
 	unsigned int parent_irq;
 
+	domain = __init_i8259_irqs(node);
+
 	parent_irq = irq_of_parse_and_map(node, 0);
 	if (!parent_irq) {
 		pr_err("Failed to map i8259 parent IRQ\n");
+		irq_domain_remove(domain);
 		return -ENODEV;
 	}
 
-	domain = __init_i8259_irqs(node);
 	irq_set_chained_handler_and_data(parent_irq, i8259_irq_dispatch,
 					 domain);
 	return 0;
-- 
2.9.3
