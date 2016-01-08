Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jan 2016 23:44:46 +0100 (CET)
Received: from exsmtp03.microchip.com ([198.175.253.49]:20343 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010555AbcAHWonv7sTt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Jan 2016 23:44:43 +0100
Received: from [10.14.4.125] (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.181.6; Fri, 8 Jan 2016
 15:44:35 -0700
Subject: Re: [PATCH v3 02/14] irqchip: irq-pic32-evic: Add support for PIC32
 interrupt controller
To:     Thomas Gleixner <tglx@linutronix.de>
References: <1452211389-31025-1-git-send-email-joshua.henderson@microchip.com>
 <1452211389-31025-3-git-send-email-joshua.henderson@microchip.com>
 <alpine.DEB.2.11.1601081931080.3575@nanos>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
From:   Joshua Henderson <joshua.henderson@microchip.com>
Message-ID: <56903D9F.3010908@microchip.com>
Date:   Fri, 8 Jan 2016 15:52:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1601081931080.3575@nanos>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50986
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

On 01/08/2016 12:04 PM, Thomas Gleixner wrote:
> On Thu, 7 Jan 2016, Joshua Henderson wrote:
>> +struct pic_reg {
>> +	u32 val; /* value register*/
> 
> Just a nit. If you want to document your data structure, then please use
> KernelDoc. These tail comments are horrible.
> 

Consider it done.

>> +	u32 clr; /* clear register */
>> +	u32 set; /* set register */
>> +	u32 inv; /* inv register */
>> +} __packed;
>> +
>> +struct evic {
>> +	struct pic_reg intcon;
>> +	struct pic_reg priss;
>> +	struct pic_reg intstat;
>> +	struct pic_reg iptmr;
>> +	struct pic_reg ifs[6];
>> +	u32 reserved1[8];
>> +	struct pic_reg iec[6];
>> +	u32 reserved2[8];
>> +	struct pic_reg ipc[48];
>> +	u32 reserved3[64];
>> +	u32 off[191];
> 
> It would be way simpler to parse if you structured it like a table
> 

Ack

> +	struct pic_reg	intcon;
> +	struct pic_reg	priss;
> +	struct pic_reg	intstat;
> +	struct pic_reg	iptmr;
> +	struct pic_reg	ifs[6];
> +	u32		reserved1[8];
> +	struct pic_reg	iec[6];
> +	u32		reserved2[8];
> +	struct pic_reg	ipc[48];
> +	u32		reserved3[64];
> +	u32		off[191];
> 
>> +} __packed;
>> +
>> +static int get_ext_irq_index(irq_hw_number_t hw);
>> +static void evic_set_ext_irq_polarity(int ext_irq, u32 type);
> 
> If you move the functions right here, then you don't need the forward
> declarations.
> 

Ack

>> +/* mask off an interrupt */
>> +static inline void mask_pic32_irq(struct irq_data *irqd)
>> +{
>> +	u32 reg, mask;
>> +	unsigned int hwirq = irqd_to_hwirq(irqd);
>> +
>> +	BIT_REG_MASK(hwirq, reg, mask);
>> +	writel(mask, &evic_base->iec[reg].clr);
>> +}
>> +
>> +/* unmask an interrupt */
>> +static inline void unmask_pic32_irq(struct irq_data *irqd)
>> +{
>> +	u32 reg, mask;
>> +	unsigned int hwirq = irqd_to_hwirq(irqd);
>> +
>> +	BIT_REG_MASK(hwirq, reg, mask);
>> +	writel(mask, &evic_base->iec[reg].set);
>> +}
>> +
>> +/* acknowledge an interrupt */
>> +static void ack_pic32_irq(struct irq_data *irqd)
>> +{
>> +	u32 reg, mask;
>> +	unsigned int hwirq = irqd_to_hwirq(irqd);
>> +
>> +	BIT_REG_MASK(hwirq, reg, mask);
>> +	writel(mask, &evic_base->ifs[reg].clr);
> 
> So you invented an open coded variant of the generic irq chip. Just with the
> difference that the generic chip caches the mask and the register offsets ....
> 

On PIC32 we have 4 different register offsets in many cases, including the interrupt
controller registers, to write to one hardware register.  The PIC32 has special
write only registers for set/clear/invert and which one is used is dependent on
the logic at the time of writel(). Point being, there is no obvious value in
caching when using these registers.  We don't have to perform a readl() at any
time beforehand to write a mask to a register to update it atomically.

>> +}
>> +
>> +static int set_type_pic32_irq(struct irq_data *data, unsigned int flow_type)
>> +{
>> +	int index;
>> +
>> +	switch (flow_type) {
>> +
>> +	case IRQ_TYPE_EDGE_RISING:
>> +	case IRQ_TYPE_EDGE_FALLING:
>> +		irq_set_handler_locked(data, handle_edge_irq);
>> +		break;
>> +
>> +	case IRQ_TYPE_LEVEL_HIGH:
>> +	case IRQ_TYPE_LEVEL_LOW:
>> +		irq_set_handler_locked(data, handle_fasteoi_irq);
>> +		break;
>> +
>> +	default:
>> +		pr_err("Invalid interrupt type !\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* set polarity for external interrupts only */
>> +	index = get_ext_irq_index(data->hwirq);
>> +	if (index >= 0)
>> +		evic_set_ext_irq_polarity(index, flow_type);
> 
> So for the non external interrupts you set a different handler and be
> done. How is that supposed to work? They switch magically from one mode to the
> other?
> 

It's all the same handlers (depending on whether it's persistent or
non-persistent) irrelevant of it being an external interrupt or not.  It's all
the same hardware interrupt controller.  Some pins on the chip can be configured
as an interrupt source through pin configuration and those have dedicated
interrupts associated with them.  The only thing "special" about these external
interrupts is they must be explicitly configured as edge rising or edge falling
in hardware- which is what is being handled here.  Non-external interrupts don't
need this configuration.

>> +static void pic32_bind_evic_interrupt(int irq, int set)
>> +{
>> +	writel(set, &evic_base->off[irq]);
>> +}
>> +
>> +int pic32_get_c0_compare_int(void)
>> +{
>> +	int virq;
>> +
>> +	virq = irq_create_mapping(evic_irq_domain, CORE_TIMER_INTERRUPT);
>> +	irq_set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
>> +	return virq;
> 
> Why isn't that information retrieved via device tree?
> 

I suppose it could be.  We took a lesson from irq-mips-gic.c on this one.

>> +}
>> +
>> +static struct irq_chip pic32_irq_chip = {
>> +	.name = "PIC32-EVIC",
>> +	.irq_ack = ack_pic32_irq,
>> +	.irq_mask = mask_pic32_irq,
>> +	.irq_unmask = unmask_pic32_irq,
>> +	.irq_eoi = ack_pic32_irq,
>> +	.irq_set_type = set_type_pic32_irq,
> 
> Again, this want's to be in tabular form, if at all.
> 

Ack

>> +};
>> +
>> +static void evic_set_irq_priority(int irq, int priority)
>> +{
>> +	u32 reg, shift;
>> +
>> +	reg = irq / 4;
>> +	shift = (irq % 4) * 8;
>> +
>> +	/* set priority */
>> +	writel(INT_MASK << shift, &evic_base->ipc[reg].clr);
>> +	writel(priority << shift, &evic_base->ipc[reg].set);
>> +}
>> +
>> +static void evic_set_ext_irq_polarity(int ext_irq, u32 type)
>> +{
>> +	if (WARN_ON(ext_irq >= NR_EXT_IRQS))
>> +		return;
> 
> That WARN_ON is really helpful because you already made sure not to call it
> for non EXT irqs.
> 

It is indeed redundant.

>> +	switch (type) {
>> +	case IRQ_TYPE_EDGE_RISING:
>> +		writel(1 << ext_irq, &evic_base->intcon.set);
>> +		break;
>> +	case IRQ_TYPE_EDGE_FALLING:
>> +		writel(1 << ext_irq, &evic_base->intcon.clr);
>> +		break;
>> +	default:
>> +		pr_err("Invalid external interrupt polarity !\n");
>> +	}
>> +}
>> +
>> +static int get_ext_irq_index(irq_hw_number_t hw)
>> +{
>> +	switch (hw) {
>> +	case EXTERNAL_INTERRUPT_0:
>> +		return 0;
>> +	case EXTERNAL_INTERRUPT_1:
>> +		return 1;
>> +	case EXTERNAL_INTERRUPT_2:
>> +		return 2;
>> +	case EXTERNAL_INTERRUPT_3:
>> +		return 3;
>> +	case EXTERNAL_INTERRUPT_4:
>> +		return 4;
>> +	default:
>> +		return -1;
>> +	}
>> +}
> 
> Why don't you use a seperate irq chip for the ext irqs? You can do that with
> the generic chip as well.
> 
>     irq_alloc_domain_generic_chips(domain, 32, 2, ....)
> 
> And then you assign the alternate chip (2) to your ext irqs and have the set
> type function only for the alternate chip.
> 

We have one interrupt controller.  All interrupts have a hardware hard-coded
flow type (edge, level) with the exception of what we are calling "external
interrupts".  These are essentially gpio interrupts that can be software
configured as edge rising or edge falling.  Otherwise, there is no difference
between any of the interrupts.  Does setting edge parity for these interrupts
really warrant a new irq domain and irq_chip?

> Thanks,
> 
> 	tglx
> 

Josh
