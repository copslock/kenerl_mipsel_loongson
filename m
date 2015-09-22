Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 20:30:10 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56536 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009118AbbIVSaIgY0UP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 20:30:08 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1434FFA7310AD;
        Tue, 22 Sep 2015 19:29:59 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 19:30:02 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 19:30:00 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] irqchip: mips-gic: convert CPU numbers to VP IDs
Date:   Tue, 22 Sep 2015 11:29:10 -0700
Message-ID: <1442946551-27893-3-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1442946551-27893-1-git-send-email-paul.burton@imgtec.com>
References: <1442946551-27893-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49315
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

Make use of the mips_cm_vp_id function to convert from Linux CPU numbers
to the VP IDs used by hardware, which are not identical in all systems.
Without doing so we map interrupts to incorrect VP(E)s.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 drivers/irqchip/irq-mips-gic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index af2f16b..842a53d 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -426,7 +426,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 	spin_lock_irqsave(&gic_lock, flags);
 
 	/* Re-route this IRQ */
-	gic_map_to_vpe(irq, cpumask_first(&tmp));
+	gic_map_to_vpe(irq, mips_cm_vp_id(cpumask_first(&tmp)));
 
 	/* Update the pcpu_masks */
 	for (i = 0; i < NR_CPUS; i++)
@@ -599,7 +599,7 @@ static __init void gic_ipi_init_one(unsigned int intr, int cpu,
 				      GIC_SHARED_TO_HWIRQ(intr));
 	int i;
 
-	gic_map_to_vpe(intr, cpu);
+	gic_map_to_vpe(intr, mips_cm_vp_id(cpu));
 	for (i = 0; i < NR_CPUS; i++)
 		clear_bit(intr, pcpu_masks[i].pcpu_mask);
 	set_bit(intr, pcpu_masks[cpu].pcpu_mask);
-- 
2.5.3
