Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2012 19:50:13 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:61911 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825706Ab2JWRsEriRgx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2012 19:48:04 +0200
Received: by mail-lb0-f177.google.com with SMTP id gi11so520885lbb.36
        for <multiple recipients>; Tue, 23 Oct 2012 10:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=xJTLIqiLi/yb4cx2+H7jQT7CoZ07FHS3bCaIlFbuB4U=;
        b=LJTwN49Zeig5/j/pT7YsIkvrPjK7xnp9HruDvT/+8JoloaiAxDytJraAsCMk+8hL4n
         Bbe1wpldeFFUNohZaCmaGXckQyCXBSyAIdY1k/ZO9WHrqeR7PB+rJwVhAe3a9pATKO9D
         HnqCzdnUpkl6YA0KY4WoBI7oba1ImjHPU1N6BMAZCCcB0GhYFnHzTxQv1+OptB4lNk/v
         XDHuuDAKDI7znSGXp/vISkdEa0uPRo5aRV9ZTveIn1+2DIHx/JWcfEi8G/xAeHaOcDiT
         O3EE7eSf8VGQ9bSjk187KUjjMHoI0jifi187LXTn3Si+1nam2GyYMKhHGeivLvpMcGq+
         ArwQ==
Received: by 10.112.48.200 with SMTP id o8mr5300263lbn.96.1351014478683;
        Tue, 23 Oct 2012 10:47:58 -0700 (PDT)
Received: from lazar.cs.niisi.ras.ru (t109.niisi.ras.ru. [193.232.173.109])
        by mx.google.com with ESMTPS id m6sm4260284lbh.10.2012.10.23.10.47.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Oct 2012 10:47:57 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Antony Pavlov <antonynpavlov@gmail.com>
Subject: [RFC 05/13] MIPS: JZ4750D: Add clocksource/clockevent support
Date:   Tue, 23 Oct 2012 21:43:53 +0400
Message-Id: <1351014241-3207-6-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
References: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
X-archive-position: 34757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Add clocksource and clockevent support for the timer/counter unit on
JZ4750D SoCs.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
---
 arch/mips/jz4750d/time.c |  145 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)
 create mode 100644 arch/mips/jz4750d/time.c

