Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g71GmERw007260
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 1 Aug 2002 09:48:14 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g71GmEQr007259
	for linux-mips-outgoing; Thu, 1 Aug 2002 09:48:14 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft16-f78.dialo.tiscali.de [62.246.16.78])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g71Gm2Rw007232
	for <linux-mips@oss.sgi.com>; Thu, 1 Aug 2002 09:48:04 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g71GnTM23294;
	Thu, 1 Aug 2002 18:49:29 +0200
Date: Thu, 1 Aug 2002 18:49:29 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [update] [patch] linux: Cache coherency fixes
Message-ID: <20020801184929.B22824@dea.linux-mips.net>
References: <20020801152500.A31808@dea.linux-mips.net> <Pine.GSO.3.96.1020801173504.8256H-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020801173504.8256H-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Aug 01, 2002 at 06:05:17PM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Aug 01, 2002 at 06:05:17PM +0200, Maciej W. Rozycki wrote:

>  Huh?  Coherent caching mode can be used for a few processors only, namely
> R4[04]00MC and presumably SB1 (inferred from the sources), i.e. the ones
> that support the interprocessor coherency protocol.  If you know of any
> other processor that supports the protocol, I'd be pleased to see a
> reference to a spec -- I hoped someone, possibly you, would fill the
> missing bits when I proposed the patch a month ago.  Nobody bothered,
> though, sigh...

R10000.

>  I see your changes are broken conceptually, as the caching mode for the
> TLB should be inferred from the CPU configuration in the first place and
> not the system selection (actually it should be best selected ath the run
> time).  Hence I'd invert the flag, since most systems are non-coherent,
> and only permit it for certain processors.

Back in time I prefered CONFIG_NONCOHERENT_IO over CONFIG_COHERENT_IO
because the noncoherent case needs additional code and in general I'm
trying to reduce the number of the #if !defined conditionals for easier
readability.

The R10000 is our standard example why looking at the processor type doesn't
work.  It's used in coherent mode in IP27 but in coherent mode but in
coherent mode in IP28 or IP32.  Otoh I don't know of any system that
supports coherency but also is being used with non-coherent processors.

>  Using a non-coherent
> configuration for an UP system that supports coherency (do SGI IP27 and
> SiByte SB1250 have another agent in the chipset that may issue coherent
> requests regardless of the number of processors started?)

Yes.  That's how coherency is working - all agents have to support coherent
requests or coherency simply won't work.  So basically we'd be trully
picky we'd have to verify that all agents, processor and other support
coherency but just using the system type seems to be sufficient.

> results in a
> performance hit only due to superfluous invalidations, but using a
> coherent configuration for a processor/system that doesn't support it may
> lead to a hard to debug hang with no apparent reason (as I wrote
> previously, even NMI/Reset stopped working on my system -- I had to hit
> the power switch). 

Using a non-coherent mode on IP27 may result in nice, hard to trackdown bus
errors.

  Ralf
