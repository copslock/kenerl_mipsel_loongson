Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Sep 2016 23:32:25 +0200 (CEST)
Received: from mail-io0-f179.google.com ([209.85.223.179]:36689 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991970AbcIUVcSr47PT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Sep 2016 23:32:18 +0200
Received: by mail-io0-f179.google.com with SMTP id m79so66929424ioo.3
        for <linux-mips@linux-mips.org>; Wed, 21 Sep 2016 14:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mOxBUd9MDuygTDLn6p64A12TVflWZ0yYtnvhPRns5iI=;
        b=Q4vUjpvFTRr0/HatkKPoIa04MB/oCp3xIv1NzY7xIfJYTRK9Xrb0CfdMH5T2R6X5BN
         0yTDHUyRKsJgiBCkUdiXU6Iq/sXMjqeoOIorg8v5qbEDTqcEXaL82WkxkFKSp/FykGIt
         vHOTC5ORTtzPrMlvdQjRLboqgzUFui9T2LrZLhHdKI2pRHDWbvLQ6ItqqpYLEch++f30
         TBzllTYAOxOur6sLTrRk+24Jt5t/OlJ13YcrnNckQfig3H8VWBKciEG9L788XgrF+IlQ
         qRRUnQcRBHfZuuGJs8z0vKT9rnY+KGXgBFyvJEjo5/2ryUir1xkXH13/P/w/YbZZWFLa
         cNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mOxBUd9MDuygTDLn6p64A12TVflWZ0yYtnvhPRns5iI=;
        b=e5d/+/Lp53zgg0+9oj/wS6d56m696CChvGko9aiYLfJo/3d0jgtcNyxDgZfpjSUtrz
         ulRZOKGbzoM275jmMc+j29ljkaASzvS8JV0XzCRPI66kSKIZPhe9j4hI2gBU+KbLttlG
         hos2jzYjFTf07uthvQQVMpBlKAxZYpcMvBj+LqMKv2yaYO1PGeugfyUAk7rhbX4Wuxmv
         jHhLQm1d64yx36ZQNzmNDDGNYW7T1EwBRiJYjxnvitsjg9Ikr0AlTe61J+4tdBYrXk19
         mI5enBiawPupmFZiqZdO/cYYx+FLcHAXixfyLsNJy7WTkioCaGlZvNsqiFslskeKsQwu
         1MeQ==
X-Gm-Message-State: AE9vXwNR0DEkdul85H9YMqb6he18fHIudtgWgu19hjqx0m+4hRjrEDYc4QxSlhMdI6a88kNBB7/H4ID7JOQiDQ==
X-Received: by 10.107.1.197 with SMTP id 188mr47989527iob.20.1474493533155;
 Wed, 21 Sep 2016 14:32:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.27.79 with HTTP; Wed, 21 Sep 2016 14:32:12 -0700 (PDT)
From:   Justin Chen <justinpopo6@gmail.com>
Date:   Wed, 21 Sep 2016 14:32:12 -0700
Message-ID: <CAJx26kX1ygnds8wD_L95fxwKZRiQhFAkC7DivZmvrGgjas+WLg@mail.gmail.com>
Subject: [RFC] Timing hazard in arch/mips/kernel/smp.c:start_secondary
To:     linux-mips@linux-mips.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <justinpopo6@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55225
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

Hello everyone,

I am running into a deadlock while testing bmips power management
code. Currently attempting to add power management functionality to
arch/mips/configs/bmips_stb_defconfig. The kernel locks up when coming
back from a suspend state. I am working on a bcm7435 board.

In arch/mips/kernel/smp.c:start_secondary
---
asmlinkage void start_secondary(void)
{
        ....
        set_cpu_online(cpu, true);

        set_cpu_sibling_map(cpu);
        set_cpu_core_map(cpu);

        calculate_cpu_foreign_map();

        cpumask_set_cpu(cpu, &cpu_callin_map);

        synchronise_count_slave(cpu);
        ....
}
---
The deadlock occurs because the set_cpu_online() is called before
synchronise_count_slave(). This can cause a deadlock if the boot cpu
sees that the secondary cpu is online and tries to execute a function
on it before it synchronizes with it. The boot cpu ends up waiting for
the secondary cpu to execute a function, while the secondary cpu waits
for the boot cpu to synchronise with it.

Lets assume the following occurs.

1. CPU0 starts CPU1. CPU0 starts waiting for CPU1 to start up.
CPU0 ends up at arch/mips/kernel/smp.c:__cpu_up().
---
int __cpu_up(unsigned int cpu, struct task_struct *tidle)
{
        mp_ops->boot_secondary(cpu, tidle);

        /*
         * Trust is futile.  We should really have timeouts ...
         */
        while (!cpumask_test_cpu(cpu, &cpu_callin_map)) {
                udelay(100);
                schedule();
        }

        synchronise_count_master(cpu);
        return 0;
}
---
While CPU0 waits for CPU1 it schedules another thread.

2. CPU0 begins executing a new thread and eventually ends up at
kernel/smp.c:smp_call_function_many()
---
void smp_call_function_many(const struct cpumask *mask,
                            smp_call_func_t func, void *info, bool wait)
{
        ....
        /* No online cpus?  We're done. */
        if (cpu >= nr_cpu_ids)
                return;

        /* Do we have another CPU which isn't us? */
        next_cpu = cpumask_next_and(cpu, mask, cpu_online_mask);
        if (next_cpu == this_cpu)
                next_cpu = cpumask_next_and(next_cpu, mask, cpu_online_mask);

        /* Fastpath: do that cpu by itself. */
        if (next_cpu >= nr_cpu_ids) {
                smp_call_function_single(cpu, func, info, wait);
                return;
        }
        ....
}
---
3. CPU1 executes set_cpu_online() and blocks at
synchronise_count_slave(). Thus CPU1 is blocked, however it tells
everyone it is online.

4. CPU0(in kernel/smp.c:smp_call_function_many()) sees that one CPU is
online and attempts to a run a function on that CPU(which is CPU1).
CPU0 then blocks with no preempt and irqs off. Thus both CPUs are
deadlocked.
CPU0 is blocked at smp_call_function_single()
CPU1 is blocked at synchronise_count_slave()

I am running into this issue with this execution.
kernel/power/standby.c: suspend_enter()
kernel/power/standby.c: syscore_resume() (Coming out of suspend, only 1 cpu up)
kernel/time/timekeeping.c: timekeeping_resume() (syscore calls the
timekeeping resume hook)
kernel/time/hrtimer.c: hrtimer_resume()
kernel/time/hrtimer.c: clock_was_set_delayed() (We schedule some work for later)
...
CPU0 then starts up CPU1
arch/mips/kernel/smp.c: __cpu_up() (Comes here and decides to schedule
the hrtimer thread)
kernel/time/hrtimer.c: clock_was_set_work()
kernel/time/hrtimer.c: clock_was_set()
kernel/time/hrtimer.c: on_each_cpu() (and this is where we get screwed)
...
kernel/smp.c: smp_call_function_many() (Eventually gets here and
blocks if CPU1 already executed set_cpu_online())

The deadlock doesn't happen when I test pm with no_console_suspend. I
am assuming this happens because things get printed out before
"set_cpu_online()" gets executed. Thus delaying the timing. Then CPU0
does not see that CPU1 is online when running
"smp_call_function_many()".

Am I seeing this correctly? What would be the proper fix to this?

Thanks,
Justin
