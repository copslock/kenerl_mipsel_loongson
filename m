Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2014 02:30:50 +0200 (CEST)
Received: from mail-wi0-f176.google.com ([209.85.212.176]:62553 "EHLO
        mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860084AbaGaAarK9O9e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Jul 2014 02:30:47 +0200
Received: by mail-wi0-f176.google.com with SMTP id bs8so8460968wib.3
        for <linux-mips@linux-mips.org>; Wed, 30 Jul 2014 17:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=e4kIHHsK0vaEIkYSANYal+2HxP7gWKL4kBrQcOG1Ruw=;
        b=Evf7Y+mJ1lDnvzCQAEofFX6dLRPN4qtdFBE0oBNo4vLjSeXkaIsp4QjyeL1VE4d6x1
         rRdbtHguTRNn1gCRBOzaxujwrfHnhaeAzKa3tFP7E5whcxI+bd9YYIL5PdimqG4fMcp+
         E9sYmVrujcp0A4ddtuODg8L9ySCcjOVDPOBujOihhAzBho3xHp4I+iTU/KDvKRHxF8cb
         f4BYgb0YC9pFl6gjoOsATvIJ8yKdh+hQpJ4d9x3H5QKLlhPg6iM+pwLWPtCGiQr21Du0
         Qkc3Po3uHWVsjztYFVFI7c7trzIjTh/I0d/ClsvsBVKRxh3vFO6G3TDcAiU4K8Xh1r1Y
         WFKQ==
X-Received: by 10.180.94.166 with SMTP id dd6mr10499901wib.33.1406766641316;
        Wed, 30 Jul 2014 17:30:41 -0700 (PDT)
Received: from localhost (8.20.196.77.rev.sfr.net. [77.196.20.8])
        by mx.google.com with ESMTPSA id r1sm14846281wia.21.2014.07.30.17.30.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jul 2014 17:30:40 -0700 (PDT)
Date:   Thu, 31 Jul 2014 02:30:37 +0200
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
Message-ID: <20140731003034.GA32078@localhost.localdomain>
References: <cover.1405992946.git.luto@amacapital.net>
 <3f649f5658a163645e3ce15156176c325283762e.1405992946.git.luto@amacapital.net>
 <20140728173723.GA20993@redhat.com>
 <20140728185803.GA24663@redhat.com>
 <20140728192209.GA26017@localhost.localdomain>
 <20140729175414.GA3289@redhat.com>
 <20140730163516.GC18158@localhost.localdomain>
 <20140730174630.GA30862@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140730174630.GA30862@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <fweisbec@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41828
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

On Wed, Jul 30, 2014 at 07:46:30PM +0200, Oleg Nesterov wrote:
> On 07/30, Frederic Weisbecker wrote:
> >
> > On Tue, Jul 29, 2014 at 07:54:14PM +0200, Oleg Nesterov wrote:
> >
> > >
> > > Looks like, we can kill context_tracking_task_switch() and simply change the
> > > "__init" callers of context_tracking_cpu_set() to do set_thread_flag(TIF_NOHZ) ?
> > > Then this flag will be propagated by copy_process().
> >
> > Right, that would be much better. Good catch! context tracking is enabled from
> > tick_nohz_init(). This is the init 0 task so the flag should be propagated from there.
> 
> actually init 1 task, but this doesn't matter.

Are you sure? It does matter because that would invalidate everything I understood
about init/main.c :) I was convinced that the very first kernel init task is PID 0 then
it forks on rest_init() to launch the userspace init with PID 1. Then init/0 becomes the
idle task of the boot CPU.

> 
> > I still think we need a for_each_process_thread() set as well though because some
> > kernel threads may well have been created at this stage already.
> 
> Yes... Or we can add set_thread_flag(TIF_NOHZ) into ____call_usermodehelper().

Couldn't there be some other tasks than usermodehelper stuffs at this stage? Like workqueues
or random kernel threads?

> 
> > > Or I am totally confused? (quite possible).
> > >
> > > > So here is a scenario where this is a problem: a task runs on CPU 0, passes the context
> > > > tracking call before returning from a syscall to userspace, and gets an interrupt. The
> > > > interrupt preempts the task and it moves to CPU 1. So it returns from preempt_schedule_irq()
> > > > after which it is going to resume to userspace.
> > > >
> > > > In this scenario, if context tracking is only enabled on CPU 1, we have no way to know that
> > > > the task is resuming to userspace, because we passed through the context tracking probe
> > > > already and it was ignored on CPU 0.
> > >
> > > Thanks. But I still can't understand... So if we only track CPU 1, then in this
> > > case context_tracking.state == IN_USER on CPU 0, but it can be IN_USER or IN_KERNEL
> > > on CPU 1.
> >
> > I'm not sure I understand your question.
> 
> Probably because it was stupid. Seriously, I still have no idea what this code
> actually does.
> 
> > Context tracking is either enabled everywhere or
> > nowhere.
> >
> > I need to say though that there is a per CPU context tracking state named context_tracking.active.
> > It's confusing because it suggests that context tracking is active per CPU. Actually it's tracked
> > everywhere when globally enabled, but active determines if we call the RCU and vtime callbacks or
> > not.
> >
> > So only nohz full CPUs have context_tracking.active set because only these need to call the RCU
> > and vtime callbacks. Other CPUs still do the context tracking but they won't call rcu and vtime
> > functions.
> 
> I meant that in the scenario you described above the "global" TIF_NOHZ doesn't
> really make a difference, afaics.
> 
> Lets assume that context tracking is only enabled on CPU 1. To simplify,
> assume that we have a single usermode task T which sleeps in kernel mode.
> 
> So context_tracking[0].state == context_tracking[1].state == IN_KERNEL.
> 
> T wakes up on CPU_0, returns to user space, calls user_enter(). This sets
> context_tracking[0].state = IN_USER but otherwise does nothing else, this
> CPU is not tracked and .active is false.
> 
> Right after local_irq_restore() this task can migrate to CPU_1 and finish
> its ret-to-usermode path. But since it had already passed user_enter() we
> do not change context_tracking[1].state and do not play with rcu/vtime.
> (unless this task hits SCHEDULE_USER in asm).
> 
> The same for user_exit() of course.

So indeed if context tracking is enabled on CPU 1 and not in CPU 0, we risk
such situation where CPU 1 has wrong context tracking.

But global TIF_NOHZ should enforce context tracking everywhere. And also it's
less context switch overhead.

> 
> Oleg.
> 
