Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0MHYR014829
	for linux-mips-outgoing; Tue, 22 Jan 2002 09:34:27 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0MHYFP14826;
	Tue, 22 Jan 2002 09:34:15 -0800
Received: from drow by nevyn.them.org with local (Exim 3.33 #1 (Debian))
	id 16T3sK-0003jo-00; Tue, 22 Jan 2002 11:34:20 -0500
Date: Tue, 22 Jan 2002 11:34:20 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Dominic Sweetman <dom@algor.co.uk>, Ralf Baechle <ralf@oss.sgi.com>,
   Ulrich Drepper <drepper@redhat.com>, Mike Uhler <uhler@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>,
   "H . J . Lu" <hjl@lucon.org>
Subject: Re: thread-ready ABIs
Message-ID: <20020122113420.A14284@nevyn.them.org>
References: <m3elkoa5dw.fsf@myware.mynet><20020118101908.C23887@lucon.org><01b801c1a081$3f6518e0$0deca8c0@Ulysses><20020119162415.B31028@dea.linux-mips.net><m3d703thl6.fsf@myware.mynet><01be01c1a2d7$6ec299c0$0deca8c0@Ulysses> <15437.14361.918255.115877@gladsmuir.algor.co.uk> <002001c1a33e$d9936560$0deca8c0@Ulysses> <20020122102128.A11455@nevyn.them.org> <007601c1a35e$b3e3f940$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007601c1a35e$b3e3f940$0deca8c0@Ulysses>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jan 22, 2002 at 05:05:45PM +0100, Kevin D. Kissell wrote:
> > In any case, that's not the real problem.  Linux user threads do not
> > have true separate stacks.  They share their _entire_ address space;
> > the stacks are all bounded (default is 2MB) and grouped together at the
> > top of the available memory region.
> 
> Exactly.  But if all we all we are worried about is thread
> specific data for user threads multiplexed on exactly
> one kernel thread, we could probably get by with a
> simple global variable for the thread pointer for the
> current user thread running in the process.   It's the
> case of multiple user threads running within multiple
> *kernel* threads (e.g. created by fork()) that complicates
> things, and makes people want to use a register
> or other storage resource associated with exactly one
> kernel thread (and CPU).  A permanently assigned
> register, as we have seen, creates various complications,
> so I'm looking for another kernel-thread-specific resource,
> of which I believe the stack region is the best candidate.
> Each process/task/program would have a single global
> variable, which points to a common address in the
> stack region of each kernel thread, which is used
> to store the address of the user-thread-specific
> data of the user thread executing on that kernel thread.

Perhaps I'm mangling terminology.  LinuxThreads is a one-to-one mapping
of kernel threads to user threads.  All the kernel threads, and thus
all the user threads, share the same memory region - including the
stack region.  Their stacks are differentiated solely by different
values in the stack pointer register.  Thus I don't think what you're
suggesting is possible.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
