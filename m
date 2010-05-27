Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 May 2010 15:07:02 +0200 (CEST)
Received: from mail-pz0-f173.google.com ([209.85.222.173]:51716 "EHLO
        mail-pz0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492367Ab0E0NFG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 May 2010 15:05:06 +0200
Received: by mail-pz0-f173.google.com with SMTP id 3so3858148pzk.26
        for <multiple recipients>; Thu, 27 May 2010 06:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Dyj6xqZcln9hPqlMk9IGuttTOWEo9wz0Jn4zu9Xp5IY=;
        b=Xpyh9OnV4mCydgSiad89tFrkGRSFfj3/0VfYTgAjwCL3nh0w/Uvo01ob0kfvjy3cWo
         r/nZCDbHJ8pOCab9HHKUG5maWqKzLVQIQqAQ4P7NDuHPjK9Xerff06gC9TiUfvkLuiq9
         oLpnIQWPmkRVOpp1pYwkADdT82A3DpcS+Il4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RsAvKASImlKMmqhxk9WYX6wXMfZi0vnoHJD/GWXIqkO640jjoz71MOTfUXILwM4IDr
         G+MEctrc7BRXkthpGlyxHJiGIdY+8o8BiybcSmQ2IQW30eROjG/4umoH28N8RSXzMBWG
         IyamlR97LJHeHetW+SN0LYEEb32lWrUidKo30=
Received: by 10.142.59.10 with SMTP id h10mr6950782wfa.284.1274965504840;
        Thu, 27 May 2010 06:05:04 -0700 (PDT)
Received: from localhost.localdomain ([114.84.70.124])
        by mx.google.com with ESMTPS id 21sm972927pzk.8.2010.05.27.06.04.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 06:05:04 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v5 06/12] MIPS: add support for hardware performance events (mipsxx)
Date:   Thu, 27 May 2010 21:03:34 +0800
Message-Id: <1274965420-5091-7-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

This patch adds the mipsxx Perf-event support based on the skeleton.
Generic hardware events and cache events are now fully implemented for
the 24K/34K/74K/1004K cores. To support other cores in mipsxx (such as
R10000/SB1), the generic hardware event tables and cache event tables
need to be filled out. To support other CPUs which have different PMU
than mipsxx, such as RM9000 and LOONGSON2, the additional files
perf_event_$cpu.c need to be created.

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
 arch/mips/kernel/perf_event.c        |    2 +
 arch/mips/kernel/perf_event_mipsxx.c |  719 ++++++++++++++++++++++++++++++++++
 2 files changed, 721 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/kernel/perf_event_mipsxx.c

diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
index 63ea0e9..4c9b741 100644
--- a/arch/mips/kernel/perf_event.c
+++ b/arch/mips/kernel/perf_event.c
@@ -502,6 +502,8 @@ handle_associated_event(struct cpu_hw_events *cpuc,
 		mipspmu->disable_event(idx);
 }
 
+#include "perf_event_mipsxx.c"
+
 /*
  * Callchain handling code.
  */
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
new file mode 100644
index 0000000..87103bf
--- /dev/null
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -0,0 +1,719 @@
+#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64) || \
+    defined(CONFIG_CPU_R10000) || defined(CONFIG_CPU_SB1)
+
+#define M_PERFCTL_COUNT_EVENT_WHENEVER		\
+	(M_PERFCTL_EXL | M_PERFCTL_KERNEL |	\
+	M_PERFCTL_USER | M_PERFCTL_SUPERVISOR |	\
+	M_PERFCTL_INTERRUPT_ENABLE)
+
+#ifdef CONFIG_MIPS_MT_SMP
+#define M_PERFCTL_CONFIG_MASK 0x3fff801f
+#else
+#define M_PERFCTL_CONFIG_MASK 0x1f
+#endif
+#define M_PERFCTL_EVENT_MASK 0xfe0
+
+static inline unsigned int
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
+mipsxx_pmu_write_counter(unsigned int idx, unsigned int val)
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
+	} else {
+		/* The event type is not (yet) supported. */
+		return -EOPNOTSUPP;
+	}
+
+	if (IS_ERR(pev))
+		return PTR_ERR(pev);
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
+						0x7fffffff);		\
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
+	.general_event_map = &mipsxx74Kcore_event_map,
+	.cache_event_map = &mipsxx74Kcore_cache_map,
+};
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
