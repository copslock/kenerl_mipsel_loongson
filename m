Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6NDwvRw026914
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 23 Jul 2002 06:58:57 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6NDwvmP026913
	for linux-mips-outgoing; Tue, 23 Jul 2002 06:58:57 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft17-f249.dialo.tiscali.de [62.246.17.249])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6NDwlRw026902
	for <linux-mips@oss.sgi.com>; Tue, 23 Jul 2002 06:58:48 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6NDxZI24818;
	Tue, 23 Jul 2002 15:59:35 +0200
Date: Tue, 23 Jul 2002 15:59:35 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux: cpu_probe(): remove 32-bit CPU bits for MIPS64
Message-ID: <20020723155935.A22195@dea.linux-mips.net>
References: <20020723152300.A14474@dea.linux-mips.net> <Pine.GSO.3.96.1020723152521.26569C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020723152521.26569C-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Jul 23, 2002 at 03:31:30PM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 23, 2002 at 03:31:30PM +0200, Maciej W. Rozycki wrote:

> > You've been a little bit too fast :) I've almost implemented my suggestion
> > of moving the probing code into cpu-probe.c.
> 
>  What's the problem?  Now the branch and the trunk are in sync (I just did
> a `cp' from the trunk as the missing function was the only difference), so
> you may apply the same changes to both. :-)  Otherwise you'd have to deal
> with the difference.

No real toy, just a merge conflict.  Doing this cleanup I also noticed that
the 2.4 and 2.5 cpu probing code is out of sync, so I took care of that
as well.  Any future clean and fix should new be easier as the merge between
32-bit and 64-bit, 2.4 and 2.5 can simply be done using cp.  Modern
technology rules :)

> > >  That might be a good idea in principle, but it won't solve the problem
> > > anyway.  I'd like to see the code for 32-bit processors get annihilated by
> > > the compiler if built for mips64.  I'll look at it soon.  The MIPS32/64
> > > crap needs to be fixed here as well.
> > 
> > If you find a nice way of implementing this I certainly won't object.
> 
>  The MIPS32/64 fix is obvious; the 32-bit CPU is not so, but I have a sort
> of an idea.  I'd like to get rid of all ifdefs in the area.  Not a high
> priority, though, sorry.

I was refering to the less obvious part, obviously ;-)

  Ralf
