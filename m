Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KDqHEC027204
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 06:52:17 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KDqHn2027203
	for linux-mips-outgoing; Tue, 20 Aug 2002 06:52:17 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KDq8EC027192;
	Tue, 20 Aug 2002 06:52:09 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA12523;
	Tue, 20 Aug 2002 15:55:35 +0200 (MET DST)
Date: Tue, 20 Aug 2002 15:55:34 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: Ralf Baechle <ralf@oss.sgi.com>, SGI MIPS list <linux-mips@oss.sgi.com>
Subject: Re: [PATCH] Bring back R4600 V1.7 support
In-Reply-To: <Pine.GSO.3.96.1020820152046.8700E-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.3.96.1020820153410.8700F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 20 Aug 2002, Maciej W. Rozycki wrote:

> > Please accept the patch (from my previous mail). I'm using it now for
> > two days, and I've got one mail telling me that it works for its sender.
> 
>  Ugh, this should be a separate set of functions selected at the run time. 
> It should be fairly trivial to rewrite it this way (best done with
> processor-specific functions expanded from common templates for ease of
> maintenance), but the size of the resulting interrupt masking window is
> unacceptable.  A more finegrained implementation is really desireable,
> with an interrupt enable window every page or so, but your proposal should
> be fair enough for the sake of usability once rewritten as I suggested.

 An additional thought that just came to my mind: it might be possible to
avoid masking interrupts with a dummy ll/sc pair only checking if an
interrupt happened within the critical code.  It should be easy to
validate since only a single mask of a processor would make use of the
code.  The real question is: "Do the affected cache operations corrupt any
state or do they only work on wrong lines?"  If the latter, the approach
should work for all operations except from "Hit_Invalidate_D" that
corrupts state by definition (but it isn't used by any R4k processor, so
it may simply be replaced with a panic()).  Unfortunately, the knowledge
does no longer exist within IDT, but maybe someone else knows? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
