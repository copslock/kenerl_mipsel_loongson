Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g72B4cRw031157
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 2 Aug 2002 04:04:38 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g72B4cGj031156
	for linux-mips-outgoing; Fri, 2 Aug 2002 04:04:38 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft17-f74.dialo.tiscali.de [62.246.17.74])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g72B4TRw031144
	for <linux-mips@oss.sgi.com>; Fri, 2 Aug 2002 04:04:31 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g72B5qj03625;
	Fri, 2 Aug 2002 13:05:52 +0200
Date: Fri, 2 Aug 2002 13:05:52 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] MIPS64 R4k TLB refill CP0 hazards
Message-ID: <20020802130552.C27824@dea.linux-mips.net>
References: <20020731223158.A6394@dea.linux-mips.net> <Pine.GSO.3.96.1020801171104.8256E-100000@delta.ds2.pg.gda.pl> <20020801191804.D22824@dea.linux-mips.net> <3D4A519B.3EF5459@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D4A519B.3EF5459@mips.com>; from carstenl@mips.com on Fri, Aug 02, 2002 at 11:32:18AM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Aug 02, 2002 at 11:32:18AM +0200, Carsten Langgaard wrote:

> > >  After looking at the generated assembly I discovered the handlers don't
> > > fit in 128 bytes.  They didn't crash since I have modules disabled for
> > > now, so the vmalloc path didn't get hit and the user path happened to fit,
> > > but it was pure luck.  The path got hit before I fixed a bug in gas though
> > > -- that's the explanation of the false cache error exceptions I used to
> > > observe.
> >
> > Ouch.  It was a known problem but we simply ignored it for a while as that
> > handler just overwrites the cache error handler which normally should be
> > used extremly rarely, if at all.  The problem is somewhat itching by now
> > as we're supporting the SB1 core which in it's revision one may throw
> > spurious cache errors, so the handler is actually used ...
> >
> 
> Maybe it's time for some intelligent check for the size of these exception
> routine.

Easy trick at compile time which will just inflate the object code a little
bit:

        .align  5
LEAF(except_vec1_r4k)
	[...]
	END(except_vec1_r4k)
	.org	except_vec1_r4k + 0x80

This will result in an assembler error if the body of the except_vec1_r4k
function is bigger than 0x80.

  Ralf
