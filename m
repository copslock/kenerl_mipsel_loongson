Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 May 2010 17:39:24 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:52735 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491795Ab0EOPiK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 May 2010 17:38:10 +0200
Received: by mail-pw0-f49.google.com with SMTP id 3so708651pwi.36
        for <multiple recipients>; Sat, 15 May 2010 08:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BpM+whsWLMJ/avEE7ewSsYeG+vq1C4wTm8rics2iUhA=;
        b=gE8khprNYfFeazCVzAfrpZ954S+jSNHCEm3Ky+fppF4WfXwMsWgoH66IVG1/4ga6AY
         CSt1g/XEmqv2KgdCJf7gjAC7BwxJTm/0aYv3Kt5a0eLtzuDA2qRzzgjZm24/JWPRSWC3
         rIXp8eZgLzLNHhA3o8tSSNFpLaFyJJ5ctswg8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LsQLGRNuj9JUQYQcRI4Z0pVYvgbSf8wuE5vXqmOh8do2dqpZZAy/woW+C3V5hiVqGh
         MhndXWF4VoDKatS9RVrxL9fMCaCf1Y92OlqaK6HH9HWImzSkS83P3jtpRpCNObMBDFzB
         NSTaqHc0sGsaOyoWxvCeq2XyNAe5cUhMx618E=
Received: by 10.115.66.26 with SMTP id t26mr2315999wak.210.1273937889162;
        Sat, 15 May 2010 08:38:09 -0700 (PDT)
Received: from localhost.localdomain ([114.84.90.117])
        by mx.google.com with ESMTPS id n32sm30648683wae.10.2010.05.15.08.38.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 08:38:08 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v4 4/9] MIPS: add support for hardware performance events
Date:   Sat, 15 May 2010 23:36:50 +0800
Message-Id: <1273937815-4781-5-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1273937815-4781-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1273937815-4781-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

This patch is the HW perf event support. To enable this feature, we can
not choose the SMTC kernel; Oprofile should be disabled; kernel
performance events be selected. Then we can enable it in Kernel type menu.

Oprofile for MIPS platforms initializes irq at arch init time. Currently
we do not change this logic to allow PMU reservation.

If a platform has EIC, we can use the irq base and perf counter irq
offset defines for the interrupt controller in mipspmu_get_irq().

Besides generic hardware events and cache events, raw events are also
supported by this patch. Please refer to processor core software user's
manual and the comments for mipsxx_pmu_map_raw_event() for more details.

