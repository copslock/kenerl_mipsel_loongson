Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Sep 2010 02:06:38 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:43178 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490991Ab0IAAGb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Sep 2010 02:06:31 +0200
X-Authority-Analysis: v=1.1 cv=8rLOhk8wZGSvnaCM3aW+9DxbPzg0bBAKX0Qt8NUyFX0= c=1 sm=0 a=vpGvh0kIRgkA:10 a=Q9fys5e9bTEA:10 a=OPBmh+XkhLl+Enan7BmTLg==:17 a=UVBnVOq77BREf0-VBfcA:9 a=pYSEPj7oK5rFuqYse6kA:7 a=dJkidqD3Sk6vsfd-eoJqwkJQ2rUA:4 a=PUjeQqilurYA:10 a=OPBmh+XkhLl+Enan7BmTLg==:117
X-Cloudmark-Score: 0
X-Originating-IP: 67.242.120.143
Received: from [67.242.120.143] ([67.242.120.143:48763] helo=[192.168.23.10])
        by hrndva-oedge03.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.2.39 r()) with ESMTP
        id D8/B5-15146-EF89D7C4; Wed, 01 Sep 2010 00:06:23 +0000
Subject: Re: Ftrace for MIPS may hang on SMP system
From:   Steven Rostedt <rostedt@goodmis.org>
To:     wu zhangjin <wuzhangjin@gmail.com>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <AANLkTimkXpC+jcdFZ+sW09qdhV1mq9OmMZ4+9kqhbJ_A@mail.gmail.com>
References: <AANLkTintyZknEja=hNhreYK15Sqd9YNFpBLmPF7jf-SH@mail.gmail.com>
         <AANLkTikSt742WyX5ysC9TWeLsgDdHYODZq3=P=tdYCJA@mail.gmail.com>
         <AANLkTi=S2c+PcYWzHedB-gDeR=frn4YUpSUeVLJL=Yx+@mail.gmail.com>
         <AANLkTinBR3+OMX-taCsp6cn4_-cBn5gQ1ooUkX2XS81O@mail.gmail.com>
         <AANLkTin1k+P9ZoW6LdtoGppAsRjBgxTNru1QFD97b8yi@mail.gmail.com>
         <4C72B16B.5000101@caviumnetworks.com>
         <AANLkTimU7uQjKnSwOGi2s9nb4K8LJRBdwkpQ=-vrRQLx@mail.gmail.com>
         <1283201505.3656.25.camel@gandalf.stny.rr.com>
         <AANLkTimkXpC+jcdFZ+sW09qdhV1mq9OmMZ4+9kqhbJ_A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Tue, 31 Aug 2010 20:06:22 -0400
Message-ID: <1283299582.1377.859.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.2 
Content-Transfer-Encoding: 7bit
X-archive-position: 27706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18

On Tue, 2010-08-31 at 11:33 +0800, wu zhangjin wrote:

> We have called ftace_modify_code() with irq disabled(the same to
> stop_machine()):
> 
> kernel/trace/ftrace.c:
> 
>        /* disable interrupts to prevent kstop machine */
>         local_irq_save(flags);
>         ftrace_update_code(mod);
>         local_irq_restore(flags);
> 
> This may introduce the warning in the smp_call_func_many() if we call
> flush_icache_range() in ftrace_modify_code() on SMP:

Hmm, I think preempt_disable() will do the same thing. Would that work?

> 
> kernel/smp.c:
> 
> void smp_call_function_many(const struct cpumask *mask,
>                             void (*func)(void *), void *info, bool wait)
> {
>         struct call_function_data *data;
>         unsigned long flags;
>         int cpu, next_cpu, this_cpu = smp_processor_id();
> 
>         /*
>          * Can deadlock when called with interrupts disabled.
>          * We allow cpu's that are not yet online though, as no one else can
>          * send smp call function interrupt to this cpu and as such deadlocks
>          * can't happen.
>          */
>         WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
>                      && !oops_in_progress);
> 
> Actually, for the other cpus' irq are not disabled here, there will be
> no real deadlock, but this warning may show there are really potential
> problems, if the irqs of the other cpus are disabled by something
> else, we may really get the deadlock.
> 
> So, If want to fix this problem eventually, my patch is not enough, we
> may need to move the flush_icache_range() out of the
> ftrace_modify_code() and after the irq is enabled, for example:
> 
>        /* disable interrupts to prevent kstop machine */
>         local_irq_save(flags);
>         ftrace_update_code(mod);
>         local_irq_restore(flags);
> +        __flush_icache_all();
> 
> and similarly, we add this __flush_icache_all() after the stop_machine() too:
> 
> static void ftrace_run_update_code(int command)
> {
>         int ret;
> 
>         ret = ftrace_arch_code_modify_prepare();
>         FTRACE_WARN_ON(ret);
>         if (ret)
>                 return;
> 
>         stop_machine(__ftrace_modify_code, &command, NULL);
> +      __flush_icache_all();
> 
>         ret = ftrace_arch_code_modify_post_process();
>         FTRACE_WARN_ON(ret);
> }
> 
> I'm not sure whether this is needed for all of the architectures, but
> this may be needed by MIPS and powerpc.
> 
> If X86 doesn't need it, we can add a macro
> NEED_FTRACE_FLUSH_ICACHE_ALL for MIPS and powerpc and introduce a
> wrapper ftrace_flush_icache_all() for __flush_icache_all().

Perhaps just changing the above to preempt disable() and adding the
__flush_icache_all() 

> 
> static inline ftrace_flush_icache_all()
> {
> #ifdef NEED_FTRACE_FLUSH_ICACHE_ALL
>        __flush_icache_all();
> #endif
> }

Hmm, maybe we could just add another weak function called
ftrace_arch_module_post_process() and have the archs do the flush
themselves. I'm not sure that function is common even for the archs that
would need it.


> 
> Can we apply this method on X86 too? I'm not sure the performance of
> the current sync_core() ;-) If it is not good(especially when we use
> it for 22,000 times as you mentioned above), we may be possible to
> apply this method on X86 to improve the performance too.

Well, we also need it for NMI than do run, thus it should be fine. The
22,000 updates does not seem to be an issue.

> 
> And a side effect is: after moving flush_icache_range() out of the
> ftrace_modify_code(), we may need to ensure every caller of
> ftrace_modify_code() must flush the icaches themselves, sometimes we
> may need to call __flush_icache_full() If we don't know which range we
> need to flush, sometimes we may be possible to call
> flush_icache_range() to flush the indicated range of the icaches
> realted to ftrace_modify_code().

Perhaps just be safe and call the flush_icache_full() after the
modifications. Thus I think it would be best to have the ftrace_arch_*
functions.

-- Steve
