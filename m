Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jul 2007 10:21:33 +0100 (BST)
Received: from mtagate5.de.ibm.com ([195.212.29.154]:59732 "EHLO
	mtagate5.de.ibm.com") by ftp.linux-mips.org with ESMTP
	id S20022050AbXG1JVa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 28 Jul 2007 10:21:30 +0100
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6S9KOoT773982;
	Sat, 28 Jul 2007 09:20:24 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com [9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6S9KGH01327174;
	Sat, 28 Jul 2007 11:20:24 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6S9Jx2C021908;
	Sat, 28 Jul 2007 11:20:00 +0200
Received: from localhost (dyn-9-152-198-42.boeblingen.de.ibm.com [9.152.198.42])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id l6S9JxuN021781;
	Sat, 28 Jul 2007 11:19:59 +0200
Date:	Sat, 28 Jul 2007 11:19:50 +0200
From:	Heiko Carstens <heiko.carstens@de.ibm.com>
To:	Stephane Eranian <eranian@hpl.hp.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
	mucci@cs.utk.edu, linux-mips@linux-mips.org, ak@suse.de,
	akpm@linux-foundation.org, Tony Luck <tony.luck@intel.com>,
	Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] MIPS: add smp_call_function_single()
Message-ID: <20070728091950.GA4642@osiris.boeblingen.de.ibm.com>
References: <20070727124451.GC9828@frankl.hpl.hp.com> <20070727125533.GD5118@linux-mips.org> <20070727135323.GF9828@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070727135323.GF9828@frankl.hpl.hp.com>
User-Agent: Mutt/1.5.15 (2007-04-06)
Return-Path: <heiko.carstens@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: heiko.carstens@de.ibm.com
Precedence: bulk
X-list: linux-mips

On Fri, Jul 27, 2007 at 06:53:23AM -0700, Stephane Eranian wrote:
> Ralf,
> 
> Here is take 2.
> 
> [MIPS] add smp_call_function_single (take 2)
> 
> signed-off-by: Stephane Eranian <eranian@hpl.hp.com>
> signed-off-by: Phil Mucci <mucci@cs.utk.edu>
> 
> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> index be7362b..d47234c 100644
> --- a/arch/mips/kernel/smp.c
> +++ b/arch/mips/kernel/smp.c
> @@ -193,6 +193,53 @@ void smp_call_function_interrupt(void)
>  	}
>  }
> 
> +int smp_call_function_single(int cpu, void (*func) (void *info), void *info, int retry,
> +			     int wait)
> +{
> +	struct call_data_struct data;
> +	int me = smp_processor_id();
> +
> +	/*
> +	 * Can die spectacularly if this CPU isn't yet marked online
> +	 */
> +	BUG_ON(!cpu_online(me));
> +	if (cpu == me) {
> +		WARN_ON(1);
> +		return -EBUSY;
> +	}
> +
> +	/* Can deadlock when called with interrupts disabled */
> +	WARN_ON(irqs_disabled());
> +
> +	data.func = func;
> +	data.info = info;
> +	atomic_set(&data.started, 0);
> +	data.wait = wait;
> +	if (wait)
> +		atomic_set(&data.finished, 0);
> +
> +	spin_lock(&smp_call_lock);
> +	call_data = &data;
> +	mb();
> +
> +	/* Send a message to the other CPU */
> +	core_send_ipi(cpu, SMP_CALL_FUNCTION);
> +
> +	/* Wait for response */
> +	/* FIXME: lock-up detection, backtrace on lock-up */
> +	while (atomic_read(&data.started) != 1)
> +		barrier();
> +
> +	if (wait)
> +		while (atomic_read(&data.finished) != 1)
> +			barrier();
> +	call_data = NULL;
> +	spin_unlock(&smp_call_lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(smp_call_function_single);
> +
>  static void stop_this_cpu(void *dummy)
>  {

This will not do the right thing. Semantics of smp_call_function_single()
changed recently. It now is supposed to call func() locally with irqs
disabled if cpu == smp_processor_id(). See i386/x86_64 and powerpc.
Unfortunately ia64 hasn't been changed yet, so it will behave differently.
