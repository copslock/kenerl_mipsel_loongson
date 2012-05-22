Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2012 08:21:50 +0200 (CEST)
Received: from mail-qa0-f42.google.com ([209.85.216.42]:49777 "EHLO
        mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901163Ab2EVGVq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 May 2012 08:21:46 +0200
Received: by qafi31 with SMTP id i31so2091131qaf.15
        for <multiple recipients>; Mon, 21 May 2012 23:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jFdz+yMn1cRMmZqIXUNKkhn+Ph+w7P9BslE8IxxgbTM=;
        b=EsGh3Zu5yqZxJtHsWs58fC7VMEbYf7A3CWQdpY77VEQTeTJopNq934lE3xITcFp5rj
         9GbL1vC1RpLhsp2GJs3TLPHl6qRtF+/pnDhwMARgQ4woA8DUdLjt4lOOp5A38YvdgPdw
         Av75daGDE/lvoWfMCPb1Fg/RbZPgb5OXTDSLWjbnN0l1Xo6nMvw462/8HDK+ZTcw9Y62
         1bAXNJkI4NqQ3wOW8IIdfwKmLTCzbwD5qd+x1JmXzBzX05byLPEsp6yYmYz8zQS86kW2
         1E1sKtGkmgOV0lhKXjsHt2y84AJVIVGq5naEsqvSLpKLSf5RGt1ha2j6VIPRVDy7q4E6
         mqEg==
Received: by 10.224.181.137 with SMTP id by9mr11587083qab.9.1337667700383;
        Mon, 21 May 2012 23:21:40 -0700 (PDT)
Received: from localhost ([61.148.56.138])
        by mx.google.com with ESMTPS id i7sm43713170qae.20.2012.05.21.23.21.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 May 2012 23:21:39 -0700 (PDT)
Date:   Tue, 22 May 2012 14:21:27 +0800
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, sshtylyov@mvista.com, david.daney@cavium.com
Subject: Re: [PATCH 6/8] MIPS: call set_cpu_online() on the uping cpu with
 irq disabled
Message-ID: <20120522062126.GB12098@zhy>
Reply-To: Yong Zhang <yong.zhang0@gmail.com>
References: <1337580008-7280-1-git-send-email-yong.zhang0@gmail.com>
 <1337580008-7280-7-git-send-email-yong.zhang0@gmail.com>
 <4FBA1B54.3@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4FBA1B54.3@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, May 21, 2012 at 04:09:16PM +0530, Srivatsa S. Bhat wrote:
> On 05/21/2012 11:30 AM, Yong Zhang wrote:
> 
> > From: Yong Zhang <yong.zhang@windriver.com>
> > 
> > To prevent a problem as commit 5fbd036b [sched: Cleanup cpu_active madness]
> > and commit 2baab4e9 [sched: Fix select_fallback_rq() vs cpu_active/cpu_online]
> > try to resolve, move set_cpu_online() to the brought up CPU and with irq
> > disabled.
> > 
> > Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
> > Acked-by: David Daney <david.daney@cavium.com>
> > ---
> >  arch/mips/kernel/smp.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> > index 73a268a..042145f 100644
> > --- a/arch/mips/kernel/smp.c
> > +++ b/arch/mips/kernel/smp.c
> > @@ -122,6 +122,8 @@ asmlinkage __cpuinit void start_secondary(void)
> > 
> >  	notify_cpu_starting(cpu);
> > 
> > +	set_cpu_online(cpu, true);
> > +
> 
> 
> You will also need to use ipi_call_lock/unlock() around this.
> See how x86 does it. (MIPS also selects USE_GENERIC_SMP_HELPERS).

Hmm... But look at the comments in arch/x86/kernel/smpboot.c::start_secondary()

start_secondary()
{
	...
        /*   
         * We need to hold call_lock, so there is no inconsistency
         * between the time smp_call_function() determines number of
         * IPI recipients, and the time when the determination is made
         * for which cpus receive the IPI. Holding this
         * lock helps us to not include this cpu in a currently in progress
         * smp_call_function().
         *
         * We need to hold vector_lock so there the set of online cpus
         * does not change while we are assigning vectors to cpus.  Holding
         * this lock ensures we don't half assign or remove an irq from a cpu.
         */
        ipi_call_lock();
        lock_vector_lock();
        set_cpu_online(smp_processor_id(), true);
        unlock_vector_lock();
        ipi_call_unlock();

	...
}

which ipi_call_lock()/ipi_call_unlock() is to pretect race with concurrent 
smp_call_function(), but it seems that is already broken, because

1) The comments is alread there before we switch to generic smp helper(commit
   3b16cf87), and at that time the comments is true because
   smp_call_function_interrupt() doesn't test if a cpu should handle the
   IPI interrupt.
   But in the gereric smp helper, we have checked if a cpu should handle the IPI
   in generic_smp_call_function_interrupt():
   	if (!cpumask_test_cpu(cpu, data->cpumask))
		continue;

2) call_function.lock used in smp_call_function_many() is just to protect
   call_function.queue and &data->refs, cpu_online_mask is outside of the
   lock. And I don't think it's necessary to protect cpu_online_mask,
   because data->cpumask is pre-calculate and even if a cpu is brougt up
   when calling arch_send_call_function_ipi_mask(), it's harmless because
   validation test in generic_smp_call_function_interrupt() will take care
   of it.

3) For cpu down issue, stop_machine() will guarantee that no concurrent
   smp_call_fuction() is processing.

So it seems ipi_call_lock()/ipi_call_unlock() is not needed and could be
removed IMHO.
Or am I missing something?

Thanks,
Yong
