Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Nov 2002 16:08:46 +0100 (CET)
Received: from p508B747B.dip.t-dialin.net ([80.139.116.123]:4844 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122118AbSKYPIq>; Mon, 25 Nov 2002 16:08:46 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gAPF80423363;
	Mon, 25 Nov 2002 16:08:00 +0100
Date: Mon, 25 Nov 2002 16:08:00 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Daniel Jacobowitz <dan@debian.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	atul srivastava <atulsrivastava9@rediffmail.com>,
	linux-mips@linux-mips.org
Subject: Re: watch exception only for kseg0 addresses..?
Message-ID: <20021125160800.A22590@linux-mips.org>
References: <20021125102458.B22046@linux-mips.org> <Pine.GSO.3.96.1021125123643.8769B-100000@delta.ds2.pg.gda.pl> <20021125144059.GA23310@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021125144059.GA23310@nevyn.them.org>; from dan@debian.org on Mon, Nov 25, 2002 at 09:40:59AM -0500
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 25, 2002 at 09:40:59AM -0500, Daniel Jacobowitz wrote:

> > > The whole watch stuff in the the kernel is pretty much an ad-hoc API
> > > which I did create to debug a stack overflow.  I'm sure if you're
> > > going to use it you'll find problems.  For userspace for example you'd
> > > have to switch the watch register when switching the MMU context so
> > > each process gets it's own virtual watch register.  Beyond that there
> > > are at least two different formats of watch registers implemented in
> > > actual silicon, the original R4000-style and the MIPS32/MIPS64 style
> > > watch registers and the kernel's watch code only know the R4000 style
> > > one.  So check your CPU's manual ...
> > 
> >  I think the best use of the watch exception would be making it available
> > to userland via PTRACE_PEEKUSR and PTRACE_POKEUSR for hardware watchpoint
> > support (e.g. for gdb).  Hardware support is absolutely necessary for
> > watching read accesses and much beneficial for write ones (otherwise gdb
> > single-steps code which sucks performace-wise).
> 
> (Although that isn't necessary; page-protection watchpoints are on my
> TODO for next year.  They aren't quite as efficient as hardware
> watchpoints but they don't require hardware support either, just an
> MMU.)
> 
> Heck, you can even do read watchpoints that way.
> 
> In any case, yes, the thing to do is choose an API for these and expose
> them via ptrace; not necessarily in PEEKUSER though.  There's no cost
> to adding new PTRACE_* ops.

I assume you got and R4000 manual and the MIPS64 spec.   R4000 implements
matching a physical address with a granularity of 8 bytes for load and
store operations.

MIPS64 extends that to also support instruction address matches; the
granularity can be set anywhere from 8 bytes to 4kB; in addition ASID
matching and a global bit can be used for matching.  A MIPS64 CPU can
support anywhere from 0 to 4 such watch registers.

The global bit stuff would only be useful for in-kernel use, I think.  The
ASID thing could be used to implement watchpoints for an entire process, not
just per thread though I doubt there is much use for something like that.

So how would a prefered ptrace(2) API for hardware watchpoints look like?

  Ralf
