Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jun 2010 06:38:06 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:54698 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491094Ab0FIEfb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jun 2010 06:35:31 +0200
Received: by mail-px0-f177.google.com with SMTP id 1so2293665pxi.36
        for <multiple recipients>; Tue, 08 Jun 2010 21:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=MhyYz0uAPkCLtplTaO4LWd9bnvJUhEYCeXf1cbiZ2Uo=;
        b=JAxlB+8FWywwCPEYwUB7SXipFzZkxRgtUanCVqKcKdYNo05jqw3Que70fSm6nawqhJ
         TFfEIhNg2t0wNUVQJ0onQvEmeN8g7a8KLQxHIpvweLMas2uC+00x7gXSJ9pMyStAgXN0
         xgWlth3c71i0fZ+JD7reH+J1LpPgwrBEqSTQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BTJsN5AlQutdYcIADGrQq9UmXLhw7G/bGOycvOVJVnQs1J7uoNM8tnY6Hl90Mp/9J7
         gWFdCjxaNxdWpT6E0FM5WU2u+NToYVo4P+9vEvIqF4Bc7AV1gaowMZABEu23ooPc2jdO
         jE/bXMj4mu0DrIvdLKdivEynUKpBPXxdHL0Eo=
Received: by 10.142.60.5 with SMTP id i5mr12713489wfa.244.1276058130374;
        Tue, 08 Jun 2010 21:35:30 -0700 (PDT)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id 22sm4483464pzk.9.2010.06.08.21.35.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jun 2010 21:35:30 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v6 6/7] MIPS: add support for hardware performance events (mipsxx)
Date:   Wed,  9 Jun 2010 12:35:29 +0800
Message-Id: <1276058130-25851-7-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1276058130-25851-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1276058130-25851-1-git-send-email-dengcheng.zhu@gmail.com>
X-archive-position: 27098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6110

This patch adds the mipsxx Perf-event support based on the skeleton.
Generic hardware events and cache events are now fully implemented for
the 24K/34K/74K/1004K cores. To support other cores in mipsxx (such as
R10000/SB1), the generic hardware event tables and cache event tables
need to be filled out. To support other CPUs which have different PMU
than mipsxx, such as RM9000 and LOONGSON2, the additional files
perf_event_$cpu.c need to be created.

Raw event is an important part of Perf-events. It helps the user collect
performance data for events that are not listed as the generic hardware
events and cache events but ARE supported by the CPU's PMU.

This patch also adds this feature for mipsxx 24K/34K/74K/1004K. For how to
use it, please refer to processor core software user's manual and the
comments for mipsxx_pmu_map_raw_event() for more details.

Please note that this is a "precise" implementation, which means the
kernel will check whether the requested raw events are supported by this
CPU and which hardware counters can be assigned for them.

To test the functionality of Perf-event, you may want to compile the tool
"perf" for your MIPS platform. You can refer to the following URL:
http://www.linux-mips.org/archives/linux-mips/2010-04/msg00158.html

Please note: Before that patch is accepted, you can choose a "specific"
rmb() which is suitable for your platform -- an example is provided in
the description of that patch.

You also need to customize the CFLAGS and LDFLAGS in tools/perf/Makefile
for your libs, includes, etc.

In case you encounter the boot failure in SMVP kernel on multi-threading
CPUs, you may take a look at:
http://www.linux-mips.org/git?p=linux-mti.git;a=commitdiff;h=5460815027d802697b879644c74f0e8365254020

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/include/asm/pmu.h          |   87 ++++
 arch/mips/kernel/perf_event.c        |    7 +
 arch/mips/kernel/perf_event_mipsxx.c |  802 ++++++++++++++++++++++++++++++++++
 3 files changed, 896 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/kernel/perf_event_mipsxx.c

diff --git a/arch/mips/include/asm/pmu.h b/arch/mips/include/asm/pmu.h
index c84d70c..be057ca 100644
--- a/arch/mips/include/asm/pmu.h
+++ b/arch/mips/include/asm/pmu.h
@@ -41,6 +41,19 @@
 #define M_PERFCTL_WIDE			(1UL      << 30)
 #define M_PERFCTL_MORE			(1UL      << 31)
 
+#define M_PERFCTL_COUNT_EVENT_WHENEVER	(M_PERFCTL_EXL |		\
+					M_PERFCTL_KERNEL |		\
+					M_PERFCTL_USER |		\
+					M_PERFCTL_SUPERVISOR |		\
+					M_PERFCTL_INTERRUPT_ENABLE)
+
+#ifdef CONFIG_MIPS_MT_SMP
+#define M_PERFCTL_CONFIG_MASK		0x3fff801f
+#else
+#define M_PERFCTL_CONFIG_MASK		0x1f
+#endif
+#define M_PERFCTL_EVENT_MASK		0xfe0
+
 #define M_COUNTER_OVERFLOW		(1UL      << 31)
 
 #ifdef CONFIG_MIPS_MT_SMP
