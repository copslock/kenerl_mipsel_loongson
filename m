Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2017 10:06:35 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44203 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991232AbdAWJG1q307c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2017 10:06:27 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id DEC0CBEA1D8B8;
        Mon, 23 Jan 2017 09:06:17 +0000 (GMT)
Received: from [10.80.2.5] (10.80.2.5) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 23 Jan
 2017 09:06:20 +0000
Subject: Re: [PATCH 2/2] MIPS: ptrace: disable watchpoints if hit in kernel
 mode
To:     James Hogan <james.hogan@imgtec.com>
References: <1484293487-5770-1-git-send-email-marcin.nowakowski@imgtec.com>
 <1484293487-5770-2-git-send-email-marcin.nowakowski@imgtec.com>
 <20170113114218.GM10569@jhogan-linux.le.imgtec.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <eeb4d812-2c7e-b330-da15-d205451b3883@imgtec.com>
Date:   Mon, 23 Jan 2017 10:06:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170113114218.GM10569@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56465
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

Hi James,

On 13.01.2017 12:42, James Hogan wrote:
> On Fri, Jan 13, 2017 at 08:44:47AM +0100, Marcin Nowakowski wrote:
>> If a watchpoint is hit when in kernel mode it is possible for the system
>> to end up in an infinite loop processing the watchpoint. This can happen
>> if a user sets a watchpoint in the kernel addess space (which is
>> possible in certain EVA configurations) or if a user sets a watchpoint
>> in a user area accessed directly by the kernel (eg. a user buffer
>> accessed via a syscall).
>>
>> To prevent the infinite loop ensure that the watchpoint was hit in
>> userspace, and clear the watchpoint registers otherwise.
>>
>> As this change could mean that a watchpoint is not hit when it should be
>> (when returning to the interrupted traced task on exception exit), the
>> resume_userspace path needs to be extended to conditionally restore the
>> watchpoint configuration. If a task switch occurs when returning to
>> userspace, the watchpoints will be restored in a typical way in the
>> switch_to() handler.
>>
>> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
>> ---
>>  arch/mips/kernel/entry.S | 9 ++++++++-
>>  arch/mips/kernel/traps.c | 2 +-
>>  2 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
>> index ef69a64..b15a9a9 100644
>> --- a/arch/mips/kernel/entry.S
>> +++ b/arch/mips/kernel/entry.S
>> @@ -55,7 +55,14 @@ resume_userspace:
>>  	LONG_L	a2, TI_FLAGS($28)	# current->work
>>  	andi	t0, a2, _TIF_WORK_MASK	# (ignoring syscall_trace)
>>  	bnez	t0, work_pending
>> -	j	restore_all
>> +#ifdef CONFIG_HARDWARE_WATCHPOINTS
>> +	li	t0, _TIF_LOAD_WATCH
>> +	and	t0, a2, t0
>> +	beqz	t0, 1f
>> +	PTR_L	a0, TI_TASK($28)
>> +	jal	mips_install_watch_registers
>> +#endif
>
> Perhaps this should also be conditional upon EVA, otherwise the return
> to userland path would get unnecessarily slower whenever watchpoints are
> enabled.

Unfortunately this can affect all systems regardless of EVA - whenever 
eg. a watchpoint is set on a userspace address accessed from kernel (eg. 
a user buffer passed via a syscall).
I agree it's not great to add the extra overhead on the resume userspace 
path, but it could be really difficult to handle otherwise.

An alternative is to only leave the 2nd chunk of this patch and remove 
this one, but then that leaves a chance that on resume userspace we 
could end up with a user process without watchpoints even though they 
should be set (until kernel re-schedules). I don't think such behaviour 
would be acceptable?

> TBH my worry with this general approach is that it permits userland to
> mess with kernel assumptions in quite controlled and unexpected ways.
> For example, it allows userland to inject temporary enabling of
> interrupts at any point, e.g. in a spin_lock_irq() critical section
> somewhere.
>
> Perhaps that specific case can be worked around by having do_watch leave
> interrupts disabled if they were already disabled when the exception was
> taken. resume_kernel won't call preempt_schedule_irq() if IRQs are
> disabled in the context being restored.
>
> The other issue is I think it only really considers instruction watches
> (hardware breakpoints). What about if userland put a data watchpoint on
> a kernel stack address that gets hit in do_watch()'s prologue (i.e.
> after EXL=0)? That can't be placed in a dedicated section, and would be
> tricky to specifically exclude (would fork result in a new kernel stack
> pointer and also preserve watch points?), and doing so would potentially
> leak the process' kernel stack pointer too (regardless of KASLR),
> presumably a valuable target for an exploit.


> Cheers
> James
>
>> +1:	j	restore_all
>>
>>  #ifdef CONFIG_PREEMPT
>>  resume_kernel:
>> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
>> index b86ce85..d92169e 100644
>> --- a/arch/mips/kernel/traps.c
>> +++ b/arch/mips/kernel/traps.c
>> @@ -1527,7 +1527,7 @@ asmlinkage void do_watch(struct pt_regs *regs)
>>  	 * their values and send SIGTRAP.  Otherwise another thread
>>  	 * left the registers set, clear them and continue.
>>  	 */
>> -	if (test_tsk_thread_flag(current, TIF_LOAD_WATCH)) {
>> +	if (user_mode(regs) && test_tsk_thread_flag(current, TIF_LOAD_WATCH)) {
>>  		mips_read_watch_registers();
>>  		local_irq_enable();
>>  		force_sig_info(SIGTRAP, &info, current);
>> --
>> 2.7.4
>>
