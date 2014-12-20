Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2014 02:10:25 +0100 (CET)
Received: from mail-ie0-f170.google.com ([209.85.223.170]:37732 "EHLO
        mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009080AbaLTBKYRX7rp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Dec 2014 02:10:24 +0100
Received: by mail-ie0-f170.google.com with SMTP id rd18so1736834iec.29;
        Fri, 19 Dec 2014 17:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Wn4dJKAXgiBh49WwB0VN47JaWZgTY0Sun7/vHSInYVc=;
        b=duVFxjTEo9ePf6qIl6H8lxl6Lw77FrnBD7VXgbx37CxW4va6WKw5NSxtHp/sy59agI
         Vk8gVFvYrvLOStWXEW3a3EV6+NCSdMpFc2X0sHIkogZ4bNY4O/y5DmpAjBBuIEjCsEch
         kIArT7zB44kFNDQzANHAHrvolBOb3DVPzxmEcFqryWybv61zmp6638/g/bzHjqJ8xPNn
         Bjzm2fU8h//V24ORWVCZu6toraFIROv4V92esOdSEIkbYLUO9QTbLBV2qfEUQbpVY2j9
         rEaTvi3HMnYUkRsE+/wHWVlRK4Bi5l3G1D8FvZgZjOqmuSAkcCDNskjJ3cUECVpcwQua
         WP/A==
X-Received: by 10.107.8.149 with SMTP id h21mr10401384ioi.74.1419037818440;
        Fri, 19 Dec 2014 17:10:18 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id r18sm5299314ioi.28.2014.12.19.17.10.17
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 19 Dec 2014 17:10:18 -0800 (PST)
Message-ID: <5494CC78.2010207@gmail.com>
Date:   Fri, 19 Dec 2014 17:10:16 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 0/2] Revert broken C0_Pagegrain[PG_IEC] support.
References: <1419035585-21671-1-git-send-email-ddaney.cavm@gmail.com> <5494C639.8050808@imgtec.com> <5494C798.60706@imgtec.com> <20141220005203.GA5104@linux-mips.org>
In-Reply-To: <20141220005203.GA5104@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 12/19/2014 04:52 PM, Ralf Baechle wrote:
> On Fri, Dec 19, 2014 at 04:49:28PM -0800, Leonid Yegoshin wrote:
>> Date:   Fri, 19 Dec 2014 16:49:28 -0800
>> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>> To: David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
>>   ralf@linux-mips.org
>> Subject: Re: [PATCH 0/2] Revert broken C0_Pagegrain[PG_IEC] support.
>> Content-Type: text/plain; charset="windows-1252"; format=flowed
>>
>> On 12/19/2014 04:43 PM, Leonid Yegoshin wrote:
>>> On 12/19/2014 04:33 PM, David Daney wrote:
>>>> From: David Daney <david.daney@cavium.com>
>>>>
>>>> The two patches reverted here break eXecute-Inhibit (XI) memory
>>>> protection support.  Before the patches we get SIGSEGV when attempting
>>>> to execute in non-executable memory, after the patches we loop forever
>>>> in handle_tlbl.
>>>>
>>>> It is probably possible to make C0_Pagegrain[PG_IEC] work, but I think
>>>> the most prudent thing is to revert these patches, and then only reapply
>>>> something that works after it has been well tested.
>>>>
>>>> David Daney (2):
>>>>    Revert "MIPS: Use dedicated exception handler if CPU supports RI/XI
>>>>      exceptions"
>>>>    Revert "MIPS: kernel: cpu-probe: Detect unique RI/XI exceptions"
>>>>
>>>>   arch/mips/include/asm/mipsregs.h | 1 -
>>>>   arch/mips/kernel/cpu-probe.c     | 9 ---------
>>>>   arch/mips/kernel/traps.c         | 7 -------
>>>>   arch/mips/mm/tlbex.c             | 4 ++--
>>>>   4 files changed, 2 insertions(+), 19 deletions(-)
>>>>
>>> Well, it may be have sense just to fix tlb_init() instead.
>>
>> diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
>> index aa6e4b3b2fe2..ed18efd9374b 100644
>> --- a/arch/mips/mm/tlb-r4k.c
>> +++ b/arch/mips/mm/tlb-r4k.c
>> @@ -602,7 +602,7 @@ void __cpuinit tlb_init(void)
>>   #ifdef CONFIG_64BIT
>>                  pg |= PG_ELPA;
>>   #endif
>> -               write_c0_pagegrain(pg);
>> +               write_c0_pagegrain(pg | read_c0_pagegrain());
>
> Simpler:
>   		set_c0_pagegrain(pg);

No.  That is exactly how it was broken before.

It is possible that you would want:

	if (cpu_has_rixiex)
		pg |= PG_IEC;
	set_c0_pagegrain(pg);

But that wasn't really tested.  It seems to work though.

I will send another patch.

David Daney

>
>    Ralf
>
>
