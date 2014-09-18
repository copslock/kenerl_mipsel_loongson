Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2014 23:54:09 +0200 (CEST)
Received: from mail-oa0-f73.google.com ([209.85.219.73]:51151 "EHLO
        mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009265AbaIRVrxJbhRZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2014 23:47:53 +0200
Received: by mail-oa0-f73.google.com with SMTP id eb12so182046oac.4
        for <linux-mips@linux-mips.org>; Thu, 18 Sep 2014 14:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GsT8vrRIqbm4us8AworNPKTpKGdtXr0oOPcNUAhfC3Q=;
        b=DZvUtFXYMb7a4hqE/xs/tU5Leme16mGAIOHnTB8PLbMzZTC3Fv1Ej5dAswuHKyOGy5
         3r+J96TulUJc3o5AcAlQrtFZk/B4ZcJWlx4jjGZqfJGe5cNG6YzIQ+Ijqu3NoxJVtyjE
         nR8Ni7A3U66kH/Hej4QqWWTPJTH4Rbe2/3NKGZ0lzN/VteJVqOxWsvT0IOU289k25aTB
         8ovP/sfGPcnhfRby/fI912zzI7YG183qgAvt4uaG3QlNGoniXH/0Y2gEkX0Fs4VQC5oH
         kTA9XuOSN/JL9Ati5GLq4q89+Rjh9Nv/QeWljkHefr4jHbUwRuGpjsFmxlLMZjg64dUb
         /lNw==
X-Gm-Message-State: ALoCoQm2RdWyfoYAwO4ZylLWMVt6ykJg6r4prvB1CD9S8OZYeuM4raQfIFycTh+wi4Ok8uJzkNio
X-Received: by 10.182.110.130 with SMTP id ia2mr1236426obb.42.1411076867237;
        Thu, 18 Sep 2014 14:47:47 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id j25si5204yhb.0.2014.09.18.14.47.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2014 14:47:47 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id P0uuVMGs.6; Thu, 18 Sep 2014 14:47:47 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 11BE0220B91; Thu, 18 Sep 2014 14:47:46 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 21/24] irqchip: mips-gic: Support local interrupts
Date:   Thu, 18 Sep 2014 14:47:27 -0700
Message-Id: <1411076851-28242-22-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
References: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42701
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

The MIPS GIC supports 7 local interrupts, 2 of which are the GIC
local watchdog and count/compare timer.  The remainder are CPU
interrupts which may optionally be re-routed through the GIC.
GIC hardware IRQs 0-6 are now used for local interrupts while
hardware IRQs 7+ are used for external (shared) interrupts.

Note that the 5 CPU interrupts may not be re-routable through
the GIC.  In that case mapping will fail and the vectors reported
in C0_IntCtl should be used instead.  gic_get_c0_compare_int() and
gic_get_c0_perfcount_int() will return the correct IRQ number to
use for the C0 timer and perfcounter interrupts based on the
routability of those interrupts through the GIC.

A separate irq_chip, with callbacks that mask/unmask the local
interrupt on all CPUs, is used for the C0 timer and performance
counter interrupts since all other platforms do not use the percpu
IRQ API for those interrupts.

Malta, SEAD-3, and the GIC clockevent driver have been updated
to use local interrupts and the R4K clockevent driver has been
updated to poll for C0 timer interrupts through the GIC when
the GIC is present.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Acked-by: Jason Cooper <jason@lakedaemon.net>
Reviewed-by: Qais Yousef <qais.yousef@imgtec.com>
Tested-by: Qais Yousef <qais.yousef@imgtec.com>
---
Changes from v1:
 - allow SWINTs to be routable in non-EIC mode
 - use separate irq_chip for C0 timer/perf interrupts
 - mask all routable local interrupts initially
 - remove unnecessary irq_ack, irq_mask_ack, and irq_eoi callbacks
---
 arch/mips/include/asm/gic.h                  |  29 ++-
 arch/mips/include/asm/mips-boards/maltaint.h |   4 +-
 arch/mips/include/asm/mips-boards/sead3int.h |  10 +-
 arch/mips/kernel/cevt-gic.c                  |  15 +-
 arch/mips/kernel/cevt-r4k.c                  |   2 +-
 arch/mips/mti-malta/malta-int.c              |   6 +-
 arch/mips/mti-malta/malta-time.c             |  13 +-
 arch/mips/mti-sead3/sead3-time.c             |  34 +---
 drivers/irqchip/irq-mips-gic.c               | 291 ++++++++++++++++++++-------
 9 files changed, 279 insertions(+), 125 deletions(-)

diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index f245395..6b99610 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -209,6 +209,7 @@
 #define GIC_VPE_WD_MAP_OFS		0x0040
 #define GIC_VPE_COMPARE_MAP_OFS		0x0044
 #define GIC_VPE_TIMER_MAP_OFS		0x0048
+#define GIC_VPE_FDC_MAP_OFS		0x004c
 #define GIC_VPE_PERFCTR_MAP_OFS		0x0050
 #define GIC_VPE_SWINT0_MAP_OFS		0x0054
 #define GIC_VPE_SWINT1_MAP_OFS		0x0058
@@ -262,6 +263,10 @@
 #define GIC_MAP_MSK			(MSK(6) << GIC_MAP_SHF)
 
 /* GIC_VPE_CTL Masks */
+#define GIC_VPE_CTL_FDC_RTBL_SHF	4
+#define GIC_VPE_CTL_FDC_RTBL_MSK	(MSK(1) << GIC_VPE_CTL_FDC_RTBL_SHF)
+#define GIC_VPE_CTL_SWINT_RTBL_SHF	3
+#define GIC_VPE_CTL_SWINT_RTBL_MSK	(MSK(1) << GIC_VPE_CTL_SWINT_RTBL_SHF)
 #define GIC_VPE_CTL_PERFCNT_RTBL_SHF	2
 #define GIC_VPE_CTL_PERFCNT_RTBL_MSK	(MSK(1) << GIC_VPE_CTL_PERFCNT_RTBL_SHF)
 #define GIC_VPE_CTL_TIMER_RTBL_SHF	1
@@ -329,16 +334,30 @@
 /* Add 2 to convert GIC CPU pin to core interrupt */
 #define GIC_CPU_PIN_OFFSET	2
 
-/* Local GIC interrupts. */
-#define GIC_INT_TMR		(GIC_CPU_INT5)
-#define GIC_INT_PERFCTR		(GIC_CPU_INT5)
-
 /* Add 2 to convert non-EIC hardware interrupt to EIC vector number. */
 #define GIC_CPU_TO_VEC_OFFSET	(2)
 
 /* Mapped interrupt to pin X, then GIC will generate the vector (X+1). */
 #define GIC_PIN_TO_VEC_OFFSET	(1)
 
+/* Local GIC interrupts. */
+#define GIC_LOCAL_INT_WD	0 /* GIC watchdog */
+#define GIC_LOCAL_INT_COMPARE	1 /* GIC count and compare timer */
+#define GIC_LOCAL_INT_TIMER	2 /* CPU timer interrupt */
+#define GIC_LOCAL_INT_PERFCTR	3 /* CPU performance counter */
+#define GIC_LOCAL_INT_SWINT0	4 /* CPU software interrupt 0 */
+#define GIC_LOCAL_INT_SWINT1	5 /* CPU software interrupt 1 */
+#define GIC_LOCAL_INT_FDC	6 /* CPU fast debug channel */
+#define GIC_NUM_LOCAL_INTRS	7
+
+/* Convert between local/shared IRQ number and GIC HW IRQ number. */
+#define GIC_LOCAL_HWIRQ_BASE	0
+#define GIC_LOCAL_TO_HWIRQ(x)	(GIC_LOCAL_HWIRQ_BASE + (x))
+#define GIC_HWIRQ_TO_LOCAL(x)	((x) - GIC_LOCAL_HWIRQ_BASE)
+#define GIC_SHARED_HWIRQ_BASE	GIC_NUM_LOCAL_INTRS
+#define GIC_SHARED_TO_HWIRQ(x)	(GIC_SHARED_HWIRQ_BASE + (x))
+#define GIC_HWIRQ_TO_SHARED(x)	((x) - GIC_SHARED_HWIRQ_BASE)
+
 #include <linux/clocksource.h>
 #include <linux/irq.h>
 
@@ -363,4 +382,6 @@ extern void gic_bind_eic_interrupt(int irq, int set);
 extern unsigned int gic_get_timer_pending(void);
 extern void gic_get_int_mask(unsigned long *dst, const unsigned long *src);
 extern unsigned int gic_get_int(void);
