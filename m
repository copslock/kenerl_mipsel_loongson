Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2002 21:01:07 +0200 (CEST)
Received: from gateway-1237.mvista.com ([12.44.186.158]:18927 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S1122987AbSIQTBG>;
	Tue, 17 Sep 2002 21:01:06 +0200
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id g8HImVR05439;
	Tue, 17 Sep 2002 11:48:31 -0700
Date: Tue, 17 Sep 2002 11:48:31 -0700
From: Jun Sun <jsun@mvista.com>
To: justinca@cs.cmu.edu
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [RFC] FPU context switch
Message-ID: <20020917114831.G17321@mvista.com>
References: <20020917110423.E17321@mvista.com> <1032288140.28433.165.camel@gs256.sp.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1032288140.28433.165.camel@gs256.sp.cs.cmu.edu>; from justinca@cs.cmu.edu on Tue, Sep 17, 2002 at 02:42:20PM -0400
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Sep 17, 2002 at 02:42:20PM -0400, justinca@cs.cmu.edu wrote:
> > 
> > This requires each CPU to remember the last owner of FPU.
> > In order to support possible process migration cases in a SMP
> > system, each process also needs to remember the processor
> > on which it used FPU last.  A process has a valid live FPU
> > context on a CPU if those two variables match to each other.
> > Therefore we can avoid unnecessary restoring FPU context.
> > 
> > Fairly complex in implementation. 
> > 
> 
> I'd argue for something between 2 & 3.  Always save FPU state, and if
> you know the state has been preserved for the next run, skip the
> restore.
> 

Determining whether the current FPU context is valid for the new
process is not easy.  It requires last_task_used_math like variable
for each CPU.

> I'm a bit leery of the whole "don't restore FPU state on context switch
> until you use the FPU again" idea as it's added complexity 

Quite easy to implement.  Just turn off ST0_CU1 bit in the status register
saved in the kernel stack when a process is switched off.  Therefore
next use of FPU will cause a trap and do_cpu() does the normal thing.

> and I'm not
> at all sure you're going to see any measurable performance gain out of
> it.  

I think this gives a big performance improvement because most processes
don't use FPU during their runs but they all have used_math flag set!


Jun
