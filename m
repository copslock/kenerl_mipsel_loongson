Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Nov 2010 10:18:15 +0100 (CET)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:47691 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491830Ab0K2JRX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Nov 2010 10:17:23 +0100
Received: by mail-gw0-f49.google.com with SMTP id 20so2076191gwj.36
        for <multiple recipients>; Mon, 29 Nov 2010 01:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2Y0t/ci8xgIxHcLi3Qxk3IC2JhOLrB5FWek0K84jT5Y=;
        b=sZpaHgsP/7FSr9uZa7hyUxp4wz344IxJbDQKTyKcZWG2muCxOeBNBiXahgDieLWwB2
         28n/v2Wu3neH7vNJIQ+UwXk/DMf4qbMGag9bsKBMojHtcEAPHOQsaIIt5laW5EUmDJEI
         2AxY3YXGi6keXxC3YvYNiCwYMGzbgAjkr2efM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=F7FamwyHoKLmNLts1DXyO2ynC7I2qJ7mKx9dDT+NVgbFmVA1gygTRpKLs4u/rCnu1+
         2dMHtq9PHkYAy09wUzsiaTvdAlnK3TIbMGKFfL33sq1bA9bJ/A6k4eZnOeErstqhLmUf
         kAR6NFC569UnfN4YJp07aHKD6LJEVbUkukEt4=
Received: by 10.151.27.1 with SMTP id e1mr9849148ybj.276.1291022242937;
        Mon, 29 Nov 2010 01:17:22 -0800 (PST)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id u68sm522697yhc.47.2010.11.29.01.17.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 01:17:22 -0800 (PST)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     ralf@linux-mips.org, a.p.zijlstra@chello.nl, fweisbec@gmail.com,
        will.deacon@arm.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, dengcheng.zhu@gmail.com, matt@console-pimps.org,
        sshtylyov@mvista.com
Subject: [PATCH v3 2/5] MIPS/Perf-events: Work with the new PMU interface
Date:   Mon, 29 Nov 2010 17:19:08 +0800
Message-Id: <1291022351-13152-3-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1291022351-13152-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1291022351-13152-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

This is the MIPS part of the following commits by Peter Zijlstra:

- a4eaf7f14675cb512d69f0c928055e73d0c6d252
    perf: Rework the PMU methods

    Replace pmu::{enable,disable,start,stop,unthrottle} with
    pmu::{add,del,start,stop}, all of which take a flags argument.

    The new interface extends the capability to stop a counter while
    keeping it scheduled on the PMU. We replace the throttled state with
    the generic stopped state.

    This also allows us to efficiently stop/start counters over certain
    code paths (like IRQ handlers).

    It also allows scheduling a counter without it starting, allowing for
    a generic frozen state (useful for rotating stopped counters).

    The stopped state is implemented in two different ways, depending on
    how the architecture implemented the throttled state:

     1) We disable the counter:
        a) the pmu has per-counter enable bits, we flip that
        b) we program a NOP event, preserving the counter state

     2) We store the counter state and ignore all read/overflow events

For MIPSXX, the stopped state is implemented in the way of 1.b as above.

- 33696fc0d141bbbcb12f75b69608ea83282e3117
    perf: Per PMU disable

    Changes perf_disable() into perf_pmu_disable().

- 24cd7f54a0d47e1d5b3de29e2456bfbd2d8447b7
    perf: Reduce perf_disable() usage

    Since the current perf_disable() usage is only an optimization,
    remove it for now. This eases the removal of the __weak
    hw_perf_enable() interface.

- b0a873ebbf87bf38bf70b5e39a7cadc96099fa13
    perf: Register PMU implementations

    Simple registration interface for struct pmu, this provides the
    infrastructure for removing all the weak functions.

- 51b0fe39549a04858001922919ab355dee9bdfcf
    perf: Deconstify struct pmu

    sed -ie 's/const struct pmu\>/struct pmu/g' `git grep -l "const struct pmu\>"`

Reported-by: Wu Zhangjin <wuzhangjin@gmail.com>
Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/kernel/perf_event.c        |  275 +++++++++++++++++++---------------
 arch/mips/kernel/perf_event_mipsxx.c |    2 +
 2 files changed, 158 insertions(+), 119 deletions(-)

diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
index 2b7f3f7..1ee44a3 100644
--- a/arch/mips/kernel/perf_event.c
+++ b/arch/mips/kernel/perf_event.c
@@ -161,41 +161,6 @@ mipspmu_event_set_period(struct perf_event *event,
 	return ret;
 }
 
