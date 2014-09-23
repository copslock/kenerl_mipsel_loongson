Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2014 21:46:12 +0200 (CEST)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:48683 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009414AbaIWTqJd9bAH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Sep 2014 21:46:09 +0200
Received: by mail-pa0-f53.google.com with SMTP id hz1so7000706pad.26
        for <multiple recipients>; Tue, 23 Sep 2014 12:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5OhIX3cbAgsdOOYt6vsUXwZDnVap0dbOGeXDVBfbab4=;
        b=WFt+eWIayJxsH87vgEQTTd79wmE+EaoImm3EMoRseHAlFiC/eZq2MmSJ1P5qHs/bYE
         h5rms9ORdA8gzDM0jQ6w11ehsOAAGHABfIUMob6yLmje/BQMHuTtEtk68UTMrk1dLaWA
         B40Ww4uun6bDmiWWVSI+wEfPX9ir4lIP/kbr6UBcNMnqU+c7scsC5rCo/sDe428OCOtb
         J63TxncE7Ogu6R9m1eyK1rzKnjMUKxk4Ue0zBo0Ziq166FrtdGJYtf+clXL5nfkidGDi
         t8gOtWTwv+xFF8TTMr303kFxeWI2XZTcsGT6S6D5cO4q/n23mFO+ze/jIJ3UHhXNiOTK
         V5xg==
X-Received: by 10.66.254.195 with SMTP id ak3mr2504522pad.142.1411501563127;
        Tue, 23 Sep 2014 12:46:03 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id rb2sm12897821pab.5.2014.09.23.12.46.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Sep 2014 12:46:02 -0700 (PDT)
Date:   Tue, 23 Sep 2014 12:45:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kirill Tkhai <tkhai@yandex.ru>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Kirill Tkhai <ktkhai@parallels.com>, oleg@redhat.com,
        ralf@linux-mips.org, tony.luck@intel.com,
        linux-mips@linux-mips.org, linux-ia64@vger.kernel.org
Subject: Re: [RFC][PATCH] sched,mips,ia64: Remove __ARCH_WANT_UNLOCKED_CTXSW
Message-ID: <20140923194558.GA677@roeck-us.net>
References: <20140922183612.11015.64200.stgit@localhost>
 <20140922183618.11015.95007.stgit@localhost>
 <20140923150641.GH3312@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140923150641.GH3312@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Tue, Sep 23, 2014 at 05:06:41PM +0200, Peter Zijlstra wrote:
> On Mon, Sep 22, 2014 at 10:36:18PM +0400, Kirill Tkhai wrote:
> > From: Kirill Tkhai <ktkhai@parallels.com>
> > 
> > Architectures, which define __ARCH_WANT_UNLOCKED_CTXSW,
> > may pull a task when it's in the middle of schedule().
> > 
> > CPU1(task1 calls schedule)            CPU2
> > ...                                   schedule()
> > ...                                      idle_balance()
> > ...                                         load_balance()
> > ...                                            ...
> > schedule()                                     ...
> >    prepare_lock_switch()                       ...
> >       raw_spin_unlock(&rq1->lock)              ...
> >       ...                                      raw_spin_lock(&rq1->lock)
> >       ...                                         detach_tasks();
> >       ...                                            can_migrate_task(task1)
> >       ...                                         attach_tasks(); <--- move task1 to rq2
> >       ...                                      raw_spin_unlock(&rq1->lock)
> >       ...                                context_switch() <--- switch to task1's stack
> >       ...                                ...
> >    (using task1's stack)                 (using task1's stack)
> >    ...                                   ...
> >    context_switch()                      ...
> > 
> > 
> > Parallel use of a single stack is not a good idea.
> 
> Indeed it is, but how about we do this instead?
> 
> ---
> Subject: sched,mips,ia64: Remove __ARCH_WANT_UNLOCKED_CTXSW
> 
> Kirill found that there's a subtle race in the
> __ARCH_WANT_UNLOCKED_CTXSW code, and instead of fixing it, remove the
> entire exception because neither arch that uses it seems to actually
> still require it.
> 
> Boot tested on mips64el (qemu) only.
> 
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/ia64/include/asm/processor.h |  1 -
>  arch/mips/include/asm/processor.h |  6 ------
>  kernel/sched/core.c               |  6 ------
>  kernel/sched/sched.h              | 30 ------------------------------

