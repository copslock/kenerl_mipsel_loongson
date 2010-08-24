Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Aug 2010 08:26:08 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:34415 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490973Ab0HXG0D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Aug 2010 08:26:03 +0200
Received: by wwi14 with SMTP id 14so1171287wwi.24
        for <multiple recipients>; Mon, 23 Aug 2010 23:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=UXb92lB5PraWP/oM9BkY0W1Gb7n9cN9lm1NW/qsvvc4=;
        b=eDv+oQ2H3EKvy216mGUBaK496e/9rd+YLHb36pp7kB3KptWa5S0CCGYsUnGTTc1mAC
         6z1ApikFkqx+Y7EeqzoVKbIz3YKrgAGo/S0dpQQFxqfualjJX8KIZ6SHKUbPvYxVHv6r
         QLsUJb4Md/2Dv7ul6p0/w6rrbUzUDM+A6Moro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Kzg+QwSsvGLBX+/gJC5PVtCFBZjA8XENSs7PtMNo6AKj1lv8g8FfFVQ2yAewUbJbNn
         NWZvQTucErwmsQpNJ5kCWqcwQ5VjilsZD6SxXQgMIdQTUkjNY5a5H7erNtW89NQybTf0
         T4JqfGlvh+v8J9dPbSzqi7oGiongYNqALb98U=
MIME-Version: 1.0
Received: by 10.216.186.207 with SMTP id w57mr368068wem.19.1282631157889; Mon,
 23 Aug 2010 23:25:57 -0700 (PDT)
Received: by 10.216.166.69 with HTTP; Mon, 23 Aug 2010 23:25:57 -0700 (PDT)
In-Reply-To: <4C72B16B.5000101@caviumnetworks.com>
References: <AANLkTintyZknEja=hNhreYK15Sqd9YNFpBLmPF7jf-SH@mail.gmail.com>
        <AANLkTikSt742WyX5ysC9TWeLsgDdHYODZq3=P=tdYCJA@mail.gmail.com>
        <AANLkTi=S2c+PcYWzHedB-gDeR=frn4YUpSUeVLJL=Yx+@mail.gmail.com>
        <AANLkTinBR3+OMX-taCsp6cn4_-cBn5gQ1ooUkX2XS81O@mail.gmail.com>
        <AANLkTin1k+P9ZoW6LdtoGppAsRjBgxTNru1QFD97b8yi@mail.gmail.com>
        <4C72B16B.5000101@caviumnetworks.com>
Date:   Tue, 24 Aug 2010 14:25:57 +0800
Message-ID: <AANLkTimU7uQjKnSwOGi2s9nb4K8LJRBdwkpQ=-vrRQLx@mail.gmail.com>
Subject: Re: Ftrace for MIPS may hang on SMP system
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On 8/24/10, David Daney <ddaney@caviumnetworks.com> wrote:
> Can you send a real patch with your proposed complete fix and proper
> Signed-off-by: header?
>
> I would like to test it.
>
> Also as a point of reference, I have been using ftrace on 16 way SMP
> mips64 systems without seeing this issue.

Yes, even without this patch, it works well on cavium, the reason is
cavium doesn't use smp_call_function() to send the ipi interrupts, but
just send the ipi with octeon_send_ipi_single():

flush_icache_range              = octeon_flush_icache_range;

/**
 * Flush a range of kernel addresses out of the icache
 *
 */
static void octeon_flush_icache_range(unsigned long start, unsigned long end)
{
        octeon_flush_icache_all_cores(NULL);
}

octeon_flush_icache_all_cores
{
         [snip]
         for_each_cpu_mask(cpu, mask)
                octeon_send_ipi_single(cpu, SMP_ICACHE_FLUSH);
         [snip]
}

static irqreturn_t mailbox_interrupt(int irq, void *dev_id)
{
        [snip]
        if (action & SMP_CALL_FUNCTION)
                smp_call_function_interrupt();

        /* Check if we've been told to flush the icache */
        if (action & SMP_ICACHE_FLUSH)
                asm volatile ("synci 0($0)\n");
        return IRQ_HANDLED;
}

When the irqs of the cpus are disabled by stop_machine(), the icache
of the other cpus will not be flushed till the irqs are enabled, but
it is okay for the synci of cavium will flush the whole local icache
after the pending ipi is filed:

static inline void octeon_local_flush_icache(void)
{
        asm volatile ("synci 0($0)");
}

