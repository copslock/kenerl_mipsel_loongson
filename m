Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Mar 2012 20:36:01 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:32778 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903626Ab2CCTfn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Mar 2012 20:35:43 +0100
Received: by yhjj52 with SMTP id j52so1330241yhj.36
        for <multiple recipients>; Sat, 03 Mar 2012 11:35:37 -0800 (PST)
Received-SPF: pass (google.com: domain of robherring2@gmail.com designates 10.101.190.10 as permitted sender) client-ip=10.101.190.10;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of robherring2@gmail.com designates 10.101.190.10 as permitted sender) smtp.mail=robherring2@gmail.com; dkim=pass header.i=robherring2@gmail.com
Received: from mr.google.com ([10.101.190.10])
        by 10.101.190.10 with SMTP id s10mr6052645anp.75.1330803337007 (num_hops = 1);
        Sat, 03 Mar 2012 11:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=dRbGCB1NcdLoq34QaKa5F8r/syyjpDlttvpLxgI4mtQ=;
        b=RvyelmpPiEtML2yWa7oNbMYM4EtyHJsJmpO5IJa9P5g+49NaSvdtG2NjiqJrOArfUu
         POdoZ5f1e1zDDxP0aBZGamJmvmocSP1dda0hkRTn1a0VuuC2/iZ1RgWzB+o0P9IvTT+O
         RNIQ53jkLNA0SP+hzSyeF7nmYi+H8zcOzjf/3CVGuCYezNIBiFYC4CJmBGvG9xeQAoSv
         pXLlVnY0xNOaqs9Y2EDb9BmFDXxNUM3KGb8WKPj3h7pOxS3xTLWEKxG8HaBctDhKd8lC
         UJQMCCbnK1ghCHQTnidTr8x1gu+vONJ8yaPJ22T0Mwza61RpIT72l20dJ6WA1h2q2KKB
         yB0Q==
Received: by 10.101.190.10 with SMTP id s10mr4807987anp.75.1330803336943;
        Sat, 03 Mar 2012 11:35:36 -0800 (PST)
Received: from [192.168.1.103] (65-36-72-55.dyn.grandenetworks.net. [65.36.72.55])
        by mx.google.com with ESMTPS id r7sm4696444yhm.9.2012.03.03.11.35.34
        (version=SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 11:35:35 -0800 (PST)
Message-ID: <4F527285.1020500@gmail.com>
Date:   Sat, 03 Mar 2012 13:35:33 -0600
From:   Rob Herring <robherring2@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     David Daney <david.daney@cavium.com>
CC:     Grant Likely <grant.likely@secretlab.ca>,
        David Daney <ddaney.cavm@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        Rob Herring <rob.herring@calxeda.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 4/5] MIPS: Octeon: Setup irq_domains for interrupts.
References: <1330563422-14078-1-git-send-email-ddaney.cavm@gmail.com> <1330563422-14078-5-git-send-email-ddaney.cavm@gmail.com> <4F50D7C2.7080204@gmail.com> <4F510B8E.3070201@cavium.com> <20120302190744.571E03E1C63@localhost> <4F511FB0.5070901@cavium.com>
In-Reply-To: <4F511FB0.5070901@cavium.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/02/2012 01:29 PM, David Daney wrote:
> On 03/02/2012 11:07 AM, Grant Likely wrote:
>> On Fri, 02 Mar 2012 10:03:58 -0800, David
>> Daney<david.daney@cavium.com>  wrote:
>>> On 03/02/2012 06:22 AM, Rob Herring wrote:
>>> [...]
>>>>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>>>>> index ce30e2f..01344ae 100644
>>>>> --- a/arch/mips/Kconfig
>>>>> +++ b/arch/mips/Kconfig
>>>>> @@ -1432,6 +1432,7 @@ config CPU_CAVIUM_OCTEON
>>>>>        select WEAK_ORDERING
>>>>>        select CPU_SUPPORTS_HIGHMEM
>>>>>        select CPU_SUPPORTS_HUGEPAGES
>>>>> +    select IRQ_DOMAIN
>>>>
>>>> IIRC, Grant has a patch cued up that enables IRQ_DOMAIN for all of
>>>> MIPS.
>>>>
>>>
>>> Indeed, I now see it in linux-next.  I will remove this one.
>>>
>>>>>        help
>>>>>          The Cavium Octeon processor is a highly integrated chip
>>>>> containing
>>>>>          many ethernet hardware widgets for networking tasks. The
>>>>> processor
>>>>> diff --git a/arch/mips/cavium-octeon/octeon-irq.c
>>>>> b/arch/mips/cavium-octeon/octeon-irq.c
>>>>> index bdcedd3..e9f2f6c 100644
>>>>> --- a/arch/mips/cavium-octeon/octeon-irq.c
>>>>> +++ b/arch/mips/cavium-octeon/octeon-irq.c
>>> [...]
>>>>> +static void __init octeon_irq_set_ciu_mapping(unsigned int irq,
>>>>> +                          unsigned int line,
>>>>> +                          unsigned int bit,
>>>>> +                          struct irq_domain *domain,
>>>>>                              struct irq_chip *chip,
>>>>>                              irq_flow_handler_t handler)
>>>>>    {
>>>>> +    struct irq_data *irqd;
>>>>>        union octeon_ciu_chip_data cd;
>>>>>
>>>>>        irq_set_chip_and_handler(irq, chip, handler);
>>>>> -
>>>>>        cd.l = 0;
>>>>>        cd.s.line = line;
>>>>>        cd.s.bit = bit;
>>>>>
>>>>>        irq_set_chip_data(irq, cd.p);
>>>>>        octeon_irq_ciu_to_irq[line][bit] = irq;
>>>>> +
>>>>> +    irqd = irq_get_irq_data(irq);
>>>>> +    irqd->hwirq = line<<   6 | bit;
>>>>> +    irqd->domain = domain;
>>>>
>>>> I think the domain code will set these.
>>>
>>> It is my understanding that the domain code only does this for:
>>>
>>> o irq_domain_add_legacy()
>>>
>>> o irq_create_direct_mapping()
>>>
>>> o irq_create_mapping()
>>>
>>> We use none of those.  So I do it here.
>>>
>>> If there is a better way, I am open to suggestions.
>>
>> irq_create_mapping is called by irq_create_of_mapping() which is
>> in turn called by irq_of_parse_and-map().  irq_domain always
>> manages the hwirq and domain values.  Driver code cannot manipulate
>> them manually.
>>
> 
> I really must be missing something.
> 
> Given:
> 
> 1) I must have a mapping between hwirq and irq that I control so that
> non-OF code using the OCTEON_IRQ_* constants continues to work.

Those defines are what you need to work to get rid of.

> 2) irq_create_mapping() will allocate a random irq value if none is
> already assigned to the hwirq.
> 
> Therefore: To avoid having random irq values assigned, I must manually
> assign them.
> 

So you should be using legacy domain if you need to maintain fixed hwirq
to linux irq numbers. "linear" is a bit confusing as it doesn't mean
linear 1:1 irq number assignment, but linear search.

Ultimately, for DT boot you should use of_irq_init to scan the dts, and
then create a linear domain for each interrupt controller node. You may
need to decide on linear vs. legacy at runtime based on having a DT node
pointer or not.

Rob
