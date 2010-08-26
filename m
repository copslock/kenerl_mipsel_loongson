Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Aug 2010 18:21:55 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13685 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490967Ab0HZQVs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Aug 2010 18:21:48 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c7694b80000>; Thu, 26 Aug 2010 09:22:16 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 26 Aug 2010 09:21:44 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 26 Aug 2010 09:21:44 -0700
Message-ID: <4C769498.9020004@caviumnetworks.com>
Date:   Thu, 26 Aug 2010 09:21:44 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100720 Fedora/3.0.6-1.fc12 Thunderbird/3.0.6
MIME-Version: 1.0
To:     Adam Jiang <jiang.adam@gmail.com>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] mips: irq: add statckoverflow detection
References: <1282372293-30211-1-git-send-email-jiang.adam@gmail.com>    <4C757CF4.6010304@caviumnetworks.com> <AANLkTi=FrWs_tL_Z6EL0LeiBMt2Vj9_axFVXprzJB0iS@mail.gmail.com>
In-Reply-To: <AANLkTi=FrWs_tL_Z6EL0LeiBMt2Vj9_axFVXprzJB0iS@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Aug 2010 16:21:44.0477 (UTC) FILETIME=[C622A4D0:01CB453A]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 08/25/2010 06:12 PM, Adam Jiang wrote:
> 2010/8/26 David Daney<ddaney@caviumnetworks.com>:
>> It looks like this patch only checks when processing an interrupt, which
>> doesn't seem like it would give much coverage.
>
> Yes, it is. This is only for detection on the situation which may be
> caused by nested interruption. No more coverage to any other cases.
> Because to do that is much difficult and unpredicted.
>

Well, since the default is to run interrupt handlers with interrupts 
disabled, it seems like it is of little use as you will almost never see 
nested interrupts.

A solution that shows overflow in all situations would be of more use. 
Something that could use GCC's -stack-check or related machinery might 
be interesting.

David Daney


> I will revise the bad code style Sergei blamed.
>
> /Adam
>
>>
>> Am I missing something?
>>
>> David Daney
>>
>>
>> On 08/20/2010 11:31 PM, jiang.adam@gmail.com wrote:
>>>
>>> From: Adam Jiang<jiang.adam@gmail.com>
>>>
>>> Add stackoverflow detection to mips arch
>>>
>>> Signed-off-by: Adam Jiang<jiang.adam@gmail.com>
>>> ---
>>>   arch/mips/Kconfig.debug |    7 +++++++
>>>   arch/mips/kernel/irq.c  |   19 +++++++++++++++++++
>>>   2 files changed, 26 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
>>> index 43dc279..f1a00a2 100644
>>> --- a/arch/mips/Kconfig.debug
>>> +++ b/arch/mips/Kconfig.debug
>>> @@ -67,6 +67,13 @@ config CMDLINE_OVERRIDE
>>>
>>>           Normally, you will choose 'N' here.
>>>
>>> +config DEBUG_STACKOVERFLOW
>>> +       bool "Check for stack overflows"
>>> +       depends on DEBUG_KERNEL
>>> +       help
>>> +         This option will cause messages to be printed if free stack
>>> space
>>> +         drops below a certain limit.
>>> +
>>>   config DEBUG_STACK_USAGE
>>>         bool "Enable stack utilization instrumentation"
>>>         depends on DEBUG_KERNEL
>>> diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
>>> index c6345f5..6334037 100644
>>> --- a/arch/mips/kernel/irq.c
>>> +++ b/arch/mips/kernel/irq.c
>>> @@ -151,6 +151,22 @@ void __init init_IRQ(void)
>>>   #endif
>>>   }
>>>
>>> +static inline void check_stack_overflow(void)
>>> +{
>>> +#ifdef CONFIG_DEBUG_STACKOVERFLOW
>>> +       long sp;
>>> +
>>> +       asm volatile("move %0, $sp" : "=r" (sp));
>>> +       sp = sp&    (THREAD_SIZE-1);
>>> +
>>> +       /* check for stack overflow: is there less then 2KB free? */
>>> +       if (unlikely(sp<    (sizeof(struct thread_info) + 2048))) {
>>> +               printk("do_IRQ: stack overflow: %ld\n",
>>> +                      sp - sizeof(struct thread_info));
>>> +               dump_stack();
>>> +       }
>>> +#endif
>>> +}
>>>   /*
>>>    * do_IRQ handles all normal device IRQ's (the special
>>>    * SMP cross-CPU interrupts have their own specific
>>> @@ -159,6 +175,9 @@ void __init init_IRQ(void)
>>>   void __irq_entry do_IRQ(unsigned int irq)
>>>   {
>>>         irq_enter();
>>> +
>>> +       check_stack_overflow();
>>> +
>>>         __DO_IRQ_SMTC_HOOK(irq);
>>>         generic_handle_irq(irq);
>>>         irq_exit();
>>
>>
