Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Nov 2002 15:41:09 +0100 (CET)
Received: from crack.them.org ([65.125.64.184]:52936 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1122118AbSKYOlJ>;
	Mon, 25 Nov 2002 15:41:09 +0100
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 18GMIJ-0002GE-00; Mon, 25 Nov 2002 10:41:11 -0600
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 18GKPz-00067s-00; Mon, 25 Nov 2002 09:40:59 -0500
Date: Mon, 25 Nov 2002 09:40:59 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	atul srivastava <atulsrivastava9@rediffmail.com>,
	linux-mips@linux-mips.org
Subject: Re: watch exception only for kseg0 addresses..?
Message-ID: <20021125144059.GA23310@nevyn.them.org>
References: <20021125102458.B22046@linux-mips.org> <Pine.GSO.3.96.1021125123643.8769B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1021125123643.8769B-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 25, 2002 at 12:55:11PM +0100, Maciej W. Rozycki wrote:
> On Mon, 25 Nov 2002, Ralf Baechle wrote:
> 
> > The whole watch stuff in the the kernel is pretty much an ad-hoc API
> > which I did create to debug a stack overflow.  I'm sure if you're
> > going to use it you'll find problems.  For userspace for example you'd
> > have to switch the watch register when switching the MMU context so
> > each process gets it's own virtual watch register.  Beyond that there
> > are at least two different formats of watch registers implemented in
> > actual silicon, the original R4000-style and the MIPS32/MIPS64 style
> > watch registers and the kernel's watch code only know the R4000 style
> > one.  So check your CPU's manual ...
> 
>  I think the best use of the watch exception would be making it available
> to userland via PTRACE_PEEKUSR and PTRACE_POKEUSR for hardware watchpoint
> support (e.g. for gdb).  Hardware support is absolutely necessary for
> watching read accesses and much beneficial for write ones (otherwise gdb
> single-steps code which sucks performace-wise).

(Although that isn't necessary; page-protection watchpoints are on my
TODO for next year.  They aren't quite as efficient as hardware
watchpoints but they don't require hardware support either, just an
MMU.)

Heck, you can even do read watchpoints that way.

In any case, yes, the thing to do is choose an API for these and expose
them via ptrace; not necessarily in PEEKUSER though.  There's no cost
to adding new PTRACE_* ops.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
