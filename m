Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2012 00:05:48 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:53077 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903679Ab2C0WFe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2012 00:05:34 +0200
Received: by obbup16 with SMTP id up16so508672obb.36
        for <multiple recipients>; Tue, 27 Mar 2012 15:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=9xxAwDbUWaspmyFctxNQaSUAvlo1GpKai16r32vP8hU=;
        b=mY5S5vhQYAcN0zmhf04r8DKnzeJOUBUlhCDQyqytTW/9+KV8gwz90kxD9Ae1P5CVsW
         oPyuXx8LVY13pq+aRcGxKIGylpVNyLGsb42EZf8fzgdLBAugBC3dvTLxSRycZoDbL//6
         e45Q+xq9ffbuaO+wvfOJZLIzZlM+LJkl0AfrpLqTJ98kAHLHDtklGV8gbCopoI30YEai
         /b0J3Hym+3XcyFB3jBpurKZjeGBd68nL67rd6IIX/Fa7xzuxw9zlQqoWxAKuoB+QT6ek
         Su+yxDcY2H5xd95aLWIRTjhTTsK1PMjmSD1sl5BNiXhyCzRGg9RQu9KUS6CUDuBlTEfc
         EQUA==
Received: by 10.182.134.97 with SMTP id pj1mr34943747obb.2.1332885927575;
        Tue, 27 Mar 2012 15:05:27 -0700 (PDT)
Received: from [10.10.10.90] ([173.226.190.126])
        by mx.google.com with ESMTPS id b2sm1122019obo.22.2012.03.27.15.05.25
        (version=SSLv3 cipher=OTHER);
        Tue, 27 Mar 2012 15:05:26 -0700 (PDT)
Message-ID: <4F7239A4.7070905@gmail.com>
Date:   Tue, 27 Mar 2012 17:05:24 -0500
From:   Rob Herring <robherring2@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120310 Thunderbird/11.0
MIME-Version: 1.0
To:     David Daney <david.daney@cavium.com>
CC:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/4] MIPS: Octeon: Setup irq_domains for interrupts.
References: <1332790281-9648-1-git-send-email-ddaney.cavm@gmail.com> <1332790281-9648-3-git-send-email-ddaney.cavm@gmail.com> <4F711E69.1080302@gmail.com> <4F7205F3.3000108@cavium.com>
In-Reply-To: <4F7205F3.3000108@cavium.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/27/2012 01:24 PM, David Daney wrote:
> On 03/26/2012 06:56 PM, Rob Herring wrote:
>> On 03/26/2012 02:31 PM, David Daney wrote:
>>> From: David Daney<david.daney@cavium.com>
> [...]
>>> +static bool octeon_irq_ciu_is_edge(unsigned int line, unsigned int bit)
>>> +{
>>> +    bool edge = false;
>>> +
>>> +    if (line == 0)
>>> +        switch (bit) {
>>> +        case 48 ... 49: /* GMX DRP */
>>> +        case 50: /* IPD_DRP */
>>> +        case 52 ... 55: /* Timers */
>>> +        case 58: /* MPI */
>>> +            edge = true;
>>> +            break;
>>> +        default:
>>> +            break;
>>> +        }
>>> +    else /* line == 1 */
>>> +        switch (bit) {
>>> +        case 47: /* PTP */
>>> +            edge = true;
>>> +            break;
>>> +        default:
>>> +            break;
>>> +        }
>>> +    return edge;
>>
>> Moving in the right direction, but I still don't get why this is not in
>> the CIU binding as a 3rd cell?
> 
> There are a several reasons, in no particular order they are:
> 
> o There is no 3rd cell.  The bindings were discussed with Grant here:
>   http://www.linux-mips.org/archives/linux-mips/2011-05/msg00355.html
> 

Then add one.

> o The edge/level thing cannot be changed, and the irq lines don't leave
> the SOC, so hard coding it is possible.

Right, but DT describes h/w connections and this is an aspect of the
connection. This may be fixed for the SOC, but it's not fixed for the
CIU (i.e. could change in future chips), right?

There's 2 reasons why you would not put this into DTS:

- All irq lines' trigger type are the same, fixed and known.
- You can read a register to tell you the trigger type.

Even if it's not going to change ever, it's still worth putting into the
DTS as it is well suited for holding that data and it is just data.

> 
>>
>>> +}
>>> +
>>> +struct octeon_irq_gpio_domain_data {
>>> +    unsigned int base_hwirq;
>>> +};
>>> +
>>> +static int octeon_irq_gpio_xlat(struct irq_domain *d,
>>> +                struct device_node *node,
>>> +                const u32 *intspec,
>>> +                unsigned int intsize,
>>> +                unsigned long *out_hwirq,
>>> +                unsigned int *out_type)
>>> +{
>>> +    unsigned int type;
>>> +    unsigned int pin;
>>> +    unsigned int trigger;
>>> +    bool set_edge_handler = false;
>>> +    struct octeon_irq_gpio_domain_data *gpiod;
>>> +
>>> +    if (d->of_node != node)
>>> +        return -EINVAL;
>>> +
>>> +    if (intsize<  2)
>>> +        return -EINVAL;
>>> +
>>> +    pin = intspec[0];
>>> +    if (pin>= 16)
>>> +        return -EINVAL;
>>> +
>>> +    trigger = intspec[1];
>>> +
>>> +    switch (trigger) {
>>> +    case 1:
>>> +        type = IRQ_TYPE_EDGE_RISING;
>>> +        set_edge_handler = true;
>>
>> This is never used.
> 
> Right, it was leftover from the previous version.
> 
>>
>>> +        break;
>>> +    case 2:
>>> +        type = IRQ_TYPE_EDGE_FALLING;
>>> +        set_edge_handler = true;
>>> +        break;
>>> +    case 4:
>>> +        type = IRQ_TYPE_LEVEL_HIGH;
>>> +        break;
>>> +    case 8:
>>> +        type = IRQ_TYPE_LEVEL_LOW;
>>> +        break;
>>> +    default:
>>> +        pr_err("Error: (%s) Invalid irq trigger specification: %x\n",
>>> +               node->name,
>>> +               trigger);
>>> +        type = IRQ_TYPE_LEVEL_LOW;
>>> +        break;
>>> +    }
>>> +    *out_type = type;
>>
>> Can't you get rid of the whole switch statement and just do:
>>
>> *out_type = intspec[1];
> 
> That wouldn't catch erroneous values like 6.
> 

if (!x || fls(x) != ffs(x))
	// ERROR


>>
> [...]
>>> +static int octeon_irq_ciu_map(struct irq_domain *d,
>>> +                  unsigned int virq, irq_hw_number_t hw)
>>> +{
>>> +    unsigned int line = hw>>  6;
>>> +    unsigned int bit = hw&  63;
>>> +
>>> +    if (virq>= 256)
>>> +        return -EINVAL;
>>
>> Drop this. You should not care what the virq numbers are.
> 
> 
> I care that they don't overflow the width of octeon_irq_ciu_to_irq (a u8).
> 
> So really I want to say:
> 
>    if (virq >= (1 << sizeof (octeon_irq_ciu_to_irq[0][0]))) {
>        WARN(...);
>        return -EINVAL;
>    }
> 
> 
> I need a map external to any one irq_domain.  The irq handling code
> handles sources that come from two separate irq_domains, as well as irqs
> that are not part of any domain.
> 

Okay, but ultimately this needs to go. The irqdomain provides no
guarantee of irq numbers assigned.

Rob
