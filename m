Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1KFNr514515
	for linux-mips-outgoing; Wed, 20 Feb 2002 07:23:53 -0800
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1KFNj914512
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 07:23:45 -0800
Received: from dea.linux-mips.net (a1as06-p249.stg.tli.de [195.252.187.249]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA04445
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 06:23:41 -0800 (PST)
	mail_from (ralf@linux-mips.net)
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1KDoNa16490;
	Wed, 20 Feb 2002 14:50:23 +0100
Date: Wed, 20 Feb 2002 14:50:23 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Daniel Jacobowitz <dan@debian.org>, Jun Sun <jsun@mvista.com>,
   Greg Lindahl <lindahl@conservativecomputer.com>, linux-mips@oss.sgi.com
Subject: Re: FPU emulator unsafe for SMP?
Message-ID: <20020220145023.G15588@dea.linux-mips.net>
References: <20020214232030.A3601@mvista.com> <20020215003037.A3670@mvista.com> <002b01c1b607$6afbd5c0$10eca8c0@grendel> <20020219140514.C25739@mvista.com> <00af01c1b9a2$c0d6d5f0$10eca8c0@grendel> <20020219171238.E25739@mvista.com> <20020219222835.A4195@wumpus.skymv.com> <20020219202434.F25739@mvista.com> <20020219233222.A22099@nevyn.them.org> <006001c1b9f7$7da1c920$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <006001c1b9f7$7da1c920$0deca8c0@Ulysses>; from kevink@mips.com on Wed, Feb 20, 2002 at 11:14:02AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Feb 20, 2002 at 11:14:02AM +0100, Kevin D. Kissell wrote:

> One cannot make design decisions based on what one
> "thinks is pretty common".   Binding threads to CPUs
> (CPU affinity) is almost always more efficient when
> the behavior of the workload looks like batch FORTRAN
> processing.   It's when one gets a mix of computational
> and interactive jobs that it often creates unfortunate
> artifacts, and thus must be handled with care.

Today's CPU performance is mainly dictated by exploiting caches as well
as possible.  So that means timeslices should be as long as possible.
At the same time we have the contradicting issue of scheduling latency.
The Linux scheduler already contains some heuristics that is trying to
find a sweet spot in between those two.

> > Not true.  For instance, on a processor with hardware FPU, setjmp()
> > will save FPU registers.  That means most processes will actually end
> > up taking the FPU at least once.
> 
> Almost all MIPS/Linux threads, from init() onward, have FPU state, 
> due to setjmp(), printf() (which uses the FP registers even
> if one does not specify a floating point data item or format), etc.

Printf doesn't ever use floating point due to possible rounding errors.

> Has anyone ever measured the performance impact of
> lazy FPU context switching on MIPS?   It's one of those
> ideas that was trendy in the 1980's, but I recall that when
> we implemented it  for SVR2 on the Fairchild Clipper 
> (which had only 16 FP registers), the measured improvement 
> on average context switch time was tiny - a percent or so.
> We left it in, because it worked and it *was* an improvement,
> but we would never have gone through the hassle had we
> known how little it would buy us.

These days I assume the difference to be greater for cache reasons.  Our
stored fp registers take 256 bytes and also tend to be located at a constant
offset from start of the 8kB (64-bit: 16kB) aligned task_struct.  Combined
with the usually low degree of cache associativity on MIPS that means
we'll frequently miss L1.  And many MIPS systems still don't come with
L2 caches, so fiddling with anything stored in the task_struct may
easily become quite expensive.  In fact on the worst case CPU, the R4000PC
context switching the fprs will result in guaranteed worst case
performance, we'll *always* have to writeback / refill the affected
cache lines from memory.

In this context I should also note that the FP context used by the kernel
stores in the 32-bit kernel provides space for 32 double precission
registers.  We only use the 16/32 register model so will pump twice as
many cachelines over the memory bus at postcard speed ...

Btw, Fairchild Clipper is the same Clipper that was used by Intergraph?

> It occurs to me that we can to some degree "split
> the difference" on FPU context management for
> SMP if we *always* save the FPU state when a
> thread switches out, but preserve the logic that
> schedules threads with CU1 inhibited so that the
> context is only *loaded* if the thread executes
> FP instructions.  That would save about half of
> the context switch overhead for non-FP-intensive
> threads, while eliminating the migration problem.

As I also suggested in my other mail.  Guess we got a winner.

  Ralf