+extern int gic_get_c0_compare_int(void);
+extern int gic_get_c0_perfcount_int(void);
 #endif /* _ASM_GICREGS_H */
diff --git a/arch/mips/include/asm/mips-boards/maltaint.h b/arch/mips/include/asm/mips-boards/maltaint.h
index bdd6f39..38b06a0 100644
--- a/arch/mips/include/asm/mips-boards/maltaint.h
+++ b/arch/mips/include/asm/mips-boards/maltaint.h
@@ -10,6 +10,8 @@
 #ifndef _MIPS_MALTAINT_H
 #define _MIPS_MALTAINT_H
 
+#include <asm/gic.h>
+
 /*
  * Interrupts 0..15 are used for Malta ISA compatible interrupts
  */
@@ -61,6 +63,6 @@
 #define MSC01E_INT_CPUCTR	11
 
 /* GIC external interrupts */
-#define GIC_INT_I8259A		3
+#define GIC_INT_I8259A		GIC_SHARED_TO_HWIRQ(3)
 
 #endif /* !(_MIPS_MALTAINT_H) */
diff --git a/arch/mips/include/asm/mips-boards/sead3int.h b/arch/mips/include/asm/mips-boards/sead3int.h
index a2e0095..59d6c32 100644
--- a/arch/mips/include/asm/mips-boards/sead3int.h
+++ b/arch/mips/include/asm/mips-boards/sead3int.h
@@ -10,6 +10,8 @@
 #ifndef _MIPS_SEAD3INT_H
 #define _MIPS_SEAD3INT_H
 
+#include <asm/gic.h>
+
 /* SEAD-3 GIC address space definitions. */
 #define GIC_BASE_ADDR		0x1b1c0000
 #define GIC_ADDRSPACE_SZ	(128 * 1024)
@@ -22,9 +24,9 @@
 #define CPU_INT_NET		6
 
 /* GIC interrupt offsets */
-#define GIC_INT_NET		0
-#define GIC_INT_UART1		2
-#define GIC_INT_UART0		3
-#define GIC_INT_EHCI		5
+#define GIC_INT_NET		GIC_SHARED_TO_HWIRQ(0)
+#define GIC_INT_UART1		GIC_SHARED_TO_HWIRQ(2)
+#define GIC_INT_UART0		GIC_SHARED_TO_HWIRQ(3)
+#define GIC_INT_EHCI		GIC_SHARED_TO_HWIRQ(5)
 
 #endif /* !(_MIPS_SEAD3INT_H) */
diff --git a/arch/mips/kernel/cevt-gic.c b/arch/mips/kernel/cevt-gic.c
index a90bd4c..4f9262a 100644
--- a/arch/mips/kernel/cevt-gic.c
+++ b/arch/mips/kernel/cevt-gic.c
@@ -68,7 +68,7 @@ int gic_clockevent_init(void)
 	if (!cpu_has_counter || !gic_frequency)
 		return -ENXIO;
 
-	irq = MIPS_GIC_IRQ_BASE;
+	irq = MIPS_GIC_IRQ_BASE + GIC_LOCAL_TO_HWIRQ(GIC_LOCAL_INT_COMPARE);
 
 	cd = &per_cpu(gic_clockevent_device, cpu);
 
@@ -91,16 +91,13 @@ int gic_clockevent_init(void)
 
 	clockevents_register_device(cd);
 
-	GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE_MAP),
-		 GIC_MAP_TO_PIN_MSK | gic_cpu_pin);
-	GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_SMASK), GIC_VPE_SMASK_CMP_MSK);
+	if (!gic_timer_irq_installed) {
+		setup_percpu_irq(irq, &gic_compare_irqaction);
+		gic_timer_irq_installed = 1;
+	}
 
-	if (gic_timer_irq_installed)
-		return 0;
+	enable_percpu_irq(irq, IRQ_TYPE_NONE);
 
-	gic_timer_irq_installed = 1;
 
-	setup_irq(irq, &gic_compare_irqaction);
-	irq_set_handler(irq, handle_percpu_irq);
 	return 0;
 }
diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 5b8f8e3..fd0ef8d 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -86,7 +86,7 @@ void mips_event_handler(struct clock_event_device *dev)
 static int c0_compare_int_pending(void)
 {
 #ifdef CONFIG_MIPS_GIC
-	if (cpu_has_veic)
+	if (gic_present)
 		return gic_get_timer_pending();
 #endif
 	return (read_c0_cause() >> cp0_compare_irq_shift) & (1ul << CAUSEB_IP);
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index 3b3bc1d..c6b3548 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -273,11 +273,7 @@ asmlinkage void plat_irq_dispatch(void)
 
 	irq = irq_ffs(pending);
 
-	/* HACK: GIC doesn't properly dispatch local interrupts yet */
-	if (gic_present && irq == MIPSCPU_INT_GIC && gic_compare_int())
-		do_IRQ(MIPS_GIC_IRQ_BASE);
-	else
-		do_IRQ(MIPS_CPU_IRQ_BASE + irq);
+	do_IRQ(MIPS_CPU_IRQ_BASE + irq);
 }
 
 #ifdef CONFIG_MIPS_MT_SMP
diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 17cfc8a..f6ca8ea 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -126,9 +126,9 @@ int get_c0_perfcount_int(void)
 	if (cpu_has_veic) {
 		set_vi_handler(MSC01E_INT_PERFCTR, mips_perf_dispatch);
 		mips_cpu_perf_irq = MSC01E_INT_BASE + MSC01E_INT_PERFCTR;
+	} else if (gic_present) {
+		mips_cpu_perf_irq = gic_get_c0_perfcount_int();
 	} else if (cp0_perfcount_irq >= 0) {
-		if (cpu_has_vint)
-			set_vi_handler(cp0_perfcount_irq, mips_perf_dispatch);
 		mips_cpu_perf_irq = MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
 	} else {
 		mips_cpu_perf_irq = -1;
@@ -139,15 +139,12 @@ int get_c0_perfcount_int(void)
 
 unsigned int get_c0_compare_int(void)
 {
-#ifdef MSC01E_INT_BASE
 	if (cpu_has_veic) {
 		set_vi_handler(MSC01E_INT_CPUCTR, mips_timer_dispatch);
 		mips_cpu_timer_irq = MSC01E_INT_BASE + MSC01E_INT_CPUCTR;
-	} else
-#endif
-	{
-		if (cpu_has_vint)
-			set_vi_handler(cp0_compare_irq, mips_timer_dispatch);
+	} else if (gic_present) {
+		mips_cpu_timer_irq = gic_get_c0_compare_int();
+	} else {
 		mips_cpu_timer_irq = MIPS_CPU_IRQ_BASE + cp0_compare_irq;
 	}
 
diff --git a/arch/mips/mti-sead3/sead3-time.c b/arch/mips/mti-sead3/sead3-time.c
index f090c51..fd40de3 100644
--- a/arch/mips/mti-sead3/sead3-time.c
+++ b/arch/mips/mti-sead3/sead3-time.c
@@ -8,24 +8,12 @@
 #include <linux/init.h>
 
 #include <asm/cpu.h>
+#include <asm/gic.h>
 #include <asm/setup.h>
 #include <asm/time.h>
 #include <asm/irq.h>
 #include <asm/mips-boards/generic.h>
 
-static int mips_cpu_timer_irq;
-static int mips_cpu_perf_irq;
-
-static void mips_timer_dispatch(void)
-{
-	do_IRQ(mips_cpu_timer_irq);
-}
-
-static void mips_perf_dispatch(void)
-{
-	do_IRQ(mips_cpu_perf_irq);
-}
-
 static void __iomem *status_reg = (void __iomem *)0xbf000410;
 
 /*
@@ -83,22 +71,18 @@ void read_persistent_clock(struct timespec *ts)
 
 int get_c0_perfcount_int(void)
 {
-	if (cp0_perfcount_irq >= 0) {
-		if (cpu_has_vint)
-			set_vi_handler(cp0_perfcount_irq, mips_perf_dispatch);
-		mips_cpu_perf_irq = MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
-	} else {
-		mips_cpu_perf_irq = -1;
-	}
-	return mips_cpu_perf_irq;
+	if (gic_present)
+		return gic_get_c0_compare_int();
+	if (cp0_perfcount_irq >= 0)
+		return MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
+	return -1;
 }
 
 unsigned int get_c0_compare_int(void)
 {
-	if (cpu_has_vint)
-		set_vi_handler(cp0_compare_irq, mips_timer_dispatch);
-	mips_cpu_timer_irq = MIPS_CPU_IRQ_BASE + cp0_compare_irq;
-	return mips_cpu_timer_irq;
+	if (gic_present)
+		return gic_get_c0_compare_int();
+	return MIPS_CPU_IRQ_BASE + cp0_compare_irq;
 }
 
 void __init plat_time_init(void)
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index bfe8bfb..b28f7ad 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -44,6 +44,7 @@ static struct gic_intrmask_regs intrmask_regs[NR_CPUS];
 static DEFINE_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
 static int gic_shared_intrs;
+static int gic_vpes;
 static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
 
 static void __gic_irq_dispatch(void);
@@ -96,12 +97,35 @@ cycle_t gic_read_compare(void)
 }
 #endif
 
+static bool gic_local_irq_is_routable(int intr)
+{
+	u32 vpe_ctl;
+
+	/* All local interrupts are routable in EIC mode. */
+	if (cpu_has_veic)
+		return true;
+
+	GICREAD(GIC_REG(VPE_LOCAL, GIC_VPE_CTL), vpe_ctl);
+	switch (intr) {
+	case GIC_LOCAL_INT_TIMER:
+		return vpe_ctl & GIC_VPE_CTL_TIMER_RTBL_MSK;
+	case GIC_LOCAL_INT_PERFCTR:
+		return vpe_ctl & GIC_VPE_CTL_PERFCNT_RTBL_MSK;
+	case GIC_LOCAL_INT_FDC:
+		return vpe_ctl & GIC_VPE_CTL_FDC_RTBL_MSK;
+	case GIC_LOCAL_INT_SWINT0:
+	case GIC_LOCAL_INT_SWINT1:
+		return vpe_ctl & GIC_VPE_CTL_SWINT_RTBL_MSK;
+	default:
+		return true;
+	}
+}
+
 unsigned int gic_get_timer_pending(void)
 {
 	unsigned int vpe_pending;
 
-	GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR), 0);
-	GICREAD(GIC_REG(VPE_OTHER, GIC_VPE_PEND), vpe_pending);
+	GICREAD(GIC_REG(VPE_LOCAL, GIC_VPE_PEND), vpe_pending);
 	return (vpe_pending & GIC_VPE_PEND_TIMER_MSK);
 }
 
