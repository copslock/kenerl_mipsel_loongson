Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5QC5cnC001478
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 26 Jun 2002 05:05:38 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5QC5cxA001477
	for linux-mips-outgoing; Wed, 26 Jun 2002 05:05:38 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-180.ka.dial.de.ignite.net [62.180.196.180])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5QC5TnC001468
	for <linux-mips@oss.sgi.com>; Wed, 26 Jun 2002 05:05:31 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5QC5qA20368;
	Wed, 26 Jun 2002 14:05:52 +0200
Date: Wed, 26 Jun 2002 14:05:52 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ladislav Michl <ladis@psi.cz>, linux-mips@oss.sgi.com
Subject: Re: [patch] linux: DBE/IBE handling rewrite
Message-ID: <20020626140552.F19858@dea.linux-mips.net>
References: <Pine.GSO.3.96.1020625131229.29623A-100000@delta.ds2.pg.gda.pl> <Pine.GSO.3.96.1020626121553.23599A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020626121553.23599A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Jun 26, 2002 at 01:51:08PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jun 26, 2002 at 01:51:08PM +0200, Maciej W. Rozycki wrote:

> >  This way, the fixup search is invoked first and a system-specific handler
> > can judge whether to let the fixup be invoked or a serious failure
> > happened and the system should act appropriately.  The handler can do
> > whatever actions are needed (e.g. clear error status data in system
> > registers, report ECC syndromes, etc.) for the system for both cases.
> 
>  OK, here is the code.  I wrote it a bit differently from what I
> considered yesterday, as fixup doesn't seem useful for a system-specific
> handler.  With the following code only a boolean flag is passed informing
> whether a fixup is available and the handler can decide how to treat an
> error, based on the state passed as arguments and possibly additional one
> obtained from system-specific resources.  Both MIPS and MIPS64 are handled
> in the same way.  For MIPS64 it means a removal of duplicated similar code
> as well.  I adjusted some SGI-specific code appropriately, but platform
> maintainers will have to check if bus_error_init() stubs are OK for them.
> 
>  Ralf, OK to apply?

Certainly looks saner than what we're having right now.  Please apply.

  Ralf
