Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0T1MKq01312
	for linux-mips-outgoing; Mon, 28 Jan 2002 17:22:20 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0T1MAP01293
	for <linux-mips@oss.sgi.com>; Mon, 28 Jan 2002 17:22:10 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g0T0KDB18375;
	Mon, 28 Jan 2002 16:20:13 -0800
Subject: RE: Help with OOPSes, anyone?
From: Pete Popov <ppopov@pacbell.net>
To: Matthew Dharm <mdharm@momenco.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <NEBBLJGMNKKEEMNLHGAICEBKCFAA.mdharm@momenco.com>
References: <NEBBLJGMNKKEEMNLHGAICEBKCFAA.mdharm@momenco.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 28 Jan 2002 16:22:36 -0800
Message-Id: <1012263756.8522.181.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 2002-01-28 at 16:09, Matthew Dharm wrote:
> Frankly, I'm not entirely certain which version the Montavista kernel
> is.  We were supposed to be doing the software validation for
> PMC-Sierra (who contracted to Montavista for the work), so this is one
> of the later kernels from that process.  But I really don't know
> exactly which one...

It's probably 2.4.2 based, but it could be 2.4.0-test9.  On the target,
type "uname --all"
 
> As for the 'wait' thing... forgot to try that one.  How does one go
> about disabling the wait instruction, anyway?

arch/mips/kernel/setup.c, in the function check_wait(), ifdef-out the
RM7000 case so that 'wait' is not available.

Pete

> 
> Matt
> 
> --
> Matthew D. Dharm                            Senior Software Designer
> Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
> (760) 431-8663 X-115                        Carlsbad, CA 92008-7310
> Momentum Works For You                      www.momenco.com
> 
> > -----Original Message-----
> > From: Pete Popov [mailto:ppopov@pacbell.net]
> > Sent: Monday, January 28, 2002 3:55 PM
> > To: Matthew Dharm
> > Cc: linux-mips
> > Subject: RE: Help with OOPSes, anyone?
> >
> >
> > On Mon, 2002-01-28 at 15:31, Matthew Dharm wrote:
> > > Well, here's the latest test results...
> > >
> > > The 2.4.0 kernel from MontaVista seems to work just fine.
> >  Of course,
> > > it doesn't have support for the full range of interrupts,
> > but that's a
> > > separate matter.  But it doesn't crash under big compiles.
> >
> > 2.4.0 from MontaVista? Do you mean the very first release, which was
> > 2.4.0-test9?
> >
> > > 2.4.17 with CONFIG_MIPS_UNCACHED crashes.  It takes
> > longer, but that
> > > may just be a function of it running so much slower.  The BogoMIPS
> > > drops by a factor of 100.  Ouch.
> > >
> > > So it doesn't look like a cache problem after all.  And it does
> > > suggest that something introduced between 2.4.0 and .17
> > is what broke
> > > things.  But what that is, I have no idea.
> > >
> > > I'm going to try Jason's modified cache code just in
> > case, but I doubt
> > > that will change anything.  We'll have to see, tho.
> > >
> > > Does anyone have any other suggestions to try?  I'm
> > starting to wonder
> > > if perhaps the PROM isn't setting up the SDRAM properly, but that
> > > conflicts with the working 2.4.0 kernel -- the PROM is the same in
> > > both cases, so I would expect a PROM error to affect both
> > versions.
> > >
> > > I'm running out of ideas here... anyone?
> >
> > If you're absolutely sure 2.4.0-test9 doesn't crash (you
> > ran the test
> > "enough" times), perhaps you can start testing kernels
> > between 2.4.0 and
> > 2.4.17.   And, you did get rid of the 'wait' instruction in 2.4.17,
> > right ;-)?
> >
> > Pete
> >
> 
