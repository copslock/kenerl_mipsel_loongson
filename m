Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Mar 2012 06:09:59 +0100 (CET)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:50049 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903560Ab2CDFJm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 4 Mar 2012 06:09:42 +0100
Received: by pbbro2 with SMTP id ro2so4621297pbb.36
        for <multiple recipients>; Sat, 03 Mar 2012 21:09:34 -0800 (PST)
Received-SPF: pass (google.com: domain of david.s.daney@gmail.com designates 10.68.196.201 as permitted sender) client-ip=10.68.196.201;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of david.s.daney@gmail.com designates 10.68.196.201 as permitted sender) smtp.mail=david.s.daney@gmail.com; dkim=pass header.i=david.s.daney@gmail.com
Received: from mr.google.com ([10.68.196.201])
        by 10.68.196.201 with SMTP id io9mr18776822pbc.86.1330837774925 (num_hops = 1);
        Sat, 03 Mar 2012 21:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=b0ZBgfZ7Cd9zLy9EM1B6lH1OmCMvscw+fml6YPtfejA=;
        b=TlLj1pV7hu7nvDE7V6AuKPV27F2IXnhvgb815g+EuSIdLTqLxf77Y0r9uky6Y0nPjW
         3PTV6kSwUHrmtug8mu12OC3bgyUR0/1+H0hywui8DKjxA70g//PgZZ7xgd/+g2iGboTF
         9PdGm57aP7r9sGS8tHs4TSRIFRSS2QFwi2VGi/dPba58rmsfEk1m5o3OTl2v4YP9k2PI
         qP2ksrGKA6/nY5GUXYjLjFAhNkZ/sb1zBkeR9cOQVP1pOypWuMJiwWKr2I+mYMfPolJZ
         pe0ynZVsYkmiR5aW5YXkVb/qn7c/QsHUPs0ukj1AlZ6K+9k3mb0deUJwyhshgo0I31my
         mabQ==
Received: by 10.68.196.201 with SMTP id io9mr16192682pbc.86.1330837774858;
        Sat, 03 Mar 2012 21:09:34 -0800 (PST)
Received: from dd_xps.caveonetworks.com (adsl-67-127-190-10.dsl.pltn13.pacbell.net. [67.127.190.10])
        by mx.google.com with ESMTPS id 3sm9537705pbx.66.2012.03.03.21.09.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 21:09:34 -0800 (PST)
Message-ID: <4F52F90C.5060306@gmail.com>
Date:   Sat, 03 Mar 2012 21:09:32 -0800
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To:     Rob Herring <robherring2@gmail.com>
CC:     David Daney <david.daney@cavium.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        David Daney <ddaney.cavm@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        Rob Herring <rob.herring@calxeda.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 4/5] MIPS: Octeon: Setup irq_domains for interrupts.
References: <1330563422-14078-1-git-send-email-ddaney.cavm@gmail.com> <1330563422-14078-5-git-send-email-ddaney.cavm@gmail.com> <4F50D7C2.7080204@gmail.com> <4F510B8E.3070201@cavium.com> <20120302190744.571E03E1C63@localhost> <4F511FB0.5070901@cavium.com> <4F527285.1020500@gmail.com>
In-Reply-To: <4F527285.1020500@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/03/2012 11:35 AM, Rob Herring wrote:
> On 03/02/2012 01:29 PM, David Daney wrote:
>> On 03/02/2012 11:07 AM, Grant Likely wrote:
>>> +static void __init octeon_irq_set_ciu_mapping(unsigned int irq,
>>> +                          unsigned int line,
>>> +                          unsigned int bit,
>>> +                          struct irq_domain *domain,
>>>                               struct irq_chip *chip,
>>>                               irq_flow_handler_t handler)
>>>     {
>>> +    struct irq_data *irqd;
>>>         union octeon_ciu_chip_data cd;
>>>
>>>         irq_set_chip_and_handler(irq, chip, handler);
>>> -
>>>         cd.l = 0;
>>>         cd.s.line = line;
>>>         cd.s.bit = bit;
>>>
>>>         irq_set_chip_data(irq, cd.p);
>>>         octeon_irq_ciu_to_irq[line][bit] = irq;
>>> +
>>> +    irqd = irq_get_irq_data(irq);
>>> +    irqd->hwirq = line<<    6 | bit;
>>> +    irqd->domain = domain;
>>>>> I think the domain code will set these.
>>>> It is my understanding that the domain code only does this for:
>>>>
>>>> o irq_domain_add_legacy()
>>>>
>>>> o irq_create_direct_mapping()
>>>>
>>>> o irq_create_mapping()
>>>>
>>>> We use none of those.  So I do it here.
>>>>
>>>> If there is a better way, I am open to suggestions.
>>> irq_create_mapping is called by irq_create_of_mapping() which is
>>> in turn called by irq_of_parse_and-map().  irq_domain always
>>> manages the hwirq and domain values.  Driver code cannot manipulate
>>> them manually.
>>>
>> I really must be missing something.
>>
>> Given:
>>
>> 1) I must have a mapping between hwirq and irq that I control so that
>> non-OF code using the OCTEON_IRQ_* constants continues to work.
> Those defines are what you need to work to get rid of.

We are not starting from a blank slate here.  There is a lot of in-tree 
code using these symbols.  We cannot make them disappear with wishful 
thinking.

The first step is a switch to irq_domains using the existing mappings.

After we do that, I have patches to transition some drivers to use the 
OF mapping via irq_domains.  After those are merged, we can work toward 
getting rid of OCTEON_IRQ_*.  But I think it must be the last step in 
the process, not the first.
>
>> 2) irq_create_mapping() will allocate a random irq value if none is
>> already assigned to the hwirq.
>>
>> Therefore: To avoid having random irq values assigned, I must manually
>> assign them.
>>
> So you should be using legacy domain if you need to maintain fixed hwirq
> to linux irq numbers. "linear" is a bit confusing as it doesn't mean
> linear 1:1 irq number assignment, but linear search.

My reading of Grant's code in linux-next directly contradicts this 
statement.  There is no code in irqdomain.c, that I can see, that allows 
me to have an arbitrary mapping of irq <--> hwirq values.


>
> Ultimately, for DT boot you should use of_irq_init to scan the dts, and
> then create a linear domain for each interrupt controller node. You may
> need to decide on linear vs. legacy at runtime based on having a DT node
> pointer or not.

Perhaps, but we need to take the first step before gradually arriving at 
some Ultimate Solution.

We will also need to handle irq controllers with 2^20 sparsely populated 
hwirq values, so linear domains will probably be out of the question there.

David Daney