@@ -174,6 +187,80 @@ static inline int n_counters(void)
 	return counters;
 }
 
+static inline u64
+mipsxx_pmu_read_counter(unsigned int idx)
+{
+	switch (idx) {
+	case 0:
+		return r_c0_perfcntr0();
+	case 1:
+		return r_c0_perfcntr1();
+	case 2:
+		return r_c0_perfcntr2();
+	case 3:
+		return r_c0_perfcntr3();
+	default:
+		WARN_ONCE(1, "Invalid performance counter number (%d)\n", idx);
+		return 0;
+	}
+}
+
+static inline void
+mipsxx_pmu_write_counter(unsigned int idx, u64 val)
+{
+	switch (idx) {
+	case 0:
+		w_c0_perfcntr0(val);
+		return;
+	case 1:
+		w_c0_perfcntr1(val);
+		return;
+	case 2:
+		w_c0_perfcntr2(val);
+		return;
+	case 3:
+		w_c0_perfcntr3(val);
+		return;
+	}
+}
+
+static inline unsigned int
+mipsxx_pmu_read_control(unsigned int idx)
+{
+	switch (idx) {
+	case 0:
+		return r_c0_perfctrl0();
+	case 1:
+		return r_c0_perfctrl1();
+	case 2:
+		return r_c0_perfctrl2();
+	case 3:
+		return r_c0_perfctrl3();
+	default:
+		WARN_ONCE(1, "Invalid performance counter number (%d)\n", idx);
+		return 0;
+	}
+}
+
+static inline void
+mipsxx_pmu_write_control(unsigned int idx, unsigned int val)
+{
+	switch (idx) {
+	case 0:
+		w_c0_perfctrl0(val);
+		return;
+	case 1:
+		w_c0_perfctrl1(val);
+		return;
+	case 2:
+		w_c0_perfctrl2(val);
+		return;
+	case 3:
+		w_c0_perfctrl3(val);
+		return;
+	}
+}
+
 /* rm9000 */
 #define RM9K_COUNTER1_EVENT(event)	((event) << 0)
 #define RM9K_COUNTER1_SUPERVISOR	(1ULL    <<  7)
diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
index 7e371ae..fb7a040 100644
--- a/arch/mips/kernel/perf_event.c
+++ b/arch/mips/kernel/perf_event.c
@@ -87,6 +87,9 @@ struct mips_perf_event {
 #endif
 };
 
+static struct mips_perf_event raw_event;
+static DEFINE_MUTEX(raw_event_mutex);
+
 #define UNSUPPORTED_PERF_EVENT_ID 0xffffffff
 #define C(x) PERF_COUNT_HW_CACHE_##x
 
