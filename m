Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Dec 2002 18:01:24 +0000 (GMT)
Received: from crack.them.org ([65.125.64.184]:3240 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S8225241AbSLKSBY>;
	Wed, 11 Dec 2002 18:01:24 +0000
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 18MD2Z-0007Ff-00; Wed, 11 Dec 2002 14:01:07 -0600
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 18MBAt-0003vI-00; Wed, 11 Dec 2002 13:01:35 -0500
Date: Wed, 11 Dec 2002 13:01:35 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: watch exception only for kseg0 addresses..?
Message-ID: <20021211180135.GB14768@nevyn.them.org>
References: <20021211165854.GA12223@nevyn.them.org> <Pine.GSO.3.96.1021211182901.22157N-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1021211182901.22157N-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 11, 2002 at 06:38:51PM +0100, Maciej W. Rozycki wrote:
> On Wed, 11 Dec 2002, Daniel Jacobowitz wrote:
> 
> > That way we expose more of the hardware to userland; and the thing
> > that's most important to me is that GDB not have to know if it's on a
> > MIPS32 or an R4650 when determining how watchpoints work. 
> > IWatch/DWatch are two particular watchpoints or distinguished by access
> > type?  I.E. what would GDB need to know to know which it is setting?
> 
>  The watchpoints would always be interfaced the same way, regardless of
> the underlying implementation, of course.  For the IWatch/DWatch, I'd
> assign their numbers somehow (e.g. IWatch is watchpoint #0 and DWatch is
> #1, following the sequence used for their CP0 register numbers).  A user
> such as GDB would have to determine the capabilities of all watchpoints as
> I described and would discover that watchpoint #0 only accepts instruction
> fetch events and watchpoint #1 only accepts data read/write ones.
> 
>  This way we can accept an arbitrary underlying implementation.

This is what I don't like.  Setting each individual watchpoint to
determine their capabilities, when the kernel could just _report_ said
capabilities.  It's a difference in philosophy I suppose.  I also have
some concerns about making the probing indistinguishable from setting a
watchpoint; if MIPS37 or MPIS256 has a substantially different
watchpoint layout, we'll have to give it a whole new set of ptrace ops,
which defeats the point of abstracting it.

If we write up decent documentation for what a userspace implementation
has to do to probe the current implementations, I guess I'm satisfied.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
