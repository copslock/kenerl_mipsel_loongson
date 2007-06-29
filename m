Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jun 2007 10:31:05 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.182]:47246 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20023064AbXF2JbA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Jun 2007 10:31:00 +0100
Received: by py-out-1112.google.com with SMTP id p76so1336247pyb
        for <linux-mips@linux-mips.org>; Fri, 29 Jun 2007 02:30:47 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bIh/nszFhTYNP2b5xzMmVjAN1FGcg8Wxokdq2pvDGaXd9W8UJL5zXznAAzChF/CKzcoKm/t4GF+lQAN4eo7vBLS9njcSrJVKUR3SYoGbqexHtQKK1L18Qszk623FL/0aqH0qEtvB9nOZJHT3PCMkM2DQgXJz2khOB9HH8RDES90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H4zkAd4EHAv1NfE0B8r5Prn2Ih5MarGrEQ20aX9rtnwZVhw8UjZPumF+b0n34TDr+urFZlv2l07kQ5mwYbMthTNqh0gkYypjhgAHRomilPpk192kue7tnbld+JGtw1V9t9Uk1oIPPWe4DIxEigfrA9f3cb6vIJJJWttoadr9CzA=
Received: by 10.65.212.3 with SMTP id o3mr4834397qbq.1183109447073;
        Fri, 29 Jun 2007 02:30:47 -0700 (PDT)
