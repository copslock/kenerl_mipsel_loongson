Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA17798; Fri, 20 Jun 1997 13:17:13 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA23993 for linux-list; Fri, 20 Jun 1997 13:16:50 -0700
Received: from aa5b.engr.sgi.com (aa5b.engr.sgi.com [150.166.36.26]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA23969; Fri, 20 Jun 1997 13:16:46 -0700
Received: from localhost (nigel@localhost) by aa5b.engr.sgi.com (970321.SGI.8.8.5/950213.SGI.AUTOCF) via SMTP id UAA03555; Fri, 20 Jun 1997 20:16:45 GMT
Date: Fri, 20 Jun 1997 13:16:45 -0700 (PDT)
From: Nigel Gamble <nigel@cthulhu.engr.sgi.com>
To: "David S. Miller" <davem@jenolan.rutgers.edu>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Getting X on Linux/SGI
In-Reply-To: <199706200917.FAA07966@jenolan.caipgeneral>
Message-ID: <Pine.SGI.3.96.970620125702.3690A-100000@aa5b.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, 20 Jun 1997, David S. Miller wrote:
> He was given QNX to write his drivers and get the box going.  Since it
> is a micro-kernel, you have to perform a task switch to handle even an
> interrupt, and you have to compile your interrupt handlers with a
> special compiler and compiler options using QNX compilers just to cope
> with this bullshit.  This was on both systems.
> 
> Interrupt response was so slow, that even when he coded the drivers in
> raw optimized assembly he could not keep up and would drop characters
> easily on his serial ports, the ISDN performance sucked balls as well.
> 
> So eddie got so frustrated one night that he took both the m68k and
> Intel ports of Linux, in about an hour added kernel build time
> configuration options such as "CONFIG_NO_MEMORY_MANAGEMENT",
> "CONFIG_NO_FANCY_SYSCALLS", "CONFIG_NO_USELESS_FEATURES" and the like
> to the point where he was able to get a 120k sized Linux kernel with
> his drivers and the specialized code to run the control systems he
> needed to deploy, and he got full over the serial line KGDB source
> level debugging of his kernel as well.
> 
> The next night he got it completely working and debugged, needless to
> say this thing didn't have the interrupt performance problems QNX
> did.  The next evening he blew the first revisions of the PROM's the
> boxes would eventually use in production when these things got sent
> to the customers.

This tells me more about this guy's determination to use Linux, come
what may, than it does about QNX.  If he'd put half the effort into
learning the QNX device driver model that he did into hacking Linux,
I bet he could have solved his problem with QNX.  I certainly could.

When I first implemented a version of the Linux parallel port
printer driver that used interrupts (because the polling driver was
only printing one line every 30 seconds on my old dot-matrix printer),
I discovered that my driver couldn't send characters fast enough
to keep up with a laser printer.  Does this imply that Linux's
(non-threaded) interrupt performance sucked?  No, it just meant that
my naive first attempt was taking an interrupt for every character.


Nigel Gamble       "Are we going to push the edge of the envelope, Brain?"
Silicon Graphics   "No, Pinky, but we may get to the sticky part."
nigel@sgi.com
(415) 933-3109
