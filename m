Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2002 01:57:54 +0200 (CEST)
Received: from gateway-1237.mvista.com ([12.44.186.158]:48882 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S1122987AbSIQX5y>;
	Wed, 18 Sep 2002 01:57:54 +0200
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id g8HNjKx27046;
	Tue, 17 Sep 2002 16:45:20 -0700
Date: Tue, 17 Sep 2002 16:45:20 -0700
From: Jun Sun <jsun@mvista.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [RFC] FPU context switch
Message-ID: <20020917164520.P17321@mvista.com>
References: <20020917110423.E17321@mvista.com> <01ad01c25ea4$435ab220$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01ad01c25ea4$435ab220$10eca8c0@grendel>; from kevink@mips.com on Wed, Sep 18, 2002 at 01:44:57AM +0200
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Sep 18, 2002 at 01:44:57AM +0200, Kevin D. Kissell wrote:
> > I am now facing a couple of choices in the implementation and 
> > like to hear back from you.  Those choices mainly differ at when we 
> > should save fpu context and when we should restore it.
> > 
> > 1) always blindly save and restore during context switch (switch_to())
> > 
> > Not interesting.  Just list it here for completeness.
> 
> Not everything that is interesting is worth doing.
> And not everything worth doing is interesting.
> 
> > 2) save PFU context when process is switched off *only if* 
> >    FPU is used in the last run.  
> >    restore FPU context on next use of FPU.
> > 
> > Need to use an additional flag to remember whether it is used
> > in the current run.
> >
> > Perhaps overridding used_math?  In that
> > case, used_math == 2 indicates it used in the current run.
> > used_math is set back to 1 when process is switched off.
> > 
> > Very simply to implement.
> 
> It's still somewhat less simple than the current hack,
> and *that* was gotten wrong repeatedly.
>

It is much simpler than the current hack, because it does not
maintain last_task_used_math or any "lazy switch" concepts.

 
> 
> I'd much prefer something that is simple and processor-local,
> even if it may be less optimal in some corner cases.  For example,
> Why not simply use CP0.Status.CU1 as a "dirty" bit?  If it's set 
> when a process switches out, the FPU state gets saved, and CU1 
> cleared.  If it's not set when a process hits an FP instruction, 
> CU1 gets set and the context gets loaded. This involves no 
> access whatever to shared control variables, indeed, it doesn't 
> even go to memory to make the decision. It will, of course, save 
> some FP contexts that don't need saving, but it is well behaved
> in the cases I care most about - it avoids saving/restoring FPRs
> of code that is doing no FP whatsoever, and it ensures that
> whenever a thread starts up, whatever CPU its on, its full
> context is available to that CPU, no (coherent) questions asked.
> 

This is basically 2) except for dirty bit difference.

My current implementaion uses bit:1 in task->used_math flag for 
"dirty" bit purpose.

I was thinking to use CU1, but it turns out to be a non-
reliable indicator.  Several places inside the kernel
turning on/off FPUs.

Perhaps after further cleanups, these offending places may become
obsolete.  I will keep this option in my mind.


Jun
