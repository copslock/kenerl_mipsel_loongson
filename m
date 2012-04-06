Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Apr 2012 19:32:52 +0200 (CEST)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:63589 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904078Ab2DFRci (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Apr 2012 19:32:38 +0200
Received: by ggnk1 with SMTP id k1so1532941ggn.36
        for <linux-mips@linux-mips.org>; Fri, 06 Apr 2012 10:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=bsHxJioAWywJxNCFc3GPyvtLmKVEHUWWz0zEPlgVyyg=;
        b=lDODrCSWWD3uBFKolMoBnlw0myFSO2f+pQcIu5GoCcf9pvm6sjedZvKvF3tWcVMtlH
         ob8y7mBdwQRDHVLvvYVv7FH3iYihUVZqwIbTefgJZwGIMHMp8S3GVfpZKVFfkzjEJQwl
         I3tNMopz78psZmk5wQ5r5txuTuE1KDiy4NYi5aXsUpBYzUUeWaVO3dOT9HK0fVxSCB1C
         YebQNIvXQu6/3BAnOcTqJ/pxKQSrNPeLN9klmizEV6adXtEurHUYcfviZXJm8tL/ANfj
         iRWyQI9h+IxfFHdd9l2CfRUk+yyxNNhLkDLfXJtNfIfV2+06e5dMwRX/NmrVWZAaUNWU
         OFGw==
Received: by 10.60.18.198 with SMTP id y6mr10273129oed.38.1333733552668;
        Fri, 06 Apr 2012 10:32:32 -0700 (PDT)
Received: from [10.10.10.90] ([173.226.190.126])
        by mx.google.com with ESMTPS id t1sm3410071obl.5.2012.04.06.10.32.30
        (version=SSLv3 cipher=OTHER);
        Fri, 06 Apr 2012 10:32:31 -0700 (PDT)
Message-ID: <4F7F28AD.4050109@gmail.com>
Date:   Fri, 06 Apr 2012 12:32:29 -0500
From:   Rob Herring <robherring2@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Grant Likely <grant.likely@secretlab.ca>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree-discuss@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] irq/irq_domain: Quit ignoring error returns from irq_alloc_desc_from().
References: <1333669933-25267-1-git-send-email-ddaney.cavm@gmail.com> <4F7E64E4.3080509@gmail.com> <4F7F1BDD.4070205@gmail.com>
In-Reply-To: <4F7F1BDD.4070205@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/06/2012 11:37 AM, David Daney wrote:
> Rob,
> 
> What the he*%? ...
> 
> 
> On 04/05/2012 08:37 PM, Rob Herring wrote:
>> On 04/05/2012 06:52 PM, David Daney wrote:
>>> From: David Daney<david.daney@cavium.com>
>>>
>>> In commit 4bbdd45a (irq_domain/powerpc: eliminate irq_map; use
>>> irq_alloc_desc() instead) code was added that ignores error returns
>>> from irq_alloc_desc_from() by (silently) casting the return value to
>>> unsigned.  The negitive value error return now suddenly looks like a
>>> valid irq number.
>>>
>>> Commits cc79ca69 (irq_domain: Move irq_domain code from powerpc to
>>> kernel/irq) and 1bc04f2c (irq_domain: Add support for base irq and
>>> hwirq in legacy mappings) move this code to its current location in
> 
> That would be commits:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=4bbdd45afdae208a7c4ade89cf602f89a6397cff
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=cc79ca691c292e9fd44f589c7940b9654e22f2f6
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=1bc04f2cf8c2a1feadbd994f50c40bb145bf2989
> 
> 
>>> irqdomain.c
>>>
>>> The result of all of this is a null pointer dereference OOPS if one of
>>> the error cases is hit.
>>>
>>> The fix: Don't cast away the negativeness of the return value and then
>>> check for errors.
>>>
>>> Signed-off-by: David Daney<david.daney@cavium.com>
>>> ---
>>>   kernel/irq/irqdomain.c |   11 ++++++-----
>>>   1 files changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
>>> index af48e59..9d3e3ae 100644
>>> --- a/kernel/irq/irqdomain.c
>>> +++ b/kernel/irq/irqdomain.c
>>> @@ -351,6 +351,7 @@ unsigned int irq_create_mapping(struct irq_domain
>>> *domain,
>>>                   irq_hw_number_t hwirq)
>>>   {
>>>       unsigned int virq, hint;
>>> +    int irq;
>>>
>>>       pr_debug("irq: irq_create_mapping(0x%p, 0x%lx)\n", domain, hwirq);
>>>
>>> @@ -380,14 +381,14 @@ unsigned int irq_create_mapping(struct
>>> irq_domain *domain,
>>>       hint = hwirq % irq_virq_count;
>>>       if (hint == 0)
>>>           hint++;
>>> -    virq = irq_alloc_desc_from(hint, 0);
>>
>> You are not looking at mainline. hint was removed in later versions, and
>> the referenced commit ids don't exist.
> 
> Please look at Linus' tree before making incorrect statements about
> whether or not code exists on the 'mainline'
> 
> The current kernel.org tree contains the bug and will cause anything
> using irq_create_mapping() to crash in a semi-random manner.
> 

Doh, evidently I need git training... Sorry about that. I was looking at
a 3.2 branch even though I did check that. Plus I was remembering Grant
removed some of the hint code in later versions of the irq domain code.

My only comment is perhaps the pr_debug should be an error msg unless
you get an error message already. Otherwise, FWIW:

Acked-by: Rob Herring <rob.herring@calxeda.com>

Off to find my brain,
Rob


> David Daney
> 
>>
>> Rob
>>
>>> -    if (!virq)
>>> -        virq = irq_alloc_desc_from(1, 0);
>>> -    if (!virq) {
>>> +    irq = irq_alloc_desc_from(hint, 0);
>>> +    if (irq<= 0)
>>> +        irq = irq_alloc_desc_from(1, 0);
>>> +    if (irq<= 0) {
>>>           pr_debug("irq: ->  virq allocation failed\n");
>>>           return 0;
>>>       }
>>> -
>>> +    virq = irq;
>>>       if (irq_setup_virq(domain, virq, hwirq)) {
>>>           if (domain->revmap_type != IRQ_DOMAIN_MAP_LEGACY)
>>>               irq_free_desc(virq);
>>
>>
> 
