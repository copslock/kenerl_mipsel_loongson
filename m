Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jul 2017 09:39:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30648 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990924AbdGRHjdU9bQq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Jul 2017 09:39:33 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A0F92653C01A7;
        Tue, 18 Jul 2017 08:39:24 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 18 Jul 2017 08:39:26 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] irqchip/mips-gic: Remove population of irq domain names
Date:   Tue, 18 Jul 2017 08:39:21 +0100
Message-ID: <1500363561-32213-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Since commit d59f6617eef0f ("genirq: Allow fwnode to carry name
information only") the irqdomain core sets the names of irq domains.
When the name is allocated the new IRQ_DOMAIN_NAME_ALLOCATED flag is
set. Replacing the allocated name with a constant one is not a good
idea, since calling the new irq_domain_update_bus_token() API, added to
the MIPS GIC driver by commit 96f0d93a487e1 ("irqchip/MSI: Use
irq_domain_update_bus_token instead of an open coded access") will
attempt to kfree the pointer, and result in a kernel OOPS.

Fix this by removing the names, now that they are set by the irqdomain
core. This effectively reverts commit 21c57fd13589 ("irqchip/mips-gic:
Populate irq_domain names").

Fixes: d59f6617eef0f ("genirq: Allow fwnode to carry name information only")
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

 drivers/irqchip/irq-mips-gic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 832ebf4062f7..6ab1d3afec02 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -950,7 +950,6 @@ static void __init __gic_init(unsigned long gic_base_addr,
 					       &gic_irq_domain_ops, NULL);
 	if (!gic_irq_domain)
 		panic("Failed to add GIC IRQ domain");
-	gic_irq_domain->name = "mips-gic-irq";
 
 	gic_ipi_domain = irq_domain_add_hierarchy(gic_irq_domain,
 						  IRQ_DOMAIN_FLAG_IPI_PER_CPU,
@@ -959,7 +958,6 @@ static void __init __gic_init(unsigned long gic_base_addr,
 	if (!gic_ipi_domain)
 		panic("Failed to add GIC IPI domain");
 
-	gic_ipi_domain->name = "mips-gic-ipi";
 	irq_domain_update_bus_token(gic_ipi_domain, DOMAIN_BUS_IPI);
 
 	if (node &&
-- 
2.7.4
