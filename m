Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2007 20:23:51 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:49562 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20023763AbXFSTXt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2007 20:23:49 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 965153EC9; Tue, 19 Jun 2007 12:23:45 -0700 (PDT)
Message-ID: <46782DA9.6080805@ru.mvista.com>
Date:	Tue, 19 Jun 2007 23:25:29 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Franck <vagabon.xyz@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time
 code.
References: <11818164011355-git-send-email-fbuihuu@gmail.com>	 <11818164023940-git-send-email-fbuihuu@gmail.com>	 <20070614111748.GA8223@alpha.franken.de>	 <cda58cb80706140643g63c3bf34sbd5b843a15653c3d@mail.gmail.com>	 <Pine.LNX.4.64N.0706141501080.25868@blysk.ds.pg.gda.pl>	 <cda58cb80706140731j1b6e8e36l96d4423db1ffd9e7@mail.gmail.com>	 <Pine.LNX.4.64N.0706141648540.25868@blysk.ds.pg.gda.pl>	 <cda58cb80706150159j5c3d5b7p4293dc529d5ee97c@mail.gmail.com>	 <20070615134948.GB16133@linux-mips.org> <cda58cb80706170636kbff000cw849fa1d5ccf31152@mail.gmail.com> <46767D66.50501@innova-card.com>
In-Reply-To: <46767D66.50501@innova-card.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Franck Bui-Huu wrote:

> Subject: [PATCH 6/6] Implement clockevents for R4000-style cp0 timer
[...]
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 7bcf38d..d852cb0 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -723,6 +723,14 @@ config GENERIC_TIME
>  	bool
>  	default y
>  
> +config GENERIC_CLOCKEVENTS
> +	bool
> +	default y
> +
> +config CP0_HPT_TIMER

    I'd suggest just CP0_TIMER...

> +	bool
> +	default y
> +
>  config GENERIC_CMOS_UPDATE
>  	bool
>  	default y
[...]
> diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
> index 4924626..ffd4352 100644
> --- a/arch/mips/kernel/Makefile
> +++ b/arch/mips/kernel/Makefile
> @@ -11,6 +11,8 @@ obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
>  binfmt_irix-objs	:= irixelf.o irixinv.o irixioctl.o irixsig.o	\
>  			   irix5sys.o sysirix.o
>  
> +obj-$(CONFIG_CP0_HPT_TIMER)	+= hpt-cp0.o

    cp0-timer.o here too.

> +
>  obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
>  obj-$(CONFIG_MODULES)		+= mips_ksyms.o module.o
>  
> diff --git a/arch/mips/kernel/hpt-cp0.c b/arch/mips/kernel/hpt-cp0.c
> new file mode 100644
> index 0000000..8581a20
> --- /dev/null
> +++ b/arch/mips/kernel/hpt-cp0.c
> @@ -0,0 +1,248 @@
> +/*
> + * This is a driver for CP0 hpt.
> + */
> +#include <linux/kernel_stat.h>
> +#include <linux/spinlock.h>
> +#include <linux/clockchips.h>
> +#include <linux/clocksource.h>
> +
> +
> +#include <asm/time.h>
> +#include <asm/hpt.h>
> +
> +
> +#define MIPS_HPT_NAME	"cp0-hpt"

    I'd named it "cp0-timer" or something.

> +/*
> + * High precision timer functions
> + */
> +
> +static int cp0_hpt_set_next_event(unsigned long delta,
> +				   struct clock_event_device *evt)
> +{
> +	unsigned int cnt;
> +
> +	BUG_ON(evt->mode != CLOCK_EVT_MODE_ONESHOT);
> +
> +	/* interrupt ack is done by setting up the next event */
> +	cnt = read_c0_count();
> +	cnt += delta;
> +	write_c0_compare(cnt);
> +
> +	return ((long)(read_c0_count() - cnt) > 0L) ? -ETIME : 0;
> +}
> +
> +static void cp0_hpt_set_mode(enum clock_event_mode mode,
> +			     struct clock_event_device *evt)
> +{
> +	switch (mode) {
> +	case CLOCK_EVT_MODE_UNUSED:
> +	case CLOCK_EVT_MODE_SHUTDOWN:
> +		/*
> +		 * For now, we can't disable cp0 hpt interrupts. So we
> +		 * leave them enabled, and ignore them in this mode.
> +		 * Therefore we will get one useless but also harmless
> +		 * interrupt every 2^32 cycles...
> +		 */
> +		cp0_hpt_ack();

    Good idea...

> +		break;
> +	case CLOCK_EVT_MODE_ONESHOT:
> +		/* nothing to do */
> +		break;
> +	case CLOCK_EVT_MODE_PERIODIC:
> +		BUG();
> +	};
> +}
> +
> +static struct clock_event_device hpt_clockevent __initdata = {
> +	.name		= MIPS_HPT_NAME,
> +	.mode		= CLOCK_EVT_MODE_UNUSED,
> +	.features	= CLOCK_EVT_FEAT_ONESHOT,
> +	.shift		= 32,
> +	.set_mode	= cp0_hpt_set_mode,
> +	.set_next_event	= cp0_hpt_set_next_event,
> +	.irq		= -1,
> +};
> +
> +static DEFINE_PER_CPU(struct clock_event_device, cp0_hpt_clock_events);

   Oh, these are declared per-CPU at last...

