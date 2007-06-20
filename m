Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2007 11:24:17 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.179]:28580 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20024619AbXFTKYP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Jun 2007 11:24:15 +0100
Received: by py-out-1112.google.com with SMTP id f31so260723pyh
        for <linux-mips@linux-mips.org>; Wed, 20 Jun 2007 03:24:13 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B1RO09qx+v5ay3XUTeSFZ29DYxwKOTwTPmWztiT3uh4gK279nhqviP25uypFSezaanL61SdgoDqz3R10zEDXKyD6++OqpLf1RixIsj0pCmDCHPTZg/aFZMOCW78McRC/zWrPLgORql1nrGTuU8/0ciWun+5wfG2g0QCTjY1L5zg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nSfW22LWKpQpJsZ4SVxN+9SPsTJbnKRhZWCT/KPK3+gClG9qkAI/mYbBbWJKTeVoN5FH5iovU4sofRXFhbJQkstlc9zXoE8TibL7/ZISwv+pV2Byv7X1aj7JYPKZGoOhMPovN4Cm7JI2hgISrz1rEH2+YNJtVDtXOPyF9g1dIgo=
Received: by 10.65.219.20 with SMTP id w20mr1134687qbq.1182335052760;
        Wed, 20 Jun 2007 03:24:12 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Wed, 20 Jun 2007 03:24:12 -0700 (PDT)
Message-ID: <cda58cb80706200324v77fd1de1m77a9872276a7ef92@mail.gmail.com>
Date:	Wed, 20 Jun 2007 12:24:12 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time code.
Cc:	"Ralf Baechle" <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org, "Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
In-Reply-To: <46782DA9.6080805@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11818164011355-git-send-email-fbuihuu@gmail.com>
	 <cda58cb80706140643g63c3bf34sbd5b843a15653c3d@mail.gmail.com>
	 <Pine.LNX.4.64N.0706141501080.25868@blysk.ds.pg.gda.pl>
	 <cda58cb80706140731j1b6e8e36l96d4423db1ffd9e7@mail.gmail.com>
	 <Pine.LNX.4.64N.0706141648540.25868@blysk.ds.pg.gda.pl>
	 <cda58cb80706150159j5c3d5b7p4293dc529d5ee97c@mail.gmail.com>
	 <20070615134948.GB16133@linux-mips.org>
	 <cda58cb80706170636kbff000cw849fa1d5ccf31152@mail.gmail.com>
	 <46767D66.50501@innova-card.com> <46782DA9.6080805@ru.mvista.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

Thanks for considering.

Sergei Shtylyov wrote:
>> @@ -723,6 +723,14 @@ config GENERIC_TIME
>>      bool
>>      default y
>>
>> +config GENERIC_CLOCKEVENTS
>> +    bool
>> +    default y
>> +
>> +config CP0_HPT_TIMER
>
>    I'd suggest just CP0_TIMER...
>

TIMER is confusing with timers implemented in kernel/timer.c

Maybe ?

	CP0_HRT,
	CP0_CLOCKS,

>>
>> +obj-$(CONFIG_CP0_HPT_TIMER)    += hpt-cp0.o
>
>    cp0-timer.o here too.

ditto.

>> +
>> +#define MIPS_HPT_NAME    "cp0-hpt"
>
>    I'd named it "cp0-timer" or something.

ditto

