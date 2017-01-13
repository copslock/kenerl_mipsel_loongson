Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jan 2017 12:33:46 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3110 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992267AbdAMLdeY5A6n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jan 2017 12:33:34 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B67F1DD4D88C5;
        Fri, 13 Jan 2017 11:33:24 +0000 (GMT)
Received: from [10.80.2.5] (10.80.2.5) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 13 Jan
 2017 11:33:27 +0000
Subject: Re: [PATCH 1/2] MIPS: ptrace: protect watchpoint handling code from
 setting watchpoints
To:     James Hogan <james.hogan@imgtec.com>
References: <1484293487-5770-1-git-send-email-marcin.nowakowski@imgtec.com>
 <20170113111141.GL10569@jhogan-linux.le.imgtec.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <272821c4-1fa3-2e85-b792-78c688f491d6@imgtec.com>
Date:   Fri, 13 Jan 2017 12:33:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170113111141.GL10569@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56300
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

Thanks for your comments

On 13.01.2017 12:11, James Hogan wrote:
> Hi Marcin,
>
> On Fri, Jan 13, 2017 at 08:44:46AM +0100, Marcin Nowakowski wrote:
>> With certain EVA configurations it is possible for the kernel address
>> space to overlap user address space, which allows the user to set
>> watchpoints on kernel addresses via ptrace.
>>
>> If a watchpoint is set in the watch exception handling code (after
>> exception level has been cleared) then the system will hang in an
>> infinite loop when hitting a watchpoint while trying to process it.
>>
>> To prevent that place all watch exception entry/exit code in a single
>> named section and disallow placing watchpoints in that area.
>
> An interesting approach. If I understand correctly, any watch placed on
> watch exception entry code up to when watchpoints are disabled in
> do_watch and interrupts re-enabled is disallowed, as well as the code
> after watchpoints are restored.

That's the intention. In theory it could be relaxed so that we can allow 
watchpoints to be placed _after_ watchpoint registers are cleared and 
before they are restored, but that would bring extra complexity and no 
benefit (at least I cannot see any).

> Should mips_install_watch_registers() also move into that section?

It probably should, as we may end up hitting the watchpoint as soon as 
they are enabled again, and the same goes for the resume() method as 
well, which is called in switch_to() after mips_install_watch_registers().


> Should do_watch be made notrace too, so we don't get calls into
> unprotected ftrace code?

Good point.

