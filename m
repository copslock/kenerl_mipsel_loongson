Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9PIxui27903
	for linux-mips-outgoing; Thu, 25 Oct 2001 11:59:56 -0700
Received: from ns.snowman.net (ns.snowman.net [63.80.4.34])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9PIxlD27899;
	Thu, 25 Oct 2001 11:59:47 -0700
Received: from localhost (nick@localhost)
	by ns.snowman.net (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id OAA18616;
	Thu, 25 Oct 2001 14:59:41 -0400
Date: Thu, 25 Oct 2001 14:59:41 -0400 (EDT)
From: <nick@snowman.net>
X-Sender: nick@ns
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Lukas Hejtmanek <xhejtman@mail.muni.cz>, linux-mips@oss.sgi.com
Subject: Re: Origin 200
In-Reply-To: <20011025121450.A1644@dea.linux-mips.net>
Message-ID: <Pine.LNX.4.21.0110251458380.2654-100000@ns>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I didn't notice any huge differences.  My ASIC HUB ran at a different
speed, 120mhz IIRC.  I will try to aquire a single proc module for my
o200.  Lukas: Can I get a copy of your boot messages under linux?
	Thanks
		Nick

On Thu, 25 Oct 2001, Ralf Baechle wrote:

> On Thu, Oct 25, 2001 at 10:33:33AM +0200, Lukas Hejtmanek wrote:
> 
> > On Wed, Oct 24, 2001 at 08:23:00PM -0400, nick@snowman.net wrote:
> > > Getting it running 64bit shouldn't be *too* bad, however there are some
> > > revs of some chips on the MB which linux currently can't deal with, and
> > > noone is quite sure 1. what revs, 2. why, or 3. anything
> > > usefull. <Grin>.  Could you send a hinv -v from the prom?  Boot logs would
> > > also be usefull (so I can tell if we are haveing the exact same problem,
> > > or just similar ones)
> > 
> > >> hinv -v
> > IP27 Node Board, Module 1, Slot MotherBoard
> >     ASIC HUB Rev 3, 90 MHz, (nasid 0)
> [...]
> 
> Pretty much a standard Origin.  I suspect the problem might be related to
> machines which only have a single physical CPU, that was the only common
> thing between all the Origins on which Linux fails.  And indeed I don't
> think we ever used such a small configuration for testing at SGI ...
> 
> Nick, did you observe any interesting differences to your failing Origin
> configuration?
> 
> Btw, Origin UP kernel is definately broken ...
> 
>   Ralf
> 
