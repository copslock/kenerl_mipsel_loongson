Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g15Ccu303064
	for linux-mips-outgoing; Tue, 5 Feb 2002 04:38:56 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g15CclA03044;
	Tue, 5 Feb 2002 04:38:47 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id EAA04442;
	Tue, 5 Feb 2002 04:38:40 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id EAA07880;
	Tue, 5 Feb 2002 04:38:37 -0800 (PST)
Received: from copsun18.mips.com (copsun18 [192.168.205.28])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g15CcAA08992;
	Tue, 5 Feb 2002 13:38:10 +0100 (MET)
From: Hartvig Ekner <hartvige@mips.com>
Received: (from hartvige@localhost)
	by copsun18.mips.com (8.9.1/8.9.0) id NAA03846;
	Tue, 5 Feb 2002 13:38:34 +0100 (MET)
Message-Id: <200202051238.NAA03846@copsun18.mips.com>
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
To: macro@ds2.pg.gda.pl (Maciej W. Rozycki)
Date: Tue, 5 Feb 2002 13:38:34 +0100 (MET)
Cc: ralf@oss.sgi.com (Ralf Baechle), hartvige@mips.com (Hartvig Ekner),
   justinca@ri.cmu.edu (Justin Carlson), dan@debian.org (Daniel Jacobowitz),
   hjl@lucon.org (H . J . Lu), dom@algor.co.uk (Dominic Sweetman),
   libc-alpha@sources.redhat.com (GNU C Library), linux-mips@oss.sgi.com
In-Reply-To: <Pine.GSO.3.96.1020205131750.9674E-100000@delta.ds2.pg.gda.pl> from "Maciej W. Rozycki" at Feb 05, 2002 01:31:05 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Some of MIPS's cores do externalize the event of a "LL" and make it
visible on the bus interface. Similarly, the SC is externalized and
requires a go/nogo response from the system logic. Think of it as
putting a shared LLAddr & LLBit outside the processor. The SC will
only succeed if the internal LLBit is ok *and* the external logic gives
the go-ahead as well.

The reasoning behind all this is that one can then utilize LL/SC in
multi CPU systems without full coherency support being required.

But then again, this might not be relevant for MIPS/Linux as it will not
run without full HW coherency on multiple CPUs?

/Hartvig

Maciej W. Rozycki writes:
> 
> On Tue, 5 Feb 2002, Ralf Baechle wrote:
> 
> > Some of the processor manuals explicitly note that the execution of a
> > ll instruction may not be visible at all externally.  That's the case if
> > the address is already in a primary cache line in exclusive (ll) or
> > dirty (sc) state.  That makes even if a processor supports full coherency
> > since there is no reason to indicate the update to any other external
> > agent.  Or am I missing something?
> 
>  By definition, apart from an ordinary load, an "ll" does only the
> following two additional actions:
> 
> 1. Loads the LLAddr register (it's visible in CP0, at least in certain
> implementations) to set up the ll comparator. 
> 
> 2. Sets the LLbit flip-flop to set the ll state to valid initially.
> 
> None of the actions should normally involve externally visible activity. 
> 
> -- 
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
> 
> 


-- 
 _    _   _____  ____     Hartvig Ekner        Mailto:hartvige@mips.com
 |\  /| | |____)(____                          Direct: +45 4486 5503
 | \/ | | |     _____)    MIPS Denmark         Switch: +45 4486 5555
T E C H N O L O G I E S   http://www.mips.com  Fax...: +45 4486 5556
