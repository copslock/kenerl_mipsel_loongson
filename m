Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jan 2016 20:31:45 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:39744 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009614AbcALTbebSTGK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jan 2016 20:31:34 +0100
Received: from [10.14.4.125] (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Tue, 12 Jan 2016
 12:31:24 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
Subject: Re: [PATCH v3 02/14] irqchip: irq-pic32-evic: Add support for PIC32
 interrupt controller
To:     Thomas Gleixner <tglx@linutronix.de>
References: <1452211389-31025-1-git-send-email-joshua.henderson@microchip.com>
 <1452211389-31025-3-git-send-email-joshua.henderson@microchip.com>
 <alpine.DEB.2.11.1601081931080.3575@nanos> <56903D9F.3010908@microchip.com>
 <alpine.DEB.2.11.1601091148480.3575@nanos>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        "Jason Cooper" <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <5695565E.4050500@microchip.com>
Date:   Tue, 12 Jan 2016 12:39:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1601091148480.3575@nanos>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joshua.henderson@microchip.com
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

Thomas,

On 01/10/2016 03:09 AM, Thomas Gleixner wrote:
> Joshua,
> 
> On Fri, 8 Jan 2016, Joshua Henderson wrote:
>> On 01/08/2016 12:04 PM, Thomas Gleixner wrote:
>>> On Thu, 7 Jan 2016, Joshua Henderson wrote:
>>>> +/* acknowledge an interrupt */
>>>> +static void ack_pic32_irq(struct irq_data *irqd)
>>>> +{
>>>> +	u32 reg, mask;
>>>> +	unsigned int hwirq = irqd_to_hwirq(irqd);
>>>> +
>>>> +	BIT_REG_MASK(hwirq, reg, mask);
>>>> +	writel(mask, &evic_base->ifs[reg].clr);
>>>
>>> So you invented an open coded variant of the generic irq chip. Just with the
>>> difference that the generic chip caches the mask and the register offsets ....
>>>
>>
>> On PIC32 we have 4 different register offsets in many cases, including the interrupt
>> controller registers, to write to one hardware register.  The PIC32 has special
>> write only registers for set/clear/invert and which one is used is dependent on
>> the logic at the time of writel(). Point being, there is no obvious value in
>> caching when using these registers.  We don't have to perform a readl() at any
>> time beforehand to write a mask to a register to update it atomically.
> 
> The generic chip has functions which handle the seperate register case.
> 
> void irq_gc_mask_disable_reg(struct irq_data *d);
> void irq_gc_unmask_enable_reg(struct irq_data *d);
> void irq_gc_mask_disable_reg_and_ack(struct irq_data *d);
> void irq_gc_eoi(struct irq_data *d);
> 

This makes sense now.  Using these is a natural result of moving to using generic chip as suggested below.

>>>> +static int set_type_pic32_irq(struct irq_data *data, unsigned int flow_type)
>>>> +{
>>>> +	int index;
>>>> +
>>>> +	switch (flow_type) {
>>>> +
>>>> +	case IRQ_TYPE_EDGE_RISING:
>>>> +	case IRQ_TYPE_EDGE_FALLING:
>>>> +		irq_set_handler_locked(data, handle_edge_irq);
>>>> +		break;
>>>> +
>>>> +	case IRQ_TYPE_LEVEL_HIGH:
>>>> +	case IRQ_TYPE_LEVEL_LOW:
>>>> +		irq_set_handler_locked(data, handle_fasteoi_irq);
>>>> +		break;
>>>> +
>>>> +	default:
>>>> +		pr_err("Invalid interrupt type !\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	/* set polarity for external interrupts only */
>>>> +	index = get_ext_irq_index(data->hwirq);
>>>> +	if (index >= 0)
>>>> +		evic_set_ext_irq_polarity(index, flow_type);
>>>
>>> So for the non external interrupts you set a different handler and be
>>> done. How is that supposed to work? They switch magically from one mode to the
>>> other?
>>>
>>
>> It's all the same handlers (depending on whether it's persistent or
>> non-persistent) irrelevant of it being an external interrupt or not.  It's all
>> the same hardware interrupt controller.  Some pins on the chip can be configured
>> as an interrupt source through pin configuration and those have dedicated
>> interrupts associated with them.  The only thing "special" about these external
>> interrupts is they must be explicitly configured as edge rising or edge falling
>> in hardware- which is what is being handled here.  Non-external interrupts don't
>> need this configuration.
> 
> I really cannot follow here. The code tells me that I can set
> EDGE_RISING/FALLING/LEVEL_HIGH/LOW for any of those interrupts.
> 
> So that makes two questions:
> 
>    1) Can the non-external mode handle all type variants automagically? I
>       seriously doubt that. If the type cannot be set, then it makes no sense
>       to pretend that it can and allow to switch the handler from fasteoi to
>       edge mode.
> 
>    2) The external irqs do not support level according to your
>       evic_set_ext_irq_polarity() function. But you return success if set_type
>       is called with a level type and gladly switch the handler. You merily
>       pr_warn in evic_set_ext_irq_polarity().
> 
> That's just crap.
> 

Got it.  The plan is for .irq_set_type to only exist for edge interrupts, and properly fail if it is not an external interrupt (meaning, there is no actual hardware change otherwise).  External interrupts will configured through a custom DT property in the evic node.  So, this means all non external interrupts will be "locked" to the DT specified irq type at mapping.  This should cleanly address these two issues.  Comments will be added to explain this.
 
>>>> +int pic32_get_c0_compare_int(void)
>>>> +{
>>>> +	int virq;
>>>> +
>>>> +	virq = irq_create_mapping(evic_irq_domain, CORE_TIMER_INTERRUPT);
>>>> +	irq_set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
>>>> +	return virq;
>>>
>>> Why isn't that information retrieved via device tree?
>>>
>>
>> I suppose it could be.  We took a lesson from irq-mips-gic.c on this one.
> 
> You copied it, right? That does not make it any better.
>  

Typically, this CPU core interrupt number can be read from the CP0 registers.  However, the interrupt controller on PIC32 is the interface/arbiter for all interrupts, peripheral and CPU, and therefore we have to specify it.  Because this is not a unique scenario for probably various reasons, the arch/mips/kernel/cevt-r4k.c provides get_c0_compare_int() as a __weak symbol which is currently overwritten by ~11 MIPS platforms in the exact same non-DTS way.  This is what I meant by saying PIC32 implemented this like irq-mips-gic.c.  So, I see 2 options to address this:

1) Move pic32_get_c0_compare_int() to platform code as get_c0_compare_int().  Load a fixed mapping from DT in the irqchip driver and find that mapping with get_c0_compare_int().
2) Add DT support to arch cevt-r4k.c or cpu_probe.c read an arch common property from DT to get the core timer interrupt number.

I think 1) satisfies your feedback on this.  Does this make sense?

