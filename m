Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2017 17:44:31 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:50674 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992364AbdJaQniI6G6A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Oct 2017 17:43:38 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 31 Oct 2017 16:43:14 +0000
Received: from pburton-laptop.mipstec.com (10.20.1.18) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Tue, 31 Oct 2017
 09:41:01 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH v2 4/8] irqchip: mips-gic: Configure EIC when CPUs come online
Date:   Tue, 31 Oct 2017 09:41:47 -0700
Message-ID: <20171031164151.6357-5-paul.burton@mips.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171031164151.6357-1-paul.burton@mips.com>
References: <867evc5cc9.fsf@arm.com>
 <20171031164151.6357-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1509468105-452059-3093-416304-5
X-BESS-VER: 2017.12.1-r1710261623
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186454
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
X-archive-position: 60607
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

Changes in v2: None

 drivers/irqchip/irq-mips-gic.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index bd732b256f67..b1320ccb9f94 100644
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
