Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jul 2014 21:22:30 +0200 (CEST)
Received: from mail-we0-f182.google.com ([74.125.82.182]:41611 "EHLO
        mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860184AbaG1TW0DZyzs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Jul 2014 21:22:26 +0200
Received: by mail-we0-f182.google.com with SMTP id k48so7971303wev.27
        for <linux-mips@linux-mips.org>; Mon, 28 Jul 2014 12:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/uTEpvavJJpdmvVUXjdEtrmnHx4w/HE8oIcqH0w3GOc=;
        b=tz/c8rJg8MQSGNKnvQ/9c9ls8PSYWirhS93xYFLazLlWrvE3QgB9FBr2eMoW86zYYO
         i6Hgvzqkw9mAO1/K2tLUlPR0tcq34dXTz0ijFEudZbJ+4yhHWUdfqHpHCFHV797rfUGd
         y06E2s9Abb/7HBuy4JIzffpwx9JSCslwHWUmcXtiCh0LAsiB2Qv30v9G8xPqHAmPZDRc
         nfLxNqwtUhEXdug0dQQTpMzRgfqQzKGX2irryHeSEIrRG8BXutlBg30xNvoq+g3b2n5x
         0a5enTmFU1wxqhhbDzdf4qmUoHBmoEq+JsHAH7RHTMKJhSb4JdRzHf09nooteT4KTpX8
         z/VQ==
X-Received: by 10.195.13.79 with SMTP id ew15mr49785570wjd.19.1406575339530;
        Mon, 28 Jul 2014 12:22:19 -0700 (PDT)
Received: from localhost (8.20.196.77.rev.sfr.net. [77.196.20.8])
        by mx.google.com with ESMTPSA id k6sm8855697wjq.5.2014.07.28.12.22.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jul 2014 12:22:18 -0700 (PDT)
Date:   Mon, 28 Jul 2014 21:22:13 +0200
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
Message-ID: <20140728192209.GA26017@localhost.localdomain>
References: <cover.1405992946.git.luto@amacapital.net>
 <3f649f5658a163645e3ce15156176c325283762e.1405992946.git.luto@amacapital.net>
 <20140728173723.GA20993@redhat.com>
 <20140728185803.GA24663@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140728185803.GA24663@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <fweisbec@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41719
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

On Mon, Jul 28, 2014 at 08:58:03PM +0200, Oleg Nesterov wrote:
> Off-topic, but...
> 
> On 07/28, Oleg Nesterov wrote:
> >
> > But we should always call user_exit() unconditionally?
> 
> Frederic, don't we need the patch below? In fact clear_() can be moved
> under "if ()" too. and probably copy_process() should clear this flag...
> 
> Or. __context_tracking_task_switch() can simply do
> 
> 	 if (context_tracking_cpu_is_enabled())
> 	 	set_tsk_thread_flag(next, TIF_NOHZ);
> 	 else
> 	 	clear_tsk_thread_flag(next, TIF_NOHZ);
> 
> and then we can forget about copy_process(). Or I am totally confused?
> 
> 
> I am also wondering if we can extend user_return_notifier to handle
> enter/exit and kill TIF_NOHZ.
> 
> Oleg.
> 
> --- x/kernel/context_tracking.c
> +++ x/kernel/context_tracking.c
> @@ -202,7 +202,8 @@ void __context_tracking_task_switch(stru
>  				    struct task_struct *next)
>  {
>  	clear_tsk_thread_flag(prev, TIF_NOHZ);
> -	set_tsk_thread_flag(next, TIF_NOHZ);
> +	if (context_tracking_cpu_is_enabled())
> +		set_tsk_thread_flag(next, TIF_NOHZ);
>  }
>  
>  #ifdef CONFIG_CONTEXT_TRACKING_FORCE

Unfortunately, as long as tasks can migrate in and out a context tracked CPU, we
need to track all CPUs.

This is because there is always a small shift between hard and soft kernelspace
boundaries.

Hard boundaries are the real strict boundaries: between "int", "iret" or faulting
instructions for example.

Soft boundaries are the place where we put our context tracking probes. They
are just function calls and a distance between them and hard boundaries is inevitable.

So here is a scenario where this is a problem: a task runs on CPU 0, passes the context
tracking call before returning from a syscall to userspace, and gets an interrupt. The
interrupt preempts the task and it moves to CPU 1. So it returns from preempt_schedule_irq()
after which it is going to resume to userspace.

In this scenario, if context tracking is only enabled on CPU 1, we have no way to know that
the task is resuming to userspace, because we passed through the context tracking probe
already and it was ignored on CPU 0.

This might be hackbable by ensuring that irqs are disabled between context tracking
calls and actual returns to userspace. It's a nightmare to audit on all archs though,
and it makes the context tracking callers less flexible also that only solve the issue
for irqs. Exception have a similar problem and we can't mask them.
