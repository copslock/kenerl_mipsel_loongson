Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id TAA30505 for <linux-archive@neteng.engr.sgi.com>; Tue, 2 Dec 1997 19:07:47 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA06445 for linux-list; Tue, 2 Dec 1997 19:06:35 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA06437 for <linux@cthulhu.engr.sgi.com>; Tue, 2 Dec 1997 19:06:34 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id TAA05948; Tue, 2 Dec 1997 19:06:33 -0800
Date: Tue, 2 Dec 1997 19:06:33 -0800
Message-Id: <199712030306.TAA05948@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: jwiede@blammo.engr.sgi.com (John Wiederhirn)
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Linux on the O2
In-Reply-To: <9712021646.ZM11626@blammo.engr.sgi.com>
References: <m0xd2Iz-0005FsC@lightning.swansea.linux.org.uk>
	<9712021646.ZM11626@blammo.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

John Wiederhirn writes:
...
 > Now, having said all that, I do believe the problem is solvable.
 > I think that with some modifications of the Linux kernel, it would
 > be quite possible to get the necessary abstraction to support
 > either an IRIX or customized third-party X server.  Further, it
 > would be nice if something equivalent to the SGI DMedia libraries
 > were available on Linux (with similar hardware abstraction), since
 > this is an area where simply put, Linux is FAR behind Windows{95,NT}
 > and SGI (and others).
 > 
 > Getting Linux on O2 probably isn't too difficult.  Getting USEFUL
 > O2/Octane/Onyx2 2D/3D graphics and multimedia under Linux would
 > be god-awful difficult with the current kernel/X situation.
...

     Having implemented a good bit of the system-specific code for
Indy and O2, I agree entirely.  Without the above features, O2 is just
another, not especially distinguished, general purpose workstation,
except for having fairly fast I/O for its price.  The most interesting
thing about O2 is what you can do with graphics and multimedia, which
is otherwise possible only with far more expensive hardware.  In
different problem domains, something similar can be said of Octane and
the various SGI servers.
