Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Feb 2003 18:45:30 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:12795 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225222AbTBGSpa>;
	Fri, 7 Feb 2003 18:45:30 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h17IeKV04962;
	Fri, 7 Feb 2003 10:40:20 -0800
Date: Fri, 7 Feb 2003 10:40:20 -0800
From: Jun Sun <jsun@mvista.com>
To: Vivien Chappelier <vivienc@nerim.net>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [PATCH 2.5] r4k_switch task_struct/thread_info fixes
Message-ID: <20030207104020.K13258@mvista.com>
References: <20030206163647.F13258@mvista.com> <Pine.LNX.4.21.0302071019550.1913-100000@melkor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0302071019550.1913-100000@melkor>; from vivienc@nerim.net on Fri, Feb 07, 2003 at 10:29:16AM +0100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, Feb 07, 2003 at 10:29:16AM +0100, Vivien Chappelier wrote:
> On Thu, 6 Feb 2003, Jun Sun wrote:
> 
> > Actually the following hunks are not right.  ST_OFF
> > should be applied against the task_struct, which is a0,
> > not thread_info (t3).
> 
> In 2.4 yes, not in 2.5.
> 

You are right.  I got misled.  I thought task struct has 2 page 
size and thread_info is allocated from slab.  It should be reverse.

> include/linux/sched.h:469
> > union thread_union {
> >         struct thread_info thread_info;
> >         unsigned long stack[INIT_THREAD_SIZE/sizeof(long)];
> > };
> 
> That means the top of the stack is actually at (task->thread_info +
> KERNEL_STACK_SIZE) in 2.5. See for example arch/mips64/kernel/ptrace.c:107
> 
> > Also see my next email before you rush into trying :-)
> 
> Ok, I'll look at it later.
>

It turns I made a rather stupid comment there as well.  See it there.  :-)

Jun
