Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2014 18:35:53 +0200 (CEST)
Received: from mail-we0-f179.google.com ([74.125.82.179]:57479 "EHLO
        mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860084AbaG3Qfbvc20n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Jul 2014 18:35:31 +0200
Received: by mail-we0-f179.google.com with SMTP id u57so1510046wes.10
        for <linux-mips@linux-mips.org>; Wed, 30 Jul 2014 09:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=p/FJElC4QLiSGqC1qrIpIk5eGRS2HwZC00HWQ45y8oI=;
        b=Sc1giS5owFbqX7t7yaz5z371buZZh9VLBpL1C8i/qr0knYVYJhKtRQxGcSJHZKcXNr
         hytkFAa4MXvM2EjmIse16Aj+0U1vrInAvUEfUMIkHbkQdQkUo18Y/pLwki5rJjm0BcPc
         ceOwgmmeSCG2X4J1bsmBQbggpXiP6rq0WqvVuaoGkL06B06nlV+eW7DYmATZvIoGffgQ
         vwybbIRlD7/nKpNaAGiBBqAsPdSV5oP+KYk/mcCJPHARRuzqFa3fBZmCwqI0JmEaI218
         K1nG2s235ZBXgrYIRfQLr98PCghziVO+MSftNnIDXjse9uQGQKmR1vcYDrm5WPIJRVlm
         Othg==
X-Received: by 10.194.92.244 with SMTP id cp20mr7381270wjb.135.1406738124798;
        Wed, 30 Jul 2014 09:35:24 -0700 (PDT)
Received: from localhost (8.20.196.77.rev.sfr.net. [77.196.20.8])
        by mx.google.com with ESMTPSA id ed15sm11318676wic.9.2014.07.30.09.35.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jul 2014 09:35:24 -0700 (PDT)
Date:   Wed, 30 Jul 2014 18:35:21 +0200
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
Message-ID: <20140730163516.GC18158@localhost.localdomain>
References: <cover.1405992946.git.luto@amacapital.net>
 <3f649f5658a163645e3ce15156176c325283762e.1405992946.git.luto@amacapital.net>
 <20140728173723.GA20993@redhat.com>
 <20140728185803.GA24663@redhat.com>
 <20140728192209.GA26017@localhost.localdomain>
 <20140729175414.GA3289@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140729175414.GA3289@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <fweisbec@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41809
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

On Tue, Jul 29, 2014 at 07:54:14PM +0200, Oleg Nesterov wrote:
> Thanks Frederic for your explanations. Yes, I was confused. But cough, now I am
> even more confused.
> 
> I didn't even try to read this code, perhaps I'll try later, but let me ask
> another question while you are here ;)
> 
> The comment above __context_tracking_task_switch() says:
> 
> 	 * The context tracking uses the syscall slow path to implement its user-kernel
> 	 * boundaries probes on syscalls. This way it doesn't impact the syscall fast
> 	 * path on CPUs that don't do context tracking.
> 	        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Indeed, in fact the comment is confusing the way it explain things. It suggests that
some CPUs maybe doing context tracking while some other can choose not to context track.

It's rather all or nothing. Actually TIF_NOHZ optimize systems that have CONFIG_CONTEXT_TRACKING=y
and that don't need context tracking. In this case TIF_NOHZ is cleared and thus the syscall
fastpath has no overhead.

So I should rephrase it that way:

        * The context tracking uses the syscall slow path to implement its user-kernel
        * boundaries probes on syscalls. This way it doesn't impact the syscall fast
        * path when context tracking is globally disabled.

> 
> How? Every running task should have TIF_NOHZ set if context_tracking_is_enabled() ?
> 
> 	 * But we need to clear the flag on the previous task because it may later
> 	 * migrate to some CPU that doesn't do the context tracking. As such the TIF
> 	 * flag may not be desired there.
> 
> For what? How this can help? This flag will be set again when we switch to this
> task again?

That is indeed a stale comment from aborted early design.

> 
> Looks like, we can kill context_tracking_task_switch() and simply change the
> "__init" callers of context_tracking_cpu_set() to do set_thread_flag(TIF_NOHZ) ?
> Then this flag will be propagated by copy_process().

Right, that would be much better. Good catch! context tracking is enabled from
tick_nohz_init(). This is the init 0 task so the flag should be propagated from there.

I still think we need a for_each_process_thread() set as well though because some
kernel threads may well have been created at this stage already.

> 
> Or I am totally confused? (quite possible).
> 
> > So here is a scenario where this is a problem: a task runs on CPU 0, passes the context
> > tracking call before returning from a syscall to userspace, and gets an interrupt. The
> > interrupt preempts the task and it moves to CPU 1. So it returns from preempt_schedule_irq()
> > after which it is going to resume to userspace.
> >
> > In this scenario, if context tracking is only enabled on CPU 1, we have no way to know that
> > the task is resuming to userspace, because we passed through the context tracking probe
> > already and it was ignored on CPU 0.
> 
> Thanks. But I still can't understand... So if we only track CPU 1, then in this
> case context_tracking.state == IN_USER on CPU 0, but it can be IN_USER or IN_KERNEL
> on CPU 1.

I'm not sure I understand your question. Context tracking is either enabled everywhere or
nowhere.

I need to say though that there is a per CPU context tracking state named context_tracking.active.
It's confusing because it suggests that context tracking is active per CPU. Actually it's tracked
everywhere when globally enabled, but active determines if we call the RCU and vtime callbacks or
not.

So only nohz full CPUs have context_tracking.active set because only these need to call the RCU
and vtime callbacks. Other CPUs still do the context tracking but they won't call rcu and vtime
functions.

> 
> Oleg.
> 
