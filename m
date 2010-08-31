Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Aug 2010 05:33:40 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:34511 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490951Ab0HaDdg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Aug 2010 05:33:36 +0200
Received: by wyb38 with SMTP id 38so6407550wyb.36
        for <multiple recipients>; Mon, 30 Aug 2010 20:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=oId0fOTZWJgzkiMDVJBKJoN3tBU3U8rPk8UKeCz13vU=;
        b=kwhLpkmfmD1XTesoHUrnWELO65MQYLqjuBCBXznlwhrcp50J+5rLQqfEDERYKdUylf
         nNZ0DME+y0tRDaGh382scrCZUdVMFKfhNLi7fw+QS7Z/9pHjBbShZSTqkNDODjyHNjkj
         arcAN5r8o1PubvrWIpPU+NzCjo+38JFtW5jc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=WzgfB2a4bPYWdyAnKXzvtsO/OHlJahEQSuCdaTKgalq9oCDTh4a21wMG+bT60Xs613
         pqvGlgiyvtX0PMzW8LYECMoSBVm8RyECeIc8AvC5DxPz2fPmVhcT7k8sb5XlwaqEwpP+
         aTqU9TShUZwn06jJzOuPFpxWPmg2+KSdX3XzQ=
MIME-Version: 1.0
Received: by 10.227.156.12 with SMTP id u12mr5512751wbw.213.1283225601119;
 Mon, 30 Aug 2010 20:33:21 -0700 (PDT)
Received: by 10.216.166.69 with HTTP; Mon, 30 Aug 2010 20:33:21 -0700 (PDT)
In-Reply-To: <1283201505.3656.25.camel@gandalf.stny.rr.com>
References: <AANLkTintyZknEja=hNhreYK15Sqd9YNFpBLmPF7jf-SH@mail.gmail.com>
        <AANLkTikSt742WyX5ysC9TWeLsgDdHYODZq3=P=tdYCJA@mail.gmail.com>
        <AANLkTi=S2c+PcYWzHedB-gDeR=frn4YUpSUeVLJL=Yx+@mail.gmail.com>
        <AANLkTinBR3+OMX-taCsp6cn4_-cBn5gQ1ooUkX2XS81O@mail.gmail.com>
        <AANLkTin1k+P9ZoW6LdtoGppAsRjBgxTNru1QFD97b8yi@mail.gmail.com>
        <4C72B16B.5000101@caviumnetworks.com>
        <AANLkTimU7uQjKnSwOGi2s9nb4K8LJRBdwkpQ=-vrRQLx@mail.gmail.com>
        <1283201505.3656.25.camel@gandalf.stny.rr.com>
Date:   Tue, 31 Aug 2010 11:33:21 +0800
Message-ID: <AANLkTimkXpC+jcdFZ+sW09qdhV1mq9OmMZ4+9kqhbJ_A@mail.gmail.com>
Subject: Re: Ftrace for MIPS may hang on SMP system
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On 8/31/10, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 2010-08-24 at 14:25 +0800, wu zhangjin wrote:
>
>> So, this patch is necessary to fix the deadlock and icache problem on
>> RMI XLS and it will also improve the performance via reducing the
>> unnecessary ipi interrupt on RML XLS and Cavium.
>
> I was about to mention the performance boost of the patch even on
> machines not affected by the lock up.
>
> When you enable function tracing, it can update 22,000 locations. Doing
> a cache invalidate 22,000 times in a row, is not very efficient. Only a
> full cache flush is needed at the end of the update (except for the
> module updates, which are done on a live system).

Yeah, will enable it for UP too via removing the #ifdef CONFIG_SMP ... #endif

BTW: I have found another potential problem, that is:

We have called ftace_modify_code() with irq disabled(the same to
stop_machine()):

kernel/trace/ftrace.c:

       /* disable interrupts to prevent kstop machine */
        local_irq_save(flags);
        ftrace_update_code(mod);
        local_irq_restore(flags);

This may introduce the warning in the smp_call_func_many() if we call
flush_icache_range() in ftrace_modify_code() on SMP:

kernel/smp.c:

void smp_call_function_many(const struct cpumask *mask,
                            void (*func)(void *), void *info, bool wait)
{
        struct call_function_data *data;
        unsigned long flags;
        int cpu, next_cpu, this_cpu = smp_processor_id();

        /*
         * Can deadlock when called with interrupts disabled.
         * We allow cpu's that are not yet online though, as no one else can
         * send smp call function interrupt to this cpu and as such deadlocks
         * can't happen.
         */
        WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
                     && !oops_in_progress);

Actually, for the other cpus' irq are not disabled here, there will be
no real deadlock, but this warning may show there are really potential
problems, if the irqs of the other cpus are disabled by something
else, we may really get the deadlock.

So, If want to fix this problem eventually, my patch is not enough, we
may need to move the flush_icache_range() out of the
ftrace_modify_code() and after the irq is enabled, for example:

       /* disable interrupts to prevent kstop machine */
        local_irq_save(flags);
        ftrace_update_code(mod);
        local_irq_restore(flags);
+        __flush_icache_all();

and similarly, we add this __flush_icache_all() after the stop_machine() too:

static void ftrace_run_update_code(int command)
{
        int ret;

        ret = ftrace_arch_code_modify_prepare();
        FTRACE_WARN_ON(ret);
        if (ret)
                return;

        stop_machine(__ftrace_modify_code, &command, NULL);
+      __flush_icache_all();

        ret = ftrace_arch_code_modify_post_process();
        FTRACE_WARN_ON(ret);
}

I'm not sure whether this is needed for all of the architectures, but
this may be needed by MIPS and powerpc.

If X86 doesn't need it, we can add a macro
NEED_FTRACE_FLUSH_ICACHE_ALL for MIPS and powerpc and introduce a
wrapper ftrace_flush_icache_all() for __flush_icache_all().

static inline ftrace_flush_icache_all()
{
#ifdef NEED_FTRACE_FLUSH_ICACHE_ALL
       __flush_icache_all();
#endif
}

Can we apply this method on X86 too? I'm not sure the performance of
the current sync_core() ;-) If it is not good(especially when we use
it for 22,000 times as you mentioned above), we may be possible to
apply this method on X86 to improve the performance too.

And a side effect is: after moving flush_icache_range() out of the
ftrace_modify_code(), we may need to ensure every caller of
ftrace_modify_code() must flush the icaches themselves, sometimes we
may need to call __flush_icache_full() If we don't know which range we
need to flush, sometimes we may be possible to call
flush_icache_range() to flush the indicated range of the icaches
realted to ftrace_modify_code().

Thanks & Regards,
Wu Zhangjin
