Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2002 10:30:10 +0200 (CEST)
Received: from mx2.mips.com ([206.31.31.227]:14299 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1122961AbSIRIaJ>;
	Wed, 18 Sep 2002 10:30:09 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g8I8TqUD009629;
	Wed, 18 Sep 2002 01:29:52 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id BAA24820;
	Wed, 18 Sep 2002 01:30:00 -0700 (PDT)
Received: from mips.com (IDENT:carstenl@coplin20 [192.168.205.90])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g8I8Tpb28455;
	Wed, 18 Sep 2002 10:29:51 +0200 (MEST)
Message-ID: <3D88397E.8EFB8B13@mips.com>
Date: Wed, 18 Sep 2002 10:29:50 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31-P3-UP-WS-jg i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: linux-mips@linux-mips.org
Subject: Re: [RFC] FPU context switch
References: <20020917110423.E17321@mvista.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

Jun Sun wrote:

> I am rewriting the FPU management code with the following
> objectives in my mind:
>
> 1) to make it work for SMP.  Right now, processes can migrate
> to different CPUs leaving their FPU context on another CPU.
> And the global variable last_task_used_math is shared by
> multiple CPUs. :-)
>
> 2) to provide a layer to generic kernel code that hides
> the differences between fpu emul case and hard FPU case,
> so that we don't see many "if (mips_cpu.options & MIPS_CPU_FPU)"
> around.
>
> 3) to simplify some existing code (such as those in signal.c)
> so that we don't see many "if (last_task_used_math == ...)" around.
>
> I am now facing a couple of choices in the implementation and
> like to hear back from you.  Those choices mainly differ at when we
> should save fpu context and when we should restore it.
>
> 1) always blindly save and restore during context switch (switch_to())
>
> Not interesting.  Just list it here for completeness.
>
> 2) save PFU context when process is switched off *only if*
>    FPU is used in the last run.
>    restore FPU context on next use of FPU.
>
> Need to use an additional flag to remember whether it is used
> in the current run.  Perhaps overridding used_math?  In that
> case, used_math == 2 indicates it used in the current run.
> used_math is set back to 1 when process is switched off.
>

Let's go for solution 2.
Try to look in 64-bit kernel (when CONFIG_SMP is enabled), here solution
2 is already implemented (the plan is to implement this in the 32-bit
kernel as well, but please go a head and do it).
The extra flag you are looking for, is the PF_USEDFPU flag, which also is
used by other architecture.

Locally we have got rid of the '#ifdef CONFIG_SMP', and always do it the
SMP way.
The "last_task_used_math / lazy fpu switch" method has just cost to much
pain.




>
> Very simply to implement.
>
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
>         a) live FPU context in current CPU
>         b) saved FPU context in memory
>         c) live FPU context in another CPU
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
>
> Jun

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
