Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA09242; Fri, 27 Jun 1997 09:42:13 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA09741 for linux-list; Fri, 27 Jun 1997 09:41:51 -0700
Received: from odin.corp.sgi.com (odin.corp.sgi.com [192.26.51.194]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA09715; Fri, 27 Jun 1997 09:41:49 -0700
Received: from fir.engr.sgi.com by odin.corp.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1502/951211.SGI)
	 id JAA06533; Fri, 27 Jun 1997 09:06:08 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id JAA29443; Fri, 27 Jun 1997 09:06:08 -0700
Date: Fri, 27 Jun 1997 09:06:08 -0700
Message-Id: <199706271606.JAA29443@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
Cc: sca@refugee.engr.sgi.com, linux@cthulhu.engr.sgi.com
Subject: Re: Keyboard/Mouse drivers on SGI
In-Reply-To: <199706270132.UAA11076@athena.nuclecu.unam.mx>
References: <199706241904.MAA25297@fir.engr.sgi.com>
	<199706270132.UAA11076@athena.nuclecu.unam.mx>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Miguel de Icaza writes:
 > 
 > >     For the time being, I recommend that you go with the usual linux
 > > driver for PC keyboard/mouse controller, which the Indy hardware 
 > > emulates.
 > 
 > I may probably go with a SunOS-like mode of this, since it may be the
 > easier to hack on the X server I am using right now (X11R6.1, and I
 > plan to move to X11R6.3 once I have the thing demoable).
 > 
 > Later I could sit down and write the emulation mode for a couple of
 > the STREAMS ioctls.

     The streams ioctl's don't do much in themselves, except in the sense
that they turn on other behavior by pushing streams modules.  The latter
have more complex behavior.  You could hack I_PUSH of a given name to
enable specific behavior, and then implement that behavior.  The pushed
streams module is responsible for controlling the device (keyboard, mouse,
tablet, and so on), whereas the driver is mostly responsible for
managing the link controller or serial port to which the device is attached.
