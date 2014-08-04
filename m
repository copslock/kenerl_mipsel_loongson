Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Aug 2014 14:02:45 +0200 (CEST)
Received: from e37.co.us.ibm.com ([32.97.110.158]:48470 "EHLO
        e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860164AbaHDMCjG9Drg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Aug 2014 14:02:39 +0200
Received: from /spool/local
        by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 4 Aug 2014 06:02:31 -0600
Received: from d03dlp02.boulder.ibm.com (9.17.202.178)
        by e37.co.us.ibm.com (192.168.1.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 4 Aug 2014 06:02:29 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 08FDE3E4004F
        for <linux-mips@linux-mips.org>; Mon,  4 Aug 2014 06:02:29 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
        by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s74C1AS63604744
        for <linux-mips@linux-mips.org>; Mon, 4 Aug 2014 14:01:10 +0200
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
        by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id s74C6fim010268
        for <linux-mips@linux-mips.org>; Mon, 4 Aug 2014 06:06:41 -0600
Received: from paulmck-ThinkPad-W500 (sig-9-65-2-239.mts.ibm.com [9.65.2.239])
        by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id s74C6e8g010221;
        Mon, 4 Aug 2014 06:06:40 -0600
Received: by paulmck-ThinkPad-W500 (Postfix, from userid 1000)
        id AE28E3814CC; Mon,  4 Aug 2014 05:02:25 -0700 (PDT)
Date:   Mon, 4 Aug 2014 05:02:25 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com
Subject: Re: TIF_NOHZ can escape nonhz mask? (Was: [PATCH v3 6/8] x86:  Split
 syscall_trace_enter into two phases)
Message-ID: <20140804120225.GA32378@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20140728192209.GA26017@localhost.localdomain>
 <20140729175414.GA3289@redhat.com>
 <20140730163516.GC18158@localhost.localdomain>
 <20140730174630.GA30862@redhat.com>
 <20140731003034.GA32078@localhost.localdomain>
 <20140731160353.GA14772@redhat.com>
 <20140731171329.GD7842@localhost.localdomain>
 <20140731181230.GA18695@redhat.com>
 <20140731184729.GA12296@localhost.localdomain>
 <20140802173024.GB22510@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140802173024.GB22510@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 14080412-7164-0000-0000-00000392736B
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paulmck@linux.vnet.ibm.com
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

On Sat, Aug 02, 2014 at 07:30:24PM +0200, Oleg Nesterov wrote:
> On 07/31, Frederic Weisbecker wrote:
> >
> > On Thu, Jul 31, 2014 at 08:12:30PM +0200, Oleg Nesterov wrote:
> > > > >
> > > > > Yes sure. But context_tracking_cpu_set() is called by init task with PID 1, not
> > > > > by "swapper".
> > > >
> > > > Are you sure? It's called from start_kernel() which is init/0.
> > >
> > > But do_initcalls() is called by kernel_init(), this is the init process which is
> > > going to exec /sbin/init later.
> > >
> > > But this doesn't really matter,
> >
> > Yeah but tick_nohz_init() is not an initcall, it's a function called from start_kernel(),
> > before initcalls.
> 
> Ah, indeed, and context_tracking_init() too. Even better, so we only need
> 
> 	--- x/kernel/context_tracking.c
> 	+++ x/kernel/context_tracking.c
> 	@@ -30,8 +30,10 @@ EXPORT_SYMBOL_GPL(context_tracking_enabl
> 	 DEFINE_PER_CPU(struct context_tracking, context_tracking);
> 	 EXPORT_SYMBOL_GPL(context_tracking);
> 	 
> 	-void context_tracking_cpu_set(int cpu)
> 	+void __init context_tracking_cpu_set(int cpu)
> 	 {
> 	+	/* Called by "swapper" thread, all threads will inherit this flag */
> 	+	set_thread_flag(TIF_NOHZ);
> 		if (!per_cpu(context_tracking.active, cpu)) {
> 			per_cpu(context_tracking.active, cpu) = true;
> 			static_key_slow_inc(&context_tracking_enabled);
> 
> and now we can kill context_tracking_task_switch() ?
> 
> > > Yes, yes, this doesn't really matter. We can even add set(TIF_NOHZ) at the start
> > > of start_kernel(). The question is, I still can't understand why do we want to
> > > have the global TIF_NOHZ.
> >
> > Because then the flags is inherited in forks. It's better than inheriting it on
> > context switch due to context switch being called much more often than fork.
> 
> This is clear, that is why I suggested this. Just we didn't understand each other,
> when I said "global TIF_NOHZ" I meant the current situtation when every (running)
> task has this bit set anyway. Sorry for confusion.
> 
> > No, because preempt_schedule_irq() does the ctx_state save and restore with
> > exception_enter/exception_exit.
> 
> Thanks again. Can't understand how I managed to miss that exception_enter/exit
> in preempt_schedule_*.
> 
> Damn. And after I spent more time, I don't have any idea how to make this
> tracking cheaper.

Mike Galbraith's profiles showed that timekeeping was one of the most
expensive operations.  Would it make sense to have the option of statistical
jiffy-based accounting?  The idea would be to sample the jiffies counter
at each context switch, and charge the time to whoever happens to be running
when the jiffies counter increments.

							Thanx, Paul
