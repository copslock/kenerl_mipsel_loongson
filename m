Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Sep 2017 01:28:31 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28694 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994832AbdIGX1UCkPHk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Sep 2017 01:27:20 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 3FDF3588876A0;
        Fri,  8 Sep 2017 00:27:07 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 8 Sep 2017 00:27:11
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
Subject: [RFC PATCH v1 4/9] MIPS: Remove perf_irq interrupt sharing fallback
Date:   Thu, 7 Sep 2017 16:25:37 -0700
Message-ID: <20170907232542.20589-5-paul.burton@imgtec.com>
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
X-archive-position: 59958
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

Since commit a1ec0e188330 ("MIPS: perf: Allow sharing IRQ with timer")
we have supported registering our performance counter overflow IRQ
handler using the IRQF_SHARED flag when cp0_perfcount_irq >= 0 or
get_c0_perfcount_int() is implemented & returns a valid interrupt. This
was made unconditional for MIPSr2 & beyond by commit 4a91d8fb61e2
("MIPS: Allow shared IRQ for timer & perf counter") which removed a
special case that set cp0_perfcount_irq to -1 if the performance counter
overflow & timer interrupts share a CPU interrupt pin, however for
pre-r2 systems we retained a fallback wherein we don't register the perf
IRQ handler & instead set a perf_irq function pointer which is called by
the timer driver.

Commit 4a91d8fb61e2 ("MIPS: Allow shared IRQ for timer & perf counter")
seems to suggest that this is necessary because the we can't decode
which interrupt happened on pre-r2 systems, but this is not true - in
this case __handle_irq_event_percpu() will simply invoke both the timer
driver & perf interrupt handlers which is exactly what we want, and
they'll simply both perform their work as they do now.

As such we can set cp0_perfcount_irq = cp0_compare_irq for pre-r2
systems and remove the perf_irq fallback in favor of always relying on
more standard interrupt sharing using IRQF_SHARED & multiple handlers.

A natural cleanup that ties in with no longer using perf_irq is that we
can remove mipsxx_pmu_handle_shared_irq() which we previously pointed
perf_irq at, and effectively inline it in mipsxx_pmu_handle_irq().

In the the loongson3 oprofile case the driver had exclusively relied
upon perf_irq, and we switch instead to calling request_irq() to
register the shared handler just like the mipsxx perf & oprofile code.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
---

 arch/mips/kernel/perf_event_mipsxx.c    | 59 +++++++++++----------------------
 arch/mips/kernel/traps.c                |  2 +-
 arch/mips/oprofile/op_model_loongson3.c | 39 +++++++++++-----------
 arch/mips/oprofile/op_model_mipsxx.c    | 10 ++----
 4 files changed, 42 insertions(+), 68 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 9e6c74bf66c4..cae36ca400e9 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -25,7 +25,7 @@
 #include <asm/irq.h>
 #include <asm/irq_regs.h>
 #include <asm/stacktrace.h>
-#include <asm/time.h> /* For perf_irq */
+#include <asm/time.h>
 
 #define MIPS_MAX_HWEVENTS 4
 #define MIPS_TCS_PER_COUNTER 2
@@ -167,7 +167,6 @@ static unsigned int counters_total_to_per_cpu(unsigned int counters)
 static void resume_local_counters(void);
 static void pause_local_counters(void);
 static irqreturn_t mipsxx_pmu_handle_irq(int, void *);
