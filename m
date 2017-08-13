Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 06:47:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32192 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993928AbdHMEpWSiKzd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 06:45:22 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 888D8DE092AD5;
        Sun, 13 Aug 2017 05:45:13 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 05:45:15 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 26/38] MIPS: Use mips_gic_present() in place of gic_present
Date:   Sat, 12 Aug 2017 21:36:34 -0700
Message-ID: <20170813043646.25821-27-paul.burton@imgtec.com>
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
X-archive-position: 59542
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

In preparation for removing the gic_present global variable, switch to
using the mips_gic_present() function instead. For the most part this is
a straightforward substitution. In cases which previously wrapped the
GIC case in an #ifdef CONFIG_MIPS_GIC that #ifdef has been removed,
since mips_gic_present() will return a compile-time constant false
allowing the affected code to be optimised out anyway.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/generic/irq.c          |  7 ++++---
 arch/mips/kernel/smp-mt.c        |  6 ++----
 arch/mips/lantiq/irq.c           |  4 ----
 arch/mips/mti-malta/malta-int.c  |  4 ++--
 arch/mips/mti-malta/malta-time.c | 19 +++++++++----------
 5 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/arch/mips/generic/irq.c b/arch/mips/generic/irq.c
index 14064bdd91dd..a05fcb328e2e 100644
--- a/arch/mips/generic/irq.c
+++ b/arch/mips/generic/irq.c
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 
 #include <asm/irq.h>
+#include <asm/mips-cps.h>
 
 int get_c0_fdc_int(void)
 {
@@ -23,7 +24,7 @@ int get_c0_fdc_int(void)
 
 	if (cpu_has_veic)
 		panic("Unimplemented!");
-	else if (gic_present)
+	else if (mips_gic_present())
 		mips_cpu_fdc_irq = gic_get_c0_fdc_int();
 	else if (cp0_fdc_irq >= 0)
 		mips_cpu_fdc_irq = MIPS_CPU_IRQ_BASE + cp0_fdc_irq;
@@ -39,7 +40,7 @@ int get_c0_perfcount_int(void)
 
 	if (cpu_has_veic)
 		panic("Unimplemented!");
-	else if (gic_present)
+	else if (mips_gic_present())
 		mips_cpu_perf_irq = gic_get_c0_perfcount_int();
 	else if (cp0_perfcount_irq >= 0)
 		mips_cpu_perf_irq = MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
@@ -55,7 +56,7 @@ unsigned int get_c0_compare_int(void)
 
 	if (cpu_has_veic)
 		panic("Unimplemented!");
-	else if (gic_present)
+	else if (mips_gic_present())
 		mips_cpu_timer_irq = gic_get_c0_compare_int();
 	else
 		mips_cpu_timer_irq = MIPS_CPU_IRQ_BASE + cp0_compare_irq;
diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index 30415a74f312..94ab3276b48c 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -21,7 +21,6 @@
 #include <linux/sched.h>
 #include <linux/cpumask.h>
 #include <linux/interrupt.h>
-#include <linux/irqchip/mips-gic.h>
 #include <linux/compiler.h>
 #include <linux/sched/task_stack.h>
 #include <linux/smp.h>
@@ -36,6 +35,7 @@
 #include <asm/mipsregs.h>
 #include <asm/mipsmtregs.h>
 #include <asm/mips_mt.h>
+#include <asm/mips-cps.h>
 
 static void __init smvp_copy_vpe_config(void)
 {
@@ -118,14 +118,12 @@ static void __init smvp_tc_init(unsigned int tc, unsigned int mvpconf0)
 
 static void vsmp_init_secondary(void)
 {
-#ifdef CONFIG_MIPS_GIC
 	/* This is Malta specific: IPI,performance and timer interrupts */
-	if (gic_present)
+	if (mips_gic_present())
 		change_c0_status(ST0_IM, STATUSF_IP2 | STATUSF_IP3 |
 					 STATUSF_IP4 | STATUSF_IP5 |
 					 STATUSF_IP6 | STATUSF_IP7);
 	else
-#endif
 		change_c0_status(ST0_IM, STATUSF_IP0 | STATUSF_IP1 |
 					 STATUSF_IP6 | STATUSF_IP7);
 }
diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index 33728b7af426..f0bc3312ed11 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -61,10 +61,6 @@
 /* we have a cascade of 8 irqs */
 #define MIPS_CPU_IRQ_CASCADE		8
 
-#ifdef CONFIG_MIPS_MT_SMP
-int gic_present;
-#endif
-
 static int exin_avail;
 static u32 ltq_eiu_irq[MAX_EIU];
 static void __iomem *ltq_icu_membase[MAX_IM];
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index 2e831f4abfb3..a840e0c1642c 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -19,7 +19,6 @@
 #include <linux/smp.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/irqchip/mips-gic.h>
 #include <linux/of_irq.h>
 #include <linux/kernel_stat.h>
 #include <linux/kernel.h>
@@ -31,6 +30,7 @@
 #include <asm/irq_regs.h>
 #include <asm/mips-boards/malta.h>
 #include <asm/mips-boards/maltaint.h>
+#include <asm/mips-cps.h>
 #include <asm/gt64120.h>
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/msc01_pci.h>
@@ -214,7 +214,7 @@ void __init arch_init_irq(void)
 					msc_nr_irqs);
 	}
 