But for RMI XSL, flush_icache_range() will flush the indicated address
via the cache instruction, it doesn't flush the whole local icache,
so, if too many cache requests are sent to the other cpus, only the
icaches of the latest addresses will be flushed after the irqs are
enabled, and in RMI XSL, it use the smp_call_function() to send the
ipi to the other cpus, if the irqs of the cpus are disabled, there
will be deadlock for smp_call_function_many() called by
smp_call_function() will wait for the other cpus.

So, this patch is necessary to fix the deadlock and icache problem on
RMI XLS and it will also improve the performance via reducing the
unnecessary ipi interrupt on RML XLS and Cavium.

Thanks & Regards,
Wu Zhangjin

>
> David Daney
>
> On 08/23/2010 07:16 AM, wu zhangjin wrote:
>> On 8/23/10, wu zhangjin<wuzhangjin@gmail.com>  wrote:
>>> Hi,
>>>
>>> To avoid touching the other parts, I have used the following method:
>>>
>>> delay the cache flushing operation after the stop_machine().
>>>
>>> Here is the patch:
>>>
>>> diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
>>> index 5a84a1f..f4c9581 100644
>>> --- a/arch/mips/kernel/ftrace.c
>>> +++ b/arch/mips/kernel/ftrace.c
>>> @@ -33,6 +33,25 @@ static inline int in_module(unsigned long ip)
>>>          return ip&  0x40000000;
>>>   }
>>>
>>> +#ifdef CONFIG_SMP
>>> +static bool machine_stopped;
>>> +
>>> +int ftrace_arch_code_modify_prepare(void)
>>> +{
>>> +       preempt_disable();
>>
>> preempt_disable() is not necessary, and it may introduce the warning
>> about "scheduling in atomic()"
>>
>> Regards,
>> Wu Zhangjin
>>
>>> +       machine_stopped = 1;
>>> +       return 0;
>>> +}
>>> +
>>> +int ftrace_arch_code_modify_post_process(void)
>>> +{
>>> +       __flush_cache_all();
>>> +       machine_stopped = 0;
>>> +       preempt_enable();
>>> +       return 0;
>>> +}
>>> +#endif
>>> +
>>>   #ifdef CONFIG_DYNAMIC_FTRACE
>>>
>>>   #define JAL 0x0c000000         /* jump&  link: ip -->  ra, jump to
>>> target
>>> */
>>> @@ -79,7 +98,12 @@ static int ftrace_modify_code(unsigned long ip,
>>> unsigned int new_code)
>>>          if (unlikely(faulted))
>>>                  return -EFAULT;
>>>
>>> -       flush_icache_range(ip, ip + 8);
>>> +#ifndef CONFIG_SMP
>>> +       flush_icache_range(ip, ip + MCOUNT_INSN_SIZE);
>>> +#else
>>> +       if (!machine_stopped)
>>> +               flush_icache_range(ip, ip + MCOUNT_INSN_SIZE);
>>> +#endif
>>>
>>>          return 0;
>>>   }
>>>
>>>
>>> Regards,
>>> Wu Zhangjin
>>>
>>> On 8/22/10, wu zhangjin<wuzhangjin@gmail.com>  wrote:
>>>> On 8/22/10, wu zhangjin<wuzhangjin@gmail.com>  wrote:
>>>>> (Add 'another' Steven in this loop)
>>>>>
>>>>> On 8/22/10, wu zhangjin<wuzhangjin@gmail.com>  wrote:
>>>>>> Hi, all
>>>>>>
>>>>>> For I didn't have a SMP machine, I haven't used Ftrace(in 2.6.34) for
>>>>>> MIPS on SMP system before, Yesterday,  I got a RMI XLS machine and
>>>>>> found Ftrace for MIPS hanged on it after I issued:
>>>>>>
>>>>>> $ echo function>  /debug/tracing/current_tracer
>>>>>>
>>>>>> I have gotten the root cause, that is:
>>>>>>
>>>>>> in kernel/trace/ftrace.c:
>>>>>>
>>>>>> stop_machine() disables the irqs of the other cpus and then modify the
>>>>>> codes via calling the arch specific ftrace_modify_code() in
>>>>>> __ftrace_modify_code().
>>>>>>
>>>>>> As the description about stop_machine() in arch/x86/kernel/ftrace.c
>>>>>> shows:
>>>>>>
>>>>>> /*
>>>>>>   * Modifying code must take extra care. On an SMP machine, if
>>>>>>   * the code being modified is also being executed on another CPU
>>>>>>   * that CPU will have undefined results and possibly take a GPF.
>>>>>>   * We use kstop_machine to stop other CPUS from exectuing code.
>>>>>> [snip]
>>>>>>
>>>>>> Then, it is reasonable to use stop_machine() here.
>>>>>>
>>>>>> And in arch/mips/kernel/ftrace.c:
>>>>>>
>>>>>> flush_icache_range() is called in ftrace_modify_code() to ensure the
>>>>>> intructions will be executed are what we want.
>>>>>>
>>>>>> In UP system, there is no problem for flush_icache_range() simply
>>>>>> flush the instruction cache, but In SMP system, this may be different,
>>>>>> for flush_icache_range() may also need to ask the other cpus (via
>>>>>> sending ipi interrupt) to flush their icaches and will wait for them
>>>>>> till the other cpus finish their flushing.
>>>>>>
>>>>>> But as we know above, the irqs of the other cpus are disabled by
>>>>>> stop_machine(), they have no opportunity to flush their icache and
>>>>>> will let the current cpu wait for them all the time, then soft lock
>>>>>> -->  hang.
>>>>>>
>>>>>> To fix it, there are two potential solutions:
>>>>>>
>>>>>> 1. replace flush_icache_range() by something else, maybe we can use
>>>>>> the similar method in arch/x86/kernel/ftrace.c, x86 uses sync_core()
>>>>>> defined in arch/x86/include/asm/processor.h to flush the icache on all
>>>>>> processors:
>>>>>>
>>>>>> /* Stop speculative execution and prefetching of modified code. */
>>>>>> static inline void sync_core(void)
>>>>>> {
>>>>>>          int tmp;
>>>>>>
>>>>>> #if defined(CONFIG_M386) || defined(CONFIG_M486)
>>>>>>          if (boot_cpu_data.x86<  5)
>>>>>>                  /* There is no speculative execution.
>>>>>>                   * jmp is a barrier to prefetching. */
>>>>>>                  asm volatile("jmp 1f\n1:\n" ::: "memory");
>>>>>>          else
>>>>>> #endif
>>>>>>                  /* cpuid is a barrier to speculative execution.
>>>>>>                   * Prefetched instructions are automatically
>>>>>>                   * invalidated when modified. */
>>>>>>                  asm volatile("cpuid" : "=a" (tmp) : "0" (1)
>>>>>>                               : "ebx", "ecx", "edx", "memory");
>>>>>> }
>>>>>>
>>>>>> But is there a cpuid like hardware instruction in MIPS SMP? As I know,
>>>>>> in UP, we may be possible to use prefetch instruction to push the
>>>>>> instruction to the cache, but in SMP, is there a instruction to force
>>>>>> the other cpus to flush their cache too?
>>>>>>
>>>>>> 2. Replace the stop_machine() by something else
>>>>>>
>>>>>> I have written such a patch:
>>>>>>
>>>>>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>>>>>> index 2404b59..e4d058f 100644
>>>>>> --- a/kernel/trace/ftrace.c
>>>>>> +++ b/kernel/trace/ftrace.c
>>>>>> @@ -1129,13 +1129,18 @@ static int __ftrace_modify_code(void *data)
>>>>>>   static void ftrace_run_update_code(int command)
>>>>>>   {
>>>>>>          int ret;
>>>>>> +       unsigned long flags;
>>>>>>
>>>>>>          ret = ftrace_arch_code_modify_prepare();
>>>>>>          FTRACE_WARN_ON(ret);
>>>>>>          if (ret)
>>>>>>                  return;
>>>>>>
>>>>>> -       stop_machine(__ftrace_modify_code,&command, NULL);
>>>>>> +       preempt_disable();
>>>>>> +       local_irq_save(flags);
>>>>>> +       __ftrace_modify_code(&command);
>>>>>> +       local_irq_restore(flags);
>>>>>> +       preempt_enable();
>>>>>>
>>>>>>          ret = ftrace_arch_code_modify_post_process();
>>>>>>          FTRACE_WARN_ON(ret);
>>>>>>
>>>>
>>>> We may need to protect the __ftrace_modify_code() with raw spin lock.
>>>>
>>>>>> It works without any hang but I'm not sure whether it will guarantee
>>>>>> the "undefined results" problem mentioned above. Here we may need to
>>>>>> prevent the other cpus from executing the source code for we are
>>>>>> modifying the source code but also need to allow them to get the ipi
>>>>>> interrupt and flush their icaches.
>>>>>>
>>>>>> And I have took a look at the part of code modification in kgdb
>>>>>> system, seems it doesn't use stop_machine().
>>>>>>
>>>>>> What's your ideas?
>>>>>>
>>>>>> Thanks&  Regards,
>>>>>> Wu Zhangjin
>>>
>>
>>
>
>


-- 
MSN+Gtalk: wuzhangjin@gmail.com
Blog: http://falcon.oss.lzu.edu.cn
Tel:+86-18710032278
