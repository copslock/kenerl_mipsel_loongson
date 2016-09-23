Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Sep 2016 18:56:35 +0200 (CEST)
Received: from mail-ua0-f196.google.com ([209.85.217.196]:35313 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991932AbcIWQ41cGZUg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Sep 2016 18:56:27 +0200
Received: by mail-ua0-f196.google.com with SMTP id 107so1944569uah.2
        for <linux-mips@linux-mips.org>; Fri, 23 Sep 2016 09:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VP8scMiqMytfKjHOpj/z8+Kzzquzc2DkxGa2Ksyjifw=;
        b=z3N22YCbNcfbrmx6N2b1sD68y1ILHn04tU/2da6DnWnRrC29GitCKm1XWAN9aXN7W4
         e7HCLHJqhVkE9uePzfTb8psrOhfIbFalB/GZ5qcWzpjiwVxX9KaEYivjyY4TrqZoYOS+
         oCudkfgHAv9pd9DPiynjWcd8USzbenSyX4+Z8pcKfYP0u3tLLzj/1rRi31Ryukc+yM4u
         0AzJo3ix2ESKexOxein17yXy+ujKT0fh6g3teDpRXlQqSLzoGU5CE+S8co7BX3/gZGsj
         NNHYhmv9UQpCT2radVdRycbbp4PgUnIgBsytu+l1r9gVQcXbYwxBdTsXgwDTW46EQX+H
         4KCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VP8scMiqMytfKjHOpj/z8+Kzzquzc2DkxGa2Ksyjifw=;
        b=cPH9pjKcHAnxVXGdZOlKj/qJLXGtp4jqTmqSiJQcUvLfmAFl/6WKSb/ho7kHIX0itp
         hXoWB7SycmN3ze2N/Uts59GorKmHjrYJpm7kEO2Y52dzAarT3/sdBPW/ICcGwxSA8A0I
         FND1aNFYXs5jCi+Nepcf4xkTB7LIe9CVslOrKTqRTePmz+mwFdaAaPTL6VbmRPDo+VlM
         rKUQdXDaYDJUnMPVlnLfFUfFc7gt/vCcm8hpNPNtlDlGlxMh2wMbAAzzCxAFbOul7tfs
         vrrsA8Qmv1SZGnAxPFne6OtgA6a13GmVSi1bD2gpgQPCBTuvXAjJ/SBh27mUpLlpoy5D
         oP0w==
X-Gm-Message-State: AA6/9Rnj7pmdIkkceD3Cj8ra6AKVXL3JCxjh9YYCFJuwSTVqdaEETfC8tL+sDtyaJxk8IkDG7PSN/yD7n5I+jA==
X-Received: by 10.176.4.6 with SMTP id 6mr5523546uav.151.1474649781640; Fri,
 23 Sep 2016 09:56:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.48.8 with HTTP; Fri, 23 Sep 2016 09:56:21 -0700 (PDT)
In-Reply-To: <ad31e755-953e-657a-1fe3-06b6e3e260de@imgtec.com>
References: <CAJx26kX1ygnds8wD_L95fxwKZRiQhFAkC7DivZmvrGgjas+WLg@mail.gmail.com>
 <de7895bb-c8c3-65b0-392d-d0618a1e074d@imgtec.com> <CAJx26kU2bSz62J544E7iyZd0oDJ8Q8YR8pSU0oThWqUpi_9=pg@mail.gmail.com>
 <ad31e755-953e-657a-1fe3-06b6e3e260de@imgtec.com>
From:   Justin Chen <justinpopo6@gmail.com>
Date:   Fri, 23 Sep 2016 09:56:21 -0700
Message-ID: <CAJx26kVCbWta9nOffqbnQxbeHd7r0PEwCdR257WDuMTxs+qMqw@mail.gmail.com>
Subject: Re: [RFC] Timing hazard in arch/mips/kernel/smp.c:start_secondary
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     linux-mips@linux-mips.org, Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <justinpopo6@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: justinpopo6@gmail.com
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

On Fri, Sep 23, 2016 at 3:07 AM, Matt Redfearn <matt.redfearn@imgtec.com> wrote:
>
> On 22/09/16 19:04, Justin Chen wrote:
>>
>> On Thu, Sep 22, 2016 at 9:15 AM, Matt Redfearn <matt.redfearn@imgtec.com>
>> wrote:
>>>
>>> Hi Justin,
>>>
>>> Nice catch! Funnily enough I ran into the same deadlock today so your
>>> debugging helped arrive at a quick solution. The following patch fixes
>>> the
>>> issue for me, does it fix it for you?
>>
>> Awesome! Yup, this fixes it for me. I am using a 4.1 kernel, so maybe
>> we can send the patch to v4.1+? or maybe earlier?
>>
>> Thanks Matt!
>
>
> Hi Justin,
> Great! The patch depends on "MIPS: c-r4k: Fix cache flushing for MT cores"
> for context, which was only backported as far as 4.1, so I will mark the
> patch for 4.1 onwards. Am I OK to add your Tested-by?
Alright sounds good. Sure.
>
> Thanks,
> Matt
>
>
>
>
>>>
>>>      MIPS: smp: Fix possibility of deadlock when bringing CPUs online
>>>
>>>      This patch fixes the possibility of a deadlock when bringing up
>>>      secondary CPUs.
>>>      The deadlock occurs because the set_cpu_online() is called before
>>>      synchronise_count_slave(). This can cause a deadlock if the boot
>>> CPU,
>>>      having scheduled another thread, attempts to send an IPI to the
>>>      secondary CPU, which it sees has been marked online. The secondary
>>> is
>>>      blocked in synchronise_count_slave() waiting for the boot CPU to
>>> enter
>>>      synchronise_count_master(), but the boot cpu is blocked in
>>>      smp_call_function_many() waiting for the secondary to respond to
>>> it's
>>>      IPI request.
>>>
>>>      Fix this by marking the CPU online in cpu_callin_map and
>>> synchronising
>>>      counters before declaring the CPU online and calculating the maps
>>> for
>>>      IPIs.
>>>
>>>      Cc: stable@vger.kernel.org # v4.2+
>>>      Reported-by: Justin Chen <justinpopo6@gmail.com>
>>>      Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>>>
>>> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
>>> index f95f094f36e4..b0baf48951fa 100644
>>> --- a/arch/mips/kernel/smp.c
>>> +++ b/arch/mips/kernel/smp.c
>>> @@ -322,6 +322,9 @@ asmlinkage void start_secondary(void)
>>>          cpumask_set_cpu(cpu, &cpu_coherent_mask);
>>>          notify_cpu_starting(cpu);
>>>
>>> +       cpumask_set_cpu(cpu, &cpu_callin_map);
>>> +       synchronise_count_slave(cpu);
>>> +
>>>          set_cpu_online(cpu, true);
>>>
>>>          set_cpu_sibling_map(cpu);
>>> @@ -329,10 +332,6 @@ asmlinkage void start_secondary(void)
>>>
>>>          calculate_cpu_foreign_map();
>>>
>>> -       cpumask_set_cpu(cpu, &cpu_callin_map);
>>> -
>>> -       synchronise_count_slave(cpu);
>>> -
>>>          /*
>>>           * irq will be enabled in ->smp_finish(), enabling it too early
>>>           * is dangerous.
>>> ~
>>>
>>> If so, I will send the patch to Ralf.
>>>
>>> Thanks,
>>>
>>> Matt
>>>
>>>
>>>
>>>
>>> On 21/09/16 22:32, Justin Chen wrote:
>>>>
>>>> Hello everyone,
>>>>
>>>> I am running into a deadlock while testing bmips power management
>>>> code. Currently attempting to add power management functionality to
>>>> arch/mips/configs/bmips_stb_defconfig. The kernel locks up when coming
>>>> back from a suspend state. I am working on a bcm7435 board.
>>>>
>>>> In arch/mips/kernel/smp.c:start_secondary
>>>> ---
>>>> asmlinkage void start_secondary(void)
>>>> {
>>>>           ....
>>>>           set_cpu_online(cpu, true);
>>>>
>>>>           set_cpu_sibling_map(cpu);
>>>>           set_cpu_core_map(cpu);
>>>>
>>>>           calculate_cpu_foreign_map();
>>>>
>>>>           cpumask_set_cpu(cpu, &cpu_callin_map);
>>>>
>>>>           synchronise_count_slave(cpu);
>>>>           ....
>>>> }
>>>> ---
>>>> The deadlock occurs because the set_cpu_online() is called before
>>>> synchronise_count_slave(). This can cause a deadlock if the boot cpu
>>>> sees that the secondary cpu is online and tries to execute a function
>>>> on it before it synchronizes with it. The boot cpu ends up waiting for
>>>> the secondary cpu to execute a function, while the secondary cpu waits
>>>> for the boot cpu to synchronise with it.
>>>>
>>>> Lets assume the following occurs.
>>>>
>>>> 1. CPU0 starts CPU1. CPU0 starts waiting for CPU1 to start up.
>>>> CPU0 ends up at arch/mips/kernel/smp.c:__cpu_up().
>>>> ---
>>>> int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>>>> {
>>>>           mp_ops->boot_secondary(cpu, tidle);
>>>>
>>>>           /*
>>>>            * Trust is futile.  We should really have timeouts ...
>>>>            */
>>>>           while (!cpumask_test_cpu(cpu, &cpu_callin_map)) {
>>>>                   udelay(100);
>>>>                   schedule();
>>>>           }
>>>>
>>>>           synchronise_count_master(cpu);
>>>>           return 0;
>>>> }
>>>> ---
>>>> While CPU0 waits for CPU1 it schedules another thread.
>>>>
>>>> 2. CPU0 begins executing a new thread and eventually ends up at
>>>> kernel/smp.c:smp_call_function_many()
>>>> ---
>>>> void smp_call_function_many(const struct cpumask *mask,
>>>>                               smp_call_func_t func, void *info, bool
>>>> wait)
>>>> {
>>>>           ....
>>>>           /* No online cpus?  We're done. */
>>>>           if (cpu >= nr_cpu_ids)
>>>>                   return;
>>>>
>>>>           /* Do we have another CPU which isn't us? */
>>>>           next_cpu = cpumask_next_and(cpu, mask, cpu_online_mask);
>>>>           if (next_cpu == this_cpu)
>>>>                   next_cpu = cpumask_next_and(next_cpu, mask,
>>>> cpu_online_mask);
>>>>
>>>>           /* Fastpath: do that cpu by itself. */
>>>>           if (next_cpu >= nr_cpu_ids) {
>>>>                   smp_call_function_single(cpu, func, info, wait);
>>>>                   return;
>>>>           }
>>>>           ....
>>>> }
>>>> ---
>>>> 3. CPU1 executes set_cpu_online() and blocks at
>>>> synchronise_count_slave(). Thus CPU1 is blocked, however it tells
>>>> everyone it is online.
>>>>
>>>> 4. CPU0(in kernel/smp.c:smp_call_function_many()) sees that one CPU is
>>>> online and attempts to a run a function on that CPU(which is CPU1).
>>>> CPU0 then blocks with no preempt and irqs off. Thus both CPUs are
>>>> deadlocked.
>>>> CPU0 is blocked at smp_call_function_single()
>>>> CPU1 is blocked at synchronise_count_slave()
>>>>
>>>> I am running into this issue with this execution.
>>>> kernel/power/standby.c: suspend_enter()
>>>> kernel/power/standby.c: syscore_resume() (Coming out of suspend, only 1
>>>> cpu up)
>>>> kernel/time/timekeeping.c: timekeeping_resume() (syscore calls the
>>>> timekeeping resume hook)
>>>> kernel/time/hrtimer.c: hrtimer_resume()
>>>> kernel/time/hrtimer.c: clock_was_set_delayed() (We schedule some work
>>>> for
>>>> later)
>>>> ...
>>>> CPU0 then starts up CPU1
>>>> arch/mips/kernel/smp.c: __cpu_up() (Comes here and decides to schedule
>>>> the hrtimer thread)
>>>> kernel/time/hrtimer.c: clock_was_set_work()
>>>> kernel/time/hrtimer.c: clock_was_set()
>>>> kernel/time/hrtimer.c: on_each_cpu() (and this is where we get screwed)
>>>> ...
>>>> kernel/smp.c: smp_call_function_many() (Eventually gets here and
>>>> blocks if CPU1 already executed set_cpu_online())
>>>>
>>>> The deadlock doesn't happen when I test pm with no_console_suspend. I
>>>> am assuming this happens because things get printed out before
>>>> "set_cpu_online()" gets executed. Thus delaying the timing. Then CPU0
>>>> does not see that CPU1 is online when running
>>>> "smp_call_function_many()".
>>>>
>>>> Am I seeing this correctly? What would be the proper fix to this?
>>>>
>>>> Thanks,
>>>> Justin
>>>>
>
