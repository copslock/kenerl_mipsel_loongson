Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jun 2010 06:37:36 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:35527 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491064Ab0FIEfb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jun 2010 06:35:31 +0200
Received: by pwj6 with SMTP id 6so519757pwj.36
        for <multiple recipients>; Tue, 08 Jun 2010 21:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5SzyF8Y5k4ZxI2Btp6UzeXFg3/4SPH6ZiThDaNIZfX8=;
        b=VXk7XtYgoAWcAdyOh9cdqHNNVDVtlje4lVNKPNC8fLOpUy23vmKsYzblks4Z1yGQ2y
         DiQxymXS0qxSET81XtT4208hlfrlwyWp8Z7wIuzSj7wkV9N+l3Fb30elk2612uUW6x8d
         L+dHY+f2MCiX3DRIz4di4PEv2nC1YraKcUDYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=k61oBEoy4Jsg7X/PNC60e+syoVCSYItwMyS9bKvcMnSqnMV1I1+qzdoJMaL7eLjGOw
         LV4vv8so8KV/OvXiJ6eNRL4q3VB/0cx1rXSRhryOjT8n2M9oPVJRFJgCxeA7cEiKp6po
         pj5PuTJs1mytuQ6zrt28Eg6bxgsZdvntjetKw=
Received: by 10.143.169.5 with SMTP id w5mr12619447wfo.222.1276058123456;
        Tue, 08 Jun 2010 21:35:23 -0700 (PDT)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id 22sm4483464pzk.9.2010.06.08.21.35.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jun 2010 21:35:23 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v6 4/7] MIPS: add support for hardware performance events (skeleton)
Date:   Wed,  9 Jun 2010 12:35:27 +0800
Message-Id: <1276058130-25851-5-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1276058130-25851-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1276058130-25851-1-git-send-email-dengcheng.zhu@gmail.com>
X-archive-position: 27097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6109

This patch provides the skeleton of the HW perf event support. To enable
this feature, we can not choose the SMTC kernel; Oprofile should be
disabled; kernel performance events be selected. Then we can enable it in
Kernel type menu.

Oprofile for MIPS platforms initializes irq at arch init time. Currently
we do not change this logic to allow PMU reservation.

If a platform has EIC, we can use the irq base and perf counter irq
offset defines for the interrupt controller in mipspmu_get_irq().

Based on this skeleton patch, the 3 different kinds of MIPS PMU, namely,
mipsxx/loongson2/rm9000, can be supported by adding corresponding lower
level C files at the bottom. The suggested names of these files are
perf_event_mipsxx.c/perf_event_loongson2.c/perf_event_rm9000.c. So, for
example, we can do this by adding "#include perf_event_mipsxx.c" at the
bottom of perf_event.c.

In addition, PMUs with 64bit counters are also considered in this patch.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/Kconfig                  |    8 +
 arch/mips/include/asm/perf_event.h |   26 ++
 arch/mips/kernel/Makefile          |    2 +
 arch/mips/kernel/perf_event.c      |  510 ++++++++++++++++++++++++++++++++++++
 4 files changed, 546 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/perf_event.h
 create mode 100644 arch/mips/kernel/perf_event.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 378c25d..653d574 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1888,6 +1888,14 @@ config NODES_SHIFT
 	default "6"
 	depends on NEED_MULTIPLE_NODES
 
+config HW_PERF_EVENTS
+	bool "Enable hardware performance counter support for perf events"
+	depends on PERF_EVENTS && !MIPS_MT_SMTC && OPROFILE=n && CPU_MIPS32
+	default y
+	help
+	  Enable hardware performance counter support for perf events. If
+	  disabled, perf events will use software events only.
+
 source "mm/Kconfig"
 
 config SMP
