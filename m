Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6V24MRw002498
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 30 Jul 2002 19:04:23 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6V24MTu002497
	for linux-mips-outgoing; Tue, 30 Jul 2002 19:04:22 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft16-f207.dialo.tiscali.de [62.246.16.207])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6V24DRw002340
	for <linux-mips@oss.sgi.com>; Tue, 30 Jul 2002 19:04:15 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6V25T406353;
	Wed, 31 Jul 2002 04:05:29 +0200
Date: Wed, 31 Jul 2002 04:05:29 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Carsten Langgaard <carstenl@mips.com>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] MIPS64 R4k TLB refill CP0 hazards
Message-ID: <20020731040529.A5451@dea.linux-mips.net>
References: <Pine.GSO.3.96.1020729163359.22288I-100000@delta.ds2.pg.gda.pl> <3D45A13E.79C882B5@mips.com> <3D46393D.37D36612@mips.com> <20020730132955.A28302@dea.linux-mips.net> <00f801c237c6$29cabd00$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <00f801c237c6$29cabd00$10eca8c0@grendel>; from kevink@mips.com on Tue, Jul 30, 2002 at 02:39:24PM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 30, 2002 at 02:39:24PM +0200, Kevin D. Kissell wrote:

> > following the branch delay slot.  For R4600, R4700, R5000 and a bunch of
> > derivates I've verified that according to the documentation this extra
> > penalty of two cycles does not exist nor we need two extra cycles to handle
> > the hazard.  In other words the branch trick - which also is used by
> > some other commercial OS btw. - is providing best possible performance on
> > a wide range of processors.
> 
> Which would be a fairly compelling argument if (a) we were constrained
> for some reason to only have one handler and (b) the majority of MIPS
> Linux systems being built had R4000/4400/4600/4700/5000 CPUs in
> them.  But neither of those assumptions is true.  I don't see any cases
> in the kernel of assembler functions being put into the .init segment of
> the kernel image, but I would think that it could be (and anyway should
> be) done with the various exception vectors, and in any case they are
> dynamically installed based on the detected CPU.  If people using
> old workstations want to use a branch-based timing hack in their
> TLB handlers, that's all well and good.  But there is no guarantee that
> the trick will work on all future (or even current) MIPS CPUs, and
> I agree with Carsten that it is inappropriate for the generic or default
> MIPS32 handlers.  I guess we need to propose a patch to allow
> the Indy/Decstation crowd to retain their branch-based scheme,
> but to quarantine it from the rest of the MIPS/Linux universe.

Basically we have two groups of interrupt handlers.  Some contain
workarounds for hardware bugs; the rest are very similar except having
to handle different hazards.  I was already thinking about building the
actuall exception handlers from a piece of code that inserts the right
number of (ss)nops etc. as required into the right place, thereby
producing an optimal handler for every CPU.

  Ralf
