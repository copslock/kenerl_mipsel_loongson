Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2017 17:44:08 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:47687 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992346AbdJaQnbvZ-LA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Oct 2017 17:43:31 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx2.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 31 Oct 2017 16:43:21 +0000
Received: from pburton-laptop.mipstec.com (10.20.1.18) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Tue, 31 Oct 2017
 09:41:01 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH v2 5/8] irqchip: mips-gic: Use num_possible_cpus() to reserve IPIs
Date:   Tue, 31 Oct 2017 09:41:48 -0700
Message-ID: <20171031164151.6357-6-paul.burton@mips.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171031164151.6357-1-paul.burton@mips.com>
References: <867evc5cc9.fsf@arm.com>
 <20171031164151.6357-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1509468178-298553-26023-82397-2
X-BESS-VER: 2017.12-r1710252241
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
X-archive-position: 60606
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

Reserving a number of IPIs based upon the number of VPs reported by the
GIC makes little sense for a few reasons:

 - The kernel may have been configured with NR_CPUS less than the number
   of VPs in the cluster, in which case using gic_vpes causes us to
   reserve more interrupts for IPIs than we will possibly use.

 - If a kernel is configured without support for multi-threading & runs
   on a system with multi-threading & multiple VPs per core then we'll
   similarly reserve more interrupts for IPIs than we will possibly use.

 - In systems with multiple clusters the GIC can only provide us with
   the number of VPs in its cluster, not across all clusters. In this
   case we'll reserve fewer interrupts for IPIs than we need.

Fix these issues by using num_possible_cpus() instead, which in all
cases is actually indicative of how many IPIs we may need.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---

Changes in v2: None

 drivers/irqchip/irq-mips-gic.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index b1320ccb9f94..4304283bfb1a 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -671,7 +671,7 @@ static int gic_cpu_startup(unsigned int cpu)
 static int __init gic_of_init(struct device_node *node,
 			      struct device_node *parent)
 {
-	unsigned int cpu_vec, i, gicconfig, v[2];
+	unsigned int cpu_vec, i, gicconfig, v[2], num_ipis;
 	unsigned long reserved;
 	phys_addr_t gic_base;
 	struct resource res;
@@ -781,10 +781,12 @@ static int __init gic_of_init(struct device_node *node,
 	    !of_property_read_u32_array(node, "mti,reserved-ipi-vectors", v, 2)) {
 		bitmap_set(ipi_resrv, v[0], v[1]);
 	} else {
-		/* Make the last 2 * gic_vpes available for IPIs */
-		bitmap_set(ipi_resrv,
-			   gic_shared_intrs - 2 * gic_vpes,
-			   2 * gic_vpes);
+		/*
+		 * Reserve 2 interrupts per possible CPU/VP for use as IPIs,
+		 * meeting the requirements of arch/mips SMP.
+		 */
+		num_ipis = 2 * num_possible_cpus();
+		bitmap_set(ipi_resrv, gic_shared_intrs - num_ipis, num_ipis);
 	}
 
 	bitmap_copy(ipi_available, ipi_resrv, GIC_MAX_INTRS);
-- 
2.14.3
