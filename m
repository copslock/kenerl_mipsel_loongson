Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7JCs4Rw006355
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 19 Aug 2002 05:54:04 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7JCs4Zx006354
	for linux-mips-outgoing; Mon, 19 Aug 2002 05:54:04 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7JCrsRw006339;
	Mon, 19 Aug 2002 05:53:55 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA15909;
	Mon, 19 Aug 2002 14:57:15 +0200 (MET DST)
Date: Mon, 19 Aug 2002 14:57:14 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: a really really weird crash on swarm
In-Reply-To: <20020811185138.A2133@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020819144136.14441E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, 11 Aug 2002, Ralf Baechle wrote:

> > Call me crazy - I have seen crash like this.  As you can see, the register is 
> > loaded with one value and on next instruction it shows another value.  What 
> > the hell is it possibly going on?
> > 
> > This is with today's OSS tree 2.4 branch.
> 
> Really odd because the register only lost the upper 16 bits; the lower 16
> bits still have their expected value.

 It is a typical symptom of a register being corrupted between a "lui" and
an "addiu"  -- an exception must have done it in the immediately preceding
code.  You might be able to track a reason down by carefully studying
possible exception paths at the place of the problem.  Unfortunately you
don't have much of the state preserved at this stage -- you only know
which register was corrupted. 

 Another possible approach is to add some code that compares the values of
the register upon an exception entry and exit and wait for it to trigger
-- for a single register it shouldn't be too tough and you have still much
of the state available before an "rfe" or "eret".

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
