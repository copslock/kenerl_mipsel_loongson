Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2002 20:16:58 +0200 (CEST)
Received: from gateway-1237.mvista.com ([12.44.186.158]:53231 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S1122987AbSIQSQ5>;
	Tue, 17 Sep 2002 20:16:57 +0200
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id g8HI4Nf05292;
	Tue, 17 Sep 2002 11:04:23 -0700
Date: Tue, 17 Sep 2002 11:04:23 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [RFC] FPU context switch
Message-ID: <20020917110423.E17321@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


I am rewriting the FPU management code with the following
objectives in my mind:

1) to make it work for SMP.  Right now, processes can migrate
to different CPUs leaving their FPU context on another CPU.
And the global variable last_task_used_math is shared by
multiple CPUs. :-)

2) to provide a layer to generic kernel code that hides
the differences between fpu emul case and hard FPU case,
so that we don't see many "if (mips_cpu.options & MIPS_CPU_FPU)"
around.

3) to simplify some existing code (such as those in signal.c)
so that we don't see many "if (last_task_used_math == ...)" around.

I am now facing a couple of choices in the implementation and 
like to hear back from you.  Those choices mainly differ at when we 
should save fpu context and when we should restore it.

1) always blindly save and restore during context switch (switch_to())

Not interesting.  Just list it here for completeness.

2) save PFU context when process is switched off *only if* 
   FPU is used in the last run.  
   restore FPU context on next use of FPU.

Need to use an additional flag to remember whether it is used
in the current run.  Perhaps overridding used_math?  In that
case, used_math == 2 indicates it used in the current run.
used_math is set back to 1 when process is switched off.

Very simply to implement.

3) save FPU context when process is switched off *only if* 
   FPU is used in the last run.  
   restore FPU context on the next use of FPU and *only* if other 
   processes have tampered FPU context since the last use of FPU by 
   the current process.

This requires each CPU to remember the last owner of FPU.
In order to support possible process migration cases in a SMP
system, each process also needs to remember the processor
on which it used FPU last.  A process has a valid live FPU
context on a CPU if those two variables match to each other.
Therefore we can avoid unnecessary restoring FPU context.

Fairly complex in implementation. 


4) don't save or restore any FPU context during context switches.
   Instead, we implement a full SMP-safe version of lazy fpu 
   switch.

This introduces three states in terms of FPU context status:
	a) live FPU context in current CPU
	b) saved FPU context in memory
	c) live FPU context in another CPU
Before we only have a) and b) states.  c) is new in this approach.

To deal with c), we need to provide an inter-processor call so that
we can ask another CPU to save FPU context in case we need to access
it on this CPU.

Additionally we need similar variables required in 3) to keep track
who owns FPU at any time.

Very complex to implement.  Has the best performance, though.

Currently I am leaning towards 2) or 3).  What is your opinion?

Jun