>>> Why don't you use a seperate irq chip for the ext irqs? You can do that with
>>> the generic chip as well.
>>>
>>>     irq_alloc_domain_generic_chips(domain, 32, 2, ....)
>>>
>>> And then you assign the alternate chip (2) to your ext irqs and have the set
>>> type function only for the alternate chip.
>>>
>>
>> We have one interrupt controller.  All interrupts have a hardware hard-coded
>> flow type (edge, level) ...
> 
> And that's exactly the point. They are hardcoded, but you still allow any
> random driver to change the type and therefor the handler. How is that
> supposed to work?
> 

To clarify, by hardcoded, I mean the hardware peripheral the interrupt controller is arbitrating for has a defined irq type.  We specify this in a DT standard way for each peripheral, seeing that it varies by peripheral and there is no rhyme or reason to it in the linear IRQ mapping for > 200 interrupts at the evic level:

	uart1: serial@1f822000 {
                compatible = "microchip,pic32mzda-uart";
		...
                interrupts = <112 IRQ_TYPE_LEVEL_HIGH>,
                        <113 IRQ_TYPE_LEVEL_HIGH>,
                        <114 IRQ_TYPE_LEVEL_HIGH>;
		...
        };

	PBTIMER1:pbtimer1 {
		compatible = "microchip,pic32mzda-timerA";
		...
                interrupts = <4 IRQ_TYPE_EDGE_RISING>;
		...
        };

The shortcoming of allowing a change to the flow handler will be addressed.  It does make sense as you are suggesting to use different irq chips for the different flow handlers.  irq_alloc_domain_generic_chips() will work as suggested and there will be alternate chips for the different scenarios.

>> ...  with the exception of what we are calling "external interrupts".
>> These are essentially gpio interrupts that can be software
>> configured as edge rising or edge falling.  Otherwise, there is no difference
>> between any of the interrupts.
> 
> And again. Here you can change the type, but only edge rising and falling are
> supported. And you still allow setting a level type.
> 

This will be addressed.

> So for both types you allow the driver/DT writer to get it wrong. And of
> course this happens without a single line of comment which explains the
> oddities of your driver, so a causual reader will stumble over it and ask
> exactly the questions I'm asking. We want understandable and maintainable code
> and not some 'work for me' hackery.

Make no mistake, I'm here to do this the right way.  A new irqchip driver is in the oven.

Thanks,
Josh