Received: by 10.65.185.15 with HTTP; Fri, 29 Jun 2007 02:30:47 -0700 (PDT)
Message-ID: <cda58cb80706290230h68d7c0eav423bf85d0757089c@mail.gmail.com>
Date:	Fri, 29 Jun 2007 11:30:47 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Subject: Re: [RFC Implement clockevents/clocksource for R4000-style cp0 timer [take #3]
Cc:	linux-mips <linux-mips@linux-mips.org>,
	"Ralf Baechle" <ralf@linux-mips.org>,
	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
In-Reply-To: <4682A748.2000108@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <467F8C34.7080904@innova-card.com> <4682A748.2000108@ru.mvista.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

Sergei Shtylyov wrote:
> Franck Bui-Huu wrote:
>>    - Rename CP0_HPT_TIMER into CP0_CLOCKS but I'm still not sure. If
>
>    Why not just CP0_TIMER? Hm, CP0_HPT_TIMER was even redundant... :-)
>

I already gave up CP0_HPT_TIMER, as you said it was redundant. Now I use
CPO_CLOCKS but I'm not really happy with it.

Ok for CP0_TIMER...

>>      someone can come with a better idea that would be nice. BTW
>>      hpt-cp0.c file should be renamed into clock-cp0.c too.
>
>    I suggest timer-cp0.c ot cp0-timer.c
>

Ok for timer-cp0.c

>>  arch/mips/Kconfig          |    9 +
>>  arch/mips/kernel/Makefile  |    2 +
>>  arch/mips/kernel/hpt-cp0.c |  259 +++++++++++++++++++++++++++
>>  arch/mips/kernel/process.c |    3 +
>>  arch/mips/kernel/smp.c     |    2 +
>>  arch/mips/kernel/time.c    |  416
>> ++++----------------------------------------
>>  include/asm-mips/hpt.h     |   36 ++++
>
>    That HPT just doesn't want to die. :-)

yes I wanted to be sure about the name before getting rid of
all these 'hpt'. Done now.

>
> [...]
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index 7bcf38d..a994af1 100644
> [...]
>> @@ -1741,6 +1749,7 @@ config HZ
>>      default 1000 if HZ_1000
>>      default 1024 if HZ_1024
>>
>> +source "kernel/time/Kconfig"
>>  source "kernel/Kconfig.preempt"
>
>    I would have put this part into a separate patch, along with tickless
> mode
> hooks in arch/mips/kernel/process.c...
>

Fair enough, that was my plan too but I wanted this single rfc patch
to be functional.

>> +static int disable_clockevent __initdata;
>> +static int disable_clocksource __initdata;
>> +
>> +static int __init cp0_clock_setup(char *arg)
>> +{
>> +    if (arg == NULL)
>> +        return -EINVAL;
>> +
>> +    if (!strcmp(arg, "disable_event"))
>> +        disable_clockevent = 1;
>> +    else if (!strcmp(arg, "disable_source"))
>> +        disable_clocksource = 1;
>> +    else if (!strcmp(arg, "disable_both")) {
>> +        disable_clocksource = 1;
>> +        disable_clockevent = 1;
>
>    How about "noevent", "nosource", and "none"?
>

No objection.

>> +    }
>> +    return 0;
>> +}
>> +early_param("cp0_clock", cp0_clock_setup);
>> +
>> +/*
>> + * cp0 count/compare operations.
>> + */
>> +static void cp0_count_ack(void)
>> +{
>> +    write_c0_compare(read_c0_compare());
>> +}
>> +
>> +static cycle_t cp0_count_read(void)
>> +{
>> +        return read_c0_count();
>
>    "Entab" spaces here please.
>

I forgot to enable git hooks in my new repo...  sorry, it shouldn't
happen anymore.

>> +}
>> +
>> +/*
>> + * Clocksource device. Its rating should not depend on its frequency:
>> + * stability is a feature more valuable for a clock source.
>> + */
>> +struct clocksource cp0_clocksource = {
>> +    .name        = CP0_CLOCK_NAME,
>> +    .rating        = 200,
>
>    Perhaps we even need to rise the rating to 300 or 400 -- according to
> what
> <linux/clocksource.h> says...
>

I dunno. I kept the previous value (without the timer freq depedency).
Do you think cp0 counter is stable enough to rise this rating ?

>> +    .mask        = CLOCKSOURCE_MASK(32),
>> +    .flags        = CLOCK_SOURCE_IS_CONTINUOUS,
>> +    .read        = cp0_count_read,
>> +};
>> +
>> +static void __init setup_cp0_clocksource(void)
>> +{
>> +    int cpu = smp_processor_id();
>> +    unsigned freq = get_freq(cpu);
>
>    Might fold these 2 lines into:
>

OK

> unsigned freq = get_freq(smp_processor_id());
>
>> +    unsigned shift = 0;
>
>    Unneeded initializer.
>

OK

>> +    u64 mult;
>> +
>> +    for (shift = 32; shift > 0; shift--) {
>> +        mult = (u64)NSEC_PER_SEC << shift;
>> +        do_div(mult, freq);
>> +        if ((mult >> 32) == 0)
>> +            break;
>> +    }
>> +
>> +    cp0_clocksource.shift = shift;
>> +    cp0_clocksource.mult = mult;
>> +
>> +    clocksource_register(&cp0_clocksource);
>> +}
>> +
>> +/*
>> + * High precision timer functions
>> + */
>> +static int cp0_set_next_event(unsigned long delta,
>> +                   struct clock_event_device *evt)
>> +{
>> +    unsigned int cnt;
>> +
>> +    BUG_ON(evt->mode != CLOCK_EVT_MODE_ONESHOT);
>> +
>> +    /* interrupt ack is done by setting up the next event */
>
>    We acknowledge interrupt independently from this code anyway, so the
> comment seems misplaced.
>

Old comment. Removed.

>> +    cnt = read_c0_count();
>> +    cnt += delta;
>
>   Could be merge into one statement...
>
>> +    write_c0_compare(cnt);
>> +
>> +    return ((long)(read_c0_count() - cnt) > 0L) ? -ETIME : 0;
>> +}
>> +
>> +static void cp0_set_mode(enum clock_event_mode mode,
>> +                 struct clock_event_device *evt)
>> +{
>> +    switch (mode) {
>> +    case CLOCK_EVT_MODE_UNUSED:
>> +    case CLOCK_EVT_MODE_SHUTDOWN:
>> +        /*
>> +         * For now, we don't disable cp0 hpt interrupts. So we
>
>    A reference to hpt needs to be killed.

Done

>
>> +         * leave them enabled, and ignore them in this mode.
>> +         * Therefore we will get one useless but also harmless
>> +         * interrupt every 2^32 cycles...
>> +         */
>> +        cp0_count_ack();
>> +        break;
>> +    case CLOCK_EVT_MODE_ONESHOT:
>> +        /* nothing to do */
>> +        break;
>> +    case CLOCK_EVT_MODE_PERIODIC:
>> +        BUG();
>> +    };
>> +}
>> +
>> +static struct clock_event_device cp0_clockevent __initdata = {
>> +    .name        = CP0_CLOCK_NAME,
>> +    .mode        = CLOCK_EVT_MODE_UNUSED,
>
>    Needless intialization, that constant is 0 anyway, so this field will
> just get zeroed implicitly.


Well you can state this because you took a look to the clockevent
implementation internals. What's happening if they change this value ?
I know it won't happen but it's cleaner anyway. I prefer leave it
alone if you don't mind.

>
>> +    .features    = CLOCK_EVT_FEAT_ONESHOT,
>> +    .shift        = 32,
>> +    .set_mode    = cp0_set_mode,
>> +    .set_next_event    = cp0_set_next_event,
>> +    .irq        = -1,
>> +};
>> +
>> +static DEFINE_PER_CPU(struct clock_event_device, cp0_clock_events);
>> +
>> +void __init setup_cp0_clockevent(void)
>> +{
>> +    struct clock_event_device *evt;
>> +    int cpu = smp_processor_id();
>> +    unsigned freq;
>> +
>> +    if (disable_clockevent)
>> +        return;
>> +
>> +    evt = &__get_cpu_var(cp0_clock_events);
>
>    Could use per_cpu() here, as we already have "sampled"
> smp_processor_id().
>

OK.

>> +
>> +    memcpy(evt, &cp0_clockevent, sizeof(*evt));
>> +
>> +    freq = get_freq(cpu);
>> +
>> +    evt->rating = 200 + freq/10000000;
>> +    evt->mult = div_sc(freq, NSEC_PER_SEC, evt->shift);
>> +    evt->cpumask = cpumask_of_cpu(cpu);
>> +
>> +    evt->max_delta_ns = clockevent_delta2ns(0x7fffffff, evt);
>> +    evt->min_delta_ns = clockevent_delta2ns(0x10, evt);
>> +
>> +    clockevents_register_device(evt);
>> +
>> +    printk("Using %u.%03u MHz CP0 high precision timer on CPU #%d.\n",
>
>    The "high precision " part should disapper.

Killed.

>
>> +           ((freq + 500) / 1000) / 1000,
>> +           ((freq + 500) / 1000) % 1000,
>> +        cpu);
>> +}
>> +
>> +static irqreturn_t cp0_clockevent_interrupt(int irq, void *dev_id)
>> +{
>> +    const int r2 = cpu_has_mips_r2;
>> +    struct clock_event_device *evt;
>> +
> [...]
>> +    /*
>> +     * The same applies to performance counter interrupts.  But with the
>> +     * above we now know that the reason we got here must be a timer
>> +     * interrupt.  Being the paranoiacs we are we check anyway.
>> +     */
>> +    if (!r2 || (read_c0_cause() & (1 << 30))) {
>> +        evt = &__get_cpu_var(cp0_clock_events);
>
>    I'd think 'evt' should be declared in this block too, not at the
> function level.

OK.

>
>> +
>> +        /*
>> +         * We can get interrupts whereas the hpt clock event
>
>    A reference to hpt needs to be killed there too...

Destroyed.

>
>> +         * device has been disabled since we can't shut it
>> +         * down. So always ack the timer.
>> +         */
>> +        cp0_count_ack();
>> +
>> +        switch (evt->mode) {
>> +        case CLOCK_EVT_MODE_ONESHOT:
>> +            evt->event_handler(evt);
>> +            break;
>> +        case CLOCK_EVT_MODE_UNUSED:
>> +        case CLOCK_EVT_MODE_SHUTDOWN:
>> +        case CLOCK_EVT_MODE_PERIODIC:
>> +            /* nothing */;
>> +        }
>
>    Isn't this over-engineered? Why use *switch*' where the simple *if*
> would suffice?

I just wanted to be sure that I won't miss any new mode, being
paranoid I guess. I'll change it.

>
>> +    }
>> +out:
>> +    return IRQ_HANDLED;
>> +}
>> +
>> +static struct irqaction cp0_clockevent_irqaction = {
>> +    .handler    = cp0_clockevent_interrupt,
>> +    .flags        = IRQF_DISABLED | IRQF_PERCPU,
>> +    .name        = CP0_CLOCK_NAME,
>> +};
>> +
>> +
>> +/*
>> + * This function is used by platforms which use the hpt as clock
>> + * source and timer.
>> + */
>> +int __init setup_cp0_clocks(struct cp0_clock_info *info)
>> +{
>
>    Erm, do we need this function at all after we have separate setups
> for clock source/event?  Just move all the override checks there.
>

Well I would say no. setup_cp0_clockevent() is normally called only
once by board init code. Whereas setup_cp0_clockevent() can be called
several times in SMP. Thus we can have several cp0 counters with
different frequencies. It was Ralf's requierement.

Maybe I should rename setup_cp0_clockevent() into
setup_cp0_clockevent_per_cpu() ?

>> +    if (!cpu_has_counter)
>> +        goto disable_all;
>> +    if (info->get_freq == NULL)
>> +        goto disable_all;
>> +
>> +    get_freq = info->get_freq;
>> +    perf_handler = info->perf_handler;
>
>    I seriously don't understand why are you expecting this to be passed
> by the platform code... :-/  Currently this is not so -- since it's the
> Oprofile code that handles the performance interrupt.
>

You're right, I didn't give a close look to this. I'll remove it and
try to implement something else.

>> +
>> +    if (info->irq == 0)
>> +        disable_clockevent = 1;
>> +
>> +    if (!disable_clocksource)
>> +        setup_cp0_clocksource();
>> +    if (!disable_clockevent) {
>> +        setup_cp0_clockevent();
>> +        setup_irq(info->irq, &cp0_clockevent_irqaction);
>
>    Erm... why not include setup_irq() into setup_cp0_clockevent()? This
> way, it'll be autonomous and callable by the platfrom code on its own...

See my previous answer about setup_cp0_clockevent() which can be
called several times in SMP.

> but there would remain perf_irq and get_freq problems. Wouldn't it be
> better to declare get_cp0_timer_freq as a pointer ot function and let
> the platform just fill it before calling setup?
>

see structure comment below...

>> -
>> -static unsigned int __init calibrate_hpt(void)
>> +unsigned __init calibrate_timer(cycle_t (*x_read)(void),
>> +                int (*y_state)(void))
>
>    Hm, with those x/y it looks a bit like joystick code. :-)
>

Yeah. Actually it was said that this function should be rewritten in
order to be called by any platform code. Until this, I added 2
parameters to this function and killed 2 global function pointers.

Actually it should be part of a separate patch but until it got
written I leave this joystick code.

>> diff --git a/include/asm-mips/hpt.h b/include/asm-mips/hpt.h
>> new file mode 100644
>> index 0000000..f0acab3
>> --- /dev/null
>> +++ b/include/asm-mips/hpt.h
>> @@ -0,0 +1,36 @@
>> +#ifndef _ASM_HPT_H
>> +#define _ASM_HPT_H
>> +
>> +#ifdef CONFIG_CP0_CLOCKS
>> +
>> +struct cp0_clock_info {
>> +    /*
>> +     * This is the irq num of the cp0 count/compare timer.
>> +     */
>> +    int irq;
>> +
>> +    /*
>> +     * This mandartory hook is called to get the frequency of
>> +     * the running processor.
>> +     */
>> +    unsigned (*get_freq)(int cpu);
>
>    Creating a global variable looks like a better idea...
>
>> +
>> +    /*
>> +     * The performance counter overflow irq may be shared with the
>> +     * hpt interrupt. In that case this handler will be called
>> +     * during a hpt interrupt.
>> +     */
>> +    irqreturn_t (*perf_handler)(int irq, void *dev_id);
>
>    The only issue is that the platform code may have no idea what it
> should be...  I think we need to stick to the old approach here.
>
>> +};
>
>    ... this would leave us with only IRQ field and eliminate the need
> for this structure.

I think this structure allow us to gather all information needed by
cp0 timer 'driver' in one place. They're all one place and thus easy
for a board to see what they need to setup in order to use cp0 timer.

>
>> +
>> +extern int setup_cp0_clocks(struct cp0_clock_info *info);
>> +extern void setup_cp0_clockevent(void);
>> +
>> +#else
>> +
>> +static inline void setup_cp0_clockevent(void) {}
>> +
>> +#endif    /* CONFIG_CP0_CLOCKS */
>> +
>> +#endif    /* _ASM_HPT_H */
>
>    The remaining declaration might be joined to time.h, thus making this
> whole header unneeded... well, that's up to you.
>

OK.

I'll cook up a new patch.

Thanks a lot for your comments.
---
                Franck
