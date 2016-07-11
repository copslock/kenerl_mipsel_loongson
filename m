Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jul 2016 20:19:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43034 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993368AbcGKSTtyVDLV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jul 2016 20:19:49 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 3E95F2092226E;
        Mon, 11 Jul 2016 19:19:30 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 11 Jul
 2016 19:19:33 +0100
Received: from [10.20.2.61] (10.20.2.61) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 11 Jul
 2016 11:19:30 -0700
Message-ID: <5783E332.2020503@imgtec.com>
Date:   Mon, 11 Jul 2016 11:19:30 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     <yhb@ruijie.com.cn>, <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: We need to clear MMU contexts of all other processes
 when asid_cache(cpu) wraps to 0.
References: <80B78A8B8FEE6145A87579E8435D78C30205D5F3@fzex.ruijie.com.cn> <5783DF18.1080408@imgtec.com> <20160711180755.GA29839@jhogan-linux.le.imgtec.org>
In-Reply-To: <20160711180755.GA29839@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.2.61]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 07/11/2016 11:07 AM, James Hogan wrote:
> Hi Leonid,
>
> On Mon, Jul 11, 2016 at 11:02:00AM -0700, Leonid Yegoshin wrote:
>> On 07/10/2016 06:04 AM, yhb@ruijie.com.cn wrote:
>>> Subject: [PATCH] MIPS: We need to clear MMU contexts of all other processes
>>>    when asid_cache(cpu) wraps to 0.
>>>
>>> Suppose that asid_cache(cpu) wraps to 0 every n days.
>>> case 1:
>>> (1)Process 1 got ASID 0x101.
>>> (2)Process 1 slept for n days.
>>> (3)asid_cache(cpu) wrapped to 0x101, and process 2 got ASID 0x101.
>>> (4)Process 1 is woken,and ASID of process 1 is same as ASID of process 2.
>>>
>>> case 2:
>>> (1)Process 1 got ASID 0x101 on CPU 1.
>>> (2)Process 1 migrated to CPU 2.
>>> (3)Process 1 migrated to CPU 1 after n days.
>>> (4)asid_cache on CPU 1 wrapped to 0x101, and process 2 got ASID 0x101.
>>> (5)Process 1 is scheduled, and ASID of process 1 is same as ASID of process 2.
>>>
>>> So we need to clear MMU contexts of all other processes when asid_cache(cpu) wraps to 0.
>>>
>>> Signed-off-by: yhb <yhb@ruijie.com.cn>
>>>
>> I think a more clear description should be given here - there is no
>> indication that wrap happens over 32bit integer.
>>
>> And taking into account "n days" frequency - can we just kill all local
>> ASIDs in all processes (additionally to local_flush_tlb_all) and enforce
>> reassignment if wrap happens? It should be a very rare event, you are
>> first to hit this.
>>
>> It seems to be some localized stuff in get_new_mmu_context() instead of
>> widespread patching.
> That is what this patch does, but to do so it appears you need to lock
> the other tasks one by one, and that must be doable from a context
> switch, i.e. hardirq context, and that requires the task lock to be of
> the _irqsave variant, hence the widespread changes and the relatively
> tiny MIPS change hidden in the middle.
>
Not exactly. The change must be done only for local CPU which executes 
at the moment get_new_mmu_context(). Just prevent preemption here and 
change of cpu_context(THIS_CPU,...) can be done safely - other CPUs 
don't do anything with this variable besides killing it (writing 0 to it).

You can look into flush_tlb_mm() for example how it is cleared for 
single memory map.

We have a macro to safely walk all processes, right? (don't remember 
it's name).
