Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0MGM7k12875
	for linux-mips-outgoing; Tue, 22 Jan 2002 08:22:07 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0MGLpP12872;
	Tue, 22 Jan 2002 08:21:52 -0800
Received: from drow by nevyn.them.org with local (Exim 3.33 #1 (Debian))
	id 16T2jo-00032O-00; Tue, 22 Jan 2002 10:21:28 -0500
Date: Tue, 22 Jan 2002 10:21:28 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Dominic Sweetman <dom@algor.co.uk>, Ralf Baechle <ralf@oss.sgi.com>,
   Ulrich Drepper <drepper@redhat.com>, Mike Uhler <uhler@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>,
   GNU libc hacker <libc-hacker@sources.redhat.com>,
   "H . J . Lu" <hjl@lucon.org>
Subject: Re: thread-ready ABIs
Message-ID: <20020122102128.A11455@nevyn.them.org>
References: <m3elkoa5dw.fsf@myware.mynet><20020118101908.C23887@lucon.org><01b801c1a081$3f6518e0$0deca8c0@Ulysses><20020119162415.B31028@dea.linux-mips.net><m3d703thl6.fsf@myware.mynet><01be01c1a2d7$6ec299c0$0deca8c0@Ulysses> <15437.14361.918255.115877@gladsmuir.algor.co.uk> <002001c1a33e$d9936560$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002001c1a33e$d9936560$0deca8c0@Ulysses>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jan 22, 2002 at 01:18:03PM +0100, Kevin D. Kissell wrote:
> I think that the problem is complicated by the fact that
> there may be a many->many mapping of kernel threads
> (and CPUs) to user-land threads.  In that case, no single
> low-memory address can be correct for all kernel threads.
> However, since every kernel thread should have its own
> stack segment, it would appear to me that having a
> variable "under" the stack would satisfy the need for
> per-kernel-thread storage at a knowable location.
> I suspect that there is a second-order problem in that
> the base stack address may differ for instances of
> the same binary launched under different circumstances.
> But I don't think that renders the problem impossible.
> One could have a global pointer, resolvable at link
> time, which could be set to SP+delta by whatever
> we call crt0 these days, and which should provide the
> required semantics.  Each user thread startup or 

Resolvable at link time and set by crt0 seem to be mutually
exclusive... but perhaps I'm misunderstanding you.

In any case, that's not the real problem.  Linux user threads do not
have true separate stacks.  They share their _entire_ address space;
the stacks are all bounded (default is 2MB) and grouped together at the
top of the available memory region.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
