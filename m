Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jan 2008 17:04:57 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:47799 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20023841AbYAJREu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 Jan 2008 17:04:50 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id A3D143EC9; Thu, 10 Jan 2008 09:04:47 -0800 (PST)
Message-ID: <47865063.7060208@ru.mvista.com>
Date:	Thu, 10 Jan 2008 20:05:39 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Vitaly Wool <vitalywool@gmail.com>, linux-mips@linux-mips.org
Subject: Re: pnx8xxx: move to clocksource
References: <4786273D.7010006@gmail.com> <478645FD.2090708@ru.mvista.com> <20080110162744.GA16880@linux-mips.org>
In-Reply-To: <20080110162744.GA16880@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

> On Thu, Jan 10, 2008 at 07:21:17PM +0300, Sergei Shtylyov wrote:

>>>Index: linux-2.6/arch/mips/philips/pnx8550/common/time.c
>>>===================================================================
>>>--- linux-2.6.orig/arch/mips/philips/pnx8550/common/time.c
>>>+++ linux-2.6/arch/mips/philips/pnx8550/common/time.c
>>>@@ -22,7 +22,6 @@
>>>#include <linux/kernel_stat.h>
>>>#include <linux/spinlock.h>
>>>#include <linux/interrupt.h>
>>>-#include <linux/module.h>
>>>
>>>#include <asm/bootinfo.h>
>>>#include <asm/cpu.h>
>>>@@ -41,11 +40,60 @@ static cycle_t hpt_read(void)
>>>    return read_c0_count2();
>>>}
>>
>>>+static struct clocksource pnx_clocksource = {
>>>+    .name        = "pnx8xxx",
>>>+    .rating        = 200,
>>>+    .read        = hpt_read,
>>>+    .flags        = CLOCK_SOURCE_IS_CONTINUOUS,
>>>+};

>>   Something probably have converted tabs to 8 spaces...

> Only 3 of them?

    Erm, it's format=flowed that spoils the tabs for Mozilla which renders 
them to 4 spaces, so it's actually hard to see which tabs are actually tabs 
and which are not... :-/

>>   I would have done it otherwise -- using timer 1 as a generic MIPS 
>>clocksource (just hooking the IRQ to reload the comparator to all ones), 
>>and timer 2 as clockevent...

>>>static void timer_ack(void)
>>>{
>>>    write_c0_compare(cpj);
>>>}

>>   Do we still need this function? I don't think so -- mips_timer_ack() is 
>>dead...

> It's only used on initialization.

    Could have put the call inline, or loaded the comparator with all ones 
just like timer 2 -- we don't need 'cpj' variable any more as well...

>>[...]

>>>+static struct clock_event_device pnx8xxx_clockevent = {
>>>+    .name        = "pnx8xxx_clockevent",
>>>+    .features    = CLOCK_EVT_FEAT_ONESHOT,

>>   Aren't PNX8550 timers actually periodic in nature?

> All I recall is they were odd ;-)

> The hardware nature of timers and how to declare them to the Linux timer
> code is not always the same.  CLOCK_EVT_FEAT_ONESHOT be used if the
> time to the next shot can be programmed.

    I meant that both modes should have been indicated by the flags.
And actually, shouldn't we disable the timer after expiry if in one-shot mode.
Writing to the comparator doesn't clear the counter, AFAICS -- so, isn't the 
explicit counter clearing to 0 needed in set_next_event() method?

>>>__init void plat_time_init(void)
>>>{
>>>+    unsigned int             configPR;

>>  Something has definitely spoilt all the tabs in the patch...

> I fixed the three checkpatch.pl was bitching about.

    All the others were due to the way format=flowed is rendered by Mozilla it 
seems...

>>>    unsigned int             n;
>>>    unsigned int             m;
>>>    unsigned int             p;
>>>    unsigned int             pow2p;
>>>
>>>+    clockevents_register_device(&pnx8xxx_clockevent);
>>>+    clocksource_register(&pnx_clocksource);
>>>+
>>>+    setup_irq(PNX8550_INT_TIMER1, &pnx8xxx_timer_irq);
>>>+    setup_irq(PNX8550_INT_TIMER2, &monotonic_irqaction);
>>>+
>>>+    /* Timer 1 start */
>>>+    configPR = read_c0_config7();
>>>+    configPR &= ~0x00000008;
>>>+    write_c0_config7(configPR);
>>>+
>>>+    /* Timer 2 start */
>>>+    configPR = read_c0_config7();
>>>+    configPR &= ~0x00000010;
>>>+    write_c0_config7(configPR);
>>>+
>>>+    /* Timer 3 stop */
>>>+    configPR = read_c0_config7();
>>>+    configPR |= 0x00000020;
>>>+    write_c0_config7(configPR);

>>   Enabling timers before they are actually set up? :-|

> Are the additional timers used at all?

    Additional == timer 3? It's not used, only 1 and 2 are -- and their 
count/compare registers are initialized further in this function...

>   Ralf

WBR, Sergei
