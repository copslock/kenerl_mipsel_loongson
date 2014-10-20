Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 21:09:06 +0200 (CEST)
Received: from mail-qg0-f73.google.com ([209.85.192.73]:64945 "EHLO
        mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011962AbaJTTEWAlUsl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 21:04:22 +0200
Received: by mail-qg0-f73.google.com with SMTP id i50so472098qgf.0
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 12:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0qdAz0YWsySTya5cIhctdoIYVnTc0W+8EiYvDQpSewc=;
        b=HsqRBzQct48Sm1PR84B7BUKR0ea09nTthcIcYeb2vP5MWmUKsjVy3gN5t2z71HUyG9
         rgFDue8YT8+j9SlahvHmFmWkMPeOY4Xyg4aDbDGR7drSmb4ynAiBbW81mh8wITysJX9V
         enMXdHAlCSvaWc9rP8wn5S4fefwCS5a9eFXe5DFjtTnkRQUfquHuukHjtCzoaxsHszAC
         yQ0pmJDGLO4EibSoxnytKG0UDfMSoRjiD7ht6WntwaiqOdj9/wSF1HFWmY6OkGMsisje
         cXNhkme0DiR3cCsAY1do0E1ZktwBnI5GTzf0W7VE7IwfYctUIb/Yp/zkD8pKE1uONk3n
         sAJQ==
X-Gm-Message-State: ALoCoQmnLV6u/3I7wR8nKO0dLgbs10IWw11mqN+rNBd5nRabSIC0v5G2H6TrsMHWd7KB7Z8vOBDT
X-Received: by 10.224.56.9 with SMTP id w9mr19194564qag.5.1413831856319;
        Mon, 20 Oct 2014 12:04:16 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id s23si438204yhf.0.2014.10.20.12.04.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2014 12:04:16 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id SSPIjhGM.5; Mon, 20 Oct 2014 12:04:16 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 5555E220B02; Mon, 20 Oct 2014 12:04:15 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/19] clocksource: mips-gic: Use CPU notifiers to setup the timer
Date:   Mon, 20 Oct 2014 12:04:04 -0700
Message-Id: <1413831846-32100-18-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
References: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43376
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

Instead of requiring an explicit call to gic_clockevent_init in the SMP
startup path, use CPU notifiers to register and enable the GIC timer on
CPU startup.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/include/asm/time.h         |  5 +--
 drivers/clocksource/mips-gic-timer.c | 60 ++++++++++++++++++++++++++----------
 2 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index 5f30aab..8ab2874 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -53,13 +53,10 @@ extern int __weak get_c0_perfcount_int(void);
  */
 extern unsigned int __weak get_c0_compare_int(void);
 extern int r4k_clockevent_init(void);
-extern int gic_clockevent_init(void);
 
 static inline int mips_clockevent_init(void)
 {
-#if   defined(CONFIG_CLKSRC_MIPS_GIC)
-	return (gic_clockevent_init() | r4k_clockevent_init());
-#elif defined(CONFIG_CEVT_R4K)
+#ifdef CONFIG_CEVT_R4K
 	return r4k_clockevent_init();
 #else
 	return -ENXIO;
diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 05bdfe1..3ce992b 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -6,9 +6,11 @@
  * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
 #include <linux/clockchips.h>
+#include <linux/cpu.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irqchip/mips-gic.h>
+#include <linux/notifier.h>
 #include <linux/percpu.h>
 #include <linux/smp.h>
 #include <linux/time.h>
@@ -16,7 +18,7 @@
 #include <asm/time.h>
 
 static DEFINE_PER_CPU(struct clock_event_device, gic_clockevent_device);
-static int gic_timer_irq_installed;
+static int gic_timer_irq;
 static unsigned int gic_frequency;
 
 static int gic_next_event(unsigned long delta, struct clock_event_device *evt)
@@ -53,18 +55,9 @@ struct irqaction gic_compare_irqaction = {
 	.name = "timer",
 };
 
-int gic_clockevent_init(void)
+static void gic_clockevent_cpu_init(struct clock_event_device *cd)
 {
 	unsigned int cpu = smp_processor_id();
-	struct clock_event_device *cd;
-	unsigned int irq;
-
-	if (!cpu_has_counter || !gic_frequency)
-		return -ENXIO;
-
-	irq = MIPS_GIC_IRQ_BASE + GIC_LOCAL_TO_HWIRQ(GIC_LOCAL_INT_COMPARE);
-
-	cd = &per_cpu(gic_clockevent_device, cpu);
 
 	cd->name		= "MIPS GIC";
 	cd->features		= CLOCK_EVT_FEAT_ONESHOT |
@@ -77,19 +70,52 @@ int gic_clockevent_init(void)
 	cd->min_delta_ns	= clockevent_delta2ns(0x300, cd);
 
 	cd->rating		= 300;
-	cd->irq			= irq;
+	cd->irq			= gic_timer_irq;
 	cd->cpumask		= cpumask_of(cpu);
 	cd->set_next_event	= gic_next_event;
 	cd->set_mode		= gic_set_clock_mode;
 
 	clockevents_register_device(cd);
 
-	if (!gic_timer_irq_installed) {
-		setup_percpu_irq(irq, &gic_compare_irqaction);
-		gic_timer_irq_installed = 1;
+	enable_percpu_irq(gic_timer_irq, IRQ_TYPE_NONE);
+}
+
+static void gic_clockevent_cpu_exit(struct clock_event_device *cd)
+{
+	disable_percpu_irq(gic_timer_irq);
+}
+
+static int gic_cpu_notifier(struct notifier_block *nb, unsigned long action,
+				void *data)
+{
+	switch (action & ~CPU_TASKS_FROZEN) {
+	case CPU_STARTING:
+		gic_clockevent_cpu_init(this_cpu_ptr(&gic_clockevent_device));
+		break;
+	case CPU_DYING:
+		gic_clockevent_cpu_exit(this_cpu_ptr(&gic_clockevent_device));
+		break;
 	}
 
-	enable_percpu_irq(irq, IRQ_TYPE_NONE);
+	return NOTIFY_OK;
+}
+
+static struct notifier_block gic_cpu_nb = {
+	.notifier_call = gic_cpu_notifier,
+};
+
+static int gic_clockevent_init(void)
+{
+	if (!cpu_has_counter || !gic_frequency)
+		return -ENXIO;
+
+	gic_timer_irq = MIPS_GIC_IRQ_BASE +
+		GIC_LOCAL_TO_HWIRQ(GIC_LOCAL_INT_COMPARE);
+	setup_percpu_irq(gic_timer_irq, &gic_compare_irqaction);
+
+	register_cpu_notifier(&gic_cpu_nb);
+
+	gic_clockevent_cpu_init(this_cpu_ptr(&gic_clockevent_device));
 
 	return 0;
 }
@@ -116,4 +142,6 @@ void __init gic_clocksource_init(unsigned int frequency)
 	gic_clocksource.rating = 200 + frequency / 10000000;
 
 	clocksource_register_hz(&gic_clocksource, frequency);
+
+	gic_clockevent_init();
 }
-- 
2.1.0.rc2.206.gedb03e5
