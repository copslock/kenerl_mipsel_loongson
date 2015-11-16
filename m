Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2015 20:43:11 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:60411 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012822AbbKPTnJTL8iz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Nov 2015 20:43:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=MOWM0vlUlnhc9uv+5Ba5ckROxt4PNUe7ZcXFdT6+nJM=;
        b=mmX3O/zejcOs2WhaAugd/APaS1YxWV9XTfO2vWbNsISTEz+CXqIAN7a27mb/XrqF4d5ZfQlH5sK1PZotmhLtPya4uy9LCanUzzlLQ41cLDrKgNq4VzkgijccDa5AmfaB8fP/cTudXXnEeh8MLjwRttDjM0bikCoJXyGyna7NwvJQ17MTvyU1AeeyUIYYqDxr0ZoBlk0a4hk7133C47r1s9p8cH5t39aiu74pBBVZ0ev5PpBze35acERjPb5/Cdx7lPJ0uAjGHfHZpdethcVUi+DTbp+InYsXMLyxKUavE2JP/prm4A12Yzh2xRtVIHDRMkxO1hXZCzP+3Q0GotvXFg==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:43130 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1ZyPfz-0005xJ-BY (Exim); Mon, 16 Nov 2015 19:42:56 +0000
Subject: Re: [PATCH 2/2] MIPS: bmips: Add bcm63168-l1 interrupt controller
To:     Jonas Gorski <jogo@openwrt.org>
References: <5648B804.40806@simon.arlott.org.uk>
 <5648B89A.8080203@simon.arlott.org.uk>
 <CAOiHx=nNN1XhAihNtFhWEozvA6KpV0BBexf2W3CuB4PX4U_zyw@mail.gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <564A31BE.1060504@simon.arlott.org.uk>
Date:   Mon, 16 Nov 2015 19:42:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <CAOiHx=nNN1XhAihNtFhWEozvA6KpV0BBexf2W3CuB4PX4U_zyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: simon@fire.lp0.eu
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

On 16/11/15 12:56, Jonas Gorski wrote:
> On Sun, Nov 15, 2015 at 5:53 PM, Simon Arlott <simon@fire.lp0.eu> wrote:
>> Add the BCM63168 interrupt controller based on the SMP-capable BCM7038
>> and the BCM3380 but with packed interrupt registers.
>>
>> Add the BCM63168 interrupt controller to a list with the existing BCM7038
>> so that interrupts on CPU1 are not ignored.

This will be renamed to bcm6345-l1.

