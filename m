Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4PKdea11625
	for linux-mips-outgoing; Fri, 25 May 2001 13:39:40 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4PKdZF11617
	for <linux-mips@oss.sgi.com>; Fri, 25 May 2001 13:39:37 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f4PKRk406697;
	Fri, 25 May 2001 17:27:46 -0300
Date: Fri, 25 May 2001 17:27:46 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Daniel Jacobowitz <dan@debian.org>, linux-mips@oss.sgi.com
Subject: Re: [PATCH] incorrect asm constraints for ll/sc constructs
Message-ID: <20010525172746.B6578@bacchus.dhis.org>
References: <20010523145257.A13013@nevyn.them.org> <Pine.GSO.3.96.1010524134521.6990F-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010524134521.6990F-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, May 24, 2001 at 03:42:56PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, May 24, 2001 at 03:42:56PM +0200, Maciej W. Rozycki wrote:

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

I admit the construction is somewhat fragile and will take any patches to
cleanup this.

  Ralf
