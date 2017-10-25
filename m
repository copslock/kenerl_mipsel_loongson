Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Oct 2017 01:39:33 +0200 (CEST)
Received: from 5pmail.ess.barracuda.com ([64.235.154.203]:51723 "EHLO
        5pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991978AbdJYXi367KsS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Oct 2017 01:38:29 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 25 Oct 2017 23:38:18 +0000
Received: from pburton-laptop.mipstec.com (10.20.1.18) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Wed, 25 Oct 2017
 16:36:21 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH 4/8] irqchip: mips-gic: Configure EIC when CPUs come online
Date:   Wed, 25 Oct 2017 16:37:26 -0700
Message-ID: <20171025233730.22225-5-paul.burton@mips.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171025233730.22225-1-paul.burton@mips.com>
References: <20171025233730.22225-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1508974696-321459-28744-58481-8
X-BESS-VER: 2017.12-r1709122024
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186295
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Rather than configuring EIC mode for all CPUs during boot, configure it
locally on each when they come online. This will become important with
multi-cluster support, since clusters may be powered on & off (for
example via hotplug) and would lose the EIC configuration when powered
off.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---

 drivers/irqchip/irq-mips-gic.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 2a31949d09ce..95daa96d8b52 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -655,6 +655,10 @@ static const struct irq_domain_ops gic_ipi_domain_ops = {
 
 static int gic_cpu_startup(unsigned int cpu)
 {
+	/* Enable or disable EIC */
+	change_gic_vl_ctl(GIC_VX_CTL_EIC,
+			  cpu_has_veic ? GIC_VX_CTL_EIC : 0);
+
 	/* Clear all local IRQ masks (ie. disable all local interrupts) */
 	write_gic_vl_rmask(~0);
 
@@ -667,7 +671,7 @@ static int gic_cpu_startup(unsigned int cpu)
 static int __init gic_of_init(struct device_node *node,
 			      struct device_node *parent)
 {
-	unsigned int cpu_vec, i, gicconfig, cpu, v[2];
+	unsigned int cpu_vec, i, gicconfig, v[2];
 	unsigned long reserved;
 	phys_addr_t gic_base;
 	struct resource res;
@@ -722,12 +726,6 @@ static int __init gic_of_init(struct device_node *node,
 	gic_vpes = gic_vpes + 1;
 
 	if (cpu_has_veic) {
-		/* Set EIC mode for all VPEs */
-		for_each_present_cpu(cpu) {
-			write_gic_vl_other(mips_cm_vp_id(cpu));
-			write_gic_vo_ctl(GIC_VX_CTL_EIC);
-		}
-
 		/* Always use vector 1 in EIC mode */
 		gic_cpu_pin = 0;
 		timer_cpu_pin = gic_cpu_pin;
-- 
2.14.3
