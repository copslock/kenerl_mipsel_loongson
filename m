Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Apr 2012 22:46:14 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:64461 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903723Ab2DQUp7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Apr 2012 22:45:59 +0200
Received: by yhjj52 with SMTP id j52so3733131yhj.36
        for <multiple recipients>; Tue, 17 Apr 2012 13:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Q5UFV3riz7fmfx9N5ped6x7GkKHiLrLesiFMF26ylJQ=;
        b=D7J8yy/xu0QtxU/aNbUU73Q7tHGipCJkbJaqTz3k8YTgjyygSMgqt+AbKtczNKo1Sb
         zkCGKRlVDleTH+kX7lnEhev7w6cM2vUZ2X+7RZjlYSkchwAKsjRocdoJM+NHKEabuqAz
         y7hpmVCeKTY2WgPidqlHbFcqZ8LkEJKuDpGRsmi2UNiimVYcFhop05BqbeZi6HWve3Nt
         yvQGCoJwZS37+ewK0bGz0sHzSWHOpCrXwC7IkdbSQwvYooH7drrqcjAfU+DDMVD7H7Tj
         O+uolIp41Q/rGkD+uit07QmtwTRYlu87AeZEWkhlFYJ0cnACpLOads3I6+U4ppxJStJC
         IcCw==
Received: by 10.60.14.136 with SMTP id p8mr23192297oec.68.1334695552751;
        Tue, 17 Apr 2012 13:45:52 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id t10sm989928obc.15.2012.04.17.13.45.51
        (version=SSLv3 cipher=OTHER);
        Tue, 17 Apr 2012 13:45:52 -0700 (PDT)
Message-ID: <4F8DD67E.3000600@gmail.com>
Date:   Tue, 17 Apr 2012 13:45:50 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Yong Zhang <yong.zhang0@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: cavium: Don't enable irq in ->init__secondary()
References: <1334561133-19139-1-git-send-email-yong.zhang0@gmail.com> <4F8C4D4E.4060900@gmail.com> <20120417030848.GA6377@zhy>
In-Reply-To: <20120417030848.GA6377@zhy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/16/2012 08:08 PM, Yong Zhang wrote:
> On Mon, Apr 16, 2012 at 09:48:14AM -0700, David Daney wrote:
>> On 04/16/2012 12:25 AM, Yong Zhang wrote:
>>> From: Yong Zhang<yong.zhang@windriver.com>
>>>
>>> Too early to enable irq will break some following action,
>>> such as notify_cpu_starting().
>>
>> Can you be more specific about what breaks?
>
> For example:
>
> 	CPU1				CPU2
> __cpu_up();
>    mp_ops->boot_secondary();
>      				start_secondary();
> 				  octeon_init_secondary();
> 				    raw_local_irq_enable();
> 				<IRQ>
> 				do something;
> 				      wake up softirqd;
> 				      try_to_wake_up();
> 				        select_fallback_rq();
> 					/* select wrong cpu */
>      set_cpu_online();
>

Yeah, that looks broken to me too.

>>
>>>
>>> I don't get side effect with this patch.
>>
>> Without this, where do irqs get enabled on the secondary CPUs?
>
> cpu_idle() will handle it. But in fact we should not depend on
> cpu_idle().

It is not done in cpu_idle() itself.  If irqs are disabled upon entry to 
cpu_idle() *and* need_resched(), then we call into schedule().  The irqs 
are then enabled by the raw_spin_unlock_irq(&rq->lock) at the end of 
kernel/sched/core.c: __schedule().

>
> But it seems there is not suitable place to put local_irq_enable(),
> though ->smp_finish() looks like a more suitable place.

It would be better, but it seems like really it should be done in 
cpu_idle() immediately after rcu_idle_enter().

>
> When looking more at smp support on MIPS, there is more things I find.
> Such as set_cpu_online() is called on CPU1, so there will be another race
> window like above scenario. Please take a look at what commit 2baab4e9
> intend to resolve.
>
> Thanks,
> Yong
>
>
>
>
>>
>>>
>>> Signed-off-by: Yong Zhang<yong.zhang0@gmail.com>
>>> Cc: David Daney<ddaney@caviumnetworks.com>
>>> Cc: Ralf Baechle<ralf@linux-mips.org>
>>> ---
>>>   arch/mips/cavium-octeon/smp.c |    1 -
>>>   1 files changed, 0 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
>>> index 97e7ce9..7e65c88 100644
>>> --- a/arch/mips/cavium-octeon/smp.c
>>> +++ b/arch/mips/cavium-octeon/smp.c
>>> @@ -185,7 +185,6 @@ static void __cpuinit octeon_init_secondary(void)
>>>   	octeon_init_cvmcount();
>>>
>>>   	octeon_irq_setup_secondary();
>>> -	raw_local_irq_enable();
>>>   }
>>>
>>>   /**
>
