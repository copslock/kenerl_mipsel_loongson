Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Aug 2004 18:13:07 +0100 (BST)
Received: from p508B66F0.dip.t-dialin.net ([IPv6:::ffff:80.139.102.240]:22073
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225236AbUHWRND>; Mon, 23 Aug 2004 18:13:03 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i7NHCwuR027355;
	Mon, 23 Aug 2004 19:12:58 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i7NHCviJ027354;
	Mon, 23 Aug 2004 19:12:57 +0200
Date: Mon, 23 Aug 2004 19:12:57 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Dominic Sweetman <dom@mips.com>, Jun Sun <jsun@mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: anybody tried NPTL?
Message-ID: <20040823171256.GC21884@linux-mips.org>
References: <20040804152936.D6269@mvista.com> <16676.46694.564448.344602@arsenal.mips.com> <20040819221646.GC8737@mvista.com> <16678.163.774841.111369@arsenal.mips.com> <20040823132853.GA31354@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040823132853.GA31354@nevyn.them.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 23, 2004 at 09:28:53AM -0400, Daniel Jacobowitz wrote:

> On Fri, Aug 20, 2004 at 02:46:11PM +0100, Dominic Sweetman wrote:
> > I guess our main message was that we felt it would be a mistake just
> > to add a thread register to o32 (which produces a substantially
> > incompatible new ABI anyway).
> 
> Completely agree...
> 
> > Until that all works, what we had in mind is that we'd do NPTL over
> > o32 by defining a system call to return a per-thread ID which is or
> > can be converted into a per-thread data pointer.  We suspected that
> > NPTL's per-thread-data model allows the use of cunning macros or
> > library functions to make that look OK.
> > 
> > Ought we to go further and see exactly how that can be done?
> 
> It shouldn't be at all hard.  The way NPTL's __thread support works,
> the only things that should have to know where the TLS base is are
> (A) GCC, so it can load it and (B) GDB, via some new ptrace op.  I
> don't know if you'd want to open-code the syscall or take the overhead
> of a function call.  Ralf had some ideas?

Thiemo and have been compiling various pieces of code with different
gcc versions trying to find the best possible register for that purpose.
We used code bloat as (weak ...) indicator for register pressure.  It
turned out that $t9 was the best choice for all tested compiler versions;
thanks to the much improved register allocation of newer gcc the choice
of a particular register made far less difference on recent compilers
than on older compilers.

I've also implemented a fast system call for reading the thread registers.
Benchmarks did show that to have about half the latency of a regular
syscall; the hope was if gcc was doing clever optimization that overhead
would effectivly become zero.

I was favoring this low-overhead syscall approach because it would avoid
the loss of a register thus leaving performance of non-threaded code
unchanged but other developers generally favor the permanent allocation
of $t9 as a thread register.

Other crazy ideas did include a per-thread mapping containing the thread
pointer - and possibly more information in the future.

Finally one of the ideas was using one of $k0 / $k1 as thread pointer.
This would require changes to the exception handlers; any extra
instruction in the TLB refill handler would be particularly painful.

On the positive side if we had multiple register sets on a MIPSxx V2
processor we could exploit that to get rid of this overheade and do
other nice optimizations for TLB reload also.  Unfortunately these
register sets are optional feature of the architecture only.

  Ralf
