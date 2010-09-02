Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Sep 2010 07:54:35 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:43001 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490957Ab0IBFyb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Sep 2010 07:54:31 +0200
Received: by wyb29 with SMTP id 29so11114wyb.36
        for <multiple recipients>; Wed, 01 Sep 2010 22:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=oo8imHThhVQ8J4HI2D9SDWCN6xcSMyii9PkKcQqNnAc=;
        b=Zdl/nsCi/ZdNU0OqwLJ4Li2fdYQ2Jfjjnedkspmk1JI9yJfOsSmbCmqVi2Z87klCll
         0pXJkhm40Y9Spn/Vah/vdlsZeKqO8TyETCOvZd5CLSo3GxVdQJ0JRaaZ28AW009lWw7p
         hyswaGhs9dkw0MRYzRk8MGc8cp0M+NAi9b1S4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=I3KLDiTjhou5NtrxCoHmwtGpVp28uafmXBqyto7bT3pyZDzHjmsUx4LZGKdcgOzRAx
         hUWDxWkNQnSBk5qrGvCWzvHTirn4l/4RVyepH3RHg+STKxfRYxTGiYkeEIhQ+4iRSt/x
         w0AWQj8FpcHF7eYmnmOJj2RCCUCr47icWibmE=
MIME-Version: 1.0
Received: by 10.216.7.78 with SMTP id 56mr830719weo.96.1283406865333; Wed, 01
 Sep 2010 22:54:25 -0700 (PDT)
Received: by 10.216.166.69 with HTTP; Wed, 1 Sep 2010 22:54:24 -0700 (PDT)
In-Reply-To: <1283299582.1377.859.camel@gandalf.stny.rr.com>
References: <AANLkTintyZknEja=hNhreYK15Sqd9YNFpBLmPF7jf-SH@mail.gmail.com>
        <AANLkTikSt742WyX5ysC9TWeLsgDdHYODZq3=P=tdYCJA@mail.gmail.com>
        <AANLkTi=S2c+PcYWzHedB-gDeR=frn4YUpSUeVLJL=Yx+@mail.gmail.com>
        <AANLkTinBR3+OMX-taCsp6cn4_-cBn5gQ1ooUkX2XS81O@mail.gmail.com>
        <AANLkTin1k+P9ZoW6LdtoGppAsRjBgxTNru1QFD97b8yi@mail.gmail.com>
        <4C72B16B.5000101@caviumnetworks.com>
        <AANLkTimU7uQjKnSwOGi2s9nb4K8LJRBdwkpQ=-vrRQLx@mail.gmail.com>
        <1283201505.3656.25.camel@gandalf.stny.rr.com>
        <AANLkTimkXpC+jcdFZ+sW09qdhV1mq9OmMZ4+9kqhbJ_A@mail.gmail.com>
        <1283299582.1377.859.camel@gandalf.stny.rr.com>
Date:   Thu, 2 Sep 2010 13:54:24 +0800
Message-ID: <AANLkTikb4moAThdKUHhUM4Qy_bQ9gGhae-mZzqGj0r9+@mail.gmail.com>
Subject: Re: Ftrace for MIPS may hang on SMP system
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 27709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1127

On 9/1/10, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 2010-08-31 at 11:33 +0800, wu zhangjin wrote:
>
>> We have called ftace_modify_code() with irq disabled(the same to
>> stop_machine()):
>>
>> kernel/trace/ftrace.c:
>>
>>        /* disable interrupts to prevent kstop machine */
>>         local_irq_save(flags);
>>         ftrace_update_code(mod);
>>         local_irq_restore(flags);
>>
>> This may introduce the warning in the smp_call_func_many() if we call
>> flush_icache_range() in ftrace_modify_code() on SMP:
>
> Hmm, I think preempt_disable() will do the same thing. Would that work?
>
>>
>> kernel/smp.c:
>>
>> void smp_call_function_many(const struct cpumask *mask,
>>                             void (*func)(void *), void *info, bool wait)
>> {
>>         struct call_function_data *data;
>>         unsigned long flags;
>>         int cpu, next_cpu, this_cpu = smp_processor_id();
>>
>>         /*
>>          * Can deadlock when called with interrupts disabled.
>>          * We allow cpu's that are not yet online though, as no one else
>> can
>>          * send smp call function interrupt to this cpu and as such
>> deadlocks
>>          * can't happen.
>>          */
>>         WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
>>                      && !oops_in_progress);
>>
>> Actually, for the other cpus' irq are not disabled here, there will be
>> no real deadlock, but this warning may show there are really potential
>> problems, if the irqs of the other cpus are disabled by something
>> else, we may really get the deadlock.
>>
>> So, If want to fix this problem eventually, my patch is not enough, we
>> may need to move the flush_icache_range() out of the
>> ftrace_modify_code() and after the irq is enabled, for example:
>>
>>        /* disable interrupts to prevent kstop machine */
>>         local_irq_save(flags);
>>         ftrace_update_code(mod);
>>         local_irq_restore(flags);
>> +        __flush_icache_all();
>>
>> and similarly, we add this __flush_icache_all() after the stop_machine()
>> too:
>>
>> static void ftrace_run_update_code(int command)
>> {
>>         int ret;
>>
>>         ret = ftrace_arch_code_modify_prepare();
>>         FTRACE_WARN_ON(ret);
>>         if (ret)
>>                 return;
>>
>>         stop_machine(__ftrace_modify_code, &command, NULL);
>> +      __flush_icache_all();
>>
>>         ret = ftrace_arch_code_modify_post_process();
>>         FTRACE_WARN_ON(ret);
>> }
>>
>> I'm not sure whether this is needed for all of the architectures, but
>> this may be needed by MIPS and powerpc.
>>
>> If X86 doesn't need it, we can add a macro
>> NEED_FTRACE_FLUSH_ICACHE_ALL for MIPS and powerpc and introduce a
>> wrapper ftrace_flush_icache_all() for __flush_icache_all().
>
> Perhaps just changing the above to preempt disable() and adding the
> __flush_icache_all()
>
>>
>> static inline ftrace_flush_icache_all()
>> {
>> #ifdef NEED_FTRACE_FLUSH_ICACHE_ALL
>>        __flush_icache_all();
>> #endif
>> }
>
> Hmm, maybe we could just add another weak function called
> ftrace_arch_module_post_process() and have the archs do the flush
> themselves. I'm not sure that function is common even for the archs that
> would need it.
>
>
>>
>> Can we apply this method on X86 too? I'm not sure the performance of
>> the current sync_core() ;-) If it is not good(especially when we use
>> it for 22,000 times as you mentioned above), we may be possible to
>> apply this method on X86 to improve the performance too.
>
> Well, we also need it for NMI than do run, thus it should be fine. The
> 22,000 updates does not seem to be an issue.
>
>>
>> And a side effect is: after moving flush_icache_range() out of the
>> ftrace_modify_code(), we may need to ensure every caller of
>> ftrace_modify_code() must flush the icaches themselves, sometimes we
>> may need to call __flush_icache_full() If we don't know which range we
>> need to flush, sometimes we may be possible to call
>> flush_icache_range() to flush the indicated range of the icaches
>> realted to ftrace_modify_code().
>
> Perhaps just be safe and call the flush_icache_full() after the
> modifications. Thus I think it would be best to have the ftrace_arch_*
> functions.

Ok, I will add the ftrace_arch_module_prepare/post_process() to
kernel/trace/ftrace.c.

Thanks Steve!

Regards,
Wu Zhangjin
