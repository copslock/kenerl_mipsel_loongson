Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA18810; Thu, 19 Jun 1997 12:43:36 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA24459 for linux-list; Thu, 19 Jun 1997 12:43:15 -0700
Received: from morgaine.engr.sgi.com (morgaine.engr.sgi.com [130.62.16.64]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA24452 for <linux@cthulhu.engr.sgi.com>; Thu, 19 Jun 1997 12:43:13 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by morgaine.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA20534 for <linux@morgaine.engr.sgi.com>; Thu, 19 Jun 1997 12:42:32 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id MAA11573; Thu, 19 Jun 1997 12:42:31 -0700
Date: Thu, 19 Jun 1997 12:42:31 -0700
Message-Id: <199706191942.MAA11573@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Martin Knoblauch <knobi@munich.sgi.com>
Cc: Larry McVoy <lm@neteng.engr.sgi.com>,
        John Wiederhirn <jwiede@blammo.engr.sgi.com>,
        linux@morgaine.engr.sgi.com
Subject: Re: Getting X on Linux/SGI (2)
In-Reply-To: <33A79A89.1CFB@munich.sgi.com>
References: <199706180637.XAA09017@neteng.engr.sgi.com>
	<33A79A89.1CFB@munich.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Martin Knoblauch writes:
 > [also changeing the subject]
 > 
 > Larry McVoy wrote:
 > > 
 > > : There are some very serious issues which come up even getting
 > > : Xfree to a moderate level of acceleration.
 > > 
 > > How about to a simple level of working?  Without any acceleration?
 > > For most people, just having xterms and netscape working is enough.
 > > 
 > > I'm not a graphics or X person.  Could someone who knows SGI's gfx
 > > devices tell us how hard it would be to make the basics work?
 > > 
 > 
 >   Probably not that hard if we gave away the documentation
 > (do we have *documentation*) on the GFX cards low level interfaces.
 > The major problem to me seems that each different architecture
 > (XL, XZ/Elan/Extreme, IMPACT, CRM) has different interfaces.
 > I am not sure that you can find a minimal subset of calls
 > to make a very simple Xserver work (is Peter Daifuku on this
 > list ? Mark Kilgard?).

     The kernel graphics driver is quite complex, although that is in
large part due to the support for direct rendering in GL.  The
hardware, except for Starter, XL, and O2, requires downloaded firmware.
Fortunately, basic firmware is downloaded by the PROM, so that it can
write on the screen.  I believe that an X server can simply do the
same operations as the PROM, in regard to manipulating the frame buffer,
using the firmware interfaces.  I have to investigate this in more
detail, however.

...
 > - How much HW dependent stuff is in Xsgi itself?
 > - Which of the DSOs in /usr/lib/X11/dyDDX are minimally
 >   needed to bring up an non-GLX Xserver?
 > - How much efforts would it cost to compile the dyDDX
 >   stuff for Linux and distribute the binaries only
 >   (assuming that there is not to much HW stuff in Xsgi itself)?

     The interfaces are very different.  I tried mixing IRIX X server
and XFree86 X server source and did not get very far.  