>>
>> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
>> ---
>>  arch/mips/kernel/entry.S       |  2 +-
>>  arch/mips/kernel/genex.S       |  2 ++
>>  arch/mips/kernel/ptrace.c      | 14 ++++++++++++++
>>  arch/mips/kernel/traps.c       |  2 ++
>>  arch/mips/kernel/vmlinux.lds.S |  8 ++++++++
>>  5 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
>> index 7791840..ef69a64 100644
>> --- a/arch/mips/kernel/entry.S
>> +++ b/arch/mips/kernel/entry.S
>> @@ -24,7 +24,7 @@
>>  #define __ret_from_irq	ret_from_exception
>>  #endif
>>
>> -	.text
>> +	.section .text..no_watch
>>  	.align	5
>>  #ifndef CONFIG_PREEMPT
>>  FEXPORT(ret_from_exception)
>> diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
>> index dc0b296..102a9e8 100644
>> --- a/arch/mips/kernel/genex.S
>> +++ b/arch/mips/kernel/genex.S
>> @@ -433,6 +433,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
>>  	BUILD_HANDLER ftlb ftlb none silent		/* #16 */
>>  	BUILD_HANDLER msa msa sti silent		/* #21 */
>>  	BUILD_HANDLER mdmx mdmx sti silent		/* #22 */
>> +.section .text..no_watch
>>  #ifdef	CONFIG_HARDWARE_WATCHPOINTS
>>  	/*
>>  	 * For watch, interrupts will be enabled after the watch
>> @@ -442,6 +443,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
>>  #else
>>  	BUILD_HANDLER watch watch sti verbose		/* #23 */
>>  #endif
>> +.previous
>>  	BUILD_HANDLER mcheck mcheck cli verbose		/* #24 */
>>  	BUILD_HANDLER mt mt sti silent			/* #25 */
>>  	BUILD_HANDLER dsp dsp sti silent		/* #26 */
>> diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
>> index c8ba260..1c8d75c 100644
>> --- a/arch/mips/kernel/ptrace.c
>> +++ b/arch/mips/kernel/ptrace.c
>> @@ -235,6 +235,17 @@ int ptrace_get_watch_regs(struct task_struct *child,
>>  	return 0;
>>  }
>>
>> +static int ptrace_watch_in_watch_code_region(unsigned long addr)
>> +{
>> +	extern unsigned long __nowatch_text_start, __nowatch_text_end;
>> +	unsigned long start, end;
>> +
>> +	start = (((unsigned long)&__nowatch_text_start) & ~MIPS_WATCHLO_IRW);
>> +	end = (((unsigned long)&__nowatch_text_end) & ~MIPS_WATCHLO_IRW);
>> +
>> +	return addr >= start && addr < end;
>> +}
>> +
>>  int ptrace_set_watch_regs(struct task_struct *child,
>>  			  struct pt_watch_regs __user *addr)
>>  {
>> @@ -262,6 +273,9 @@ int ptrace_set_watch_regs(struct task_struct *child,
>>  				return -EINVAL;
>>  		}
>>  #endif
>> +		if (ptrace_watch_in_watch_code_region(lt[i]))
>> +			return -EINVAL;
>
> This would apparently permit userland to probe for the address of the
> kernel on EVA kernels, regardless of KASLR (assuming that works with
> EVA). Perhaps in that case we should be more restrictive and disallow
> any watchpoints in the same segment as the kernel.

That's an unfortunate side-effect.

> Actually for stable kernel purposes, it might be better to do that
> first, i.e. disallow any to the same segments as kernel (tagged for
> stable), then relax it as you've done here.

That sounds like a good idea.
What do you think about making my 'relaxed' approach depend on !KASLR?

>> +
>>  		__get_user(ht[i], &addr->WATCH_STYLE.watchhi[i]);
>>  		if (ht[i] & ~MIPS_WATCHHI_MASK)
>>  			return -EINVAL;
>> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
>> index 6c7f9d7..b86ce85 100644
>> --- a/arch/mips/kernel/traps.c
>> +++ b/arch/mips/kernel/traps.c
>> @@ -1509,6 +1509,8 @@ asmlinkage void do_mdmx(struct pt_regs *regs)
>>   * Called with interrupts disabled.
>>   */
>>  asmlinkage void do_watch(struct pt_regs *regs)
>> +	__attribute__((section(".text..no_watch")));
>
> maybe worth a macro, especially if any other functions do need this.

Will do

> is a separate declaration really needed? could it go after void in the
> definition like notrace does?

I need to check that. I had always thought that when attributes are 
added then a separate declaration is required, but if that's not the 
case then I will happily remove it, as it doesn't look too good.


> Cheers
> James
>
>> +asmlinkage void do_watch(struct pt_regs *regs)
>>  {
>>  	siginfo_t info = { .si_signo = SIGTRAP, .si_code = TRAP_HWBKPT };
>>  	enum ctx_state prev_state;
>> diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
>> index d5de675..f76f481 100644
>> --- a/arch/mips/kernel/vmlinux.lds.S
>> +++ b/arch/mips/kernel/vmlinux.lds.S
>> @@ -32,6 +32,13 @@ PHDRS {
>>  	jiffies	 = jiffies_64;
>>  #endif
>>
>> +#define NOWATCH_TEXT							\
>> +		ALIGN_FUNCTION();					\
>> +		VMLINUX_SYMBOL(__nowatch_text_start) = .;		\
>> +		*(.text..no_watch)					\
>> +		VMLINUX_SYMBOL(__nowatch_text_end) = .;
>> +
>> +
>>  SECTIONS
>>  {
>>  #ifdef CONFIG_BOOT_ELF64
>> @@ -54,6 +61,7 @@ SECTIONS
>>  	_text = .;	/* Text and read-only data */
>>  	.text : {
>>  		TEXT_TEXT
>> +		NOWATCH_TEXT
>>  		SCHED_TEXT
>>  		CPUIDLE_TEXT
>>  		LOCK_TEXT
>> --
>> 2.7.4
>>
