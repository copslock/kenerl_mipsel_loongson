Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id FAA12188; Wed, 18 Jun 1997 05:39:46 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id FAA16225 for linux-list; Wed, 18 Jun 1997 05:39:25 -0700
Received: from morgaine.engr.sgi.com (morgaine.engr.sgi.com [130.62.16.64]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id FAA16220 for <linux@cthulhu.engr.sgi.com>; Wed, 18 Jun 1997 05:39:23 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by morgaine.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id FAA16680 for <linux@morgaine.engr.sgi.com>; Wed, 18 Jun 1997 05:38:42 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id FAA27279; Wed, 18 Jun 1997 05:38:42 -0700
Date: Wed, 18 Jun 1997 05:38:42 -0700
Message-Id: <199706181238.FAA27279@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: jwiede@blammo.engr.sgi.com (John Wiederhirn)
Cc: linux@morgaine.engr.sgi.com
Subject: Re: Good news: no more begging for HW
In-Reply-To: <9706171700.ZM11546@blammo.engr.sgi.com>
References: <199706171710.MAA15321@athena.nuclecu.unam.mx>
	<9706171053.ZM9344@sgi.com>
	<9706171700.ZM11546@blammo.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

John Wiederhirn writes:
 > On Jun 17, 10:53am, richard offer wrote:
 > > * $ from miguel@nuclecu.unam.mx at "17-Jun:12:10pm" | sed "1,$s/^/* /"
 > > *
 > > * 4. Would it be possible for a free software company to redistribute
 > > *    the SGI's X server?  In that case, we could concentrate on getting
 > > *    the IRIX emulation as good as possible and just use the SGI X
 > > *    server and let Red Hat/Debian/GNU ship the cd with that binary.
 > >
 > > This would be my preferred solution, but I've had many an argument on this
 > > subject that I felt very dubious about bringing it up again.
...
     I talked with David Miller about this area last year.  I suspect that
one can run any of the cards with the firmware loaded by the PROM, in "dumb"
mode.  One would basically render by hand, or with very limited acceleration
and just DMA the data into the frame buffer (since the frame buffer is generally
not memory-mapped).  The result would not be really fast, but it would be functional.
I am travelling today, but I will check tomorrow.
