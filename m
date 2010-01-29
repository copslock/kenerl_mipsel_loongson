Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2010 20:29:55 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9350 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492826Ab0A2T3v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jan 2010 20:29:51 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b6337350000>; Fri, 29 Jan 2010 11:29:57 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 29 Jan 2010 11:28:49 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 29 Jan 2010 11:28:49 -0800
Message-ID: <4B6336F1.8070208@caviumnetworks.com>
Date:   Fri, 29 Jan 2010 11:28:49 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Guenter Roeck <guenter.roeck@ericsson.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Kernel crash in 2.6.32.6 / bcm1480 with 16k page size
References: <20100128155514.GA31611@ericsson.com> <20100129132406.GD5685@linux-mips.org> <20100129151220.GA3882@ericsson.com> <4B6316D2.1060006@caviumnetworks.com> <20100129180619.GA20113@linux-mips.org> <20100129183926.GB9895@ericsson.com> <4B632F60.4000604@caviumnetworks.com> <20100129192532.GA11123@ericsson.com>
In-Reply-To: <20100129192532.GA11123@ericsson.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jan 2010 19:28:49.0653 (UTC) FILETIME=[4886D250:01CAA119]
X-archive-position: 25747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19069

Guenter Roeck wrote:
> On Fri, Jan 29, 2010 at 01:56:32PM -0500, David Daney wrote:
>> Guenter Roeck wrote:
>>> On Fri, Jan 29, 2010 at 01:06:20PM -0500, Ralf Baechle wrote:
>>>> On Fri, Jan 29, 2010 at 09:11:46AM -0800, David Daney wrote:
>>>>
>>>>>> So first question would be: Has anyone successfully loaded a 64
>>>>>> bit mips kernel with 2.6.32 and a page size of 16k or 64k ? This
>>>>>> would at least help me reducing the problem to sb1.
>>>>> Yes, I routinely run with both 64K and 16K page sizes on 2.6.32 and
>>>>> 2.6.33-rc*.  I have not seen any crashes that can not be easily
>>>>> explained.
>>>> I can reproduce it with today's 14b7baff3eb4b1b46a592630e6f85ded9264798a.
>>>> 4K page size works ok, 16K without IPv6 works ok and 16K with IPv6 crashes.
>>>> Note, I was testing with a non-16K capable userland so ok means userland is
>>>> reached.
>>>>
>>>> Either way, that's good enought to look into things.
>>>>
>>> 16k page size works for me with the patch below. Not that I have any idea why;
>>> this was just a blind test.
>>>
>>> It seems to me that the notes in arch/mips/include/asm/pgtable-64.h regarding
>>> available virtual memory per page size may contradict with the definition
>>> of VMALLOC_END. VMALLOC_END-VMALLOC_START increases as the page size increases,
>>> but the comments indicate that a system with 16k pages should have _less_
>>> virtual memory available than a system with 4k pages because it only uses
>>> a 2 level page table.
>>>
>>> Guenter
>>>
>>> ---------------
>>>
>>> git diff arch/mips/include/asm/pgtable-64.h
>>> diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
>>> index 9cd5089..bd61030 100644
>>> --- a/arch/mips/include/asm/pgtable-64.h
>>> +++ b/arch/mips/include/asm/pgtable-64.h
>>> @@ -110,7 +110,7 @@
>>>  #define VMALLOC_START          MAP_BASE
>>>  #define VMALLOC_END    \
>>>         (VMALLOC_START + \
>>> -        PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE - (1UL << 32))
>>> +        (PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE / 16) - (1UL << 32))
>>>  #if defined(CONFIG_MODULES) && defined(KBUILD_64BIT_SYM32) && \
>>>         VMALLOC_START != CKSSEG
>>>  /* Load modules into 32bit-compatible segment. */
>> Although it may fix it, I think something along the lines of this:
>>
>> In asm/mach-generic/spaces.h:
>> #define MAX_VIRTUAL_SIZE (1 << some number)
>>
>> In asm/mach-sibyte/paces.h:
>> #define MAX_VIRTUAL_SIZE (1 << some other umber)
>>
>> In arch/mips/include/asm/pgtable-64.h
>>
>> #define VIRTUAL_SIZE (PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * 
>> PAGE_SIZE)
>>
>> #define VMALLOC_END (VMALLOC_START + min(MAX_VIRTUAL_SIZE, VIRTUAL_SIZE) 
>> - (1UL << 32))
> 
> Something like that. My patch wasn't supposed to be a proposal for a fix,
> just a guide to help finding the underlying problem.
> It may require some factor related to the page size.
> Someone who knows mips and its memory management scheme should have
> a look, otherwise it would just be a trial-end-error fix.
> 

I suspect you are hitting a maximum valid address bits limit and getting 
the Address Exception.  Limiting VMALLOC_END so that you don't hit the 
limit seems to be the solution.  I don't have the manual for the sibyte, 
so I don't know what the limit is.  The architecture specification 
doesn't state a fixed limit, although it tells what should happen when 
the limit is reached.

David Daney
