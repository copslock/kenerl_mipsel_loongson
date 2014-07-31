Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2014 20:47:53 +0200 (CEST)
Received: from mail-we0-f172.google.com ([74.125.82.172]:59857 "EHLO
        mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860194AbaGaSrlQwIWT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Jul 2014 20:47:41 +0200
Received: by mail-we0-f172.google.com with SMTP id x48so3251805wes.3
        for <linux-mips@linux-mips.org>; Thu, 31 Jul 2014 11:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GLTbagPA3qVhiV9NEtfEoCZB19KQE9X6CMlkdYUOLvU=;
        b=yWkInv6DUGFmZXYnm+WfwTecFk5FZd7VEe5/D17xpGTDNiDKrGROdy9tz5Zy6zKbNJ
         FctnqiwdV5naoh/Ii2vkaGyU14MV6eNUV8j0Gs2Ys8R/TO6poAfY7UkFsAullEQfe2Q9
         pfWQ2Hzdlm6rbl51HxhKPmrCOS/LGzRZsxeXUdTaJw5CRRWL3hhPDcZyE3pO2MdMgDA1
         H6YbAC8a9NwZNFcqcxpE3YTYLC6gTW3fdDHorUBrkNJjNkruKurFbwSqUnLVSeX4coAf
         TkqWpv17Op3Yp0r/GOqhtEvcblPmKbpOCPZA31/fYEI6ETo17gZyIFktY85Bzn3Eok6B
         Zs/g==
X-Received: by 10.194.185.238 with SMTP id ff14mr122137wjc.9.1406832455970;
        Thu, 31 Jul 2014 11:47:35 -0700 (PDT)
Received: from localhost (8.20.196.77.rev.sfr.net. [77.196.20.8])
        by mx.google.com with ESMTPSA id 20sm15157186wjt.42.2014.07.31.11.47.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jul 2014 11:47:35 -0700 (PDT)
Date:   Thu, 31 Jul 2014 20:47:31 +0200
From:   Frederic Weisbecker <fweisbec@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com
Subject: Re: TIF_NOHZ can escape nonhz mask? (Was: [PATCH v3 6/8] x86: Split
 syscall_trace_enter into two phases)
Message-ID: <20140731184729.GA12296@localhost.localdomain>
References: <20140728173723.GA20993@redhat.com>
 <20140728185803.GA24663@redhat.com>
 <20140728192209.GA26017@localhost.localdomain>
 <20140729175414.GA3289@redhat.com>
 <20140730163516.GC18158@localhost.localdomain>
 <20140730174630.GA30862@redhat.com>
 <20140731003034.GA32078@localhost.localdomain>
 <20140731160353.GA14772@redhat.com>
 <20140731171329.GD7842@localhost.localdomain>
 <20140731181230.GA18695@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140731181230.GA18695@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <fweisbec@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fweisbec@gmail.com
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

On Thu, Jul 31, 2014 at 08:12:30PM +0200, Oleg Nesterov wrote:
> On 07/31, Frederic Weisbecker wrote:
> >
> > On Thu, Jul 31, 2014 at 06:03:53PM +0200, Oleg Nesterov wrote:
> > > On 07/31, Frederic Weisbecker wrote:
> > > >
> > > > I was convinced that the very first kernel init task is PID 0 then
> > > > it forks on rest_init() to launch the userspace init with PID 1. Then init/0 becomes the
> > > > idle task of the boot CPU.
> > >
> > > Yes sure. But context_tracking_cpu_set() is called by init task with PID 1, not
> > > by "swapper".
> >
> > Are you sure? It's called from start_kernel() which is init/0.
> 
> But do_initcalls() is called by kernel_init(), this is the init process which is
> going to exec /sbin/init later.
> 
> But this doesn't really matter,

Yeah but tick_nohz_init() is not an initcall, it's a function called from start_kernel(),
before initcalls.

> 
> > Maybe we should just enable it everywhere.
> 
> Yes, yes, this doesn't really matter. We can even add set(TIF_NOHZ) at the start
> of start_kernel(). The question is, I still can't understand why do we want to
> have the global TIF_NOHZ.

Because then the flags is inherited in forks. It's better than inheriting it on
context switch due to context switch being called much more often than fork.

> 
> > > OK. To simplify, lets discuss user_enter() only. So, it is actually a nop on
> > > CPU_0, and CPU_1 can miss it anyway.
> > >
> > > > But global TIF_NOHZ should enforce context tracking everywhere.
> > >
> > > And this is what I can't understand. Lets return to my initial question, why
> > > we can't change __context_tracking_task_switch()
> > >
> > > 	void __context_tracking_task_switch(struct task_struct *prev,
> > > 					    struct task_struct *next)
> > > 	{
> > > 		if (context_tracking_cpu_is_enabled())
> > > 			set_tsk_thread_flag(next, TIF_NOHZ);
> > > 		else
> > > 			clear_tsk_thread_flag(next, TIF_NOHZ);
> > > 	}
> > >
> > > ?
> >
> > Well we can change it to global TIF_NOHZ
> >
> > > How can the global TIF_NOHZ help?
> >
> > It avoids that flag swap on task_switch.
> 
> Ah, you probably meant that we can kill context_tracking_task_switch() as
> we discussed.

Yeah.

> 
> But I meant another thing, TIF_NOHZ is already global because it is always
> set after context_tracking_cpu_set().
> 
> Performance-wise, this set/clear code above can be better because it avoids
> the slow paths on the untracked CPU's.

But all CPUs are tracked when context tracking is enabled. So there is no such
per CPU granularity.

> But let's ignore this, the question is
> why the change above is not correct? Or why it can make the things worse?

Which change above?

> 
> 
> > > OK, OK, a task can return to usermode on CPU_0, notice TIF_NOHZ, take the
> > > slow path, and do the "right" thing if it migrates to CPU_1 _before_ it
> > > comes to user_enter(). But this case is very unlikely, certainly this can't
> > > explain why do we penalize the untracked CPU's ?
> >
> > It's rather that CPU 0 calls user_enter() and then migrate to CPU 1 and resume
> > to userspace.
> 
> And in this case a) user_enter() is pointless on CPU_0, and b) CPU_1 misses
> the necessary user_enter().

