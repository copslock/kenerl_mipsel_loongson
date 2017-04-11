Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Apr 2017 10:20:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36214 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992366AbdDKIUmy7NLx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Apr 2017 10:20:42 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 2809C28525931;
        Tue, 11 Apr 2017 09:20:33 +0100 (IST)
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 11 Apr
 2017 09:20:35 +0100
Subject: Re: [PATCH 2/2] irqchip/mips-gic: Fix Local compare interrupt
To:     Paul Burton <paul.burton@imgtec.com>
References: <1490958332-31094-1-git-send-email-matt.redfearn@imgtec.com>
 <1490958332-31094-3-git-send-email-matt.redfearn@imgtec.com>
 <9298882.YeGiCV4jUY@np-p-burton>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <a71e58d4-b223-7bc7-803a-937e3b6837bb@imgtec.com>
Date:   Tue, 11 Apr 2017 09:20:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <9298882.YeGiCV4jUY@np-p-burton>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57664
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Paul,


On 10/04/17 23:06, Paul Burton wrote:
> Hi Matt,
>
> On Friday, 31 March 2017 04:05:32 PDT Matt Redfearn wrote:
>> Commit 4cfffcfa5106 ("irqchip/mips-gic: Fix local interrupts") added
>> mapping of several local interrupts during initialisation of the gic
>> driver. This associates virq numbers with these interrupts.
>> Unfortunately, as not all of the interrupts are mapped in hardware
>> order, when drivers subsequently request these interrupts they conflict
>> with the mappings that have already been set up. For example, this
>> manifests itself in the gic clocksource driver, which fails to probe
>> with the message:
>>
>> clocksource: GIC: mask: 0xffffffffffffffff max_cycles: 0x7350c9738,
>> max_idle_ns: 440795203769 ns
>> GIC timer IRQ 25 setup failed: -22
>>
>> This is because virq 25 (the correct IRQ number specified via device
>> tree) was allocated to the PERFCTR interrupt (and 24 to the timer, 26 to
>> the FDC).
> I'm confused by this - the DT doesn't specify VIRQs, it specifies hardware IRQ
> numbers. Which VIRQ is used should be irrelevant. Is this on a system using
> gic_clocksource_init() from platform code? (Malta?) and therefore relying on
> MIPS_GIC_IRQ_BASE?

Yes, this is on Malta, which as you say, uses MIPS_GIC_IRQ_BASE. On 
Malta that ends up, through the definition of I8259A_IRQ_BASE and 
MIPS_CPU_IRQ_BASE, to be 24. Therefore hardware interrupt 1 of the GIC 
ends up expecting to be allocated at virq 25. But since 4cfffcfa5106, 
that virq number was allocated to the PERFCTR interrupt. Everything 
about the order-dependent and hardcoded bases of Maltas IRQs seems bad 
and needs looking at but this was the easiest fix for this cycle.

>
> If so I think this would be much more cleanly fixed by moving to probe the
> clocksource using DT

Not sure that would help if Maltas expected virq for this source had 
already been allocated?

Thanks,
Matt

> than by adding more fragile order-dependent mappings in
> the GIC driver. Perhaps we have to live with it for this cycle though...
>
> Thanks,
>      Paul
>
>> To fix this, map all of these local interrupts in the hardware
>> order so as to associate their virq numbers with the correct hw
>> interrupts.
>>
>> Fixes: 4cfffcfa5106 ("irqchip/mips-gic: Fix local interrupts")
>> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>> ---
>>
>>   drivers/irqchip/irq-mips-gic.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
>> index 11d12bccc4e7..cd20df12d63d 100644
>> --- a/drivers/irqchip/irq-mips-gic.c
>> +++ b/drivers/irqchip/irq-mips-gic.c
>> @@ -991,8 +991,12 @@ static void __init gic_map_single_int(struct
>> device_node *node,
>>
>>   static void __init gic_map_interrupts(struct device_node *node)
>>   {
>> +	gic_map_single_int(node, GIC_LOCAL_INT_WD);
>> +	gic_map_single_int(node, GIC_LOCAL_INT_COMPARE);
>>   	gic_map_single_int(node, GIC_LOCAL_INT_TIMER);
>>   	gic_map_single_int(node, GIC_LOCAL_INT_PERFCTR);
>> +	gic_map_single_int(node, GIC_LOCAL_INT_SWINT0);
>> +	gic_map_single_int(node, GIC_LOCAL_INT_SWINT1);
>>   	gic_map_single_int(node, GIC_LOCAL_INT_FDC);
>>   }
