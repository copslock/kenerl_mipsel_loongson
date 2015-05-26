Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2015 20:45:25 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55996 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007278AbbEZSpYJLPtK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 May 2015 20:45:24 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 61F16B374E3D5;
        Tue, 26 May 2015 19:45:17 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 26 May
 2015 19:43:17 +0100
Received: from laptop.hh.imgtec.org (10.100.200.175) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Tue, 26 May
 2015 19:43:16 +0100
From:   Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        <devicetree@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        <Govindraj.Raja@imgtec.com>, <Damien.Horsley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH v2 4/7] clocksource: mips-gic: Update clockevent frequency on clock rate changes
Date:   Tue, 26 May 2015 15:39:05 -0300
Message-ID: <1432665548-16024-5-git-send-email-ezequiel.garcia@imgtec.com>
X-Mailer: git-send-email 2.3.3
In-Reply-To: <1432665548-16024-1-git-send-email-ezequiel.garcia@imgtec.com>
References: <1432665548-16024-1-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.175]
Return-Path: <Ezequiel.Garcia@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel.garcia@imgtec.com
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

This commit introduces the clockevent frequency update, using
a clock notifier. It will be used to support CPUFreq on platforms
using MIPS GIC based clockevents.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 drivers/clocksource/mips-gic-timer.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 22a4daf..a155bec 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -79,6 +79,13 @@ static void gic_clockevent_cpu_exit(struct clock_event_device *cd)
 	disable_percpu_irq(gic_timer_irq);
 }
 
+static void gic_update_frequency(void *data)
+{
+	unsigned long rate = (unsigned long)data;
+
+	clockevents_update_freq(this_cpu_ptr(&gic_clockevent_device), rate);
+}
+
 static int gic_cpu_notifier(struct notifier_block *nb, unsigned long action,
 				void *data)
 {
@@ -94,10 +101,26 @@ static int gic_cpu_notifier(struct notifier_block *nb, unsigned long action,
 	return NOTIFY_OK;
 }
 
+static int gic_clk_notifier(struct notifier_block *nb, unsigned long action,
+			    void *data)
+{
+	struct clk_notifier_data *cnd = data;
+
+	if (action == POST_RATE_CHANGE)
+		on_each_cpu(gic_update_frequency, (void *)cnd->new_rate, 1);
+
+	return NOTIFY_OK;
+}
+
+
 static struct notifier_block gic_cpu_nb = {
 	.notifier_call = gic_cpu_notifier,
 };
 
+static struct notifier_block gic_clk_nb = {
+	.notifier_call = gic_clk_notifier,
+};
+
 static int gic_clockevent_init(void)
 {
 	int ret;
@@ -160,6 +183,7 @@ void __init gic_clocksource_init(unsigned int frequency)
 static void __init gic_clocksource_of_init(struct device_node *node)
 {
 	struct clk *clk;
+	int ret;
 
 	if (WARN_ON(!gic_present || !node->parent ||
 		    !of_device_is_compatible(node->parent, "mti,gic")))
@@ -186,7 +210,12 @@ static void __init gic_clocksource_of_init(struct device_node *node)
 	}
 
 	__gic_clocksource_init();
-	gic_clockevent_init();
+
+	ret = gic_clockevent_init();
+	if (!ret && !IS_ERR(clk)) {
+		if (clk_notifier_register(clk, &gic_clk_nb) < 0)
+			pr_warn("GIC: Unable to register clock notifier\n");
+	}
 
 	/* And finally start the counter */
 	gic_start_count();
-- 
2.3.3
