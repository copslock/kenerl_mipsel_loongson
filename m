Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Aug 2010 22:47:54 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:62215 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491114Ab0H3Urr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Aug 2010 22:47:47 +0200
X-Authority-Analysis: v=1.1 cv=u9yrfc8dX8+D+pHqGYUzxVYM/oVXAp/JCIDMGESp0LA= c=1 sm=0 a=vpGvh0kIRgkA:10 a=Q9fys5e9bTEA:10 a=OPBmh+XkhLl+Enan7BmTLg==:17 a=pGLkceISAAAA:8 a=rehj9n5GDLp4zDrv9sQA:9 a=Z0x9H5cLHvJWHJtCRBAA:7 a=kyWeFHCz2dksaC1Zxvwen10d-3cA:4 a=PUjeQqilurYA:10 a=MSl-tDqOz04A:10 a=OPBmh+XkhLl+Enan7BmTLg==:117
X-Cloudmark-Score: 0
X-Originating-IP: 67.242.120.143
Received: from [67.242.120.143] ([67.242.120.143:47095] helo=[192.168.23.10])
        by hrndva-oedge04.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.2.39 r()) with ESMTP
        id FE/D7-17535-AE81C7C4; Mon, 30 Aug 2010 20:47:40 +0000
Subject: Re: Ftrace for MIPS may hang on SMP system
From:   Steven Rostedt <rostedt@goodmis.org>
To:     wu zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <AANLkTi=S2c+PcYWzHedB-gDeR=frn4YUpSUeVLJL=Yx+@mail.gmail.com>
References: <AANLkTintyZknEja=hNhreYK15Sqd9YNFpBLmPF7jf-SH@mail.gmail.com>
         <AANLkTikSt742WyX5ysC9TWeLsgDdHYODZq3=P=tdYCJA@mail.gmail.com>
         <AANLkTi=S2c+PcYWzHedB-gDeR=frn4YUpSUeVLJL=Yx+@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Mon, 30 Aug 2010 16:47:38 -0400
Message-ID: <1283201258.3656.22.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.2 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

Sorry for the late reply, just got back from vacation.


On Sun, 2010-08-22 at 22:27 +0800, wu zhangjin wrote:
> On 8/22/10, wu zhangjin <wuzhangjin@gmail.com> wrote:
> > (Add 'another' Steven in this loop)
> >
> > On 8/22/10, wu zhangjin <wuzhangjin@gmail.com> wrote:
> >> Hi, all
> >>
> >> For I didn't have a SMP machine, I haven't used Ftrace(in 2.6.34) for
> >> MIPS on SMP system before, Yesterday,  I got a RMI XLS machine and
> >> found Ftrace for MIPS hanged on it after I issued:
> >>
> >> $ echo function > /debug/tracing/current_tracer
> >>
> >> I have gotten the root cause, that is:
> >>
> >> in kernel/trace/ftrace.c:
> >>
> >> stop_machine() disables the irqs of the other cpus and then modify the
> >> codes via calling the arch specific ftrace_modify_code() in
> >> __ftrace_modify_code().
> >>
> >> As the description about stop_machine() in arch/x86/kernel/ftrace.c
> >> shows:
> >>
> >> /*
> >>  * Modifying code must take extra care. On an SMP machine, if
> >>  * the code being modified is also being executed on another CPU
> >>  * that CPU will have undefined results and possibly take a GPF.
> >>  * We use kstop_machine to stop other CPUS from exectuing code.
> >> [snip]
> >>
> >> Then, it is reasonable to use stop_machine() here.
> >>
> >> And in arch/mips/kernel/ftrace.c:
> >>
> >> flush_icache_range() is called in ftrace_modify_code() to ensure the
> >> intructions will be executed are what we want.
> >>
> >> In UP system, there is no problem for flush_icache_range() simply
> >> flush the instruction cache, but In SMP system, this may be different,
> >> for flush_icache_range() may also need to ask the other cpus (via
> >> sending ipi interrupt) to flush their icaches and will wait for them
> >> till the other cpus finish their flushing.
> >>
> >> But as we know above, the irqs of the other cpus are disabled by
> >> stop_machine(), they have no opportunity to flush their icache and
> >> will let the current cpu wait for them all the time, then soft lock
> >> --> hang.
> >>
> >> To fix it, there are two potential solutions:
> >>
> >> 1. replace flush_icache_range() by something else, maybe we can use
> >> the similar method in arch/x86/kernel/ftrace.c, x86 uses sync_core()
> >> defined in arch/x86/include/asm/processor.h to flush the icache on all
> >> processors:
> >>
> >> /* Stop speculative execution and prefetching of modified code. */
> >> static inline void sync_core(void)
> >> {
> >>         int tmp;
> >>
> >> #if defined(CONFIG_M386) || defined(CONFIG_M486)
> >>         if (boot_cpu_data.x86 < 5)
> >>                 /* There is no speculative execution.
> >>                  * jmp is a barrier to prefetching. */
> >>                 asm volatile("jmp 1f\n1:\n" ::: "memory");
> >>         else
> >> #endif
> >>                 /* cpuid is a barrier to speculative execution.
> >>                  * Prefetched instructions are automatically
> >>                  * invalidated when modified. */
> >>                 asm volatile("cpuid" : "=a" (tmp) : "0" (1)
> >>                              : "ebx", "ecx", "edx", "memory");
> >> }
> >>
> >> But is there a cpuid like hardware instruction in MIPS SMP? As I know,
> >> in UP, we may be possible to use prefetch instruction to push the
> >> instruction to the cache, but in SMP, is there a instruction to force
> >> the other cpus to flush their cache too?
> >>
> >> 2. Replace the stop_machine() by something else
> >>
> >> I have written such a patch:
> >>
> >> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> >> index 2404b59..e4d058f 100644
> >> --- a/kernel/trace/ftrace.c
> >> +++ b/kernel/trace/ftrace.c
> >> @@ -1129,13 +1129,18 @@ static int __ftrace_modify_code(void *data)
> >>  static void ftrace_run_update_code(int command)
> >>  {
> >>         int ret;
> >> +       unsigned long flags;
> >>
> >>         ret = ftrace_arch_code_modify_prepare();
> >>         FTRACE_WARN_ON(ret);
> >>         if (ret)
> >>                 return;
> >>
> >> -       stop_machine(__ftrace_modify_code, &command, NULL);
> >> +       preempt_disable();
> >> +       local_irq_save(flags);
> >> +       __ftrace_modify_code(&command);
> >> +       local_irq_restore(flags);
> >> +       preempt_enable();
> >>
> >>         ret = ftrace_arch_code_modify_post_process();
> >>         FTRACE_WARN_ON(ret);
> >>
> 
> We may need to protect the __ftrace_modify_code() with raw spin lock.

Nope, this will still crash a x86 box. The problem is not with
synchronizing the modification of code, but with modifying code that may
be executing on another CPU.

If the code is being entered in the pipe on one CPU, and another CPU
happens to modify that code (especially in kernel mode), the executing
CPU may take a general protection fault.

I believe this is true with some PPC's as well, so it is not a x86 only
problem.

It may also be a problem with MIPS too.

-- Steve
