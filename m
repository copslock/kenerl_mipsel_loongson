Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Apr 2010 17:21:42 +0200 (CEST)
Received: from fg-out-1718.google.com ([72.14.220.159]:25421 "EHLO
        fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492020Ab0D1PVf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Apr 2010 17:21:35 +0200
Received: by fg-out-1718.google.com with SMTP id e12so1900060fga.6
        for <multiple recipients>; Wed, 28 Apr 2010 08:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=cTC3NyiSDi1LgRwZHikNYTMrwVXfaOyeTmj6KdTqVRA=;
        b=iPiFqeZSRIcbUMOH0DyYEOUI9vAiLK1urEeIbkcqZ1bS9u6aQPLPcDDsTUO0wVjGEb
         cCU/x6A42jAm5Roqpq/zz92SOnhhggl6F9ST82Ftxfna9olve5+oOP9wYH3yyNpBVCrU
         UZvSBNor+xEiaACYDfta19ACfdLxK86IC/eDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=WDIdXh1LvWRlohR+pxMc82CFle5eS+9oOBmQbIzn2SfT9kaVrtcsr+EHghlgt+SU8u
         hTGU3wUQr93YJC4kOzaO3MhrG9zBlnKKPfxMle9D/r9rwMowh3uFqIg/SidDmyfomC4j
         7AuQ35Ib8XZG38WZ9iADs3nagVhmqm9j3dT3s=
Received: by 10.87.31.36 with SMTP id i36mr5063209fgj.56.1272468093649;
        Wed, 28 Apr 2010 08:21:33 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 3sm6669052fge.15.2010.04.28.08.21.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Apr 2010 08:21:31 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     loongson-dev <loongson-dev@googlegroups.com>,
        linux-mips@linux-mips.org
Cc:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>, ralf@linux-mips.org,
        Zhang Le <r0bertz@gentoo.org>, yajin <yajinzhou@vm-kernel.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] Loongson2: add a primary perf support (not applicable)
Date:   Wed, 28 Apr 2010 23:21:17 +0800
Message-Id: <1272468077-12292-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

"perf - Performance analysis tools for Linux
[...]
Performance counters for Linux are a new kernel-based subsystem
that provide a framework for all things performance analysis. It
covers hardware level (CPU/PMU, Performance Monitoring Unit) features
and software features (software counters, tracepoints) as well."
	-- tools/perf/Documentation/perf.txt

Based on Deng-cheng's perf support for MIPS[1], this patch adds a primary perf
support for loongson2. it is far from the full support.

To make the basic perf support work on loongson2, you need to use the kernel
2.6.34-rc from [2] and apply Deng-cheng's patches[1] at first, then apply this
patch and at last compile it with CONFIG_HW_PERF_EVENTS=y (and please ensure
OPROFILE=n).

And then you need to compile the user-space tools/perf with the following steps
if want to local-compile it:

1. copy the {include, lib, tools/perf} directories of linux source code
to the target machines and ensure it looks like this:

$ ls
include lib tools
$ ls tools
perf

2. install the basic -dev libs (use debian as an example)

$ sudo apt-get install libdw-dev libelf-dev

(If not enough, please refer to the error report when compiling, search the
header files with the help of "apt-cache search ...")

3. Apply deng-cheng's another patch[3] for tools/perf

4. compile it

$ cd tools/perf
$ make

5. usage: refer to tools/perf/Documentation/examples.txt

$ ./perf list

For a non-raw event

$ ./perf stat -e cycles ls -l

For a raw event

$ ./perf stat -e r0 ls -l

Currently, seems "./perf record" and lots of software events not work, anybody
have interest in playing with it can refer to {tools/perf/Documentation,
arch/mips/kernel/perf_event*, arch/mips/include/asm/pmu.h,
arch/x86/kernel/cpu/perf_event*, arch/arm/kernel/perf_event* ...}.

That's all! Thanks~