>> +static void cp0_hpt_set_mode(enum clock_event_mode mode,
>> +                 struct clock_event_device *evt)
>> +{
>> +    switch (mode) {
>> +    case CLOCK_EVT_MODE_UNUSED:
>> +    case CLOCK_EVT_MODE_SHUTDOWN:
>> +        /*
>> +         * For now, we can't disable cp0 hpt interrupts. So we
>> +         * leave them enabled, and ignore them in this mode.
>> +         * Therefore we will get one useless but also harmless
>> +         * interrupt every 2^32 cycles...
>> +         */
>> +        cp0_hpt_ack();
>
>    Good idea...

What about this other alternative ?

static void cp0_hpt_set_mode(enum clock_event_mode mode,
			     struct clock_event_device *evt)
{
	switch (mode) {
	case CLOCK_EVT_MODE_UNUSED:
		free_irq(hpt_irq, NULL);
		break;
	case CLOCK_EVT_MODE_SHUTDOWN:
		cp0_hpt_ack();
		break;
	case CLOCK_EVT_MODE_ONESHOT:
		setup_irq(hpt_irq, &hpt_irqaction);
		break;
	case CLOCK_EVT_MODE_PERIODIC:
		BUG();
	};
}

>> +static irqreturn_t cp0_hpt_interrupt(int irq, void *dev_id)
>> +{
>> +    const int r2 = cpu_has_mips_r2;
>> +    struct clock_event_device *cd;
>> +
>> +    /*
>> +     * Suckage alert:
>> +     * Before R2 of the architecture there was no way to see if a
>> +     * performance counter interrupt was pending, so we have to run
>> +     * the performance counter interrupt handler anyway.
>> +     */
>> +    if (perf_handler && perf_handler(irq, dev_id) == IRQ_HANDLED)
>> +        /*
>> +         * The performance counter overflow interrupt may be
>> +         * shared with the timer interrupt. If it is (!r2)
>> +         * then we can't reliably determine if a counter
>> +         * interrupt has also happened. So don't check for a
>> +         * timer interrupt in this case.
>> +         */
>> +        if (!r2)
>> +            goto out;
>
>    Might be folded into one if stmt...
>

If you don't mind I prefer let it as is. I think it's more readable and
the second comment right before the "if (!r2)" condition can be well
placed.

>> +
>> +    /*
>> +     * The same applies to performance counter interrupts.  But with the
>> +     * above we now know that the reason we got here must be a timer
>> +     * interrupt.  Being the paranoiacs we are we check anyway.
>> +     */
>> +    if (!r2 || (read_c0_cause() & (1 << 30))) {
>> +        /*
>> +         * We can get interrupts whereas the hpt clock event
>> +         * device has been disabled since we can't shut it
>> +         * down. So always ack the timer.
>> +         */
>> +        cp0_hpt_ack();
>> +
>> +        cd = &__get_cpu_var(cp0_hpt_clock_events);
>> +        if (likely(cd->mode != CLOCK_EVT_MODE_SHUTDOWN))
>
>    Hm, I thought the upper level code takes care of this case... well, it
> might have in 2.6.18 time. :-)

Sorry I don't see what you mean. It's an interrupt handler, what
do you mean by "upper level code" ?

>    But maybe CLOCK_EVT_MODE_UNUSED should also be checked?

yes. Actually this test should be:

	if (likely(cd->mode == CLOCK_EVT_MODE_ONESHOT))
		...

>
>> +            cd->event_handler(cd);
>> +    }
>> +out:
>> +    return IRQ_HANDLED;
>> +}
>> +
>> +struct irqaction hpt_irqaction = {
>> +    .handler    = cp0_hpt_interrupt,
>> +    .flags        = IRQF_DISABLED | IRQF_PERCPU,
>> +    .name        = MIPS_HPT_NAME,
>> +};
>
>> +/*
>> + * This function is used by platforms which use the hpt as clock
>> + * source and timer.
>> + */
>> +int __init setup_cp0_hpt(struct cp0_hpt_info *info)
>> +{
>> +    if (cp0_hpt_disabled)
>> +        goto out;
>> +    if (!cpu_has_counter)
>> +        goto disable;
>> +
>> +    if (info->irq == 0)
>> +        goto disable;
>
>    Shouldn't harm clocksource, in theory.
>

agreed.

>> +    if (info->get_freq == NULL)
>> +        goto disable;
>> +
>> +    cp0_hpt_get_freq = info->get_freq;
>> +    perf_handler = info->perf_handler;
>> +
>> +    setup_cp0_hpt_clocksource();
>> +    setup_cp0_hpt_clockevent();
>
>    Probably not both. It would have been the best thing to have the
> separate
> init. functions...

OK.

>
>> diff --git a/include/asm-mips/hpt.h b/include/asm-mips/hpt.h
>> new file mode 100644
>> index 0000000..2b62827
>> --- /dev/null
>> +++ b/include/asm-mips/hpt.h
>> @@ -0,0 +1,30 @@
>> +#ifndef _ASM_HPT_H
>> +#define _ASM_HPT_H
>> +
>> +#ifdef CONFIG_CP0_HPT_TIMER
>> +
>> +struct cp0_hpt_info {
>
>    Not sure if we need the structure at this point at all...
>
>> +    /* FIXME: could we let the user override hpt ops ? */
>
>    No.
>

Alright.

>> +    /* FIXME: should we add a disable_irq method ? */
>
>    Couldn't it be handled in somegeneric way?
>

Not really, or at least there're some configs where you can't. See
this thread from:

http://marc.info/?l=linux-mips&m=118121616820659&w=2

That said maybe we can provide a default disable_irq() that would
disable CP0 hpt irq from CP0. That would be the 'generic' way. And
we still give the possibility to override it through the cp0_hpt_info
structure. Of course the same thing would be needed to enable CP0
hpt interrupts.

What do you think ?

>> +    int        irq;
>> +    unsigned    (*get_freq)(int cpu);
>> +
>> +    /*
>> +     * The performance counter overflow irq may be shared with the
>> +     * hpt interrupt. In that case this handler will be called
>> +     * during a hpt interrupt.
>> +     */
>> +    irqreturn_t    (*perf_handler)(int irq, void *dev_id);
>
>    Hm... what it's doing here, in this structure?
>

As the comment above tries to explain, the cp0 hpt interrupts can
be shared with the perf interrupts on some systems.

Should I rephrase the comment ?

>> +};
>> +
>> +
>> +extern int setup_cp0_hpt(struct cp0_hpt_info *info);
>> +extern void setup_cp0_hpt_clockevent(void);
>
>    No explicit 'extern' needed for functions -- they all have that
> memory class by deafult.

Just a matter of coding style. The same happens with "unsigned" and
"unsigned int"...

Thanks again,
-- 
               Franck
