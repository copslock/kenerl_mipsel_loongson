Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id WAA31901 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Jan 1998 22:15:46 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA26367 for linux-list; Wed, 14 Jan 1998 22:10:57 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA26361; Wed, 14 Jan 1998 22:10:55 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id WAA18877; Wed, 14 Jan 1998 22:10:45 -0800
Date: Wed, 14 Jan 1998 22:10:45 -0800
Message-Id: <199801150610.WAA18877@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: ralf@uni-koblenz.de
Cc: "William J. Earl" <wje@fir.engr.sgi.com>, William Ellis <bellis@cerf.net>,
        Linux porting team <linux@cthulhu.engr.sgi.com>
Subject: Re: boot problem
In-Reply-To: <19980115061519.46558@uni-koblenz.de>
References: <34BD4F3E.7F86@cerf.net>
	<19980115012622.51359@uni-koblenz.de>
	<199801150056.QAA17975@fir.engr.sgi.com>
	<19980115061519.46558@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
 > On Wed, Jan 14, 1998 at 04:56:38PM -0800, William J. Earl wrote:
 > 
 > >  > Thinking about it, the kernel should only try to touch the gfx hardware
 > >  > at all, if the ARC environment variable ``console'' is unset.  If you
 > >  > want to run from a serial console, then the variable's value should be
 > >  > either ``d1'' or ``d2'' for the first rsp. second serial interface.
 > >  > I suppose IRIX just defaults to serial console because it knows that
 > >  > a Challenge S is headless or after a failed probe for gfx hardware.
 > > 
 > >      IRIX probes for the graphics card.  If the probe fails, it
 > > assumes this is not one.  If there is no graphics, or if console != g,
 > > it sets the system console to the serial port.  Note, however, that
 > > IRIX normally puts up an X login on the graphics head even if
 > > console=d and thus the console is on the serial port.  This seems
 > > like a reasonable approach for linux as well.
 > 
 > Indeed, this is how Linux will behave after the probe / console env
 > thing is fixed.  I assume your more than minimal necessary probe has the
 > purpose to make shut that the machine does not only have gfx but also
 > that the gfx found in the address space is not something else like the
 > XZ for example?
...

      Yes, that is correct.  Also, it means that the system will
come up with a serial console if the graphics board is completely dead.
