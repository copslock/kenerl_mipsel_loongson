Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id VAA29546 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Jan 1998 21:24:20 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA21485 for linux-list; Wed, 14 Jan 1998 21:18:34 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA21476; Wed, 14 Jan 1998 21:18:29 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id VAA12441; Wed, 14 Jan 1998 21:18:27 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-05.uni-koblenz.de [141.26.249.5])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id GAA14440;
	Thu, 15 Jan 1998 06:18:24 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id GAA06339;
	Thu, 15 Jan 1998 06:15:19 +0100
Message-ID: <19980115061519.46558@uni-koblenz.de>
Date: Thu, 15 Jan 1998 06:15:19 +0100
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: William Ellis <bellis@cerf.net>,
        Linux porting team <linux@cthulhu.engr.sgi.com>
Subject: Re: boot problem
References: <34BD4F3E.7F86@cerf.net> <19980115012622.51359@uni-koblenz.de> <199801150056.QAA17975@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199801150056.QAA17975@fir.engr.sgi.com>; from William J. Earl on Wed, Jan 14, 1998 at 04:56:38PM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jan 14, 1998 at 04:56:38PM -0800, William J. Earl wrote:

>  > Thinking about it, the kernel should only try to touch the gfx hardware
>  > at all, if the ARC environment variable ``console'' is unset.  If you
>  > want to run from a serial console, then the variable's value should be
>  > either ``d1'' or ``d2'' for the first rsp. second serial interface.
>  > I suppose IRIX just defaults to serial console because it knows that
>  > a Challenge S is headless or after a failed probe for gfx hardware.
> 
>      IRIX probes for the graphics card.  If the probe fails, it
> assumes this is not one.  If there is no graphics, or if console != g,
> it sets the system console to the serial port.  Note, however, that
> IRIX normally puts up an X login on the graphics head even if
> console=d and thus the console is on the serial port.  This seems
> like a reasonable approach for linux as well.

Indeed, this is how Linux will behave after the probe / console env
thing is fixed.  I assume your more than minimal necessary probe has the
purpose to make shut that the machine does not only have gfx but also
that the gfx found in the address space is not something else like the
XZ for example?

William Ellis: could you try to set the ARC environment variable ``console''
to d1 / d2 according to the port you're using and run the kernel you've
tested once again?

  Ralf
