Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Mar 2012 20:39:05 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:50509 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903626Ab2CCTis (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Mar 2012 20:38:48 +0100
Received: by ghbf11 with SMTP id f11so1336246ghb.36
        for <multiple recipients>; Sat, 03 Mar 2012 11:38:42 -0800 (PST)
Received-SPF: pass (google.com: domain of robherring2@gmail.com designates 10.236.138.110 as permitted sender) client-ip=10.236.138.110;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of robherring2@gmail.com designates 10.236.138.110 as permitted sender) smtp.mail=robherring2@gmail.com; dkim=pass header.i=robherring2@gmail.com
Received: from mr.google.com ([10.236.138.110])
        by 10.236.138.110 with SMTP id z74mr19583983yhi.114.1330803522000 (num_hops = 1);
        Sat, 03 Mar 2012 11:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=67dJ4scwfsu6oIP2mhnG3bPd5KUxXZD928kVdvrBvE0=;
        b=Zdk4ZSKqDn0oQKEYgabZC/4YSfwcDzYxnt0orGLioazc4XIxN5XHU8+doAbIiYVQ90
         kCqlbyaPhHOSqDHuyCcAvV1eHWFZAtGF628zECPKWaUdZyyfWnbhxCmmaxU9tffWBaSr
         DDtIdHoB6UwqpbxQtTeWvpVW9Xwx28A5hIJ2PLMoQHoRsjhRfIjj18+gH+dnNsddXOVX
         a6clsjGuc+4UU9TMguk/FzyEUDIhTcbecZHuSvpLZ2IkC5+3RkxXyt73bvjiM9bf3T7D
         1qC8gK/9jtnZiHKEX/WFqk4QPgYGwq7MHSiRTvnw0n0stmT40j9n1mDp5UD9oJA3WlvN
         MCUQ==
Received: by 10.236.138.110 with SMTP id z74mr15549220yhi.114.1330803521954;
        Sat, 03 Mar 2012 11:38:41 -0800 (PST)
