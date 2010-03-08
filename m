Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Mar 2010 10:42:53 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:63179 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491022Ab0CHJms (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Mar 2010 10:42:48 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o289gaLe024132;
        Mon, 8 Mar 2010 01:42:36 -0800 (PST)
Received: from [128.224.162.222] ([128.224.162.222]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
         Mon, 8 Mar 2010 01:42:35 -0800
Message-ID: <4B94C68A.4000002@windriver.com>
Date:   Mon, 08 Mar 2010 17:42:34 +0800
From:   Yang Shi <yang.shi@windriver.com>
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
MIME-Version: 1.0
To:     Yang Shi <yang.shi@windriver.com>
CC:     David Daney <ddaney@caviumnetworks.com>, ralf@linux-mips.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Protect current_cpu_data with preempt disable in
 delay()
References: <1267695573-27360-1-git-send-email-yang.shi@windriver.com> <4B8FFAB3.1090409@caviumnetworks.com> <4B9059FE.3090801@windriver.com>
In-Reply-To: <4B9059FE.3090801@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 08 Mar 2010 09:42:35.0862 (UTC) FILETIME=[AF02BF60:01CABEA3]
Return-Path: <Yang.Shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips

Hi folks,

Any advice on this topic?

Thanks,
Yang

Yang Shi 写道:
> David Daney 写道:
>   
>> On 03/04/2010 01:39 AM, Yang Shi wrote:
>>   
>>     
>>> During machine restart with reboot command, get the following
>>> bug info:
>>>
>>> BUG: using smp_processor_id() in preemptible [00000000] code: reboot/1989
>>> caller is __udelay+0x14/0x70
>>> Call Trace:
>>> [<ffffffff8110ad28>] dump_stack+0x8/0x34
>>> [<ffffffff812dde04>] debug_smp_processor_id+0xf4/0x110
>>> [<ffffffff812d90bc>] __udelay+0x14/0x70
>>> [<ffffffff81378274>] md_notify_reboot+0x12c/0x148
>>> [<ffffffff81161054>] notifier_call_chain+0x64/0xc8
>>> [<ffffffff811614dc>] __blocking_notifier_call_chain+0x64/0xc0
>>> [<ffffffff8115566c>] kernel_restart_prepare+0x1c/0x38
>>> [<ffffffff811556cc>] kernel_restart+0x14/0x50
>>> [<ffffffff8115581c>] SyS_reboot+0x10c/0x1f0
>>> [<ffffffff81103684>] handle_sysn32+0x44/0x84
>>>
>>> The root cause is that current_cpu_data is accessed in preemptible
>>> context, so protect it with preempt_disable/preempt_enable pair
>>> in delay().
>>>
>>> Signed-off-by: Yang Shi<yang.shi@windriver.com>
>>> ---
>>>   arch/mips/lib/delay.c |    6 +++++-
>>>   1 files changed, 5 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/mips/lib/delay.c b/arch/mips/lib/delay.c
>>> index 6b3b1de..dc38064 100644
>>> --- a/arch/mips/lib/delay.c
>>> +++ b/arch/mips/lib/delay.c
>>> @@ -41,7 +41,11 @@ EXPORT_SYMBOL(__delay);
>>>
>>>   void __udelay(unsigned long us)
>>>   {
>>> -	unsigned int lpj = current_cpu_data.udelay_val;
>>> +	unsigned int lpj;
>>> +
>>> +	preempt_disable();
>>> +	lpj = current_cpu_data.udelay_val;
>>> +	preempt_enable();
>>>
>>>   	__delay((us * 0x000010c7ull * HZ * lpj)>>  32);
>>>   }
>>>     
>>>       
>> This doesn't seem like the best approach.
>>
>> Perhaps we should either use raw_current_cpu_data and no 
>> preempt_disable(), or if we are concerned about migrating to a CPU with 
>> a different lpj value, move the preempt_enable after the call to __delay().
>>   
>>     
>
> Thanks David.
>
> Yes, actually I also has this concern, so this patch is just a rough 
> fix. And I tried raw_current_cpu_data as well, but I'm not sure if it's 
> safe or not. Another proposal is to change cpu_data and current_cpu_data 
> to per CPU variables, of course this is a big change.
>
> Regards,
> Yang
>
>   
>> David Daney
>>
>>   
>>     
>
>
>
>   
