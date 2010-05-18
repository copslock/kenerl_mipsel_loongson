Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2010 13:07:38 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:62644 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491833Ab0ERLHf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 May 2010 13:07:35 +0200
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o4IB7Sae021582;
        Tue, 18 May 2010 04:07:28 -0700 (PDT)
Received: from [128.224.162.222] ([128.224.162.222]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
         Tue, 18 May 2010 04:07:27 -0700
Message-ID: <4BF274EF.90604@windriver.com>
Date:   Tue, 18 May 2010 19:07:27 +0800
From:   Yang Shi <yang.shi@windriver.com>
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [Bug report] Got bus error when loading kernel module on SB1250
 Rev B2 board with 64 bit kernel
References: <4BED25F3.4010809@windriver.com> <20100514180211.GB32203@linux-mips.org> <4BF0B08F.1010305@windriver.com> <4BF2083B.4000303@windriver.com> <20100518103818.GA31874@linux-mips.org>
In-Reply-To: <20100518103818.GA31874@linux-mips.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 18 May 2010 11:07:27.0926 (UTC) FILETIME=[4D724D60:01CAF67A]
Return-Path: <Yang.Shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle 写道:
> On Tue, May 18, 2010 at 11:23:39AM +0800, Yang Shi wrote:
>
>   
>> It seems CPU_PREFETCH caused this issue. See commit:
>>
>> commit 6b4caed2ebff4ee232f227d62eb3180d0b558a31
>>     
>
> Is this a commit ID of a Wind River tree?  The commit ID for the kernel.org
> kernel tree is 634286f127bef8799cd04799d3e1d5471e8fd91c, for the lmo tree
> e3bf818d95cb372bfe78696957586d9afff0b405.
>   

Yes, that commit is cherry-picked from mainline commit 
634286f127bef8799cd04799d3e1d5471e8fd91c. If I revert this commit, 
module loading works well.

>   
>> Author: Ralf Baechle <ralf@linux-mips.org>
>> Date:   Wed Jan 28 17:48:40 2009 +0000
>>
>>    MIPS: IP27: Switch from DMA_IP27 to DMA_COHERENT
>>    commit 0d356eaa6316cbb3e89b4607de20b2f2d0ceda25 from linux-mips
>>    The special IP27 DMA code selected by DMA_IP27 has been removed a while
>>    ago turning DMA_IP27 into almost a nop.  Also fixup the broken logic of
>>    its last users memcpy.S and memcpy-inatomic.s.
>>    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>>
>> If undef CPU_PREFETCH for SB1250, module can be loaded correctly.
>>     
>
> [...]
>
>   
>> This patch did below fix:
>>
>> -#if !defined(CONFIG_DMA_COHERENT) || !defined(CONFIG_DMA_IP27)
>> +#ifdef CONFIG_DMA_NONCOHERENT
>> #undef CONFIG_CPU_HAS_PREFETCH
>>
>> Before the fix, CONFIG_DMA_IP27 is undefined for all of boards except
>> IP27, so CONFIG_CPU_HAS_PREFETCH is undefined always.
>>     
>
> That's an old issue striking here then.  Memcpy will prefetch beyond the
> end of the source or destination area, if the use of prefetch is enabled.
>
> On non-coherent systems this is a problem because these prefetches might
> bring back data that was just flushed from the cache back into the cache
> resulting in corrupted DMA transfers.
>
> Some systems that do very tight checking of address but do not differenciate
> between actual loads / stores and prefetch accesses may also also throw
> address error exceptions when prefetching from non-decoded address ranges.
> That would typically be just beyond the end of a RAM range.  For those
>   
> systems the solution is to either disable prefetching or to not use the
> last page of every physically contiguous area of memory.
>   
> I'm still looking at why we this wasn't triggered earlier.  Something else
> must have changed to suddenly trigger this issue - and your system seems
> to be the only system affected.
>   

As I said above, before 634286f127bef8799cd04799d3e1d5471e8fd91c 
checking in, actually prefetch should be *undefined* for all of boards 
except IP27, so maybe no one noticed this issue.

Seems yes, just Sibyte is affected :(

Thanks,
Yang

>   Ralf
>
>   
