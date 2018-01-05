Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 11:34:46 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:40157 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992917AbeAEKeGBA5Ru (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jan 2018 11:34:06 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 05 Jan 2018 10:33:44 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Fri, 5 Jan 2018 02:33:04 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "Marc Zyngier" <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] irqchip/mips-gic: Separate local interrupt handling.
Date:   Fri, 5 Jan 2018 10:31:10 +0000
Message-ID: <1515148270-9391-7-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1515148270-9391-1-git-send-email-matt.redfearn@mips.com>
References: <1515148270-9391-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1515148424-637138-32445-543760-3
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
X-archive-position: 61910
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

The GIC driver now has the concept of multiple vectors for the shared
and local interrupts. The vector number for shared interrupt sources is
now in shared_cpu_pin and this effectively leaves gic_cpu_pin
containing the vector number for local interrupts. Rename it, and
additionally __gic_irq_dispatch to __gic_irq_dispatch_local, which is
only called for local interrupt sources now so no longer needs to handle
shared interrupts.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

---

 drivers/irqchip/irq-mips-gic.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 541eae9a491d..b2cfc6d66d74 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -53,7 +53,7 @@ static struct irq_domain *gic_irq_domain;
 static struct irq_domain *gic_ipi_domain;
 static int gic_shared_intrs;
 static unsigned int shared_cpu_pin;
-static unsigned int gic_cpu_pin;
+static unsigned int local_cpu_pin;
 static unsigned int timer_cpu_pin;
 static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
 static DECLARE_BITMAP(ipi_resrv, GIC_MAX_INTRS);
@@ -401,10 +401,9 @@ static struct irq_chip gic_all_vpes_local_irq_controller = {
 	.irq_cpu_online		= gic_all_vpes_irq_cpu_online,
 };
 
-static void __gic_irq_dispatch(void)
+static void __gic_irq_dispatch_local(void)
 {
 	gic_handle_local_int(false);
-	gic_handle_shared_int(false);
 }
 
 static void __gic_irq_dispatch_shared(void)
@@ -482,7 +481,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	}
 
 	intr = GIC_HWIRQ_TO_LOCAL(hwirq);
-	map = GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin;
+	map = GIC_MAP_PIN_MAP_TO_PIN | local_cpu_pin;
 
 	switch (intr) {
 	case GIC_LOCAL_INT_TIMER:
@@ -735,18 +734,17 @@ static int __init gic_of_init(struct device_node *node,
 	mips_gic_enable_eic();
 
 	if (cpu_has_veic) {
-		/* Always use vector 1 in EIC mode */
-		gic_cpu_pin = 0;
-		timer_cpu_pin = gic_cpu_pin;
-		set_vi_handler(gic_cpu_pin + GIC_PIN_TO_VEC_OFFSET,
-			       __gic_irq_dispatch);
+		/* Route all local interrupts to pin 0, vector 1 */
+		timer_cpu_pin = local_cpu_pin = 0;
+		set_vi_handler(local_cpu_pin + GIC_PIN_TO_VEC_OFFSET,
+			       __gic_irq_dispatch_local);
 
 		/* Route all shared interrupts to pin 1, vector 2 */
 		shared_cpu_pin = 1;
 		set_vi_handler(shared_cpu_pin + GIC_PIN_TO_VEC_OFFSET,
 			       __gic_irq_dispatch_shared);
 	} else {
-		shared_cpu_pin = gic_cpu_pin = cpu_vec - GIC_CPU_PIN_OFFSET;
+		shared_cpu_pin = local_cpu_pin = cpu_vec - GIC_CPU_PIN_OFFSET;
 		irq_set_chained_handler(MIPS_CPU_IRQ_BASE + cpu_vec,
 					gic_irq_dispatch);
 		/*
@@ -768,7 +766,7 @@ static int __init gic_of_init(struct device_node *node,
 						timer_cpu_pin,
 						gic_irq_dispatch);
 		} else {
-			timer_cpu_pin = gic_cpu_pin;
+			timer_cpu_pin = local_cpu_pin;
 		}
 	}
 
-- 
2.7.4
