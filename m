Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 06:38:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61661 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992036AbdHMEiWHRYJd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 06:38:22 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id BA10B1D686416;
        Sun, 13 Aug 2017 05:38:13 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 05:38:15 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 03/38] clocksource: mips-gic-timer: Use new GIC accessor functions
Date:   Sat, 12 Aug 2017 21:36:11 -0700
Message-ID: <20170813043646.25821-4-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170813043646.25821-1-paul.burton@imgtec.com>
References: <20170813043646.25821-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.142]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Switch from calling functions exported by the GIC interrupt controller
to using new accessors provided by asm/mips-gic.h. This will allow the
counter-handling functionality to be removed from the interrupt
controller driver, where it doesn't really belong, and also allow for
inlining of the accesses to the GIC.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---

 drivers/clocksource/mips-gic-timer.c | 37 ++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 17b861ea2626..ae3167c28b12 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -10,25 +10,45 @@
 #include <linux/cpu.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/irqchip/mips-gic.h>
 #include <linux/notifier.h>
 #include <linux/of_irq.h>
 #include <linux/percpu.h>
 #include <linux/smp.h>
 #include <linux/time.h>
+#include <asm/mips-cps.h>
 
 static DEFINE_PER_CPU(struct clock_event_device, gic_clockevent_device);
 static int gic_timer_irq;
 static unsigned int gic_frequency;
 
+static u64 notrace gic_read_count(void)
+{
+	unsigned int hi, hi2, lo;
+
+	if (mips_cm_is64)
+		return read_gic_counter();
+
+	do {
+		hi = read_gic_counter_32h();
+		lo = read_gic_counter_32l();
+		hi2 = read_gic_counter_32h();
+	} while (hi2 != hi);
+
+	return (((u64) hi) << 32) + lo;
+}
+
 static int gic_next_event(unsigned long delta, struct clock_event_device *evt)
 {
+	unsigned long flags;
 	u64 cnt;
 	int res;
 
 	cnt = gic_read_count();
 	cnt += (u64)delta;
-	gic_write_cpu_compare(cnt, cpumask_first(evt->cpumask));
+	local_irq_save(flags);
+	write_gic_vl_other(mips_cm_vp_id(cpumask_first(evt->cpumask)));
+	write_gic_vo_compare(cnt);
+	local_irq_restore(flags);
 	res = ((int)(gic_read_count() - cnt) >= 0) ? -ETIME : 0;
 	return res;
 }
@@ -37,7 +57,7 @@ static irqreturn_t gic_compare_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *cd = dev_id;
 
-	gic_write_compare(gic_read_compare());
+	write_gic_vl_compare(read_gic_vl_compare());
 	cd->event_handler(cd);
 	return IRQ_HANDLED;
 }
@@ -139,10 +159,15 @@ static struct clocksource gic_clocksource = {
 
 static int __init __gic_clocksource_init(void)
 {
+	unsigned int count_width;
 	int ret;
 
 	/* Set clocksource mask. */
-	gic_clocksource.mask = CLOCKSOURCE_MASK(gic_get_count_width());
+	count_width = read_gic_config() & GIC_CONFIG_COUNTBITS;
+	count_width >>= __fls(GIC_CONFIG_COUNTBITS);
+	count_width *= 4;
+	count_width += 32;
+	gic_clocksource.mask = CLOCKSOURCE_MASK(count_width);
 
 	/* Calculate a somewhat reasonable rating value. */
 	gic_clocksource.rating = 200 + gic_frequency / 10000000;
@@ -159,7 +184,7 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 	struct clk *clk;
 	int ret;
 
-	if (!gic_present || !node->parent ||
+	if (!mips_gic_present() || !node->parent ||
 	    !of_device_is_compatible(node->parent, "mti,gic")) {
 		pr_warn("No DT definition for the mips gic driver\n");
 		return -ENXIO;
@@ -197,7 +222,7 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 	}
 
 	/* And finally start the counter */
-	gic_start_count();
+	clear_gic_config(GIC_CONFIG_COUNTSTOP);
 
 	return 0;
 }
-- 
2.14.0
