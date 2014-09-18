Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2014 23:49:54 +0200 (CEST)
Received: from mail-pa0-f73.google.com ([209.85.220.73]:33450 "EHLO
        mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009234AbaIRVrpVerKZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2014 23:47:45 +0200
Received: by mail-pa0-f73.google.com with SMTP id kq14so499384pab.4
        for <linux-mips@linux-mips.org>; Thu, 18 Sep 2014 14:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2HJRgNXPWiV8w+Fuvzp+sLWNtF5l+CuS6ek6YIXR3nU=;
        b=LUmv+a11wwUOuyHbN+471Cvopq8ZSW3KW5PQR3aeoEwMZC5h2OohNzt0mJMRjrfLSx
         tRVyOlsD8rOXdJQ7dmZ+700uBZ8a5lWAbvLeBORHmQNLEAiFkBnvjIGHLBB7P8VRk0AG
         8Uso1hB+6Xtbnm3pQkSDmsUmR/plBdpMmQ8uYSWE6+xtNzWN8mPevIbtbPMyCcAnqaPP
         stZ1MxA7GpRl8PRRFST8uHR+FKO8qeTd0Eq+Elchbm+6w+dopwfUGR/yVWAtRGLUaU16
         MFDPh7VtYEriC/dQF7hZim4dGSUD7YNliA6vWTIG95qEsQUxRwiQpPLTfhaCe3/at7OL
         A/cg==
X-Gm-Message-State: ALoCoQlYHKmo7iwTEGDvk8M8/CDLleqRznLpedZj/nL2UmUB0XRHKvAEyax/DyPOAWJLzhrPXqNJ
X-Received: by 10.66.156.232 with SMTP id wh8mr6096286pab.27.1411076859117;
        Thu, 18 Sep 2014 14:47:39 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id m14si1172yhm.7.2014.09.18.14.47.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2014 14:47:39 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id lBwURzVy.2; Thu, 18 Sep 2014 14:47:38 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id E2BCC220D1A; Thu, 18 Sep 2014 14:47:37 -0700 (PDT)
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
Subject: [PATCH V2 06/24] MIPS: Add hook to get C0 performance counter interrupt
Date:   Thu, 18 Sep 2014 14:47:12 -0700
Message-Id: <1411076851-28242-7-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
References: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42687
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

The hardware perf event driver and oprofile interpret the global
cp0_perfcount_irq differently: in the hardware perf event driver
it is an offset from MIPS_CPU_IRQ_BASE and in oprofile it is the
actual IRQ number.  This still works most of the time since
MIPS_CPU_IRQ_BASE is usually 0, but is clearly wrong.  Since the
performance counter interrupt may vary from platform to platform
like the C0 timer interrupt, add the optional get_c0_perfcount_int
hook which returns the IRQ number of the performance counter.
The hook should return < 0 if the performance counter interrupt is
shared with the timer.  If the hook is not present, the CPU vector
reported in C0_IntCtl (cp0_perfcount_irq) is used.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Reviewed-by: Qais Yousef <qais.yousef@imgtec.com>
Tested-by: Qais Yousef <qais.yousef@imgtec.com>
---
No changes from v1.
---
 arch/mips/ath79/irq.c                |  1 -
 arch/mips/ath79/setup.c              |  5 +++++
 arch/mips/include/asm/time.h         |  1 +
 arch/mips/kernel/perf_event_mipsxx.c | 23 +++++++----------------
 arch/mips/lantiq/irq.c               |  8 +++++++-
 arch/mips/mti-malta/malta-time.c     | 16 ++++++----------
 arch/mips/mti-sead3/sead3-time.c     |  7 ++++---
 arch/mips/oprofile/op_model_mipsxx.c | 18 ++++++++++++++----
 arch/mips/ralink/irq.c               |  8 +++++++-
 9 files changed, 51 insertions(+), 36 deletions(-)

diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
index 9c0e176..6adae36 100644
--- a/arch/mips/ath79/irq.c
+++ b/arch/mips/ath79/irq.c
@@ -359,7 +359,6 @@ void __init arch_init_irq(void)
 		BUG();
 	}
 
-	cp0_perfcount_irq = ATH79_MISC_IRQ(5);
 	mips_cpu_irq_init();
 	ath79_misc_irq_init();
 
diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 64807a4..a73c93c 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -182,6 +182,11 @@ const char *get_system_type(void)
 	return ath79_sys_type;
 }
 
+int get_c0_perfcount_int(void)
+{
+	return ATH79_MISC_IRQ(5);
+}
+
 unsigned int get_c0_compare_int(void)
 {
 	return CP0_LEGACY_COMPARE_IRQ;
diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index 8f3047d..7969933 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -46,6 +46,7 @@ extern unsigned int mips_hpt_frequency;
  * so it lives here.
  */
 extern int (*perf_irq)(void);
+extern int __weak get_c0_perfcount_int(void);
 
 /*
  * Initialize the calling CPU's compare interrupt as clockevent device
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index b63f248..3a25096 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -1614,22 +1614,13 @@ init_hw_perf_events(void)
 		counters = counters_total_to_per_cpu(counters);
 #endif
 
-#ifdef MSC01E_INT_BASE
-	if (cpu_has_veic) {
-		/*
-		 * Using platform specific interrupt controller defines.
-		 */
-		irq = MSC01E_INT_BASE + MSC01E_INT_PERFCTR;
-	} else {
-#endif
-		if ((cp0_perfcount_irq >= 0) &&
-				(cp0_compare_irq != cp0_perfcount_irq))
-			irq = MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
-		else
-			irq = -1;
-#ifdef MSC01E_INT_BASE
-	}
-#endif
+	if (get_c0_perfcount_int)
+		irq = get_c0_perfcount_int();
+	else if ((cp0_perfcount_irq >= 0) &&
+		 (cp0_compare_irq != cp0_perfcount_irq))
+		irq = MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
+	else
+		irq = -1;
 
 	mipspmu.map_raw_event = mipsxx_pmu_map_raw_event;
 
diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index 030568a..21c38ee 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -70,6 +70,7 @@ static struct resource ltq_eiu_irq[MAX_EIU];
 static void __iomem *ltq_icu_membase[MAX_IM];
 static void __iomem *ltq_eiu_membase;
 static struct irq_domain *ltq_domain;