diff --git a/arch/mips/jz4750d/time.c b/arch/mips/jz4750d/time.c
new file mode 100644
index 0000000..5df91e0
--- /dev/null
+++ b/arch/mips/jz4750d/time.c
@@ -0,0 +1,145 @@
+/*
+ *  Copyright (C) 2012, Antony Pavlov <antonynpavlov@gmail.com>
+ *  JZ4750D platform time support
+ *
+ *  based on JZ4740 platform time support
+ *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/time.h>
+
+#include <linux/clockchips.h>
+
+#include <asm/time.h>
+
+#include "clock.h"
+#include "timer.h"
+
+#define TIMER_CLOCKEVENT 5
+
+static uint16_t jz4750d_jiffies_per_tick;
+
+static cycle_t jz4750d_clocksource_read(struct clocksource *cs)
+{
+	return (cycle_t)jz4750d_ostimer_get_count();
+}
+
+static struct clocksource jz4750d_clocksource = {
+	.name = "jz4750d-timer",
+	.rating = 200,
+	.read = jz4750d_clocksource_read,
+	.mask = CLOCKSOURCE_MASK(32),
+	.flags = CLOCK_SOURCE_WATCHDOG,
+};
+
+static irqreturn_t jz4750d_clockevent_irq(int irq, void *devid)
+{
+	struct clock_event_device *cd = devid;
+
+	jz4750d_timer_ack_full(TIMER_CLOCKEVENT);
+
+	if (cd->mode != CLOCK_EVT_MODE_PERIODIC)
+		jz4750d_timer_disable(TIMER_CLOCKEVENT);
+
+	cd->event_handler(cd);
+
+	return IRQ_HANDLED;
+}
+
+static void jz4750d_clockevent_set_mode(enum clock_event_mode mode,
+	struct clock_event_device *cd)
+{
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		jz4750d_timer_set_count(TIMER_CLOCKEVENT, 0);
+		jz4750d_timer_set_period(TIMER_CLOCKEVENT, jz4750d_jiffies_per_tick);
+	case CLOCK_EVT_MODE_RESUME:
+		jz4750d_timer_irq_full_enable(TIMER_CLOCKEVENT);
+		jz4750d_timer_enable(TIMER_CLOCKEVENT);
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		jz4750d_timer_disable(TIMER_CLOCKEVENT);
+		break;
+	default:
+		break;
+	}
+}
+
+static int jz4750d_clockevent_set_next(unsigned long evt,
+	struct clock_event_device *cd)
+{
+	jz4750d_timer_set_count(TIMER_CLOCKEVENT, 0);
+	jz4750d_timer_set_period(TIMER_CLOCKEVENT, evt);
+	jz4750d_timer_enable(TIMER_CLOCKEVENT);
+
+	return 0;
+}
+
+static struct clock_event_device jz4750d_clockevent = {
+	.name = "jz4750d-timer",
+	.features = CLOCK_EVT_FEAT_PERIODIC,
+	.set_next_event = jz4750d_clockevent_set_next,
+	.set_mode = jz4750d_clockevent_set_mode,
+	.rating = 200,
+	.irq = JZ4750D_IRQ_TCU1,
+};
+
+static struct irqaction timer_irqaction = {
+	.handler = jz4750d_clockevent_irq,
+	.flags = IRQF_DISABLED | IRQF_PERCPU | IRQF_TIMER,
+	.name = "jz4750d-timerirq",
+	.dev_id = &jz4750d_clockevent,
+};
+
+void __init plat_time_init(void)
+{
+	int ret;
+	uint32_t clk_rate;
+
+	jz4750d_timer_init();
+
+	clk_rate = jz4750d_clock_bdata.ext_rate >> 4;
+	jz4750d_jiffies_per_tick = DIV_ROUND_CLOSEST(clk_rate, HZ);
+
+	clockevent_set_clock(&jz4750d_clockevent, clk_rate);
+	jz4750d_clockevent.min_delta_ns =
+		clockevent_delta2ns(100, &jz4750d_clockevent);
+	jz4750d_clockevent.max_delta_ns =
+		clockevent_delta2ns(0xffff, &jz4750d_clockevent);
+	jz4750d_clockevent.cpumask = cpumask_of(0);
+
+	jz4750d_timer_irq_full_disable(TIMER_CLOCKEVENT);
+
+	clockevents_register_device(&jz4750d_clockevent);
+
+	ret = clocksource_register_hz(&jz4750d_clocksource, clk_rate);
+
+	if (ret)
+		printk(KERN_ERR "Failed to register clocksource: %d\n", ret);
+
+	setup_irq(JZ4750D_IRQ_TCU1, &timer_irqaction);
+
+	jz4750d_timer_set_ctrl(TIMER_CLOCKEVENT, JZ_TIMER_CTRL_PRESCALE_16
+		| JZ_TIMER_CTRL_SRC_EXT);
+	jz4750d_ostimer_set_ctrl(JZ_OSTIMER_CTRL_PRESCALE_16
+		| JZ_OSTIMER_CTRL_SRC_EXT);
+
+	jz4750d_timer_set_period(TIMER_CLOCKEVENT, jz4750d_jiffies_per_tick);
+	jz4750d_timer_irq_full_enable(TIMER_CLOCKEVENT);
+
+	jz4750d_ostimer_set_period(0xffffffff);
+
+	jz4750d_timer_enable(TIMER_CLOCKEVENT);
+	jz4750d_timer_start(TIMER_CLOCKEVENT);
+	jz4750d_ostimer_enable();
+	jz4750d_ostimer_start();
+}
-- 
1.7.10.4
