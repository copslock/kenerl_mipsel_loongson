Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA19712; Mon, 20 May 1996 23:49:58 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA18798 for linux-list; Tue, 21 May 1996 06:49:54 GMT
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA18793 for <linux@cthulhu.engr.sgi.com>; Mon, 20 May 1996 23:49:53 -0700
Received: from ares.esd.sgi.com (fddi-ares.engr.sgi.com [192.26.80.60]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA06436 for <linux@yon.engr.sgi.com>; Mon, 20 May 1996 23:49:28 -0700
Received: from fir.esd.sgi.com by ares.esd.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/950213.SGI.AUTOCF)
	 id XAA20269; Mon, 20 May 1996 23:49:51 -0700
Received: by fir.esd.sgi.com (940816.SGI.8.6.9/920502.SGI.AUTO)
	 id XAA14132; Mon, 20 May 1996 23:49:51 -0700
Date: Mon, 20 May 1996 23:49:51 -0700
From: wje@fir.esd.sgi.com (William J. Earl)
Message-Id: <199605210649.XAA14132@fir.esd.sgi.com>
To: "David S. Miller" <davem@caip.rutgers.edu>
Cc: linux@yon.engr.sgi.com
Subject: Re: some projections...
In-Reply-To: <199605210625.CAA07005@huahaga.rutgers.edu>
References: <199605210625.CAA07005@huahaga.rutgers.edu>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

David S. Miller writes:
...
 > Console driver: I assume the keyboard/mouse is driven off the Zilog
 > 		uarts, if so this should be relatively simple as I can
 > 		adapt most of the code from my Sparc stuff and how I
 > 		layed that code out.  As for the screen I just need
 > 		to figure out where the frame buffer lives and how to
 > 		play with the palette registers and I'm set.  Also
 > 		should be cakewalk to do serial console as well. This
 > 		might be a 4 or 5 day job depending upon how things
 > 		go initially.
...

    The keyboard and mouse, on the Indy and Indigo2, are driven by
a PS2-style keyboard and mouse controller.  Aside from the different 
way of addressing the registers, the driver should pretty much be the
same as the Linux PS2 keyboard and mouse controller.  

    The frame buffer is not directly addressable.  Most operations
are performed via commands written to the pixel pipeline, although
one can DMA pixels from main memory to the frame buffer.  I will
arrange for you to talk with the people who do IRIX X and GL
for Newport.

    It will probably be a good idea to boot up on a serial console
first, since the graphics interface is a bit more complex than a dumb
frame buffer.  That is how we usually port IRIX to a new system.
Since there are two serial ports, one can run the console on the first
port and the remote debugger on the second port, with very little
working beside the serial driver and bsaic exception handling
(assuming you start by booting using bootp() and the standard PROM).