Generic hardware events, cache events and raw events are currently fully
implemented for 24K/34K/74K/1004K cores which are categorized as mipsxx.
To support other cores in mipsxx (such as MIPS64/R10000/SB1), the generic
hardware event and cache event tables and raw event macros need to be
filled out. To support other CPUs which have different PMU than mipsxx,
such as RM9000 and LOONGSON2, additional files perf_event_$cpu.c need to
be created.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/Kconfig                    |    8 +
 arch/mips/include/asm/perf_event.h   |   28 ++
 arch/mips/kernel/Makefile            |    2 +
 arch/mips/kernel/perf_event.c        |  605 +++++++++++++++++++++++
 arch/mips/kernel/perf_event_mipsxx.c |  869 ++++++++++++++++++++++++++++++++++
 5 files changed, 1512 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/perf_event.h
 create mode 100644 arch/mips/kernel/perf_event.c
 create mode 100644 arch/mips/kernel/perf_event_mipsxx.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 1bccfe5..27577b4 100644
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
index 0000000..bcf54bc
--- /dev/null
+++ b/arch/mips/include/asm/perf_event.h
@@ -0,0 +1,28 @@
+/*
+ * linux/arch/mips/include/asm/perf_event.h
+ *
+ * Copyright (C) 2010 MIPS Technologies, Inc. Deng-Cheng Zhu
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __MIPS_PERF_EVENT_H__
+#define __MIPS_PERF_EVENT_H__
+
+extern int (*perf_irq)(void);
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
index 7a6ac50..c934ab7 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -101,6 +101,8 @@ obj-$(CONFIG_HAVE_STD_PC_SERIAL_PORT)	+= 8250-platform.o
 
 obj-$(CONFIG_MIPS_CPUFREQ)	+= cpufreq/
 
+obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
+
 EXTRA_CFLAGS += -Werror
 
 CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
new file mode 100644
index 0000000..24e07f8
--- /dev/null
+++ b/arch/mips/kernel/perf_event.c
@@ -0,0 +1,605 @@
+/*
+ * Linux performance counter support for MIPS.
+ *
+ * Copyright (C) 2010 MIPS Technologies, Inc. Deng-Cheng Zhu
+ *
+ * This code is based on the implementation for ARM, which is in turn
+ * based on the sparc64 perf event code and the x86 code. Performance
+ * counter access is based on the MIPS Oprofile code. And the callchain
+ * support references the code of MIPS traps.c.
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
+#include <asm/pmu.h>
+
+
+#define MAX_PERIOD ((1ULL << 32) - 1)
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
+	 * counter uses its bit 31 as a factor of determining whether a counter
+	 * overflow should be signaled. So here we use a separate MSB for each
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
+	irqreturn_t	(*handle_irq)(int irq, void *dev);
+	int		(*handle_shared_irq)(void);
+	void		(*start)(void);
+	void		(*stop)(void);
+	int		(*alloc_counter)(struct cpu_hw_events *cpuc,
+					struct hw_perf_event *hwc);
+	unsigned int	(*read_counter)(unsigned int idx);
+	void		(*write_counter)(unsigned int idx, unsigned int val);
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
+static int
+mipspmu_event_set_period(struct perf_event *event,
+			struct hw_perf_event *hwc,
+			int idx)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	s64 left = atomic64_read(&hwc->period_left);
+	s64 period = hwc->sample_period;
+	int ret = 0;
+	unsigned long flags, uleft;
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
+	uleft = (u64)(-left) & 0xffffffff;
+	test_bit(31, &uleft) ?
+		set_bit(idx, cpuc->msbs) : clear_bit(idx, cpuc->msbs);
+	mipspmu->write_counter(idx, (u64)(-left) & 0x7fffffff);
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
+	int shift = 64 - 32;
+	s64 prev_raw_count, new_raw_count;
+	s64 delta;
+
+again:
+	prev_raw_count = atomic64_read(&hwc->prev_count);
+	local_irq_save(flags);
+	/* Make the counter value be a "real" one. */
+	new_raw_count = mipspmu->read_counter(idx);
+	if (new_raw_count & (test_bit(idx, cpuc->msbs) << 31)) {
+		new_raw_count &= 0x7fffffff;
+		clear_bit(idx, cpuc->msbs);
+	} else
+		new_raw_count |= (test_bit(idx, cpuc->msbs) << 31);
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
+#include "perf_event_mipsxx.c"
+
+/*
+ * Callchain handling code.
+ */
+static inline void
+callchain_store(struct perf_callchain_entry *entry,
+		u64 ip)
+{
+	if (entry->nr < PERF_MAX_STACK_DEPTH)
+		entry->ip[entry->nr++] = ip;
+}
+
+static void
+perf_callchain_user(struct pt_regs *regs,
+		    struct perf_callchain_entry *entry)
+{
+	unsigned long *sp;
+	unsigned long addr;
+
+	callchain_store(entry, PERF_CONTEXT_USER);
+
+	if (!user_mode(regs))
+		regs = task_pt_regs(current);
+
+	sp = (unsigned long *)(regs->regs[29] & ~3);
+
+	while (!kstack_end(sp)) {
+		unsigned long __user *p =
+			(unsigned long __user *)(unsigned long)sp++;
+		if (__get_user(addr, p)) {
+			pr_warning("Performance counter callchain "
+				"suppport: Bad stack address.\n");
+			break;
+		}
+		callchain_store(entry, addr);
+	}
+}
+
+static void
+perf_callchain_kernel(struct pt_regs *regs,
+		      struct perf_callchain_entry *entry)
+{
+	unsigned long sp = regs->regs[29];
+	unsigned long ra = regs->regs[31];
+	unsigned long pc = regs->cp0_epc;
+
+	if (unlikely(!__kernel_text_address(pc))) {
+		pr_warning("Performance counter callchain support "
+			"error.\n");
+		return;
+	}
+
+	callchain_store(entry, PERF_CONTEXT_KERNEL);
+
+	do {
+		callchain_store(entry, pc);
+		pc = unwind_stack(current, &sp, pc, &ra);
+	} while (pc);
+}
+
+static void
+perf_do_callchain(struct pt_regs *regs,
+		  struct perf_callchain_entry *entry)
+{
+	int is_user;
+
+	if (!regs)
+		return;
+
+	is_user = user_mode(regs);
+
+	if (!current || !current->pid)
+		return;
+
+	if (is_user && current->state != TASK_RUNNING)
+		return;
+
+	if (!is_user)
+		perf_callchain_kernel(regs, entry);
+
+	if (current->mm)
+		perf_callchain_user(regs, entry);
+}
+
+static DEFINE_PER_CPU(struct perf_callchain_entry, pmc_irq_entry);
+
+struct perf_callchain_entry *
+perf_callchain(struct pt_regs *regs)
+{
+	struct perf_callchain_entry *entry = &__get_cpu_var(pmc_irq_entry);
+
+	entry->nr = 0;
+	perf_do_callchain(regs, entry);
+	return entry;
+}
+
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
new file mode 100644
index 0000000..802d98e
--- /dev/null
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -0,0 +1,869 @@
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
