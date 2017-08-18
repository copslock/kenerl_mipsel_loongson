Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 19:25:27 +0200 (CEST)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42706 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994932AbdHRRZQhnUhv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Aug 2017 19:25:16 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CFED2B;
        Fri, 18 Aug 2017 10:25:10 -0700 (PDT)
Received: from [10.1.207.16] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C9C63F483;
        Fri, 18 Aug 2017 10:25:09 -0700 (PDT)
Subject: Re: [PATCH 35/38] irqchip: mips-gic: Use pcpu_masks to avoid reading
 GIC_SH_MASK*
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>
References: <20170813043646.25821-1-paul.burton@imgtec.com>
 <20170813043646.25821-36-paul.burton@imgtec.com>
 <405f8fc2-2947-cc68-e40a-b7e26a03e713@arm.com>
 <34162033.30QQ0eu7r0@np-p-burton>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <f44d57df-1071-94f6-75cf-83f5175abf50@arm.com>
Date:   Fri, 18 Aug 2017 18:25:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <34162033.30QQ0eu7r0@np-p-burton>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marc.zyngier@arm.com
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

On 18/08/17 18:11, Paul Burton wrote:
> Hi Marc,
> 
> On Friday, 18 August 2017 08:44:15 PDT Marc Zyngier wrote:
>> On 13/08/17 05:36, Paul Burton wrote:
>>> This patch avoids the need to read the GIC_SH_MASK* registers when
>>> decoding shared interrupts by setting & clearing the interrupt's bit in
>>> the appropriate CPU's pcpu_masks entry when masking or unmasking the
>>> interrupt.
>>>
>>> This effectively means that whilst an interrupt is masked we clear its
>>> bit in all pcpu_masks, which causes gic_handle_shared_int() to ignore it
>>> on all CPUs without needing to check GIC_SH_MASK*.
>>>
>>> In essence, we add a little overhead to masking or unmasking interrupts
>>> but in return reduce the overhead of the far more common task of
>>> decoding interrupts.
>>>
>>> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>>> Cc: Jason Cooper <jason@lakedaemon.net>
>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>> Cc: Ralf Baechle <ralf@linux-mips.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: linux-mips@linux-mips.org
>>> ---
>>>
>>>  drivers/irqchip/irq-mips-gic.c | 49
>>>  ++++++++++++++++++++++++------------------ 1 file changed, 28
>>>  insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/irqchip/irq-mips-gic.c
>>> b/drivers/irqchip/irq-mips-gic.c index 00153231376a..7a42f0b3822f 100644
>>> --- a/drivers/irqchip/irq-mips-gic.c
>>> +++ b/drivers/irqchip/irq-mips-gic.c
>>> @@ -55,6 +55,19 @@ static struct irq_chip gic_level_irq_controller,
>>> gic_edge_irq_controller;> 
>>>  DECLARE_BITMAP(ipi_resrv, GIC_MAX_INTRS);
>>>  DECLARE_BITMAP(ipi_available, GIC_MAX_INTRS);
>>>
>>> +static void gic_setup_pcpu_mask(unsigned int intr, unsigned int cpu)
>>> +{
>>> +	unsigned int i;
>>> +
>>> +	/* Clear the interrupt's bit in all pcpu_masks */
>>> +	for_each_possible_cpu(i)
>>> +		clear_bit(intr, per_cpu_ptr(pcpu_masks, i));
>>
>> This iterates from 0 to nr_cpu_ids-1...
>>
>>> +
>>> +	/* Set the interrupt's bit in the appropriate CPU's mask */
>>> +	if (cpu < NR_CPUS)
>>
>> and here you're using NR_CPUS. I'm a bit worried that you're not quite
>> using the same thing (nr_cpu_ids <= NR_CPUS).
> 
> I think that would be fine - if nr_cpu_ids is less than NR_CPUS then all we 
> risk is leaving bits set in the mask for CPUs that aren't in cpu_possible_mask 
> (which is where nr_cpu_ids comes from). Since those CPUs don't exist & thus 
> can't take interrupts they'll never check the bits in their mask.
> 
> The NR_CPUS check here is basically just to allow the interrupt to be set in 
> none of the masks when called by gic_mask_irq() - NR_CPUS is just some 
> constant value that we know will never be the ID of a CPU that an interrupt's 
> affinity is set to.
> 
> Perhaps it'd be clearer to instead split gic_setup_pcpu_mask() into 2 
> functions - one to just clear all the masks, and one to set the interrupt's 
> bit in the appropriate one? Possibly just inline that second one. That way we 
> wouldn't be using NR_CPUS at all here which might be clearer. How does that 
> sound?

That'd probably be best, even if that's a couple extra lines here and
there. This NR_CPUS is just confusing.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
