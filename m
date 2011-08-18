Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2011 18:24:06 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:2119 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492141Ab1HRQX6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2011 18:23:58 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e4d3ce00000>; Thu, 18 Aug 2011 09:25:04 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 18 Aug 2011 09:23:55 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 18 Aug 2011 09:23:55 -0700
Message-ID: <4E4D3C8D.1040707@cavium.com>
Date:   Thu, 18 Aug 2011 09:23:41 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Yong Zhang <yong.zhang@windriver.com>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: use 32-bit wrapper for compat_sys_futex
References: <1313546094-11882-1-git-send-email-yong.zhang@windriver.com> <4E4BF7C0.80703@cavium.com> <20110818023247.GA3750@windriver.com>
In-Reply-To: <20110818023247.GA3750@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Aug 2011 16:23:55.0628 (UTC) FILETIME=[39C772C0:01CC5DC3]
X-archive-position: 30894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13377

On 08/17/2011 07:32 PM, Yong Zhang wrote:
> On Wed, Aug 17, 2011 at 10:17:52AM -0700, David Daney wrote:
>>> diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
>>> index 46c4763..f48b18e 100644
>>> --- a/arch/mips/kernel/scall64-o32.S
>>> +++ b/arch/mips/kernel/scall64-o32.S
>>> @@ -441,7 +441,7 @@ sys_call_table:
>>>   	PTR	sys_fremovexattr		/* 4235 */
>>>   	PTR	sys_tkill
>>>   	PTR	sys_sendfile64
>>> -	PTR	compat_sys_futex
>>> +	PTR	sys_32_futex
>>
>> This change is redundant, scall64-o32.S already does the right thing
>
> My first virsion(not sent out) doesn't include scall64-o32.S either.
>
>> so additional zero extending is not needed and is just extra
>> instructions to execute for no reason.
>
> Why I'm adding it here is for:
> 1)code consistent, otherwise we must move SYSCALL_DEFINE6(32_futex,...)
>    under CONFIG_MIPS32_N32;

No, you don't have to move it.  Just don't call it.


> 2)I'm afraid there may be some other way to touch the high 32-bit of a
>    register, so touching scall64-o32.S is also for safety(due to unknown
>    reason, fix me if I'm wrong).

OK: You are mistaken.  You claim you don't understand what the code 
does.  That is really a poor justification for modifying it.

David Daney
