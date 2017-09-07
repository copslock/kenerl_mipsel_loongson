Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Sep 2017 01:29:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27003 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994806AbdIGX1gbW65k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Sep 2017 01:27:36 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id C933E91DCA102;
        Fri,  8 Sep 2017 00:27:24 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 8 Sep 2017 00:27:29
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
Subject: [RFC PATCH v1 5/9] MIPS: Remove perf_irq
Date:   Thu, 7 Sep 2017 16:25:38 -0700
Message-ID: <20170907232542.20589-6-paul.burton@imgtec.com>
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
X-archive-position: 59959
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

Remove the perf_irq function pointer which we no longer use. The
cevt-r4k clock event driver no longer needs to call it, which simplifies
c0_compare_interrupt(), and we drop its definition & declarations.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/time.h |  1 -
 arch/mips/kernel/cevt-r4k.c  | 48 +++++++++-----------------------------------
 arch/mips/kernel/time.c      |  9 ---------
 arch/mips/oprofile/op_impl.h |  2 --
 4 files changed, 10 insertions(+), 50 deletions(-)

diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index 17d4cd20f18c..7a21792826a6 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -45,7 +45,6 @@ extern unsigned int mips_hpt_frequency;
  * The performance counter IRQ on MIPS is a close relative to the timer IRQ
  * so it lives here.
  */
-extern int (*perf_irq)(void);
 extern int __weak get_c0_perfcount_int(void);
 
 /*
diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index dd6a18bc10ab..893aa32759d9 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -108,54 +108,26 @@ static unsigned int calculate_min_delta(void)
 DEFINE_PER_CPU(struct clock_event_device, mips_clockevent_device);
 int cp0_timer_irq_installed;
 
-/*
- * Possibly handle a performance counter interrupt.
- * Return true if the timer interrupt should not be checked
- */
-static inline int handle_perf_irq(int r2)
-{
-	/*
-	 * The performance counter overflow interrupt may be shared with the
-	 * timer interrupt (cp0_perfcount_irq < 0). If it is and a
-	 * performance counter has overflowed (perf_irq() == IRQ_HANDLED)
-	 * and we can't reliably determine if a counter interrupt has also
-	 * happened (!r2) then don't check for a timer interrupt.
-	 */
-	return (cp0_perfcount_irq < 0) &&
-		perf_irq() == IRQ_HANDLED &&
-		!r2;
-}
-
 irqreturn_t c0_compare_interrupt(int irq, void *dev_id)
 {
-	const int r2 = cpu_has_mips_r2_r6;
 	struct clock_event_device *cd;
 	int cpu = smp_processor_id();
 
 	/*
-	 * Suckage alert:
-	 * Before R2 of the architecture there was no way to see if a
-	 * performance counter interrupt was pending, so we have to run
-	 * the performance counter interrupt handler anyway.
+	 * If we have the Cause.TI bit with which to decode whether this was in
+	 * fact a timer interrupt, rather than another which shares the CPU
+	 * pin, then check that & return if no timer interrupt is pending.
 	 */
-	if (handle_perf_irq(r2))
-		return IRQ_HANDLED;
+	if (cpu_has_mips_r2_r6 && !(read_c0_cause() & CAUSEF_TI))
+		return IRQ_NONE;
 
-	/*
-	 * The same applies to performance counter interrupts.	But with the
-	 * above we now know that the reason we got here must be a timer
-	 * interrupt.  Being the paranoiacs we are we check anyway.
-	 */
-	if (!r2 || (read_c0_cause() & CAUSEF_TI)) {
-		/* Clear Count/Compare Interrupt */
-		write_c0_compare(read_c0_compare());
-		cd = &per_cpu(mips_clockevent_device, cpu);
-		cd->event_handler(cd);
+	/* Clear Count/Compare Interrupt */
+	write_c0_compare(read_c0_compare());
 
-		return IRQ_HANDLED;
-	}
+	cd = &per_cpu(mips_clockevent_device, cpu);
+	cd->event_handler(cd);
 
-	return IRQ_NONE;
+	return IRQ_HANDLED;
 }
 
 struct irqaction c0_compare_irqaction = {
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index a6ebc8135112..1090d1c11afa 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -49,15 +49,6 @@ int update_persistent_clock(struct timespec now)
 	return rtc_mips_set_mmss(now.tv_sec);
 }
 
-static int null_perf_irq(void)
-{
-	return 0;
-}
-
-int (*perf_irq)(void) = null_perf_irq;
-
-EXPORT_SYMBOL(perf_irq);
-
 /*
  * time_init() - it does the following things.
  *
diff --git a/arch/mips/oprofile/op_impl.h b/arch/mips/oprofile/op_impl.h
index a4e758a39af4..9b0b295bdaf1 100644
--- a/arch/mips/oprofile/op_impl.h
+++ b/arch/mips/oprofile/op_impl.h
@@ -10,8 +10,6 @@
 #ifndef OP_IMPL_H
 #define OP_IMPL_H 1
 
-extern int (*perf_irq)(void);
-
 /* Per-counter configuration as set via oprofilefs.  */
 struct op_counter_config {
 	unsigned long enabled;
-- 
2.14.1
