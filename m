Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g728NFRw027790
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 2 Aug 2002 01:23:15 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g728NF8S027789
	for linux-mips-outgoing; Fri, 2 Aug 2002 01:23:15 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g728N3Rw027779;
	Fri, 2 Aug 2002 01:23:03 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g728NsXb029243;
	Fri, 2 Aug 2002 01:23:54 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id BAA07040;
	Fri, 2 Aug 2002 01:23:53 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g728Nrb07296;
	Fri, 2 Aug 2002 10:23:53 +0200 (MEST)
Message-ID: <3D4A4191.DF5EFFC4@mips.com>
Date: Fri, 02 Aug 2002 10:23:53 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [update] [patch] linux: Cache coherency fixes
References: <20020801152500.A31808@dea.linux-mips.net> <Pine.GSO.3.96.1020801173504.8256H-100000@delta.ds2.pg.gda.pl> <20020801184929.B22824@dea.linux-mips.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> On Thu, Aug 01, 2002 at 06:05:17PM +0200, Maciej W. Rozycki wrote:
>
> >  Huh?  Coherent caching mode can be used for a few processors only, namely
> > R4[04]00MC and presumably SB1 (inferred from the sources), i.e. the ones
> > that support the interprocessor coherency protocol.  If you know of any
> > other processor that supports the protocol, I'd be pleased to see a
> > reference to a spec -- I hoped someone, possibly you, would fill the
> > missing bits when I proposed the patch a month ago.  Nobody bothered,
> > though, sigh...
>
> R10000.
>
> >  I see your changes are broken conceptually, as the caching mode for the
> > TLB should be inferred from the CPU configuration in the first place and
> > not the system selection (actually it should be best selected ath the run
> > time).  Hence I'd invert the flag, since most systems are non-coherent,
> > and only permit it for certain processors.
>
> Back in time I prefered CONFIG_NONCOHERENT_IO over CONFIG_COHERENT_IO
> because the noncoherent case needs additional code and in general I'm
> trying to reduce the number of the #if !defined conditionals for easier
> readability.
>
> The R10000 is our standard example why looking at the processor type doesn't
> work.  It's used in coherent mode in IP27 but in coherent mode but in
> coherent mode in IP28 or IP32.  Otoh I don't know of any system that
> supports coherency but also is being used with non-coherent processors.
>
> >  Using a non-coherent
> > configuration for an UP system that supports coherency (do SGI IP27 and
> > SiByte SB1250 have another agent in the chipset that may issue coherent
> > requests regardless of the number of processors started?)
>
> Yes.  That's how coherency is working - all agents have to support coherent
> requests or coherency simply won't work.  So basically we'd be trully
> picky we'd have to verify that all agents, processor and other support
> coherency but just using the system type seems to be sufficient.
>

The Malta board is a system that both run coherent and non-coherent, so I would
prefer, that we either make the coherency a configuration option or make it
possible to determine at run time.


>
> > results in a
> > performance hit only due to superfluous invalidations, but using a
> > coherent configuration for a processor/system that doesn't support it may
> > lead to a hard to debug hang with no apparent reason (as I wrote
> > previously, even NMI/Reset stopped working on my system -- I had to hit
> > the power switch).
>
> Using a non-coherent mode on IP27 may result in nice, hard to trackdown bus
> errors.
>
>   Ralf

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
