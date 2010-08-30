Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Aug 2010 22:49:02 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:56589 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491114Ab0H3Us7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Aug 2010 22:48:59 +0200
X-Authority-Analysis: v=1.1 cv=h9FjAN2ougM9pVhvDq3M6+cWFo1DP5/t8S/Ny2XAPyw= c=1 sm=0 a=vpGvh0kIRgkA:10 a=Q9fys5e9bTEA:10 a=OPBmh+XkhLl+Enan7BmTLg==:17 a=pGLkceISAAAA:8 a=meVymXHHAAAA:8 a=_ojM_Dzv2sncSkz7g4oA:9 a=E1u02nfi55KUCkvUONAA:7 a=_J0_3T4w2RCAMu1TR5kMltgMFQIA:4 a=PUjeQqilurYA:10 a=MSl-tDqOz04A:10 a=jeBq3FmKZ4MA:10 a=OPBmh+XkhLl+Enan7BmTLg==:117
X-Cloudmark-Score: 0
X-Originating-IP: 67.242.120.143
Received: from [67.242.120.143] ([67.242.120.143:47098] helo=[192.168.23.10])
        by hrndva-oedge03.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.2.39 r()) with ESMTP
        id AC/4B-26575-3391C7C4; Mon, 30 Aug 2010 20:48:52 +0000
Subject: Re: Ftrace for MIPS may hang on SMP system
From:   Steven Rostedt <rostedt@goodmis.org>
To:     wu zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <AANLkTin1k+P9ZoW6LdtoGppAsRjBgxTNru1QFD97b8yi@mail.gmail.com>
References: <AANLkTintyZknEja=hNhreYK15Sqd9YNFpBLmPF7jf-SH@mail.gmail.com>
         <AANLkTikSt742WyX5ysC9TWeLsgDdHYODZq3=P=tdYCJA@mail.gmail.com>
         <AANLkTi=S2c+PcYWzHedB-gDeR=frn4YUpSUeVLJL=Yx+@mail.gmail.com>
         <AANLkTinBR3+OMX-taCsp6cn4_-cBn5gQ1ooUkX2XS81O@mail.gmail.com>
         <AANLkTin1k+P9ZoW6LdtoGppAsRjBgxTNru1QFD97b8yi@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Mon, 30 Aug 2010 16:48:50 -0400
