Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Aug 2017 15:24:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28810 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993964AbdH3NYMeM5zv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Aug 2017 15:24:12 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 72551820DF98;
        Wed, 30 Aug 2017 14:24:02 +0100 (IST)
Received: from [10.150.130.83] (10.150.130.83) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 30 Aug
 2017 14:24:05 +0100
Subject: Re: [PATCH] MIPS: Revert "MIPS: Fix race on setting and getting
 cpu_online_mask"
To:     Huacai Chen <chenhuacai@gmail.com>,
        Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
References: <1503476475-21069-1-git-send-email-matt.redfearn@imgtec.com>
 <71ea8331-78da-c22b-d46d-99ab6c187bbf@nokia.com>
 <CAAhV-H7z82vsvdDc6Hfbp62KM6q72Z_bg6eUFdbK0azU2zmseg@mail.gmail.com>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <7e9037a6-195b-ca0f-75da-5a338c5e938d@imgtec.com>
Date:   Wed, 30 Aug 2017 14:24:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7z82vsvdDc6Hfbp62KM6q72Z_bg6eUFdbK0azU2zmseg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Hi Huacai,

On 29/08/17 02:43, Huacai Chen wrote:
> I suggest to drop sync_r4k completely, because it is inaccurate. You
> can use IPI to synchronize count/compare instead, as Loongson-3 does.

I am all for a better fix, such as this - but that would be a much more 
invasive change than what I propose. Currently 4.13 is broken by the 
patch that this is attempting to revert. It is easy to deadlock the 
system by hotplugging a CPU while it is busy. That was what my patch 
8f46cca1e6c06 originally fixed. Even though it is, perhaps, not 
stylistically great to have the synchronisation done by callers, the 
fact is that it *is* done (added in 8df3e07e7f21f), so the behavior for 
4.13 would be safe and deadlocks not possible. We can then look at more 
invasive changes that are acceptable to everyone during the 4.14 cycle.

Thanks,
Matt

>
> Huacai
>
> On Mon, Aug 28, 2017 at 6:07 PM, Matija Glavinic Pecotic
> <matija.glavinic-pecotic.ext@nokia.com> wrote:
>> On 08/23/2017 10:21 AM, Matt Redfearn wrote:
>>> As noted in the commit message, upstream differs in this area. The
>>> hotplug code now waits on a completion event in bringup_wait_for_ap,
>>> which is set by the starting CPU in cpuhp_online_idle once it calls
>>> cpu_startup_entry. Thus there is no possibility of a race in upstream,
>>> and this commit has only re-introduced the deadlock condition, which can
>>> be observed on multiple platforms when running a heavy load test at the
>>> same time as hotplugging CPUs. See commit 8f46cca1e6c06 ("MIPS: SMP: Fix
>>> possibility of deadlock when bringing CPUs online") for details.
>> I personally do not like the fact that synchronization is implicitly done by the callers, it is the reason why the patch was proposed. As noted before, it is enough someone checks cpu online mask somewhere in between and there is race again.
>>
>> How about moving synchronise_count_slave before setting the cpu online? Is there dependency it has to be done after completion?
>>
>> Regards,
>>
>> Matija
>>
