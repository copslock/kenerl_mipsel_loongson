Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jan 2015 16:07:11 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6453 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009890AbbAHPHKDXgBr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jan 2015 16:07:10 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 285686C66FAEB;
        Thu,  8 Jan 2015 15:07:00 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 8 Jan 2015 15:07:03 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 8 Jan 2015 15:07:02 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        "Thomas Gleixner" <tglx@linutronix.de>
Subject: [PATCH] MIPS: cevt-r4k: Use Cause.TI for timer pending
Date:   Thu, 8 Jan 2015 15:06:39 +0000
Message-ID: <1420729599-22034-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

The cevt-r4k driver used to call into the GIC driver to find whether the
timer was pending, but only with External Interrupt Controller (EIC)
mode, where the Cause.IP bits can't be used as they encode the interrupt
priority level (Cause.RIPL) instead.

However commit e9de688dac65 ("irqchip: mips-gic: Support local
interrupts") changed the condition from cpu_has_veic to gic_present.
This fails on cores such as P5600 which have a GIC but the local
interrupts aren't routable by the GIC, causing c0_compare_int_usable()
to consider the interrupt unusable so r4k_clockevent_init() fails.

The previous behaviour wasn't really correct either though since P5600
apparently supports EIC mode too, so lets use the Cause.TI bit instead
which should be present since release 2 of the MIPS32/MIPS64
architecture. In fact multiple interrupts can be routed to that same CPU
interrupt line (e.g. performance counter and fast debug channel
interrupts), so lets use Cause.TI in preference to Cause.IP on all cores
since release 2.

Fixes: e9de688dac65 ("irqchip: mips-gic: Support local interrupts")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Andrew Bresticker <abrestic@chromium.org>
Cc: Qais Yousef <qais.yousef@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/cevt-r4k.c      | 20 +++++++++++++++-----
 drivers/irqchip/irq-mips-gic.c   |  8 --------
 include/linux/irqchip/mips-gic.h |  1 -
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 6acaad0480af..6747a2cbf662 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -11,7 +11,6 @@
 #include <linux/percpu.h>
 #include <linux/smp.h>
 #include <linux/irq.h>
-#include <linux/irqchip/mips-gic.h>
 
 #include <asm/time.h>
 #include <asm/cevt-r4k.h>
@@ -85,10 +84,21 @@ void mips_event_handler(struct clock_event_device *dev)
  */
 static int c0_compare_int_pending(void)
 {
-#ifdef CONFIG_MIPS_GIC
-	if (gic_present)
-		return gic_get_timer_pending();
-#endif
+	/*
+	 * With External Interrupt Controller (EIC) mode (which may be present
+	 * since release 2 of MIPS32/MIPS64) the interrupt pending bits
+	 * (Cause.IP) are used for the interrupt priority level (Cause.RIPL) so
+	 * we can't use it to determine whether the timer interrupt is pending.
+	 *
+	 * Instead lets use the timer pending bit (Cause.TI) which is present
+	 * since release 2, and lets use it even without EIC mode since it
+	 * unambigously specifies whether the timer interrupt is pending
+	 * regardless of what other internal or external interrupts are wired to
+	 * the same CPU IRQ line.
+	 */
+	if (cpu_has_mips_r2)
+		return read_c0_cause() & CAUSEF_TI;
+
 	return (read_c0_cause() >> cp0_compare_irq_shift) & (1ul << CAUSEB_IP);
 }
 
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 2b0468e3df6a..e58600b1de28 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -191,14 +191,6 @@ static bool gic_local_irq_is_routable(int intr)
 	}
 }
 
-unsigned int gic_get_timer_pending(void)
-{
-	unsigned int vpe_pending;
-
-	vpe_pending = gic_read(GIC_REG(VPE_LOCAL, GIC_VPE_PEND));
-	return vpe_pending & GIC_VPE_PEND_TIMER_MSK;
-}
-
 static void gic_bind_eic_interrupt(int irq, int set)
 {
 	/* Convert irq vector # to hw int # */
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index 420f77b34d02..e6a6aac451db 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -243,7 +243,6 @@ extern void gic_write_cpu_compare(cycle_t cnt, int cpu);
 extern void gic_send_ipi(unsigned int intr);
 extern unsigned int plat_ipi_call_int_xlate(unsigned int);
 extern unsigned int plat_ipi_resched_int_xlate(unsigned int);
-extern unsigned int gic_get_timer_pending(void);
 extern int gic_get_c0_compare_int(void);
 extern int gic_get_c0_perfcount_int(void);
 #endif /* __LINUX_IRQCHIP_MIPS_GIC_H */
-- 
2.0.5
