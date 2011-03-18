Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Mar 2011 17:57:24 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:12446 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491934Ab1CRQ5V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Mar 2011 17:57:21 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d838f270000>; Fri, 18 Mar 2011 09:58:15 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 18 Mar 2011 09:57:19 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 18 Mar 2011 09:57:19 -0700
Message-ID: <4D838EEE.3080804@caviumnetworks.com>
Date:   Fri, 18 Mar 2011 09:57:18 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Heiher <admin@heiher.info>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] Fixup personality in different ABI.
References: <AANLkTimsVcPtJHrV+UMcXAMcqDRpm3ZbbXqSuupx0Uq5@mail.gmail.com>      <4D8385AA.605@caviumnetworks.com> <AANLkTi=xoZpT7KyOhrsFpWqi2bRKMJqHuAOtmfFTTDL+@mail.gmail.com>
In-Reply-To: <AANLkTi=xoZpT7KyOhrsFpWqi2bRKMJqHuAOtmfFTTDL+@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Mar 2011 16:57:19.0017 (UTC) FILETIME=[8AB09990:01CBE58D]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 03/18/2011 09:34 AM, Heiher wrote:
> Hello,
>
> I think the o32 process personality default value is PER_LINUX32, n32
> &  n64 abi process is PER_LINUX in 64-bit Kernel. The kernel should
> automatic set a 'right' personality to every process for different
> abi. Isn't it?

No.

Did you see my first question below?


>
> On Sat, Mar 19, 2011 at 12:17 AM, David Daney<ddaney@caviumnetworks.com>  wrote:
>> On 03/17/2011 09:59 PM, Heiher wrote:
>>>
>>> Hello,
>>
>> Why, hello to you too.
>>
>>
>> Can you explain what problem you are trying to solve?

Please answer this question.


There are millions of lines of code in the Linux kernel.  A change to 
any of which requires justification.  You cannot just say I don't like 
the looks of things, so I am going to make an arbitrary change to the 
kernel ABI that will break existing code.

David Daney

>>
>> Presumably if someone has set the personality, they had a reason for doing
>> so.  On what grounds do you think it is a good idea to override the explicit
>> desires of the user and restore a default personality?
>>
>> This patch would break many software build systems.
>>
>> Unless you can explain why this is needed, I have to say:
>>
>> NAK to this patch.
>>
>> Thanks,
>> David Daney
>>
>>>
>>>>  From bf3637153bc5e3d0e3f1c2982c323057a8e04801 Mon Sep 17 00:00:00 2001
>>>
>>> From: Heiher<admin@heiher.info>
>>> Date: Fri, 18 Mar 2011 12:51:08 +0800
>>> Subject: [PATCH] Fixup personality in different ABI.
>>>
>>> * 'arch' output:
>>>         o32 : mips
>>>         n32 : mips64
>>>         64  : mips64
>>> ---
>>>   arch/mips/include/asm/elf.h |    5 +++++
>>>   1 files changed, 5 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
>>> index 455c0ac..01510d4 100644
>>> --- a/arch/mips/include/asm/elf.h
>>> +++ b/arch/mips/include/asm/elf.h
>>> @@ -262,6 +262,7 @@ do {
>>>                       \
>>>   #ifdef CONFIG_MIPS32_N32
>>>   #define __SET_PERSONALITY32_N32()                                     \
>>>         do {                                                            \
>>> +               set_personality(PER_LINUX);                             \
>>>                 set_thread_flag(TIF_32BIT_ADDR);                        \
>>>                 current->thread.abi =&mips_abi_n32;                     \
>>>         } while (0)
>>> @@ -273,6 +274,7 @@ do {
>>>                       \
>>>   #ifdef CONFIG_MIPS32_O32
>>>   #define __SET_PERSONALITY32_O32()                                     \
>>>         do {                                                            \
>>> +               set_personality(PER_LINUX32);                   \
>>>                 set_thread_flag(TIF_32BIT_REGS);                        \
>>>                 set_thread_flag(TIF_32BIT_ADDR);                        \
>>>                 current->thread.abi =&mips_abi_32;                      \
>>> @@ -305,7 +307,10 @@ do {
>>>                        \
>>>         if ((ex).e_ident[EI_CLASS] == ELFCLASS32)                       \
>>>                 __SET_PERSONALITY32(ex);                                \
>>>         else                                                            \
>>> +       {                                                               \
>>> +               set_personality(PER_LINUX);                             \
>>>                 current->thread.abi =&mips_abi;                 \
>>> +       }                                                               \
>>>                                                                         \
>>>         p = personality(current->personality);                          \
>>>         if (p != PER_LINUX32&&    p != PER_LINUX)                         \
>>
>>
>
