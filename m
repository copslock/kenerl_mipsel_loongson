Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2016 13:07:51 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49875 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27033137AbcEWLHt7M2ug (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 May 2016 13:07:49 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 8135356B6E401;
        Mon, 23 May 2016 12:07:41 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 23 May 2016 12:07:44 +0100
Received: from hhunt-arch.le.imgtec.org (192.168.154.26) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 23 May 2016 12:07:43 +0100
From:   Harvey Hunt <harvey.hunt@imgtec.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>
CC:     Harvey Hunt <harvey.hunt@imgtec.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, Qais Yousef <qsyousef@gmail.com>
Subject: [PATCH] irqchip/mips-gic: Populate irq_domain names
Date:   Mon, 23 May 2016 12:07:37 +0100
Message-ID: <1464001657-31348-1-git-send-email-harvey.hunt@imgtec.com>
X-Mailer: git-send-email 2.8.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.26]
Return-Path: <Harvey.Hunt@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: harvey.hunt@imgtec.com
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

Set the irq_domain names so that they don't default to an unhelpful
value.

Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
Reviewed-by: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: <linux-mips@linux-mips.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: Qais Yousef <qsyousef@gmail.com>
---
 drivers/irqchip/irq-mips-gic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 40fb120..22a4a6d 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -1022,12 +1022,14 @@ static void __init __gic_init(unsigned long gic_base_addr,
 					       &gic_irq_domain_ops, NULL);
 	if (!gic_irq_domain)
 		panic("Failed to add GIC IRQ domain");
+	gic_irq_domain->name = "mips-gic-irq";
 
 	gic_dev_domain = irq_domain_add_hierarchy(gic_irq_domain, 0,
 						  GIC_NUM_LOCAL_INTRS + gic_shared_intrs,
 						  node, &gic_dev_domain_ops, NULL);
 	if (!gic_dev_domain)
 		panic("Failed to add GIC DEV domain");
+	gic_dev_domain->name = "mips-gic-dev";
 
 	gic_ipi_domain = irq_domain_add_hierarchy(gic_irq_domain,
 						  IRQ_DOMAIN_FLAG_IPI_PER_CPU,
@@ -1036,6 +1038,7 @@ static void __init __gic_init(unsigned long gic_base_addr,
 	if (!gic_ipi_domain)
 		panic("Failed to add GIC IPI domain");
 
+	gic_ipi_domain->name = "mips-gic-ipi";
 	gic_ipi_domain->bus_token = DOMAIN_BUS_IPI;
 
 	if (node &&
-- 
2.8.2