...
>> diff --git a/drivers/irqchip/irq-bcm63168-l1.c b/drivers/irqchip/irq-bcm63168-l1.c
>> new file mode 100644
>> index 0000000..5a144af
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-bcm63168-l1.c
>> @@ -0,0 +1,372 @@
>> +/*
>> + * Broadcom BCM63168 style Level 1 interrupt controller driver
>> + *
>> + * Copyright (C) 2014 Broadcom Corporation
>> + * Copyright 2015 Simon Arlott
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This is based on the BCM7038 (which supports SMP) but with a single
>> + * enable register instead of separate mask/set/clear registers.
>> + *
>> + * The BCM3380 has a similar mask/status register layout, but each pair
>> + * of words is at separate locations (and SMP is not supported).
>> + *
>> + * ENABLE/STATUS words are packed next to each other for each CPU:
>> + *
>> + * 6368:
>> + *   0x1000_0020: CPU0_W0_ENABLE
>> + *   0x1000_0024: CPU0_W1_ENABLE
>> + *   0x1000_0028: CPU0_W0_STATUS               IRQs 31-63
>> + *   0x1000_002c: CPU0_W1_STATUS               IRQs 0-31
>> + *   0x1000_0030: CPU1_W0_ENABLE
>> + *   0x1000_0034: CPU1_W1_ENABLE
>> + *   0x1000_0038: CPU1_W0_STATUS               IRQs 31-63
>> + *   0x1000_003c: CPU1_W1_STATUS               IRQs 0-31
>> + *
>> + * 63168:
>> + *   0x1000_0020: CPU0_W0_ENABLE
>> + *   0x1000_0024: CPU0_W1_ENABLE
>> + *   0x1000_0028: CPU0_W2_ENABLE
>> + *   0x1000_002c: CPU0_W3_ENABLE
>> + *   0x1000_0030: CPU0_W0_STATUS       IRQs 96-127
>> + *   0x1000_0034: CPU0_W1_STATUS       IRQs 64-95
>> + *   0x1000_0038: CPU0_W2_STATUS       IRQs 32-63
>> + *   0x1000_003c: CPU0_W3_STATUS       IRQs 0-31
>> + *   0x1000_0040: CPU1_W0_ENABLE
>> + *   0x1000_0044: CPU1_W1_ENABLE
>> + *   0x1000_0048: CPU1_W2_ENABLE
>> + *   0x1000_004c: CPU1_W3_ENABLE
>> + *   0x1000_0050: CPU1_W0_STATUS       IRQs 96-127
>> + *   0x1000_0054: CPU1_W1_STATUS       IRQs 64-95
>> + *   0x1000_0058: CPU1_W2_STATUS       IRQs 32-63
>> + *   0x1000_005c: CPU1_W3_STATUS       IRQs 0-31
>> + *
>> + * IRQs are numbered in CPU native endian order
>> + * (which is big-endian in these examples)
>> + */
>> +
...
>> +static inline unsigned int reg_enable(struct bcm63168_l1_chip *intc,
>> +                                          unsigned int word)
>> +{
>> +#ifdef __BIG_ENDIAN
>> +       return (1 * intc->n_words - word - 1) * sizeof(u32);
>> +#else
>> +       return (0 * intc->n_words + word) * sizeof(u32);
> 
> Huh, do the words really change the order when running in LE? I would
> have expected
> to each 32-bit word to contain the same interrupts, just bit-order reversed.

Without having a LE version of this SoC to check it on, I don't know...
but this device binding is specified as native endian and the current
ordering is definitely BE as interrupt "0" is in the last register.

>> +#endif
>> +}
>> +
>> +static inline unsigned int reg_status(struct bcm63168_l1_chip *intc,
>> +                                     unsigned int word)
>> +{
>> +#ifdef __BIG_ENDIAN
>> +       return (2 * intc->n_words - word - 1) * sizeof(u32);
>> +#else
>> +       return (1 * intc->n_words + word) * sizeof(u32);
>> +#endif
>> +}
>> +
>> +static inline unsigned int cpu_for_irq(struct bcm63168_l1_chip *intc,
>> +                                       struct irq_data *d)
>> +{
>> +       return cpumask_first_and(&intc->cpumask, irq_data_get_affinity_mask(d));
>> +}
>> +
>> +static void bcm63168_l1_irq_handle(struct irq_desc *desc)
>> +{
>> +       struct bcm63168_l1_chip *intc = irq_desc_get_handler_data(desc);
>> +       struct bcm63168_l1_cpu *cpu;
>> +       struct irq_chip *chip = irq_desc_get_chip(desc);
>> +       unsigned int idx;
>> +
>> +#ifdef CONFIG_SMP
>> +       cpu = intc->cpus[cpu_logical_map(smp_processor_id())];
>> +#else
>> +       cpu = intc->cpus[0];
>> +#endif
> 
> This looks expensive, can they change during runtime? If not, maybe
> just assign intc->cpus[] accordingly at probe time, so you can just do
> intc->cpus[smp_processor_id()] without any #ifdefs.

It's an array lookup in mips, so it becomes:
    cpu = intc->cpus[__cpu_logical_map[smp_processor_id()]];

I could just remove the ifdef because smp_processor_id() becomes 0. It
looks like it still does the array lookup.

The bcm7038-l1 driver had this ifdef.

>> +
>> +       chained_irq_enter(chip, desc);
>> +
>> +       for (idx = 0; idx < intc->n_words; idx++) {
>> +               int base = idx * IRQS_PER_WORD;
>> +               unsigned long pending;
>> +               irq_hw_number_t hwirq;
>> +               unsigned int irq;
>> +
>> +               pending = __raw_readl(cpu->map_base + reg_status(intc, idx));
>> +               pending &= __raw_readl(cpu->map_base + reg_enable(intc, idx));
> 
> Is it save to access the registers without any locking? 7038-l1
> doesn't think so.

7038-l1 is using a lock because it's accessing its own copy of the
enable mask. I read the controller's enable register to determine what
is currently enabled.

When the enable mask is modified it uses intc->cpus[n]->enable_cache
(with a lock held) and then writes it to the controller.

This way I don't need to have both CPUs compete with each other for the
same lock within the interrupt handler itself.

>> +
>> +               for_each_set_bit(hwirq, &pending, IRQS_PER_WORD) {
>> +                       irq = irq_linear_revmap(intc->domain, base + hwirq);
>> +                       if (irq)
>> +                               do_IRQ(irq);
>> +                       else
>> +                               spurious_interrupt();
>> +               }
>> +       }
>> +
>> +       chained_irq_exit(chip, desc);
>> +}
>> +
>> +static inline void __bcm63168_l1_unmask(struct irq_data *d)
>> +{
>> +       struct bcm63168_l1_chip *intc = irq_data_get_irq_chip_data(d);
>> +       u32 word = d->hwirq / IRQS_PER_WORD;
>> +       u32 mask = BIT(d->hwirq % IRQS_PER_WORD);
>> +       unsigned int cpu_idx = cpu_for_irq(intc, d);
>> +
>> +       intc->cpus[cpu_idx]->enable_cache[word] |= mask;
>> +       __raw_writel(intc->cpus[cpu_idx]->enable_cache[word],
>> +               intc->cpus[cpu_idx]->map_base + reg_enable(intc, word));
>> +}
>> +
>> +static inline void __bcm63168_l1_mask(struct irq_data *d)
>> +{
>> +       struct bcm63168_l1_chip *intc = irq_data_get_irq_chip_data(d);
>> +       u32 word = d->hwirq / IRQS_PER_WORD;
>> +       u32 mask = BIT(d->hwirq % IRQS_PER_WORD);
>> +       unsigned int cpu_idx = cpu_for_irq(intc, d);
>> +
>> +       intc->cpus[cpu_idx]->enable_cache[word] &= ~mask;
>> +       __raw_writel(intc->cpus[cpu_idx]->enable_cache[word],
>> +               intc->cpus[cpu_idx]->map_base + reg_enable(intc, word));
>> +}
>> +
>> +static void bcm63168_l1_unmask(struct irq_data *d)
>> +{
>> +       struct bcm63168_l1_chip *intc = irq_data_get_irq_chip_data(d);
>> +       u32 word = d->hwirq / IRQS_PER_WORD;
>> +       unsigned long flags;
>> +
>> +       raw_spin_lock_irqsave(&intc->lock[word], flags);
>> +       __bcm63168_l1_unmask(d);
>> +       raw_spin_unlock_irqrestore(&intc->lock[word], flags);
>> +}
>> +
>> +static void bcm63168_l1_mask(struct irq_data *d)
>> +{
>> +       struct bcm63168_l1_chip *intc = irq_data_get_irq_chip_data(d);
>> +       u32 word = d->hwirq / IRQS_PER_WORD;
>> +       unsigned long flags;
>> +
>> +       raw_spin_lock_irqsave(&intc->lock[word], flags);
>> +       __bcm63168_l1_mask(d);
>> +       raw_spin_unlock_irqrestore(&intc->lock[word], flags);
>> +}
>> +
...
>> +
>> +static struct irq_chip bcm63168_l1_irq_chip = {
>> +       .name                   = "bcm63168-l1",
>> +       .irq_mask               = bcm63168_l1_mask,
>> +       .irq_unmask             = bcm63168_l1_unmask,
>> +       .irq_set_affinity       = bcm63168_l1_set_affinity,
>> +};
> 
> You are already allocing memory, why not alloc this one as well?