-	if (gic_present) {
+	if (mips_gic_present()) {
 		corehi_irq = MIPS_CPU_IRQ_BASE + MIPSCPU_INT_COREHI;
 	} else if (cpu_has_veic) {
 		set_vi_handler(MSC01E_INT_COREHI, corehi_irqdispatch);
diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index cea4ec909806..7db872be01c0 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -40,6 +40,7 @@
 #include <asm/time.h>
 #include <asm/mc146818-time.h>
 #include <asm/msc01_ic.h>
+#include <asm/mips-cps.h>
 
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/maltaint.h>
@@ -85,7 +86,7 @@ static void __init estimate_frequencies(void)
 
 	local_irq_save(flags);
 
-	if (gic_present)
+	if (mips_gic_present())
 		gic_start_count();
 
 	/*
@@ -95,7 +96,7 @@ static void __init estimate_frequencies(void)
 	while (CMOS_READ(RTC_REG_A) & RTC_UIP);
 	while (!(CMOS_READ(RTC_REG_A) & RTC_UIP));
 	start = read_c0_count();
-	if (gic_present)
+	if (mips_gic_present())
 		gicstart = gic_read_count();
 
 	/* Wait for falling edge before reading RTC. */
@@ -105,7 +106,7 @@ static void __init estimate_frequencies(void)
 	/* Read counters again exactly on rising edge of update flag. */
 	while (!(CMOS_READ(RTC_REG_A) & RTC_UIP));
 	count = read_c0_count();
-	if (gic_present)
+	if (mips_gic_present())
 		giccount = gic_read_count();
 
 	/* Wait for falling edge before reading RTC again. */
@@ -128,7 +129,7 @@ static void __init estimate_frequencies(void)
 	count /= secs;
 	mips_hpt_frequency = count;
 
-	if (gic_present) {
+	if (mips_gic_present()) {
 		giccount = div_u64(giccount - gicstart, secs);
 		gic_frequency = giccount;
 	}
@@ -154,7 +155,7 @@ int get_c0_fdc_int(void)
 
 	if (cpu_has_veic)
 		return -1;
-	else if (gic_present)
+	else if (mips_gic_present())
 		return gic_get_c0_fdc_int();
 	else if (cp0_fdc_irq >= 0)
 		return MIPS_CPU_IRQ_BASE + cp0_fdc_irq;
@@ -167,7 +168,7 @@ int get_c0_perfcount_int(void)
 	if (cpu_has_veic) {
 		set_vi_handler(MSC01E_INT_PERFCTR, mips_perf_dispatch);
 		mips_cpu_perf_irq = MSC01E_INT_BASE + MSC01E_INT_PERFCTR;
-	} else if (gic_present) {
+	} else if (mips_gic_present()) {
 		mips_cpu_perf_irq = gic_get_c0_perfcount_int();
 	} else if (cp0_perfcount_irq >= 0) {
 		mips_cpu_perf_irq = MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
@@ -184,7 +185,7 @@ unsigned int get_c0_compare_int(void)
 	if (cpu_has_veic) {
 		set_vi_handler(MSC01E_INT_CPUCTR, mips_timer_dispatch);
 		mips_cpu_timer_irq = MSC01E_INT_BASE + MSC01E_INT_CPUCTR;
-	} else if (gic_present) {
+	} else if (mips_gic_present()) {
 		mips_cpu_timer_irq = gic_get_c0_compare_int();
 	} else {
 		mips_cpu_timer_irq = MIPS_CPU_IRQ_BASE + cp0_compare_irq;
@@ -258,8 +259,7 @@ void __init plat_time_init(void)
 	setup_pit_timer();
 #endif
 
-#ifdef CONFIG_MIPS_GIC
-	if (gic_present) {
+	if (mips_gic_present()) {
 		freq = freqround(gic_frequency, 5000);
 		printk("GIC frequency %d.%02d MHz\n", freq/1000000,
 		       (freq%1000000)*100/1000000);
@@ -268,5 +268,4 @@ void __init plat_time_init(void)
 		timer_probe();
 #endif
 	}
-#endif
 }
-- 
2.14.0
