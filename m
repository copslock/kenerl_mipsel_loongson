Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA09489; Thu, 26 Jun 1997 18:47:09 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA13887 for linux-list; Thu, 26 Jun 1997 18:46:38 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA13882; Thu, 26 Jun 1997 18:46:36 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA24368; Thu, 26 Jun 1997 18:46:30 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id UAA11076;
	Thu, 26 Jun 1997 20:32:43 -0500
Date: Thu, 26 Jun 1997 20:32:43 -0500
Message-Id: <199706270132.UAA11076@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: wje@fir.engr.sgi.com
CC: sca@refugee.engr.sgi.com, linux@cthulhu.engr.sgi.com
In-reply-to: <199706241904.MAA25297@fir.engr.sgi.com> (wje@fir.engr.sgi.com)
Subject: Re: Keyboard/Mouse drivers on SGI
X-Windows: A terminal disease.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


>     For the time being, I recommend that you go with the usual linux
> driver for PC keyboard/mouse controller, which the Indy hardware 
> emulates.

I may probably go with a SunOS-like mode of this, since it may be the
easier to hack on the X server I am using right now (X11R6.1, and I
plan to move to X11R6.3 once I have the thing demoable).

Later I could sit down and write the emulation mode for a couple of
the STREAMS ioctls.

Cheers,
Miguel
