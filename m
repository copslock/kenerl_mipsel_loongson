Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g15DUP318730
	for linux-mips-outgoing; Tue, 5 Feb 2002 05:30:25 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g15DU9A18515;
	Tue, 5 Feb 2002 05:30:10 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA14932;
	Tue, 5 Feb 2002 14:29:00 +0100 (MET)
Date: Tue, 5 Feb 2002 14:28:59 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Hartvig Ekner <hartvige@mips.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, Justin Carlson <justinca@ri.cmu.edu>,
   Daniel Jacobowitz <dan@debian.org>, "H . J . Lu" <hjl@lucon.org>,
   Dominic Sweetman <dom@algor.co.uk>,
   GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
In-Reply-To: <200202051238.NAA03846@copsun18.mips.com>
Message-ID: <Pine.GSO.3.96.1020205134113.9674G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 5 Feb 2002, Hartvig Ekner wrote:

> Some of MIPS's cores do externalize the event of a "LL" and make it
> visible on the bus interface. Similarly, the SC is externalized and
> requires a go/nogo response from the system logic. Think of it as
> putting a shared LLAddr & LLBit outside the processor. The SC will
> only succeed if the internal LLBit is ok *and* the external logic gives
> the go-ahead as well.

 OK, but an external register shouldn't need any additional CPU time to
get its contents latched. 

> The reasoning behind all this is that one can then utilize LL/SC in
> multi CPU systems without full coherency support being required.

 Nor should an external comparator.

> But then again, this might not be relevant for MIPS/Linux as it will not
> run without full HW coherency on multiple CPUs?

 How do you maintain coherency on such a system?  To support such a model
all shared area write accesses should be followed by explicit
synchronization requests.  It should be trivial but tedious to do for
Linux, but it might not be that easy for threads.

 One bit I've forgotten about "ll" -- it also implies a "sync".

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
