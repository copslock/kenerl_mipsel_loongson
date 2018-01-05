Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 11:34:23 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:44655 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992396AbeAEKd5Dg7Uu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jan 2018 11:33:57 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 05 Jan 2018 10:33:44 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Fri, 5 Jan 2018 02:33:02 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "Marc Zyngier" <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] irqchip/mips-gic: Use separate vector for shared interrupts in EIC mode
Date:   Fri, 5 Jan 2018 10:31:09 +0000
Message-ID: <1515148270-9391-6-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1515148270-9391-1-git-send-email-matt.redfearn@mips.com>
References: <1515148270-9391-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1515148423-321458-25580-45506-12
X-BESS-VER: 2017.16-r1712230000
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188674
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

In EIC mode, the GIC can assert 64 distinct interrupt sources in the
CPU. Until now, the GIC has routed all interrupt sources to a single CPU
interrupt source. This is inefficient since we end up checking both local
and shared interrupt flag registers for both local and shared
interrupts. This introduces additional latency into the interrupt paths
which is easy to remove in EIC mode by making use of an additional
vector for shared interrupt sources.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 drivers/irqchip/irq-mips-gic.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index ee391f42e97d..541eae9a491d 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -52,6 +52,7 @@ static DEFINE_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
 static struct irq_domain *gic_ipi_domain;
 static int gic_shared_intrs;
+static unsigned int shared_cpu_pin;
 static unsigned int gic_cpu_pin;
 static unsigned int timer_cpu_pin;
 static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
@@ -406,6 +407,11 @@ static void __gic_irq_dispatch(void)
 	gic_handle_shared_int(false);
 }
 
+static void __gic_irq_dispatch_shared(void)
+{
+	gic_handle_shared_int(false);
+}
+
 static void gic_irq_dispatch(struct irq_desc *desc)
 {
 	gic_handle_local_int(true);
@@ -422,7 +428,7 @@ static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	data = irq_get_irq_data(virq);
 
 	spin_lock_irqsave(&gic_lock, flags);
-	write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
+	write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | shared_cpu_pin);
 	write_gic_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
 	gic_clear_pcpu_masks(intr);
 	set_bit(intr, per_cpu_ptr(pcpu_masks, cpu));
@@ -734,8 +740,13 @@ static int __init gic_of_init(struct device_node *node,
 		timer_cpu_pin = gic_cpu_pin;
 		set_vi_handler(gic_cpu_pin + GIC_PIN_TO_VEC_OFFSET,
 			       __gic_irq_dispatch);
+
+		/* Route all shared interrupts to pin 1, vector 2 */
+		shared_cpu_pin = 1;
+		set_vi_handler(shared_cpu_pin + GIC_PIN_TO_VEC_OFFSET,
+			       __gic_irq_dispatch_shared);
 	} else {
-		gic_cpu_pin = cpu_vec - GIC_CPU_PIN_OFFSET;
+		shared_cpu_pin = gic_cpu_pin = cpu_vec - GIC_CPU_PIN_OFFSET;
 		irq_set_chained_handler(MIPS_CPU_IRQ_BASE + cpu_vec,
 					gic_irq_dispatch);
 		/*
-- 
2.7.4
