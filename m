Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jul 2016 21:39:29 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48728 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993415AbcGKTjWWGuFs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jul 2016 21:39:22 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 78D471BB5698C;
        Mon, 11 Jul 2016 20:39:02 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 11 Jul
 2016 20:39:05 +0100
Received: from [10.20.2.61] (10.20.2.61) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 11 Jul
 2016 12:39:03 -0700
Message-ID: <5783F5D7.2090804@imgtec.com>
Date:   Mon, 11 Jul 2016 12:39:03 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     <yhb@ruijie.com.cn>, <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: We need to clear MMU contexts of all other processes
 when asid_cache(cpu) wraps to 0.
References: <80B78A8B8FEE6145A87579E8435D78C30205D5F3@fzex.ruijie.com.cn> <5783DF18.1080408@imgtec.com> <20160711180755.GA29839@jhogan-linux.le.imgtec.org> <5783E332.2020503@imgtec.com> <20160711192121.GC26799@jhogan-linux.le.imgtec.org>
In-Reply-To: <20160711192121.GC26799@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.2.61]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54289
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

On 07/11/2016 12:21 PM, James Hogan wrote:
> On Mon, Jul 11, 2016 at 11:19:30AM -0700, Leonid Yegoshin wrote:
>> On 07/11/2016 11:07 AM, James Hogan wrote:
>>>
>> Not exactly. The change must be done only for local CPU which executes
>> at the moment get_new_mmu_context(). Just prevent preemption here and
>> change of cpu_context(THIS_CPU,...) can be done safely - other CPUs
>> don't do anything with this variable besides killing it (writing 0 to it).
> Right, but I was thinking more along the lines of whether you can ensure
> the other tasks / mm continues to exist. I think this is partly achieved
> by the read_lock'ing of tasklist_lock, but also possibly by the
> find_lock_task_mm() call, which has a comment saying:
>
> /*
>   * The process p may have detached its own ->mm while exiting or through
>   * use_mm(), but one or more of its subthreads may still have a valid
>   * pointer.  Return p, or any of its subthreads with a valid ->mm, with
>   * task_lock() held.
>   */
>
> (but of course I could be mistaken and something else guarantees it
> won't go away).
I don't look into details of that but a safe way to do is - walk through 
all memory maps and lock it before change.

And to walk through memory maps we could use something like 
'find_lock_task_mm' but if there is a concern like you stated above then 
we could walk through all subthreads of task or just through all threads 
in system - anywhere, this even (ASID wrap) is pretty rare.

The advantage is in keeping all that stuff local and avoid patching 
other arch and common code.

>
> Note also that I have a patch I'm about to submit which changes some of
> those assignments of 0 to assign 1 instead (so as not to confuse the
> cache management code into thinking the CPU has never run the code when
> it has, while still triggering ASID regeneration). That applies here
> too, so it should perhaps be doing something like this instead:
>
> if (t->mm != mm && cpu_context(cpu, t->mm))
> 	cpu_context(cpu, t->mm) = 1;
Not sure, but did you have chance to look into having another variable 
for cache flush control? It can be that some more states may be needed 
in future, so - just disjoin both, TLB and cache coontrol.

- Leonid.

>
> Cheers
> James
>
>> You can look into flush_tlb_mm() for example how it is cleared for
>> single memory map.
>>
>> We have a macro to safely walk all processes, right? (don't remember
>> it's name).
>>
>>
