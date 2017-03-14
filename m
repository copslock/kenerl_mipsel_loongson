Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 08:40:36 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29430 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993543AbdCNHk3scmBJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 08:40:29 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 0E91FE94CDC93;
        Tue, 14 Mar 2017 07:40:20 +0000 (GMT)
Received: from [10.80.2.5] (10.80.2.5) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 14 Mar
 2017 07:40:22 +0000
Subject: Re: [PATCH 0/2] cpu-features.h rename
To:     Florian Fainelli <f.fainelli@gmail.com>, <ralf@linux-mips.org>
References: <1489412018-30387-1-git-send-email-marcin.nowakowski@imgtec.com>
 <f5870aae-0974-6213-2499-bbfb365cf063@gmail.com>
CC:     <linux-mips@linux-mips.org>
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <be773311-fb5b-949e-378e-09db2baa8cd4@imgtec.com>
Date:   Tue, 14 Mar 2017 08:40:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <f5870aae-0974-6213-2499-bbfb365cf063@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57197
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

On 13.03.2017 18:08, Florian Fainelli wrote:
> On 03/13/2017 06:33 AM, Marcin Nowakowski wrote:
>> Since the introduction of GENERIC_CPU_AUTOPROBE
>> (https://patchwork.linux-mips.org/patch/15395/) we've got 2 very similarily
>> named headers: cpu-features.h and cpufeature.h.
>> Since the latter is used by all platforms that implement
>> GENERIC_CPU_AUTOPROBE functionality, it's better to rename the MIPS-specific
>> cpu-features.h.
>>
>> Marcin Nowakowski (2):
>>   MIPS: mach-rm: Remove recursive include of cpu-feature-overrides.h
>>   MIPS: rename cpu-features.h -> cpucaps.h
>
> That's a lot of churn that could cause some good headaches in
> backporting stable changes affecting cpu-feature-overrides.h.
>
> Can we just do the cpu-features.h -> cpucaps.h rename and keep
> cpu-feature-overrides.h around?

That's of course possible, but I think it would make the naming quite 
confusing as well, as it would be very unclear for any reader as to why 
a 'cpu-feature-overrides' overrides 'cpucaps'.

I've looked at the change history of these files and most receive very 
little updates (which is hardly surprising given the changes are done 
mostly during initial integration of a new cpu or soon after), and none 
of the changes in those files were marked for stable. I think it's safe 
to assume that this pattern is not likely to change, would you agree?

Marcin

>>
>>  arch/mips/dec/setup.c                                             | 2 +-
>>  arch/mips/dec/time.c                                              | 2 +-
>>  arch/mips/include/asm/atomic.h                                    | 2 +-
>>  arch/mips/include/asm/bitops.h                                    | 2 +-
>>  arch/mips/include/asm/branch.h                                    | 2 +-
>>  arch/mips/include/asm/cacheflush.h                                | 2 +-
>>  arch/mips/include/asm/{cpu-features.h => cpucaps.h}               | 8 ++++----
>>  arch/mips/include/asm/dsp.h                                       | 2 +-
>>  arch/mips/include/asm/fpu.h                                       | 2 +-
>>  arch/mips/include/asm/highmem.h                                   | 2 +-
>>  arch/mips/include/asm/io.h                                        | 2 +-
>>  .../mach-ath25/{cpu-feature-overrides.h => cpucaps-overrides.h}   | 8 ++++----
>>  .../mach-ath79/{cpu-feature-overrides.h => cpucaps-overrides.h}   | 8 ++++----
>>  .../mach-au1x00/{cpu-feature-overrides.h => cpucaps-overrides.h}  | 6 +++---
>>  .../mach-bcm47xx/{cpu-feature-overrides.h => cpucaps-overrides.h} | 6 +++---
>>  .../mach-bcm63xx/{cpu-feature-overrides.h => cpucaps-overrides.h} | 6 +++---
>>  .../mach-bmips/{cpu-feature-overrides.h => cpucaps-overrides.h}   | 6 +++---
>>  .../{cpu-feature-overrides.h => cpucaps-overrides.h}              | 4 ++--
>>  .../mach-cobalt/{cpu-feature-overrides.h => cpucaps-overrides.h}  | 6 +++---
>>  .../asm/mach-dec/{cpu-feature-overrides.h => cpucaps-overrides.h} | 6 +++---
>>  .../mach-generic/{cpu-feature-overrides.h => cpucaps-overrides.h} | 6 +++---
>>  .../mach-ip22/{cpu-feature-overrides.h => cpucaps-overrides.h}    | 6 +++---
>>  .../mach-ip27/{cpu-feature-overrides.h => cpucaps-overrides.h}    | 6 +++---
>>  .../mach-ip28/{cpu-feature-overrides.h => cpucaps-overrides.h}    | 6 +++---
>>  .../mach-ip32/{cpu-feature-overrides.h => cpucaps-overrides.h}    | 6 +++---
>>  .../mach-jz4740/{cpu-feature-overrides.h => cpucaps-overrides.h}  | 4 ++--
>>  .../falcon/{cpu-feature-overrides.h => cpucaps-overrides.h}       | 8 ++++----
>>  .../{cpu-feature-overrides.h => cpucaps-overrides.h}              | 6 +++---
>>  .../mach-malta/{cpu-feature-overrides.h => cpucaps-overrides.h}   | 6 +++---
>>  .../{cpu-feature-overrides.h => cpucaps-overrides.h}              | 6 +++---
>>  .../{cpu-feature-overrides.h => cpucaps-overrides.h}              | 6 +++---
>>  .../mach-pic32/{cpu-feature-overrides.h => cpucaps-overrides.h}   | 6 +++---
>>  .../{cpu-feature-overrides.h => cpucaps-overrides.h}              | 6 +++---
>>  .../mt7620/{cpu-feature-overrides.h => cpucaps-overrides.h}       | 8 ++++----
>>  .../mt7621/{cpu-feature-overrides.h => cpucaps-overrides.h}       | 8 ++++----
>>  .../rt288x/{cpu-feature-overrides.h => cpucaps-overrides.h}       | 8 ++++----
>>  .../rt305x/{cpu-feature-overrides.h => cpucaps-overrides.h}       | 8 ++++----
>>  .../rt3883/{cpu-feature-overrides.h => cpucaps-overrides.h}       | 8 ++++----
>>  .../mach-rc32434/{cpu-feature-overrides.h => cpucaps-overrides.h} | 8 ++++----
>>  .../asm/mach-rm/{cpu-feature-overrides.h => cpucaps-overrides.h}  | 8 +++-----
>>  .../mach-sibyte/{cpu-feature-overrides.h => cpucaps-overrides.h}  | 6 +++---
>>  .../mach-tx49xx/{cpu-feature-overrides.h => cpucaps-overrides.h}  | 6 +++---
>>  arch/mips/include/asm/r4kcache.h                                  | 2 +-
>>  arch/mips/include/asm/switch_to.h                                 | 2 +-
>>  arch/mips/include/asm/timex.h                                     | 2 +-
>>  arch/mips/include/asm/tlb.h                                       | 2 +-
>>  arch/mips/kernel/branch.c                                         | 2 +-
>>  arch/mips/kernel/cpu-probe.c                                      | 2 +-
>>  arch/mips/kernel/elf.c                                            | 2 +-
>>  arch/mips/kernel/proc.c                                           | 2 +-
>>  arch/mips/kernel/signal.c                                         | 2 +-
>>  arch/mips/kernel/signal_n32.c                                     | 2 +-
>>  arch/mips/kernel/smp-bmips.c                                      | 2 +-
>>  arch/mips/kernel/sysrq.c                                          | 2 +-
>>  arch/mips/kernel/time.c                                           | 2 +-
>>  arch/mips/kernel/uprobes.c                                        | 2 +-
>>  arch/mips/mm/c-octeon.c                                           | 2 +-
>>  arch/mips/mm/c-r4k.c                                              | 2 +-
>>  arch/mips/mm/cache.c                                              | 2 +-
>>  arch/mips/mm/gup.c                                                | 2 +-
>>  arch/mips/net/bpf_jit.c                                           | 2 +-
>>  arch/mips/netlogic/common/time.c                                  | 2 +-
>>  arch/mips/pistachio/irq.c                                         | 2 +-
>>  63 files changed, 135 insertions(+), 137 deletions(-)
>>  rename arch/mips/include/asm/{cpu-features.h => cpucaps.h} (99%)
>>  rename arch/mips/include/asm/mach-ath25/{cpu-feature-overrides.h => cpucaps-overrides.h} (86%)
>>  rename arch/mips/include/asm/mach-ath79/{cpu-feature-overrides.h => cpucaps-overrides.h} (85%)
>>  rename arch/mips/include/asm/mach-au1x00/{cpu-feature-overrides.h => cpucaps-overrides.h} (91%)
>>  rename arch/mips/include/asm/mach-bcm47xx/{cpu-feature-overrides.h => cpucaps-overrides.h} (93%)
>>  rename arch/mips/include/asm/mach-bcm63xx/{cpu-feature-overrides.h => cpucaps-overrides.h} (87%)
>>  rename arch/mips/include/asm/mach-bmips/{cpu-feature-overrides.h => cpucaps-overrides.h} (64%)
>>  rename arch/mips/include/asm/mach-cavium-octeon/{cpu-feature-overrides.h => cpucaps-overrides.h} (94%)
>>  rename arch/mips/include/asm/mach-cobalt/{cpu-feature-overrides.h => cpucaps-overrides.h} (90%)
>>  rename arch/mips/include/asm/mach-dec/{cpu-feature-overrides.h => cpucaps-overrides.h} (95%)
>>  rename arch/mips/include/asm/mach-generic/{cpu-feature-overrides.h => cpucaps-overrides.h} (61%)
>>  rename arch/mips/include/asm/mach-ip22/{cpu-feature-overrides.h => cpucaps-overrides.h} (88%)
>>  rename arch/mips/include/asm/mach-ip27/{cpu-feature-overrides.h => cpucaps-overrides.h} (92%)
>>  rename arch/mips/include/asm/mach-ip28/{cpu-feature-overrides.h => cpucaps-overrides.h} (88%)
>>  rename arch/mips/include/asm/mach-ip32/{cpu-feature-overrides.h => cpucaps-overrides.h} (89%)
>>  rename arch/mips/include/asm/mach-jz4740/{cpu-feature-overrides.h => cpucaps-overrides.h} (92%)
>>  rename arch/mips/include/asm/mach-lantiq/falcon/{cpu-feature-overrides.h => cpucaps-overrides.h} (85%)
>>  rename arch/mips/include/asm/mach-loongson64/{cpu-feature-overrides.h => cpucaps-overrides.h} (89%)
>>  rename arch/mips/include/asm/mach-malta/{cpu-feature-overrides.h => cpucaps-overrides.h} (92%)
>>  rename arch/mips/include/asm/mach-netlogic/{cpu-feature-overrides.h => cpucaps-overrides.h} (88%)
>>  rename arch/mips/include/asm/mach-paravirt/{cpu-feature-overrides.h => cpucaps-overrides.h} (83%)
>>  rename arch/mips/include/asm/mach-pic32/{cpu-feature-overrides.h => cpucaps-overrides.h} (82%)
>>  rename arch/mips/include/asm/mach-pmcs-msp71xx/{cpu-feature-overrides.h => cpucaps-overrides.h} (76%)
>>  rename arch/mips/include/asm/mach-ralink/mt7620/{cpu-feature-overrides.h => cpucaps-overrides.h} (87%)
>>  rename arch/mips/include/asm/mach-ralink/mt7621/{cpu-feature-overrides.h => cpucaps-overrides.h} (88%)
>>  rename arch/mips/include/asm/mach-ralink/rt288x/{cpu-feature-overrides.h => cpucaps-overrides.h} (87%)
>>  rename arch/mips/include/asm/mach-ralink/rt305x/{cpu-feature-overrides.h => cpucaps-overrides.h} (87%)
>>  rename arch/mips/include/asm/mach-ralink/rt3883/{cpu-feature-overrides.h => cpucaps-overrides.h} (86%)
>>  rename arch/mips/include/asm/mach-rc32434/{cpu-feature-overrides.h => cpucaps-overrides.h} (90%)
>>  rename arch/mips/include/asm/mach-rm/{cpu-feature-overrides.h => cpucaps-overrides.h} (84%)
>>  rename arch/mips/include/asm/mach-sibyte/{cpu-feature-overrides.h => cpucaps-overrides.h} (87%)
>>  rename arch/mips/include/asm/mach-tx49xx/{cpu-feature-overrides.h => cpucaps-overrides.h} (74%)
>>
>
>
