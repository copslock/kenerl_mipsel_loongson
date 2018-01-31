Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Jan 2018 15:03:44 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:55712 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994777AbeAaODgd9AS7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Jan 2018 15:03:36 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 31 Jan 2018 14:03:21 +0000
Received: from [192.168.159.182] (192.168.159.182) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 31 Jan
 2018 05:58:33 -0800
Subject: Re: [PATCH v2] MIPS: fix incorrect mem=X@Y handling
To:     Mathieu Malaterre <malat@debian.org>
CC:     "# v4 . 11" <stable@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
References: <1504609608-7694-1-git-send-email-marcin.nowakowski@imgtec.com>
 <20171221210100.12002-1-malat@debian.org> <20180123141756.GE22211@saruman>
 <CA+7wUszKJbZTs-8W6s-4a-N7MB=7OrV3Uyp0v-ZZiHmRTVNazw@mail.gmail.com>
From:   Marcin Nowakowski <marcin.nowakowski@mips.com>
Message-ID: <63726aa5-543d-8297-2e63-f767a3ba6be1@mips.com>
Date:   Wed, 31 Jan 2018 14:58:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CA+7wUszKJbZTs-8W6s-4a-N7MB=7OrV3Uyp0v-ZZiHmRTVNazw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.159.182]
X-BESS-ID: 1517407400-452059-5836-145013-1
X-BESS-VER: 2018.1.1-r1801291958
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.20
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189550
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.20 PR0N_SUBJECT           META: Subject has letters around special characters (pr0n) 
X-BESS-Outbound-Spam-Status: SCORE=0.20 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, PR0N_SUBJECT
X-BESS-BRTS-Status: 1
Return-Path: <Marcin.Nowakowski@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@mips.com
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

Hi Mathieu,

On 31.01.2018 08:47, Mathieu Malaterre wrote:

> Since it's been a week, could you confirm the patch is ok as-is or do
> you think some comment(s) from James should be incorporated ?

I'll prepare an updated patch that includes James' suggestions - I think 
they will lead to an overall cleaner (and probably slightly smaller) code.

Marcin


> On Tue, Jan 23, 2018 at 3:17 PM, James Hogan <jhogan@kernel.org> wrote:
>> On Thu, Dec 21, 2017 at 10:00:59PM +0100, Mathieu Malaterre wrote:
>>> From: Marcin Nowakowski <marcin.nowakowski@mips.com>
>>>
>>> Change 73fbc1eba7ff added a fix to ensure that the memory range between
>>
>> Please refer to commits with e.g. commit 73fbc1eba7ff ("MIPS: fix
>> mem=X@Y commandline processing").
>>
>>> PHYS_OFFSET and low memory address specified by mem= cmdline argument is
>>> not later processed by free_all_bootmem.
>>> This change was incorrect for systems where the commandline specifies
>>> more than 1 mem argument, as it will cause all memory between
>>> PHYS_OFFSET and each of the memory offsets to be marked as reserved,
>>> which results in parts of the RAM marked as reserved (Creator CI20's
>>> u-boot has a default commandline argument 'mem=256M@0x0
>>> mem=768M@0x30000000').
>>>
>>> Change the behaviour to ensure that only the range between PHYS_OFFSET
>>> and the lowest start address of the memories is marked as protected.
>>>
>>> This change also ensures that the range is marked protected even if it's
>>> only defined through the devicetree and not only via commandline
>>> arguments.
>>>
>>> Reported-by: Mathieu Malaterre <mathieu.malaterre@gmail.com>
>>> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@mips.com>
>>> Fixes: 73fbc1eba7ff ("MIPS: fix mem=X@Y commandline processing")
>>> Cc: <stable@vger.kernel.org> # v4.11
>>
>> I'm guessing that should technically be v4.11+
> 
> My fault, if this is the only change, I can re-submit.
> 
>>> ---
>>> v2: Use updated email adress, add tag for stable.
>>>   arch/mips/kernel/setup.c | 19 ++++++++++++++++---
>>>   1 file changed, 16 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
>>> index 702c678de116..f19d61224c71 100644
>>> --- a/arch/mips/kernel/setup.c
>>> +++ b/arch/mips/kernel/setup.c
>>> @@ -375,6 +375,7 @@ static void __init bootmem_init(void)
>>>        unsigned long reserved_end;
>>>        unsigned long mapstart = ~0UL;
>>>        unsigned long bootmap_size;
>>> +     phys_addr_t ramstart = ~0UL;
>>
>> Although practically it might not matter, technically phys_addr_t may be
>> 64-bits (CONFIG_PHYS_ADDR_T_64BIT) even on a 32-bit kernels, in which
>> case ~0UL may not be sufficiently large.
>>
>> Maybe that should be ~(phys_addr_t)0, or perhaps (phys_addr_t)ULLONG_MAX
>> to match add_memory_region().
>>
>>>        bool bootmap_valid = false;
>>>        int i;
>>>
>>> @@ -395,6 +396,21 @@ static void __init bootmem_init(void)
>>>        max_low_pfn = 0;
>>>
>>>        /*
>>> +      * Reserve any memory between the start of RAM and PHYS_OFFSET
>>> +      */
>>> +     for (i = 0; i < boot_mem_map.nr_map; i++) {
>>> +             if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
>>> +                     continue;
>>> +
>>> +             ramstart = min(ramstart, boot_mem_map.map[i].addr);
>>
>> Is it worth incorporating this into the existing loop below ...
>>
>>> +     }
>>> +
>>> +     if (ramstart > PHYS_OFFSET)
>>> +             add_memory_region(PHYS_OFFSET, ramstart - PHYS_OFFSET,
>>> +                               BOOT_MEM_RESERVED);
>>
>> ... and this then placed below that loop?
>>
>> Otherwise I can't find fault with this patch, though i'm not intimately
>> familiar with bootmem.
>>
>> Cheers
>> James
>>
>>> +
>>> +
>>> +     /*
>>>         * Find the highest page frame number we have available.
>>>         */
>>>        for (i = 0; i < boot_mem_map.nr_map; i++) {
>>> @@ -664,9 +680,6 @@ static int __init early_parse_mem(char *p)
>>>
>>>        add_memory_region(start, size, BOOT_MEM_RAM);
>>>
>>> -     if (start && start > PHYS_OFFSET)
>>> -             add_memory_region(PHYS_OFFSET, start - PHYS_OFFSET,
>>> -                             BOOT_MEM_RESERVED);
>>>        return 0;
>>>   }
>>>   early_param("mem", early_parse_mem);
>>> --
>>> 2.11.0
>>>
