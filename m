Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id NAA504193 for <linux-archive@neteng.engr.sgi.com>; Fri, 14 Nov 1997 13:03:11 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA03398 for linux-list; Fri, 14 Nov 1997 13:00:44 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA03334; Fri, 14 Nov 1997 13:00:38 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id NAA08559; Fri, 14 Nov 1997 13:00:34 -0800
Date: Fri, 14 Nov 1997 13:00:34 -0800
Message-Id: <199711142100.NAA08559@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Shrijeet Mukherjee <shm@cthulhu.engr.sgi.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: SGI / Linux
In-Reply-To: <Pine.SGI.3.94.971114121408.10300A-100000@tantrik.engr.sgi.com>
References: <m0xW9Dg-0005FsC@lightning.swansea.linux.org.uk>
	<Pine.SGI.3.94.971114121408.10300A-100000@tantrik.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Shrijeet Mukherjee writes:
 > 
 > Hi all, 
 > 
 > I just wanted to make something certain, b4 I went and banged my head all
 > the way, about linux ports for SGI h/w.
 > 
 > I have recently acquired a 100Mhz R4K indigo .. would mips/linux work on
 > this, as this is a r4k machine .. ( I would presume the kernel should
 > work, while the device drivers may not ) ..
 > 
 > if yes, is there something else I need to do to make that happen .. if not
 > can I hack my way into making that happen.
 > 
 > If hacking is possible, then could somebody send me some pointers .. since
 > what I want to work on, is the Xserver ..
...

       Most of the chips are similar, but not identical, to those in
the Indy, except for graphics, which is considerably different.  The
memory controller is the same, but many of the I/O parts are earlier
generations.  I don't believe I can readily locate the hardware
documentation for the parts which differ from Indy.  (I was able to
provide documentation for Indy, with management permission.)
