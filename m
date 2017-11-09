Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 12:03:19 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.230]:42211 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990483AbdKILDH3zRix (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Nov 2017 12:03:07 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 09 Nov 2017 11:02:56 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Thu, 9 Nov 2017 03:02:53 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "Jason Cooper" <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] irqchip/mips-gic: Add pr_fmt and reword pr_* messages
Date:   Thu, 9 Nov 2017 11:02:44 +0000
Message-ID: <1510225365-2584-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1510225376-321458-16046-53236-1
X-BESS-VER: 2017.12-r1709122024
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186750
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
X-archive-position: 60797
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

Several messages from the MIPS GIC driver include the text "GIC", but
the format is not standard. Add a pr_fmt of "irq-mips-gic: " and reword
the messages now that they will be prefixed with the driver name.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Reviewed-by: Paul Burton <paul.burton@mips.com>
---

 drivers/irqchip/irq-mips-gic.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 3ccebb020f40..9b768899f07b 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -6,6 +6,9 @@
  * Copyright (C) 2008 Ralf Baechle (ralf@linux-mips.org)
  * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
+
+#define pr_fmt(fmt) "irq-mips-gic: " fmt
+
 #include <linux/bitmap.h>
 #include <linux/clocksource.h>
 #include <linux/cpuhotplug.h>
@@ -685,7 +688,7 @@ static int __init gic_of_init(struct device_node *node,
 
 	cpu_vec = find_first_zero_bit(&reserved, hweight_long(ST0_IM));
 	if (cpu_vec == hweight_long(ST0_IM)) {
-		pr_err("No CPU vectors available for GIC\n");
+		pr_err("No CPU vectors available\n");
 		return -ENODEV;
 	}
 
@@ -699,7 +702,7 @@ static int __init gic_of_init(struct device_node *node,
 				~CM_GCR_GIC_BASE_GICEN;
 			gic_len = 0x20000;
 		} else {
-			pr_err("Failed to get GIC memory range\n");
+			pr_err("Failed to get memory range\n");
 			return -ENODEV;
 		}
 	} else {
@@ -757,7 +760,7 @@ static int __init gic_of_init(struct device_node *node,
 					       gic_shared_intrs, 0,
 					       &gic_irq_domain_ops, NULL);
 	if (!gic_irq_domain) {
-		pr_err("Failed to add GIC IRQ domain");
+		pr_err("Failed to add IRQ domain");
 		return -ENXIO;
 	}
 
@@ -766,7 +769,7 @@ static int __init gic_of_init(struct device_node *node,
 						  GIC_NUM_LOCAL_INTRS + gic_shared_intrs,
 						  node, &gic_ipi_domain_ops, NULL);
 	if (!gic_ipi_domain) {
-		pr_err("Failed to add GIC IPI domain");
+		pr_err("Failed to add IPI domain");
 		return -ENXIO;
 	}
 
-- 
2.7.4
