Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jun 2012 10:25:44 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:62994 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903616Ab2FCIZj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Jun 2012 10:25:39 +0200
Received: by pbbrq13 with SMTP id rq13so5197462pbb.36
        for <multiple recipients>; Sun, 03 Jun 2012 01:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=J/uBad80stU0KPfYA0lW8I/VP6BYA0dr19dGkNJmjlQ=;
        b=Ro4Vh/IUY39fjjv896HT4kMCtl9fp5GZsQk7p/nGgjBI9gsM2uxHukLaFBAj0pS+I4
         dRUi6R/haK3FBWPSuYMFFjWU/MLc68v2/UZ1Q/5HoBbtA+0qBQ+a1TnXME2bud8GAHLT
         3lhfZBcG9FdP3egT/iBmtKw6Gfno16B9KWpiVj9QirszqAGjULHGK7h0mpoJkN7McqPH
         avQuhsTHd6FX0vCPFV6A+sFFvCyALbIkq5wQZlN0DMiS4S5j78F75aa6XTdQcqTTayBj
         uitB1js91N6dNPlCPmTf+XU1uQsvyWVB6x3lgBTdiJFsJv+UJMKfoAinaaj7kOLoW3w+
         JxqA==
Received: by 10.68.232.103 with SMTP id tn7mr27131837pbc.86.1338711931773;
        Sun, 03 Jun 2012 01:25:31 -0700 (PDT)
Received: from localhost ([221.223.120.44])
        by mx.google.com with ESMTPS id io2sm8904976pbc.24.2012.06.03.01.25.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Jun 2012 01:25:29 -0700 (PDT)
Date:   Sun, 3 Jun 2012 16:25:07 +0800
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc:     tglx@linutronix.de, peterz@infradead.org,
        paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au,
        mingo@kernel.org, akpm@linux-foundation.org,
        vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, nikunj@linux.vnet.ibm.com,
        Ralf Baechle <ralf@linux-mips.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Mike Frysinger <vapier@gentoo.org>,
        David Howells <dhowells@redhat.com>,
        Arun Sharma <asharma@fb.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 10/27] mips, smpboot: Use generic SMP booting
 infrastructure
Message-ID: <20120603082507.GA16829@zhy>
Reply-To: Yong Zhang <yong.zhang0@gmail.com>
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
 <20120601091226.31979.62223.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20120601091226.31979.62223.stgit@srivatsabhat.in.ibm.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 33507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, Jun 01, 2012 at 02:42:32PM +0530, Srivatsa S. Bhat wrote:
> Convert mips to use the generic framework to boot secondary CPUs.
> 
> Notes:
> 1. The boot processor was setting the secondary cpu in cpu_online_mask!
> Instead, leave it up to the secondary cpu (... and it will be done by the
> generic code now).
> 
> 2. Make the boot cpu wait for the secondary cpu to be set in cpu_online_mask
> before returning.

We don't need to wait for both cpu_callin_map (The code above yours)
any more.

> 
> 3. Don't enable interrupts in cmp_smp_finish() and vsmp_smp_finish().
> Do it much later, in generic code.

Hmmm... the bad thing is that some board enable irq more early than
->smp_finish(), I have sent patches for that (by moving irq enable
to smp_finish() and delaying smp_finish()).
Please check patch#0001~patch#0004 in
http://marc.info/?l=linux-mips&m=133758022710973&w=2

> 
> 4. In synchronise_count_slave(), use local_save_flags() instead of
> local_irq_save() because irqs are still disabled.

We can just remove local_irq_save()/local_irq_restore() like:
http://marc.info/?l=linux-mips&m=133758046211043&w=2

Thanks,
Yong

> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Eric Dumazet <eric.dumazet@gmail.com>
> Cc: Mike Frysinger <vapier@gentoo.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Arun Sharma <asharma@fb.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---
> 
>  arch/mips/kernel/smp-cmp.c  |    8 ++++----
>  arch/mips/kernel/smp-mt.c   |    2 --
>  arch/mips/kernel/smp.c      |   23 +++++++++++++++--------
>  arch/mips/kernel/sync-r4k.c |    3 ++-
>  4 files changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
> index e7e03ec..7ecd6db 100644
> --- a/arch/mips/kernel/smp-cmp.c
> +++ b/arch/mips/kernel/smp-cmp.c
> @@ -108,7 +108,9 @@ static void cmp_init_secondary(void)
>  
>  static void cmp_smp_finish(void)
>  {
> -	pr_debug("SMPCMP: CPU%d: %s\n", smp_processor_id(), __func__);
> +	unsigned int cpu = smp_processor_id();
> +
> +	pr_debug("SMPCMP: CPU%d: %s\n", cpu, __func__);
>  
>  	/* CDFIXME: remove this? */
>  	write_c0_compare(read_c0_count() + (8 * mips_hpt_frequency / HZ));
> @@ -116,10 +118,8 @@ static void cmp_smp_finish(void)
>  #ifdef CONFIG_MIPS_MT_FPAFF
>  	/* If we have an FPU, enroll ourselves in the FPU-full mask */
>  	if (cpu_has_fpu)
> -		cpu_set(smp_processor_id(), mt_fpu_cpumask);
> +		cpumask_set_cpu(cpu, &mt_fpu_cpumask);
>  #endif /* CONFIG_MIPS_MT_FPAFF */
> -
> -	local_irq_enable();
>  }
>  
>  static void cmp_cpus_done(void)
> diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
> index ff17868..25f7b09 100644
> --- a/arch/mips/kernel/smp-mt.c
> +++ b/arch/mips/kernel/smp-mt.c
> @@ -171,8 +171,6 @@ static void __cpuinit vsmp_smp_finish(void)
>  	if (cpu_has_fpu)
>  		cpu_set(smp_processor_id(), mt_fpu_cpumask);
>  #endif /* CONFIG_MIPS_MT_FPAFF */
> -
> -	local_irq_enable();
>  }
>  
>  static void vsmp_cpus_done(void)
> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> index 71a95f5..4453d4d 100644
> --- a/arch/mips/kernel/smp.c
> +++ b/arch/mips/kernel/smp.c
> @@ -33,6 +33,7 @@
>  #include <linux/cpu.h>
>  #include <linux/err.h>
>  #include <linux/ftrace.h>
> +#include <linux/smpboot.h>
>  
>  #include <linux/atomic.h>
>  #include <asm/cpu.h>
> @@ -98,8 +99,11 @@ __cpuinit void register_smp_ops(struct plat_smp_ops *ops)
>   */
>  asmlinkage __cpuinit void start_secondary(void)
>  {
> -	unsigned int cpu;
> +	smpboot_start_secondary(NULL);
> +}
>  
> +void __cpuinit __cpu_pre_starting(void *unused)
> +{
>  #ifdef CONFIG_MIPS_MT_SMTC
>  	/* Only do cpu_probe for first TC of CPU */
>  	if ((read_c0_tcbind() & TCBIND_CURTC) == 0)
> @@ -116,20 +120,22 @@ asmlinkage __cpuinit void start_secondary(void)
>  	 */
>  
>  	calibrate_delay();
> -	preempt_disable();
> -	cpu = smp_processor_id();
> -	cpu_data[cpu].udelay_val = loops_per_jiffy;
> +	cpu_data[smp_processor_id()].udelay_val = loops_per_jiffy;
> +}
>  
> -	notify_cpu_starting(cpu);
> +void __cpuinit __cpu_pre_online(void *unused)
> +{
> +	unsigned int cpu = smp_processor_id();
>  
>  	mp_ops->smp_finish();
>  	set_cpu_sibling_map(cpu);
>  
>  	cpu_set(cpu, cpu_callin_map);
> +}
>  
> +void __cpuinit __cpu_post_online(void *unused)
> +{
>  	synchronise_count_slave();
> -
> -	cpu_idle();
>  }
>  
>  /*
> @@ -196,7 +202,8 @@ int __cpuinit __cpu_up(unsigned int cpu, struct task_struct *tidle)
>  	while (!cpu_isset(cpu, cpu_callin_map))
>  		udelay(100);
>  
> -	set_cpu_online(cpu, true);
> +	while (!cpu_online(cpu))
> +		udelay(100);
>  
>  	return 0;
>  }
> diff --git a/arch/mips/kernel/sync-r4k.c b/arch/mips/kernel/sync-r4k.c
> index 99f913c..7f43069 100644
> --- a/arch/mips/kernel/sync-r4k.c
> +++ b/arch/mips/kernel/sync-r4k.c
> @@ -46,7 +46,8 @@ void __cpuinit synchronise_count_master(void)
>  	printk(KERN_INFO "Synchronize counters across %u CPUs: ",
>  	       num_online_cpus());
>  
> -	local_irq_save(flags);
> +	/* IRQs are already disabled. So just save the flags */
> +	local_save_flags(flags);
>  
>  	/*
>  	 * Notify the slaves that it's time to start