Received: from [192.168.1.103] (65-36-72-55.dyn.grandenetworks.net. [65.36.72.55])
        by mx.google.com with ESMTPS id n24sm24948368yhj.13.2012.03.03.11.38.40
        (version=SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 11:38:41 -0800 (PST)
Message-ID: <4F52733F.4030807@gmail.com>
Date:   Sat, 03 Mar 2012 13:38:39 -0600
From:   Rob Herring <robherring2@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     David Daney <david.daney@cavium.com>
CC:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/5] MIPS: Octeon: Setup irq_domains for interrupts.
References: <1330563422-14078-1-git-send-email-ddaney.cavm@gmail.com> <1330563422-14078-5-git-send-email-ddaney.cavm@gmail.com> <4F50D7C2.7080204@gmail.com> <4F510B8E.3070201@cavium.com>
In-Reply-To: <4F510B8E.3070201@cavium.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/02/2012 12:03 PM, David Daney wrote:
> On 03/02/2012 06:22 AM, Rob Herring wrote:
> [...]
>>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>>> index ce30e2f..01344ae 100644
>>> --- a/arch/mips/Kconfig
>>> +++ b/arch/mips/Kconfig
>>> @@ -1432,6 +1432,7 @@ config CPU_CAVIUM_OCTEON
>>>       select WEAK_ORDERING
>>>       select CPU_SUPPORTS_HIGHMEM
>>>       select CPU_SUPPORTS_HUGEPAGES
>>> +    select IRQ_DOMAIN
>>
>> IIRC, Grant has a patch cued up that enables IRQ_DOMAIN for all of MIPS.
>>
> 
> Indeed, I now see it in linux-next.  I will remove this one.
> 
>>>       help
>>>         The Cavium Octeon processor is a highly integrated chip
>>> containing
>>>         many ethernet hardware widgets for networking tasks. The
>>> processor
>>> diff --git a/arch/mips/cavium-octeon/octeon-irq.c
>>> b/arch/mips/cavium-octeon/octeon-irq.c
>>> index bdcedd3..e9f2f6c 100644
>>> --- a/arch/mips/cavium-octeon/octeon-irq.c
>>> +++ b/arch/mips/cavium-octeon/octeon-irq.c
> [...]
>>> +static void __init octeon_irq_set_ciu_mapping(unsigned int irq,
>>> +                          unsigned int line,
>>> +                          unsigned int bit,
>>> +                          struct irq_domain *domain,
>>>                             struct irq_chip *chip,
>>>                             irq_flow_handler_t handler)
>>>   {
>>> +    struct irq_data *irqd;
>>>       union octeon_ciu_chip_data cd;
>>>
>>>       irq_set_chip_and_handler(irq, chip, handler);
>>> -
>>>       cd.l = 0;
>>>       cd.s.line = line;
>>>       cd.s.bit = bit;
>>>
>>>       irq_set_chip_data(irq, cd.p);
>>>       octeon_irq_ciu_to_irq[line][bit] = irq;
>>> +
>>> +    irqd = irq_get_irq_data(irq);
>>> +    irqd->hwirq = line<<  6 | bit;
>>> +    irqd->domain = domain;
>>
>> I think the domain code will set these.
> 
> It is my understanding that the domain code only does this for:
> 
> o irq_domain_add_legacy()
> 
> o irq_create_direct_mapping()
> 
> o irq_create_mapping()
> 
> We use none of those.  So I do it here.
> 
> If there is a better way, I am open to suggestions.

How do you convert local h/w irq controller numbers in the dts to linux
irq #'s?

> 
> [...]
>>> @@ -982,6 +1092,10 @@ static void __init octeon_irq_init_ciu(void)
>>>       struct irq_chip *chip_mbox;
>>>       struct irq_chip *chip_wd;
>>>       struct irq_chip *chip_gpio;
>>> +    struct device_node *gpio_node;
>>> +    struct device_node *ciu_node;
>>> +    struct irq_domain *gpio_domain;
>>> +    struct irq_domain *ciu_domain;
>>>
>>>       octeon_irq_init_ciu_percpu();
>>>       octeon_irq_setup_secondary = octeon_irq_setup_secondary_ciu;
>>> @@ -1011,83 +1125,144 @@ static void __init octeon_irq_init_ciu(void)
>>>       /* Mips internal */
>>>       octeon_irq_init_core();
>>>
>>> +    gpio_node = of_find_compatible_node(NULL, NULL,
>>> "cavium,octeon-3860-gpio");
>>> +    ciu_node = of_find_compatible_node(NULL, NULL,
>>> "cavium,octeon-3860-ciu");
>>> +    /* gpio domain host_data is the base hwirq number. */
>>> +    gpio_domain = irq_domain_add_linear(gpio_node,
>>> 16,&octeon_irq_domain_gpio_ops, (void *)16);
>>
>> It would be better to define a struct here rather than casting a data
>> value to a ptr.
> 
> You mean allocate storage for the data somewhere and then pass a pointer
> to it?
> 
> If so, I could, but it would just be adding code and data size just to
> satisfy some coding style thing...
> 
> Or do you want a union of the pointer and my int?  That would use the
> same amount of storage, but add more source code to gain what?

The former. It's better style, less error prone and easily expanded if
more data is needed in the future.

> 
> [...]
>>> +    octeon_irq_set_ciu_mapping(OCTEON_IRQ_PEM0, 1, 48,
>>> +                   ciu_domain, chip, handle_level_irq);
>>> +    octeon_irq_set_ciu_mapping(OCTEON_IRQ_PEM1, 1, 49,
>>> +                   ciu_domain, chip, handle_level_irq);
>>> +    octeon_irq_set_ciu_mapping(OCTEON_IRQ_SRIO0, 1, 50,
>>> +                   ciu_domain, chip, handle_level_irq);
>>> +    octeon_irq_set_ciu_mapping(OCTEON_IRQ_SRIO1, 1, 51,
>>> +                   ciu_domain, chip, handle_level_irq);
>>> +    octeon_irq_set_ciu_mapping(OCTEON_IRQ_LMC0, 1, 52,
>>> +                   ciu_domain, chip, handle_level_irq);
>>> +    octeon_irq_set_ciu_mapping(OCTEON_IRQ_DFM, 1, 56,
>>> +                   ciu_domain, chip, handle_level_irq);
>>> +    octeon_irq_set_ciu_mapping(OCTEON_IRQ_RST, 1, 63,
>>> +                   ciu_domain, chip, handle_level_irq);
>>>
>>
>> Can all these calls be moved into the .map function somehow?
>>
> 
> No, the non-OF code using the OCTEON_IRQ_* symbols doesn't use
> irq_domain, so the .map function would never be used.
> 

.map is called for legacy domains during domain add.


> 
>> edge vs. level should be driven by dts.
>>
> 
> We may have to disagree on this point.  Because:
> 
> 1) edge vs. level can be accurately probed, as we do here.

Looks like you are just hard coding it here. Where do you read something
that tells you the interrupt is level or edge?

Rob

> 
> 2) The dts doesnt contain the information.
> 
> 
> David Daney
