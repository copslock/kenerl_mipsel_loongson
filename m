Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0MH5WO14122
	for linux-mips-outgoing; Tue, 22 Jan 2002 09:05:32 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0MH5MP14113;
	Tue, 22 Jan 2002 09:05:22 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id IAA02431;
	Tue, 22 Jan 2002 08:05:12 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id IAA17777;
	Tue, 22 Jan 2002 08:05:10 -0800 (PST)
Message-ID: <007601c1a35e$b3e3f940$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Daniel Jacobowitz" <dan@debian.org>
Cc: "Dominic Sweetman" <dom@algor.co.uk>, "Ralf Baechle" <ralf@oss.sgi.com>,
   "Ulrich Drepper" <drepper@redhat.com>, "Mike Uhler" <uhler@mips.com>,
   "MIPS/Linux List \(SGI\)" <linux-mips@oss.sgi.com>,
   "GNU libc hacker" <libc-hacker@sources.redhat.com>,
   "H . J . Lu" <hjl@lucon.org>
References: <m3elkoa5dw.fsf@myware.mynet><20020118101908.C23887@lucon.org><01b801c1a081$3f6518e0$0deca8c0@Ulysses><20020119162415.B31028@dea.linux-mips.net><m3d703thl6.fsf@myware.mynet><01be01c1a2d7$6ec299c0$0deca8c0@Ulysses> <15437.14361.918255.115877@gladsmuir.algor.co.uk> <002001c1a33e$d9936560$0deca8c0@Ulysses> <20020122102128.A11455@nevyn.them.org>
Subject: Re: thread-ready ABIs
Date: Tue, 22 Jan 2002 17:05:45 +0100
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

Tue, Jan 22, 2002 at 01:18:03PM +0100, Kevin D. Kissell wrote:
> > I think that the problem is complicated by the fact that
> > there may be a many->many mapping of kernel threads
> > (and CPUs) to user-land threads.  In that case, no single
> > low-memory address can be correct for all kernel threads.
> > However, since every kernel thread should have its own
> > stack segment, it would appear to me that having a
> > variable "under" the stack would satisfy the need for
> > per-kernel-thread storage at a knowable location.
> > I suspect that there is a second-order problem in that
> > the base stack address may differ for instances of
> > the same binary launched under different circumstances.
> > But I don't think that renders the problem impossible.
> > One could have a global pointer, resolvable at link
> > time, which could be set to SP+delta by whatever
> > we call crt0 these days, and which should provide the
> > required semantics.  Each user thread startup or 
> 
> Resolvable at link time and set by crt0 seem to be mutually
> exclusive... but perhaps I'm misunderstanding you.

You are.  The *address* of the pointer to the pointer
can be resolved at link time.  The *value* of the pointer
to the pointer is set by crt0 (if stack origins are not
intrinsically fixed at link time - if they are, the indirection
is not necessary).

> In any case, that's not the real problem.  Linux user threads do not
> have true separate stacks.  They share their _entire_ address space;
> the stacks are all bounded (default is 2MB) and grouped together at the
> top of the available memory region.

Exactly.  But if all we all we are worried about is thread
specific data for user threads multiplexed on exactly
one kernel thread, we could probably get by with a
simple global variable for the thread pointer for the
current user thread running in the process.   It's the
case of multiple user threads running within multiple
*kernel* threads (e.g. created by fork()) that complicates
things, and makes people want to use a register
or other storage resource associated with exactly one
kernel thread (and CPU).  A permanently assigned
register, as we have seen, creates various complications,
so I'm looking for another kernel-thread-specific resource,
of which I believe the stack region is the best candidate.
Each process/task/program would have a single global
variable, which points to a common address in the
stack region of each kernel thread, which is used
to store the address of the user-thread-specific
data of the user thread executing on that kernel thread.

Of course, I still haven't seen an informed description
of the actual problem that Ulrich and H.J. are trying to
solve, so it may in fact be simpler (or more complex).

            Regards,

            Kevin K.
