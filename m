Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2018 12:31:23 +0200 (CEST)
Received: from mail-wr1-x443.google.com ([IPv6:2a00:1450:4864:20::443]:36950
        "EHLO mail-wr1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994558AbeJAKaaOE8od (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Oct 2018 12:30:30 +0200
Received: by mail-wr1-x443.google.com with SMTP id u12-v6so13281580wrr.4;
        Mon, 01 Oct 2018 03:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j2df1F7A1EojtFvWrbg9MeA0epkXwZN8rulW9WsbrEo=;
        b=DqUe6opM/X2Gj/1gnG7DUI9iflbk3YJ/VvY81FVN5RPJN7RjIKbXT9K5rWtTJZMwsD
         C2WUCtKAYddPLEaVi/sNEEP45m7mPcL0YqFbUMA4X/ddUBLp4CBjifzoxROz4JWyXUAY
         dPx835eV0uxnxUSCYqKpvzJVg2GT2EBZO60ajb5vPXuKyvG6rNpifDLKR6Y8j0T1Zy1s
         D/DfPBTR3cnIGqwnqpNp7OId9FinUm5nfEABzfEA9i5O+TPaQdsBKFNMWsM+exm7FkO3
         e+K14M+KZKuT+z9ErtaKumj/n5asOIhoux9b91+NwuZHJcWSsc1hSvCLGbfX3B1xSKlm
         0LTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j2df1F7A1EojtFvWrbg9MeA0epkXwZN8rulW9WsbrEo=;
        b=QR6ZHaHbZ7AZFDuJiqZ6d26sTxk8h4CqWO+x4Y60YXMO9UjqHxjeuZ4GzFosLI7rfz
         SuyvQAC4YXRdC8QPqClNIkJ+j4ZYFcGlxolArua7qU9OZcKz2WVt0loExXI2OZTZ1508
         72LQB+80swYyIxkpQ8CLe+4dSzqwWoNn1ayiDJgT+GMVQtK7s1aEj4XUnJTVUP9dwnpy
         foPzrAh82L4TmbVciVODNjppVVFzuYOV3LiDIqBM24X5PMhf3dmmENRxyQLkOFx4UhYG
         qVc66oBx9l3mlS1B6bBymfirtqINe2vC6l8cNLabq/qBW/E8MAR3B8tlIxRSiONA88cz
         U6Lg==
X-Gm-Message-State: ABuFfogA1X6NXOdy1cUf+M7fy1aVwtb5ZDGoWVZJccwlzqjtvH/DzoWS
        f0BvtM0ZachoaOXByA4g7Wrxcb59ySI=
X-Google-Smtp-Source: ACcGV61UHmG3nWLzeYv//BtAZv1v3WTaRK7kEyI/yTxo+dLzKo4FfyUpuQpawHaJnaQ5AgLRRps4Lg==
X-Received: by 2002:adf:a646:: with SMTP id k64-v6mr6081773wrc.41.1538389824635;
        Mon, 01 Oct 2018 03:30:24 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id g8-v6sm2461169wmf.45.2018.10.01.03.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 03:30:24 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 5/7] clocksource/drivers/rtl8186: Add RTL8186 timer driver
Date:   Mon,  1 Oct 2018 13:29:50 +0300
Message-Id: <20181001102952.7913-6-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001102952.7913-1-yasha.che3@gmail.com>
References: <20181001102952.7913-1-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <yasha.che3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yasha.che3@gmail.com
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

The Realtek RTL8186 SoC is a MIPS based SoC
used in some home routers [1][2].

This adds a driver to handle the built-in timers
on this SoC.

Timers 0 and 1 are 24bit timers.
Timers 2 and 3 are 32bit timers.

Use Timer2 as clocksource and Timer3 for clockevents.
Timer2 is also used for sched_clock.

[1] https://www.linux-mips.org/wiki/Realtek_SOC#Realtek_RTL8186
[2] https://wikidevi.com/wiki/Realtek_RTL8186

Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/clocksource/Kconfig         |   9 ++
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/timer-rtl8186.c | 220 ++++++++++++++++++++++++++++
 3 files changed, 230 insertions(+)
 create mode 100644 drivers/clocksource/timer-rtl8186.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index dec0dd88ec15..da87f73d0631 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -609,4 +609,13 @@ config ATCPIT100_TIMER
 	help
 	  This option enables support for the Andestech ATCPIT100 timers.
 
