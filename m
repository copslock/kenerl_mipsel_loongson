Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA12389; Tue, 8 Apr 1997 19:32:32 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA10177 for linux-list; Tue, 8 Apr 1997 19:32:00 -0700
Received: from soyuz.wellington.sgi.com (soyuz.wellington.sgi.com [134.14.64.194]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA10100 for <linux@cthulhu.engr.sgi.com>; Tue, 8 Apr 1997 19:31:37 -0700
Received: from windy.wellington.sgi.com by soyuz.wellington.sgi.com via ESMTP (940816.SGI.8.6.9/940406.SGI)
	 id OAA29123; Wed, 9 Apr 1997 14:31:17 +1200
Received: (alambie@localhost) by windy.wellington.sgi.com (950413.SGI.8.6.12/8.6.9) id OAA09873; Wed, 9 Apr 1997 14:31:16 +1200
From: "Alistair Lambie" <alambie@wellington.sgi.com>
Message-Id: <9704091431.ZM9866@windy.wellington.sgi.com>
Date: Wed, 9 Apr 1997 14:31:16 +0000
In-Reply-To: "Alistair Lambie" <alambie>
        "Re: init=/bin/sh and serial devices" (Apr  9,  2:30pm)
References: <199704090209.WAA06281@neon.ingenia.ca> 
	<9704091422.ZM9856@windy.wellington.sgi.com> 
	<9704091429.ZM9870@windy.wellington.sgi.com>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: Mike Shaver <shaver@neon.ingenia.ca>
Subject: Re: init=/bin/sh and serial devices
Cc: linux@cthulhu.engr.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Apr 9,  2:30pm, Alistair Lambie wrote:
> Subject: Re: init=/bin/sh and serial devices
> BTW, if you use the init package it will take care of all this stuff...you
> should be able to just lay it over the top of the root package on your nfs
> disk.
>

You will need to edit inittab for the serial devices...it's set up for the vc's
on a 'headed' Indy.


> Cheers, Alistair
>
> On Apr 9,  2:23pm, Alistair Lambie wrote:
> > Subject: Re: init=/bin/sh and serial devices
> > On Apr 9,  2:12pm, Mike Shaver wrote:
> > > Subject: init=/bin/sh and serial devices
> > > Wierd stuff here.
> > > We've got it mountinng the NFS partition and running /bin/sh, but we
> > > can't type anything to it at that point.
> > > It's kinda weird, because we see the `#' prompt, but stuff I type to
> > > it isn't registering.
> > >
> > > stdin in /dev/cua1, FWIW.
> > >
> >
> > Try 'init=/bin/sh </dev/cua1 >/dev/cua1'.  I seem to remember you need
that.
> > Sorry all this seems to be coming piece meal, but it's been a long time
since
> I
> > have run it up, and you kind of forget some of the details till you are
> > reminded!
> >
> > Cheers, Alistair
> >
> > --
> > Alistair Lambie
> 				    alambie@wellington.sgi.com
> > Silicon Graphics New Zealand				  SGI
Voicemail: 56791
> > Level 5, Walsh Wrightson Tower,				    Ph:
> +64-4-802 1455
> > 94-96 Dixon St, Wellington, NZ			  	   Fax:
> +64-4-802 1459
> >-- End of excerpt from Alistair Lambie
>
>
>
> --
> Alistair Lambie
				    alambie@wellington.sgi.com
> Silicon Graphics New Zealand				  SGI Voicemail: 56791
> Level 5, Walsh Wrightson Tower,				    Ph:
+64-4-802 1455
> 94-96 Dixon St, Wellington, NZ			  	   Fax:
+64-4-802 1459
>-- End of excerpt from Alistair Lambie



-- 
Alistair Lambie					    alambie@wellington.sgi.com
Silicon Graphics New Zealand				  SGI Voicemail: 56791
Level 5, Walsh Wrightson Tower,				    Ph: +64-4-802 1455
94-96 Dixon St, Wellington, NZ			  	   Fax: +64-4-802 1459
