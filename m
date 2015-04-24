Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2015 15:22:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26488 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026033AbbDXNWbL2iDj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Apr 2015 15:22:31 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D577F4FA4F152;
        Fri, 24 Apr 2015 14:22:22 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 24 Apr 2015 14:22:25 +0100
Received: from localhost (192.168.159.76) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 24 Apr
 2015 14:22:24 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v4 13/37] MIPS: JZ4740: register an irq_domain for the interrupt controller
Date:   Fri, 24 Apr 2015 14:17:13 +0100
Message-ID: <1429881457-16016-14-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429881457-16016-1-git-send-email-paul.burton@imgtec.com>
References: <1429881457-16016-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.76]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47047
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

When probining the interrupt controller, register an IRQ domain such
that the interrupts can be translated by devicetree code & thus used
from devicetree.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
Changes in v4:
  - None.

Changes in v3:
  - Rebase.

Changes in v2:
  - None.
---
 arch/mips/jz4740/irq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/jz4740/irq.c b/arch/mips/jz4740/irq.c
index ed51915..ddcf78a 100644
--- a/arch/mips/jz4740/irq.c
+++ b/arch/mips/jz4740/irq.c
@@ -85,6 +85,7 @@ static int __init jz4740_intc_of_init(struct device_node *node,
 {
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
+	struct irq_domain *domain;
 	int parent_irq;
 
 	parent_irq = irq_of_parse_and_map(node, 0);
@@ -113,6 +114,11 @@ static int __init jz4740_intc_of_init(struct device_node *node,
 
 	irq_setup_generic_chip(gc, IRQ_MSK(32), 0, 0, IRQ_NOPROBE | IRQ_LEVEL);
 
+	domain = irq_domain_add_legacy(node, num_chips * 32, JZ4740_IRQ_BASE, 0,
+				       &irq_domain_simple_ops, NULL);
+	if (!domain)
+		pr_warn("unable to register IRQ domain\n");
+
 	setup_irq(parent_irq, &jz4740_cascade_action);
 	return 0;
 }
-- 
2.3.5