@@ -119,53 +143,6 @@ void gic_send_ipi(unsigned int intr)
 	GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), 0x80000000 | intr);
 }
 
-static void __init vpe_local_setup(unsigned int numvpes)
-{
-	unsigned long timer_intr = GIC_INT_TMR;
-	unsigned long perf_intr = GIC_INT_PERFCTR;
-	unsigned int vpe_ctl;
-	int i;
-
-	if (cpu_has_veic) {
-		/*
-		 * GIC timer interrupt -> CPU HW Int X (vector X+2) ->
-		 * map to pin X+2-1 (since GIC adds 1)
-		 */
-		timer_intr += (GIC_CPU_TO_VEC_OFFSET - GIC_PIN_TO_VEC_OFFSET);
-		/*
-		 * GIC perfcnt interrupt -> CPU HW Int X (vector X+2) ->
-		 * map to pin X+2-1 (since GIC adds 1)
-		 */
-		perf_intr += (GIC_CPU_TO_VEC_OFFSET - GIC_PIN_TO_VEC_OFFSET);
-	}
-
-	/*
-	 * Setup the default performance counter timer interrupts
-	 * for all VPEs
-	 */
-	for (i = 0; i < numvpes; i++) {
-		GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR), i);
-
-		/* Are Interrupts locally routable? */
-		GICREAD(GIC_REG(VPE_OTHER, GIC_VPE_CTL), vpe_ctl);
-		if (vpe_ctl & GIC_VPE_CTL_TIMER_RTBL_MSK)
-			GICWRITE(GIC_REG(VPE_OTHER, GIC_VPE_TIMER_MAP),
-				 GIC_MAP_TO_PIN_MSK | timer_intr);
-		if (cpu_has_veic) {
-			set_vi_handler(timer_intr + GIC_PIN_TO_VEC_OFFSET,
-				       __gic_irq_dispatch);
-		}
-
-		if (vpe_ctl & GIC_VPE_CTL_PERFCNT_RTBL_MSK)
-			GICWRITE(GIC_REG(VPE_OTHER, GIC_VPE_PERFCTR_MAP),
-				 GIC_MAP_TO_PIN_MSK | perf_intr);
-		if (cpu_has_veic) {
-			set_vi_handler(perf_intr + GIC_PIN_TO_VEC_OFFSET,
-				       __gic_irq_dispatch);
-		}
-	}
-}
-
 unsigned int gic_compare_int(void)
 {
 	unsigned int pending;
@@ -177,6 +154,26 @@ unsigned int gic_compare_int(void)
 		return 0;
 }
 
