Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 21:45:47 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16255 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903689Ab1KKUpk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Nov 2011 21:45:40 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ebd89c50000>; Fri, 11 Nov 2011 12:47:01 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 11 Nov 2011 12:45:37 -0800
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 11 Nov 2011 12:45:37 -0800
Message-ID: <4EBD8971.2090408@caviumnetworks.com>
Date:   Fri, 11 Nov 2011 12:45:37 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Rob Herring <robherring2@gmail.com>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 3/8] MIPS: Octeon: Add irq_create_of_mapping() and GPIO
 interrupts.
References: <1320978124-13042-1-git-send-email-ddaney.cavm@gmail.com> <1320978124-13042-4-git-send-email-ddaney.cavm@gmail.com> <4EBD4868.7040809@gmail.com> <4EBD7C5D.7080606@gmail.com> <4EBD8867.30205@gmail.com>
In-Reply-To: <4EBD8867.30205@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Nov 2011 20:45:37.0806 (UTC) FILETIME=[DE1E6AE0:01CCA0B2]
X-archive-position: 31583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10624

On 11/11/2011 12:41 PM, Rob Herring wrote:
> David,
>
> On 11/11/2011 01:49 PM, David Daney wrote:
>> On 11/11/2011 08:08 AM, Rob Herring wrote:
>>> On 11/10/2011 08:21 PM, ddaney.cavm@gmail.com wrote:
>>>> From: David Daney<david.daney@cavium.com>
>>>>
>>>> This is needed for Octeon to use the Device Tree.
>>>>
>>>> The GPIO interrupts are configured based on Device Tree properties
>>>>
>>>> Signed-off-by: David Daney<david.daney@cavium.com>
>>>> ---
>>>>    arch/mips/cavium-octeon/octeon-irq.c |  188
>>>> +++++++++++++++++++++++++++++++++-
>>>>    1 files changed, 187 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/arch/mips/cavium-octeon/octeon-irq.c
>>>> b/arch/mips/cavium-octeon/octeon-irq.c
>>>> index ffd4ae6..bb10546 100644
>>>> --- a/arch/mips/cavium-octeon/octeon-irq.c
>>>> +++ b/arch/mips/cavium-octeon/octeon-irq.c
>>>> @@ -8,11 +8,14 @@
>>>>
>>>>    #include<linux/interrupt.h>
>>>>    #include<linux/bitops.h>
>>>> +#include<linux/module.h>
>>>>    #include<linux/percpu.h>
>>>> +#include<linux/of_irq.h>
>>>>    #include<linux/irq.h>
>>>>    #include<linux/smp.h>
>>>>
>>>>    #include<asm/octeon/octeon.h>
>>>> +#include<asm/octeon/cvmx-gpio-defs.h>
>>>>
>>>>    static DEFINE_RAW_SPINLOCK(octeon_irq_ciu0_lock);
>>>>    static DEFINE_RAW_SPINLOCK(octeon_irq_ciu1_lock);
>>>> @@ -58,6 +61,95 @@ static void __init octeon_irq_set_ciu_mapping(int
>>>> irq, int line, int bit,
>>>>        octeon_irq_ciu_to_irq[line][bit] = irq;
>>>>    }
>>>>
>>>> +static unsigned int octeon_irq_gpio_mapping(struct device_node
>>>> *controller,
>>>> +                        const u32 *intspec,
>>>> +                        unsigned int intsize)
>>>> +{
>>>> +    struct of_irq oirq;
>>>> +    int i;
>>>> +    unsigned int irq = 0;
>>>> +    unsigned int type;
>>>> +    unsigned int ciu = 0, bit = 0;
>>>> +    unsigned int pin = be32_to_cpup(intspec);
>>>> +    unsigned int trigger = be32_to_cpup(intspec + 1);
>>>> +    bool set_edge_handler = false;
>>>> +
>>>> +    if (pin>= 16)
>>>> +        goto err;
>>>> +    i = of_irq_map_one(controller, 0,&oirq);
>>>> +    if (i)
>>>> +        goto err;
>>>> +    if (oirq.size != 2)
>>>> +        goto err_put;
>>>> +
>>>> +    ciu = oirq.specifier[0];
>>>> +    bit = oirq.specifier[1] + pin;
>>>> +
>>>> +    if (ciu>= 8 || bit>= 64)
>>>> +        goto err_put;
>>>> +
>>>> +    irq = octeon_irq_ciu_to_irq[ciu][bit];
>>>> +    if (!irq)
>>>> +        goto err_put;
>>>> +
>>>> +    switch (trigger&   0xf) {
>>>> +    case 1:
>>>> +        type = IRQ_TYPE_EDGE_RISING;
>>>> +        set_edge_handler = true;
>>>> +        break;
>>>> +    case 2:
>>>> +        type = IRQ_TYPE_EDGE_FALLING;
>>>> +        set_edge_handler = true;
>>>> +        break;
>>>> +    case 4:
>>>> +        type = IRQ_TYPE_LEVEL_HIGH;
>>>> +        break;
>>>> +    case 8:
>>>> +        type = IRQ_TYPE_LEVEL_LOW;
>>>> +        break;
>>>> +    default:
>>>> +        pr_err("Error: Invalid irq trigger specification: %x\n",
>>>> +               trigger);
>>>> +        type = IRQ_TYPE_LEVEL_LOW;
>>>> +        break;
>>>> +    }
>>>> +
>>>> +    irq_set_irq_type(irq, type);
>>>> +
>>>> +    if (set_edge_handler)
>>>> +        __irq_set_handler(irq, handle_edge_irq, 0, NULL);
>>>> +
>>>> +err_put:
>>>> +    of_node_put(oirq.controller);
>>>> +err:
>>>> +    return irq;
>>>> +}
>>>> +
>>>> +/*
>>>> + * irq_create_of_mapping - Hook to resolve OF irq specifier into a
>>>> Linux irq#
>>>> + *
>>>> + * Octeon irq maps are a pair of indexes.  The first selects either
>>>> + * ciu0 or ciu1, the second is the bit within the ciu register.
>>>> + */
>>>> +unsigned int irq_create_of_mapping(struct device_node *controller,
>>>> +                   const u32 *intspec, unsigned int intsize)
>>>> +{
>>>> +    unsigned int irq = 0;
>>>> +    unsigned int ciu, bit;
>>>> +
>>>> +    if (of_device_is_compatible(controller, "cavium,octeon-3860-gpio"))
>>>> +        return octeon_irq_gpio_mapping(controller, intspec, intsize);
>>>> +
>>>> +    ciu = be32_to_cpup(intspec);
>>>> +    bit = be32_to_cpup(intspec + 1);
>>>> +
>>>> +    if (ciu<   8&&   bit<   64)
>>>> +        irq = octeon_irq_ciu_to_irq[ciu][bit];
>>>> +
>>>> +    return irq;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(irq_create_of_mapping);
>>>
>>> Have you looked at irq_domains (kernel/irq/irqdomain.c)? That is what
>>> you should be using for your (gpio) interrupt controller and then use
>>> the common irq_create_of_mapping.
>>>
>>
>> Unfortunatly, although a good idea, kernel/irq/irqdomain.c makes a bunch
>> of assumptions that don't hold for Octeon.  We may be able to improve it
>> so that it flexible enough to suit us.
>>
>>
>> Here are the problems I see:
>>
>> 1) It is assumed that there is some sort of linear correspondence
>> between 'hwirq' and 'irq', and that the range of valid values is
>> contiguous.
>
> That's not true if you implement .to_irq for your domain.

It is true.  irq_domain_add() iterates.

>
>> 2) It is assumed that the concepts of nr_irq, irq_base and hwirq_base
>> have easy to determin values and you can do iteration over their ranges
>> by adding indexes to the bases.
>
> That's true for hwirq numbering, but not for Linux irq numbering.
> irq_base is only used if you don't provide .to_irq. hwirq_base is just
> to allow a linear range that doesn't start with 0.
>
>> I think we can fix this by adding iteration helper functions to struct
>> irq_domain.  If these are present, we would just ignore the irq_base,
>> nr_irq and hwirq_base elements of the structure.
>> irq_domain_for_each_hwirq() and irq_domain_for_each_irq() would be
>> modified to use the iteration helper functions.
>
> Expanding irqdomain is certainly the intention and right direction.

I have a patch.  It should be ready in a couple of hours.

>
> It seems to me you just need something different than an irq. controller
> with a linear range of irq lines. Perhaps sparsely allocated hwirq's?
> Can you describe the h/w?
>
> Also, you could have a different domain per irqdesc if you really needed to.
>

Too ugly.

David Daney
