Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2016 12:17:26 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3587 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992866AbcF3KRURK7v0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Jun 2016 12:17:20 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 2CB971AFE048A;
        Thu, 30 Jun 2016 11:17:11 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 30 Jun 2016 11:17:13 +0100
Received: from [127.0.0.1] (10.100.200.138) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 30 Jun
 2016 11:17:13 +0100
Subject: Re: [RFC PATCH v3 1/2] MIPS: use per-mm page to execute branch delay
 slot instructions
To:     Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
References: <20160629143830.526-1-paul.burton@imgtec.com>
 <20160629143830.526-2-paul.burton@imgtec.com> <5774DFDC.4000607@imgtec.com>
CC:     Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        Matthew Fortune <matthew.fortune@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>
From:   Paul Burton <paul.burton@imgtec.com>
Message-ID: <9c74a08a-afbb-68c6-e022-a4f01713f01c@imgtec.com>
Date:   Thu, 30 Jun 2016 11:17:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <5774DFDC.4000607@imgtec.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.100.200.138]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On 30/06/16 10:01, Matt Redfearn wrote:
> Hi Paul

Hi Matt :)

>> @@ -128,6 +129,11 @@ init_new_context(struct task_struct *tsk, struct
>> mm_struct *mm)
>>         atomic_set(&mm->context.fp_mode_switching, 0);
>>   +    mm->context.bd_emupage = 0;
>> +    mm->context.bd_emupage_allocmap = NULL;
>> +    mutex_init(&mm->context.bd_emupage_mutex);
>> +    init_waitqueue_head(&mm->context.bd_emupage_queue);
>> +
>
> Should this be wrapped in a CONFIG? We're introducing overhead to every
> tsk creation even if we won't be making use of the emulation.

Since this is used by the FPU emulator, which we always include in the 
kernel, no I'd say not. The overhead here should be very small - all the 
actual memory allocation & book-keeping is left until a delay slot 
emulation is actually performed, we're effectively just setting some 
variables to sane & constant initial values here.

In order to guarantee that we don't use this code we'd need to guarantee 
that we don't use the FPU emulator (or MIPSr2 emulation on a MIPSr6 
system) and right now at least there is no way for us to do that. We 
could add an option to build the kernel without the emulator, but then 
we'd have issues even if we run on a system with an FPU that doesn't 
implement certain operations (eg. denormals), so in practice I think 
that would mean we'd be much better with an option to disable use of FP 
entirely. That is probably something it would be useful to have anyway 
for people who know their userland is entirely soft-float, but it's not 
something I think this patch should do.

>>   @@ -162,6 +168,7 @@ static inline void switch_mm(struct mm_struct
>> *prev, struct mm_struct *next,
>>    */
>>   static inline void destroy_context(struct mm_struct *mm)
>>   {
>> +    dsemul_mm_cleanup(mm);
> Ditto.

Likewise.

>>   -#define STACK_TOP    (TASK_SIZE & PAGE_MASK)
>> +/*
>> + * One page above the stack is used for branch delay slot "emulation".
>> + * See dsemul.c for details.
>> + */
>> +#define STACK_TOP    ((TASK_SIZE & PAGE_MASK) - PAGE_SIZE)
>
> Again, should this be dependent on config? Otherwise we waste a page for
> every task.

Likewise. Note that we don't actually use a page of memory for every 
process, we just reserve a page of its virtual address space. The actual 
memory allocation only occurs (in alloc_emuframe) if we perform a delay 
slot emulation.

>> +    /*
>> +     * If the PC is at the emul instruction, roll back to the branch. If
>> +     * PC is at the badinst (break) instruction, we've already
>> emulated the
>> +     * instruction so progress to the continue PC. If it's anything else
>> +     * then something is amiss.
>> +     */
>> +    if (msk_isa16_mode(regs->cp0_epc) == (unsigned long)&fr->emul)
>> +        regs->cp0_epc = current->thread.bd_emu_branch_pc;
>> +    else if (msk_isa16_mode(regs->cp0_epc) == (unsigned
>> long)&fr->badinst)
>> +        regs->cp0_epc = current->thread.bd_emu_cont_pc;
>> +    else
>> +        return false;
> Would that lead to bd_emu_frame getting stuck?

The only way I can think of this case possibly being hit would be if the 
user code tried to trick the kernel into thinking it was executing from 
a struct emuframe when it actually wasn't - ie. some time after 
executing an actual delay slot emulation & preventing the badinst break 
instruction being hit (either by a well timed signal or an exception & 
signal generating instruction) the user would need to either manually 
write to the page & jump into it, or jump to a frame that some other 
thread had set up (and either way another thread may clobber what it's 
executing at any moment). If it does try that then yes, the thread's 
actual frame might persist until the thread either requires another 
emulation or exits. Worst case scenario the process has one less frame 
available to it, which I don't see as being an issue. We probably could 
just free the allocated frame anyway in this case, but actually perhaps 
SIGKILL would be more suitable.

BTW, a way to prevent one of the above scenarios would be ideal future 
work: it would be good for security if the user could only execute the 
page, and the kernel could only write it. That would probably involve 
having aliased mappings, but would be nice to add later.

Thanks,
     Paul
