Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2017 07:44:35 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17054 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990644AbdIOFo0SdtwQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Sep 2017 07:44:26 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id DF7CFFFF660D7;
        Fri, 15 Sep 2017 06:44:16 +0100 (IST)
Received: from [10.80.2.5] (10.80.2.5) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 15 Sep
 2017 06:44:18 +0100
Subject: Re: [PATCH for 4.9 11/59] MIPS: fix mem=X@Y commandline processing
To:     Mathieu Malaterre <malat@debian.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
References: <20170914155051.8289-1-alexander.levin@verizon.com>
 <20170914155051.8289-11-alexander.levin@verizon.com>
 <CA+7wUszvyofkuLPb6K+E5ngJ7=e0CiCh1s+WQUBX0cG_MfnU7w@mail.gmail.com>
 <20170914191119.y554znlpcnsershp@sasha-lappy>
 <CA+7wUsy7X_3ST0hgnyxWMiC45ZeM8A_oafzn9PuufETkcKN+Xw@mail.gmail.com>
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <7c4d02d8-3d96-3471-89b2-dba606367218@imgtec.com>
Date:   Fri, 15 Sep 2017 07:44:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CA+7wUsy7X_3ST0hgnyxWMiC45ZeM8A_oafzn9PuufETkcKN+Xw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

Hi,

On 14.09.2017 21:17, Mathieu Malaterre wrote:
> On Thu, Sep 14, 2017 at 9:11 PM, Levin, Alexander (Sasha Levin)
> <alexander.levin@verizon.com> wrote:
>> On Thu, Sep 14, 2017 at 08:59:05PM +0200, Mathieu Malaterre wrote:
>>> On Thu, Sep 14, 2017 at 5:51 PM, Levin, Alexander (Sasha Levin)
>>> <alexander.levin@verizon.com> wrote:
>>>> From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
>>>>
>>>> [ Upstream commit 73fbc1eba7ffa3bf0ad12486232a8a1edb4e4411 ]
>>>>
>>>> When a memory offset is specified through the commandline, add the
>>>> memory in range PHYS_OFFSET:Y as reserved memory area.
>>>> Otherwise the bootmem allocator is initialised with low page equal to
>>>> min_low_pfn = PHYS_OFFSET, and in free_all_bootmem will process pages
>>>> starting from min_low_pfn instead of PFN(Y).
>>>>
>>>> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
>>>> Cc: linux-mips@linux-mips.org
>>>> Patchwork: https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.linux-2Dmips.org_patch_14613_&d=DwIBaQ&c=udBTRvFvXC5Dhqg7UHpJlPps3mZ3LRxpb6__0PomBTQ&r=bUtaaC9mlBij4OjEG_D-KPul_335azYzfC4Rjgomobo&m=6siOw0e29CYMhuJcboVwEeX-LcC1yJjtnGPVl_1tClQ&s=rP-QGn8HHjuow4b4qd6sfl_EEPoAKkxAffkh1zEq-kc&e=
>>>> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>>>> Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
>>>> ---
>>>>   arch/mips/kernel/setup.c | 4 ++++
>>>>   1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
>>>> index f66e5ce505b2..38697f25d168 100644
>>>> --- a/arch/mips/kernel/setup.c
>>>> +++ b/arch/mips/kernel/setup.c
>>>> @@ -589,6 +589,10 @@ static int __init early_parse_mem(char *p)
>>>>                  start = memparse(p + 1, &p);
>>>>
>>>>          add_memory_region(start, size, BOOT_MEM_RAM);
>>>> +
>>>> +       if (start && start > PHYS_OFFSET)
>>>> +               add_memory_region(PHYS_OFFSET, start - PHYS_OFFSET,
>>>> +                               BOOT_MEM_RESERVED);
>>>>          return 0;
>>>>   }
>>>>   early_param("mem", early_parse_mem);
>>>
>>> Does not work on MIPS Creator CI20. See:
>>
>> Hm, so upstream is actually broken right now?
> 
> Yes, at least on Creator CI20. You need to clear out all your mem=X@Y
> from your boot command line, or apply the new patch I mentionned
> above, or revert 73fbc1eba7ffa3bf0ad12486232a8a1edb4e4411.

Yes, there is this issue that Mathieu discovered that upstream suffers 
from. My patch that fixes it has not yet been merged - but hopefully 
will be included in the next release.
Luckily the issue is only seen with a specific set of commandline 
arguments which are not even required - but are set as defaults by the 
CI20 bootloader.

For this reason it's probably better not to include this patch in the 
stable series without the followup fix (without it the kernel is also 
subtly broken, just in a different way and that fault is less likely to 
be seen by the users).

Marcin
