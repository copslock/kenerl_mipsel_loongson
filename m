Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4ONjQG11182
	for linux-mips-outgoing; Thu, 24 May 2001 16:45:26 -0700
Received: from nevyn.them.org (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4ONjQF11179
	for <linux-mips@oss.sgi.com>; Thu, 24 May 2001 16:45:26 -0700
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 1534mp-0005ie-00; Thu, 24 May 2001 16:44:59 -0700
Date: Thu, 24 May 2001 16:44:59 -0700
From: Daniel Jacobowitz <dan@debian.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@oss.sgi.com
Subject: Re: [PATCH] incorrect asm constraints for ll/sc constructs
Message-ID: <20010524164459.A19466@nevyn.them.org>
References: <20010523145257.A13013@nevyn.them.org> <Pine.GSO.3.96.1010524134521.6990F-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.GSO.3.96.1010524134521.6990F-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, May 24, 2001 at 03:42:56PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, May 24, 2001 at 03:42:56PM +0200, Maciej W. Rozycki wrote:
> On Wed, 23 May 2001, Daniel Jacobowitz wrote:
> 
> > The ll/sc constructs in the kernel use ".set noat" to inhibit use of $at,
> > and proceed to use it themselves.  This is fine, except for one problem: the
> > constraints on memory operands are "o" and "=o", which means offsettable
> > memory references.  If I'm not mistaken, the assembler will (always?)
> > turn these into uses of $at if the offset is not 0 - at least, it certainly
> > seems to do that here (gcc 2.95.3, binutils 2.10.91.0.2).  Just being honest
> > with the compiler and asking for a real memory reference does the trick. 
> 
>  Both "m" and "o" seem to be incorrect here as both are the same for MIPS; 
> "R" seems to be appropriate, OTOH.  Still gcc 2.95.3 doesn't handle "R" 
> fine for all cases, but it works most of the time and emits a warning
> otherwise.  I can't comment on 3.0.

They aren't the same for MIPS, though.  I exhibit as evidence the fact
that my patch fixed the problem I was seeing.  I didn't know about 'R';
I suppose that it is more correct.  'm' at least is closer than 'o',
though.

If 'R' will behave correctly, could that be applied to CVS, then?

>  Note that if noat is in effect and at is to be used, gas should bail out
> with an error.  There is a bug, if it doesn't.

It issues a warning, currently (2.10.91.0.2 - I think 2.11 behaves the
same).

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
Monta Vista Software                              Debian Security Team
