Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g15JUos30968
	for linux-mips-outgoing; Tue, 5 Feb 2002 11:30:50 -0800
Received: from dea.linux-mips.net (a1as03-p87.stg.tli.de [195.252.186.87])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g15JUkA30961
	for <linux-mips@oss.sgi.com>; Tue, 5 Feb 2002 11:30:46 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g15IxDK07734;
	Tue, 5 Feb 2002 19:59:13 +0100
Date: Tue, 5 Feb 2002 19:59:12 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Hartvig Ekner <hartvige@mips.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Justin Carlson <justinca@ri.cmu.edu>, Daniel Jacobowitz <dan@debian.org>,
   "H . J . Lu" <hjl@lucon.org>, Dominic Sweetman <dom@algor.co.uk>,
   GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
Message-ID: <20020205195912.A7023@dea.linux-mips.net>
References: <Pine.GSO.3.96.1020205131750.9674E-100000@delta.ds2.pg.gda.pl> <200202051238.NAA03846@copsun18.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200202051238.NAA03846@copsun18.mips.com>; from hartvige@mips.com on Tue, Feb 05, 2002 at 01:38:34PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Feb 05, 2002 at 01:38:34PM +0100, Hartvig Ekner wrote:

> Some of MIPS's cores do externalize the event of a "LL" and make it
> visible on the bus interface. Similarly, the SC is externalized and
> requires a go/nogo response from the system logic. Think of it as
> putting a shared LLAddr & LLBit outside the processor. The SC will
> only succeed if the internal LLBit is ok *and* the external logic gives
> the go-ahead as well.
> 
> The reasoning behind all this is that one can then utilize LL/SC in
> multi CPU systems without full coherency support being required.
> 
> But then again, this might not be relevant for MIPS/Linux as it will not
> run without full HW coherency on multiple CPUs?

Linux could easily be hacked into handle such a configuration as a cluster.
Anything else would be a pretty large job.

  Ralf
