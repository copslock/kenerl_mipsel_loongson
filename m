Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 May 2012 15:38:09 +0200 (CEST)
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:57248 "EHLO
        e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903701Ab2E1NiC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 May 2012 15:38:02 +0200
Received: from /spool/local
        by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
        Mon, 28 May 2012 19:07:51 +0530
Received: from d28relay01.in.ibm.com (9.184.220.58)
        by e28smtp09.in.ibm.com (192.168.1.139) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 28 May 2012 19:07:47 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
        by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q4SC5Uk41180068;
        Mon, 28 May 2012 17:35:31 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
        by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q4SHa7M8017288;
        Tue, 29 May 2012 03:36:08 +1000
Received: from [9.124.35.113] (srivatsabhat.in.ibm.com [9.124.35.113])
        by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id q4SHa70F017278;
        Tue, 29 May 2012 03:36:07 +1000
Message-ID: <4FC369E3.1030901@linux.vnet.ibm.com>
Date:   Mon, 28 May 2012 17:34:51 +0530
From:   "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120424 Thunderbird/12.0
MIME-Version: 1.0
To:     Yong Zhang <yong.zhang0@gmail.com>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, sshtylyov@mvista.com, david.daney@cavium.com,
        Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, axboe@kernel.dk,
        jeremy.fitzhardinge@citrix.com, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 6/8] MIPS: call set_cpu_online() on the uping cpu with
 irq disabled
References: <1337580008-7280-1-git-send-email-yong.zhang0@gmail.com> <1337580008-7280-7-git-send-email-yong.zhang0@gmail.com> <4FBA1B54.3@linux.vnet.ibm.com> <20120522062126.GB12098@zhy>
In-Reply-To: <20120522062126.GB12098@zhy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
x-cbid: 12052813-2674-0000-0000-000004B4D8E7
X-archive-position: 33472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: srivatsa.bhat@linux.vnet.ibm.com
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

On 05/22/2012 11:51 AM, Yong Zhang wrote:

> On Mon, May 21, 2012 at 04:09:16PM +0530, Srivatsa S. Bhat wrote:
>> On 05/21/2012 11:30 AM, Yong Zhang wrote:
>>
>>> From: Yong Zhang <yong.zhang@windriver.com>
>>>
>>> To prevent a problem as commit 5fbd036b [sched: Cleanup cpu_active madness]
>>> and commit 2baab4e9 [sched: Fix select_fallback_rq() vs cpu_active/cpu_online]
>>> try to resolve, move set_cpu_online() to the brought up CPU and with irq
>>> disabled.
>>>
>>> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
>>> Acked-by: David Daney <david.daney@cavium.com>
>>> ---
>>>  arch/mips/kernel/smp.c |    4 ++--
>>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
>>> index 73a268a..042145f 100644
>>> --- a/arch/mips/kernel/smp.c
>>> +++ b/arch/mips/kernel/smp.c
>>> @@ -122,6 +122,8 @@ asmlinkage __cpuinit void start_secondary(void)
>>>
>>>  	notify_cpu_starting(cpu);
>>>
>>> +	set_cpu_online(cpu, true);
>>> +
>>
>>
>> You will also need to use ipi_call_lock/unlock() around this.
>> See how x86 does it. (MIPS also selects USE_GENERIC_SMP_HELPERS).
> 
> Hmm... But look at the comments in arch/x86/kernel/smpboot.c::start_secondary()
> 
> start_secondary()
> {
> 	...
>         /*   
>          * We need to hold call_lock, so there is no inconsistency
>          * between the time smp_call_function() determines number of
>          * IPI recipients, and the time when the determination is made
>          * for which cpus receive the IPI. Holding this
>          * lock helps us to not include this cpu in a currently in progress
>          * smp_call_function().
>          *
>          * We need to hold vector_lock so there the set of online cpus
>          * does not change while we are assigning vectors to cpus.  Holding
>          * this lock ensures we don't half assign or remove an irq from a cpu.
>          */
>         ipi_call_lock();
>         lock_vector_lock();
>         set_cpu_online(smp_processor_id(), true);
>         unlock_vector_lock();
>         ipi_call_unlock();
> 
> 	...
> }
> 
> which ipi_call_lock()/ipi_call_unlock() is to pretect race with concurrent 
> smp_call_function(), but it seems that is already broken, because
> 
> 1) The comments is alread there before we switch to generic smp helper(commit
>    3b16cf87), and at that time the comments is true because
>    smp_call_function_interrupt() doesn't test if a cpu should handle the
>    IPI interrupt.
>    But in the gereric smp helper, we have checked if a cpu should handle the IPI
>    in generic_smp_call_function_interrupt():
>    	if (!cpumask_test_cpu(cpu, data->cpumask))
> 		continue;
> 
> 2) call_function.lock used in smp_call_function_many() is just to protect
>    call_function.queue and &data->refs, cpu_online_mask is outside of the
>    lock. And I don't think it's necessary to protect cpu_online_mask,
>    because data->cpumask is pre-calculate and even if a cpu is brougt up
>    when calling arch_send_call_function_ipi_mask(), it's harmless because
>    validation test in generic_smp_call_function_interrupt() will take care
>    of it.
> 
> 3) For cpu down issue, stop_machine() will guarantee that no concurrent
>    smp_call_fuction() is processing.
> 
> So it seems ipi_call_lock()/ipi_call_unlock() is not needed and could be
> removed IMHO.
> Or am I missing something?
> 


No, I think you are right. Sorry for the delay in replying.
It indeed looks like we need not use ipi_call_lock/unlock() in CPU bringup
code..

However, it does make me wonder about this:
commit 3d4422332 introduced the generic ipi helpers, and reduced the scope
of call_function.lock and also added the check in
generic_smp_call_function_interrupt() to proceed only if the cpu is present
in data->cpumask.

Then, commit 3b16cf8748 converted x86 to the generic ipi helpers, but while
doing that, it explicitly retained ipi_call_lock/unlock(), which is kind of
surprising.. I guess it was a mistake rather than intentional.
 
Regards,
Srivatsa S. Bhat
