Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6UCgkRw007509
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 30 Jul 2002 05:42:46 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6UCgjlO007508
	for linux-mips-outgoing; Tue, 30 Jul 2002 05:42:45 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6UCgaRw007496;
	Tue, 30 Jul 2002 05:42:37 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA17643;
	Tue, 30 Jul 2002 14:44:32 +0200 (MET DST)
Date: Tue, 30 Jul 2002 14:44:32 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Carsten Langgaard <carstenl@mips.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] MIPS64 R4k TLB refill CP0 hazards
In-Reply-To: <3D4681DE.7BE793C9@mips.com>
Message-ID: <Pine.GSO.3.96.1020730141305.16647B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 30 Jul 2002, Carsten Langgaard wrote:

> > The branch - which is used by other OSes btw. - for the R4000 / R4400 where
> > this kind of taken branch implies a total delay of three cycles.  One for
> > the branch delay slot plus two extra cycles for the killed instructions
> > following the branch delay slot.  For R4600, R4700, R5000 and a bunch of
> > derivates I've verified that according to the documentation this extra
> > penalty of two cycles does not exist nor we need two extra cycles to handle
> > the hazard.  In other words the branch trick - which also is used by
> > some other commercial OS btw. - is providing best possible performance on
> > a wide range of processors.
> 
> If we are going to make the exception generic and usable for as many CPUs as
> possible, I don't thing the branch trick is save.
> Why not make a hazard barrier that contains 0, 1 or 2 'ssnop's depending on
> the CPU configuration ?
> This way we will have the exact number of 'ssnop' to solve the hazard, without
> adding extra penalty for other CPUs.

 Since the handler is critical for performance, it would be desireable to
have separate versions tuned for particular CPUs.  The branch for the
R4400 seems appropriate as it works unlike the documented code: the
R4000/R4400 manual as available from the MIPS site states a single
intervening instruction is needed before the last move to EntryLo and a
"tlbwr" or "tlbwi" (see Table F-1 and F-2).  So I conclude the branch is
really a workaround for a kind of erratum or a specification change. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
