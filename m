Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g15CVh702203
	for linux-mips-outgoing; Tue, 5 Feb 2002 04:31:43 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g15CVYA02179;
	Tue, 5 Feb 2002 04:31:35 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA13528;
	Tue, 5 Feb 2002 13:31:06 +0100 (MET)
Date: Tue, 5 Feb 2002 13:31:05 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Hartvig Ekner <hartvige@mips.com>, Justin Carlson <justinca@ri.cmu.edu>,
   Daniel Jacobowitz <dan@debian.org>, "H . J . Lu" <hjl@lucon.org>,
   Dominic Sweetman <dom@algor.co.uk>,
   GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
In-Reply-To: <20020205131257.A4482@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020205131750.9674E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 5 Feb 2002, Ralf Baechle wrote:

> Some of the processor manuals explicitly note that the execution of a
> ll instruction may not be visible at all externally.  That's the case if
> the address is already in a primary cache line in exclusive (ll) or
> dirty (sc) state.  That makes even if a processor supports full coherency
> since there is no reason to indicate the update to any other external
> agent.  Or am I missing something?

 By definition, apart from an ordinary load, an "ll" does only the
following two additional actions:

1. Loads the LLAddr register (it's visible in CP0, at least in certain
implementations) to set up the ll comparator. 

2. Sets the LLbit flip-flop to set the ll state to valid initially.

None of the actions should normally involve externally visible activity. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
