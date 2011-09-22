Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Sep 2011 19:32:30 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:6286 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491921Ab1IVRcV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Sep 2011 19:32:21 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e7b716c0000>; Thu, 22 Sep 2011 10:33:32 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 22 Sep 2011 10:32:17 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 22 Sep 2011 10:32:17 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id p8MHWA72007521;
        Thu, 22 Sep 2011 10:32:10 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p8MHW9t9007511;
        Thu, 22 Sep 2011 10:32:09 -0700
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v5 2/5] MIPS: perf: Cleanup formatting in arch/mips/kernel/perf_event.c
Date:   Thu, 22 Sep 2011 10:32:07 -0700
Message-Id: <1316712727-7478-1-git-send-email-david.daney@cavium.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1316712378-7282-1-git-send-email-david.daney@cavium.com>
References: <1316712378-7282-1-git-send-email-david.daney@cavium.com>
X-OriginalArrivalTime: 22 Sep 2011 17:32:17.0695 (UTC) FILETIME=[934272F0:01CC794D]
X-archive-position: 31135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12730

Get rid of a bunch of useless inline declarations, and join a bunch of
improperly split lines.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/kernel/perf_event.c        |   26 +++++-------
 arch/mips/kernel/perf_event_mipsxx.c |   68 +++++++++++++---------------------
 2 files changed, 37 insertions(+), 57 deletions(-)

diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
index 0aee944..f3d6e99 100644
--- a/arch/mips/kernel/perf_event.c
+++ b/arch/mips/kernel/perf_event.c
@@ -118,10 +118,9 @@ struct mips_pmu {
 
 static const struct mips_pmu *mipspmu;
 
-static int
-mipspmu_event_set_period(struct perf_event *event,
-			struct hw_perf_event *hwc,
-			int idx)
+static int mipspmu_event_set_period(struct perf_event *event,
+				    struct hw_perf_event *hwc,
+				    int idx)
 {
 	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
 	s64 left = local64_read(&hwc->period_left);
@@ -162,8 +161,8 @@ mipspmu_event_set_period(struct perf_event *event,
 }
 
 static void mipspmu_event_update(struct perf_event *event,
-			struct hw_perf_event *hwc,
-			int idx)
+				 struct hw_perf_event *hwc,
+				 int idx)
 {
 	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
 	unsigned long flags;
@@ -420,8 +419,7 @@ static struct pmu pmu = {
 	.read		= mipspmu_read,
 };
 
-static inline unsigned int
-mipspmu_perf_event_encode(const struct mips_perf_event *pev)
+static unsigned int mipspmu_perf_event_encode(const struct mips_perf_event *pev)
 {
 /*
  * Top 8 bits for range, next 16 bits for cntr_mask, lowest 8 bits for
@@ -437,8 +435,7 @@ mipspmu_perf_event_encode(const struct mips_perf_event *pev)
 #endif
 }
 
-static const struct mips_perf_event *
-mipspmu_map_general_event(int idx)
+static const struct mips_perf_event *mipspmu_map_general_event(int idx)
 {
 	const struct mips_perf_event *pev;
 
@@ -449,8 +446,7 @@ mipspmu_map_general_event(int idx)
 	return pev;
 }
 
-static const struct mips_perf_event *
-mipspmu_map_cache_event(u64 config)
+static const struct mips_perf_event *mipspmu_map_cache_event(u64 config)
 {
 	unsigned int cache_type, cache_op, cache_result;
 	const struct mips_perf_event *pev;
@@ -513,9 +509,9 @@ static int validate_group(struct perf_event *event)
 }
 
 /* This is needed by specific irq handlers in perf_event_*.c */
-static void
-handle_associated_event(struct cpu_hw_events *cpuc,
-	int idx, struct perf_sample_data *data, struct pt_regs *regs)
+static void handle_associated_event(struct cpu_hw_events *cpuc,
+				    int idx, struct perf_sample_data *data,
+				    struct pt_regs *regs)
 {
 	struct perf_event *event = cpuc->events[idx];
 	struct hw_perf_event *hwc = &event->hw;
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index e5ad09a..a5925b5 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -49,37 +49,32 @@ static int cpu_has_mipsmt_pertccounters;
 #endif
 
 /* Copied from op_model_mipsxx.c */
-static inline unsigned int vpe_shift(void)
+static unsigned int vpe_shift(void)
 {
 	if (num_possible_cpus() > 1)
 		return 1;
 
 	return 0;
 }
-#else /* !CONFIG_MIPS_MT_SMP */
-#define vpe_id()	0
-
-static inline unsigned int vpe_shift(void)
-{
-	return 0;
-}
-#endif /* CONFIG_MIPS_MT_SMP */
 
-static inline unsigned int
-counters_total_to_per_cpu(unsigned int counters)
+static unsigned int counters_total_to_per_cpu(unsigned int counters)
 {
 	return counters >> vpe_shift();
 }
 
-static inline unsigned int
-counters_per_cpu_to_total(unsigned int counters)
+static unsigned int counters_per_cpu_to_total(unsigned int counters)
 {
 	return counters << vpe_shift();
 }
 
+#else /* !CONFIG_MIPS_MT_SMP */
+#define vpe_id()	0
+
+#endif /* CONFIG_MIPS_MT_SMP */
+
 #define __define_perf_accessors(r, n, np)				\
 									\
-static inline unsigned int r_c0_ ## r ## n(void)			\
+static unsigned int r_c0_ ## r ## n(void)				\
 {									\
 	unsigned int cpu = vpe_id();					\
 									\
@@ -94,7 +89,7 @@ static inline unsigned int r_c0_ ## r ## n(void)			\
 	return 0;							\
 }									\
 									\
-static inline void w_c0_ ## r ## n(unsigned int value)			\
+static void w_c0_ ## r ## n(unsigned int value)				\
 {									\
 	unsigned int cpu = vpe_id();					\
 									\
@@ -121,7 +116,7 @@ __define_perf_accessors(perfctrl, 1, 3)
 __define_perf_accessors(perfctrl, 2, 0)
 __define_perf_accessors(perfctrl, 3, 1)
 
-static inline int __n_counters(void)
+static int __n_counters(void)
 {
 	if (!(read_c0_config1() & M_CONFIG1_PC))
 		return 0;
@@ -135,7 +130,7 @@ static inline int __n_counters(void)
 	return 4;
 }
 
-static inline int n_counters(void)
+static int n_counters(void)
 {
 	int counters;
 
@@ -175,8 +170,7 @@ static void reset_counters(void *arg)
 	}
 }
 
-static inline u64
-mipsxx_pmu_read_counter(unsigned int idx)
+static u64 mipsxx_pmu_read_counter(unsigned int idx)
 {
 	switch (idx) {
 	case 0:
@@ -193,8 +187,7 @@ mipsxx_pmu_read_counter(unsigned int idx)
 	}
 }
 
-static inline void
-mipsxx_pmu_write_counter(unsigned int idx, u64 val)
+static void mipsxx_pmu_write_counter(unsigned int idx, u64 val)
 {
 	switch (idx) {
 	case 0:
@@ -212,8 +205,7 @@ mipsxx_pmu_write_counter(unsigned int idx, u64 val)
 	}
 }
 
-static inline unsigned int
-mipsxx_pmu_read_control(unsigned int idx)
+static unsigned int mipsxx_pmu_read_control(unsigned int idx)
 {
 	switch (idx) {
 	case 0:
@@ -230,8 +222,7 @@ mipsxx_pmu_read_control(unsigned int idx)
 	}
 }
 
-static inline void
-mipsxx_pmu_write_control(unsigned int idx, unsigned int val)
+static void mipsxx_pmu_write_control(unsigned int idx, unsigned int val)
 {
 	switch (idx) {
 	case 0:
@@ -511,9 +502,8 @@ static const struct mips_perf_event mipsxx74Kcore_cache_map
 };
 
 #ifdef CONFIG_MIPS_MT_SMP
-static void
-check_and_calc_range(struct perf_event *event,
-			const struct mips_perf_event *pev)
+static void check_and_calc_range(struct perf_event *event,
+				 const struct mips_perf_event *pev)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
@@ -536,9 +526,8 @@ check_and_calc_range(struct perf_event *event,
 		hwc->config_base |= M_TC_EN_ALL;
 }
 #else
-static void
-check_and_calc_range(struct perf_event *event,
-			const struct mips_perf_event *pev)
+static void check_and_calc_range(struct perf_event *event,
+				 const struct mips_perf_event *pev)
 {
 }
 #endif
@@ -733,8 +722,7 @@ static int mipsxx_pmu_handle_shared_irq(void)
 	return handled;
 }
 
-static irqreturn_t
-mipsxx_pmu_handle_irq(int irq, void *dev)
+static irqreturn_t mipsxx_pmu_handle_irq(int irq, void *dev)
 {
 	return mipsxx_pmu_handle_shared_irq();
 }
@@ -766,9 +754,8 @@ static void mipsxx_pmu_stop(void)
 #endif
 }
 
-static int
-mipsxx_pmu_alloc_counter(struct cpu_hw_events *cpuc,
-			struct hw_perf_event *hwc)
+static int mipsxx_pmu_alloc_counter(struct cpu_hw_events *cpuc,
+				    struct hw_perf_event *hwc)
 {
 	int i;
 
@@ -797,8 +784,7 @@ mipsxx_pmu_alloc_counter(struct cpu_hw_events *cpuc,
 	return -EAGAIN;
 }
 
-static void
-mipsxx_pmu_enable_event(struct hw_perf_event *evt, int idx)
+static void mipsxx_pmu_enable_event(struct hw_perf_event *evt, int idx)
 {
 	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
 	unsigned long flags;
@@ -816,8 +802,7 @@ mipsxx_pmu_enable_event(struct hw_perf_event *evt, int idx)
 	local_irq_restore(flags);
 }
 
-static void
-mipsxx_pmu_disable_event(int idx)
+static void mipsxx_pmu_disable_event(int idx)
 {
 	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
 	unsigned long flags;
@@ -892,8 +877,7 @@ mipsxx_pmu_disable_event(int idx)
  * then 128 needs to be added to 15 as the input for the event config,
  * i.e., 143 (0x8F) to be used.
  */
-static const struct mips_perf_event *
-mipsxx_pmu_map_raw_event(u64 config)
+static const struct mips_perf_event *mipsxx_pmu_map_raw_event(u64 config)
 {
 	unsigned int raw_id = config & 0xff;
 	unsigned int base_id = raw_id & 0x7f;
-- 
1.7.2.3