@@ -102,6 +105,7 @@ struct mips_pmu {
 	void		(*write_counter)(unsigned int idx, u64 val);
 	void		(*enable_event)(struct hw_perf_event *evt, int idx);
 	void		(*disable_event)(int idx);
+	const struct mips_perf_event *(*map_raw_event)(u64 config);
 	const struct mips_perf_event (*general_event_map)[PERF_COUNT_HW_MAX];
 	const struct mips_perf_event (*cache_event_map)
 				[PERF_COUNT_HW_CACHE_MAX]
@@ -430,6 +434,7 @@ static int validate_group(struct perf_event *event)
  * mipsxx/rm9000/loongson2 have different performance counters, they have
  * specific low-level init routines.
  */
+static void reset_counters(void *arg);
 static int __hw_perf_event_init(struct perf_event *event);
 
 static void hw_perf_event_destroy(struct perf_event *event)
@@ -509,6 +514,8 @@ handle_associated_event(struct cpu_hw_events *cpuc,
 		mipspmu->disable_event(idx);
 }
 
+#include "perf_event_mipsxx.c"
+
 /* Callchain handling code. */
 static inline void
 callchain_store(struct perf_callchain_entry *entry,
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
new file mode 100644
index 0000000..135eae0
--- /dev/null
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -0,0 +1,802 @@
+#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64) || \
+    defined(CONFIG_CPU_R10000) || defined(CONFIG_CPU_SB1)
+
+#ifdef CONFIG_MIPS_MT_SMP
+static DEFINE_RWLOCK(pmuint_rwlock);
+#endif
+
+/* 24K/34K/1004K cores can share the same event map. */
+static const struct mips_perf_event mipsxxcore_event_map
+				[PERF_COUNT_HW_MAX] = {
+	[PERF_COUNT_HW_CPU_CYCLES] = { 0x00, CNTR_EVEN | CNTR_ODD, P },
+	[PERF_COUNT_HW_INSTRUCTIONS] = { 0x01, CNTR_EVEN | CNTR_ODD, T },
+	[PERF_COUNT_HW_CACHE_REFERENCES] = { UNSUPPORTED_PERF_EVENT_ID },
+	[PERF_COUNT_HW_CACHE_MISSES] = { UNSUPPORTED_PERF_EVENT_ID },
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = { 0x02, CNTR_EVEN, T },
+	[PERF_COUNT_HW_BRANCH_MISSES] = { 0x02, CNTR_ODD, T },
+	[PERF_COUNT_HW_BUS_CYCLES] = { UNSUPPORTED_PERF_EVENT_ID },
+};
+
+/* 74K core has different branch event code. */
+static const struct mips_perf_event mipsxx74Kcore_event_map
+				[PERF_COUNT_HW_MAX] = {
+	[PERF_COUNT_HW_CPU_CYCLES] = { 0x00, CNTR_EVEN | CNTR_ODD, P },
+	[PERF_COUNT_HW_INSTRUCTIONS] = { 0x01, CNTR_EVEN | CNTR_ODD, T },
+	[PERF_COUNT_HW_CACHE_REFERENCES] = { UNSUPPORTED_PERF_EVENT_ID },
+	[PERF_COUNT_HW_CACHE_MISSES] = { UNSUPPORTED_PERF_EVENT_ID },
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = { 0x27, CNTR_EVEN, T },
+	[PERF_COUNT_HW_BRANCH_MISSES] = { 0x27, CNTR_ODD, T },
+	[PERF_COUNT_HW_BUS_CYCLES] = { UNSUPPORTED_PERF_EVENT_ID },
+};
+
+/* 24K/34K/1004K cores can share the same cache event map. */
+static const struct mips_perf_event mipsxxcore_cache_map
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+[C(L1D)] = {
+	/*
+	 * Like some other architectures (e.g. ARM), the performance
+	 * counters don't differentiate between read and write
+	 * accesses/misses, so this isn't strictly correct, but it's the
+	 * best we can do. Writes and reads get combined.
+	 */
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x0a, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x0b, CNTR_EVEN | CNTR_ODD, T },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x0a, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x0b, CNTR_EVEN | CNTR_ODD, T },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(L1I)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x09, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x09, CNTR_ODD, T },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x09, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x09, CNTR_ODD, T },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { 0x14, CNTR_EVEN, T },
+		/*
+		 * Note that MIPS has only "hit" events countable for
+		 * the prefetch operation.
+		 */
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(LL)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x15, CNTR_ODD, P },
+		[C(RESULT_MISS)]	= { 0x16, CNTR_EVEN, P },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x15, CNTR_ODD, P },
+		[C(RESULT_MISS)]	= { 0x16, CNTR_EVEN, P },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(DTLB)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x06, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x06, CNTR_ODD, T },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x06, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x06, CNTR_ODD, T },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(ITLB)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x05, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x05, CNTR_ODD, T },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x05, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x05, CNTR_ODD, T },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(BPU)] = {
+	/* Using the same code for *HW_BRANCH* */
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x02, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x02, CNTR_ODD, T },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x02, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x02, CNTR_ODD, T },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+};
+
+/* 74K core has completely different cache event map. */
+static const struct mips_perf_event mipsxx74Kcore_cache_map
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+[C(L1D)] = {
+	/*
+	 * Like some other architectures (e.g. ARM), the performance
+	 * counters don't differentiate between read and write
+	 * accesses/misses, so this isn't strictly correct, but it's the
+	 * best we can do. Writes and reads get combined.
+	 */
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x17, CNTR_ODD, T },
+		[C(RESULT_MISS)]	= { 0x18, CNTR_ODD, T },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x17, CNTR_ODD, T },
+		[C(RESULT_MISS)]	= { 0x18, CNTR_ODD, T },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(L1I)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x06, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x06, CNTR_ODD, T },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x06, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x06, CNTR_ODD, T },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { 0x34, CNTR_EVEN, T },
+		/*
+		 * Note that MIPS has only "hit" events countable for
+		 * the prefetch operation.
+		 */
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(LL)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x1c, CNTR_ODD, P },
+		[C(RESULT_MISS)]	= { 0x1d, CNTR_EVEN | CNTR_ODD, P },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x1c, CNTR_ODD, P },
+		[C(RESULT_MISS)]	= { 0x1d, CNTR_EVEN | CNTR_ODD, P },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(DTLB)] = {
+	/* 74K core does not have specific DTLB events. */
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(ITLB)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x04, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x04, CNTR_ODD, T },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x04, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x04, CNTR_ODD, T },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(BPU)] = {
+	/* Using the same code for *HW_BRANCH* */
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x27, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x27, CNTR_ODD, T },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x27, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x27, CNTR_ODD, T },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+};
+
+#ifdef CONFIG_MIPS_MT_SMP
+static void
+check_and_calc_range(struct perf_event *event,
+			const struct mips_perf_event *pev)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (event->cpu >= 0) {
+		if (pev->range > V) {
+			/*
+			 * The user selected an event that is processor
+			 * wide, while expecting it to be VPE wide.
+			 */
+			hwc->config_base |= M_TC_EN_ALL;
+		} else {
+			/*
+			 * FIXME: cpu_data[event->cpu].vpe_id reports 0
+			 * for both CPUs.
+			 */
+			hwc->config_base |= M_PERFCTL_VPEID(event->cpu);
+			hwc->config_base |= M_TC_EN_VPE;
+		}
+	} else
+		hwc->config_base |= M_TC_EN_ALL;
+}
+#else
+static void
+check_and_calc_range(struct perf_event *event,
+			const struct mips_perf_event *pev)
+{
+}
+#endif
+
+static int __hw_perf_event_init(struct perf_event *event)
+{
+	struct perf_event_attr *attr = &event->attr;
+	struct hw_perf_event *hwc = &event->hw;
+	const struct mips_perf_event *pev;
+	int err;
+
+	/* Returning MIPS event descriptor for generic perf event. */
+	if (PERF_TYPE_HARDWARE == event->attr.type) {
+		if (event->attr.config >= PERF_COUNT_HW_MAX)
+			return -EINVAL;
+		pev = mipspmu_map_general_event(event->attr.config);
+	} else if (PERF_TYPE_HW_CACHE == event->attr.type) {
+		pev = mipspmu_map_cache_event(event->attr.config);
+	} else if (PERF_TYPE_RAW == event->attr.type) {
+		/* We are working on the global raw event. */
+		mutex_lock(&raw_event_mutex);
+		pev = mipspmu->map_raw_event(event->attr.config);
+	} else {
+		/* The event type is not (yet) supported. */
+		return -EOPNOTSUPP;
+	}
+
+	if (IS_ERR(pev)) {
+		if (PERF_TYPE_RAW == event->attr.type)
+			mutex_unlock(&raw_event_mutex);
+		return PTR_ERR(pev);
+	}
+
+	/*
+	 * We allow max flexibility on how each individual counter shared
+	 * by the single CPU operates (the mode exclusion and the range).
+	 */
+	hwc->config_base = M_PERFCTL_INTERRUPT_ENABLE;
+
+	/* Calculate range bits and validate it. */
+	if (num_possible_cpus() > 1)
+		check_and_calc_range(event, pev);
+
+	hwc->event_base = mipspmu_perf_event_encode(pev);
+	if (PERF_TYPE_RAW == event->attr.type)
+		mutex_unlock(&raw_event_mutex);
+
+	if (!attr->exclude_user)
+		hwc->config_base |= M_PERFCTL_USER;
+	if (!attr->exclude_kernel) {
+		hwc->config_base |= M_PERFCTL_KERNEL;
+		/* MIPS kernel mode: KSU == 00b || EXL == 1 || ERL == 1 */
+		hwc->config_base |= M_PERFCTL_EXL;
+	}
+	if (!attr->exclude_hv)
+		hwc->config_base |= M_PERFCTL_SUPERVISOR;
+
+	hwc->config_base &= M_PERFCTL_CONFIG_MASK;
+	/*
+	 * The event can belong to another cpu. We do not assign a local
+	 * counter for it for now.
+	 */
+	hwc->idx = -1;
+	hwc->config = 0;
+
+	if (!hwc->sample_period) {
+		hwc->sample_period  = MAX_PERIOD;
+		hwc->last_period    = hwc->sample_period;
+		atomic64_set(&hwc->period_left, hwc->sample_period);
+	}
+
+	err = 0;
+	if (event->group_leader != event) {
+		err = validate_group(event);
+		if (err)
+			return -EINVAL;
+	}
+
+	event->destroy = hw_perf_event_destroy;
+
+	return err;
+}
+
+static void pause_local_counters(void)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	int counters = mipspmu->num_counters;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	switch (counters) {
+	case 4:
+		cpuc->saved_ctrl[3] = r_c0_perfctrl3();
+		w_c0_perfctrl3(cpuc->saved_ctrl[3] &
+			~M_PERFCTL_COUNT_EVENT_WHENEVER);
+	case 3:
+		cpuc->saved_ctrl[2] = r_c0_perfctrl2();
+		w_c0_perfctrl2(cpuc->saved_ctrl[2] &
+			~M_PERFCTL_COUNT_EVENT_WHENEVER);
+	case 2:
+		cpuc->saved_ctrl[1] = r_c0_perfctrl1();
+		w_c0_perfctrl1(cpuc->saved_ctrl[1] &
+			~M_PERFCTL_COUNT_EVENT_WHENEVER);
+	case 1:
+		cpuc->saved_ctrl[0] = r_c0_perfctrl0();
+		w_c0_perfctrl0(cpuc->saved_ctrl[0] &
+			~M_PERFCTL_COUNT_EVENT_WHENEVER);
+	}
+	local_irq_restore(flags);
+}
+
+static void resume_local_counters(void)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	int counters = mipspmu->num_counters;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	switch (counters) {
+	case 4:
+		w_c0_perfctrl3(cpuc->saved_ctrl[3]);
+	case 3:
+		w_c0_perfctrl2(cpuc->saved_ctrl[2]);
+	case 2:
+		w_c0_perfctrl1(cpuc->saved_ctrl[1]);
+	case 1:
+		w_c0_perfctrl0(cpuc->saved_ctrl[0]);
+	}
+	local_irq_restore(flags);
+}
+
+static int mipsxx_pmu_handle_shared_irq(void)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	struct perf_sample_data data;
+	unsigned int counters = mipspmu->num_counters;
+	unsigned int counter;
+	int handled = IRQ_NONE;
+	struct pt_regs *regs;
+
+	if (cpu_has_mips_r2 && !(read_c0_cause() & (1 << 26)))
+		return handled;
+
+	/*
+	 * First we pause the local counters, so that when we are locked
+	 * here, the counters are all paused. When it gets locked due to
+	 * perf_disable(), the timer interrupt handler will be delayed.
+	 *
+	 * See also mipsxx_pmu_start().
+	 */
+	pause_local_counters();
+#ifdef CONFIG_MIPS_MT_SMP
+	read_lock(&pmuint_rwlock);
+#endif
+
+	regs = get_irq_regs();
+
+	perf_sample_data_init(&data, 0);
+
+	switch (counters) {
+#define HANDLE_COUNTER(n)						\
+	case n + 1:							\
+		if (test_bit(n, cpuc->used_mask)) {			\
+			counter = r_c0_perfcntr ## n();			\
+			if (counter & M_COUNTER_OVERFLOW) {		\
+				w_c0_perfcntr ## n(counter &		\
+						VALID_COUNT);		\
+				if (test_and_change_bit(n, cpuc->msbs))	\
+					handle_associated_event(cpuc,	\
+						n, &data, regs);	\
+				handled = IRQ_HANDLED;			\
+			}						\
+		}
+	HANDLE_COUNTER(3)
+	HANDLE_COUNTER(2)
+	HANDLE_COUNTER(1)
+	HANDLE_COUNTER(0)
+	}
+
+	/*
+	 * Do all the work for the pending perf events. We can do this
+	 * in here because the performance counter interrupt is a regular
+	 * interrupt, not NMI.
+	 */
+	if (handled == IRQ_HANDLED)
+		perf_event_do_pending();
+
+#ifdef CONFIG_MIPS_MT_SMP
+	read_unlock(&pmuint_rwlock);
+#endif
+	resume_local_counters();
+	return handled;
+}
+
+static irqreturn_t
+mipsxx_pmu_handle_irq(int irq, void *dev)
+{
+	return mipsxx_pmu_handle_shared_irq();
+}
+
+static void mipsxx_pmu_start(void)
+{
+#ifdef CONFIG_MIPS_MT_SMP
+	write_unlock(&pmuint_rwlock);
+#endif
+	resume_local_counters();
+}
+
+/*
+ * MIPS performance counters can be per-TC. The control registers can
+ * not be directly accessed accross CPUs. Hence if we want to do global
+ * control, we need cross CPU calls. on_each_cpu() can help us, but we
+ * can not make sure this function is called with interrupts enabled. So
+ * here we pause local counters and then grab a rwlock and leave the
+ * counters on other CPUs alone. If any counter interrupt raises while
+ * we own the write lock, simply pause local counters on that CPU and
+ * spin in the handler. Also we know we won't be switched to another
+ * CPU after pausing local counters and before grabbing the lock.
+ */
+static void mipsxx_pmu_stop(void)
+{
+	pause_local_counters();
+#ifdef CONFIG_MIPS_MT_SMP
+	write_lock(&pmuint_rwlock);
+#endif
+}
+
+static int
+mipsxx_pmu_alloc_counter(struct cpu_hw_events *cpuc,
+			struct hw_perf_event *hwc)
+{
+	int i;
+
+	/*
+	 * We only need to care the counter mask. The range has been
+	 * checked definitely.
+	 */
+	unsigned long cntr_mask = (hwc->event_base >> 8) & 0xffff;
+
+	for (i = mipspmu->num_counters - 1; i >= 0; i--) {
+		/*
+		 * Note that some MIPS perf events can be counted by both
+		 * even and odd counters, wheresas many other are only by
+		 * even _or_ odd counters. This introduces an issue that
+		 * when the former kind of event takes the counter the
+		 * latter kind of event wants to use, then the "counter
+		 * allocation" for the latter event will fail. In fact if
+		 * they can be dynamically swapped, they both feel happy.
+		 * But here we leave this issue alone for now.
+		 */
+		if (test_bit(i, &cntr_mask) &&
+			!test_and_set_bit(i, cpuc->used_mask))
+			return i;
+	}
+
+	return -EAGAIN;
+}
+
+static void
+mipsxx_pmu_enable_event(struct hw_perf_event *evt, int idx)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	unsigned long flags;
+
+	WARN_ON(idx < 0 || idx >= mipspmu->num_counters);
+
+	local_irq_save(flags);
+	cpuc->saved_ctrl[idx] = M_PERFCTL_EVENT(evt->event_base & 0xff) |
+		(evt->config_base & M_PERFCTL_CONFIG_MASK) |
+		/* Make sure interrupt enabled. */
+		M_PERFCTL_INTERRUPT_ENABLE;
+	/*
+	 * We do not actually let the counter run. Leave it until start().
+	 */
+	local_irq_restore(flags);
+}
+
+static void
+mipsxx_pmu_disable_event(int idx)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	unsigned long flags;
+
+	WARN_ON(idx < 0 || idx >= mipspmu->num_counters);
+
+	local_irq_save(flags);
+	cpuc->saved_ctrl[idx] = mipsxx_pmu_read_control(idx) &
+		~M_PERFCTL_COUNT_EVENT_WHENEVER;
+	mipsxx_pmu_write_control(idx, cpuc->saved_ctrl[idx]);
+	local_irq_restore(flags);
+}
+
+/* 24K */
+#define IS_UNSUPPORTED_24K_EVENT(r, b)					\
+	((b) == 12 || (r) == 151 || (r) == 152 || (b) == 26 ||		\
+	 (b) == 27 || (r) == 28 || (r) == 158 || (b) == 31 ||		\
+	 (b) == 32 || (b) == 34 || (b) == 36 || (r) == 168 ||		\
+	 (r) == 172 || (b) == 47 || ((b) >= 56 && (b) <= 63) ||		\
+	 ((b) >= 68 && (b) <= 127))
+#define IS_BOTH_COUNTERS_24K_EVENT(b)					\
+	((b) == 0 || (b) == 1 || (b) == 11)
+
+/* 34K */
+#define IS_UNSUPPORTED_34K_EVENT(r, b)					\
+	((b) == 12 || (r) == 27 || (r) == 158 || (b) == 36 ||		\
+	 (b) == 38 || (r) == 175 || ((b) >= 56 && (b) <= 63) ||		\
+	 ((b) >= 68 && (b) <= 127))
+#define IS_BOTH_COUNTERS_34K_EVENT(b)					\
+	((b) == 0 || (b) == 1 || (b) == 11)
+#ifdef CONFIG_MIPS_MT_SMP
+#define IS_RANGE_P_34K_EVENT(r, b)					\
+	((b) == 0 || (r) == 18 || (b) == 21 || (b) == 22 ||		\
+	 (b) == 25 || (b) == 39 || (r) == 44 || (r) == 174 ||		\
+	 (r) == 176 || ((b) >= 50 && (b) <= 55) ||			\
+	 ((b) >= 64 && (b) <= 67))
+#define IS_RANGE_V_34K_EVENT(r)	((r) == 47)
+#endif
+
+/* 74K */
+#define IS_UNSUPPORTED_74K_EVENT(r, b)					\
+	((r) == 5 || ((r) >= 135 && (r) <= 137) ||			\
+	 ((b) >= 10 && (b) <= 12) || (b) == 22 || (b) == 27 ||		\
+	 (b) == 33 || (b) == 34 || ((b) >= 47 && (b) <= 49) ||		\
+	 (r) == 178 || (b) == 55 || (b) == 57 || (b) == 60 ||		\
+	 (b) == 61 || (r) == 62 || (r) == 191 ||			\
+	 ((b) >= 64 && (b) <= 127))
+#define IS_BOTH_COUNTERS_74K_EVENT(b)					\
+	((b) == 0 || (b) == 1)
+
+/* 1004K */
+#define IS_UNSUPPORTED_1004K_EVENT(r, b)				\
+	((b) == 12 || (r) == 27 || (r) == 158 || (b) == 38 ||		\
+	 (r) == 175 || (b) == 63 || ((b) >= 68 && (b) <= 127))
+#define IS_BOTH_COUNTERS_1004K_EVENT(b)					\
+	((b) == 0 || (b) == 1 || (b) == 11)
+#ifdef CONFIG_MIPS_MT_SMP
+#define IS_RANGE_P_1004K_EVENT(r, b)					\
+	((b) == 0 || (r) == 18 || (b) == 21 || (b) == 22 ||		\
+	 (b) == 25 || (b) == 36 || (b) == 39 || (r) == 44 ||		\
+	 (r) == 174 || (r) == 176 || ((b) >= 50 && (b) <= 59) ||	\
+	 (r) == 188 || (b) == 61 || (b) == 62 ||			\
+	 ((b) >= 64 && (b) <= 67))
+#define IS_RANGE_V_1004K_EVENT(r)	((r) == 47)
+#endif
+
+/*
+ * User can use 0-255 raw events, where 0-127 for the events of even
+ * counters, and 128-255 for odd counters. Note that bit 7 is used to
+ * indicate the parity. So, for example, when user wants to take the
+ * Event Num of 15 for odd counters (by referring to the user manual),
+ * then 128 needs to be added to 15 as the input for the event config,
+ * i.e., 143 (0x8F) to be used.
+ */
+static const struct mips_perf_event *
+mipsxx_pmu_map_raw_event(u64 config)
+{
+	unsigned int raw_id = config & 0xff;
+	unsigned int base_id = raw_id & 0x7f;
+
+	switch (current_cpu_type()) {
+	case CPU_24K:
+		if (IS_UNSUPPORTED_24K_EVENT(raw_id, base_id))
+			return ERR_PTR(-EOPNOTSUPP);
+		raw_event.event_id = base_id;
+		if (IS_BOTH_COUNTERS_24K_EVENT(base_id))
+			raw_event.cntr_mask = CNTR_EVEN | CNTR_ODD;
+		else
+			raw_event.cntr_mask =
+				raw_id > 127 ? CNTR_ODD : CNTR_EVEN;
+#ifdef CONFIG_MIPS_MT_SMP
+		/*
+		 * This is actually doing nothing. Non-multithreading
+		 * CPUs will not check and calculate the range.
+		 */
+		raw_event.range = P;
+#endif
+		break;
+	case CPU_34K:
+		if (IS_UNSUPPORTED_34K_EVENT(raw_id, base_id))
+			return ERR_PTR(-EOPNOTSUPP);
+		raw_event.event_id = base_id;
+		if (IS_BOTH_COUNTERS_34K_EVENT(base_id))
+			raw_event.cntr_mask = CNTR_EVEN | CNTR_ODD;
+		else
+			raw_event.cntr_mask =
+				raw_id > 127 ? CNTR_ODD : CNTR_EVEN;
+#ifdef CONFIG_MIPS_MT_SMP
+		if (IS_RANGE_P_34K_EVENT(raw_id, base_id))
+			raw_event.range = P;
+		else if (unlikely(IS_RANGE_V_34K_EVENT(raw_id)))
+			raw_event.range = V;
+		else
+			raw_event.range = T;
+#endif
+		break;
+	case CPU_74K:
+		if (IS_UNSUPPORTED_74K_EVENT(raw_id, base_id))
+			return ERR_PTR(-EOPNOTSUPP);
+		raw_event.event_id = base_id;
+		if (IS_BOTH_COUNTERS_74K_EVENT(base_id))
+			raw_event.cntr_mask = CNTR_EVEN | CNTR_ODD;
+		else
+			raw_event.cntr_mask =
+				raw_id > 127 ? CNTR_ODD : CNTR_EVEN;
+#ifdef CONFIG_MIPS_MT_SMP
+		raw_event.range = P;
+#endif
+		break;
+	case CPU_1004K:
+		if (IS_UNSUPPORTED_1004K_EVENT(raw_id, base_id))
+			return ERR_PTR(-EOPNOTSUPP);
+		raw_event.event_id = base_id;
+		if (IS_BOTH_COUNTERS_1004K_EVENT(base_id))
+			raw_event.cntr_mask = CNTR_EVEN | CNTR_ODD;
+		else
+			raw_event.cntr_mask =
+				raw_id > 127 ? CNTR_ODD : CNTR_EVEN;
+#ifdef CONFIG_MIPS_MT_SMP
+		if (IS_RANGE_P_1004K_EVENT(raw_id, base_id))
+			raw_event.range = P;
+		else if (unlikely(IS_RANGE_V_1004K_EVENT(raw_id)))
+			raw_event.range = V;
+		else
+			raw_event.range = T;
+#endif
+		break;
+	}
+
+	return &raw_event;
+}
+
+static struct mips_pmu mipsxxcore_pmu = {
+	.handle_irq = mipsxx_pmu_handle_irq,
+	.handle_shared_irq = mipsxx_pmu_handle_shared_irq,
+	.start = mipsxx_pmu_start,
+	.stop = mipsxx_pmu_stop,
+	.alloc_counter = mipsxx_pmu_alloc_counter,
+	.read_counter = mipsxx_pmu_read_counter,
+	.write_counter = mipsxx_pmu_write_counter,
+	.enable_event = mipsxx_pmu_enable_event,
+	.disable_event = mipsxx_pmu_disable_event,
+	.map_raw_event = mipsxx_pmu_map_raw_event,
+	.general_event_map = &mipsxxcore_event_map,
+	.cache_event_map = &mipsxxcore_cache_map,
+};
+
+static struct mips_pmu mipsxx74Kcore_pmu = {
+	.handle_irq = mipsxx_pmu_handle_irq,
+	.handle_shared_irq = mipsxx_pmu_handle_shared_irq,
+	.start = mipsxx_pmu_start,
+	.stop = mipsxx_pmu_stop,
+	.alloc_counter = mipsxx_pmu_alloc_counter,
+	.read_counter = mipsxx_pmu_read_counter,
+	.write_counter = mipsxx_pmu_write_counter,
+	.enable_event = mipsxx_pmu_enable_event,
+	.disable_event = mipsxx_pmu_disable_event,
+	.map_raw_event = mipsxx_pmu_map_raw_event,
+	.general_event_map = &mipsxx74Kcore_event_map,
+	.cache_event_map = &mipsxx74Kcore_cache_map,
+};
+
+static void reset_counters(void *arg)
+{
+	int counters = (int)(long)arg;
+	switch (counters) {
+	case 4:
+		w_c0_perfctrl3(0);
+		w_c0_perfcntr3(0);
+	case 3:
+		w_c0_perfctrl2(0);
+		w_c0_perfcntr2(0);
+	case 2:
+		w_c0_perfctrl1(0);
+		w_c0_perfcntr1(0);
+	case 1:
+		w_c0_perfctrl0(0);
+		w_c0_perfcntr0(0);
+	}
+}
+
+static int __init
+init_hw_perf_events(void)
+{
+	int counters;
+
+	pr_info("Performance counters: ");
+
+	counters = n_counters();
+	if (counters == 0) {
+		pr_cont("No available PMU.\n");
+		return -ENODEV;
+	}
+
+#ifdef CONFIG_MIPS_MT_SMP
+	cpu_has_mipsmt_pertccounters = read_c0_config7() & (1<<19);
+	if (!cpu_has_mipsmt_pertccounters)
+		counters = counters_total_to_per_cpu(counters);
+#endif
+
+	on_each_cpu(reset_counters, (void *)(long)counters, 1);
+
+	switch (current_cpu_type()) {
+	case CPU_24K:
+		mipsxxcore_pmu.name = "mips/24K";
+		mipsxxcore_pmu.num_counters = counters;
+		mipspmu = &mipsxxcore_pmu;
+		break;
+	case CPU_34K:
+		mipsxxcore_pmu.name = "mips/34K";
+		mipsxxcore_pmu.num_counters = counters;
+		mipspmu = &mipsxxcore_pmu;
+		break;
+	case CPU_74K:
+		mipsxx74Kcore_pmu.name = "mips/74K";
+		mipsxx74Kcore_pmu.num_counters = counters;
+		mipspmu = &mipsxx74Kcore_pmu;
+		break;
+	case CPU_1004K:
+		mipsxxcore_pmu.name = "mips/1004K";
+		mipsxxcore_pmu.num_counters = counters;
+		mipspmu = &mipsxxcore_pmu;
+		break;
+	default:
+		pr_cont("Either hardware does not support performance "
+			"counters, or not yet implemented.\n");
+		return -ENODEV;
+	}
+
+	if (mipspmu)
+		pr_cont("%s PMU enabled, %d counters available to each "
+			"CPU\n", mipspmu->name, mipspmu->num_counters);
+
+	return 0;
+}
+arch_initcall(init_hw_perf_events);
+
+#endif /* defined(CONFIG_CPU_MIPS32)... */
-- 
1.6.3.3
