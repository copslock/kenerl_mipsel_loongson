Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA21413; Wed, 9 Apr 1997 00:31:33 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id AAA18875 for linux-list; Wed, 9 Apr 1997 00:30:28 -0700
Received: from soyuz.wellington.sgi.com (soyuz.wellington.sgi.com [134.14.64.194]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA18859 for <linux@cthulhu.engr.sgi.com>; Wed, 9 Apr 1997 00:30:21 -0700
Received: from windy.wellington.sgi.com by soyuz.wellington.sgi.com via ESMTP (940816.SGI.8.6.9/940406.SGI)
	 id TAA06677; Wed, 9 Apr 1997 19:30:16 +1200
Received: (alambie@localhost) by windy.wellington.sgi.com (950413.SGI.8.6.12/8.6.9) id TAA10080; Wed, 9 Apr 1997 19:30:15 +1200
From: "Alistair Lambie" <alambie@wellington.sgi.com>
Message-Id: <9704091930.ZM10078@windy.wellington.sgi.com>
Date: Wed, 9 Apr 1997 19:30:15 +0000
In-Reply-To: Martin Knoblauch <knobi@munich.sgi.com>
        "Re: init=/bin/sh and serial devices" (Apr  9,  7:07pm)
References: <199704090209.WAA06281@neon.ingenia.ca> 
	<9704091424.ZM9048@windy.wellington.sgi.com> 
	<334B3FF5.41C6@munich.sgi.com>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: Martin Knoblauch <knobi@munich.sgi.com>
Subject: Re: init=/bin/sh and serial devices
Cc: linux@cthulhu.engr.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Apr 9,  7:07pm, Martin Knoblauch wrote:
> Subject: Re: init=/bin/sh and serial devices
> Alistair Lambie wrote:
> >
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
> > Does your Indy not have a 'head' on it....why are you using
> > the serial ports..
> >
>
>  this brings up the question: do we already have drivers for
> the textport? Not to speak of an X-Server? How are we (SGI)
> going to handle this? As far as I know we never published
> the hardware dependent parts on the X11 distribution, did we?
>

We already have drivers for 'textport'....well actually it takes over the whole
screen with a font that allows something like 132x80 from what I remeber.  This
has VC support so you can do the usual Alt-F1 etc like on a PC based linux box.
 No work has been done on the X-Server yet.

Cheers, Alistair

-- 
Alistair Lambie					    alambie@wellington.sgi.com
Silicon Graphics New Zealand				  SGI Voicemail: 56791
Level 5, Walsh Wrightson Tower,				    Ph: +64-4-802 1455
94-96 Dixon St, Wellington, NZ			  	   Fax: +64-4-802 1459
