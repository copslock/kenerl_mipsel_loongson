Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Sep 2016 18:16:01 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:27387 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992143AbcIVQPzKWZaO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Sep 2016 18:15:55 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 981A81944E6C9;
        Thu, 22 Sep 2016 17:15:44 +0100 (IST)
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 22 Sep
 2016 17:15:47 +0100
Subject: Re: [RFC] Timing hazard in arch/mips/kernel/smp.c:start_secondary
To:     Justin Chen <justinpopo6@gmail.com>, <linux-mips@linux-mips.org>
References: <CAJx26kX1ygnds8wD_L95fxwKZRiQhFAkC7DivZmvrGgjas+WLg@mail.gmail.com>
CC:     Florian Fainelli <f.fainelli@gmail.com>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <de7895bb-c8c3-65b0-392d-d0618a1e074d@imgtec.com>
Date:   Thu, 22 Sep 2016 17:15:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAJx26kX1ygnds8wD_L95fxwKZRiQhFAkC7DivZmvrGgjas+WLg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Hi Justin,

Nice catch! Funnily enough I ran into the same deadlock today so your 
debugging helped arrive at a quick solution. The following patch fixes 
the issue for me, does it fix it for you?


     MIPS: smp: Fix possibility of deadlock when bringing CPUs online

     This patch fixes the possibility of a deadlock when bringing up
     secondary CPUs.
     The deadlock occurs because the set_cpu_online() is called before
     synchronise_count_slave(). This can cause a deadlock if the boot CPU,
     having scheduled another thread, attempts to send an IPI to the
     secondary CPU, which it sees has been marked online. The secondary is
     blocked in synchronise_count_slave() waiting for the boot CPU to enter
     synchronise_count_master(), but the boot cpu is blocked in
     smp_call_function_many() waiting for the secondary to respond to it's
     IPI request.

     Fix this by marking the CPU online in cpu_callin_map and synchronising
     counters before declaring the CPU online and calculating the maps for
     IPIs.

     Cc: stable@vger.kernel.org # v4.2+
     Reported-by: Justin Chen <justinpopo6@gmail.com>
     Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index f95f094f36e4..b0baf48951fa 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -322,6 +322,9 @@ asmlinkage void start_secondary(void)
         cpumask_set_cpu(cpu, &cpu_coherent_mask);
         notify_cpu_starting(cpu);

+       cpumask_set_cpu(cpu, &cpu_callin_map);
+       synchronise_count_slave(cpu);
+
         set_cpu_online(cpu, true);

         set_cpu_sibling_map(cpu);
@@ -329,10 +332,6 @@ asmlinkage void start_secondary(void)

         calculate_cpu_foreign_map();

-       cpumask_set_cpu(cpu, &cpu_callin_map);
-
-       synchronise_count_slave(cpu);
-
         /*
          * irq will be enabled in ->smp_finish(), enabling it too early
          * is dangerous.
~

If so, I will send the patch to Ralf.

Thanks,

Matt



On 21/09/16 22:32, Justin Chen wrote:
> Hello everyone,
>
> I am running into a deadlock while testing bmips power management
> code. Currently attempting to add power management functionality to
> arch/mips/configs/bmips_stb_defconfig. The kernel locks up when coming
> back from a suspend state. I am working on a bcm7435 board.
>
> In arch/mips/kernel/smp.c:start_secondary
> ---
> asmlinkage void start_secondary(void)
> {
>          ....
>          set_cpu_online(cpu, true);
>
>          set_cpu_sibling_map(cpu);
>          set_cpu_core_map(cpu);
>
>          calculate_cpu_foreign_map();
>
>          cpumask_set_cpu(cpu, &cpu_callin_map);
>
>          synchronise_count_slave(cpu);
>          ....
> }
> ---
> The deadlock occurs because the set_cpu_online() is called before
> synchronise_count_slave(). This can cause a deadlock if the boot cpu
> sees that the secondary cpu is online and tries to execute a function
> on it before it synchronizes with it. The boot cpu ends up waiting for
> the secondary cpu to execute a function, while the secondary cpu waits
> for the boot cpu to synchronise with it.
>
> Lets assume the following occurs.
>
> 1. CPU0 starts CPU1. CPU0 starts waiting for CPU1 to start up.
> CPU0 ends up at arch/mips/kernel/smp.c:__cpu_up().
> ---
> int __cpu_up(unsigned int cpu, struct task_struct *tidle)
> {
>          mp_ops->boot_secondary(cpu, tidle);
>
>          /*
>           * Trust is futile.  We should really have timeouts ...
>           */
>          while (!cpumask_test_cpu(cpu, &cpu_callin_map)) {
>                  udelay(100);
>                  schedule();
>          }
>
>          synchronise_count_master(cpu);
>          return 0;
> }
> ---
> While CPU0 waits for CPU1 it schedules another thread.
>
> 2. CPU0 begins executing a new thread and eventually ends up at
> kernel/smp.c:smp_call_function_many()
> ---
> void smp_call_function_many(const struct cpumask *mask,
>                              smp_call_func_t func, void *info, bool wait)
> {
>          ....
>          /* No online cpus?  We're done. */
>          if (cpu >= nr_cpu_ids)
>                  return;
>
>          /* Do we have another CPU which isn't us? */
>          next_cpu = cpumask_next_and(cpu, mask, cpu_online_mask);
>          if (next_cpu == this_cpu)
>                  next_cpu = cpumask_next_and(next_cpu, mask, cpu_online_mask);
>
>          /* Fastpath: do that cpu by itself. */
>          if (next_cpu >= nr_cpu_ids) {
>                  smp_call_function_single(cpu, func, info, wait);
>                  return;
>          }
>          ....
> }
> ---
> 3. CPU1 executes set_cpu_online() and blocks at
> synchronise_count_slave(). Thus CPU1 is blocked, however it tells
> everyone it is online.
>
> 4. CPU0(in kernel/smp.c:smp_call_function_many()) sees that one CPU is
> online and attempts to a run a function on that CPU(which is CPU1).
> CPU0 then blocks with no preempt and irqs off. Thus both CPUs are
> deadlocked.
> CPU0 is blocked at smp_call_function_single()
> CPU1 is blocked at synchronise_count_slave()
>
> I am running into this issue with this execution.
> kernel/power/standby.c: suspend_enter()
> kernel/power/standby.c: syscore_resume() (Coming out of suspend, only 1 cpu up)
> kernel/time/timekeeping.c: timekeeping_resume() (syscore calls the
> timekeeping resume hook)
> kernel/time/hrtimer.c: hrtimer_resume()
> kernel/time/hrtimer.c: clock_was_set_delayed() (We schedule some work for later)
> ...
> CPU0 then starts up CPU1
> arch/mips/kernel/smp.c: __cpu_up() (Comes here and decides to schedule
> the hrtimer thread)
> kernel/time/hrtimer.c: clock_was_set_work()
> kernel/time/hrtimer.c: clock_was_set()
> kernel/time/hrtimer.c: on_each_cpu() (and this is where we get screwed)
> ...
> kernel/smp.c: smp_call_function_many() (Eventually gets here and
> blocks if CPU1 already executed set_cpu_online())
>
> The deadlock doesn't happen when I test pm with no_console_suspend. I
> am assuming this happens because things get printed out before
> "set_cpu_online()" gets executed. Thus delaying the timing. Then CPU0
> does not see that CPU1 is online when running
> "smp_call_function_many()".
>
> Am I seeing this correctly? What would be the proper fix to this?
>
> Thanks,
> Justin
>
