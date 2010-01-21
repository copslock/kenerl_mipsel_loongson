Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2010 20:04:32 +0100 (CET)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:60204 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492967Ab0AVTEA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jan 2010 20:04:00 +0100
Received: from hrndva-omtalb.mail.rr.com ([10.128.143.53])
          by hrndva-qmta01.mail.rr.com with ESMTP
          id <20100121193536626.WBMM28317@hrndva-qmta01.mail.rr.com>;
          Thu, 21 Jan 2010 19:35:36 +0000
X-Authority-Analysis: v=1.0 c=1 a=LvvgB44tUwgA:10 a=7U3hwN5JcxgA:10 a=OIjbozEIWfTmjb7YNkQA:9 a=kQ4WGFup1W9nbtoZGogA:7 a=gu0YGKBbomRPw-43JY4RNGwHwlwA:4
X-Cloudmark-Score: 0
X-Originating-IP: 74.67.89.75
Received: from [74.67.89.75] ([74.67.89.75:46771] helo=[192.168.23.10])
        by hrndva-oedge03.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.2.39 r()) with ESMTP
        id D2/A4-05903-73CA85B4; Thu, 21 Jan 2010 19:34:17 +0000
Subject: Re: Lots of bugs with current->state = TASK_*INTERRUPTIBLE
From:   Steven Rostedt <rostedt@goodmis.org>
Reply-To: rostedt@goodmis.org
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, Greg KH <greg@kroah.com>,
        Andy Whitcroft <apw@canonical.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <4B58A89A.8050405@caviumnetworks.com>
References: <1263932978.31321.53.camel@gandalf.stny.rr.com>
         <4B58A89A.8050405@caviumnetworks.com>
Content-Type: text/plain; charset="ISO-8859-15"
Organization: Kihon Technologies Inc.
Date:   Thu, 21 Jan 2010 14:34:15 -0500
Message-ID: <1264102455.31321.293.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
X-archive-position: 25625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 14369

On Thu, 2010-01-21 at 11:18 -0800, David Daney wrote:
> Steven Rostedt wrote:
> > Peter Zijlstra and I were doing a look over of places that assign
> > current->state = TASK_*INTERRUPTIBLE, by simply looking at places with:
> > 
> >  $ git grep -A1 'state[[:space:]]*=[[:space:]]*TASK_[^R]'
> > 
> > and it seems there are quite a few places that looks like bugs. To be on
> > the safe side, everything outside of a run queue lock that sets the
> > current state to something other than TASK_RUNNING (or dead) should be
> > using set_current_state().
> > 
> > 	current->state = TASK_INTERRUPTIBLE;
> > 	schedule();
> > 
> > is probably OK, but it would not hurt to be consistent. Here's a few
> > examples of likely bugs:
> > 
> [...]
> 
> This may be a bit off topic, but exactly which type of barrier should 
> set_current_state() be implying?
> 
> On MIPS, set_mb() (which is used by set_current_state()) has a full mb().
> 
> Some MIPS based processors have a much lighter weight wmb().  Could 
> wmb() be used in place of mb() here?

Nope, wmb() is not enough. Below is an explanation.

> 
> If not, an explanation of the required memory ordering semantics here 
> would be appreciated.
> 
> I know the documentation says:
> 
>      set_current_state() includes a barrier so that the write of
>      current->state is correctly serialised wrt the caller's subsequent
>      test of whether to actually sleep:
> 
>   	set_current_state(TASK_UNINTERRUPTIBLE);
>   	if (do_i_need_to_sleep())
>   		schedule();
> 
> 
> Since the current CPU sees the memory accesses in order, what can be 
> happening on other CPUs that would require a full mb()?

Lets look at a hypothetical situation with:

	add_wait_queue();
	current->state = TASK_UNINTERRUPTIBLE;
	smp_wmb();
	if (!x)
		schedule();



Then somewhere we probably have:

	x = 1;
	smp_wmb();
	wake_up(queue);



	   CPU 0			   CPU 1
	------------			-----------
	add_wait_queue();
	(cpu pipeline sees a load
	 of x ahead, and preloads it)
					x = 1;
					smp_wmb();
					wake_up(queue);
					(task on CPU 0 is still at
					 TASK_RUNNING);

	current->state = TASK_INTERRUPTIBLE;
	smp_wmb(); <<-- does not prevent early loading of x
	if (!x)  <<-- returns true
		schedule();

Now the task on CPU 0 missed the wake up.

Note, places that call schedule() are not fast paths, and probably not
called often. Adding the overhead of smp_mb() to ensure correctness is a
small price to pay compared to search for why you have a stuck task that
was never woken up.

Read Documentation/memory-barriers.txt, it will be worth the time you
spend doing so.

-- Steve
