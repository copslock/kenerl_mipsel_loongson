Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jun 2007 19:05:57 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:23764 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20022442AbXF0SFx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 27 Jun 2007 19:05:53 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 00A4C3ECF; Wed, 27 Jun 2007 11:05:18 -0700 (PDT)
Message-ID: <4682A748.2000108@ru.mvista.com>
Date:	Wed, 27 Jun 2007 22:07:04 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Franck <vagabon.xyz@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [RFC Implement clockevents/clocksource for R4000-style cp0 timer
 [take #3]
References: <467F8C34.7080904@innova-card.com>
In-Reply-To: <467F8C34.7080904@innova-card.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Franck Bui-Huu wrote:

> This patch is an attempt to add clocksource/clockevent support for
> platforms that use R4000-style cp0 timer as the tick source of the
> system.

[...]

> It implements clockevent/clocksource support for cp0 counter in a new
> file "hpt-cp0.c" but let the platform code to initialize it if it
> chooses to use it. Therefore there's no more generic code which tries
> to guess what the platform wants to use as tick source because in
> practice only the platform code can drive the initialization of all
> timer devices and interrupts properly.

> Take #3 includes minor changes (Thanks to Sergei Shtylyov's feedbacks)


> Changes since take #2:
> ---------------------

>    - clocksource rating does not depend on cp0-count frequency anymore
>      since a clocksource should be selected for its stability first,
>      not its precision.

>    - Rename CP0_HPT_TIMER into CP0_CLOCKS but I'm still not sure. If

    Why not just CP0_TIMER? Hm, CP0_HPT_TIMER was even redundant... :-)

>      someone can come with a better idea that would be nice. BTW
>      hpt-cp0.c file should be renamed into clock-cp0.c too.

    I suggest timer-cp0.c ot cp0-timer.c

> TODO:
> -----

>    - There are still few places to fix that uses 'mips_hpt_frequency'
>      global.

>    - If this patch is accepted, fix all platforms that use cp0
>      counter.

> Please have a look,

> 		Franck

> -- 8< --

> Subject: [PATCH] Implement clockevents/clocksource for R4000-style cp0 timer

> Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
> ---
>  arch/mips/Kconfig          |    9 +
>  arch/mips/kernel/Makefile  |    2 +
>  arch/mips/kernel/hpt-cp0.c |  259 +++++++++++++++++++++++++++
>  arch/mips/kernel/process.c |    3 +
>  arch/mips/kernel/smp.c     |    2 +
>  arch/mips/kernel/time.c    |  416 ++++----------------------------------------
>  include/asm-mips/hpt.h     |   36 ++++

    That HPT just doesn't want to die. :-)

[...]
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 7bcf38d..a994af1 100644
[...]
> @@ -1741,6 +1749,7 @@ config HZ
>  	default 1000 if HZ_1000
>  	default 1024 if HZ_1024
>  
> +source "kernel/time/Kconfig"
>  source "kernel/Kconfig.preempt"

    I would have put this part into a separate patch, along with tickless mode
hooks in arch/mips/kernel/process.c...

> diff --git a/arch/mips/kernel/hpt-cp0.c b/arch/mips/kernel/hpt-cp0.c
> new file mode 100644
> index 0000000..e2defcd
> --- /dev/null
> +++ b/arch/mips/kernel/hpt-cp0.c
> @@ -0,0 +1,259 @@
> +/*
> + * hpt-cp0.c - CP0 clock driver
> + *
> + * Copyright (C) 2007,  Franck Bui-Huu <fbuihuu@gmail.com>
> + *
> + * This code is released under the GNU General Public License,
> + * Version 2 (GPL v2).
> + */
> +#include <linux/kernel_stat.h>
> +#include <linux/spinlock.h>
> +#include <linux/clockchips.h>
> +#include <linux/clocksource.h>
> +
> +#include <asm/time.h>
> +#include <asm/hpt.h>
> +
> +
> +#define CP0_CLOCK_NAME	"cp0-count"
> +
> +static unsigned (*get_freq)(int cpu) __initdata;
> +static irqreturn_t (*perf_handler)(int irq, void *dev_id) __read_mostly;
> +
> +/*
> + * cp0 clocks can be disabled by boot command line
> + */
> +static int disable_clockevent __initdata;
> +static int disable_clocksource __initdata;
> +
> +static int __init cp0_clock_setup(char *arg)
> +{
> +	if (arg == NULL)
> +		return -EINVAL;
> +
> +	if (!strcmp(arg, "disable_event"))
> +		disable_clockevent = 1;
> +	else if (!strcmp(arg, "disable_source"))
> +		disable_clocksource = 1;
> +	else if (!strcmp(arg, "disable_both")) {
> +		disable_clocksource = 1;
> +		disable_clockevent = 1;

    How about "noevent", "nosource", and "none"?

> +	}
> +	return 0;
> +}
> +early_param("cp0_clock", cp0_clock_setup);
> +
> +/*
> + * cp0 count/compare operations.
> + */
> +static void cp0_count_ack(void)
> +{
> +	write_c0_compare(read_c0_compare());
> +}
> +
> +static cycle_t cp0_count_read(void)
> +{
> +        return read_c0_count();

    "Entab" spaces here please.

> +}
> +
> +/*
> + * Clocksource device. Its rating should not depend on its frequency:
> + * stability is a feature more valuable for a clock source.
> + */
> +struct clocksource cp0_clocksource = {
> +	.name		= CP0_CLOCK_NAME,
> +	.rating		= 200,

    Perhaps we even need to rise the rating to 300 or 400 -- according to what
<linux/clocksource.h> says...

> +	.mask		= CLOCKSOURCE_MASK(32),
> +	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> +	.read		= cp0_count_read,
> +};
> +
> +static void __init setup_cp0_clocksource(void)
> +{
> +	int cpu = smp_processor_id();
> +	unsigned freq = get_freq(cpu);

    Might fold these 2 lines into:

unsigned freq = get_freq(smp_processor_id());

> +	unsigned shift = 0;

    Unneeded initializer.

> +	u64 mult;
> +
> +	for (shift = 32; shift > 0; shift--) {
> +		mult = (u64)NSEC_PER_SEC << shift;
> +		do_div(mult, freq);
> +		if ((mult >> 32) == 0)
> +			break;
> +	}
> +
> +	cp0_clocksource.shift = shift;
> +	cp0_clocksource.mult = mult;
> +
> +	clocksource_register(&cp0_clocksource);
> +}
> +
> +/*
> + * High precision timer functions
> + */
> +static int cp0_set_next_event(unsigned long delta,
> +				   struct clock_event_device *evt)
> +{
> +	unsigned int cnt;
> +
> +	BUG_ON(evt->mode != CLOCK_EVT_MODE_ONESHOT);
> +
> +	/* interrupt ack is done by setting up the next event */

    We acknowledge interrupt independently from this code anyway, so the 
comment seems misplaced.

> +	cnt = read_c0_count();
> +	cnt += delta;

   Could be merge into one statement...

> +	write_c0_compare(cnt);
> +
> +	return ((long)(read_c0_count() - cnt) > 0L) ? -ETIME : 0;
> +}
> +
> +static void cp0_set_mode(enum clock_event_mode mode,
> +			     struct clock_event_device *evt)
> +{
> +	switch (mode) {
> +	case CLOCK_EVT_MODE_UNUSED:
> +	case CLOCK_EVT_MODE_SHUTDOWN:
> +		/*
> +		 * For now, we don't disable cp0 hpt interrupts. So we

    A reference to hpt needs to be killed.

> +		 * leave them enabled, and ignore them in this mode.
> +		 * Therefore we will get one useless but also harmless
> +		 * interrupt every 2^32 cycles...
> +		 */
> +		cp0_count_ack();
> +		break;
> +	case CLOCK_EVT_MODE_ONESHOT:
> +		/* nothing to do */
> +		break;
> +	case CLOCK_EVT_MODE_PERIODIC:
> +		BUG();
> +	};
> +}
> +
> +static struct clock_event_device cp0_clockevent __initdata = {
> +	.name		= CP0_CLOCK_NAME,
> +	.mode		= CLOCK_EVT_MODE_UNUSED,

    Needless intialization, that constant is 0 anyway, so this field will just 
get zeroed implicitly.

> +	.features	= CLOCK_EVT_FEAT_ONESHOT,
> +	.shift		= 32,
> +	.set_mode	= cp0_set_mode,
> +	.set_next_event	= cp0_set_next_event,
> +	.irq		= -1,
> +};
> +
> +static DEFINE_PER_CPU(struct clock_event_device, cp0_clock_events);
> +
> +void __init setup_cp0_clockevent(void)
> +{
> +	struct clock_event_device *evt;
> +	int cpu = smp_processor_id();
> +	unsigned freq;
> +
> +	if (disable_clockevent)
> +		return;
> +
> +	evt = &__get_cpu_var(cp0_clock_events);

    Could use per_cpu() here, as we already have "sampled" smp_processor_id().

> +
> +	memcpy(evt, &cp0_clockevent, sizeof(*evt));
> +
> +	freq = get_freq(cpu);
> +
> +	evt->rating = 200 + freq/10000000;
> +	evt->mult = div_sc(freq, NSEC_PER_SEC, evt->shift);
> +	evt->cpumask = cpumask_of_cpu(cpu);
> +
> +	evt->max_delta_ns = clockevent_delta2ns(0x7fffffff, evt);
> +	evt->min_delta_ns = clockevent_delta2ns(0x10, evt);
> +
> +	clockevents_register_device(evt);
> +
> +	printk("Using %u.%03u MHz CP0 high precision timer on CPU #%d.\n",

    The "high precision " part should disapper.

> +	       ((freq + 500) / 1000) / 1000,
> +	       ((freq + 500) / 1000) % 1000,
> +		cpu);
> +}
> +
> +static irqreturn_t cp0_clockevent_interrupt(int irq, void *dev_id)
> +{
> +	const int r2 = cpu_has_mips_r2;
> +	struct clock_event_device *evt;
> +
[...]
> +	/*
> +	 * The same applies to performance counter interrupts.  But with the
> +	 * above we now know that the reason we got here must be a timer
> +	 * interrupt.  Being the paranoiacs we are we check anyway.
> +	 */
> +	if (!r2 || (read_c0_cause() & (1 << 30))) {
> +		evt = &__get_cpu_var(cp0_clock_events);

    I'd think 'evt' should be declared in this block too, not at the function 
level.

> +
> +		/*
> +		 * We can get interrupts whereas the hpt clock event

    A reference to hpt needs to be killed there too...

> +		 * device has been disabled since we can't shut it
> +		 * down. So always ack the timer.
> +		 */
> +		cp0_count_ack();
> +
> +		switch (evt->mode) {
> +		case CLOCK_EVT_MODE_ONESHOT:
> +			evt->event_handler(evt);
> +			break;
> +		case CLOCK_EVT_MODE_UNUSED:
> +		case CLOCK_EVT_MODE_SHUTDOWN:
> +		case CLOCK_EVT_MODE_PERIODIC:
> +			/* nothing */;
> +		}

    Isn't this over-engineered? Why use *switch*' where the simple *if* would 
suffice?

> +	}
> +out:
> +	return IRQ_HANDLED;
> +}
> +
> +static struct irqaction cp0_clockevent_irqaction = {
> +	.handler	= cp0_clockevent_interrupt,
> +	.flags		= IRQF_DISABLED | IRQF_PERCPU,
> +	.name		= CP0_CLOCK_NAME,
> +};
> +
> +
> +/*
> + * This function is used by platforms which use the hpt as clock
> + * source and timer.
> + */
> +int __init setup_cp0_clocks(struct cp0_clock_info *info)
> +{

    Erm, do we need this function at all after we have separate setups for 
clock source/event?  Just move all the override checks there.

> +	if (!cpu_has_counter)
> +		goto disable_all;
> +	if (info->get_freq == NULL)
> +		goto disable_all;
> +
> +	get_freq = info->get_freq;
> +	perf_handler = info->perf_handler;

    I seriously don't understand why are you expecting this to be passed by 
the platform code... :-/  Currently this is not so -- since it's the Oprofile 
code that handles the performance interrupt.

> +
> +	if (info->irq == 0)
> +		disable_clockevent = 1;
> +
> +	if (!disable_clocksource)
> +		setup_cp0_clocksource();
> +	if (!disable_clockevent) {
> +		setup_cp0_clockevent();
> +		setup_irq(info->irq, &cp0_clockevent_irqaction);

    Erm... why not include setup_irq() into setup_cp0_clockevent()? This way, 
it'll be autonomous and callable by the platfrom code on its own... but there 
would remain perf_irq and get_freq problems. Wouldn't it be better to declare 
get_cp0_timer_freq as a pointer ot function and let the platform just fill it 
before calling setup?

> +	}
> +	return 0;
> +
> +disable_all:
> +	disable_clocksource = disable_clockevent = 1;
> +	return -EINVAL;
> +}
> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> index 6bdfb5a..23b8858 100644
> --- a/arch/mips/kernel/process.c
> +++ b/arch/mips/kernel/process.c
> @@ -25,6 +25,7 @@
>  #include <linux/init.h>
>  #include <linux/completion.h>
>  #include <linux/kallsyms.h>
> +#include <linux/tick.h>
>  
>  #include <asm/bootinfo.h>
>  #include <asm/cpu.h>
> @@ -50,6 +51,7 @@ ATTRIB_NORET void cpu_idle(void)
>  {
>  	/* endless idle loop with no priority at all */
>  	while (1) {
> +		tick_nohz_stop_sched_tick();
>  		while (!need_resched()) {
>  #ifdef CONFIG_SMTC_IDLE_HOOK_DEBUG
>  			extern void smtc_idle_loop_hook(void);
> @@ -59,6 +61,7 @@ ATTRIB_NORET void cpu_idle(void)
>  			if (cpu_wait)
>  				(*cpu_wait)();
>  		}
> +		tick_nohz_restart_sched_tick();
>  		preempt_enable_no_resched();
>  		schedule();
>  		preempt_disable();
> diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
> index 72df0bf..0cc8363 100644
> --- a/arch/mips/kernel/time.c
> +++ b/arch/mips/kernel/time.c
[...]
> + * If you don't know timer 'X' frequency and have another timer 'Y'
> + * that flips at HZ rate, you can use this helper to determinate the
> + * timer 'X' freq.
>   */
> -
> -unsigned int mips_hpt_frequency;
> -
> -static struct irqaction timer_irqaction = {
> -	.handler = timer_interrupt,
> -	.flags = IRQF_DISABLED | IRQF_PERCPU,
> -	.name = "timer",
> -};
> -
> -static unsigned int __init calibrate_hpt(void)
> +unsigned __init calibrate_timer(cycle_t (*x_read)(void),
> +				int (*y_state)(void))

    Hm, with those x/y it looks a bit like joystick code. :-)

> diff --git a/include/asm-mips/hpt.h b/include/asm-mips/hpt.h
> new file mode 100644
> index 0000000..f0acab3
> --- /dev/null
> +++ b/include/asm-mips/hpt.h
> @@ -0,0 +1,36 @@
> +#ifndef _ASM_HPT_H
> +#define _ASM_HPT_H
> +
> +#ifdef CONFIG_CP0_CLOCKS
> +
> +struct cp0_clock_info {
> +	/*
> +	 * This is the irq num of the cp0 count/compare timer.
> +	 */
> +	int irq;
> +
> +	/*
> +	 * This mandartory hook is called to get the frequency of
> +	 * the running processor.
> +	 */
> +	unsigned (*get_freq)(int cpu);

    Creating a global variable looks like a better idea...

> +
> +	/*
> +	 * The performance counter overflow irq may be shared with the
> +	 * hpt interrupt. In that case this handler will be called
> +	 * during a hpt interrupt.
> +	 */
> +	irqreturn_t (*perf_handler)(int irq, void *dev_id);

    The only issue is that the platform code may have no idea what it should 
be...  I think we need to stick to the old approach here.

> +};

    ... this would leave us with only IRQ field and eliminate the need for 
this structure.

> +
> +extern int setup_cp0_clocks(struct cp0_clock_info *info);
> +extern void setup_cp0_clockevent(void);
> +
> +#else
> +
> +static inline void setup_cp0_clockevent(void) {}
> +
> +#endif	/* CONFIG_CP0_CLOCKS */
> +
> +#endif	/* _ASM_HPT_H */

    The remaining declaration might be joined to time.h, thus making this 
whole header unneeded... well, that's up to you.

WBR, Sergei
