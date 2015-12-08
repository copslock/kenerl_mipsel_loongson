Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 14:25:33 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43971 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013386AbbLHNVntekPZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 14:21:43 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id BBF231979548B;
        Tue,  8 Dec 2015 13:21:35 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 8 Dec 2015 13:21:37 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 8 Dec 2015 13:21:37 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <lisa.parratt@imgtec.com>, Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH v4 14/19] irqchip/mips-gic: Use gic_vpes instead of NR_CPUS
Date:   Tue, 8 Dec 2015 13:20:25 +0000
Message-ID: <1449580830-23652-15-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1449580830-23652-1-git-send-email-qais.yousef@imgtec.com>
References: <1449580830-23652-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

NR_CPUS is set by Kconfig and could be much higher than what actually is in the
system.

gic_vpes should be a true representitives of the number of cpus in the system,
so use it instead.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 drivers/irqchip/irq-mips-gic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 0434bbd8227d..331376f39f59 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -465,7 +465,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 	gic_map_to_vpe(irq, mips_cm_vp_id(cpumask_first(&tmp)));
 
 	/* Update the pcpu_masks */
-	for (i = 0; i < NR_CPUS; i++)
+	for (i = 0; i < gic_vpes; i++)
 		clear_bit(irq, pcpu_masks[i].pcpu_mask);
 	set_bit(irq, pcpu_masks[cpumask_first(&tmp)].pcpu_mask);
 
@@ -1098,8 +1098,8 @@ static void __init __gic_init(unsigned long gic_base_addr,
 
 	gic_ipi_domain->bus_token = DOMAIN_BUS_IPI;
 
-	/* Make the last 2 * NR_CPUS available for IPIs */
-	bitmap_set(ipi_resrv, gic_shared_intrs - 2 * NR_CPUS, 2 * NR_CPUS);
+	/* Make the last 2 * gic_vpes available for IPIs */
+	bitmap_set(ipi_resrv, gic_shared_intrs - 2 * gic_vpes, 2 * gic_vpes);
 
 	gic_basic_init();
 
-- 
2.1.0