+int gic_get_c0_compare_int(void)
+{
+	if (!gic_local_irq_is_routable(GIC_LOCAL_INT_TIMER))
+		return MIPS_CPU_IRQ_BASE + cp0_compare_irq;
+	return irq_create_mapping(gic_irq_domain,
+				  GIC_LOCAL_TO_HWIRQ(GIC_LOCAL_INT_TIMER));
+}
+
+int gic_get_c0_perfcount_int(void)
+{
+	if (!gic_local_irq_is_routable(GIC_LOCAL_INT_PERFCTR)) {
+		/* Is the erformance counter shared with the timer? */
+		if (cp0_perfcount_irq < 0)
+			return -1;
+		return MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
+	}
+	return irq_create_mapping(gic_irq_domain,
+				  GIC_LOCAL_TO_HWIRQ(GIC_LOCAL_INT_PERFCTR));
+}
+
 void gic_get_int_mask(unsigned long *dst, const unsigned long *src)
 {
 	unsigned int i;
@@ -217,24 +214,24 @@ unsigned int gic_get_int(void)
 
 static void gic_mask_irq(struct irq_data *d)
 {
-	GIC_CLR_INTR_MASK(d->hwirq);
+	GIC_CLR_INTR_MASK(GIC_HWIRQ_TO_SHARED(d->hwirq));
 }
 
 static void gic_unmask_irq(struct irq_data *d)
 {
-	GIC_SET_INTR_MASK(d->hwirq);
+	GIC_SET_INTR_MASK(GIC_HWIRQ_TO_SHARED(d->hwirq));
 }
 
 static void gic_ack_irq(struct irq_data *d)
 {
-	unsigned int irq = d->hwirq;
+	unsigned int irq = GIC_HWIRQ_TO_SHARED(d->hwirq);
 
 	GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), irq);
 }
 
 static int gic_set_type(struct irq_data *d, unsigned int type)
 {
-	unsigned int irq = d->hwirq;
+	unsigned int irq = GIC_HWIRQ_TO_SHARED(d->hwirq);
 	unsigned long flags;
 	bool is_edge;
 
@@ -291,7 +288,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 			    bool force)
 {
-	unsigned int irq = d->hwirq;
+	unsigned int irq = GIC_HWIRQ_TO_SHARED(d->hwirq);
 	cpumask_t	tmp = CPU_MASK_NONE;
 	unsigned long	flags;
 	int		i;
@@ -339,12 +336,85 @@ static struct irq_chip gic_edge_irq_controller = {
 #endif
 };
 
+static unsigned int gic_get_local_int(void)
+{
+	unsigned long pending, masked;
+
+	GICREAD(GIC_REG(VPE_LOCAL, GIC_VPE_PEND), pending);
+	GICREAD(GIC_REG(VPE_LOCAL, GIC_VPE_MASK), masked);
+
+	bitmap_and(&pending, &pending, &masked, GIC_NUM_LOCAL_INTRS);
+
+	return find_first_bit(&pending, GIC_NUM_LOCAL_INTRS);
+}
+
+static void gic_mask_local_irq(struct irq_data *d)
+{
+	int intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
+
+	GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_RMASK), 1 << intr);
+}
+
+static void gic_unmask_local_irq(struct irq_data *d)
+{
+	int intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
+
+	GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_SMASK), 1 << intr);
+}
+
+static struct irq_chip gic_local_irq_controller = {
+	.name			=	"MIPS GIC Local",
+	.irq_mask		=	gic_mask_local_irq,
+	.irq_unmask		=	gic_unmask_local_irq,
+};
+
+static void gic_mask_local_irq_all_vpes(struct irq_data *d)
+{
+	int intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
+	int i;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gic_lock, flags);
+	for (i = 0; i < gic_vpes; i++) {
+		GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR), i);
+		GICWRITE(GIC_REG(VPE_OTHER, GIC_VPE_RMASK), 1 << intr);
+	}
+	spin_unlock_irqrestore(&gic_lock, flags);
+}
+
+static void gic_unmask_local_irq_all_vpes(struct irq_data *d)
+{
+	int intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
+	int i;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gic_lock, flags);
+	for (i = 0; i < gic_vpes; i++) {
+		GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR), i);
+		GICWRITE(GIC_REG(VPE_OTHER, GIC_VPE_SMASK), 1 << intr);
+	}
+	spin_unlock_irqrestore(&gic_lock, flags);
+}
+
+static struct irq_chip gic_all_vpes_local_irq_controller = {
+	.name			=	"MIPS GIC Local",
+	.irq_mask		=	gic_mask_local_irq_all_vpes,
+	.irq_unmask		=	gic_unmask_local_irq_all_vpes,
+};
+
 static void __gic_irq_dispatch(void)
 {
 	unsigned int intr, virq;
 
+	while ((intr = gic_get_local_int()) != GIC_NUM_LOCAL_INTRS) {
+		virq = irq_linear_revmap(gic_irq_domain,
+					 GIC_LOCAL_TO_HWIRQ(intr));
+		do_IRQ(virq);
+	}
+
 	while ((intr = gic_get_int()) != gic_shared_intrs) {
-		virq = irq_linear_revmap(gic_irq_domain, intr);
+		virq = irq_linear_revmap(gic_irq_domain,
+					 GIC_SHARED_TO_HWIRQ(intr));
 		do_IRQ(virq);
 	}
 }
