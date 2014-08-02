Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Aug 2014 19:32:25 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:46561 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860192AbaHBRcX3VHXL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 2 Aug 2014 19:32:23 +0200
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s72HWDI0023934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 2 Aug 2014 13:32:13 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-191.brq.redhat.com [10.34.1.191])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s72HW8Lu015003;
        Sat, 2 Aug 2014 13:32:09 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Sat,  2 Aug 2014 19:30:29 +0200 (CEST)
Date:   Sat, 2 Aug 2014 19:30:24 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Frederic Weisbecker <fweisbec@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com
Subject: Re: TIF_NOHZ can escape nonhz mask? (Was: [PATCH v3 6/8] x86:
        Split syscall_trace_enter into two phases)
Message-ID: <20140802173024.GB22510@redhat.com>
References: <20140728185803.GA24663@redhat.com> <20140728192209.GA26017@localhost.localdomain> <20140729175414.GA3289@redhat.com> <20140730163516.GC18158@localhost.localdomain> <20140730174630.GA30862@redhat.com> <20140731003034.GA32078@localhost.localdomain> <20140731160353.GA14772@redhat.com> <20140731171329.GD7842@localhost.localdomain> <20140731181230.GA18695@redhat.com> <20140731184729.GA12296@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140731184729.GA12296@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oleg@redhat.com
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

On 07/31, Frederic Weisbecker wrote:
>
> On Thu, Jul 31, 2014 at 08:12:30PM +0200, Oleg Nesterov wrote:
> > > >
> > > > Yes sure. But context_tracking_cpu_set() is called by init task with PID 1, not
> > > > by "swapper".
> > >
> > > Are you sure? It's called from start_kernel() which is init/0.
> >
> > But do_initcalls() is called by kernel_init(), this is the init process which is
> > going to exec /sbin/init later.
> >
> > But this doesn't really matter,
>
> Yeah but tick_nohz_init() is not an initcall, it's a function called from start_kernel(),
> before initcalls.

Ah, indeed, and context_tracking_init() too. Even better, so we only need

	--- x/kernel/context_tracking.c
	+++ x/kernel/context_tracking.c
	@@ -30,8 +30,10 @@ EXPORT_SYMBOL_GPL(context_tracking_enabl
	 DEFINE_PER_CPU(struct context_tracking, context_tracking);
	 EXPORT_SYMBOL_GPL(context_tracking);
	 
	-void context_tracking_cpu_set(int cpu)
	+void __init context_tracking_cpu_set(int cpu)
	 {
	+	/* Called by "swapper" thread, all threads will inherit this flag */
	+	set_thread_flag(TIF_NOHZ);
		if (!per_cpu(context_tracking.active, cpu)) {
			per_cpu(context_tracking.active, cpu) = true;
			static_key_slow_inc(&context_tracking_enabled);

and now we can kill context_tracking_task_switch() ?

> > Yes, yes, this doesn't really matter. We can even add set(TIF_NOHZ) at the start
> > of start_kernel(). The question is, I still can't understand why do we want to
> > have the global TIF_NOHZ.
>
> Because then the flags is inherited in forks. It's better than inheriting it on
> context switch due to context switch being called much more often than fork.

This is clear, that is why I suggested this. Just we didn't understand each other,
when I said "global TIF_NOHZ" I meant the current situtation when every (running)
task has this bit set anyway. Sorry for confusion.

> No, because preempt_schedule_irq() does the ctx_state save and restore with
> exception_enter/exception_exit.

Thanks again. Can't understand how I managed to miss that exception_enter/exit
in preempt_schedule_*.

Damn. And after I spent more time, I don't have any idea how to make this
tracking cheaper.

Oleg.
