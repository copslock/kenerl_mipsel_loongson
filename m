Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2018 14:33:20 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:59988 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990405AbeC2MdHxDB03 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Mar 2018 14:33:07 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 29 Mar 2018 12:32:56 +0000
Received: from mredfearn-linux.mipstec.com (192.168.155.41) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Thu, 29 Mar 2018 02:49:43 -0700
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] clocksource/drivers/mips-gic-timer: Add pr_fmt and reword pr_* messages
Date:   Thu, 29 Mar 2018 10:49:03 +0100
Message-ID: <1522316943-2542-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1513781406-27292-1-git-send-email-matt.redfearn@mips.com>
References: <1513781406-27292-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1522326776-452059-22107-55110-3
X-BESS-VER: 2018.4.1-r1803282120
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191512
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
X-archive-position: 63328
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

Several messages from the MIPS GIC driver include the text "GIC", "GIC
timer", etc, but the format is not standard. Add a pr_fmt of
"mips-gic-timer: " and reword the messages now that they will be
prefixed with the driver name.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

Changes in v2:
Rebase on v4.16-rc7

 drivers/clocksource/mips-gic-timer.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 986b6796b631..54f8a331b53a 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -5,6 +5,9 @@
  *
  * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
+
+#define pr_fmt(fmt) "mips-gic-timer: " fmt
+
 #include <linux/clk.h>
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
@@ -136,8 +139,7 @@ static int gic_clockevent_init(void)
 
 	ret = setup_percpu_irq(gic_timer_irq, &gic_compare_irqaction);
 	if (ret < 0) {
-		pr_err("GIC timer IRQ %d setup failed: %d\n",
-		       gic_timer_irq, ret);
+		pr_err("IRQ %d setup failed (%d)\n", gic_timer_irq, ret);
 		return ret;
 	}
 
@@ -176,7 +178,7 @@ static int __init __gic_clocksource_init(void)
 
 	ret = clocksource_register_hz(&gic_clocksource, gic_frequency);
 	if (ret < 0)
-		pr_warn("GIC: Unable to register clocksource\n");
+		pr_warn("Unable to register clocksource\n");
 
 	return ret;
 }
@@ -188,7 +190,7 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 
 	if (!mips_gic_present() || !node->parent ||
 	    !of_device_is_compatible(node->parent, "mti,gic")) {
-		pr_warn("No DT definition for the mips gic driver\n");
+		pr_warn("No DT definition\n");
 		return -ENXIO;
 	}
 
@@ -196,7 +198,7 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 	if (!IS_ERR(clk)) {
 		ret = clk_prepare_enable(clk);
 		if (ret < 0) {
-			pr_err("GIC failed to enable clock\n");
+			pr_err("Failed to enable clock\n");
 			clk_put(clk);
 			return ret;
 		}
@@ -204,12 +206,12 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 		gic_frequency = clk_get_rate(clk);
 	} else if (of_property_read_u32(node, "clock-frequency",
 					&gic_frequency)) {
-		pr_err("GIC frequency not specified.\n");
+		pr_err("Frequency not specified\n");
 		return -EINVAL;
 	}
 	gic_timer_irq = irq_of_parse_and_map(node, 0);
 	if (!gic_timer_irq) {
-		pr_err("GIC timer IRQ not specified.\n");
+		pr_err("IRQ not specified\n");
 		return -EINVAL;
 	}
 
@@ -220,7 +222,7 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 	ret = gic_clockevent_init();
 	if (!ret && !IS_ERR(clk)) {
 		if (clk_notifier_register(clk, &gic_clk_nb) < 0)
-			pr_warn("GIC: Unable to register clock notifier\n");
+			pr_warn("Unable to register clock notifier\n");
 	}
 
 	/* And finally start the counter */
-- 
2.7.4
