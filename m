Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2017 17:45:00 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:38688 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992366AbdJaQntwD8qA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Oct 2017 17:43:49 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx2.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 31 Oct 2017 16:43:36 +0000
Received: from pburton-laptop.mipstec.com (10.20.1.18) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Tue, 31 Oct 2017
 09:41:01 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH v2 6/8] irqchip: mips-gic: Remove gic_vpes variable
Date:   Tue, 31 Oct 2017 09:41:49 -0700
Message-ID: <20171031164151.6357-7-paul.burton@mips.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171031164151.6357-1-paul.burton@mips.com>
References: <867evc5cc9.fsf@arm.com>
 <20171031164151.6357-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1509468178-298553-26023-82397-3
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186454
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60608
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

Following the past few patches nothing uses the gic_vpes variable any
longer. Remove the dead code.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---

Changes in v2: None

 drivers/irqchip/irq-mips-gic.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 4304283bfb1a..48f0f43cd05d 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -49,7 +49,6 @@ static DEFINE_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
 static struct irq_domain *gic_ipi_domain;
 static int gic_shared_intrs;
-static int gic_vpes;
 static unsigned int gic_cpu_pin;
 static unsigned int timer_cpu_pin;
 static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
@@ -721,10 +720,6 @@ static int __init gic_of_init(struct device_node *node,
 	gic_shared_intrs >>= __ffs(GIC_CONFIG_NUMINTERRUPTS);
 	gic_shared_intrs = (gic_shared_intrs + 1) * 8;
 
-	gic_vpes = gicconfig & GIC_CONFIG_PVPS;
-	gic_vpes >>= __ffs(GIC_CONFIG_PVPS);
-	gic_vpes = gic_vpes + 1;
-
 	if (cpu_has_veic) {
 		/* Always use vector 1 in EIC mode */
 		gic_cpu_pin = 0;
-- 
2.14.3
