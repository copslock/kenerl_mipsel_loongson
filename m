Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 21:07:05 +0200 (CEST)
Received: from mail-vc0-f201.google.com ([209.85.220.201]:54505 "EHLO
        mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011982AbaJTTET1Ozmo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 21:04:19 +0200
Received: by mail-vc0-f201.google.com with SMTP id hq11so473918vcb.0
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 12:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qrcLI8ERZkWRoSDtExbzxH46Z1BRHYchXBb9VGA11bQ=;
        b=cMCINY6WhV4Fp0ZaD2Chsv2UnTubaHBr7VTGfZo03EuArpZNzOY0GQOCXbdaV6Dtqj
         xAmwSP47NfJ+bn3p4s3w4BKDlvbBKGWEH7yAfHkYsrsPaQLvwBpirnTObhCkOuhLE+/L
         8nxRtgIaZV/KWQQU8fGDrf3z4i3PRmc531XnZSy1rnUDIq30Ea2qktYfN7bxY8MbJgYW
         wLGuAZvjJNqW6LcTK3AzaNzKEmj1FRihDbpMPRC25Jrs4WIkiD/Bauw6smytWBuawfa3
         o8SEnjvs05Gq1ENOqlsyI6Hz8Xrarz4TfWFLXjypQojcY8Igx6zR3+jUy5xLSXRuuFlz
         0h0A==
X-Gm-Message-State: ALoCoQkUaK1gyuxR434xKW5wW2GVj1AqXMFQV5Dg2xny+yvl+vqmPt+TSZC7c2QdQLVXh+404DTY
X-Received: by 10.236.63.41 with SMTP id z29mr19243231yhc.15.1413831853718;
        Mon, 20 Oct 2014 12:04:13 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n24si435320yha.6.2014.10.20.12.04.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2014 12:04:13 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id ezN2XdvX.4; Mon, 20 Oct 2014 12:04:13 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id BA02D220B02; Mon, 20 Oct 2014 12:04:12 -0700 (PDT)
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
Subject: [PATCH 12/19] clocksource: mips-gic: Combine with GIC clockevent driver
Date:   Mon, 20 Oct 2014 12:03:59 -0700
Message-Id: <1413831846-32100-13-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
References: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43369
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

Combine the GIC clocksource driver with the GIC clockevent driver from
arch/mips/kernel/cevt-gic.c and remove the clockevent driver's separate
Kconfig symbol.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/Kconfig                    |  13 -----
 arch/mips/include/asm/time.h         |   2 +-
 arch/mips/kernel/Makefile            |   1 -
 arch/mips/kernel/cevt-gic.c          | 103 -----------------------------------
 drivers/clocksource/mips-gic-timer.c |  90 ++++++++++++++++++++++++++++++
 drivers/irqchip/irq-mips-gic.c       |   2 +-
 6 files changed, 92 insertions(+), 119 deletions(-)
 delete mode 100644 arch/mips/kernel/cevt-gic.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5b1d44b..88ef7f4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -907,10 +907,6 @@ config CEVT_GT641XX
 config CEVT_R4K
 	bool
 
-config CEVT_GIC
-	select MIPS_CM
-	bool
-
 config CEVT_SB1250
 	bool
 
@@ -1880,15 +1876,6 @@ config FORCE_MAX_ZONEORDER
 	  The page size is not necessarily 4KB.  Keep this in mind
 	  when choosing a value for this option.
 
-config CEVT_GIC
-	bool "Use GIC global counter for clock events"
-	depends on MIPS_GIC && !MIPS_SEAD3
-	help
-	  Use the GIC global counter for the clock events. The R4K clock
-	  event driver is always present, so if the platform ends up not
-	  detecting a GIC, it will fall back to the R4K timer for the
-	  generation of clock events.
-
 config BOARD_SCACHE
 	bool
 
diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index 7969933..5f30aab 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -57,7 +57,7 @@ extern int gic_clockevent_init(void);
 
 static inline int mips_clockevent_init(void)
 {
-#if   defined(CONFIG_CEVT_GIC)
+#if   defined(CONFIG_CLKSRC_MIPS_GIC)
 	return (gic_clockevent_init() | r4k_clockevent_init());
 #elif defined(CONFIG_CEVT_R4K)
 	return r4k_clockevent_init();
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 3d1ea51..e64fe1d 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -18,7 +18,6 @@ endif
 obj-$(CONFIG_CEVT_BCM1480)	+= cevt-bcm1480.o
 obj-$(CONFIG_CEVT_R4K)		+= cevt-r4k.o
 obj-$(CONFIG_CEVT_DS1287)	+= cevt-ds1287.o
-obj-$(CONFIG_CEVT_GIC)		+= cevt-gic.o
 obj-$(CONFIG_CEVT_GT641XX)	+= cevt-gt641xx.o
 obj-$(CONFIG_CEVT_SB1250)	+= cevt-sb1250.o
 obj-$(CONFIG_CEVT_TXX9)		+= cevt-txx9.o
diff --git a/arch/mips/kernel/cevt-gic.c b/arch/mips/kernel/cevt-gic.c
deleted file mode 100644
index 9caa68a..0000000
--- a/arch/mips/kernel/cevt-gic.c
+++ /dev/null
@@ -1,103 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2013  Imagination Technologies Ltd.
- */
-#include <linux/clockchips.h>
-#include <linux/interrupt.h>
-#include <linux/percpu.h>
-#include <linux/smp.h>
-#include <linux/irq.h>
-#include <linux/irqchip/mips-gic.h>
-
-#include <asm/time.h>
-#include <asm/mips-boards/maltaint.h>
-
-DEFINE_PER_CPU(struct clock_event_device, gic_clockevent_device);
-int gic_timer_irq_installed;
-
-
-static int gic_next_event(unsigned long delta, struct clock_event_device *evt)
-{
-	u64 cnt;
-	int res;
-
-	cnt = gic_read_count();
-	cnt += (u64)delta;
-	gic_write_cpu_compare(cnt, cpumask_first(evt->cpumask));
-	res = ((int)(gic_read_count() - cnt) >= 0) ? -ETIME : 0;
-	return res;
-}
-
-void gic_set_clock_mode(enum clock_event_mode mode,
-				struct clock_event_device *evt)
-{
-	/* Nothing to do ...  */
-}
-
-irqreturn_t gic_compare_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *cd;
-	int cpu = smp_processor_id();
-
-	gic_write_compare(gic_read_compare());
-	cd = &per_cpu(gic_clockevent_device, cpu);
-	cd->event_handler(cd);
-	return IRQ_HANDLED;
-}
-
-struct irqaction gic_compare_irqaction = {
-	.handler = gic_compare_interrupt,
-	.flags = IRQF_PERCPU | IRQF_TIMER,
-	.name = "timer",
-};
-
-
-void gic_event_handler(struct clock_event_device *dev)
-{
-}
-
-int gic_clockevent_init(void)
-{
-	unsigned int cpu = smp_processor_id();
-	struct clock_event_device *cd;
-	unsigned int irq;
-
-	if (!cpu_has_counter || !gic_frequency)
-		return -ENXIO;
-
-	irq = MIPS_GIC_IRQ_BASE + GIC_LOCAL_TO_HWIRQ(GIC_LOCAL_INT_COMPARE);
-
-	cd = &per_cpu(gic_clockevent_device, cpu);
-
-	cd->name		= "MIPS GIC";
-	cd->features		= CLOCK_EVT_FEAT_ONESHOT |
-				  CLOCK_EVT_FEAT_C3STOP;
-
-	clockevent_set_clock(cd, gic_frequency);
-
-	/* Calculate the min / max delta */
-	cd->max_delta_ns	= clockevent_delta2ns(0x7fffffff, cd);
-	cd->min_delta_ns	= clockevent_delta2ns(0x300, cd);
-
-	cd->rating		= 300;
-	cd->irq			= irq;
-	cd->cpumask		= cpumask_of(cpu);
-	cd->set_next_event	= gic_next_event;
-	cd->set_mode		= gic_set_clock_mode;
-	cd->event_handler	= gic_event_handler;
-
-	clockevents_register_device(cd);
-
-	if (!gic_timer_irq_installed) {
-		setup_percpu_irq(irq, &gic_compare_irqaction);
-		gic_timer_irq_installed = 1;
-	}
-
-	enable_percpu_irq(irq, IRQ_TYPE_NONE);
-
-
-	return 0;
-}
diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 0bf28e6..3cf5912 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -5,10 +5,100 @@
  *
  * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
+#include <linux/clockchips.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/irqchip/mips-gic.h>
+#include <linux/percpu.h>
+#include <linux/smp.h>
 #include <linux/time.h>
 
+#include <asm/time.h>
+
+DEFINE_PER_CPU(struct clock_event_device, gic_clockevent_device);
+int gic_timer_irq_installed;
+
+static int gic_next_event(unsigned long delta, struct clock_event_device *evt)
+{
+	u64 cnt;
+	int res;
+
+	cnt = gic_read_count();
+	cnt += (u64)delta;
+	gic_write_cpu_compare(cnt, cpumask_first(evt->cpumask));
+	res = ((int)(gic_read_count() - cnt) >= 0) ? -ETIME : 0;
+	return res;
+}
+
+void gic_set_clock_mode(enum clock_event_mode mode,
+				struct clock_event_device *evt)
+{
+	/* Nothing to do ...  */
+}
+
+irqreturn_t gic_compare_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *cd;
+	int cpu = smp_processor_id();
+
+	gic_write_compare(gic_read_compare());
+	cd = &per_cpu(gic_clockevent_device, cpu);
+	cd->event_handler(cd);
+	return IRQ_HANDLED;
+}
+
+struct irqaction gic_compare_irqaction = {
+	.handler = gic_compare_interrupt,
+	.flags = IRQF_PERCPU | IRQF_TIMER,
+	.name = "timer",
+};
+
+void gic_event_handler(struct clock_event_device *dev)
+{
+}
+
+int gic_clockevent_init(void)
+{
+	unsigned int cpu = smp_processor_id();
+	struct clock_event_device *cd;
+	unsigned int irq;
+
+	if (!cpu_has_counter || !gic_frequency)
+		return -ENXIO;
+
+	irq = MIPS_GIC_IRQ_BASE + GIC_LOCAL_TO_HWIRQ(GIC_LOCAL_INT_COMPARE);
+
+	cd = &per_cpu(gic_clockevent_device, cpu);
+
+	cd->name		= "MIPS GIC";
+	cd->features		= CLOCK_EVT_FEAT_ONESHOT |
+				  CLOCK_EVT_FEAT_C3STOP;
+
+	clockevent_set_clock(cd, gic_frequency);
+
+	/* Calculate the min / max delta */
+	cd->max_delta_ns	= clockevent_delta2ns(0x7fffffff, cd);
+	cd->min_delta_ns	= clockevent_delta2ns(0x300, cd);
+
+	cd->rating		= 300;
+	cd->irq			= irq;
+	cd->cpumask		= cpumask_of(cpu);
+	cd->set_next_event	= gic_next_event;
+	cd->set_mode		= gic_set_clock_mode;
+	cd->event_handler	= gic_event_handler;
+
+	clockevents_register_device(cd);
+
+	if (!gic_timer_irq_installed) {
+		setup_percpu_irq(irq, &gic_compare_irqaction);
+		gic_timer_irq_installed = 1;
+	}
+
+	enable_percpu_irq(irq, IRQ_TYPE_NONE);
+
+	return 0;
+}
+
 static cycle_t gic_hpt_read(struct clocksource *cs)
 {
 	return gic_read_count();
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 99687ed..5c856e6 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -103,7 +103,7 @@ static inline void gic_map_to_vpe(unsigned int intr, unsigned int vpe)
 		  GIC_SH_MAP_TO_VPE_REG_BIT(vpe));
 }
 
-#if defined(CONFIG_CLKSRC_MIPS_GIC) || defined(CONFIG_CEVT_GIC)
+#ifdef CONFIG_CLKSRC_MIPS_GIC
 cycle_t gic_read_count(void)
 {
 	unsigned int hi, hi2, lo;
-- 
2.1.0.rc2.206.gedb03e5
