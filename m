Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g71Hv4Rw008707
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 1 Aug 2002 10:57:04 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g71Hv4fb008706
	for linux-mips-outgoing; Thu, 1 Aug 2002 10:57:04 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft16-f78.dialo.tiscali.de [62.246.16.78])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g71HuqRw008697
	for <linux-mips@oss.sgi.com>; Thu, 1 Aug 2002 10:56:53 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g71HwKg24078;
	Thu, 1 Aug 2002 19:58:20 +0200
Date: Thu, 1 Aug 2002 19:58:20 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [update] [patch] linux: Cache coherency fixes
Message-ID: <20020801195820.F22824@dea.linux-mips.net>
References: <20020801184929.B22824@dea.linux-mips.net> <Pine.GSO.3.96.1020801185642.8256P-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020801185642.8256P-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Aug 01, 2002 at 07:14:05PM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Aug 01, 2002 at 07:14:05PM +0200, Maciej W. Rozycki wrote:

> > R10000.
> 
>  OK.  Any specs anywhere?

techpubs.sgi.com should have a somewhat older manual (must have!) and
www.necel.com as well.  The geniouses at NEC stripped the description of
the cache instruction from their manual so it you really want both manuals.

> > Back in time I prefered CONFIG_NONCOHERENT_IO over CONFIG_COHERENT_IO
> > because the noncoherent case needs additional code and in general I'm
> > trying to reduce the number of the #if !defined conditionals for easier
> > readability.
> 
>  Hmm, what's wrong with "#ifndef"?  Not much less readable than "#ifdef",
> IMO. 

Just a small detail.  Nest conditions several times and the spaghetti
starts :-)

> Basically:
> 
> 1. Does the CPU support coherency?
> 
> 2. If so, does the system?
> 
> I'm going to express it this way in the config script.

Have fun expressing if a R4000 variant supports coherency :-)  You can't
if you don't want to introduce even more R4000 types or subtypes.

>  Well, inferring from docs and my experience it's not needed.  A system
> may simply require areas used for DMA to be marked as non-coherent by
> CPUs.  Often uncached accesses are used to prevent spoiling the caches
> anyway.

None such MIPS system known where this is a sensible mode of operation -
and I've hacked quite a number of platforms.  Anyway, if there were such
systems they'd either have to be considered as coherent or as non-coherent.
Our current model doesn't permit any finer grained configuration and unless
such a system actually exists I don't think we should introduce one.

Btw, I've seen a fairly new system in which the non-coherent bits in some
agent are not working at all - it's easier to implement that way ...

> > Using a non-coherent mode on IP27 may result in nice, hard to trackdown bus
> > errors.
> 
>  Weird, but I accept it as a fact.  Still a bus error expresses more than
> a hang. ;-) 

Not so weired.  The system is still operating in coherent mode; that also
means the directory caches still think they know where a particular memory
address is cached.  It's possible to operate an IP27 in non-coherent mode
for I/O only by also reconfiguring the whole chipset but that turned out to
be always slower and harder to get the software correct, so it's not used
except for debugging with a logic analyzer; details are mindbogglingly
complex.

  Ralf
