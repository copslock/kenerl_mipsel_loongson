Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id QAA19199 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Jan 1998 16:59:55 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA27870 for linux-list; Wed, 14 Jan 1998 16:56:59 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA27844; Wed, 14 Jan 1998 16:56:50 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id QAA17975; Wed, 14 Jan 1998 16:56:38 -0800
Date: Wed, 14 Jan 1998 16:56:38 -0800
Message-Id: <199801150056.QAA17975@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: ralf@uni-koblenz.de
Cc: William Ellis <bellis@cerf.net>,
        Linux porting team <linux@cthulhu.engr.sgi.com>
Subject: Re: boot problem
In-Reply-To: <19980115012622.51359@uni-koblenz.de>
References: <34BD4F3E.7F86@cerf.net>
	<19980115012622.51359@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
...
 > No, the FDDI card is just being ignored by Linux.  The problem is
 > indeed the fact that the newport GFX card isn't installed.  I'll
 > take a look at it when I have time for more than one breath
 > per minute ...
 > 
 > Thinking about it, the kernel should only try to touch the gfx hardware
 > at all, if the ARC environment variable ``console'' is unset.  If you
 > want to run from a serial console, then the variable's value should be
 > either ``d1'' or ``d2'' for the first rsp. second serial interface.
 > I suppose IRIX just defaults to serial console because it knows that
 > a Challenge S is headless or after a failed probe for gfx hardware.

     IRIX probes for the graphics card.  If the probe fails, it
assumes this is not one.  If there is no graphics, or if console != g,
it sets the system console to the serial port.  Note, however, that
IRIX normally puts up an X login on the graphics head even if
console=d and thus the console is on the serial port.  This seems
like a reasonable approach for linux as well.

 > William, what is the recommended way to recognice whethere a machine
 > is a Indy or Challenge S?  Probing for a GFX card or checking via
 > ARC firmware?

       I would probe for the graphics card.  If you try to fetch
from the configuration register and get a bus error, or if the
returned value is wrong, assume no graphics. 

       You can check that you can read from the first register
location (0x1f0f0000); if there is a bus error, there is no graphics.
Then check that the GFXBUSY bit (0x8) in the status register at 
0x1f0f1338 turns off within about 300 ms.  The IRIX driver also
does this to check that the card is alive:

	/*
	 * Write an int into the 16-bit xstarti register.
	 * Read it back from the fixed-point xstartf register.
	 * The format is 16 bits of integer, 4 bits of fraction,
	 * all << 7.  In this case, the fraction is 0, so we expect
	 * to read (0x12348765 & 0xffff) << 11.
	 */

	rex3->set.xstarti = 0x12348765;
	if ( rex3->set._xstart.word == ((0x12348765 & 0xffff) << 11) ) {
		ng1_probed[index] = NG1_FOUND;
		return 1;
	}

set.xstarti is 0x1f0f0148 and set._xstart.word is 0x1f0f0100.
