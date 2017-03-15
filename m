Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 08:24:25 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45761 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992028AbdCOHYSrHuJF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Mar 2017 08:24:18 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 2BE8BB13655EB;
        Wed, 15 Mar 2017 07:24:10 +0000 (GMT)
Received: from [10.80.2.5] (10.80.2.5) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 15 Mar
 2017 07:24:11 +0000
Subject: Re: [PATCH 0/2] cpu-features.h rename
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1489412018-30387-1-git-send-email-marcin.nowakowski@imgtec.com>
 <f5870aae-0974-6213-2499-bbfb365cf063@gmail.com>
 <be773311-fb5b-949e-378e-09db2baa8cd4@imgtec.com>
 <20170314082906.GG26432@linux-mips.org>
 <d1b970e6-f87e-3e35-7c74-7fc0a6a4c0f2@imgtec.com>
 <80d2de6c-2196-5851-ebd6-308be40ea78f@gmail.com>
CC:     <linux-mips@linux-mips.org>
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <bf7bb5eb-abeb-7ac5-3610-2a9ce6ad3f66@imgtec.com>
Date:   Wed, 15 Mar 2017 08:24:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <80d2de6c-2196-5851-ebd6-308be40ea78f@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57281
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

Hi Florian,

On 15.03.2017 03:04, Florian Fainelli wrote:
>
>
> On 03/14/2017 01:45 AM, Marcin Nowakowski wrote:
>> Hi Ralf,
>>
>> On 14.03.2017 09:29, Ralf Baechle wrote:
>>> On Tue, Mar 14, 2017 at 08:40:21AM +0100, Marcin Nowakowski wrote:
>>>
>>>> On 13.03.2017 18:08, Florian Fainelli wrote:
>>>>> On 03/13/2017 06:33 AM, Marcin Nowakowski wrote:
>>>>>> Since the introduction of GENERIC_CPU_AUTOPROBE
>>>>>> (https://patchwork.linux-mips.org/patch/15395/) we've got 2 very
>>>>>> similarily
>>>>>> named headers: cpu-features.h and cpufeature.h.
>>>>>> Since the latter is used by all platforms that implement
>>>>>> GENERIC_CPU_AUTOPROBE functionality, it's better to rename the
>>>>>> MIPS-specific
>>>>>> cpu-features.h.
>>>>>>
>>>>>> Marcin Nowakowski (2):
>>>>>>   MIPS: mach-rm: Remove recursive include of cpu-feature-overrides.h
>>>>>>   MIPS: rename cpu-features.h -> cpucaps.h
>>>>>
>>>>> That's a lot of churn that could cause some good headaches in
>>>>> backporting stable changes affecting cpu-feature-overrides.h.
>>>>>
>>>>> Can we just do the cpu-features.h -> cpucaps.h rename and keep
>>>>> cpu-feature-overrides.h around?
>>>>
>>>> That's of course possible, but I think it would make the naming quite
>>>> confusing as well, as it would be very unclear for any reader as to
>>>> why a
>>>> 'cpu-feature-overrides' overrides 'cpucaps'.
>>>>
>>>> I've looked at the change history of these files and most receive very
>>>> little updates (which is hardly surprising given the changes are done
>>>> mostly
>>>> during initial integration of a new cpu or soon after), and none of the
>>>> changes in those files were marked for stable. I think it's safe to
>>>> assume
>>>> that this pattern is not likely to change, would you agree?
>>>
>>> I've noticed the same pattern - and it's a little concerning.  Not adding
>>> values for later features means the'll probably be runtime detected
>>> resulting in a bigger, slower kernel.
>>
>> But that is a type of optimisation that may (should?) be done when new
>> features are added, which in most cases doesn't make it a candidate for
>> backporting to stable.
>
> You may be fixing actual bugs by patching this file, e.g: selecting the
> correct value for e.g: cpu_has_dc_aliases, cpu_has_ic_fills_ic,
> cpu_dcache_line_size() and so on. Ideally every feature in there has
> been properly set/cleared in arch/mips/kernel/cpu-probe.c but there
> could be platform relying exclusively on cpu-feature-overrides.h to
> provide the correct value.

Yes, of course that is possible and I'm not dismissing that fact.
I've only stated that looking at the git history of these files (which 
dates back to 2008 when they were moved from a different location), 
there have been only a few changes to them and most of the changes were 
not bugfixes for specific cores but general code changes applied 
throughout the tree.
So in an unlikely case that a bug is discovered that will be fixed by 
updating a specific cpu(caps|feature)-override.h, there would be a 
slightly increased effort required to backport the patch due to a 
filename difference, but IMO that's hardly a reason to prevent any 
changes and to keep the filenames inconsistent?
It's not like I'm changing the whole logic behind cpu_has functionality ...


> If not about the backport argument, just changing that many files at
> once (have they actually been build tested at least?)

I have build-tested this with some defconfigs affected.

> just does not seem
> practical nor worth it to me.

I think having a sensible file naming scheme is worth the change and 
you seem to see this change as a much bigger one than I do. From my 
perspective this change is a really trivial one.


> Just put a big fat disclaimer: this is not
> to be conflated with cpucaps.h (and vice versa).

But I'm not in any way changing the behaviour or meaning of these files. 
They are exactly as they have been for the past 10 (or more) years ... 
it's just a change of name.


Marcin
