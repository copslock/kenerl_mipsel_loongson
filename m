Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2002 01:43:05 +0200 (CEST)
Received: from mx2.mips.com ([206.31.31.227]:47572 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1122987AbSIQXnE>;
	Wed, 18 Sep 2002 01:43:04 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g8HNgsUD008089;
	Tue, 17 Sep 2002 16:42:54 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id QAA09925;
	Tue, 17 Sep 2002 16:43:04 -0700 (PDT)
Message-ID: <01ad01c25ea4$435ab220$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: <linux-mips@linux-mips.org>, "Jun Sun" <jsun@mvista.com>
References: <20020917110423.E17321@mvista.com>
Subject: Re: [RFC] FPU context switch
Date: Wed, 18 Sep 2002 01:44:57 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> I am now facing a couple of choices in the implementation and 
> like to hear back from you.  Those choices mainly differ at when we 
> should save fpu context and when we should restore it.
> 
> 1) always blindly save and restore during context switch (switch_to())
> 
> Not interesting.  Just list it here for completeness.

Not everything that is interesting is worth doing.
And not everything worth doing is interesting.

> 2) save PFU context when process is switched off *only if* 
>    FPU is used in the last run.  
>    restore FPU context on next use of FPU.
> 
> Need to use an additional flag to remember whether it is used
> in the current run.
>
> Perhaps overridding used_math?  In that
> case, used_math == 2 indicates it used in the current run.
> used_math is set back to 1 when process is switched off.
> 
> Very simply to implement.

It's still somewhat less simple than the current hack,
and *that* was gotten wrong repeatedly.

> 3) save FPU context when process is switched off *only if* 
>    FPU is used in the last run.  
>    restore FPU context on the next use of FPU and *only* if other 
>    processes have tampered FPU context since the last use of FPU by 
>    the current process.
> 
> This requires each CPU to remember the last owner of FPU.
> In order to support possible process migration cases in a SMP
> system, each process also needs to remember the processor
> on which it used FPU last.  A process has a valid live FPU
> context on a CPU if those two variables match to each other.
> Therefore we can avoid unnecessary restoring FPU context.
> 
> Fairly complex in implementation.
>
> 4) don't save or restore any FPU context during context switches.
>    Instead, we implement a full SMP-safe version of lazy fpu 
>    switch.
> 
> This introduces three states in terms of FPU context status:
> a) live FPU context in current CPU
> b) saved FPU context in memory
> c) live FPU context in another CPU
> Before we only have a) and b) states.  c) is new in this approach.
> 
> To deal with c), we need to provide an inter-processor call so that
> we can ask another CPU to save FPU context in case we need to access
> it on this CPU.
> 
> Additionally we need similar variables required in 3) to keep track
> who owns FPU at any time.
> 
> Very complex to implement.  Has the best performance, though.
> 
> Currently I am leaning towards 2) or 3).  What is your opinion?

My opinion is that an FP context restore costs something on the
order of 40 in-line instructions which touch contiguous data.
You don't need to load and evaluate very many control variables
to burn through those 40-odd cycles, particularly if you are 
manipulating volatile coherent shared cache lines on a cache-coherent
SMP (let's not even talk about what happens if you haven't
got cache coherence).  "FPU Shootdowns", which is essentially 
what you're calling for in 4c, would, in my opinion, be a Bad Thing.

I'd much prefer something that is simple and processor-local,
even if it may be less optimal in some corner cases.  For example,
Why not simply use CP0.Status.CU1 as a "dirty" bit?  If it's set 
when a process switches out, the FPU state gets saved, and CU1 
cleared.  If it's not set when a process hits an FP instruction, 
CU1 gets set and the context gets loaded. This involves no 
access whatever to shared control variables, indeed, it doesn't 
even go to memory to make the decision. It will, of course, save 
some FP contexts that don't need saving, but it is well behaved
in the cases I care most about - it avoids saving/restoring FPRs
of code that is doing no FP whatsoever, and it ensures that
whenever a thread starts up, whatever CPU its on, its full
context is available to that CPU, no (coherent) questions asked.

                Regards,

                Kevin K.