[1] http://patchwork.linux-mips.org/project/linux-mips/list/?=Deng-Cheng+Zhu&submitter=168&state=
  [v2,4/4] MIPS: implementing hardware performance event support
  [v2,3/4] MIPS: adding support for software performance events
  [v2,2/4] MIPS: in non-64bit kernel, using the generic atomic64 operations for perf counter support
  [v2,1/4] MIPS/Oprofile: extracting PMU defines/helper functions for sharing
[2] http://dev.lemote.com/code/linux-loongson-community
[3] http://patchwork.linux-mips.org/patch/1150/

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig                       |    2 +-
 arch/mips/include/asm/pmu.h             |   19 +-
 arch/mips/kernel/perf_event.c           |    1 +
 arch/mips/kernel/perf_event_loongson2.c |  470 +++++++++++++++++++++++++++++++
 arch/mips/loongson/lemote-2f/irq.c      |    3 +-
 5 files changed, 484 insertions(+), 11 deletions(-)
 create mode 100644 arch/mips/kernel/perf_event_loongson2.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5b485a4..51bc385 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1859,7 +1859,7 @@ config NODES_SHIFT
 
 config HW_PERF_EVENTS
 	bool "Enable hardware performance counter support for perf events"
-	depends on PERF_EVENTS && !MIPS_MT_SMTC && OPROFILE=n && CPU_MIPS32
+	depends on PERF_EVENTS && !MIPS_MT_SMTC && OPROFILE=n
 	default y
 	help
 	  Enable hardware performance counter support for perf events. If
diff --git a/arch/mips/include/asm/pmu.h b/arch/mips/include/asm/pmu.h
index 6da943c..df409c7 100644
--- a/arch/mips/include/asm/pmu.h
+++ b/arch/mips/include/asm/pmu.h
@@ -19,6 +19,8 @@
 #ifndef __MIPS_PMU_H__
 #define __MIPS_PMU_H__
 
+static int (*save_perf_irq)(void);
+
 #if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64) || \
     defined(CONFIG_CPU_R10000) || defined(CONFIG_CPU_SB1)
 
@@ -41,8 +43,6 @@
 
 #define M_COUNTER_OVERFLOW		(1UL      << 31)
 
-static int (*save_perf_irq)(void);
-
 #ifdef CONFIG_MIPS_MT_SMP
 static int cpu_has_mipsmt_pertccounters;
 #define WHAT		(M_TC_EN_VPE | \
@@ -216,15 +216,16 @@ extern unsigned int rm9000_perfcount_irq;
 
 #elif defined(CONFIG_CPU_LOONGSON2)
 
-/*
- * a patch should be sent to oprofile with the loongson-specific support.
- * otherwise, the oprofile tool will not recognize this and complain about
- * "cpu_type 'unset' is not valid".
- */
+#include <loongson.h>
+
 #define LOONGSON2_CPU_TYPE	"mips/loongson2"
 
-#define LOONGSON2_COUNTER1_EVENT(event)	((event & 0x0f) << 5)
-#define LOONGSON2_COUNTER2_EVENT(event)	((event & 0x0f) << 9)
+#define MIPS_MAX_HWEVENTS	2
+
+#define LOONGSON2_COUNTER1_EVENT(event) (((event) & 0x0f) << 5)
+#define LOONGSON2_COUNTER2_EVENT(event) (((event) & 0x0f) << 9)
+#define LOONGSON2_PERFCNT_EVENT(event, idx) \
+	(((event) & 0x0f) << ((idx) ? 9 : 5))
 
 #define LOONGSON2_PERFCNT_EXL			(1UL	<<  0)
 #define LOONGSON2_PERFCNT_KERNEL		(1UL    <<  1)
diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
index a17dc64..cbcaf43 100644
--- a/arch/mips/kernel/perf_event.c
+++ b/arch/mips/kernel/perf_event.c
@@ -459,6 +459,7 @@ const struct pmu *hw_perf_event_init(struct perf_event *event)
 }
 
 #include "perf_event_mipsxx.c"