diff --git a/arch/mips/include/asm/perf_event.h b/arch/mips/include/asm/perf_event.h
new file mode 100644
index 0000000..ad8f986
--- /dev/null
+++ b/arch/mips/include/asm/perf_event.h
@@ -0,0 +1,26 @@
+/*
+ * linux/arch/mips/include/asm/perf_event.h
+ *
+ * Copyright (C) 2010 MIPS Technologies, Inc.
+ * Author: Deng-Cheng Zhu
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __MIPS_PERF_EVENT_H__
+#define __MIPS_PERF_EVENT_H__
+
+/*
+ * MIPS performance counters do not raise NMI upon overflow, a regular
+ * interrupt will be signaled. Hence we can do the pending perf event
+ * work at the tail of the irq handler.
+ */
+static inline void
+set_perf_event_pending(void)
+{
+}
+
+#endif /* __MIPS_PERF_EVENT_H__ */
+
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index ff5ec2e..c037121 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -101,4 +101,6 @@ obj-$(CONFIG_HAVE_STD_PC_SERIAL_PORT)	+= 8250-platform.o
 
 obj-$(CONFIG_MIPS_CPUFREQ)	+= cpufreq/
 
+obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
+
 CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
new file mode 100644
index 0000000..51e31e2
--- /dev/null
+++ b/arch/mips/kernel/perf_event.c
@@ -0,0 +1,510 @@
+/*
+ * Linux performance counter support for MIPS.
+ *
+ * Copyright (C) 2010 MIPS Technologies, Inc.
+ * Author: Deng-Cheng Zhu
+ *
+ * This code is based on the implementation for ARM, which is in turn
+ * based on the sparc64 perf event code and the x86 code. Performance
+ * counter access is based on the MIPS Oprofile code.
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
+#include <asm/pmu.h>
+
+/* These are for 32bit counters. For 64bit ones, define them accordingly. */
+#define MAX_PERIOD	((1ULL << 32) - 1)
+#define VALID_COUNT	0x7fffffff
+#define TOTAL_BITS	32
+#define HIGHEST_BIT	31
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
+#define UNSUPPORTED_PERF_EVENT_ID 0xffffffff
+#define C(x) PERF_COUNT_HW_CACHE_##x
+
+struct mips_pmu {
+	const char	*name;
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
+static int
+mipspmu_event_set_period(struct perf_event *event,
+			struct hw_perf_event *hwc,
+			int idx)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	s64 left = atomic64_read(&hwc->period_left);
+	s64 period = hwc->sample_period;
+	int ret = 0;
+	u64 uleft;
+	unsigned long flags;
+
+	if (unlikely(left <= -period)) {
+		left = period;
+		atomic64_set(&hwc->period_left, left);
+		hwc->last_period = period;
+		ret = 1;
+	}
+
+	if (unlikely(left <= 0)) {
+		left += period;
+		atomic64_set(&hwc->period_left, left);
+		hwc->last_period = period;
+		ret = 1;
+	}
+
+	if (left > (s64)MAX_PERIOD)
+		left = MAX_PERIOD;
+
+	atomic64_set(&hwc->prev_count, (u64)-left);
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
+static int mipspmu_enable(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+	int err = 0;
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
+	/* Set the period for the event. */
+	mipspmu_event_set_period(event, hwc, idx);
+
+	/* Enable the event. */
+	mipspmu->enable_event(hwc, idx);
+
+	/* Propagate our changes to the userspace mapping. */
+	perf_event_update_userpage(event);
+
+out:
+	return err;
+}
+
+static void mipspmu_event_update(struct perf_event *event,
+			struct hw_perf_event *hwc,
+			int idx)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	unsigned long flags;
+	int shift = 64 - TOTAL_BITS;
+	s64 prev_raw_count, new_raw_count;
+	s64 delta;
+
+again:
+	prev_raw_count = atomic64_read(&hwc->prev_count);
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
+	if (atomic64_cmpxchg(&hwc->prev_count, prev_raw_count,
+				new_raw_count) != prev_raw_count)
+		goto again;
+
+	delta = (new_raw_count << shift) - (prev_raw_count << shift);
+	delta >>= shift;
+
+	atomic64_add(delta, &event->count);
+	atomic64_sub(delta, &hwc->period_left);
+
+	return;
+}
+
+static void mipspmu_disable(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+
+	WARN_ON(idx < 0 || idx >= mipspmu->num_counters);
+
+	/* We are working on a local event. */
+	mipspmu->disable_event(idx);
+
+	barrier();
+
+	mipspmu_event_update(event, hwc, idx);
+	cpuc->events[idx] = NULL;
+	clear_bit(idx, cpuc->used_mask);
+
+	perf_event_update_userpage(event);
+}
+
+static void mipspmu_unthrottle(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	mipspmu->enable_event(hwc, hwc->idx);
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
+static struct pmu pmu = {
+	.enable		= mipspmu_enable,
+	.disable	= mipspmu_disable,
+	.unthrottle	= mipspmu_unthrottle,
+	.read		= mipspmu_read,
+};
+
+static atomic_t active_events = ATOMIC_INIT(0);
+static DEFINE_MUTEX(pmu_reserve_mutex);
+static int mips_pmu_irq = -1;
+static int (*save_perf_irq)(void);
+
+static int mipspmu_get_irq(void)
+{
+	int err;
+
+	if (cpu_has_veic) {
+		/*
+		 * Using platform specific interrupt controller defines.
+		 */
+#ifdef MSC01E_INT_BASE
+		mips_pmu_irq = MSC01E_INT_BASE + MSC01E_INT_PERFCTR;
+#endif
+	} else if (cp0_perfcount_irq >= 0) {
+		/*
+		 * Some CPUs have explicitly defined their perfcount irq.
+		 */
+#if defined(CONFIG_CPU_RM9000)
+		mips_pmu_irq = rm9000_perfcount_irq;
+#elif defined(CONFIG_CPU_LOONGSON2)
+		mips_pmu_irq = LOONGSON2_PERFCNT_IRQ;
+#else
+		mips_pmu_irq = MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
+#endif
+	}
+
+	if (mips_pmu_irq >= 0) {
+		/* Request my own irq handler. */
+		err = request_irq(mips_pmu_irq, mipspmu->handle_irq,
+			IRQF_DISABLED | IRQF_NOBALANCING,
+			"mips_perf_pmu", NULL);
+		if (err) {
+			pr_warning("Unable to request IRQ%d for MIPS "
+			   "performance counters!\n", mips_pmu_irq);
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
+	if (mips_pmu_irq >= 0)
+		free_irq(mips_pmu_irq, NULL);
+	else if (cp0_perfcount_irq < 0)
+		perf_irq = save_perf_irq;
+
+	mips_pmu_irq = -1;
+}
+
+static inline unsigned int
+mipspmu_perf_event_encode(const struct mips_perf_event *pev)
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
+static const struct mips_perf_event *
+mipspmu_map_general_event(int idx)
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
+static const struct mips_perf_event *
+mipspmu_map_cache_event(u64 config)
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
+	if (event->pmu && event->pmu != &pmu)
+		return 0;
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
+/*
+ * mipsxx/rm9000/loongson2 have different performance counters, they have
+ * specific low-level init routines.
+ */
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
+const struct pmu *hw_perf_event_init(struct perf_event *event)
+{
+	int err = 0;
+
+	if (!mipspmu || event->cpu >= nr_cpumask_bits ||
+		(event->cpu >= 0 && !cpu_online(event->cpu)))
+		return ERR_PTR(-ENODEV);
+
+	if (!atomic_inc_not_zero(&active_events)) {
+		if (atomic_read(&active_events) > MIPS_MAX_HWEVENTS) {
+			atomic_dec(&active_events);
+			return ERR_PTR(-ENOSPC);
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
+		return ERR_PTR(err);
+
+	err = __hw_perf_event_init(event);
+	if (err)
+		hw_perf_event_destroy(event);
+
+	return err ? ERR_PTR(err) : &pmu;
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
+/* This is needed by specific irq handlers in perf_event_*.c */
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
-- 
1.6.3.3
