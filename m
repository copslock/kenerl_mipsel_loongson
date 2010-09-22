Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Sep 2010 14:27:16 +0200 (CEST)
Received: from arkanian.console-pimps.org ([212.110.184.194]:57719 "EHLO
        arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491194Ab0IVM1N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Sep 2010 14:27:13 +0200
Received: by arkanian.console-pimps.org (Postfix, from userid 1002)
        id EF10D4432F; Wed, 22 Sep 2010 13:27:12 +0100 (BST)
Received: from localhost (87-194-181-196.bethere.co.uk [87.194.181.196])
        by arkanian.console-pimps.org (Postfix) with ESMTPSA id 06FFB4432D;
        Wed, 22 Sep 2010 13:27:11 +0100 (BST)
Date:   Wed, 22 Sep 2010 13:27:11 +0100
From:   Matt Fleming <matt@console-pimps.org>
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com
Subject: Re: [PATCH v6 4/7] MIPS: add support for hardware performance
 events (skeleton)
Message-ID: <20100922122711.GB6392@console-pimps.org>
References: <1276058130-25851-1-git-send-email-dengcheng.zhu@gmail.com>
 <1276058130-25851-5-git-send-email-dengcheng.zhu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1276058130-25851-5-git-send-email-dengcheng.zhu@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 27791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt@console-pimps.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 17189

On Wed, Jun 09, 2010 at 12:35:27PM +0800, Deng-Cheng Zhu wrote:

[...]

> +static void mipspmu_event_update(struct perf_event *event,
> +			struct hw_perf_event *hwc,
> +			int idx)
> +{
> +	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
> +	unsigned long flags;
> +	int shift = 64 - TOTAL_BITS;
> +	s64 prev_raw_count, new_raw_count;
> +	s64 delta;
> +
> +again:
> +	prev_raw_count = atomic64_read(&hwc->prev_count);
> +	local_irq_save(flags);
> +	/* Make the counter value be a "real" one. */
> +	new_raw_count = mipspmu->read_counter(idx);
> +	if (new_raw_count & (test_bit(idx, cpuc->msbs) << HIGHEST_BIT)) {
> +		new_raw_count &= VALID_COUNT;
> +		clear_bit(idx, cpuc->msbs);
> +	} else
> +		new_raw_count |= (test_bit(idx, cpuc->msbs) << HIGHEST_BIT);
> +	local_irq_restore(flags);

I'm probably just being stupid but I can't figure out what this snippet
of code is doing. You're checking to see if the counter has overflowed,
and if it has then you just clear the overflow bit? I would have
expected you to reset the counter to 0.

> +	if (atomic64_cmpxchg(&hwc->prev_count, prev_raw_count,
> +				new_raw_count) != prev_raw_count)
> +		goto again;
> +
> +	delta = (new_raw_count << shift) - (prev_raw_count << shift);
> +	delta >>= shift;
> +
> +	atomic64_add(delta, &event->count);
> +	atomic64_sub(delta, &hwc->period_left);
> +
> +	return;
> +}
> +
> +static void mipspmu_disable(struct perf_event *event)
> +{
> +	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx = hwc->idx;
> +
> +
> +	WARN_ON(idx < 0 || idx >= mipspmu->num_counters);
> +
> +	/* We are working on a local event. */
> +	mipspmu->disable_event(idx);
> +
> +	barrier();
> +
> +	mipspmu_event_update(event, hwc, idx);
> +	cpuc->events[idx] = NULL;
> +	clear_bit(idx, cpuc->used_mask);

Shouldn't you also clear the overflow bit in ->msbs here?

> +
> +	perf_event_update_userpage(event);
> +}
> +
> +static void mipspmu_unthrottle(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	mipspmu->enable_event(hwc, hwc->idx);
> +}
> +
> +static void mipspmu_read(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	/* Don't read disabled counters! */
> +	if (hwc->idx < 0)
> +		return;
> +
> +	mipspmu_event_update(event, hwc, hwc->idx);
> +}
> +
> +static struct pmu pmu = {
> +	.enable		= mipspmu_enable,
> +	.disable	= mipspmu_disable,
> +	.unthrottle	= mipspmu_unthrottle,
> +	.read		= mipspmu_read,
> +};
> +
> +static atomic_t active_events = ATOMIC_INIT(0);
> +static DEFINE_MUTEX(pmu_reserve_mutex);
> +static int mips_pmu_irq = -1;
> +static int (*save_perf_irq)(void);
> +
> +static int mipspmu_get_irq(void)
> +{
> +	int err;
> +
> +	if (cpu_has_veic) {
> +		/*
> +		 * Using platform specific interrupt controller defines.
> +		 */
> +#ifdef MSC01E_INT_BASE
> +		mips_pmu_irq = MSC01E_INT_BASE + MSC01E_INT_PERFCTR;
> +#endif
> +	} else if (cp0_perfcount_irq >= 0) {
> +		/*
> +		 * Some CPUs have explicitly defined their perfcount irq.
> +		 */
> +#if defined(CONFIG_CPU_RM9000)
> +		mips_pmu_irq = rm9000_perfcount_irq;
> +#elif defined(CONFIG_CPU_LOONGSON2)
> +		mips_pmu_irq = LOONGSON2_PERFCNT_IRQ;
> +#else
> +		mips_pmu_irq = MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
> +#endif
> +	}

Having conditional code like this is a pretty sure sign that you haven't
separated support for the various performance hardware properly. Have
you had a look at how SH uses a registration interface to register
sh_pmus?  Ideally all the internals for each type of perfcounter
hardware should be in their own file.

> +
> +	if (mips_pmu_irq >= 0) {
> +		/* Request my own irq handler. */
> +		err = request_irq(mips_pmu_irq, mipspmu->handle_irq,
> +			IRQF_DISABLED | IRQF_NOBALANCING,
> +			"mips_perf_pmu", NULL);
> +		if (err) {
> +			pr_warning("Unable to request IRQ%d for MIPS "
> +			   "performance counters!\n", mips_pmu_irq);
> +		}
> +	} else if (cp0_perfcount_irq < 0) {
> +		/*
> +		 * We are sharing the irq number with the timer interrupt.
> +		 */
> +		save_perf_irq = perf_irq;
> +		perf_irq = mipspmu->handle_shared_irq;
> +		err = 0;

SH also has this problem that it doesn't have any sort of performance
counter interrupt and so can't check for overflow. This lack of
interrupt really needs to be solved generically in perf as it's a
problem that effects quite a few architectures. I suspect that using a
hrtimer instead of piggy-backing the timer interrupt would make the core
perf guys happier. Writing support for this is on my ever-growing list
of things todo. I've already started on some patches for the perf tool
so that it's possible to sample counters even though there is no
periodic interrupt (but that's a different problem).