> +static irqreturn_t cp0_hpt_interrupt(int irq, void *dev_id)
> +{
> +	const int r2 = cpu_has_mips_r2;
> +	struct clock_event_device *cd;
> +
> +	/*
> +	 * Suckage alert:
> +	 * Before R2 of the architecture there was no way to see if a
> +	 * performance counter interrupt was pending, so we have to run
> +	 * the performance counter interrupt handler anyway.
> +	 */
> +	if (perf_handler && perf_handler(irq, dev_id) == IRQ_HANDLED)
> +		/*
> +		 * The performance counter overflow interrupt may be
> +		 * shared with the timer interrupt. If it is (!r2)
> +		 * then we can't reliably determine if a counter
> +		 * interrupt has also happened. So don't check for a
> +		 * timer interrupt in this case.
> +		 */
> +		if (!r2)
> +			goto out;

    Might be folded into one if stmt...

> +
> +	/*
> +	 * The same applies to performance counter interrupts.  But with the
> +	 * above we now know that the reason we got here must be a timer
> +	 * interrupt.  Being the paranoiacs we are we check anyway.
> +	 */
> +	if (!r2 || (read_c0_cause() & (1 << 30))) {
> +		/*
> +		 * We can get interrupts whereas the hpt clock event
> +		 * device has been disabled since we can't shut it
> +		 * down. So always ack the timer.
> +		 */
> +		cp0_hpt_ack();
> +
> +		cd = &__get_cpu_var(cp0_hpt_clock_events);
> +		if (likely(cd->mode != CLOCK_EVT_MODE_SHUTDOWN))

    Hm, I thought the upper level code takes care of this case... well, it
might have in 2.6.18 time. :-)
    But maybe CLOCK_EVT_MODE_UNUSED should also be checked?

> +			cd->event_handler(cd);
> +	}
> +out:
> +	return IRQ_HANDLED;
> +}
> +
> +struct irqaction hpt_irqaction = {
> +	.handler	= cp0_hpt_interrupt,
> +	.flags		= IRQF_DISABLED | IRQF_PERCPU,
> +	.name		= MIPS_HPT_NAME,
> +};

> +/*
> + * This function is used by platforms which use the hpt as clock
> + * source and timer.
> + */
> +int __init setup_cp0_hpt(struct cp0_hpt_info *info)
> +{
> +	if (cp0_hpt_disabled)
> +		goto out;
> +	if (!cpu_has_counter)
> +		goto disable;
> +
> +	if (info->irq == 0)
> +		goto disable;

    Shouldn't harm clocksource, in theory.

> +	if (info->get_freq == NULL)
> +		goto disable;
> +
> +	cp0_hpt_get_freq = info->get_freq;
> +	perf_handler = info->perf_handler;
> +
> +	setup_cp0_hpt_clocksource();
> +	setup_cp0_hpt_clockevent();

    Probably not both. It would have been the best thing to have the separate
init. functions...

> diff --git a/include/asm-mips/hpt.h b/include/asm-mips/hpt.h
> new file mode 100644
> index 0000000..2b62827
> --- /dev/null
> +++ b/include/asm-mips/hpt.h
> @@ -0,0 +1,30 @@
> +#ifndef _ASM_HPT_H
> +#define _ASM_HPT_H
> +
> +#ifdef CONFIG_CP0_HPT_TIMER
> +
> +struct cp0_hpt_info {

    Not sure if we need the structure at this point at all...

> +	/* FIXME: could we let the user override hpt ops ? */

    No.

> +	/* FIXME: should we add a disable_irq method ? */

    Couldn't it be handled in somegeneric way?

> +	int		irq;
> +	unsigned	(*get_freq)(int cpu);
> +
> +	/*
> +	 * The performance counter overflow irq may be shared with the
> +	 * hpt interrupt. In that case this handler will be called
> +	 * during a hpt interrupt.
> +	 */
> +	irqreturn_t	(*perf_handler)(int irq, void *dev_id);

    Hm... what it's doing here, in this structure?

> +};
> +
> +
> +extern int setup_cp0_hpt(struct cp0_hpt_info *info);
> +extern void setup_cp0_hpt_clockevent(void);

    No explicit 'extern' needed for functions -- they all have that memory 
class by deafult.

WBR, Sergei
