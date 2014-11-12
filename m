Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 20:44:44 +0100 (CET)
Received: from mail-pd0-f202.google.com ([209.85.192.202]:38708 "EHLO
        mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013554AbaKLTnzf5fJY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 20:43:55 +0100
Received: by mail-pd0-f202.google.com with SMTP id ft15so2070915pdb.1
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 11:43:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CczhxnDX+wBA2FN74WL4mPtQDgOshyhZc6EAlkKFW4c=;
        b=hk+xDG+3o7rHhG5DFiJZYKwn+Pocl+z18bHbhf2JnbTb3MQXOHU+5RCYPcCH5MED3l
         PWDHyRyfXIWCKtmJCjEmdsvezOWHnIq6Yn68aL21QRECrSNIr+37wTKvkOnxK/yS5v3p
         tG6qW9m5+5Qh95kggr+1vHTXesYjTHXVzsqDBbga1xbhAqwpEW1e6BJFtFLaBZ++oUlz
         7UKDj6ALKyE6WC0RKQ0fipmwmnPwCoYcNt9+4czqi0avKljHzWder5pacHfqEJpwHiKX
         QLTxo0Qn4tMLUDce5RE+M+6JONtxQgLwHi4d5j/R7BlXSwg23JOG3dtQAxCnnKN/WXQo
         D8HA==
X-Gm-Message-State: ALoCoQmdSQ5bT+ZwxE7yoFGhEQm5sn0Z18l0UCPvPPlYvrGbBFUC87jexwhdrwcsA5JD7LGHIqzB
X-Received: by 10.66.161.3 with SMTP id xo3mr37587657pab.22.1415821429241;
        Wed, 12 Nov 2014 11:43:49 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id t28si964438yhb.4.2014.11.12.11.43.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Nov 2014 11:43:49 -0800 (PST)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id uqzOe2m2.1; Wed, 12 Nov 2014 11:43:49 -0800
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 763D3220BC1; Wed, 12 Nov 2014 11:43:47 -0800 (PST)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 4/4] clocksource: mips-gic: Add device-tree support
Date:   Wed, 12 Nov 2014 11:43:39 -0800
Message-Id: <1415821419-26974-5-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1415821419-26974-1-git-send-email-abrestic@chromium.org>
References: <1415821419-26974-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Parse the GIC timer frequency and interrupt from the device-tree.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
Changes from v4:
 - don't probe from irqchip; just warn if DT is wrong
Changes from v3:
 - probe from GIC irqchip
New for v3.
---
 drivers/clocksource/Kconfig          |  1 +
 drivers/clocksource/mips-gic-timer.c | 41 ++++++++++++++++++++++++++++++------
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index cb7e7f4..89836dc 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -226,5 +226,6 @@ config CLKSRC_VERSATILE
 config CLKSRC_MIPS_GIC
 	bool
 	depends on MIPS_GIC
+	select CLKSRC_OF
 
 endmenu
diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index a749c81..3bd31b1 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -11,6 +11,7 @@
 #include <linux/interrupt.h>
 #include <linux/irqchip/mips-gic.h>
 #include <linux/notifier.h>
+#include <linux/of_irq.h>
 #include <linux/percpu.h>
 #include <linux/smp.h>
 #include <linux/time.h>
@@ -101,8 +102,6 @@ static int gic_clockevent_init(void)
 	if (!cpu_has_counter || !gic_frequency)
 		return -ENXIO;
 
-	gic_timer_irq = MIPS_GIC_IRQ_BASE +
-		GIC_LOCAL_TO_HWIRQ(GIC_LOCAL_INT_COMPARE);
 	setup_percpu_irq(gic_timer_irq, &gic_compare_irqaction);
 
 	register_cpu_notifier(&gic_cpu_nb);
@@ -123,17 +122,45 @@ static struct clocksource gic_clocksource = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-void __init gic_clocksource_init(unsigned int frequency)
+static void __init __gic_clocksource_init(void)
 {
-	gic_frequency = frequency;
-
 	/* Set clocksource mask. */
 	gic_clocksource.mask = CLOCKSOURCE_MASK(gic_get_count_width());
 
 	/* Calculate a somewhat reasonable rating value. */
-	gic_clocksource.rating = 200 + frequency / 10000000;
+	gic_clocksource.rating = 200 + gic_frequency / 10000000;
 
-	clocksource_register_hz(&gic_clocksource, frequency);
+	clocksource_register_hz(&gic_clocksource, gic_frequency);
 
 	gic_clockevent_init();
 }
+
+void __init gic_clocksource_init(unsigned int frequency)
+{
+	gic_frequency = frequency;
+	gic_timer_irq = MIPS_GIC_IRQ_BASE +
+		GIC_LOCAL_TO_HWIRQ(GIC_LOCAL_INT_COMPARE);
+
+	__gic_clocksource_init();
+}
+
+static void __init gic_clocksource_of_init(struct device_node *node)
+{
+	if (WARN_ON(!gic_present || !node->parent ||
+		    !of_device_is_compatible(node->parent, "mti,gic")))
+		return;
+
+	if (of_property_read_u32(node, "clock-frequency", &gic_frequency)) {
+		pr_err("GIC frequency not specified.\n");
+		return;
+	}
+	gic_timer_irq = irq_of_parse_and_map(node, 0);
+	if (!gic_timer_irq) {
+		pr_err("GIC timer IRQ not specified.\n");
+		return;
+	}
+
+	__gic_clocksource_init();
+}
+CLOCKSOURCE_OF_DECLARE(mips_gic_timer, "mti,gic-timer",
+		       gic_clocksource_of_init);
-- 
2.1.0.rc2.206.gedb03e5
