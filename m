Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Feb 2018 11:41:38 +0100 (CET)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53178 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990400AbeBGKl2ZvLxA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Feb 2018 11:41:28 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FBAD1435;
        Wed,  7 Feb 2018 02:41:21 -0800 (PST)
Received: from [10.1.207.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFE243F24D;
        Wed,  7 Feb 2018 02:41:19 -0800 (PST)
Subject: Re: [PATCH] irqchip: mips-gic: Avoid spuriously handling masked
 interrupts
To:     Matt Redfearn <matt.redfearn@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
References: <1517849136-29508-1-git-send-email-matt.redfearn@mips.com>
 <bb76fb4e-5e6c-92eb-d79a-96045f74e91b@arm.com>
 <e7ec98be-5a4b-ef54-797d-7e11cf2b14e5@mips.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <5d6348d6-a87f-d3b7-b758-9a2003d9c50e@arm.com>
Date:   Wed, 7 Feb 2018 10:41:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e7ec98be-5a4b-ef54-797d-7e11cf2b14e5@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62449
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

On 07/02/18 09:44, Matt Redfearn wrote:
> Hi Marc,
> 
> On 07/02/18 09:41, Marc Zyngier wrote:
>> On 05/02/18 16:45, Matt Redfearn wrote:
>>> Commit 7778c4b27cbe ("irqchip: mips-gic: Use pcpu_masks to avoid reading
>>> GIC_SH_MASK*") removed the read of the hardware mask register when
>>> handling shared interrupts, instead using the driver's shadow pcpu_masks
>>> entry as the effective mask. Unfortunately this did not take account of
>>> the write to pcpu_masks during gic_shared_irq_domain_map, which
>>> effectively unmasks the interrupt early. If an interrupt is asserted,
>>> gic_handle_shared_int decodes and processes the interrupt even though it
>>> has not yet been unmasked via gic_unmask_irq, which also sets the
>>> appropriate bit in pcpu_masks.
>>>
>>> On the MIPS Boston board, when a console command line of
>>> "console=ttyS0,115200n8r" is passed, the modem status IRQ is enabled in
>>> the UART, which is immediately raised to the GIC. The interrupt has been
>>> mapped, but no handler has yet been registered, nor is it expected to be
>>> unmasked. However, the write to pcpu_masks in gic_shared_irq_domain_map
>>> has effectively unmasked it, resulting in endless reports of:
>>>
>>> [    5.058454] irq 13, desc: ffffffff80a7ad80, depth: 1, count: 0, unhandled: 0
>>> [    5.062057] ->handle_irq():  ffffffff801b1838,
>>> [    5.062175] handle_bad_irq+0x0/0x2c0
>>>
>>> Where IRQ 13 is the UART interrupt.
>>>
>>> To fix this, just remove the write to pcpu_masks in
>>> gic_shared_irq_domain_map. The existing write in gic_unmask_irq is the
>>> correct place for what is now the effective unmasking.
>>>
>>> Fixes: 7778c4b27cbe ("irqchip: mips-gic: Use pcpu_masks to avoid reading GIC_SH_MASK*")
>>> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
>>> Reviewed-by: Paul Burton <paul.burton@mips.com>
>>>
>>> ---
>>>
>>>   drivers/irqchip/irq-mips-gic.c | 2 --
>>>   1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
>>> index b2cfc6d66d74..2c3684ba46e5 100644
>>> --- a/drivers/irqchip/irq-mips-gic.c
>>> +++ b/drivers/irqchip/irq-mips-gic.c
>>> @@ -429,8 +429,6 @@ static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
>>>   	spin_lock_irqsave(&gic_lock, flags);
>>>   	write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | shared_cpu_pin);
>>>   	write_gic_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
>>> -	gic_clear_pcpu_masks(intr);
>>> -	set_bit(intr, per_cpu_ptr(pcpu_masks, cpu));
>>>   	irq_data_update_effective_affinity(data, cpumask_of(cpu));
>>>   	spin_unlock_irqrestore(&gic_lock, flags);
>>>   
>>>
>>
>> Does this need to be Cc to stable (since it fixes something that was
>> merged in 4.14)?
> 
> Sorry, missed stable off the CC list. Yes, it does indeed need to be 
> backported. Should I resubmit?
No need, I'll add that to the patch.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