+#include "perf_event_loongson2.c"
 
 /*
  * Callchain handling code.
diff --git a/arch/mips/kernel/perf_event_loongson2.c b/arch/mips/kernel/perf_event_loongson2.c
new file mode 100644
index 0000000..d97bf4a
--- /dev/null
+++ b/arch/mips/kernel/perf_event_loongson2.c
@@ -0,0 +1,470 @@
+#ifdef CONFIG_CPU_LOONGSON2
+
+#define LOONGSON2_PERFCNT_COUNT_EVENT_WHENEVER		\
+	(LOONGSON2_PERFCNT_EXL | LOONGSON2_PERFCNT_KERNEL |	\
+	LOONGSON2_PERFCNT_USER | LOONGSON2_PERFCNT_SUPERVISOR |	\
+	LOONGSON2_PERFCNT_INT_EN)
+
+#define LOONGSON2_PERFCNT_CONFIG_MASK 0x1f
+
+static inline unsigned int
+loongson2_pmu_read_counter(unsigned int idx)
+{
+	uint64_t counter = read_c0_perfcnt();
+
+	switch (idx) {
+	case 0:
+		return counter & 0xffffffff;
+	case 1:
+		return counter >> 32;
+	default:
+		WARN_ONCE(1, "Invalid performance counter number (%d)\n", idx);
+		return 0;
+	}
+}
+
+static inline void
+loongson2_pmu_write_counter(unsigned int idx, unsigned int val)
+{
+	uint64_t counter = read_c0_perfcnt();
+
+	switch (idx) {
+	case 0:
+		write_c0_perfcnt(val | counter);
+		return;
+	case 1:
+		write_c0_perfcnt(((uint64_t)val << 32) | counter);
+		return;
+	}
+}
+
+static inline unsigned int
+loongson2_pmu_read_control(unsigned int idx)
+{
+	return read_c0_perfctrl();
+}
+
+static inline void
+loongson2_pmu_write_control(unsigned int idx, unsigned int val)
+{
+	write_c0_perfctrl(val);
+	return;
+}
+
+static const struct mips_perf_event loongson2_event_map
+				[PERF_COUNT_HW_MAX] = {
+	[PERF_COUNT_HW_CPU_CYCLES] = { 0x00, CNTR_EVEN },
+	[PERF_COUNT_HW_INSTRUCTIONS] = { 0x00, CNTR_ODD },
+	[PERF_COUNT_HW_CACHE_REFERENCES] = { UNSUPPORTED_PERF_EVENT_ID },
+	[PERF_COUNT_HW_CACHE_MISSES] = { UNSUPPORTED_PERF_EVENT_ID },
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = { 0x01, CNTR_EVEN },
+	[PERF_COUNT_HW_BRANCH_MISSES] = { 0x01, CNTR_ODD },
+	[PERF_COUNT_HW_BUS_CYCLES] = { UNSUPPORTED_PERF_EVENT_ID },
+};
+
+static const struct mips_perf_event loongson2_cache_map
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
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { 0x04, CNTR_ODD },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { 0x04, CNTR_ODD },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(L1I)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { 0x04, CNTR_EVEN },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { 0x04, CNTR_EVEN },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		/*
+		 * Note that MIPS has only "hit" events countable for
+		 * the prefetch operation.
+		 */
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(DTLB)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { 0x0d, CNTR_EVEN },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { 0x0d, CNTR_EVEN },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(ITLB)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { 0x0c, CNTR_ODD },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { 0x0c, CNTR_ODD },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+};
+
+static void hw_perf_event_destroy(struct perf_event *event)
+{
+	if (atomic_dec_and_mutex_lock(&active_events,
+				&pmu_reserve_mutex)) {
+		/*
+		 * We must not call the destroy function with interrupts
+		 * disabled.
+		 */
+		write_c0_perfctrl(0);
+		mipspmu_free_irq();
+		mutex_unlock(&pmu_reserve_mutex);
+	}
+}
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
+	hwc->config_base = LOONGSON2_PERFCNT_INT_EN;
+
+	hwc->event_base = mipspmu_perf_event_encode(pev);
+	if (PERF_TYPE_RAW == event->attr.type)
+		mutex_unlock(&raw_event_mutex);
+
+	if (!attr->exclude_user)
+		hwc->config_base |= LOONGSON2_PERFCNT_USER;
+	if (!attr->exclude_kernel) {
+		hwc->config_base |= LOONGSON2_PERFCNT_KERNEL;
+		/* MIPS kernel mode: KSU == 00b || EXL == 1 || ERL == 1 */
+		hwc->config_base |= LOONGSON2_PERFCNT_EXL;
+	}
+	if (!attr->exclude_hv)
+		hwc->config_base |= LOONGSON2_PERFCNT_SUPERVISOR;
+
+	hwc->config_base &= LOONGSON2_PERFCNT_CONFIG_MASK;
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
+void hw_perf_enable(void)
+{
+	if (mipspmu)
+		mipspmu->start();
+}
+
+void hw_perf_disable(void)
+{
+	if (mipspmu)
+		mipspmu->stop();
+}
+
+static void
+handle_associated_event(struct cpu_hw_events *cpuc,
+	int idx, struct perf_sample_data *data, struct pt_regs *regs)
+{
+	struct perf_event *event = cpuc->events[idx];
+	struct hw_perf_event *hwc = &event->hw;
+
+	mipspmu_event_update(event, hwc, idx);
+	data->period = event->hw.last_period;
+	if (!mipspmu_event_set_period(event, hwc, idx))
+		return;
+
+	if (perf_event_overflow(event, 0, data, regs))
+		mipspmu->disable_event(idx);
+}
+
+static void pause_local_counters(void)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	unsigned long flags;
+
+	local_irq_save(flags);
+	cpuc->saved_ctrl[0] = read_c0_perfctrl();
+	write_c0_perfctrl(cpuc->saved_ctrl[0] &
+		~LOONGSON2_PERFCNT_COUNT_EVENT_WHENEVER);
+	local_irq_restore(flags);
+}
+
+static void resume_local_counters(void)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	unsigned long flags;
+
+	local_irq_save(flags);
+	write_c0_perfctrl(cpuc->saved_ctrl[0]);
+	local_irq_restore(flags);
+}
+
+static int loongson2_pmu_handle_shared_irq(void)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	struct perf_sample_data data;
+	unsigned int counters = mipspmu->num_counters;
+	unsigned int counter;
+	int handled = IRQ_NONE;
+	struct pt_regs *regs;
+
+	/* Check whether the irq belongs to me */
+	if (!(read_c0_perfcnt() & LOONGSON2_PERFCNT_INT_EN))
+		return IRQ_NONE;
+
+	/*
+	 * First we pause the local counters, so that when we are locked
+	 * here, the counters are all paused. When it gets locked due to
+	 * perf_disable(), the timer interrupt handler will be delayed.
+	 *
+	 * See also loongson2_pmu_start().
+	 */
+	pause_local_counters();
+
+	regs = get_irq_regs();
+
+	perf_sample_data_init(&data, 0);
+
+	switch (counters) {
+#define HANDLE_COUNTER(n)						\
+	case n + 1:							\
+		if (test_bit(n, cpuc->used_mask)) {			\
+			counter = loongson2_pmu_read_counter(n);	\
+			if (counter & LOONGSON2_PERFCNT_OVERFLOW) {	\
+				loongson2_pmu_write_counter(n, counter &\
+						0x7fffffff);		\
+				if (test_and_change_bit(n, cpuc->msbs))	\
+					handle_associated_event(cpuc,	\
+						n, &data, regs);	\
+				handled = IRQ_HANDLED;			\
+			}						\
+		}
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
+	resume_local_counters();
+	return handled;
+}
+
+static irqreturn_t
+loongson2_pmu_handle_irq(int irq, void *dev)
+{
+	return loongson2_pmu_handle_shared_irq();
+}
+
+static void loongson2_pmu_start(void)
+{
+	resume_local_counters();
+}
+
+static void loongson2_pmu_stop(void)
+{
+	pause_local_counters();
+}
+
+static int
+loongson2_pmu_alloc_counter(struct cpu_hw_events *cpuc,
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
+loongson2_pmu_enable_event(struct hw_perf_event *evt, int idx)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	unsigned long flags;
+
+	WARN_ON(idx < 0 || idx >= mipspmu->num_counters);
+
+	local_irq_save(flags);
+
+	cpuc->saved_ctrl[idx] =
+		LOONGSON2_PERFCNT_EVENT(evt->event_base & 0xff, idx) |
+		(evt->config_base & LOONGSON2_PERFCNT_CONFIG_MASK) |
+		/* Make sure interrupt enabled. */
+		LOONGSON2_PERFCNT_INT_EN;
+	/*
+	 * We do not actually let the counter run. Leave it until start().
+	 */
+	local_irq_restore(flags);
+}
+
+static void
+loongson2_pmu_disable_event(int idx)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	unsigned long flags;
+
+	WARN_ON(idx < 0 || idx >= mipspmu->num_counters);
+
+	local_irq_save(flags);
+	cpuc->saved_ctrl[idx] = loongson2_pmu_read_control(idx) &
+		~LOONGSON2_PERFCNT_COUNT_EVENT_WHENEVER;
+	loongson2_pmu_write_control(idx, cpuc->saved_ctrl[idx]);
+	local_irq_restore(flags);
+}
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
+loongson2_pmu_map_raw_event(u64 config)
+{
+	unsigned int raw_id = config & 0xff;
+	unsigned int base_id = raw_id & 0x7f;
+
+	raw_event.event_id = base_id;
+	raw_event.cntr_mask = raw_id > 127 ? CNTR_ODD : CNTR_EVEN;
+
+	return &raw_event;
+}
+
+static struct mips_pmu loongson2_pmu = {
+	.handle_irq = loongson2_pmu_handle_irq,
+	.handle_shared_irq = loongson2_pmu_handle_shared_irq,
+	.start = loongson2_pmu_start,
+	.stop = loongson2_pmu_stop,
+	.alloc_counter = loongson2_pmu_alloc_counter,
+	.read_counter = loongson2_pmu_read_counter,
+	.write_counter = loongson2_pmu_write_counter,
+	.enable_event = loongson2_pmu_enable_event,
+	.disable_event = loongson2_pmu_disable_event,
+	.map_raw_event = loongson2_pmu_map_raw_event,
+	.general_event_map = &loongson2_event_map,
+	.cache_event_map = &loongson2_cache_map,
+};
+
+static int __init
+init_hw_perf_events(void)
+{
+	pr_info("Performance counters: ");
+
+	/* Reset counters */
+	write_c0_perfctrl(0);
+
+	loongson2_pmu.name = LOONGSON2_CPU_TYPE;
+	loongson2_pmu.num_counters = 2;
+	mipspmu = &loongson2_pmu;
+
+	if (mipspmu)
+		pr_cont("%s PMU enabled, %d counters available to each "
+			"CPU\n", mipspmu->name, mipspmu->num_counters);
+
+	return 0;
+}
+arch_initcall(init_hw_perf_events);
+
+#endif
diff --git a/arch/mips/loongson/lemote-2f/irq.c b/arch/mips/loongson/lemote-2f/irq.c
index 1d8b4d2..d5e7220 100644
--- a/arch/mips/loongson/lemote-2f/irq.c
+++ b/arch/mips/loongson/lemote-2f/irq.c
@@ -79,7 +79,8 @@ void mach_irq_dispatch(unsigned int pending)
 	if (pending & CAUSEF_IP7)
 		do_IRQ(LOONGSON_TIMER_IRQ);
 	else if (pending & CAUSEF_IP6) {	/* North Bridge, Perf counter */
-#if defined(CONFIG_OPROFILE) || defined(CONFIG_OPROFILE_MODULE)
+#if defined(CONFIG_OPROFILE) || defined(CONFIG_OPROFILE_MODULE) \
+		|| defined(CONFIG_HW_PERF_EVENTS)
 		do_IRQ(LOONGSON2_PERFCNT_IRQ);
 #endif
 		bonito_irqdispatch();
-- 
1.7.0