You might also want to clean up any references to the define if you remove it.

Documentation/scheduler/sched-arch.txt:you must `#define __ARCH_WANT_UNLOCKED_CTXSW` in a header file
arch/blackfin/kernel/entry.S:    * since Blackfin does not define __ARCH_WANT_UNLOCKED_CTXSW, so

Guenter

>  4 files changed, 43 deletions(-)
> 
> diff --git a/arch/ia64/include/asm/processor.h b/arch/ia64/include/asm/processor.h
> index c736713..ce53c50 100644
> --- a/arch/ia64/include/asm/processor.h
> +++ b/arch/ia64/include/asm/processor.h
> @@ -19,7 +19,6 @@
>  #include <asm/ptrace.h>
>  #include <asm/ustack.h>
>  
> -#define __ARCH_WANT_UNLOCKED_CTXSW
>  #define ARCH_HAS_PREFETCH_SWITCH_STACK
>  
>  #define IA64_NUM_PHYS_STACK_REG	96
> diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
> index 05f0843..f1df4cb 100644
> --- a/arch/mips/include/asm/processor.h
> +++ b/arch/mips/include/asm/processor.h
> @@ -397,12 +397,6 @@ unsigned long get_wchan(struct task_struct *p);
>  #define ARCH_HAS_PREFETCHW
>  #define prefetchw(x) __builtin_prefetch((x), 1, 1)
>  
> -/*
> - * See Documentation/scheduler/sched-arch.txt; prevents deadlock on SMP
> - * systems.
> - */
> -#define __ARCH_WANT_UNLOCKED_CTXSW
> -
>  #endif
>  
>  #endif /* _ASM_PROCESSOR_H */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2a93b87..ccbafb0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2304,10 +2304,6 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
>  	 */
>  	post_schedule(rq);
>  
> -#ifdef __ARCH_WANT_UNLOCKED_CTXSW
> -	/* In this case, finish_task_switch does not reenable preemption */
> -	preempt_enable();
> -#endif
>  	if (current->set_child_tid)
>  		put_user(task_pid_vnr(current), current->set_child_tid);
>  }
> @@ -2350,9 +2346,7 @@ context_switch(struct rq *rq, struct task_struct *prev,
>  	 * of the scheduler it's an obvious special-case), so we
>  	 * do an early lockdep release here:
>  	 */
> -#ifndef __ARCH_WANT_UNLOCKED_CTXSW
>  	spin_release(&rq->lock.dep_map, 1, _THIS_IP_);
> -#endif
>  
>  	context_tracking_task_switch(prev, next);
>  	/* Here we just switch the register state and the stack. */
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 1bc6aad..d87f122 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -966,7 +966,6 @@ static inline int task_on_rq_migrating(struct task_struct *p)
>  # define finish_arch_post_lock_switch()	do { } while (0)
>  #endif
>  
> -#ifndef __ARCH_WANT_UNLOCKED_CTXSW
>  static inline void prepare_lock_switch(struct rq *rq, struct task_struct *next)
>  {
>  #ifdef CONFIG_SMP
> @@ -1004,35 +1003,6 @@ static inline void finish_lock_switch(struct rq *rq, struct task_struct *prev)
>  	raw_spin_unlock_irq(&rq->lock);
>  }
>  
> -#else /* __ARCH_WANT_UNLOCKED_CTXSW */
> -static inline void prepare_lock_switch(struct rq *rq, struct task_struct *next)
> -{
> -#ifdef CONFIG_SMP
> -	/*
> -	 * We can optimise this out completely for !SMP, because the
> -	 * SMP rebalancing from interrupt is the only thing that cares
> -	 * here.
> -	 */
> -	next->on_cpu = 1;
> -#endif
> -	raw_spin_unlock(&rq->lock);
> -}
> -
> -static inline void finish_lock_switch(struct rq *rq, struct task_struct *prev)
> -{
> -#ifdef CONFIG_SMP
> -	/*
> -	 * After ->on_cpu is cleared, the task can be moved to a different CPU.
> -	 * We must ensure this doesn't happen until the switch is completely
> -	 * finished.
> -	 */
> -	smp_wmb();
> -	prev->on_cpu = 0;
> -#endif
> -	local_irq_enable();
> -}
> -#endif /* __ARCH_WANT_UNLOCKED_CTXSW */
> -
>  /*
>   * wake flags
>   */