No, user_enter() is necessary on CPU 0 so that CPU 1 sees that it is in userspace
from context tracking POV.

> 
> > It's unlikely but possible. I actually observed that very easily on early testing.
> 
> Sure. And this can happen anyway? Why the change in __context_tracking_task_switch()
> is wrong?

Which change?

> 
> > And it's a big problem because then the CPU runs in userspace, possibly for a long while
> > in HPC case, and context tracking thinks it is in kernelspace. As a result, RCU waits
> > for that CPU to complete grace periods and cputime is accounted to kernelspace instead of
> > userspace.
> >
> > It looks like a harmless race but it can have big consequences.
> 
> I see. Again, does the global TIF_NOHZ really help?

Yes, to remove the context switch overhead. But it doesn't change anything on those races.

> > Because calling context_switch_task_switch() on every context switch is costly.
> 
> See above. This depends, but forcing the slow paths on all CPU's can be more
> costly.

Yeah but I don't have a safe solution that avoids that.

> 
> > > And of course I can't understand exception_enter/exit(). Not to mention that
> > > (afaics) "prev_ctx == IN_USER" in exception_exit() can be false positive even
> > > if we forget that the caller can migrate in between. Just because, once again,
> > > a tracked CPU can miss user_exit().
> >
> > You lost me on this. How can a tracked CPU miss user_exit()?
> 
> I am lost too ;) Didn't we already discuss this? A task calls user_exit() on
> CPU_0 for no reason, migrates to the tracked CPU_1 and finally returns to user
> space leaving this cpu in IN_KERNEL state?

Yeah, so? :)

I'm pretty sure there is a small but important element here that makes us misunderstanding
what each others says. It's like we aren't taking about the same thing :)

> > That's how I implemented it first. But then I changed it the way it is now:
> > 6c1e0256fad84a843d915414e4b5973b7443d48d
> > ("context_tracking: Restore correct previous context state on exception exit")
> >
> > This is again due to the shift between hard and soft userspace boundaries.
> > user_mode(regs) checks hard boundaries only.
> >
> > Lets get back to our beloved example:
> >
> >           CPU 0                                  CPU 1
> >           ---------------------------------------------
> >
> >           returning from syscall {
> >                user_enter();
> >                exception {
> >                     exception_enter()
> >                     PREEMPT!
> >                     ----------------------->
> >                                                  //resume exception
> >                                                    exception_exit();
> >                                                    return to userspace
> 
> OK, thanks, so in this case we miss user_enter().
> 
> But again, we can miss it anyway if preemptions comes before "exception" ?
> if CPU 1 was in IN_KERNEL state.

No, because preempt_schedule_irq() does the ctx_state save and restore with
exception_enter/exception_exit.