@@ -397,7 +467,8 @@ static struct irqaction irq_call = {
 static __init void gic_ipi_init_one(unsigned int intr, int cpu,
 				    struct irqaction *action)
 {
-	int virq = irq_create_mapping(gic_irq_domain, intr);
+	int virq = irq_create_mapping(gic_irq_domain,
+				      GIC_SHARED_TO_HWIRQ(intr));
 	int i;
 
 	GIC_SH_MAP_TO_VPE_SMASK(intr, cpu);
@@ -430,7 +501,7 @@ static inline void gic_ipi_init(void)
 }
 #endif
 
-static void __init gic_basic_init(int numvpes)
+static void __init gic_basic_init(void)
 {
 	unsigned int i;
 
@@ -443,28 +514,112 @@ static void __init gic_basic_init(int numvpes)
 		GIC_CLR_INTR_MASK(i);
 	}
 
-	vpe_local_setup(numvpes);
+	for (i = 0; i < gic_vpes; i++) {
+		unsigned int j;
+
+		GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR), i);
+		for (j = 0; j < GIC_NUM_LOCAL_INTRS; j++) {
+			if (!gic_local_irq_is_routable(j))
+				continue;
+			GICWRITE(GIC_REG(VPE_OTHER, GIC_VPE_RMASK), 1 << j);
+		}
+	}
 }
 
