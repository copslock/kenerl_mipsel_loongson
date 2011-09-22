Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Sep 2011 19:29:06 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:6006 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491921Ab1IVR0y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Sep 2011 19:26:54 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e7b701a0000>; Thu, 22 Sep 2011 10:27:54 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 22 Sep 2011 10:26:39 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 22 Sep 2011 10:26:38 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id p8MHQW8e007334;
        Thu, 22 Sep 2011 10:26:32 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p8MHQTLN007332;
        Thu, 22 Sep 2011 10:26:29 -0700
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Dezhong Diao <dediao@cisco.com>,
        Gabor Juhos <juhosg@openwrt.org>,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v5 3/5] MIPS: perf: Reorganize contents of perf support files.
Date:   Thu, 22 Sep 2011 10:26:16 -0700
Message-Id: <1316712378-7282-4-git-send-email-david.daney@cavium.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1316712378-7282-1-git-send-email-david.daney@cavium.com>
References: <1316712378-7282-1-git-send-email-david.daney@cavium.com>
X-OriginalArrivalTime: 22 Sep 2011 17:26:38.0657 (UTC) FILETIME=[C92D5B10:01CC794C]
X-archive-position: 31132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12723

The contents of arch/mips/kernel/perf_event.c and
arch/mips/kernel/perf_event_mipsxx.c were divided in a seemingly ad
hoc manner, with the first including the second.

I moved all the hardware counter support code to perf_event_mipsxx.c
and removed the gating #ifdefs to the Kconfig and Makefile.

Now perf_event.c contains only the callchain support, everything else
is in perf_event_mipsxx.c

There are no code changes, only moving of functions from one file to
the other, or removing empty unneeded functions.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Dezhong Diao <dediao@cisco.com>
Cc: Gabor Juhos <juhosg@openwrt.org>
Cc: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/Kconfig                    |    2 +-
 arch/mips/kernel/Makefile            |    5 +-
 arch/mips/kernel/perf_event.c        |  515 +---------------------------------
 arch/mips/kernel/perf_event_mipsxx.c |  530 +++++++++++++++++++++++++++++++++-
 4 files changed, 532 insertions(+), 520 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b122adc..cf714ea 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2098,7 +2098,7 @@ config NODES_SHIFT
 
 config HW_PERF_EVENTS
 	bool "Enable hardware performance counter support for perf events"
-	depends on PERF_EVENTS && !MIPS_MT_SMTC && OPROFILE=n && CPU_MIPS32
+	depends on PERF_EVENTS && !MIPS_MT_SMTC && OPROFILE=n && (CPU_MIPS32 || CPU_MIPS64 || CPU_R10000 || CPU_SB1)
 	default y
 	help
 	  Enable hardware performance counter support for perf events. If
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 83bba33..1a96618 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -11,6 +11,8 @@ obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_early_printk.o = -pg
+CFLAGS_REMOVE_perf_event.o = -pg
+CFLAGS_REMOVE_perf_event_mipsxx.o = -pg
 endif
 
 obj-$(CONFIG_CEVT_BCM1480)	+= cevt-bcm1480.o
@@ -106,7 +108,8 @@ obj-$(CONFIG_HAVE_STD_PC_SERIAL_PORT)	+= 8250-platform.o
 
 obj-$(CONFIG_MIPS_CPUFREQ)	+= cpufreq/
 
-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
+obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o
+obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event_mipsxx.o
 
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
index f3d6e99..c1cf9c6 100644
--- a/arch/mips/kernel/perf_event.c
+++ b/arch/mips/kernel/perf_event.c
@@ -14,529 +14,16 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/cpumask.h>
-#include <linux/interrupt.h>
-#include <linux/smp.h>
-#include <linux/kernel.h>
 #include <linux/perf_event.h>
-#include <linux/uaccess.h>
 
-#include <asm/irq.h>
-#include <asm/irq_regs.h>
 #include <asm/stacktrace.h>
