Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2010 05:23:55 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:51672 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1490959Ab0ERDXs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 May 2010 05:23:48 +0200
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o4I3Ne5l009240;
        Mon, 17 May 2010 20:23:40 -0700 (PDT)
Received: from [128.224.162.222] ([128.224.162.222]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
         Mon, 17 May 2010 20:23:39 -0700
Message-ID: <4BF2083B.4000303@windriver.com>
Date:   Tue, 18 May 2010 11:23:39 +0800
From:   Yang Shi <yang.shi@windriver.com>
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
MIME-Version: 1.0
To:     Yang Shi <yang.shi@windriver.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [Bug report] Got bus error when loading kernel module on SB1250
 Rev B2 board with 64 bit kernel
References: <4BED25F3.4010809@windriver.com> <20100514180211.GB32203@linux-mips.org> <4BF0B08F.1010305@windriver.com>
In-Reply-To: <4BF0B08F.1010305@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 18 May 2010 03:23:39.0869 (UTC) FILETIME=[82A1C8D0:01CAF639]
Return-Path: <Yang.Shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips

Yang Shi 写道:
> Ralf Baechle 写道:
>   
>> On Fri, May 14, 2010 at 06:29:07PM +0800, Yang Shi wrote:
>>
>>   
>>     
>>> I'm running 2.6.34-rc7 mainline kernel on SB1250 (Rev B2) board. And, I
>>> use the default sb1250 kernel config (sb1250-swarm_defconfig). So, 64
>>> bit kernel is used. During kernel loading module got bus error, see
>>> below log:
>>>     
>>>       
>> Whops.  Fixes which were supposed to handle exactly this problem went
>> upstream for 2.6.34-rc3 and were tested successfully by others on their
>> systems.
>>
>> I wonder if in arch/mips/sibyte/sb1250/setup.c you can instrument
>> the function sb1250_m3_workaround_needed() and print the values of
>> soc_type, soc_pass and the retun value of that function.  Then let's take
>> it from there.
>>   
>>     
>
> See below log:
>
> Broadcom SiByte BCM1250 B2 @ 800 MHz (SB1 rev 2)
>
> And, soc_typs is 0x0 and soc_pass is 0x11, sb1250_m3_workaround_needed 
> should return 1. So, tlb refill handler should go the m3 workaround code 
> path.
>   

It seems CPU_PREFETCH caused this issue. See commit:

commit 6b4caed2ebff4ee232f227d62eb3180d0b558a31
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Wed Jan 28 17:48:40 2009 +0000

    MIPS: IP27: Switch from DMA_IP27 to DMA_COHERENT
   
    commit 0d356eaa6316cbb3e89b4607de20b2f2d0ceda25 from linux-mips
   
    The special IP27 DMA code selected by DMA_IP27 has been removed a while
    ago turning DMA_IP27 into almost a nop.  Also fixup the broken logic of
    its last users memcpy.S and memcpy-inatomic.s.
   
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

If undef CPU_PREFETCH for SB1250, module can be loaded correctly.

Thanks,
Yang

> Thanks,
> Yang
>
>   
>>   Ralf
>>
>>   
>>     
>
>
>
>   
