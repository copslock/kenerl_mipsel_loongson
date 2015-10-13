Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2015 12:20:43 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4656 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010515AbbJMKRHhooUs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2015 12:17:07 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A376DE7E40B13;
        Tue, 13 Oct 2015 11:16:59 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 13 Oct 2015 11:17:01 +0100
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 13 Oct 2015 11:17:01 +0100
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [RFC v2 PATCH 13/14] irqchip: mips-gic: implement the new irq_send_ipi
Date:   Tue, 13 Oct 2015 11:16:21 +0100
Message-ID: <1444731382-19313-14-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com>
References: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49509
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

Now irqchip has a irq_send_ipi() function, implement gic_send_ipi()
to make use of it

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 drivers/irqchip/irq-mips-gic.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 9c8ece1d90f2..764470375cd0 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -266,9 +266,24 @@ static void gic_bind_eic_interrupt(int irq, int set)
 		  GIC_VPE_EIC_SS(irq), set);
 }
 
-void gic_send_ipi(unsigned int intr)
+static void gic_send_ipi(struct irq_data *d, const struct ipi_mask *cpumask)
 {
-	gic_write(GIC_REG(SHARED, GIC_SH_WEDGE), GIC_SH_WEDGE_SET(intr));
+	struct ipi_mapping *map = irq_data_get_irq_chip_data(d);
+	irq_hw_number_t intr;
+	int vpe;
+
+	if (!map)
+		return;
+
+	vpe = find_first_bit(cpumask->cpumask, cpumask->nbits);
+	while (vpe != cpumask->nbits) {
+		intr = map->cpumap[vpe];
+		if (intr == INVALID_HWIRQ)
+			continue;
+		gic_write(GIC_REG(SHARED, GIC_SH_WEDGE), GIC_SH_WEDGE_SET(intr));
+
+		vpe = find_next_bit(cpumask->cpumask, cpumask->nbits, vpe + 1);
+	}
 }
 
 int gic_get_c0_compare_int(void)
@@ -476,6 +491,7 @@ static struct irq_chip gic_edge_irq_controller = {
 #ifdef CONFIG_SMP
 	.irq_set_affinity	=	gic_set_affinity,
 #endif
+	.irq_send_ipi		=	gic_send_ipi,
 };
 
 static void gic_handle_local_int(bool chained)
-- 
2.1.0
