Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 10:51:24 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:41289 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990406AbeAXJvR0-d4V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jan 2018 10:51:17 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 24 Jan 2018 09:49:45 +0000
Received: from [10.150.130.83] (10.150.130.83) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 24 Jan
 2018 01:49:36 -0800
Subject: Re: [PATCH 02/14] MIPS: memblock: Surely map BSS kernel memory
 section
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     <ralf@linux-mips.org>, <miodrag.dinic@mips.com>,
        <jhogan@kernel.org>, <goran.ferenc@mips.com>,
        <david.daney@cavium.com>, <paul.gortmaker@windriver.com>,
        <paul.burton@mips.com>, <alex.belits@cavium.com>,
        <Steven.Hill@cavium.com>, <alexander.sverdlin@nokia.com>,
        <kumba@gentoo.org>, <marcin.nowakowski@mips.com>,
        <James.hogan@mips.com>, <Peter.Wotton@mips.com>,
        <Sergey.Semin@t-platforms.ru>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180117222312.14763-3-fancer.lancer@gmail.com>
 <3fbb8850-bf34-d698-299a-f1cd62d063ae@mips.com>
 <20180122214746.GC32024@mobilestation>
 <8a26c7cd-966f-90d4-96c9-2f974808c2f4@mips.com>
 <20180123192707.GB28147@mobilestation>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <884fd904-d439-fe9f-279c-44f4dbbfd096@mips.com>
Date:   Wed, 24 Jan 2018 09:49:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180123192707.GB28147@mobilestation>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1516787385-321458-15928-53854-6
X-BESS-VER: 2017.17-r1801171719
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189306
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

Hi Serge,

On 23/01/18 19:27, Serge Semin wrote:
> Hello Matt,
> 
> On Tue, Jan 23, 2018 at 11:03:27AM +0000, Matt Redfearn <matt.redfearn@mips.com> wrote:
>> Hi Serge,
>>
>> On 22/01/18 21:47, Serge Semin wrote:
>>> Hello Matt,
>>>
>>> On Mon, Jan 22, 2018 at 04:35:26PM +0000, Matt Redfearn <matt.redfearn@mips.com> wrote:
>>>> Hi Serge,
>>>>
>>>> On 17/01/18 22:23, Serge Semin wrote:
>>>>> The current MIPS code makes sure the kernel code/data/init
>>>>> sections are in the maps, but BSS should also be there.
>>>>
>>>> Quite right - it should. But this was protected against by reserving all
>>>> bootmem up to the _end symbol here:
>>>> http://elixir.free-electrons.com/linux/v4.15-rc8/source/arch/mips/kernel/setup.c#L388
>>>> Which you remove in the next patch in this series. I'm not sure it is worth
>>>
>>> Right. Missed that part. The old code just doesn't set the kernel memory free
>>> calling the free_bootmem() method for non-reserved parts below reserved_end.
>>>
>>>> disentangling the reserved_end stuff from the next patch to make this into a
>>>> single logical change of reserving just .bss rather than everything below
>>>> _end.
>>>
>>> Good point. I'll move this change into the "[PATCH 05/14] MIPS: memblock:
>>> Add reserved memory regions to memblock". It logically belongs to that place.
>>> Since basically by the arch_mem_addpart() calls we reserve all the kernel
>>
>>
>> Actually I was wrong - it's not this sequence of arch_mem_addpart's that
>> reserves the kernels memory. At least on DT based systems, it's pretty
>> likely that these regions will overlap with the system memory already added.
>> of_scan_flat_dt will look for the memory node and add it via
>> early_init_dt_add_memory_arch.
>> These calls to add the kernel text, init and bss detect that they overlap
>> with the already present system memory, so don't get added, here:
>> http://elixir.free-electrons.com/linux/v4.15-rc9/source/arch/mips/kernel/setup.c#L759
>>
>> As such, when we print out the content of boot_mem_map, we only have a
>> single entry:
>>
>> [    0.000000] Determined physical RAM map:
>> [    0.000000]  memory: 10000000 @ 00000000 (usable)
>>
>>
>>> memory now I'd also merged them into a single call for the range [_text, _end].
>>> What do you think?
>>
>>
>> I think that this patch makes sense in case the .bss is for some reason not
>> covered by an existing entry, but I would leave it as a separate patch.
>>
>> Your [PATCH 05/14] MIPS: memblock: Add reserved memory regions to memblock
>> is actually self-contained since it replaces reserving all memory up to _end
>> with the single reservation of the kernel's whole size
>>
>> +	size = __pa_symbol(&_end) - __pa_symbol(&_text);
>> +	memblock_reserve(__pa_symbol(&_text), size);
>>
>>
>> Which I think is definitely an improvement since it is much clearer.
>>
> 
> Alright lets sum it up. First of all, yeah, you are right, arch_mem_addpart()
> is created to make sure the kernel memory is added to the memblock/bootmem pool.
> The previous arch code was leaving such the memory range non-freed since it was
> higher the reserved_end, so to make sure the early memory allocations wouldn't
> be made from the pages, where kernel actually resides.
> 
> In my code I still wanted to make sure the kernel memory is in the memblock pool.
> But I also noticed, that .bss memory range wouldn't be added to the pool if neither
> dts nor platform-specific code added any memory to the boot_mem_map pool. So I
> decided to fix it. The actual kernel memory reservation is performed after all
> the memory regions are declared by the code you cited. It's essential to do
> the [_text, _end] memory range reservation there, otherwise memblock may
> allocate from the memory range occupied by the kernel code/data.
> 
> Since you agree with leaving it in the separate patch, I'd only suggest to
> call the arch_mem_addpart() method for just one range [_text, _end] instead of
> doing it three times for a separate _text, _data and bss sections. What do you
> think?

I think it's best left as 3 separate reservations, mainly due to the 
different attribute used for the init section. So all in all, I like 
this patch as it is.

Thanks,
Matt

> 
> Regards,
> -Sergey
> 
>> Thanks,
>> Matt
>>
>>>
>>> Regards,
>>> -Sergey
>>>
>>>>
>>>> Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
>>>>
>>>> Thanks,
>>>> Matt
>>>>
>>>>>
>>>>> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
>>>>> ---
>>>>>   arch/mips/kernel/setup.c | 3 +++
>>>>>   1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
>>>>> index 76e9e2075..0d21c9e04 100644
>>>>> --- a/arch/mips/kernel/setup.c
>>>>> +++ b/arch/mips/kernel/setup.c
>>>>> @@ -845,6 +845,9 @@ static void __init arch_mem_init(char **cmdline_p)
>>>>>   	arch_mem_addpart(PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT,
>>>>>   			 PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT,
>>>>>   			 BOOT_MEM_INIT_RAM);
>>>>> +	arch_mem_addpart(PFN_DOWN(__pa_symbol(&__bss_start)) << PAGE_SHIFT,
>>>>> +			 PFN_UP(__pa_symbol(&__bss_stop)) << PAGE_SHIFT,
>>>>> +			 BOOT_MEM_RAM);
>>>>>   	pr_info("Determined physical RAM map:\n");
>>>>>   	print_memory_map();
>>>>>