-#include <asm/time.h> /* For perf_irq */
-
-/* These are for 32bit counters. For 64bit ones, define them accordingly. */
-#define MAX_PERIOD	((1ULL << 32) - 1)
-#define VALID_COUNT	0x7fffffff
-#define TOTAL_BITS	32
-#define HIGHEST_BIT	31
-
-#define MIPS_MAX_HWEVENTS 4
-
-struct cpu_hw_events {
-	/* Array of events on this cpu. */
-	struct perf_event	*events[MIPS_MAX_HWEVENTS];
-
-	/*
-	 * Set the bit (indexed by the counter number) when the counter
-	 * is used for an event.
-	 */
-	unsigned long		used_mask[BITS_TO_LONGS(MIPS_MAX_HWEVENTS)];
-
-	/*
-	 * The borrowed MSB for the performance counter. A MIPS performance
-	 * counter uses its bit 31 (for 32bit counters) or bit 63 (for 64bit
-	 * counters) as a factor of determining whether a counter overflow
-	 * should be signaled. So here we use a separate MSB for each
-	 * counter to make things easy.
-	 */
-	unsigned long		msbs[BITS_TO_LONGS(MIPS_MAX_HWEVENTS)];
-
-	/*
-	 * Software copy of the control register for each performance counter.
-	 * MIPS CPUs vary in performance counters. They use this differently,
-	 * and even may not use it.
-	 */
-	unsigned int		saved_ctrl[MIPS_MAX_HWEVENTS];
-};
-DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
-	.saved_ctrl = {0},
-};
-
-/* The description of MIPS performance events. */
-struct mips_perf_event {
-	unsigned int event_id;
-	/*
-	 * MIPS performance counters are indexed starting from 0.
-	 * CNTR_EVEN indicates the indexes of the counters to be used are
-	 * even numbers.
-	 */
-	unsigned int cntr_mask;
-	#define CNTR_EVEN	0x55555555
-	#define CNTR_ODD	0xaaaaaaaa
-#ifdef CONFIG_MIPS_MT_SMP
-	enum {
-		T  = 0,
-		V  = 1,
-		P  = 2,
-	} range;
-#else
-	#define T
-	#define V
-	#define P
-#endif
-};
-
-static struct mips_perf_event raw_event;
-static DEFINE_MUTEX(raw_event_mutex);
-
-#define UNSUPPORTED_PERF_EVENT_ID 0xffffffff
-#define C(x) PERF_COUNT_HW_CACHE_##x
-
-struct mips_pmu {
-	const char	*name;
-	int		irq;
-	irqreturn_t	(*handle_irq)(int irq, void *dev);
-	int		(*handle_shared_irq)(void);
-	void		(*start)(void);
-	void		(*stop)(void);
-	int		(*alloc_counter)(struct cpu_hw_events *cpuc,
-					struct hw_perf_event *hwc);
-	u64		(*read_counter)(unsigned int idx);
-	void		(*write_counter)(unsigned int idx, u64 val);
-	void		(*enable_event)(struct hw_perf_event *evt, int idx);
-	void		(*disable_event)(int idx);
-	const struct mips_perf_event *(*map_raw_event)(u64 config);
-	const struct mips_perf_event (*general_event_map)[PERF_COUNT_HW_MAX];
-	const struct mips_perf_event (*cache_event_map)
-				[PERF_COUNT_HW_CACHE_MAX]
-				[PERF_COUNT_HW_CACHE_OP_MAX]
-				[PERF_COUNT_HW_CACHE_RESULT_MAX];
-	unsigned int	num_counters;
-};
-
-static const struct mips_pmu *mipspmu;
-
-static int mipspmu_event_set_period(struct perf_event *event,
-				    struct hw_perf_event *hwc,
-				    int idx)
-{
-	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
-	s64 left = local64_read(&hwc->period_left);
-	s64 period = hwc->sample_period;
-	int ret = 0;
-	u64 uleft;
-	unsigned long flags;
-
-	if (unlikely(left <= -period)) {
-		left = period;
-		local64_set(&hwc->period_left, left);
-		hwc->last_period = period;
-		ret = 1;
-	}
-
-	if (unlikely(left <= 0)) {
-		left += period;
-		local64_set(&hwc->period_left, left);
-		hwc->last_period = period;
-		ret = 1;
-	}
-
-	if (left > (s64)MAX_PERIOD)
-		left = MAX_PERIOD;
-
-	local64_set(&hwc->prev_count, (u64)-left);
-
-	local_irq_save(flags);
-	uleft = (u64)(-left) & MAX_PERIOD;
-	uleft > VALID_COUNT ?
-		set_bit(idx, cpuc->msbs) : clear_bit(idx, cpuc->msbs);
-	mipspmu->write_counter(idx, (u64)(-left) & VALID_COUNT);
-	local_irq_restore(flags);
-
-	perf_event_update_userpage(event);
-
-	return ret;
-}
-
-static void mipspmu_event_update(struct perf_event *event,
-				 struct hw_perf_event *hwc,
-				 int idx)
-{
-	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
-	unsigned long flags;
-	int shift = 64 - TOTAL_BITS;
-	s64 prev_raw_count, new_raw_count;
-	u64 delta;
-
-again:
-	prev_raw_count = local64_read(&hwc->prev_count);
-	local_irq_save(flags);
-	/* Make the counter value be a "real" one. */
-	new_raw_count = mipspmu->read_counter(idx);
-	if (new_raw_count & (test_bit(idx, cpuc->msbs) << HIGHEST_BIT)) {
-		new_raw_count &= VALID_COUNT;
-		clear_bit(idx, cpuc->msbs);
-	} else
-		new_raw_count |= (test_bit(idx, cpuc->msbs) << HIGHEST_BIT);
-	local_irq_restore(flags);
-
-	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
-				new_raw_count) != prev_raw_count)
-		goto again;
-
-	delta = (new_raw_count << shift) - (prev_raw_count << shift);
-	delta >>= shift;
-
-	local64_add(delta, &event->count);
-	local64_sub(delta, &hwc->period_left);
-}
-
-static void mipspmu_start(struct perf_event *event, int flags)
-{
-	struct hw_perf_event *hwc = &event->hw;
-
-	if (!mipspmu)
-		return;
-
-	if (flags & PERF_EF_RELOAD)
-		WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
-
-	hwc->state = 0;
-
-	/* Set the period for the event. */
-	mipspmu_event_set_period(event, hwc, hwc->idx);
-
-	/* Enable the event. */
-	mipspmu->enable_event(hwc, hwc->idx);
-}
-
-static void mipspmu_stop(struct perf_event *event, int flags)
-{
-	struct hw_perf_event *hwc = &event->hw;
-
-	if (!mipspmu)
-		return;
-
-	if (!(hwc->state & PERF_HES_STOPPED)) {
-		/* We are working on a local event. */
-		mipspmu->disable_event(hwc->idx);
-		barrier();
-		mipspmu_event_update(event, hwc, hwc->idx);
-		hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
-	}
-}
-
-static int mipspmu_add(struct perf_event *event, int flags)
-{
-	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
-	struct hw_perf_event *hwc = &event->hw;
-	int idx;
-	int err = 0;
-
-	perf_pmu_disable(event->pmu);
-
-	/* To look for a free counter for this event. */
-	idx = mipspmu->alloc_counter(cpuc, hwc);
-	if (idx < 0) {
-		err = idx;
-		goto out;
-	}
-
-	/*
-	 * If there is an event in the counter we are going to use then
-	 * make sure it is disabled.
-	 */
-	event->hw.idx = idx;
-	mipspmu->disable_event(idx);
-	cpuc->events[idx] = event;
-
-	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
-	if (flags & PERF_EF_START)
-		mipspmu_start(event, PERF_EF_RELOAD);
-
-	/* Propagate our changes to the userspace mapping. */
-	perf_event_update_userpage(event);
-
-out:
-	perf_pmu_enable(event->pmu);
-	return err;
-}
-
-static void mipspmu_del(struct perf_event *event, int flags)
-{
-	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
-	struct hw_perf_event *hwc = &event->hw;
-	int idx = hwc->idx;
-
-	WARN_ON(idx < 0 || idx >= mipspmu->num_counters);
-
-	mipspmu_stop(event, PERF_EF_UPDATE);
-	cpuc->events[idx] = NULL;
-	clear_bit(idx, cpuc->used_mask);
-
-	perf_event_update_userpage(event);
-}
-
-static void mipspmu_read(struct perf_event *event)
-{
-	struct hw_perf_event *hwc = &event->hw;
-
-	/* Don't read disabled counters! */
-	if (hwc->idx < 0)
-		return;
-
-	mipspmu_event_update(event, hwc, hwc->idx);
-}
-
-static void mipspmu_enable(struct pmu *pmu)
-{
-	if (mipspmu)
-		mipspmu->start();
-}
-
-static void mipspmu_disable(struct pmu *pmu)
-{
-	if (mipspmu)
-		mipspmu->stop();
-}
-
-static atomic_t active_events = ATOMIC_INIT(0);
-static DEFINE_MUTEX(pmu_reserve_mutex);
-static int (*save_perf_irq)(void);
-
-static int mipspmu_get_irq(void)
-{
-	int err;
-
-	if (mipspmu->irq >= 0) {
-		/* Request my own irq handler. */
-		err = request_irq(mipspmu->irq, mipspmu->handle_irq,
-			IRQF_DISABLED | IRQF_NOBALANCING,
-			"mips_perf_pmu", NULL);
-		if (err) {
-			pr_warning("Unable to request IRQ%d for MIPS "
-			   "performance counters!\n", mipspmu->irq);
-		}
-	} else if (cp0_perfcount_irq < 0) {
-		/*
-		 * We are sharing the irq number with the timer interrupt.
-		 */
-		save_perf_irq = perf_irq;
-		perf_irq = mipspmu->handle_shared_irq;
-		err = 0;
-	} else {
-		pr_warning("The platform hasn't properly defined its "
-			"interrupt controller.\n");
-		err = -ENOENT;
-	}
-
-	return err;
-}
-
-static void mipspmu_free_irq(void)
-{
-	if (mipspmu->irq >= 0)
-		free_irq(mipspmu->irq, NULL);
-	else if (cp0_perfcount_irq < 0)
-		perf_irq = save_perf_irq;
-}
-
-/*
- * mipsxx/rm9000/loongson2 have different performance counters, they have
- * specific low-level init routines.
- */
-static void reset_counters(void *arg);
-static int __hw_perf_event_init(struct perf_event *event);
-
-static void hw_perf_event_destroy(struct perf_event *event)
-{
-	if (atomic_dec_and_mutex_lock(&active_events,
-				&pmu_reserve_mutex)) {
-		/*
-		 * We must not call the destroy function with interrupts
-		 * disabled.
-		 */
-		on_each_cpu(reset_counters,
-			(void *)(long)mipspmu->num_counters, 1);
-		mipspmu_free_irq();
-		mutex_unlock(&pmu_reserve_mutex);
-	}
-}
-
-static int mipspmu_event_init(struct perf_event *event)
-{
-	int err = 0;
-
-	switch (event->attr.type) {
-	case PERF_TYPE_RAW:
-	case PERF_TYPE_HARDWARE:
-	case PERF_TYPE_HW_CACHE:
-		break;
-
-	default:
-		return -ENOENT;
-	}
-
-	if (!mipspmu || event->cpu >= nr_cpumask_bits ||
-		(event->cpu >= 0 && !cpu_online(event->cpu)))
-		return -ENODEV;
-
-	if (!atomic_inc_not_zero(&active_events)) {
-		if (atomic_read(&active_events) > MIPS_MAX_HWEVENTS) {
-			atomic_dec(&active_events);
-			return -ENOSPC;
-		}
-
-		mutex_lock(&pmu_reserve_mutex);
-		if (atomic_read(&active_events) == 0)
-			err = mipspmu_get_irq();
-
-		if (!err)
-			atomic_inc(&active_events);
-		mutex_unlock(&pmu_reserve_mutex);
-	}
-
-	if (err)
-		return err;
-
-	err = __hw_perf_event_init(event);
-	if (err)
-		hw_perf_event_destroy(event);
-
-	return err;
-}
-
-static struct pmu pmu = {
-	.pmu_enable	= mipspmu_enable,
-	.pmu_disable	= mipspmu_disable,
-	.event_init	= mipspmu_event_init,
-	.add		= mipspmu_add,
-	.del		= mipspmu_del,
-	.start		= mipspmu_start,
-	.stop		= mipspmu_stop,
-	.read		= mipspmu_read,
-};
-
-static unsigned int mipspmu_perf_event_encode(const struct mips_perf_event *pev)
-{
-/*
- * Top 8 bits for range, next 16 bits for cntr_mask, lowest 8 bits for
- * event_id.
- */
-#ifdef CONFIG_MIPS_MT_SMP
-	return ((unsigned int)pev->range << 24) |
-		(pev->cntr_mask & 0xffff00) |
-		(pev->event_id & 0xff);
-#else
-	return (pev->cntr_mask & 0xffff00) |
-		(pev->event_id & 0xff);
-#endif
-}
-
-static const struct mips_perf_event *mipspmu_map_general_event(int idx)
-{
-	const struct mips_perf_event *pev;
-
-	pev = ((*mipspmu->general_event_map)[idx].event_id ==
-		UNSUPPORTED_PERF_EVENT_ID ? ERR_PTR(-EOPNOTSUPP) :
-		&(*mipspmu->general_event_map)[idx]);
-
-	return pev;
-}
-
-static const struct mips_perf_event *mipspmu_map_cache_event(u64 config)
-{
-	unsigned int cache_type, cache_op, cache_result;
-	const struct mips_perf_event *pev;
-
-	cache_type = (config >> 0) & 0xff;
-	if (cache_type >= PERF_COUNT_HW_CACHE_MAX)
-		return ERR_PTR(-EINVAL);
-
-	cache_op = (config >> 8) & 0xff;
-	if (cache_op >= PERF_COUNT_HW_CACHE_OP_MAX)
-		return ERR_PTR(-EINVAL);
-
-	cache_result = (config >> 16) & 0xff;
-	if (cache_result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
-		return ERR_PTR(-EINVAL);
-
-	pev = &((*mipspmu->cache_event_map)
-					[cache_type]
-					[cache_op]
-					[cache_result]);
-
-	if (pev->event_id == UNSUPPORTED_PERF_EVENT_ID)
-		return ERR_PTR(-EOPNOTSUPP);
-
-	return pev;
-
-}
-
-static int validate_event(struct cpu_hw_events *cpuc,
-	       struct perf_event *event)
-{
-	struct hw_perf_event fake_hwc = event->hw;
-
-	/* Allow mixed event group. So return 1 to pass validation. */
-	if (event->pmu != &pmu || event->state <= PERF_EVENT_STATE_OFF)
-		return 1;
-
-	return mipspmu->alloc_counter(cpuc, &fake_hwc) >= 0;
-}
-
-static int validate_group(struct perf_event *event)
-{
-	struct perf_event *sibling, *leader = event->group_leader;
-	struct cpu_hw_events fake_cpuc;
-
-	memset(&fake_cpuc, 0, sizeof(fake_cpuc));
-
-	if (!validate_event(&fake_cpuc, leader))
-		return -ENOSPC;
-
-	list_for_each_entry(sibling, &leader->sibling_list, group_entry) {
-		if (!validate_event(&fake_cpuc, sibling))
-			return -ENOSPC;
-	}
-
-	if (!validate_event(&fake_cpuc, event))
-		return -ENOSPC;
-
-	return 0;
-}
-
-/* This is needed by specific irq handlers in perf_event_*.c */
-static void handle_associated_event(struct cpu_hw_events *cpuc,
-				    int idx, struct perf_sample_data *data,
-				    struct pt_regs *regs)
-{
-	struct perf_event *event = cpuc->events[idx];
-	struct hw_perf_event *hwc = &event->hw;
-
-	mipspmu_event_update(event, hwc, idx);
-	data->period = event->hw.last_period;
-	if (!mipspmu_event_set_period(event, hwc, idx))
-		return;
-
-	if (perf_event_overflow(event, data, regs))
-		mipspmu->disable_event(idx);
-}
-
-#include "perf_event_mipsxx.c"
 
 /* Callchain handling code. */
 
 /*
  * Leave userspace callchain empty for now. When we find a way to trace
- * the user stack callchains, we add here.
+ * the user stack callchains, we will add it here.
  */
-void perf_callchain_user(struct perf_callchain_entry *entry,
-		    struct pt_regs *regs)
-{
-}
 
 static void save_raw_perf_callchain(struct perf_callchain_entry *entry,
 	unsigned long reg29)
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index a5925b5..eb74dce 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -1,5 +1,529 @@
-#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64) || \
-    defined(CONFIG_CPU_R10000) || defined(CONFIG_CPU_SB1)
+/*
+ * Linux performance counter support for MIPS.
+ *
+ * Copyright (C) 2010 MIPS Technologies, Inc.
+ * Author: Deng-Cheng Zhu
+ *
+ * This code is based on the implementation for ARM, which is in turn
+ * based on the sparc64 perf event code and the x86 code. Performance
+ * counter access is based on the MIPS Oprofile code. And the callchain
+ * support references the code of MIPS stacktrace.c.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/cpumask.h>
+#include <linux/interrupt.h>
+#include <linux/smp.h>
+#include <linux/kernel.h>
+#include <linux/perf_event.h>
+#include <linux/uaccess.h>
+
+#include <asm/irq.h>
+#include <asm/irq_regs.h>
+#include <asm/stacktrace.h>
+#include <asm/time.h> /* For perf_irq */
+
+/* These are for 32bit counters. For 64bit ones, define them accordingly. */
+#define MAX_PERIOD	((1ULL << 32) - 1)
+#define VALID_COUNT	0x7fffffff
+#define TOTAL_BITS	32
+#define HIGHEST_BIT	31
+
+#define MIPS_MAX_HWEVENTS 4
+
+struct cpu_hw_events {
+	/* Array of events on this cpu. */
+	struct perf_event	*events[MIPS_MAX_HWEVENTS];
+
+	/*
+	 * Set the bit (indexed by the counter number) when the counter
+	 * is used for an event.
+	 */
+	unsigned long		used_mask[BITS_TO_LONGS(MIPS_MAX_HWEVENTS)];
+
+	/*
+	 * The borrowed MSB for the performance counter. A MIPS performance
+	 * counter uses its bit 31 (for 32bit counters) or bit 63 (for 64bit
+	 * counters) as a factor of determining whether a counter overflow
+	 * should be signaled. So here we use a separate MSB for each
+	 * counter to make things easy.
+	 */
+	unsigned long		msbs[BITS_TO_LONGS(MIPS_MAX_HWEVENTS)];
+
+	/*
+	 * Software copy of the control register for each performance counter.
+	 * MIPS CPUs vary in performance counters. They use this differently,
+	 * and even may not use it.
+	 */
+	unsigned int		saved_ctrl[MIPS_MAX_HWEVENTS];
+};
+DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
+	.saved_ctrl = {0},
+};
+
+/* The description of MIPS performance events. */
+struct mips_perf_event {
+	unsigned int event_id;
+	/*
+	 * MIPS performance counters are indexed starting from 0.
+	 * CNTR_EVEN indicates the indexes of the counters to be used are
+	 * even numbers.
+	 */
+	unsigned int cntr_mask;
+	#define CNTR_EVEN	0x55555555
+	#define CNTR_ODD	0xaaaaaaaa
+#ifdef CONFIG_MIPS_MT_SMP
+	enum {
+		T  = 0,
+		V  = 1,
+		P  = 2,
+	} range;
+#else
+	#define T
+	#define V
+	#define P
+#endif
+};
+
+static struct mips_perf_event raw_event;
+static DEFINE_MUTEX(raw_event_mutex);
+
+#define UNSUPPORTED_PERF_EVENT_ID 0xffffffff
+#define C(x) PERF_COUNT_HW_CACHE_##x
+
+struct mips_pmu {
+	const char	*name;
+	int		irq;
+	irqreturn_t	(*handle_irq)(int irq, void *dev);
+	int		(*handle_shared_irq)(void);
+	void		(*start)(void);
+	void		(*stop)(void);
+	int		(*alloc_counter)(struct cpu_hw_events *cpuc,
+					struct hw_perf_event *hwc);
+	u64		(*read_counter)(unsigned int idx);
+	void		(*write_counter)(unsigned int idx, u64 val);
+	void		(*enable_event)(struct hw_perf_event *evt, int idx);
+	void		(*disable_event)(int idx);
+	const struct mips_perf_event *(*map_raw_event)(u64 config);
+	const struct mips_perf_event (*general_event_map)[PERF_COUNT_HW_MAX];
+	const struct mips_perf_event (*cache_event_map)
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX];
+	unsigned int	num_counters;
+};
+
+static const struct mips_pmu *mipspmu;
+
+static int mipspmu_event_set_period(struct perf_event *event,
+				    struct hw_perf_event *hwc,
+				    int idx)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	s64 left = local64_read(&hwc->period_left);
+	s64 period = hwc->sample_period;
+	int ret = 0;
+	u64 uleft;
+	unsigned long flags;
+
+	if (unlikely(left <= -period)) {
+		left = period;
+		local64_set(&hwc->period_left, left);
+		hwc->last_period = period;
+		ret = 1;
+	}
+
+	if (unlikely(left <= 0)) {
+		left += period;
+		local64_set(&hwc->period_left, left);
+		hwc->last_period = period;
+		ret = 1;
+	}
+
+	if (left > (s64)MAX_PERIOD)
+		left = MAX_PERIOD;
+
+	local64_set(&hwc->prev_count, (u64)-left);
+
+	local_irq_save(flags);
+	uleft = (u64)(-left) & MAX_PERIOD;
+	uleft > VALID_COUNT ?
+		set_bit(idx, cpuc->msbs) : clear_bit(idx, cpuc->msbs);
+	mipspmu->write_counter(idx, (u64)(-left) & VALID_COUNT);
+	local_irq_restore(flags);
+
+	perf_event_update_userpage(event);
+
+	return ret;
+}
+
+static void mipspmu_event_update(struct perf_event *event,
+				 struct hw_perf_event *hwc,
+				 int idx)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	unsigned long flags;
+	int shift = 64 - TOTAL_BITS;
+	s64 prev_raw_count, new_raw_count;
+	u64 delta;
+
+again:
+	prev_raw_count = local64_read(&hwc->prev_count);
+	local_irq_save(flags);
+	/* Make the counter value be a "real" one. */
+	new_raw_count = mipspmu->read_counter(idx);
+	if (new_raw_count & (test_bit(idx, cpuc->msbs) << HIGHEST_BIT)) {
+		new_raw_count &= VALID_COUNT;
+		clear_bit(idx, cpuc->msbs);
+	} else
+		new_raw_count |= (test_bit(idx, cpuc->msbs) << HIGHEST_BIT);
+	local_irq_restore(flags);
+
+	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
+				new_raw_count) != prev_raw_count)
+		goto again;
+
+	delta = (new_raw_count << shift) - (prev_raw_count << shift);
+	delta >>= shift;
+
+	local64_add(delta, &event->count);
+	local64_sub(delta, &hwc->period_left);
+}
+
+static void mipspmu_start(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (!mipspmu)
+		return;
+
+	if (flags & PERF_EF_RELOAD)
+		WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
+
+	hwc->state = 0;
+
+	/* Set the period for the event. */
+	mipspmu_event_set_period(event, hwc, hwc->idx);
+
+	/* Enable the event. */
+	mipspmu->enable_event(hwc, hwc->idx);
+}
+
+static void mipspmu_stop(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (!mipspmu)
+		return;
+
+	if (!(hwc->state & PERF_HES_STOPPED)) {
+		/* We are working on a local event. */
+		mipspmu->disable_event(hwc->idx);
+		barrier();
+		mipspmu_event_update(event, hwc, hwc->idx);
+		hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	}
+}
+
+static int mipspmu_add(struct perf_event *event, int flags)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+	int err = 0;
+
+	perf_pmu_disable(event->pmu);
+
+	/* To look for a free counter for this event. */
+	idx = mipspmu->alloc_counter(cpuc, hwc);
+	if (idx < 0) {
+		err = idx;
+		goto out;
+	}
+
+	/*
+	 * If there is an event in the counter we are going to use then
+	 * make sure it is disabled.
+	 */
+	event->hw.idx = idx;
+	mipspmu->disable_event(idx);
+	cpuc->events[idx] = event;
+
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	if (flags & PERF_EF_START)
+		mipspmu_start(event, PERF_EF_RELOAD);
+
+	/* Propagate our changes to the userspace mapping. */
+	perf_event_update_userpage(event);
+
+out:
+	perf_pmu_enable(event->pmu);
+	return err;
+}
+
+static void mipspmu_del(struct perf_event *event, int flags)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+	WARN_ON(idx < 0 || idx >= mipspmu->num_counters);
+
+	mipspmu_stop(event, PERF_EF_UPDATE);
+	cpuc->events[idx] = NULL;
+	clear_bit(idx, cpuc->used_mask);
+
+	perf_event_update_userpage(event);
+}
+
+static void mipspmu_read(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	/* Don't read disabled counters! */
+	if (hwc->idx < 0)
+		return;
+
+	mipspmu_event_update(event, hwc, hwc->idx);
+}
+
+static void mipspmu_enable(struct pmu *pmu)
+{
+	if (mipspmu)
+		mipspmu->start();
+}
+
+static void mipspmu_disable(struct pmu *pmu)
+{
+	if (mipspmu)
+		mipspmu->stop();
+}
+
+static atomic_t active_events = ATOMIC_INIT(0);
+static DEFINE_MUTEX(pmu_reserve_mutex);
+static int (*save_perf_irq)(void);
+
+static int mipspmu_get_irq(void)
+{
+	int err;
+
+	if (mipspmu->irq >= 0) {
+		/* Request my own irq handler. */
+		err = request_irq(mipspmu->irq, mipspmu->handle_irq,
+			IRQF_DISABLED | IRQF_NOBALANCING,
+			"mips_perf_pmu", NULL);
+		if (err) {
+			pr_warning("Unable to request IRQ%d for MIPS "
+			   "performance counters!\n", mipspmu->irq);
+		}
+	} else if (cp0_perfcount_irq < 0) {
+		/*
+		 * We are sharing the irq number with the timer interrupt.
+		 */
+		save_perf_irq = perf_irq;
+		perf_irq = mipspmu->handle_shared_irq;
+		err = 0;
+	} else {
+		pr_warning("The platform hasn't properly defined its "
+			"interrupt controller.\n");
+		err = -ENOENT;
+	}
+
+	return err;
+}
+
+static void mipspmu_free_irq(void)
+{
+	if (mipspmu->irq >= 0)
+		free_irq(mipspmu->irq, NULL);
+	else if (cp0_perfcount_irq < 0)
+		perf_irq = save_perf_irq;
+}
+
+/*
+ * mipsxx/rm9000/loongson2 have different performance counters, they have
+ * specific low-level init routines.
+ */
+static void reset_counters(void *arg);
+static int __hw_perf_event_init(struct perf_event *event);
+
+static void hw_perf_event_destroy(struct perf_event *event)
+{
+	if (atomic_dec_and_mutex_lock(&active_events,
+				&pmu_reserve_mutex)) {
+		/*
+		 * We must not call the destroy function with interrupts
+		 * disabled.
+		 */
+		on_each_cpu(reset_counters,
+			(void *)(long)mipspmu->num_counters, 1);
+		mipspmu_free_irq();
+		mutex_unlock(&pmu_reserve_mutex);
+	}
+}
+
+static int mipspmu_event_init(struct perf_event *event)
+{
+	int err = 0;
+
+	switch (event->attr.type) {
+	case PERF_TYPE_RAW:
+	case PERF_TYPE_HARDWARE:
+	case PERF_TYPE_HW_CACHE:
+		break;
+
+	default:
+		return -ENOENT;
+	}
+
+	if (!mipspmu || event->cpu >= nr_cpumask_bits ||
+		(event->cpu >= 0 && !cpu_online(event->cpu)))
+		return -ENODEV;
+
+	if (!atomic_inc_not_zero(&active_events)) {
+		if (atomic_read(&active_events) > MIPS_MAX_HWEVENTS) {
+			atomic_dec(&active_events);
+			return -ENOSPC;
+		}
+
+		mutex_lock(&pmu_reserve_mutex);
+		if (atomic_read(&active_events) == 0)
+			err = mipspmu_get_irq();
+
+		if (!err)
+			atomic_inc(&active_events);
+		mutex_unlock(&pmu_reserve_mutex);
+	}
+
+	if (err)
+		return err;
+
+	err = __hw_perf_event_init(event);
+	if (err)
+		hw_perf_event_destroy(event);
+
+	return err;
+}
+
+static struct pmu pmu = {
+	.pmu_enable	= mipspmu_enable,
+	.pmu_disable	= mipspmu_disable,
+	.event_init	= mipspmu_event_init,
+	.add		= mipspmu_add,
+	.del		= mipspmu_del,
+	.start		= mipspmu_start,
+	.stop		= mipspmu_stop,
+	.read		= mipspmu_read,
+};
+
+static unsigned int mipspmu_perf_event_encode(const struct mips_perf_event *pev)
+{
+/*
+ * Top 8 bits for range, next 16 bits for cntr_mask, lowest 8 bits for
+ * event_id.
+ */
+#ifdef CONFIG_MIPS_MT_SMP
+	return ((unsigned int)pev->range << 24) |
+		(pev->cntr_mask & 0xffff00) |
+		(pev->event_id & 0xff);
+#else
+	return (pev->cntr_mask & 0xffff00) |
+		(pev->event_id & 0xff);
+#endif
+}
+
+static const struct mips_perf_event *mipspmu_map_general_event(int idx)
+{
+	const struct mips_perf_event *pev;
+
+	pev = ((*mipspmu->general_event_map)[idx].event_id ==
+		UNSUPPORTED_PERF_EVENT_ID ? ERR_PTR(-EOPNOTSUPP) :
+		&(*mipspmu->general_event_map)[idx]);
+
+	return pev;
+}
+
+static const struct mips_perf_event *mipspmu_map_cache_event(u64 config)
+{
+	unsigned int cache_type, cache_op, cache_result;
+	const struct mips_perf_event *pev;
+
+	cache_type = (config >> 0) & 0xff;
+	if (cache_type >= PERF_COUNT_HW_CACHE_MAX)
+		return ERR_PTR(-EINVAL);
+
+	cache_op = (config >> 8) & 0xff;
+	if (cache_op >= PERF_COUNT_HW_CACHE_OP_MAX)
+		return ERR_PTR(-EINVAL);
+
+	cache_result = (config >> 16) & 0xff;
+	if (cache_result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
+		return ERR_PTR(-EINVAL);
+
+	pev = &((*mipspmu->cache_event_map)
+					[cache_type]
+					[cache_op]
+					[cache_result]);
+
+	if (pev->event_id == UNSUPPORTED_PERF_EVENT_ID)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	return pev;
+
+}
+
+static int validate_event(struct cpu_hw_events *cpuc,
+	       struct perf_event *event)
+{
+	struct hw_perf_event fake_hwc = event->hw;
+
+	/* Allow mixed event group. So return 1 to pass validation. */
+	if (event->pmu != &pmu || event->state <= PERF_EVENT_STATE_OFF)
+		return 1;
+
+	return mipspmu->alloc_counter(cpuc, &fake_hwc) >= 0;
+}
+
+static int validate_group(struct perf_event *event)
+{
+	struct perf_event *sibling, *leader = event->group_leader;
+	struct cpu_hw_events fake_cpuc;
+
+	memset(&fake_cpuc, 0, sizeof(fake_cpuc));
+
+	if (!validate_event(&fake_cpuc, leader))
+		return -ENOSPC;
+
+	list_for_each_entry(sibling, &leader->sibling_list, group_entry) {
+		if (!validate_event(&fake_cpuc, sibling))
+			return -ENOSPC;
+	}
+
+	if (!validate_event(&fake_cpuc, event))
+		return -ENOSPC;
+
+	return 0;
+}
+
+/* This is needed by specific irq handlers in perf_event_*.c */
+static void handle_associated_event(struct cpu_hw_events *cpuc,
+				    int idx, struct perf_sample_data *data,
+				    struct pt_regs *regs)
+{
+	struct perf_event *event = cpuc->events[idx];
+	struct hw_perf_event *hwc = &event->hw;
+
+	mipspmu_event_update(event, hwc, idx);
+	data->period = event->hw.last_period;
+	if (!mipspmu_event_set_period(event, hwc, idx))
+		return;
+
+	if (perf_event_overflow(event, data, regs))
+		mipspmu->disable_event(idx);
+}
 
 #define M_CONFIG1_PC	(1 << 4)
 
@@ -1062,5 +1586,3 @@ init_hw_perf_events(void)
 	return 0;
 }
 early_initcall(init_hw_perf_events);
-
-#endif /* defined(CONFIG_CPU_MIPS32)... */
-- 
1.7.2.3
