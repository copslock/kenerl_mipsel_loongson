Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1K155N32479
	for linux-mips-outgoing; Tue, 19 Feb 2002 17:05:05 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1K14w932473
	for <linux-mips@oss.sgi.com>; Tue, 19 Feb 2002 17:04:58 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id QAA05743;
	Tue, 19 Feb 2002 16:04:50 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id QAA02722;
	Tue, 19 Feb 2002 16:04:49 -0800 (PST)
Message-ID: <00af01c1b9a2$c0d6d5f0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Jun Sun" <jsun@mvista.com>
Cc: <linux-mips@oss.sgi.com>
References: <3C6C6ACF.CAD2FFC@mvista.com> <20020215031118.B21011@dea.linux-mips.net> <20020214232030.A3601@mvista.com> <20020215003037.A3670@mvista.com> <002b01c1b607$6afbd5c0$10eca8c0@grendel> <20020219140514.C25739@mvista.com>
Subject: Re: FPU emulator unsafe for SMP?
Date: Wed, 20 Feb 2002 01:08:30 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> > > Hmm, I see. The lazy fpu context switch code is not SMP safe.
> > > I see fishy things like "last_task_used_math" etc...
> > 
> > What, you mean "last_task_used_math" isn't allocated in a
> > processor-specific page of kseg3???    ;-)
> 
> You must be talking about another OS, right? :-)  I don't think 
> Linux has processor-specific page, although this sounds like
> a good idea to explore.

It's gotta be done.  I mean, the last I heard (which was a long
time ago) mips64 Linux was keeping the CPU node number in
a watchpoint register (or something equally unwholesome) and
using that value as an index into tables.  Sticking all the per-CPU
state in a kseg3 VM page which is allocated and locked at boot
time would be much cleaner and on the average probably quite
a bit faster (definitely faster in the kernel but to be fair one has
to factor in the increase in TLB pressure from the locked entry).

But getting back to the original topic, there's another fun bug
waiting for us in MIPS/Linux SMP floating point that can't
be fixed as easly with VM slight-of-hand.  Consider processes
"A" and "B", where A uses FP and B does not:  A gets scheduled
on CPU 1, runs for a while, gets preempted, and B gets CPU 1.
CPU 2 gets freed, so A gets scheduled on CPU 2.  Unfortunately,
A's FP state is still in the FP register set of CPU 1.  The lazy FPU
context switch either needs to be turned off (bleah!) or be fixed
for SMP to handle the case where the "owner" of the FPR's
on one CPU gets scheduled on another.  

The brute force would be somehow to send an interrupt to the CPU 
with the FP state that will cause it to cough it up into the thread context 
area.  One alternative would be to give strict CPU affinity to the thread 
that has it's FP state on a particular CPU.  That could complicate load 
balancing, but might not really be too bad.  At most one thread per CPU 
will be non-migratable at a given point in time.  In the above scenario, 
"A" could never migrate off of CPU 1, but "B" could, and would 
presumably be picked up by an idle CPU 2 as soon as it's time slice 
is up on CPU 1.  That will be less efficient than doing an "FPU shootdown"
in some cases, but it should also be more portable and easier 
to get right.

Does this come up in x86-land?  The FPU state is much smaller
there, so lazy context switching is presumably less important.

            Kevin K. 
