Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2011 09:06:52 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:55736 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1490960Ab1CAIGt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Mar 2011 09:06:49 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p2186eSU021498;
        Tue, 1 Mar 2011 00:06:40 -0800 (PST)
Received: from [128.224.162.190] ([128.224.162.190]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
         Tue, 1 Mar 2011 00:06:39 -0800
Message-ID: <4D6CA90D.10609@windriver.com>
Date:   Tue, 01 Mar 2011 16:06:37 +0800
From:   Yang Shi <yang.shi@windriver.com>
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
MIME-Version: 1.0
To:     Himanshu Chauhan <hschauhan@nulltrace.org>
CC:     "Kevin D. Kissell" <kevink@paralogos.com>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: Kernel link address assumption
References: <4D669FCE.8000601@nulltrace.org> <4D66A08F.7050605@paralogos.com> <4D66A1AC.2090007@nulltrace.org>
In-Reply-To: <4D66A1AC.2090007@nulltrace.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Mar 2011 08:06:39.0993 (UTC) FILETIME=[98215690:01CBD7E7]
Return-Path: <Yang.Shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips

Himanshu Chauhan 写道:
> On Thursday 24 February 2011 11:46 PM, Kevin D. Kissell wrote:
>   
>> On 02/24/11 10:13, Himanshu Chauhan wrote:
>>     
>>> Hi,
>>>
>>> Does Linux kernel for MIPS assumes that its link address is always in 
>>> Kseg0?
>>> What if I change the link address to somewhere in useg?
>>>       
>
>   
>> Your page fault handlers will be in for an interesting time. ;o)
>>
>> What you describe can be, and is done, for virtualized kernels running 
>> on top
>> of a hypervisor, but there's a bit more involved than just changing 
>> the link address.
>>     
> Hi Kevin,
>
> You just caught that. Thats what I am trying to evaluate. What all I 
> would need to do apart from changing the link address. I am working on a 
> bare metal hypervisor for MIPS architecture.
>   

You need setup suitable TLB mappings for Linux kernel in bootloader or 
Hypervisor.

Yang

> Any pointers?
>
> Regards
> Himanshu
>
>
>
>   