+static int ltq_perfcount_irq;
 
 int ltq_eiu_get_irq(int exin)
 {
@@ -449,7 +450,7 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 #endif
 
 	/* tell oprofile which irq to use */
-	cp0_perfcount_irq = irq_create_mapping(ltq_domain, LTQ_PERF_IRQ);
+	ltq_perfcount_irq = irq_create_mapping(ltq_domain, LTQ_PERF_IRQ);
 
 	/*
 	 * if the timer irq is not one of the mips irqs we need to
@@ -461,6 +462,11 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 	return 0;
 }
 
+int get_c0_perfcount_int(void)
+{
+	return ltq_perfcount_irq;
+}
+
 unsigned int get_c0_compare_int(void)
 {
 	return MIPS_CPU_TIMER_IRQ;
diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 3778a35..a4e035c 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -121,22 +121,20 @@ void read_persistent_clock(struct timespec *ts)
 	ts->tv_nsec = 0;
 }
 
-static void __init plat_perf_setup(void)
+int get_c0_perfcount_int(void)
 {
-#ifdef MSC01E_INT_BASE
 	if (cpu_has_veic) {
 		set_vi_handler(MSC01E_INT_PERFCTR, mips_perf_dispatch);
 		mips_cpu_perf_irq = MSC01E_INT_BASE + MSC01E_INT_PERFCTR;
-	} else
-#endif
-	if (cp0_perfcount_irq >= 0) {
+	} else if (cp0_perfcount_irq >= 0) {
 		if (cpu_has_vint)
 			set_vi_handler(cp0_perfcount_irq, mips_perf_dispatch);
 		mips_cpu_perf_irq = MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
-#ifdef CONFIG_SMP
-		irq_set_handler(mips_cpu_perf_irq, handle_percpu_irq);
-#endif
+	} else {
+		mips_cpu_perf_irq = -1;
 	}
+
+	return mips_cpu_perf_irq;
 }
 
 unsigned int get_c0_compare_int(void)
@@ -201,6 +199,4 @@ void __init plat_time_init(void)
 #endif
 	}
 #endif
-
-	plat_perf_setup();
 }
diff --git a/arch/mips/mti-sead3/sead3-time.c b/arch/mips/mti-sead3/sead3-time.c
index 678d03d..f090c51 100644
--- a/arch/mips/mti-sead3/sead3-time.c
+++ b/arch/mips/mti-sead3/sead3-time.c
@@ -81,13 +81,16 @@ void read_persistent_clock(struct timespec *ts)
 	ts->tv_nsec = 0;
 }
 
-static void __init plat_perf_setup(void)
+int get_c0_perfcount_int(void)
 {
 	if (cp0_perfcount_irq >= 0) {
 		if (cpu_has_vint)
 			set_vi_handler(cp0_perfcount_irq, mips_perf_dispatch);
 		mips_cpu_perf_irq = MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
+	} else {
+		mips_cpu_perf_irq = -1;
 	}
+	return mips_cpu_perf_irq;
 }
 
 unsigned int get_c0_compare_int(void)
@@ -108,6 +111,4 @@ void __init plat_time_init(void)
 		(est_freq % 1000000) * 100 / 1000000);
 
 	mips_scroll_message();
-
-	plat_perf_setup();
 }
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 42821ae..01f721a 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -11,6 +11,7 @@
 #include <linux/interrupt.h>
 #include <linux/smp.h>
 #include <asm/irq_regs.h>
+#include <asm/time.h>
 
 #include "op_impl.h"
 
@@ -35,6 +36,7 @@
 #define M_PERFCTL_COUNT_ALL_THREADS	(1UL	  << 13)
 
 static int (*save_perf_irq)(void);
+static int perfcount_irq;
 
 /*
  * XLR has only one set of counters per core. Designate the
@@ -431,8 +433,16 @@ static int __init mipsxx_init(void)
 	save_perf_irq = perf_irq;
 	perf_irq = mipsxx_perfcount_handler;
 
-	if ((cp0_perfcount_irq >= 0) && (cp0_compare_irq != cp0_perfcount_irq))
-		return request_irq(cp0_perfcount_irq, mipsxx_perfcount_int,
+	if (get_c0_perfcount_int)
+		perfcount_irq = get_c0_perfcount_int();
+	else if ((cp0_perfcount_irq >= 0) &&
+		 (cp0_compare_irq != cp0_perfcount_irq))
+		perfcount_irq = MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
+	else
+		perfcount_irq = -1;
+
+	if (perfcount_irq >= 0)
+		return request_irq(perfcount_irq, mipsxx_perfcount_int,
 			0, "Perfcounter", save_perf_irq);
 
 	return 0;
@@ -442,8 +452,8 @@ static void mipsxx_exit(void)
 {
 	int counters = op_model_mipsxx_ops.num_counters;
 
-	if ((cp0_perfcount_irq >= 0) && (cp0_compare_irq != cp0_perfcount_irq))
-		free_irq(cp0_perfcount_irq, save_perf_irq);
+	if (perfcount_irq >= 0)
+		free_irq(perfcount_irq, save_perf_irq);
 
 	counters = counters_per_cpu_to_total(counters);
 	on_each_cpu(reset_counters, (void *)(long)counters, 1);
diff --git a/arch/mips/ralink/irq.c b/arch/mips/ralink/irq.c
index 0495011..7634dcd 100644
--- a/arch/mips/ralink/irq.c
+++ b/arch/mips/ralink/irq.c
@@ -45,6 +45,7 @@
 #define RALINK_INTC_IRQ_PERFC   (RALINK_INTC_IRQ_BASE + 9)
 
 static void __iomem *rt_intc_membase;
+static int rt_perfcount_irq;
 
 static inline void rt_intc_w32(u32 val, unsigned reg)
 {
@@ -73,6 +74,11 @@ static struct irq_chip ralink_intc_irq_chip = {
 	.irq_mask_ack	= ralink_intc_irq_mask,
 };
 
+int get_c0_perfcount_int(void)
+{
+	return rt_perfcount_irq;
+}
+
 unsigned int get_c0_compare_int(void)
 {
 	return CP0_LEGACY_COMPARE_IRQ;
@@ -167,7 +173,7 @@ static int __init intc_of_init(struct device_node *node,
 	irq_set_handler_data(irq, domain);
 
 	/* tell the kernel which irq is used for performance monitoring */
-	cp0_perfcount_irq = irq_create_mapping(domain, 9);
+	rt_perfcount_irq = irq_create_mapping(domain, 9);
 
 	return 0;
 }
-- 
2.1.0.rc2.206.gedb03e5
