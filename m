Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 20:50:06 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:58805 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903561Ab1KKTt7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Nov 2011 20:49:59 +0100
Received: by iapp10 with SMTP id p10so5623168iap.36
        for <multiple recipients>; Fri, 11 Nov 2011 11:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=DNN3v6DRO+EYFL6+40PSHQSH+uw0/0TC5EdCoO7KJzA=;
        b=JNbYkR23PwnkIkzf9eyTITdmYXDsYiq/4UvbjCEaBb/+8FBbRmp3ySZ1vQwliFhGsN
         2eWzc+JvEUXcdnNhPpwIebVrkAhlOccJFJlkTMztjLc73lrYp5qZme42sQLKpnZG8vuM
         bwVLcXkJmFyiZFnc/rH6XQsdqsTM8gdkNLdww=
Received: by 10.42.148.136 with SMTP id r8mr13776670icv.1.1321040992891;
        Fri, 11 Nov 2011 11:49:52 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id bu33sm17246010ibb.11.2011.11.11.11.49.50
        (version=SSLv3 cipher=OTHER);
        Fri, 11 Nov 2011 11:49:51 -0800 (PST)
Message-ID: <4EBD7C5D.7080606@gmail.com>
Date:   Fri, 11 Nov 2011 11:49:49 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Rob Herring <robherring2@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 3/8] MIPS: Octeon: Add irq_create_of_mapping() and GPIO
 interrupts.
References: <1320978124-13042-1-git-send-email-ddaney.cavm@gmail.com> <1320978124-13042-4-git-send-email-ddaney.cavm@gmail.com> <4EBD4868.7040809@gmail.com>
In-Reply-To: <4EBD4868.7040809@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10592

On 11/11/2011 08:08 AM, Rob Herring wrote:
> On 11/10/2011 08:21 PM, ddaney.cavm@gmail.com wrote:
>> From: David Daney<david.daney@cavium.com>
>>
>> This is needed for Octeon to use the Device Tree.
>>
>> The GPIO interrupts are configured based on Device Tree properties
>>
>> Signed-off-by: David Daney<david.daney@cavium.com>
>> ---
>>   arch/mips/cavium-octeon/octeon-irq.c |  188 +++++++++++++++++++++++++++++++++-
>>   1 files changed, 187 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
>> index ffd4ae6..bb10546 100644
>> --- a/arch/mips/cavium-octeon/octeon-irq.c
>> +++ b/arch/mips/cavium-octeon/octeon-irq.c
>> @@ -8,11 +8,14 @@
>>
>>   #include<linux/interrupt.h>
>>   #include<linux/bitops.h>
>> +#include<linux/module.h>
>>   #include<linux/percpu.h>
>> +#include<linux/of_irq.h>
>>   #include<linux/irq.h>
>>   #include<linux/smp.h>
>>
>>   #include<asm/octeon/octeon.h>
>> +#include<asm/octeon/cvmx-gpio-defs.h>
>>
>>   static DEFINE_RAW_SPINLOCK(octeon_irq_ciu0_lock);
>>   static DEFINE_RAW_SPINLOCK(octeon_irq_ciu1_lock);
>> @@ -58,6 +61,95 @@ static void __init octeon_irq_set_ciu_mapping(int irq, int line, int bit,
>>   	octeon_irq_ciu_to_irq[line][bit] = irq;
>>   }
>>
>> +static unsigned int octeon_irq_gpio_mapping(struct device_node *controller,
>> +					    const u32 *intspec,
>> +					    unsigned int intsize)
>> +{
>> +	struct of_irq oirq;
>> +	int i;
>> +	unsigned int irq = 0;
>> +	unsigned int type;
>> +	unsigned int ciu = 0, bit = 0;
>> +	unsigned int pin = be32_to_cpup(intspec);
>> +	unsigned int trigger = be32_to_cpup(intspec + 1);
>> +	bool set_edge_handler = false;
>> +
>> +	if (pin>= 16)
>> +		goto err;
>> +	i = of_irq_map_one(controller, 0,&oirq);
>> +	if (i)
>> +		goto err;
>> +	if (oirq.size != 2)
>> +		goto err_put;
>> +
>> +	ciu = oirq.specifier[0];
>> +	bit = oirq.specifier[1] + pin;
>> +
>> +	if (ciu>= 8 || bit>= 64)
>> +		goto err_put;
>> +
>> +	irq = octeon_irq_ciu_to_irq[ciu][bit];
>> +	if (!irq)
>> +		goto err_put;
>> +
>> +	switch (trigger&  0xf) {
>> +	case 1:
>> +		type = IRQ_TYPE_EDGE_RISING;
>> +		set_edge_handler = true;
>> +		break;
>> +	case 2:
>> +		type = IRQ_TYPE_EDGE_FALLING;
>> +		set_edge_handler = true;
>> +		break;
>> +	case 4:
>> +		type = IRQ_TYPE_LEVEL_HIGH;
>> +		break;
>> +	case 8:
>> +		type = IRQ_TYPE_LEVEL_LOW;
>> +		break;
>> +	default:
>> +		pr_err("Error: Invalid irq trigger specification: %x\n",
>> +		       trigger);
>> +		type = IRQ_TYPE_LEVEL_LOW;
>> +		break;
>> +	}
>> +
>> +	irq_set_irq_type(irq, type);
>> +
>> +	if (set_edge_handler)
>> +		__irq_set_handler(irq, handle_edge_irq, 0, NULL);
>> +
>> +err_put:
>> +	of_node_put(oirq.controller);
>> +err:
>> +	return irq;
>> +}
>> +
>> +/*
>> + * irq_create_of_mapping - Hook to resolve OF irq specifier into a Linux irq#
>> + *
>> + * Octeon irq maps are a pair of indexes.  The first selects either
>> + * ciu0 or ciu1, the second is the bit within the ciu register.
>> + */
>> +unsigned int irq_create_of_mapping(struct device_node *controller,
>> +				   const u32 *intspec, unsigned int intsize)
>> +{
>> +	unsigned int irq = 0;
>> +	unsigned int ciu, bit;
>> +
>> +	if (of_device_is_compatible(controller, "cavium,octeon-3860-gpio"))
>> +		return octeon_irq_gpio_mapping(controller, intspec, intsize);
>> +
>> +	ciu = be32_to_cpup(intspec);
>> +	bit = be32_to_cpup(intspec + 1);
>> +
>> +	if (ciu<  8&&  bit<  64)
>> +		irq = octeon_irq_ciu_to_irq[ciu][bit];
>> +
>> +	return irq;
>> +}
>> +EXPORT_SYMBOL_GPL(irq_create_of_mapping);
>
> Have you looked at irq_domains (kernel/irq/irqdomain.c)? That is what
> you should be using for your (gpio) interrupt controller and then use
> the common irq_create_of_mapping.
>

Unfortunatly, although a good idea, kernel/irq/irqdomain.c makes a bunch 
of assumptions that don't hold for Octeon.  We may be able to improve it 
so that it flexible enough to suit us.


Here are the problems I see:

1) It is assumed that there is some sort of linear correspondence 
between 'hwirq' and 'irq', and that the range of valid values is contiguous.

2) It is assumed that the concepts of nr_irq, irq_base and hwirq_base 
have easy to determin values and you can do iteration over their ranges 
by adding indexes to the bases.

I think we can fix this by adding iteration helper functions to struct 
irq_domain.  If these are present, we would just ignore the irq_base, 
nr_irq and hwirq_base elements of the structure. 
irq_domain_for_each_hwirq() and irq_domain_for_each_irq() would be 
modified to use the iteration helper functions.

David Daney
