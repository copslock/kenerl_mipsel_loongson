Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6UBTPRw005593
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 30 Jul 2002 04:29:25 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6UBTO4c005592
	for linux-mips-outgoing; Tue, 30 Jul 2002 04:29:24 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft19-f237.dialo.tiscali.de [62.246.19.237])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6UBTGRw005582
	for <linux-mips@oss.sgi.com>; Tue, 30 Jul 2002 04:29:18 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6UBTtp28422;
	Tue, 30 Jul 2002 13:29:55 +0200
Date: Tue, 30 Jul 2002 13:29:55 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] MIPS64 R4k TLB refill CP0 hazards
Message-ID: <20020730132955.A28302@dea.linux-mips.net>
References: <Pine.GSO.3.96.1020729163359.22288I-100000@delta.ds2.pg.gda.pl> <3D45A13E.79C882B5@mips.com> <3D46393D.37D36612@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D46393D.37D36612@mips.com>; from carstenl@mips.com on Tue, Jul 30, 2002 at 08:59:17AM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 30, 2002 at 08:59:17AM +0200, Carsten Langgaard wrote:

> We have been discussing this before, but I really don't like the idea of
> solving the hazard problem with a branch. The branch will on some CPUs
> (especially if they have a long pipeline) be a much bigger penalty than
> we actually wants to solve the hazard. On other CPU (with branch
> prediction) we may not even solve the hazard problem.

The branch - which is used by other OSes btw. - for the R4000 / R4400 where
this kind of taken branch implies a total delay of three cycles.  One for
the branch delay slot plus two extra cycles for the killed instructions
following the branch delay slot.  For R4600, R4700, R5000 and a bunch of
derivates I've verified that according to the documentation this extra
penalty of two cycles does not exist nor we need two extra cycles to handle
the hazard.  In other words the branch trick - which also is used by
some other commercial OS btw. - is providing best possible performance on
a wide range of processors.

> The 'nop' I used is not the solution either, instead we should use
> 'ssnop' instructions, which will make sure we also solve the hazard
> problem on superscalar CPUs.  We also need to have a hazard barrier in
> the code labeled "not_vmalloc".

Above trick was written with single issue CPUs in mind.  I'd have to
verify the pipeline timing again against CPU manuals but off my memory
at least SB1 and R1x000 are fully protected against the hazards in
question.

  Ralf