-static int mipspmu_enable(struct perf_event *event)
-{
-	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
-	struct hw_perf_event *hwc = &event->hw;
-	int idx;
-	int err = 0;
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
-	/* Set the period for the event. */
-	mipspmu_event_set_period(event, hwc, idx);
-
-	/* Enable the event. */
-	mipspmu->enable_event(hwc, idx);
-
-	/* Propagate our changes to the userspace mapping. */
-	perf_event_update_userpage(event);
-
-out:
-	return err;
-}
-
 static void mipspmu_event_update(struct perf_event *event,
 			struct hw_perf_event *hwc,
 			int idx)
@@ -231,32 +196,90 @@ again:
 	return;
 }
 
-static void mipspmu_disable(struct perf_event *event)
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
 {
 	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
-	int idx = hwc->idx;
+	int idx;
+	int err = 0;
 
+	perf_pmu_disable(event->pmu);
 
-	WARN_ON(idx < 0 || idx >= mipspmu->num_counters);
+	/* To look for a free counter for this event. */
+	idx = mipspmu->alloc_counter(cpuc, hwc);
+	if (idx < 0) {
+		err = idx;
+		goto out;
+	}
 
-	/* We are working on a local event. */
+	/*
+	 * If there is an event in the counter we are going to use then
+	 * make sure it is disabled.
+	 */
+	event->hw.idx = idx;
 	mipspmu->disable_event(idx);
+	cpuc->events[idx] = event;
 
-	barrier();
-
-	mipspmu_event_update(event, hwc, idx);
-	cpuc->events[idx] = NULL;
-	clear_bit(idx, cpuc->used_mask);
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	if (flags & PERF_EF_START)
+		mipspmu_start(event, PERF_EF_RELOAD);
 
+	/* Propagate our changes to the userspace mapping. */
 	perf_event_update_userpage(event);
+
+out:
+	perf_pmu_enable(event->pmu);
+	return err;
 }
 
-static void mipspmu_unthrottle(struct perf_event *event)
+static void mipspmu_del(struct perf_event *event, int flags)
 {
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
 
-	mipspmu->enable_event(hwc, hwc->idx);
+	WARN_ON(idx < 0 || idx >= mipspmu->num_counters);
+
+	mipspmu_stop(event, PERF_EF_UPDATE);
+	cpuc->events[idx] = NULL;
+	clear_bit(idx, cpuc->used_mask);
+
+	perf_event_update_userpage(event);
 }
 
 static void mipspmu_read(struct perf_event *event)
@@ -270,12 +293,17 @@ static void mipspmu_read(struct perf_event *event)
 	mipspmu_event_update(event, hwc, hwc->idx);
 }
 
-static struct pmu pmu = {
-	.enable		= mipspmu_enable,
-	.disable	= mipspmu_disable,
-	.unthrottle	= mipspmu_unthrottle,
-	.read		= mipspmu_read,
-};
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
 
 static atomic_t active_events = ATOMIC_INIT(0);
 static DEFINE_MUTEX(pmu_reserve_mutex);
@@ -318,6 +346,82 @@ static void mipspmu_free_irq(void)
 		perf_irq = save_perf_irq;
 }
 
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
 static inline unsigned int
 mipspmu_perf_event_encode(const struct mips_perf_event *pev)
 {
@@ -409,73 +513,6 @@ static int validate_group(struct perf_event *event)
 	return 0;
 }
 
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
-const struct pmu *hw_perf_event_init(struct perf_event *event)
-{
-	int err = 0;
-
-	if (!mipspmu || event->cpu >= nr_cpumask_bits ||
-		(event->cpu >= 0 && !cpu_online(event->cpu)))
-		return ERR_PTR(-ENODEV);
-
-	if (!atomic_inc_not_zero(&active_events)) {
-		if (atomic_read(&active_events) > MIPS_MAX_HWEVENTS) {
-			atomic_dec(&active_events);
-			return ERR_PTR(-ENOSPC);
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
-		return ERR_PTR(err);
-
-	err = __hw_perf_event_init(event);
-	if (err)
-		hw_perf_event_destroy(event);
-
-	return err ? ERR_PTR(err) : &pmu;
-}
-
-void hw_perf_enable(void)
-{
-	if (mipspmu)
-		mipspmu->start();
-}
-
-void hw_perf_disable(void)
-{
-	if (mipspmu)
-		mipspmu->stop();
-}
-
 /* This is needed by specific irq handlers in perf_event_*.c */
 static void
 handle_associated_event(struct cpu_hw_events *cpuc,
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index fa00edc..c9406d6 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -1045,6 +1045,8 @@ init_hw_perf_events(void)
 			"CPU, irq %d%s\n", mipspmu->name, counters, irq,
 			irq < 0 ? " (share with timer interrupt)" : "");
 
+	perf_pmu_register(&pmu);
+
 	return 0;
 }
 arch_initcall(init_hw_perf_events);
-- 
1.7.1
