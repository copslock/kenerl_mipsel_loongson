Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6NDUHRw026445
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 23 Jul 2002 06:30:18 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6NDUHNY026444
	for linux-mips-outgoing; Tue, 23 Jul 2002 06:30:17 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6NDU4Rw026433;
	Tue, 23 Jul 2002 06:30:05 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA28869;
	Tue, 23 Jul 2002 15:31:30 +0200 (MET DST)
Date: Tue, 23 Jul 2002 15:31:30 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux: cpu_probe(): remove 32-bit CPU bits for MIPS64
In-Reply-To: <20020723152300.A14474@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020723152521.26569C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 23 Jul 2002, Ralf Baechle wrote:

> You've been a little bit too fast :) I've almost implemented my suggestion
> of moving the probing code into cpu-probe.c.

 What's the problem?  Now the branch and the trunk are in sync (I just did
a `cp' from the trunk as the missing function was the only difference), so
you may apply the same changes to both. :-)  Otherwise you'd have to deal
with the difference.

> >  That might be a good idea in principle, but it won't solve the problem
> > anyway.  I'd like to see the code for 32-bit processors get annihilated by
> > the compiler if built for mips64.  I'll look at it soon.  The MIPS32/64
> > crap needs to be fixed here as well.
> 
> If you find a nice way of implementing this I certainly won't object.

 The MIPS32/64 fix is obvious; the 32-bit CPU is not so, but I have a sort
of an idea.  I'd like to get rid of all ifdefs in the area.  Not a high
priority, though, sorry.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
