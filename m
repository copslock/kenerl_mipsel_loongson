Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Mar 2010 03:53:54 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:63161 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492230Ab0CKCxv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Mar 2010 03:53:51 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o2B2rhM4021231;
        Wed, 10 Mar 2010 18:53:43 -0800 (PST)
Received: from [128.224.162.222] ([128.224.162.222]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
         Wed, 10 Mar 2010 18:53:42 -0800
Message-ID: <4B985B38.1050105@windriver.com>
Date:   Thu, 11 Mar 2010 10:53:44 +0800
From:   Yang Shi <yang.shi@windriver.com>
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     ddaney@caviumnetworks.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon: Fix wrong variable type in smp.c
References: <1268115862-25976-1-git-send-email-yang.shi@windriver.com> <20100309190309.GA301@linux-mips.org> <20100309191750.GA1960@linux-mips.org>
In-Reply-To: <20100309191750.GA1960@linux-mips.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Mar 2010 02:53:42.0925 (UTC) FILETIME=[0F7AE3D0:01CAC0C6]
Return-Path: <Yang.Shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle 写道:
> On Tue, Mar 09, 2010 at 08:03:09PM +0100, Ralf Baechle wrote:
>
>   
>>> @@ -281,7 +281,7 @@ static void octeon_cpu_die(unsigned int cpu)
>>>  
>>>  #ifdef CONFIG_CAVIUM_OCTEON_WATCHDOG
>>>  	/* Disable the watchdog */
>>> -	cvmx_ciu_wdogx_t ciu_wdog;
>>> +	union cvmx_ciu_wdogx ciu_wdog;
>>>  	ciu_wdog.u64 = cvmx_read_csr(CVMX_CIU_WDOGX(cpu));
>>>  	ciu_wdog.s.mode = 0;
>>>  	cvmx_write_csr(CVMX_CIU_WDOGX(cpu), ciu_wdog.u64);
>>>       
>> David,
>>
>> I think this ifdef should be replaced by a notifier called from
>> __cpu_die().
>>     
>
> Since this is unused I'll just remove it for now.
>   

This breaks kernel build when HOTPLUG_CPU is enabled.

Regards,
Yang

>   Ralf
>
>   
