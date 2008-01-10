Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jan 2008 16:20:38 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:10678 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28577527AbYAJQU3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 Jan 2008 16:20:29 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id B38633EC9; Thu, 10 Jan 2008 08:20:25 -0800 (PST)
Message-ID: <478645FD.2090708@ru.mvista.com>
Date:	Thu, 10 Jan 2008 19:21:17 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Vitaly Wool <vitalywool@gmail.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: pnx8xxx: move to clocksource
References: <4786273D.7010006@gmail.com>
In-Reply-To: <4786273D.7010006@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Vitaly Wool wrote:

> This patch converts PNX8XXX system timer to clocksource.

    Well, this patch has been already committed but nevertheless...

> arch/mips/philips/pnx8550/common/time.c |  109 
> +++++++++++++++++++++-----------
> 1 files changed, 72 insertions(+), 37 deletions(-)

> Signed-off-by: Vitaly Wool <vitalywool@gmail.com>

> Index: linux-2.6/arch/mips/philips/pnx8550/common/time.c
> ===================================================================
> --- linux-2.6.orig/arch/mips/philips/pnx8550/common/time.c
> +++ linux-2.6/arch/mips/philips/pnx8550/common/time.c
> @@ -22,7 +22,6 @@
> #include <linux/kernel_stat.h>
> #include <linux/spinlock.h>
> #include <linux/interrupt.h>
> -#include <linux/module.h>
> 
> #include <asm/bootinfo.h>
> #include <asm/cpu.h>
> @@ -41,11 +40,60 @@ static cycle_t hpt_read(void)
>     return read_c0_count2();
> }

> +static struct clocksource pnx_clocksource = {
> +    .name        = "pnx8xxx",
> +    .rating        = 200,
> +    .read        = hpt_read,
> +    .flags        = CLOCK_SOURCE_IS_CONTINUOUS,
> +};

    Something probably have converted tabs to 8 spaces...
    I would have done it otherwise -- using timer 1 as a generic MIPS 
clocksource (just hooking the IRQ to reload the comparator to all ones), and 
timer 2 as clockevent...

> static void timer_ack(void)
> {
>     write_c0_compare(cpj);
> }

    Do we still need this function? I don't think so -- mips_timer_ack() is 
dead...

[...]

> +static struct clock_event_device pnx8xxx_clockevent = {
> +    .name        = "pnx8xxx_clockevent",
> +    .features    = CLOCK_EVT_FEAT_ONESHOT,

    Aren't PNX8550 timers actually periodic in nature?

> +    .set_next_event = pnx8xxx_set_next_event,
> +};
> +
> /*
>  * plat_time_init() - it does the following things:
>  *
> @@ -58,11 +106,34 @@ static void timer_ack(void)
> 
> __init void plat_time_init(void)
> {
> +    unsigned int             configPR;

   Something has definitely spoilt all the tabs in the patch...

>     unsigned int             n;
>     unsigned int             m;
>     unsigned int             p;
>     unsigned int             pow2p;
> 
> +    clockevents_register_device(&pnx8xxx_clockevent);
> +    clocksource_register(&pnx_clocksource);
> +
> +    setup_irq(PNX8550_INT_TIMER1, &pnx8xxx_timer_irq);
> +    setup_irq(PNX8550_INT_TIMER2, &monotonic_irqaction);
> +
> +    /* Timer 1 start */
> +    configPR = read_c0_config7();
> +    configPR &= ~0x00000008;
> +    write_c0_config7(configPR);
> +
> +    /* Timer 2 start */
> +    configPR = read_c0_config7();
> +    configPR &= ~0x00000010;
> +    write_c0_config7(configPR);
> +
> +    /* Timer 3 stop */
> +    configPR = read_c0_config7();
> +    configPR |= 0x00000020;
> +    write_c0_config7(configPR);

    Enabling timers before they are actually set up? :-|

> +
> +
>         /* PLL0 sets MIPS clock (PLL1 <=> TM1, PLL6 <=> TM2, PLL5 <=> 
> mem) */
>         /* (but only if CLK_MIPS_CTL select value [bits 3:1] is 1:  
> FIXME) */
> 

WBR, Sergei