Message-ID: <1283201330.3656.23.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.2 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Mon, 2010-08-23 at 22:16 +0800, wu zhangjin wrote:
> On 8/23/10, wu zhangjin <wuzhangjin@gmail.com> wrote:
> > Hi,
> >
> > To avoid touching the other parts, I have used the following method:
> >
> > delay the cache flushing operation after the stop_machine().
> >
> > Here is the patch:
> >
> > diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
> > index 5a84a1f..f4c9581 100644
> > --- a/arch/mips/kernel/ftrace.c
> > +++ b/arch/mips/kernel/ftrace.c
> > @@ -33,6 +33,25 @@ static inline int in_module(unsigned long ip)
> >         return ip & 0x40000000;
> >  }
> >
> > +#ifdef CONFIG_SMP
> > +static bool machine_stopped;
> > +
> > +int ftrace_arch_code_modify_prepare(void)
> > +{
> > +       preempt_disable();
> 
> preempt_disable() is not necessary, and it may introduce the warning
> about "scheduling in atomic()"
> 

Correct,

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

> Regards,
> Wu Zhangjin
> 
> > +       machine_stopped = 1;
> > +       return 0;
> > +}
> > +
> > +int ftrace_arch_code_modify_post_process(void)
> > +{
> > +       __flush_cache_all();
> > +       machine_stopped = 0;
> > +       preempt_enable();
> > +       return 0;
> > +}
> > +#endif
> > +
> >  #ifdef CONFIG_DYNAMIC_FTRACE
> >
> >  #define JAL 0x0c000000         /* jump & link: ip --> ra, jump to target
> > */
> > @@ -79,7 +98,12 @@ static int ftrace_modify_code(unsigned long ip,
> > unsigned int new_code)
> >         if (unlikely(faulted))
> >                 return -EFAULT;
> >
> > -       flush_icache_range(ip, ip + 8);
> > +#ifndef CONFIG_SMP
> > +       flush_icache_range(ip, ip + MCOUNT_INSN_SIZE);
> > +#else
> > +       if (!machine_stopped)
> > +               flush_icache_range(ip, ip + MCOUNT_INSN_SIZE);
> > +#endif
> >
> >         return 0;
> >  }
> >
> >
> > Regards,
> > Wu Zhangjin
> >
> > On 8/22/10, wu zhangjin <wuzhangjin@gmail.com> wrote:
> >> On 8/22/10, wu zhangjin <wuzhangjin@gmail.com> wrote:
> >>> (Add 'another' Steven in this loop)
> >>>
> >>> On 8/22/10, wu zhangjin <wuzhangjin@gmail.com> wrote:
> >>>> Hi, all
> >>>>
> >>>> For I didn't have a SMP machine, I haven't used Ftrace(in 2.6.34) for
> >>>> MIPS on SMP system before, Yesterday,  I got a RMI XLS machine and
> >>>> found Ftrace for MIPS hanged on it after I issued:
> >>>>
> >>>> $ echo function > /debug/tracing/current_tracer
> >>>>
> >>>> I have gotten the root cause, that is:
> >>>>
> >>>> in kernel/trace/ftrace.c:
> >>>>
> >>>> stop_machine() disables the irqs of the other cpus and then modify the
> >>>> codes via calling the arch specific ftrace_modify_code() in
> >>>> __ftrace_modify_code().
> >>>>
> >>>> As the description about stop_machine() in arch/x86/kernel/ftrace.c
> >>>> shows:
> >>>>
> >>>> /*
> >>>>  * Modifying code must take extra care. On an SMP machine, if
> >>>>  * the code being modified is also being executed on another CPU
> >>>>  * that CPU will have undefined results and possibly take a GPF.
> >>>>  * We use kstop_machine to stop other CPUS from exectuing code.
> >>>> [snip]
> >>>>
> >>>> Then, it is reasonable to use stop_machine() here.
> >>>>
> >>>> And in arch/mips/kernel/ftrace.c:
> >>>>
> >>>> flush_icache_range() is called in ftrace_modify_code() to ensure the
> >>>> intructions will be executed are what we want.
> >>>>
> >>>> In UP system, there is no problem for flush_icache_range() simply
> >>>> flush the instruction cache, but In SMP system, this may be different,
> >>>> for flush_icache_range() may also need to ask the other cpus (via
> >>>> sending ipi interrupt) to flush their icaches and will wait for them
> >>>> till the other cpus finish their flushing.
> >>>>
> >>>> But as we know above, the irqs of the other cpus are disabled by
> >>>> stop_machine(), they have no opportunity to flush their icache and
> >>>> will let the current cpu wait for them all the time, then soft lock
> >>>> --> hang.
> >>>>
> >>>> To fix it, there are two potential solutions:
> >>>>
> >>>> 1. replace flush_icache_range() by something else, maybe we can use
> >>>> the similar method in arch/x86/kernel/ftrace.c, x86 uses sync_core()
> >>>> defined in arch/x86/include/asm/processor.h to flush the icache on all
> >>>> processors:
> >>>>
> >>>> /* Stop speculative execution and prefetching of modified code. */
> >>>> static inline void sync_core(void)
> >>>> {
> >>>>         int tmp;
> >>>>
> >>>> #if defined(CONFIG_M386) || defined(CONFIG_M486)
> >>>>         if (boot_cpu_data.x86 < 5)
> >>>>                 /* There is no speculative execution.
> >>>>                  * jmp is a barrier to prefetching. */
> >>>>                 asm volatile("jmp 1f\n1:\n" ::: "memory");
> >>>>         else
> >>>> #endif
> >>>>                 /* cpuid is a barrier to speculative execution.
> >>>>                  * Prefetched instructions are automatically
> >>>>                  * invalidated when modified. */
> >>>>                 asm volatile("cpuid" : "=a" (tmp) : "0" (1)
> >>>>                              : "ebx", "ecx", "edx", "memory");
> >>>> }
> >>>>
> >>>> But is there a cpuid like hardware instruction in MIPS SMP? As I know,
> >>>> in UP, we may be possible to use prefetch instruction to push the
> >>>> instruction to the cache, but in SMP, is there a instruction to force
> >>>> the other cpus to flush their cache too?
> >>>>
> >>>> 2. Replace the stop_machine() by something else
> >>>>
> >>>> I have written such a patch:
> >>>>
> >>>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> >>>> index 2404b59..e4d058f 100644
> >>>> --- a/kernel/trace/ftrace.c
> >>>> +++ b/kernel/trace/ftrace.c
> >>>> @@ -1129,13 +1129,18 @@ static int __ftrace_modify_code(void *data)
> >>>>  static void ftrace_run_update_code(int command)
> >>>>  {
> >>>>         int ret;
> >>>> +       unsigned long flags;
> >>>>
> >>>>         ret = ftrace_arch_code_modify_prepare();
> >>>>         FTRACE_WARN_ON(ret);
> >>>>         if (ret)
> >>>>                 return;
> >>>>
> >>>> -       stop_machine(__ftrace_modify_code, &command, NULL);
> >>>> +       preempt_disable();
> >>>> +       local_irq_save(flags);
> >>>> +       __ftrace_modify_code(&command);
> >>>> +       local_irq_restore(flags);
> >>>> +       preempt_enable();
> >>>>
> >>>>         ret = ftrace_arch_code_modify_post_process();
> >>>>         FTRACE_WARN_ON(ret);
> >>>>
> >>
> >> We may need to protect the __ftrace_modify_code() with raw spin lock.
> >>
> >>>> It works without any hang but I'm not sure whether it will guarantee
> >>>> the "undefined results" problem mentioned above. Here we may need to
> >>>> prevent the other cpus from executing the source code for we are
> >>>> modifying the source code but also need to allow them to get the ipi
> >>>> interrupt and flush their icaches.
> >>>>
> >>>> And I have took a look at the part of code modification in kgdb
> >>>> system, seems it doesn't use stop_machine().
> >>>>
> >>>> What's your ideas?
> >>>>
> >>>> Thanks & Regards,
> >>>> Wu Zhangjin
> >
> 
> 
