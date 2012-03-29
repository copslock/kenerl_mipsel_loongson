Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2012 03:41:12 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3601 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903690Ab2C2BlG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Mar 2012 03:41:06 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4f73be1b0000>; Wed, 28 Mar 2012 18:42:51 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 28 Mar 2012 18:40:42 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 28 Mar 2012 18:40:42 -0700
Message-ID: <4F73BDAF.7020206@cavium.com>
Date:   Wed, 28 Mar 2012 18:41:03 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Grant Likely <grant.likely@secretlab.ca>
CC:     Rob Herring <robherring2@gmail.com>,
        David Daney <ddaney.cavm@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        Rob Herring <rob.herring@calxeda.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/4] MIPS: Octeon: Setup irq_domains for interrupts.
References: <1332790281-9648-1-git-send-email-ddaney.cavm@gmail.com> <1332790281-9648-3-git-send-email-ddaney.cavm@gmail.com> <4F711E69.1080302@gmail.com> <4F7205F3.3000108@cavium.com> <20120328222246.8AFA83E0CFE@localhost>
In-Reply-To: <20120328222246.8AFA83E0CFE@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Mar 2012 01:40:42.0040 (UTC) FILETIME=[F3ABA380:01CD0D4C]
X-archive-position: 32813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/28/2012 03:22 PM, Grant Likely wrote:
> On Tue, 27 Mar 2012 11:24:51 -0700, David Daney<david.daney@cavium.com>  wrote:
>> On 03/26/2012 06:56 PM, Rob Herring wrote:
>>> On 03/26/2012 02:31 PM, David Daney wrote:
>>>> From: David Daney<david.daney@cavium.com>
>> [...]
>>>> +static int octeon_irq_ciu_map(struct irq_domain *d,
>>>> +			      unsigned int virq, irq_hw_number_t hw)
>>>> +{
>>>> +	unsigned int line = hw>>   6;
>>>> +	unsigned int bit = hw&   63;
>>>> +
>>>> +	if (virq>= 256)
>>>> +		return -EINVAL;
>>>
>>> Drop this. You should not care what the virq numbers are.
>>
>>
>> I care that they don't overflow the width of octeon_irq_ciu_to_irq (a u8).
>>
>> So really I want to say:
>>
>>      if (virq>= (1<<  sizeof (octeon_irq_ciu_to_irq[0][0]))) {
>>          WARN(...);
>>          return -EINVAL;
>>      }
>>
>>
>> I need a map external to any one irq_domain.  The irq handling code
>> handles sources that come from two separate irq_domains, as well as irqs
>> that are not part of any domain.
>
> You can get past this limitation by using the struct irq_data .hwirq and
> .domain members for the irq ==>  hwirq translation, and for hwirq ==>
> irq the code should already have the context to know which user it is.
>
> For the irqs that are not covered by an irq_domain, the driver is free
> to set the .hwirq value directly.  Ultimately however, it will
> probably be best to add an irq domain for those users also.
>
> ...
>
> Howver, I don't understand where the risk is in overflowing
> octeon_irq_ciu_to_irq[][].  From what I can see, the virq value isn't
> used at all to calculate the array dereference.  line and bit are
> calculated from the hwirq value.  What am I missing?
>

We do the opposite.  We extract the hwirq value from the interrupt 
controller and then look up virq in the table.  If the range of virq 
overflows the width of u8, we would end up calling do_IRQ() with a bad 
value.  Also this dispatch code is not aware of the various irq_domains 
and non irq_domain irqs, it is a single function that handles them all 
calling do_IRQ() with whatever it looks up in the table.

We could use a wider type for this lookup array, but that would increase 
the cache footprint of the irq dispatcher...


David Daney

David Daney

> g.
>
