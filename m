Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6BFvFRw007314
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 08:57:15 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6BFvFQD007313
	for linux-mips-outgoing; Thu, 11 Jul 2002 08:57:15 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft18-f21.dialo.tiscali.de [62.246.18.21])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6BFv6Rw007277
	for <linux-mips@oss.sgi.com>; Thu, 11 Jul 2002 08:57:08 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6BBClD11743;
	Thu, 11 Jul 2002 13:12:47 +0200
Date: Thu, 11 Jul 2002 13:12:47 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc: Carsten Langgaard <carstenl@mips.com>,
   Jon Burgess <Jon_Burgess@eur.3com.com>, linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
Message-ID: <20020711131247.A11700@dea.linux-mips.net>
References: <80256BF2.004ECBE6.00@notesmta.eur.3com.com> <20020711021554.A3207@dea.linux-mips.net> <3D2D465C.FA06D50A@niisi.msk.ru> <3D2D4D83.B2694DF1@mips.com> <3D2D58A6.2E5D9695@niisi.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D2D58A6.2E5D9695@niisi.msk.ru>; from raiko@niisi.msk.ru on Thu, Jul 11, 2002 at 02:06:30PM +0400
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 11, 2002 at 02:06:30PM +0400, Gleb O. Raiko wrote:

> > > Unfortunately, it's required by manuals for some processors. As I know,
> > > IDT HW manuals clearly state cache flush routines must operate from
> > > uncached code and must access uncached data only. Examples are R30x1 CPU
> > > series.
> > 
> > Yes, that's true.
> > But that code belongs in the R30xx specific cache routines, not in the
> > MIPS32 cache routines.
> 
> I don't wonder if other IDT CPUs also require this, including those that
> conform MIPS32.
> Basically, requirement of uncached run makes hadrware logic much simpler
> and allows  to save silicon a bit.

The R3000 cache manipulation mechanism is implemented by giving magic
meaning to store instruction while the isolate cache and swap cache bits
are in use.  By their very implementation they're both incompatible with
normal operation of caches and therefore can only be used from uncached
space.

For most part of it the situation for R4000 class CPUs is easier; a cache
instruction either hits or fails.  The only problem I could imagine an
access conflict in the i-cache when both normal instruction fetch and the
cache instruction are going to operate on the i-cache and that sounds like
a less likely problem to me.

Of course not having read the RTL of all CPUs there is a bit of speculation
here :)

  Ralf
