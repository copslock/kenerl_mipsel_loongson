Received:  by oss.sgi.com id <S553686AbRBHW7u>;
	Thu, 8 Feb 2001 14:59:50 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:7927 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553673AbRBHW7j>;
	Thu, 8 Feb 2001 14:59:39 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f18Mu0806647;
	Thu, 8 Feb 2001 14:56:00 -0800
Message-ID: <3A83247D.FC52431D@mvista.com>
Date:   Thu, 08 Feb 2001 14:58:05 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     "Kevin D. Kissell" <kevink@mips.com>
CC:     linux-mips@oss.sgi.com
Subject: Re: config option vs. run-time detection (the debate continues ...)
References: <3A830135.B1304041@mvista.com> <01bf01c0921b$6de26620$0deca8c0@Ulysses>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

"Kevin D. Kissell" wrote:
> 
> > I love this topic!
> 
> Well, I'm glad *you're* having fun!  ;-)
> 
> > Instead of replying to 10 different emails, I decide to sort out my best
> > understanding of this topic and list them here, including some of MY
> responses
> > to some of the issues.
> >
> > Definition:
> > ------------
> >
> > 1. Config option approach :
> >
> > In the kernel config menu, one picks one or more CPUs.  One also specifies
> > whether the CPU(s) have a FPU.
> >
> > All FPU related code in kernel is configured in or out based on the CONFIG
> > setting.
> 
> As has been noted in other messages in this exchange, whether one
> has an FPU or not isn't really the determining factor in including FP
> support code in the kernel.  The bulk of it is the emulator, and the
> emulator needs to be there if you want to execute binaries built
> to include MIPS FP instructions, whether in full emulation or using
> the FPU (for the denormal cases, etc.).
>

That needs a little more explanation.

. When I say "All FPU related code", I really meant FPU code which is not a
part of FPU emaulator.  One example is the code in exit_thread()
(arch/mips/process.c) as brough up by flo.  I believe there are also such code
in ptrace.c.

. Regarding whether we should have FPU emulator, I think it should be a
separate CONFIG option.  It is orthorgal to HAS_FPU option.

In other words, we will have four combinations:

 a) HAS_FPU & FPU_EMULATION - which is necessary when FPU is not a full
implementation.

 b) !HAS_FPU & FPU_EMULATION - which allows one to run fpu-ful userland
application

 c) HAS_FPU & !FPU_EMULATION - when FPU is a full implementaion (or use the
old incomplete emaulation?)

 d) !HAS_FPU & !FPU_EMULATION - it mandates non-fpu-ful userland (which to me
is perfectly fine)

I start to feel a little "shaky" here as I have not written any FPU code. 
Will such a classification make life easier or worse?  Is there any
feasibility issue here?


> 
> If you're building kernels for a workstation, that may be
> true.  If you're building kernels for a testbed where you're
> swapping CPU modules, it's actually rather nice to have
> a single kernel that boots on any of them.  I personally
> find myself in this situation.  Or to provide a less lab-oriented
> example, NEC has the R43xx family which have FPUs,
> and Toshiba markets some R49xx parts that are pin-compatible
> but cheaper - because they have no FPU.   If I were building
> a Linux-based system around either one, memory permitting,
> I would want to  have a kernel that could cope with either of
> them, to simplify the product management problem if I ever
> ended up wanting to cut over from one to the other.
> 

I think this example shifted my bias a little bit, although it has changed it
yet.

Are we confident we can do a clean run-time detection of all existing CPUs?

Jun
