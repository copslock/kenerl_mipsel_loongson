Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g71HCCRw007767
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 1 Aug 2002 10:12:12 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g71HCC1Q007766
	for linux-mips-outgoing; Thu, 1 Aug 2002 10:12:12 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g71HBwRw007756;
	Thu, 1 Aug 2002 10:11:59 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA10809;
	Thu, 1 Aug 2002 19:14:05 +0200 (MET DST)
Date: Thu, 1 Aug 2002 19:14:05 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [update] [patch] linux: Cache coherency fixes
In-Reply-To: <20020801184929.B22824@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020801185642.8256P-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 1 Aug 2002, Ralf Baechle wrote:

> R10000.

 OK.  Any specs anywhere?

> Back in time I prefered CONFIG_NONCOHERENT_IO over CONFIG_COHERENT_IO
> because the noncoherent case needs additional code and in general I'm
> trying to reduce the number of the #if !defined conditionals for easier
> readability.

 Hmm, what's wrong with "#ifndef"?  Not much less readable than "#ifdef",
IMO. 

> The R10000 is our standard example why looking at the processor type doesn't
> work.  It's used in coherent mode in IP27 but in coherent mode but in
> coherent mode in IP28 or IP32.  Otoh I don't know of any system that
> supports coherency but also is being used with non-coherent processors.

 Yep, I suppose so, but the first criterion should be the CPU anyway.
Basically:

1. Does the CPU support coherency?

2. If so, does the system?

I'm going to express it this way in the config script.

> >  Using a non-coherent
> > configuration for an UP system that supports coherency (do SGI IP27 and
> > SiByte SB1250 have another agent in the chipset that may issue coherent
> > requests regardless of the number of processors started?)
> 
> Yes.  That's how coherency is working - all agents have to support coherent
> requests or coherency simply won't work.  So basically we'd be trully
> picky we'd have to verify that all agents, processor and other support
> coherency but just using the system type seems to be sufficient.

 Well, inferring from docs and my experience it's not needed.  A system
may simply require areas used for DMA to be marked as non-coherent by
CPUs.  Often uncached accesses are used to prevent spoiling the caches
anyway.

> > results in a
> > performance hit only due to superfluous invalidations, but using a
> > coherent configuration for a processor/system that doesn't support it may
> > lead to a hard to debug hang with no apparent reason (as I wrote
> > previously, even NMI/Reset stopped working on my system -- I had to hit
> > the power switch). 
> 
> Using a non-coherent mode on IP27 may result in nice, hard to trackdown bus
> errors.

 Weird, but I accept it as a fact.  Still a bus error expresses more than
a hang. ;-) 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