+config RTL8186_TIMER
+	bool "RTL8186 timer driver"
+	depends on MACH_RTL8186
+	depends on COMMON_CLK
+	select TIMER_OF
+	select CLKSRC_MMIO
+	help
+	  Enables support for the RTL8186 timer driver.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 00caf37e52f9..734e8566e1b6 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -78,3 +78,4 @@ obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
 obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
 obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
+obj-$(CONFIG_RTL8186_TIMER)		+= timer-rtl8186.o
diff --git a/drivers/clocksource/timer-rtl8186.c b/drivers/clocksource/timer-rtl8186.c
new file mode 100644
index 000000000000..47ef4b09ad27
--- /dev/null
+++ b/drivers/clocksource/timer-rtl8186.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Realtek RTL8186 SoC timer driver.
+ *
+ * Timer0 (24bit): Unused
+ * Timer1 (24bit): Unused
+ * Timer2 (32bit): Used as clocksource
+ * Timer3 (32bit): Used as clock event device
+ *
+ * Copyright (C) 2018 Yasha Cherikovsky
+ */
+
+#include <linux/init.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/sched_clock.h>
+#include <linux/of_clk.h>
+#include <linux/io.h>
+
+#include <asm/time.h>
+#include <asm/idle.h>
+
+#include "timer-of.h"
+
+/* Timer registers */
+#define TCCNR			0x0
+#define TCIR			0x4
+#define TC_DATA(t)		(0x10 + 4 * (t))
+#define TC_CNT(t)		(0x20 + 4 * (t))
+
+/* TCCNR register bits */
+#define TCCNR_TC_EN_BIT(t)		BIT((t) * 2)
+#define TCCNR_TC_MODE_BIT(t)		BIT((t) * 2 + 1)
+#define TCCNR_TC_SRC_BIT(t)		BIT((t) + 8)
+
+/* TCIR register bits */
+#define TCIR_TC_IE_BIT(t)		BIT(t)
+#define TCIR_TC_IP_BIT(t)		BIT((t) + 4)
+
+
+/* Forward declaration */
+static struct timer_of to;
+
+static void __iomem *base;
+
+
+#define RTL8186_TIMER_MODE_COUNTER	0
+#define RTL8186_TIMER_MODE_TIMER	1
+
+static void rtl8186_set_enable_bit(int timer, int enabled)
+{
+	u16 tccnr;
+
+	tccnr = readl(base + TCCNR);
+	tccnr &= ~(TCCNR_TC_EN_BIT(timer));
+
+	if (enabled)
+		tccnr |= TCCNR_TC_EN_BIT(timer);
+
+	writel(tccnr, base + TCCNR);
+}
+
+static void rtl8186_set_mode_bit(int timer, int mode)
+{
+	u16 tccnr;
+
+	tccnr = readl(base + TCCNR);
+	tccnr &= ~(TCCNR_TC_MODE_BIT(timer));
+
+	if (mode)
+		tccnr |= TCCNR_TC_MODE_BIT(timer);
+
+	writel(tccnr, base + TCCNR);
+}
+
+
+static irqreturn_t rtl8186_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *cd = dev_id;
+	int status;
+
+	status = readl(base + TCIR);
+	writel(status, base + TCIR); /* Clear all interrupts */
+
+	cd->event_handler(cd);
+
+	return IRQ_HANDLED;
+}
+
+static int rtl8186_clockevent_set_next(unsigned long evt,
+				       struct clock_event_device *cd)
+{
+	rtl8186_set_enable_bit(3, 0);
+	writel(evt, base + TC_DATA(3));
+	writel(evt, base + TC_CNT(3));
+	rtl8186_set_enable_bit(3, 1);
+	return 0;
+}
+
+static int rtl8186_set_state_periodic(struct clock_event_device *cd)
+{
+	unsigned long period = timer_of_period(to_timer_of(cd));
+
+	rtl8186_set_enable_bit(3, 0);
+	rtl8186_set_mode_bit(3, RTL8186_TIMER_MODE_TIMER);
+
+	/* This timer should reach zero each jiffy */
+	writel(period, base + TC_DATA(3));
+	writel(period, base + TC_CNT(3));
+
+	rtl8186_set_enable_bit(3, 1);
+	return 0;
+}
+
+static int rtl8186_set_state_oneshot(struct clock_event_device *cd)
+{
+	rtl8186_set_enable_bit(3, 0);
+	rtl8186_set_mode_bit(3, RTL8186_TIMER_MODE_COUNTER);
+	return 0;
+}
+
+static int rtl8186_set_state_shutdown(struct clock_event_device *cd)
+{
+	rtl8186_set_enable_bit(3, 0);
+	return 0;
+}
+
+static void rtl8186_timer_init_hw(void)
+{
+	/* Disable all timers */
+	writel(0, base + TCCNR);
+
+	/* Clear and disable all timer interrupts */
+	writel(0xf0, base + TCIR);
+
+	/* Reset all timers timeouts */
+	writel(0, base + TC_DATA(0));
+	writel(0, base + TC_DATA(1));
+	writel(0, base + TC_DATA(2));
+	writel(0, base + TC_DATA(3));
+
+	/* Reset all counters */
+	writel(0, base + TC_CNT(0));
+	writel(0, base + TC_CNT(1));
+	writel(0, base + TC_CNT(2));
+	writel(0, base + TC_CNT(3));
+}
+
+static u64 notrace rtl8186_timer_sched_read(void)
+{
+	return ~readl(base + TC_CNT(2));
+}
+
+static int rtl8186_start_clksrc(void)
+{
+	/* We use Timer2 as a clocksource (monotonic counter). */
+	writel(0xFFFFFFFF, base + TC_DATA(2));
+	writel(0xFFFFFFFF, base + TC_CNT(2));
+
+	rtl8186_set_mode_bit(2, RTL8186_TIMER_MODE_TIMER);
+	rtl8186_set_enable_bit(2, 1);
+
+	sched_clock_register(rtl8186_timer_sched_read, 32, timer_of_rate(&to));
+
+	return clocksource_mmio_init(base + TC_CNT(2), "rtl8186-clksrc",
+				     timer_of_rate(&to), 500, 32,
+				     clocksource_mmio_readl_down);
+}
+
+static struct timer_of to = {
+	.flags = TIMER_OF_BASE | TIMER_OF_CLOCK | TIMER_OF_IRQ,
+
+	.clkevt = {
+			.name = "rtl8186_tick",
+			.rating = 200,
+			.features = CLOCK_EVT_FEAT_ONESHOT |
+				    CLOCK_EVT_FEAT_PERIODIC,
+			.set_next_event = rtl8186_clockevent_set_next,
+			.cpumask = cpu_possible_mask,
+			.set_state_periodic = rtl8186_set_state_periodic,
+			.set_state_oneshot = rtl8186_set_state_oneshot,
+			.set_state_shutdown = rtl8186_set_state_shutdown,
+	},
+
+	.of_irq = {
+			.handler = rtl8186_timer_interrupt,
+			.flags = IRQF_TIMER,
+	},
+};
+
+static int __init rtl8186_timer_init(struct device_node *node)
+{
+	int ret;
+
+	ret = timer_of_init(node, &to);
+	if (ret)
+		return ret;
+
+	base = timer_of_base(&to);
+
+	rtl8186_timer_init_hw();
+
+	ret = rtl8186_start_clksrc();
+	if (ret) {
+		pr_err("Failed to register clocksource\n");
+		return ret;
+	}
+
+	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to), 100,
+					0xffffffff);
+
+	/* Enable interrupts for Timer3. Disable interrupts for others */
+	writel(TCIR_TC_IE_BIT(3), base + TCIR);
+
+	return 0;
+}
+
+TIMER_OF_DECLARE(rtl8186_timer, "realtek,rtl8186-timer", rtl8186_timer_init);
-- 
2.19.0