The data is a const name and set of function pointers that is never
modified.

>> +
>> +static int bcm63168_l1_map(struct irq_domain *d, unsigned int virq,
>> +                         irq_hw_number_t hw_irq)
>> +{
>> +       irq_set_chip_and_handler(virq,
>> +               &bcm63168_l1_irq_chip, handle_percpu_irq);
>> +       irq_set_chip_data(virq, d->host_data);
>> +       return 0;
>> +}
>> +
>> +static const struct irq_domain_ops bcm63168_l1_domain_ops = {
>> +       .xlate                  = irq_domain_xlate_onecell,
>> +       .map                    = bcm63168_l1_map,
>> +};
>> +
>> +static int __init bcm63168_l1_of_init(struct device_node *dn,
>> +                             struct device_node *parent)
>> +{
>> +       struct bcm63168_l1_chip *intc;
>> +       unsigned int idx;
>> +       int ret;
>> +
>> +       intc = kzalloc(sizeof(*intc), GFP_KERNEL);
>> +       if (!intc)
>> +               return -ENOMEM;
>> +
>> +       cpumask_clear(&intc->cpumask);
> 
> intc->cpumask is already cleared since kzalloc'd.

Ok.

>> +
>> +       for_each_possible_cpu(idx) {
>> +               ret = bcm63168_l1_init_one(dn, idx, intc);
>> +               if (ret)
>> +                       pr_err("failed to init intc L1 for cpu %d: %d\n",
>> +                               idx, ret);
>> +               else
>> +                       cpumask_set_cpu(idx, &intc->cpumask);
>> +       }
>> +
>> +       if (!cpumask_weight(&intc->cpumask)) {
>> +               ret = -ENODEV;
>> +               goto out_free;
>> +       }
>> +
>> +       for (idx = 0; idx < intc->n_words; idx++)
>> +               raw_spin_lock_init(&intc->lock[idx]);
> 
> Do you really need a spinlock for each word?

No, this made more sense when I was using handle_level_irq and had
interrupts going to both CPUs, but the controller is too eager to
dispatch the same interrupt to both CPUs almost-simultaneously.

I'll change it to a single spinlock.

>> +
>> +       intc->domain = irq_domain_add_linear(dn, IRQS_PER_WORD * intc->n_words,
>> +                                            &bcm63168_l1_domain_ops,
>> +                                            intc);
>> +       if (!intc->domain) {
>> +               ret = -ENOMEM;
>> +               goto out_unmap;
>> +       }
>> +
>> +       pr_info("registered BCM63168 L1 intc (IRQs: %d)\n",
>> +                       IRQS_PER_WORD * intc->n_words);
>> +       for_each_cpu(idx, &intc->cpumask) {
>> +               struct bcm63168_l1_cpu *cpu = intc->cpus[idx];
>> +
>> +               pr_info("  CPU%u at MMIO 0x%p (irq = %d)\n", idx,
>> +                               cpu->map_base, cpu->parent_irq);
>> +       }
>> +
>> +       return 0;
>> +
>> +out_unmap:
>> +       for_each_possible_cpu(idx) {
>> +               struct bcm63168_l1_cpu *cpu = intc->cpus[idx];
>> +
>> +               if (cpu) {
>> +                       if (cpu->map_base)
>> +                               iounmap(cpu->map_base);
>> +                       kfree(cpu);
>> +               }
>> +       }
>> +out_free:
>> +       kfree(intc);
>> +       return ret;
>> +}
>> +
>> +IRQCHIP_DECLARE(bcm63168_l1, "brcm,bcm63168-l1-intc", bcm63168_l1_of_init);
>> --
>> 2.1.4
> 
> 
> Jonas
> 


-- 
Simon Arlott
