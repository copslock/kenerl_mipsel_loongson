Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4U0I8915983
	for linux-mips-outgoing; Tue, 29 May 2001 17:18:08 -0700
Received: from nevyn.them.org (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4U0Hkh15975;
	Tue, 29 May 2001 17:17:52 -0700
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 154tgK-0001yQ-00; Tue, 29 May 2001 17:17:48 -0700
Date: Tue, 29 May 2001 17:17:48 -0700
From: Daniel Jacobowitz <dan@debian.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: [PATCH] incorrect asm constraints for ll/sc constructs
Message-ID: <20010529171748.A7362@nevyn.them.org>
References: <20010523145257.A13013@nevyn.them.org> <Pine.GSO.3.96.1010524134521.6990F-100000@delta.ds2.pg.gda.pl> <20010525172746.B6578@bacchus.dhis.org> <20010525134909.A26065@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20010525134909.A26065@nevyn.them.org>; from dan@debian.org on Fri, May 25, 2001 at 01:49:09PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, May 25, 2001 at 01:49:09PM -0700, Daniel Jacobowitz wrote:
> On Fri, May 25, 2001 at 05:27:46PM -0300, Ralf Baechle wrote:
> > On Thu, May 24, 2001 at 03:42:56PM +0200, Maciej W. Rozycki wrote:
> > 
> > > > The ll/sc constructs in the kernel use ".set noat" to inhibit use of $at,
> > > > and proceed to use it themselves.  This is fine, except for one problem: the
> > > > constraints on memory operands are "o" and "=o", which means offsettable
> > > > memory references.  If I'm not mistaken, the assembler will (always?)
> > > > turn these into uses of $at if the offset is not 0 - at least, it certainly
> > > > seems to do that here (gcc 2.95.3, binutils 2.10.91.0.2).  Just being honest
> > > > with the compiler and asking for a real memory reference does the trick. 
> > > 
> > >  Both "m" and "o" seem to be incorrect here as both are the same for MIPS; 
> > > "R" seems to be appropriate, OTOH.  Still gcc 2.95.3 doesn't handle "R" 
> > > fine for all cases, but it works most of the time and emits a warning
> > > otherwise.  I can't comment on 3.0.

Back to quibbling - that's just not true.  For one thing, from the info
documentation:
    `R'   
          Memory reference that can be loaded with one instruction (`m'
          is preferable for `asm' statements)

For another, using the patch I posted below, I get inconsistent
constraint errors.  I'm not entirely sure why.  Is there any reason not
to use the "m" version?  I can't see any case in which it would not
behave correctly.

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
Monta Vista Software                              Debian Security Team
