Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6NDMJRw026213
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 23 Jul 2002 06:22:19 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6NDMJKV026212
	for linux-mips-outgoing; Tue, 23 Jul 2002 06:22:19 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft17-f249.dialo.tiscali.de [62.246.17.249])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6NDMBRw026200
	for <linux-mips@oss.sgi.com>; Tue, 23 Jul 2002 06:22:13 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6NDN0f21170;
	Tue, 23 Jul 2002 15:23:00 +0200
Date: Tue, 23 Jul 2002 15:23:00 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux: cpu_probe(): remove 32-bit CPU bits for MIPS64
Message-ID: <20020723152300.A14474@dea.linux-mips.net>
References: <20020723141407.B10566@dea.linux-mips.net> <Pine.GSO.3.96.1020723144023.26569B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020723144023.26569B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Jul 23, 2002 at 03:05:47PM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 23, 2002 at 03:05:47PM +0200, Maciej W. Rozycki wrote:

> > I intentionally have that 32-bit stuff in the 64-bit kernel so we can simply
> > have share identical CPU probing code between the 32-bit and 64-bit kernels.
> > This in anticipation of a further unification of the two ports which still
> > duplicate plenty of code with just minor changes.
> 
>  I suspected a maintability reason.

Right

> Thus as a temporary fix I'm checking in a version that provides the
> missing cpu_has_fpu() function (a copy from the trunk).

You've been a little bit too fast :) I've almost implemented my suggestion
of moving the probing code into cpu-probe.c.

> > To make sharing easier I suggest to move all the CPU probing code into it's
> > own file, probe.c or so?
> 
>  That might be a good idea in principle, but it won't solve the problem
> anyway.  I'd like to see the code for 32-bit processors get annihilated by
> the compiler if built for mips64.  I'll look at it soon.  The MIPS32/64
> crap needs to be fixed here as well.

If you find a nice way of implementing this I certainly won't object.

  Ralf