-static int mipsxx_pmu_handle_shared_irq(void);
 
 static unsigned int mipsxx_pmu_swizzle_perf_idx(unsigned int idx)
 {
@@ -538,44 +537,25 @@ static void mipspmu_disable(struct pmu *pmu)
 
 static atomic_t active_events = ATOMIC_INIT(0);
 static DEFINE_MUTEX(pmu_reserve_mutex);
-static int (*save_perf_irq)(void);
 
 static int mipspmu_get_irq(void)
 {
 	int err;
 
-	if (mipspmu.irq >= 0) {
-		/* Request my own irq handler. */
-		err = request_irq(mipspmu.irq, mipsxx_pmu_handle_irq,
-				  IRQF_PERCPU | IRQF_NOBALANCING |
-				  IRQF_NO_THREAD | IRQF_NO_SUSPEND |
-				  IRQF_SHARED,
-				  "mips_perf_pmu", &mipspmu);
-		if (err) {
-			pr_warn("Unable to request IRQ%d for MIPS performance counters!\n",
-				mipspmu.irq);
-		}
-	} else if (cp0_perfcount_irq < 0) {
-		/*
-		 * We are sharing the irq number with the timer interrupt.
-		 */
-		save_perf_irq = perf_irq;
-		perf_irq = mipsxx_pmu_handle_shared_irq;
-		err = 0;
-	} else {
-		pr_warn("The platform hasn't properly defined its interrupt controller\n");
-		err = -ENOENT;
-	}
-
+	err = request_irq(mipspmu.irq, mipsxx_pmu_handle_irq,
+			  IRQF_PERCPU | IRQF_NOBALANCING |
+			  IRQF_NO_THREAD | IRQF_NO_SUSPEND |
+			  IRQF_SHARED,
+			  "mips_perf_pmu", &mipspmu);
+	if (err)
+		pr_warn("Unable to request IRQ%d for MIPS performance counters!\n",
+			mipspmu.irq);
 	return err;
 }
 
 static void mipspmu_free_irq(void)
 {
-	if (mipspmu.irq >= 0)
-		free_irq(mipspmu.irq, &mipspmu);
-	else if (cp0_perfcount_irq < 0)
-		perf_irq = save_perf_irq;
+	free_irq(mipspmu.irq, &mipspmu);
 }
 
 /*
@@ -1403,13 +1383,13 @@ static void resume_local_counters(void)
 	} while (ctr > 0);
 }
 
-static int mipsxx_pmu_handle_shared_irq(void)
+static irqreturn_t mipsxx_pmu_handle_irq(int irq, void *dev)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_sample_data data;
 	unsigned int counters = mipspmu.num_counters;
 	u64 counter;
-	int handled = IRQ_NONE;
+	irqreturn_t handled = IRQ_NONE;
 	struct pt_regs *regs;
 
 	if (cpu_has_perf_cntr_intr_bit && !(read_c0_cause() & CAUSEF_PCI))
@@ -1462,11 +1442,6 @@ static int mipsxx_pmu_handle_shared_irq(void)
 	return handled;
 }
 
-static irqreturn_t mipsxx_pmu_handle_irq(int irq, void *dev)
-{
-	return mipsxx_pmu_handle_shared_irq();
-}
-
 /* 24K */
 #define IS_BOTH_COUNTERS_24K_EVENT(b)					\
 	((b) == 0 || (b) == 1 || (b) == 11)
@@ -1736,6 +1711,11 @@ init_hw_perf_events(void)
 	else
 		irq = -1;
 
+	if (irq < 0) {
+		pr_warn("The platform hasn't properly defined its interrupt controller\n");
+		return -ENOENT;
+	}
+
 	mipspmu.map_raw_event = mipsxx_pmu_map_raw_event;
 
 	switch (current_cpu_type()) {
@@ -1850,9 +1830,8 @@ init_hw_perf_events(void)
 
 	on_each_cpu(reset_counters, (void *)(long)counters, 1);
 
-	pr_cont("%s PMU enabled, %d %d-bit counters available to each "
-		"CPU, irq %d%s\n", mipspmu.name, counters, counter_bits, irq,
-		irq < 0 ? " (share with timer interrupt)" : "");
+	pr_cont("%s PMU enabled, %d %d-bit counters available to each CPU, irq %d",
+		mipspmu.name, counters, counter_bits, irq);
 
 	perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
 
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 5669d3b8bd38..0fe19103e882 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2227,7 +2227,7 @@ void per_cpu_trap_init(bool is_boot_cpu)
 	} else {
 		cp0_compare_irq = CP0_LEGACY_COMPARE_IRQ;
 		cp0_compare_irq_shift = CP0_LEGACY_PERFCNT_IRQ;
-		cp0_perfcount_irq = -1;
+		cp0_perfcount_irq = cp0_compare_irq;
 		cp0_fdc_irq = -1;
 	}
 
diff --git a/arch/mips/oprofile/op_model_loongson3.c b/arch/mips/oprofile/op_model_loongson3.c
index 436b1fc99f2c..e6954ebff4a1 100644
--- a/arch/mips/oprofile/op_model_loongson3.c
+++ b/arch/mips/oprofile/op_model_loongson3.c
@@ -40,8 +40,6 @@
 #define read_c0_perfhi2() __read_64bit_c0_register($25, 3)
 #define write_c0_perfhi2(val) __write_64bit_c0_register($25, 3, val)
 
-static int (*save_perf_irq)(void);
-
 static struct loongson3_register_config {
 	unsigned int control1;
 	unsigned int control2;
@@ -130,12 +128,13 @@ static void loongson3_cpu_stop(void *args)
 	memset(&reg, 0, sizeof(reg));
 }
 
-static int loongson3_perfcount_handler(void)
+static irqreturn_t loongson3_perfcount_handler(int irq, void *dev_id)
 {
 	unsigned long flags;
 	uint64_t counter1, counter2;
-	uint32_t cause, handled = IRQ_NONE;
+	uint32_t cause;
 	struct pt_regs *regs = get_irq_regs();
+	irqreturn_t handled = IRQ_NONE;
 
 	cause = read_c0_cause();
 	if (!(cause & CAUSEF_PCI))
@@ -182,32 +181,34 @@ static int loongson3_dying_cpu(unsigned int cpu)
 	return 0;
 }
 
+struct op_mips_model op_model_loongson3_ops = {
+	.reg_setup	= loongson3_reg_setup,
+	.cpu_setup	= loongson3_cpu_setup,
+	.init		= loongson3_init,
+	.exit		= loongson3_exit,
+	.cpu_start	= loongson3_cpu_start,
+	.cpu_stop	= loongson3_cpu_stop,
+	.cpu_type	= "mips/loongson3",
+	.num_counters	= 2
+};
+
 static int __init loongson3_init(void)
 {
 	on_each_cpu(reset_counters, NULL, 1);
 	cpuhp_setup_state_nocalls(CPUHP_AP_MIPS_OP_LOONGSON3_STARTING,
 				  "mips/oprofile/loongson3:starting",
 				  loongson3_starting_cpu, loongson3_dying_cpu);
-	save_perf_irq = perf_irq;
-	perf_irq = loongson3_perfcount_handler;
 
-	return 0;
+	return request_irq(cp0_compare_irq, loongson3_perfcount_handler,
+			   IRQF_PERCPU | IRQF_NOBALANCING |
+			   IRQF_NO_THREAD | IRQF_NO_SUSPEND |
+			   IRQF_SHARED,
+			   "Perfcounter", &op_model_loongson3_ops);
 }
 
 static void loongson3_exit(void)
 {
+	free_irq(cp0_compare_irq, &op_model_loongson3_ops);
 	on_each_cpu(reset_counters, NULL, 1);
 	cpuhp_remove_state_nocalls(CPUHP_AP_MIPS_OP_LOONGSON3_STARTING);
-	perf_irq = save_perf_irq;
 }
-
-struct op_mips_model op_model_loongson3_ops = {
-	.reg_setup	= loongson3_reg_setup,
-	.cpu_setup	= loongson3_cpu_setup,
-	.init		= loongson3_init,
-	.exit		= loongson3_exit,
-	.cpu_start	= loongson3_cpu_start,
-	.cpu_stop	= loongson3_cpu_stop,
-	.cpu_type	= "mips/loongson3",
-	.num_counters	= 2
-};
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index c3e4c18ef8d4..09cbb226c7da 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -21,7 +21,6 @@
 
 #define M_COUNTER_OVERFLOW		(1UL	  << 31)
 
-static int (*save_perf_irq)(void);
 static int perfcount_irq;
 
 /*
@@ -423,9 +422,6 @@ static int __init mipsxx_init(void)
 		return -ENODEV;
 	}
 
-	save_perf_irq = perf_irq;
-	perf_irq = mipsxx_perfcount_handler;
-
 	if (get_c0_perfcount_int)
 		perfcount_irq = get_c0_perfcount_int();
 	else if (cp0_perfcount_irq >= 0)
@@ -438,7 +434,7 @@ static int __init mipsxx_init(void)
 				   IRQF_PERCPU | IRQF_NOBALANCING |
 				   IRQF_NO_THREAD | IRQF_NO_SUSPEND |
 				   IRQF_SHARED,
-				   "Perfcounter", save_perf_irq);
+				   "Perfcounter", &op_model_mipsxx_ops);
 
 	return 0;
 }
@@ -448,12 +444,10 @@ static void mipsxx_exit(void)
 	int counters = op_model_mipsxx_ops.num_counters;
 
 	if (perfcount_irq >= 0)
-		free_irq(perfcount_irq, save_perf_irq);
+		free_irq(perfcount_irq, &op_model_mipsxx_ops);
 
 	counters = counters_per_cpu_to_total(counters);
 	on_each_cpu(reset_counters, (void *)(long)counters, 1);
-
-	perf_irq = save_perf_irq;
 }
 
 struct op_mips_model op_model_mipsxx_ops = {
-- 
2.14.1
