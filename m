Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jan 2008 16:28:03 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:27113 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28577536AbYAJQ2B (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Jan 2008 16:28:01 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0AGRj9f017003;
	Thu, 10 Jan 2008 16:27:46 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0AGRimN017002;
	Thu, 10 Jan 2008 16:27:44 GMT
Date:	Thu, 10 Jan 2008 16:27:44 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Vitaly Wool <vitalywool@gmail.com>, linux-mips@linux-mips.org
Subject: Re: pnx8xxx: move to clocksource
Message-ID: <20080110162744.GA16880@linux-mips.org>
References: <4786273D.7010006@gmail.com> <478645FD.2090708@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <478645FD.2090708@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 10, 2008 at 07:21:17PM +0300, Sergei Shtylyov wrote:

>> Index: linux-2.6/arch/mips/philips/pnx8550/common/time.c
>> ===================================================================
>> --- linux-2.6.orig/arch/mips/philips/pnx8550/common/time.c
>> +++ linux-2.6/arch/mips/philips/pnx8550/common/time.c
>> @@ -22,7 +22,6 @@
>> #include <linux/kernel_stat.h>
>> #include <linux/spinlock.h>
>> #include <linux/interrupt.h>
>> -#include <linux/module.h>
>>
>> #include <asm/bootinfo.h>
>> #include <asm/cpu.h>
>> @@ -41,11 +40,60 @@ static cycle_t hpt_read(void)
>>     return read_c0_count2();
>> }
>
>> +static struct clocksource pnx_clocksource = {
>> +    .name        = "pnx8xxx",
>> +    .rating        = 200,
>> +    .read        = hpt_read,
>> +    .flags        = CLOCK_SOURCE_IS_CONTINUOUS,
>> +};
>
>    Something probably have converted tabs to 8 spaces...

Only 3 of them?

>    I would have done it otherwise -- using timer 1 as a generic MIPS 
> clocksource (just hooking the IRQ to reload the comparator to all ones), 
> and timer 2 as clockevent...
>
>> static void timer_ack(void)
>> {
>>     write_c0_compare(cpj);
>> }
>
>    Do we still need this function? I don't think so -- mips_timer_ack() is 
> dead...

It's only used on initialization.

> [...]
>
>> +static struct clock_event_device pnx8xxx_clockevent = {
>> +    .name        = "pnx8xxx_clockevent",
>> +    .features    = CLOCK_EVT_FEAT_ONESHOT,
>
>    Aren't PNX8550 timers actually periodic in nature?

All I recall is they were odd ;-)

The hardware nature of timers and how to declare them to the Linux timer
code is not always the same.  CLOCK_EVT_FEAT_ONESHOT be used if the
time to the next shot can be programmed.

>>
>> __init void plat_time_init(void)
>> {
>> +    unsigned int             configPR;
>
>   Something has definitely spoilt all the tabs in the patch...

I fixed the three checkpatch.pl was bitching about.

>>     unsigned int             n;
>>     unsigned int             m;
>>     unsigned int             p;
>>     unsigned int             pow2p;
>>
>> +    clockevents_register_device(&pnx8xxx_clockevent);
>> +    clocksource_register(&pnx_clocksource);
>> +
>> +    setup_irq(PNX8550_INT_TIMER1, &pnx8xxx_timer_irq);
>> +    setup_irq(PNX8550_INT_TIMER2, &monotonic_irqaction);
>> +
>> +    /* Timer 1 start */
>> +    configPR = read_c0_config7();
>> +    configPR &= ~0x00000008;
>> +    write_c0_config7(configPR);
>> +
>> +    /* Timer 2 start */
>> +    configPR = read_c0_config7();
>> +    configPR &= ~0x00000010;
>> +    write_c0_config7(configPR);
>> +
>> +    /* Timer 3 stop */
>> +    configPR = read_c0_config7();
>> +    configPR |= 0x00000020;
>> +    write_c0_config7(configPR);
>
>    Enabling timers before they are actually set up? :-|

Are the additional timers used at all?

  Ralf
