Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Aug 2004 18:44:57 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:10682 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225005AbUHWRov>;
	Mon, 23 Aug 2004 18:44:51 +0100
Received: from drow by nevyn.them.org with local (Exim 4.34 #1 (Debian))
	id 1BzIsB-0002Am-Da; Mon, 23 Aug 2004 13:44:47 -0400
Date: Mon, 23 Aug 2004 13:44:47 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Dominic Sweetman <dom@mips.com>, Jun Sun <jsun@mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: anybody tried NPTL?
Message-ID: <20040823174446.GA8197@nevyn.them.org>
References: <20040804152936.D6269@mvista.com> <16676.46694.564448.344602@arsenal.mips.com> <20040819221646.GC8737@mvista.com> <16678.163.774841.111369@arsenal.mips.com> <20040823132853.GA31354@nevyn.them.org> <20040823171256.GC21884@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040823171256.GC21884@linux-mips.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 23, 2004 at 07:12:57PM +0200, Ralf Baechle wrote:
> Thiemo and have been compiling various pieces of code with different
> gcc versions trying to find the best possible register for that purpose.
> We used code bloat as (weak ...) indicator for register pressure.  It
> turned out that $t9 was the best choice for all tested compiler versions;
> thanks to the much improved register allocation of newer gcc the choice
> of a particular register made far less difference on recent compilers
> than on older compilers.
> 
> I've also implemented a fast system call for reading the thread registers.
> Benchmarks did show that to have about half the latency of a regular
> syscall; the hope was if gcc was doing clever optimization that overhead
> would effectivly become zero.
> 
> I was favoring this low-overhead syscall approach because it would avoid
> the loss of a register thus leaving performance of non-threaded code
> unchanged but other developers generally favor the permanent allocation
> of $t9 as a thread register.

Personally, I favor doing the low-overhead syscall for o32 and then
moving to the new ABI that MIPS is talking about with a thread
register.  I'm not sure what to do about n32/n64.

> Other crazy ideas did include a per-thread mapping containing the thread
> pointer - and possibly more information in the future.

Does MIPS have an efficient way to do this for SMP?

> On the positive side if we had multiple register sets on a MIPSxx V2
> processor we could exploit that to get rid of this overheade and do
> other nice optimizations for TLB reload also.  Unfortunately these
> register sets are optional feature of the architecture only.

That's more or less what was talked about for ARM v6.

-- 
Daniel Jacobowitz
