Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9PAFeP31501
	for linux-mips-outgoing; Thu, 25 Oct 2001 03:15:40 -0700
Received: from dea.linux-mips.net (a1as16-p224.stg.tli.de [195.252.192.224])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9PAFVD31498
	for <linux-mips@oss.sgi.com>; Thu, 25 Oct 2001 03:15:31 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f9PAEok01686;
	Thu, 25 Oct 2001 12:14:50 +0200
Date: Thu, 25 Oct 2001 12:14:50 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: nick@snowman.net, linux-mips@oss.sgi.com
Subject: Re: Origin 200
Message-ID: <20011025121450.A1644@dea.linux-mips.net>
References: <20011025010425.C2045@mail.muni.cz> <Pine.LNX.4.21.0110242021240.25602-100000@ns> <20011025103333.E2045@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011025103333.E2045@mail.muni.cz>; from xhejtman@mail.muni.cz on Thu, Oct 25, 2001 at 10:33:33AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Oct 25, 2001 at 10:33:33AM +0200, Lukas Hejtmanek wrote:

> On Wed, Oct 24, 2001 at 08:23:00PM -0400, nick@snowman.net wrote:
> > Getting it running 64bit shouldn't be *too* bad, however there are some
> > revs of some chips on the MB which linux currently can't deal with, and
> > noone is quite sure 1. what revs, 2. why, or 3. anything
> > usefull. <Grin>.  Could you send a hinv -v from the prom?  Boot logs would
> > also be usefull (so I can tell if we are haveing the exact same problem,
> > or just similar ones)
> 
> >> hinv -v
> IP27 Node Board, Module 1, Slot MotherBoard
>     ASIC HUB Rev 3, 90 MHz, (nasid 0)
[...]

Pretty much a standard Origin.  I suspect the problem might be related to
machines which only have a single physical CPU, that was the only common
thing between all the Origins on which Linux fails.  And indeed I don't
think we ever used such a small configuration for testing at SGI ...

Nick, did you observe any interesting differences to your failing Origin
configuration?

Btw, Origin UP kernel is definately broken ...

  Ralf
