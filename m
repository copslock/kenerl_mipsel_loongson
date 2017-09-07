Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Sep 2017 01:30:10 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44872 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994828AbdIGX2MuQLak (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Sep 2017 01:28:12 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 1A5F1AE11C7B9;
        Fri,  8 Sep 2017 00:28:00 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 8 Sep 2017 00:28:04
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <dianders@chromium.org>, James Hogan <james.hogan@imgtec.com>,
        Brian Norris <briannorris@chromium.org>,
        Jason Cooper <jason@lakedaemon.net>,
        <jeffy.chen@rock-chips.com>, Marc Zyngier <marc.zyngier@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <tfiga@chromium.org>, Paul Burton <paul.burton@imgtec.com>
Subject: [RFC PATCH v1 7/9] MIPS: cevt-r4k: percpu_devid interrupt support
Date:   Thu, 7 Sep 2017 16:25:40 -0700
Message-ID: <20170907232542.20589-8-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170907232542.20589-1-paul.burton@imgtec.com>
References: <1682867.tATABVWsV9@np-p-burton>
 <20170907232542.20589-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59961
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

The MIPS coprocessor 0 count/compare interrupt, used by the cevt-r4k
driver, is really a percpu interrupt but up until now we have not used
the percpu interrupt APIs to configure & control it. In preparation for
doing so, introduce support for percpu_devid interrupts in cevt-r4k.

We switch from using request_irq() to using either setup_irq() or
setup_percpu_irq() with an explicit struct irqaction such that we can
set the flags, handler & name for that struct irqaction once rather than
needing to duplicate them in calls to request_irq() and
request_percpu_irq().

The IRQF_NOAUTOEN flag is passed because percpu interrupts
automatically get IRQ_NOAUTOEN set by irq_set_percpu_devid_flags(). We
opt into accepting this behaviour & explicitly enable the interrupt in
r4k_clockevent_init() which is called on all CPUs during bringup.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
---

 arch/mips/kernel/cevt-r4k.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 893aa32759d9..0021fc1226f3 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -8,6 +8,7 @@
  */
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
+#include <linux/once.h>
 #include <linux/percpu.h>
 #include <linux/smp.h>
 #include <linux/irq.h>
@@ -106,7 +107,6 @@ static unsigned int calculate_min_delta(void)
 }
 
 DEFINE_PER_CPU(struct clock_event_device, mips_clockevent_device);
-int cp0_timer_irq_installed;
 
 irqreturn_t c0_compare_interrupt(int irq, void *dev_id)
 {
@@ -136,8 +136,9 @@ struct irqaction c0_compare_irqaction = {
 	 * IRQF_SHARED: The timer interrupt may be shared with other interrupts
 	 * such as perf counter and FDC interrupts.
 	 */
-	.flags = IRQF_PERCPU | IRQF_TIMER | IRQF_SHARED,
+	.flags = IRQF_PERCPU | IRQF_TIMER | IRQF_SHARED | IRQF_NOAUTOEN,
 	.name = "timer",
+	.percpu_dev_id = &mips_clockevent_device,
 };
 
 
@@ -222,11 +223,20 @@ unsigned int __weak get_c0_compare_int(void)
 	return MIPS_CPU_IRQ_BASE + cp0_compare_irq;
 }
 
+static void setup_c0_compare_int(int irq, int *err)
+{
+	if (irq_is_percpu_devid(irq))
+		*err = setup_percpu_irq(irq, &c0_compare_irqaction);
+	else
+		*err = setup_irq(irq, &c0_compare_irqaction);
+}
+
 int r4k_clockevent_init(void)
 {
 	unsigned int cpu = smp_processor_id();
 	struct clock_event_device *cd;
 	unsigned int irq, min_delta;
+	int err;
 
 	if (!cpu_has_counter || !mips_hpt_frequency)
 		return -ENXIO;
@@ -258,12 +268,17 @@ int r4k_clockevent_init(void)
 
 	clockevents_config_and_register(cd, mips_hpt_frequency, min_delta, 0x7fffffff);
 
-	if (cp0_timer_irq_installed)
-		return 0;
-
-	cp0_timer_irq_installed = 1;
+	err = 0;
+	DO_ONCE(setup_c0_compare_int, irq, &err);
+	if (err) {
+		pr_err("Unable to setup timer IRQ %d: %d\n", irq, err);
+		return err;
+	}
 
-	setup_irq(irq, &c0_compare_irqaction);
+	if (irq_is_percpu_devid(irq))
+		enable_percpu_irq(irq, IRQ_TYPE_NONE);
+	else
+		enable_irq(irq);
 
 	return 0;
 }
-- 
2.14.1
