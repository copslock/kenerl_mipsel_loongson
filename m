Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Aug 2010 18:49:27 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:48416 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490969Ab0H0QtW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Aug 2010 18:49:22 +0200
Received: by wyb38 with SMTP id 38so2323258wyb.36
        for <multiple recipients>; Fri, 27 Aug 2010 09:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=xM5wn/7XOFNWGWCPCb6J7RfrXHm+hXhDm4M9hRUfej0=;
        b=Ai3Z9dmEvYHsE/8EI13bn6Axr718404iD74wnzngJOzLI54roTPEAFYjipMLKZ27dC
         YB3XVhlWdVes1u3EV5Luks/yq8jgJonZKuNCdPlFcVJVayIjq0X+C2GPAhaC3KM+mK/y
         gPR4QncKuvgMT7EiGawn6pUPDz4+r4cUtRWnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=AkhOpR0Z0du9t/9+sOoUbgDj9Hq/Auvdy9N9jSBrOjFhg0ZWV8W6XHop/ORbz8tx42
         bsbOr7CBCie1TMZHUXeYhERgE7Jev2YOUKNU0nAh4Kr9oe7YkKex9jwDwQlcJfzEkfZA
         C6uM/onMGCfhsKcAsYEUO6rwy3DLxTdh+Vjp0=
MIME-Version: 1.0
Received: by 10.227.142.8 with SMTP id o8mr989100wbu.16.1282927750555; Fri, 27
 Aug 2010 09:49:10 -0700 (PDT)
Received: by 10.216.166.69 with HTTP; Fri, 27 Aug 2010 09:49:10 -0700 (PDT)
In-Reply-To: <1282630011-23348-1-git-send-email-wuzhangjin@gmail.com>
References: <1282630011-23348-1-git-send-email-wuzhangjin@gmail.com>
Date:   Sat, 28 Aug 2010 00:49:10 +0800
Message-ID: <AANLkTi=Me2CzPC2gcpC7ZchAJCNJ4=a7jy4fArz4JXP4@mail.gmail.com>
Subject: Re: [PATCH] tracing/ftrace: Fix the potential hang on MIPS SMP
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

This is not applicable, a revision with the new flag
machine_stop_pending instead of machine_stopped will be sent out
tomorrow.

Regards,
Wu Zhangjin

On 8/24/10, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> From: Wu Zhangjin <zhangjin.wu@windriver.com>
>
> In Ftrace, we need to flush the icache after code modification to ensure
> the instructions will be executed are exactly what we want.
>
> And for the following reason(arch/x86/kernel/ftrace.c):
>
>  * Modifying code must take extra care. On an SMP machine, if
>  * the code being modified is also being executed on another CPU
>  * that CPU will have undefined results and possibly take a GPF.
>  * We use kstop_machine to stop other CPUS from exectuing code.
>
> In SMP, the code modification are protected by stop_machine(), which
> will disables the irqs of all cpus and then modify the code, flush the
> icache.
>
> In MIPS SMP, to tell the other cpus to flush their related icache, the
> IPI interrupt must be sent to them and wait for them exiting from the
> icache flushing, but for the stop_machine() have disabled interrupts, it
> will need to wait for the other cpus all the time, then deadlock ->
> hang.
>
> (Note: cavium is an exception, benefit from its synci instruction, it
> doesn't call smp_call_function() to execute the icache flushing
> operation but send the ICACHE_FLUSH ipi to the other cpus directly, so,
> no wait and no hang on cavium, and after the irqs of the cpus are
> enabled, the pending icache flush interrupt will be filed and synci will
> flush the icache on every cpu respectively, so, no cache problem).
>
> To break this deadlock, the key is: stop calling flush_icache_range() in
> stop_machine() but delay it after stop_machine(). delaying the icache
> flushing operation doesn't influence the tracing results even if the
> other cpus execute the code just modified before the icache flushing,
> for the kernel tracing will only be enabled after users issuing:
>
> $ echo 1 > /path/to/tracing/tracing_enabled
>
> Thanks to the weak functions: ftrace_arch_code_modify_prepare() and
> ftrace_arch_code_modify_post_process(). they are called by
> ftrace_run_update_code() before and after stop_machine() respectively,
> with them, ftrace_modify_code() can check whether it is called in
> stop_machine() and if called in stop_machine(), then delay the operation
> of icache flushing, as a result, the deadlock is broken.
>
> Without this patch, Ftrace for RMI XLS will hang after issuing the
> following command:
>
> $ echo function > /path/to/tracing/current_tracer
>
> Exactly, it hangs on kernel/smp.c:
>
> void smp_call_function_many(const struct cpumask *mask,
> {
> 	[snip]
> 	/*
> 	 * Can deadlock when called with interrupts disabled.
> 	 * We allow cpu's that are not yet online though, as no one else can
> 	 * send smp call function interrupt to this cpu and as such deadlocks
> 	 * can't happen.
> 	 */
> 	WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
> 		     && !oops_in_progress);
> 	[snip]
> 	csd_lock(&data->csd);
>
> 	[snip]
> 	/* Send a message to all CPUs in the map */
> 	arch_send_call_function_ipi_mask(data->cpumask);
>
> 	/* Optionally wait for the CPUs to complete */
> 	if (wait)
> 		csd_lock_wait(&data->csd);	--> hang here
> }
>
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/kernel/ftrace.c |   22 +++++++++++++++++++++-
>  1 files changed, 21 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
> index 5a84a1f..c8ebb13 100644
> --- a/arch/mips/kernel/ftrace.c
> +++ b/arch/mips/kernel/ftrace.c
> @@ -69,6 +69,23 @@ static inline void ftrace_dyn_arch_init_insns(void)
>  #endif
>  }
>
> +#ifdef CONFIG_SMP
> +static int machine_stopped __read_mostly;
> +
> +int ftrace_arch_code_modify_prepare(void)
> +{
> +	machine_stopped = 1;
> +	return 0;
> +}
> +
> +int ftrace_arch_code_modify_post_process(void)
> +{
> +	__flush_cache_all();
> +	machine_stopped = 0;
> +	return 0;
> +}
> +#endif
> +
>  static int ftrace_modify_code(unsigned long ip, unsigned int new_code)
>  {
>  	int faulted;
> @@ -79,7 +96,10 @@ static int ftrace_modify_code(unsigned long ip, unsigned
> int new_code)
>  	if (unlikely(faulted))
>  		return -EFAULT;
>
> -	flush_icache_range(ip, ip + 8);
> +#ifdef CONFIG_SMP
> +	if (!machine_stopped)
> +#endif
> +		flush_icache_range(ip, ip + 8);
>
>  	return 0;
>  }
> --
> 1.7.0.4
>
>
>
