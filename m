Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Mar 2012 06:41:44 +0100 (CET)
Received: from mail-pz0-f48.google.com ([209.85.210.48]:52112 "EHLO
        mail-pz0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903560Ab2CDFlZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 4 Mar 2012 06:41:25 +0100
Received: by dadp13 with SMTP id p13so3139769dad.35
        for <multiple recipients>; Sat, 03 Mar 2012 21:41:18 -0800 (PST)
Received-SPF: pass (google.com: domain of david.s.daney@gmail.com designates 10.68.201.135 as permitted sender) client-ip=10.68.201.135;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of david.s.daney@gmail.com designates 10.68.201.135 as permitted sender) smtp.mail=david.s.daney@gmail.com; dkim=pass header.i=david.s.daney@gmail.com
Received: from mr.google.com ([10.68.201.135])
        by 10.68.201.135 with SMTP id ka7mr34236018pbc.145.1330839678739 (num_hops = 1);
        Sat, 03 Mar 2012 21:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=S47M9lTqW+jvLz/MwzOCvcmPKQ/biFHDD6cr7d4jVFw=;
        b=JC/dpqmudkOGESEoDY2CmTks2YmL3ZA46NBo05+OhBSxt8OL0vqWIkRAQcS2nzdBTL
         /MGOc8L/wZ3G8EEtdMBwDzl0yVZelWLKxVqmak+by5D6qewZwHzxXVVvoDTB7J95obA6
         /jdV/9W8Pdnr8lbMFG8wVS4D8dx2KqH6hnfTiGUyKYBmwf5/pE257q8SZLF+Kaxchn8x
         qvHfgIl//JimK+ZgdEVe490wd2oQC1buTLwuw6gy6NjSZVGx6rUIJcmB8ihTwTRopZHV
         Scx0WurZbm57kqqZpSp+X5WYV3PSBbARiuNWHqnw5j/isQbv90cqvvimyEGeyBUdg4kR
         ytKg==
Received: by 10.68.201.135 with SMTP id ka7mr29053266pbc.145.1330839678666;
        Sat, 03 Mar 2012 21:41:18 -0800 (PST)
Received: from dd_xps.caveonetworks.com (adsl-67-127-190-10.dsl.pltn13.pacbell.net. [67.127.190.10])
        by mx.google.com with ESMTPS id q10sm9633983pbb.10.2012.03.03.21.41.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 21:41:18 -0800 (PST)
Message-ID: <4F53007C.2030106@gmail.com>
Date:   Sat, 03 Mar 2012 21:41:16 -0800
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To:     Rob Herring <robherring2@gmail.com>
CC:     David Daney <david.daney@cavium.com>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/5] MIPS: Octeon: Setup irq_domains for interrupts.
References: <1330563422-14078-1-git-send-email-ddaney.cavm@gmail.com> <1330563422-14078-5-git-send-email-ddaney.cavm@gmail.com> <4F50D7C2.7080204@gmail.com> <4F510B8E.3070201@cavium.com> <4F52733F.4030807@gmail.com>
In-Reply-To: <4F52733F.4030807@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/03/2012 11:38 AM, Rob Herring wrote:
> On 03/02/2012 12:03 PM, David Daney wrote:
>> +
>> +    irqd = irq_get_irq_data(irq);
>> +    irqd->hwirq = line<<   6 | bit;
>> +    irqd->domain = domain;
>>> I think the domain code will set these.
>> It is my understanding that the domain code only does this for:
>>
>> o irq_domain_add_legacy()
>>
>> o irq_create_direct_mapping()
>>
>> o irq_create_mapping()
>>
>> We use none of those.  So I do it here.
>>
>> If there is a better way, I am open to suggestions.
> How do you convert local h/w irq controller numbers in the dts to linux
> irq #'s?

With the calls to octeon_irq_set_ciu_mapping() ...

  [...]
>>>> +    octeon_irq_set_ciu_mapping(OCTEON_IRQ_PEM0, 1, 48,
>>>> +                   ciu_domain, chip, handle_level_irq);
>>>> +    octeon_irq_set_ciu_mapping(OCTEON_IRQ_PEM1, 1, 49,
>>>> +                   ciu_domain, chip, handle_level_irq);
>>>> +    octeon_irq_set_ciu_mapping(OCTEON_IRQ_SRIO0, 1, 50,
>>>> +                   ciu_domain, chip, handle_level_irq);
>>>> +    octeon_irq_set_ciu_mapping(OCTEON_IRQ_SRIO1, 1, 51,
>>>> +                   ciu_domain, chip, handle_level_irq);
>>>> +    octeon_irq_set_ciu_mapping(OCTEON_IRQ_LMC0, 1, 52,
>>>> +                   ciu_domain, chip, handle_level_irq);
>>>> +    octeon_irq_set_ciu_mapping(OCTEON_IRQ_DFM, 1, 56,
>>>> +                   ciu_domain, chip, handle_level_irq);
>>>> +    octeon_irq_set_ciu_mapping(OCTEON_IRQ_RST, 1, 63,
>>>> +                   ciu_domain, chip, handle_level_irq);
>>>>

>>>> [...]
>>> edge vs. level should be driven by dts.
>>>
>> We may have to disagree on this point.  Because:
>>
>> 1) edge vs. level can be accurately probed, as we do here.
> Looks like you are just hard coding it here. Where do you read something
> that tells you the interrupt is level or edge?

We probe for the type of interrupt controller by reading the SOC 
identifier number, although we can get the same information from the dts.

Once we know the type of interrupt controller, the level vs. edge is 
known a priori, and that knowlege is encoded in all these 
octeon_irq_set_ciu_mapping() calls.

And on top of this...

>> 2) The dts doesn't contain the information.
>>

So it is kind of a moot point.

It is not some sort of generic interrupt controller that can be 
configured in different ways, each line has certain properties endowed 
upon it by the chip designers, and once a line is assigned a particular 
configuration, it is never changed in future generations.

For external devices attached to the GPIO interrupt lines, things are 
different, we can only know the triggering via the dts, and lo and 
behold... it is there and we use it.


David Daney