-static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
-			      irq_hw_number_t hw)
+static int gic_local_irq_domain_map(struct irq_domain *d, unsigned int virq,
+				    irq_hw_number_t hw)
 {
+	int intr = GIC_HWIRQ_TO_LOCAL(hw);
+	int ret = 0;
+	int i;
+	unsigned long flags;
+
+	if (!gic_local_irq_is_routable(intr))
+		return -EPERM;
+
+	/*
+	 * HACK: These are all really percpu interrupts, but the rest
+	 * of the MIPS kernel code does not use the percpu IRQ API for
+	 * the CP0 timer and performance counter interrupts.
+	 */
+	if (intr != GIC_LOCAL_INT_TIMER && intr != GIC_LOCAL_INT_PERFCTR) {
+		irq_set_chip_and_handler(virq,
+					 &gic_local_irq_controller,
+					 handle_percpu_devid_irq);
+		irq_set_percpu_devid(virq);
+	} else {
+		irq_set_chip_and_handler(virq,
+					 &gic_all_vpes_local_irq_controller,
+					 handle_percpu_irq);
+	}
+
+	spin_lock_irqsave(&gic_lock, flags);
+	for (i = 0; i < gic_vpes; i++) {
+		u32 val = GIC_MAP_TO_PIN_MSK | gic_cpu_pin;
+
+		GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR), i);
+
+		switch (intr) {
+		case GIC_LOCAL_INT_WD:
+			GICWRITE(GIC_REG(VPE_OTHER, GIC_VPE_WD_MAP), val);
+			break;
+		case GIC_LOCAL_INT_COMPARE:
+			GICWRITE(GIC_REG(VPE_OTHER, GIC_VPE_COMPARE_MAP), val);
+			break;
+		case GIC_LOCAL_INT_TIMER:
+			GICWRITE(GIC_REG(VPE_OTHER, GIC_VPE_TIMER_MAP), val);
+			break;
+		case GIC_LOCAL_INT_PERFCTR:
+			GICWRITE(GIC_REG(VPE_OTHER, GIC_VPE_PERFCTR_MAP), val);
+			break;
+		case GIC_LOCAL_INT_SWINT0:
+			GICWRITE(GIC_REG(VPE_OTHER, GIC_VPE_SWINT0_MAP), val);
+			break;
+		case GIC_LOCAL_INT_SWINT1:
+			GICWRITE(GIC_REG(VPE_OTHER, GIC_VPE_SWINT1_MAP), val);
+			break;
+		case GIC_LOCAL_INT_FDC:
+			GICWRITE(GIC_REG(VPE_OTHER, GIC_VPE_FDC_MAP), val);
+			break;
+		default:
+			pr_err("Invalid local IRQ %d\n", intr);
+			ret = -EINVAL;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&gic_lock, flags);
+
+	return ret;
+}
+
+static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
+				     irq_hw_number_t hw)
+{
+	int intr = GIC_HWIRQ_TO_SHARED(hw);
 	unsigned long flags;
 
 	irq_set_chip_and_handler(virq, &gic_level_irq_controller,
 				 handle_level_irq);
 
 	spin_lock_irqsave(&gic_lock, flags);
-	GICWRITE(GIC_REG_ADDR(SHARED, GIC_SH_MAP_TO_PIN(hw)),
+	GICWRITE(GIC_REG_ADDR(SHARED, GIC_SH_MAP_TO_PIN(intr)),
 		 GIC_MAP_TO_PIN_MSK | gic_cpu_pin);
 	/* Map to VPE 0 by default */
-	GIC_SH_MAP_TO_VPE_SMASK(hw, 0);
-	set_bit(hw, pcpu_masks[0].pcpu_mask);
+	GIC_SH_MAP_TO_VPE_SMASK(intr, 0);
+	set_bit(intr, pcpu_masks[0].pcpu_mask);
 	spin_unlock_irqrestore(&gic_lock, flags);
 
 	return 0;
 }
 
+static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
+			      irq_hw_number_t hw)
+{
+	if (GIC_HWIRQ_TO_LOCAL(hw) < GIC_NUM_LOCAL_INTRS)
+		return gic_local_irq_domain_map(d, virq, hw);
+	return gic_shared_irq_domain_map(d, virq, hw);
+}
+
 static struct irq_domain_ops gic_irq_domain_ops = {
 	.map = gic_irq_domain_map,
 	.xlate = irq_domain_xlate_twocell,
@@ -475,7 +630,6 @@ void __init gic_init(unsigned long gic_base_addr,
 		     unsigned int irqbase)
 {
 	unsigned int gicconfig;
-	int numvpes, numintrs;
 
 	_gic_base = (unsigned long) ioremap_nocache(gic_base_addr,
 						    gic_addrspace_size);
@@ -485,9 +639,9 @@ void __init gic_init(unsigned long gic_base_addr,
 		   GIC_SH_CONFIG_NUMINTRS_SHF;
 	gic_shared_intrs = ((gic_shared_intrs + 1) * 8);
 
-	numvpes = (gicconfig & GIC_SH_CONFIG_NUMVPES_MSK) >>
+	gic_vpes = (gicconfig & GIC_SH_CONFIG_NUMVPES_MSK) >>
 		  GIC_SH_CONFIG_NUMVPES_SHF;
-	numvpes = numvpes + 1;
+	gic_vpes = gic_vpes + 1;
 
 	if (cpu_has_veic) {
 		/* Always use vector 1 in EIC mode */
@@ -500,12 +654,13 @@ void __init gic_init(unsigned long gic_base_addr,
 					gic_irq_dispatch);
 	}
 
-	gic_irq_domain = irq_domain_add_simple(NULL, gic_shared_intrs, irqbase,
+	gic_irq_domain = irq_domain_add_simple(NULL, GIC_NUM_LOCAL_INTRS +
+					       gic_shared_intrs, irqbase,
 					       &gic_irq_domain_ops, NULL);
 	if (!gic_irq_domain)
 		panic("Failed to add GIC IRQ domain");
 
-	gic_basic_init(numvpes);
+	gic_basic_init();
 
 	gic_ipi_init();
 }
-- 
2.1.0.rc2.206.gedb03e5
