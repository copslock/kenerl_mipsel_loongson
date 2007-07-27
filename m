Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jul 2007 13:55:44 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:28105 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022461AbXG0Mzm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Jul 2007 13:55:42 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6RCtePH006191;
	Fri, 27 Jul 2007 13:55:40 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6RCtX7W006190;
	Fri, 27 Jul 2007 13:55:33 +0100
Date:	Fri, 27 Jul 2007 13:55:33 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Stephane Eranian <eranian@hpl.hp.com>
Cc:	linux-kernel@vger.kernel.org, mucci@cs.utk.edu,
	linux-mips@linux-mips.org, ak@suse.de, akpm@linux-foundation.org
Subject: Re: [PATCH] MIPS: add smp_call_function_single()
Message-ID: <20070727125533.GD5118@linux-mips.org>
References: <20070727124451.GC9828@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070727124451.GC9828@frankl.hpl.hp.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 27, 2007 at 05:44:51AM -0700, Stephane Eranian wrote:

> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> index be7362b..9e376e2 100644
> --- a/arch/mips/kernel/smp.c
> +++ b/arch/mips/kernel/smp.c
> @@ -193,6 +193,53 @@ void smp_call_function_interrupt(void)
>  	}
>  }
>  
> +int smp_call_function_single(int cpu, void (*func) (void *info), void *info, int retry,
> +			     int wait)
> +{
> +  struct call_data_struct data;
> +  int me = smp_processor_id();
> +
> +  /*
> +     * Can die spectacularly if this CPU isn't yet marked online
> +      */
> +  BUG_ON(!cpu_online(me));
> +  if (cpu == me) {
> +    WARN_ON(1);
> +    return -EBUSY;
> +    }
> +
> +  /* Can deadlock when called with interrupts disabled */
> +  WARN_ON(irqs_disabled());
> +
> +  data.func = func;
> +  data.info = info;
> +  atomic_set(&data.started, 0);
> +  data.wait = wait;
> +  if (wait)
> +    atomic_set(&data.finished, 0);
> +
> +  spin_lock(&smp_call_lock);
> +  call_data = &data;
> +  mb();
> +
> +  /* Send a message to the other CPU */
> +  core_send_ipi(cpu, SMP_CALL_FUNCTION);
> +
> +  /* Wait for response */
> +  /* FIXME: lock-up detection, backtrace on lock-up */
> +  while (atomic_read(&data.started) != 1)
> +    barrier();
> +
> +  if (wait)
> +    while (atomic_read(&data.finished) != 1)
> +      barrier();
> +  call_data = NULL;
> +  spin_unlock(&smp_call_lock);
> +
> +  return 0;
> +}
> +EXPORT_SYMBOL(smp_call_function_single);

Please fix the indentation to use tabs as per Documentation/CodingStyle.

>  static void stop_this_cpu(void *dummy)
>  {
>  	/*
> diff --git a/include/asm-mips/smp.h b/include/asm-mips/smp.h
> index 13aef6a..5acbf38 100644
> --- a/include/asm-mips/smp.h
> +++ b/include/asm-mips/smp.h
> @@ -102,6 +102,8 @@ static inline void smp_send_reschedule(int cpu)
>  	core_send_ipi(cpu, SMP_RESCHEDULE_YOURSELF);
>  }
>  
> +extern int smp_call_function_single(int cpuid, void (*func) (void *info),
> +				void *info, int retry, int wait);

The function is already declared in include/linux/smp.h so this segment
is unecessary.

  Ralf
