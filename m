Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA21285; Mon, 3 Jun 1996 18:03:49 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id BAA24937 for linux-list; Tue, 4 Jun 1996 01:02:55 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA24926 for <linux@cthulhu.engr.sgi.com>; Mon, 3 Jun 1996 18:02:54 -0700
Received: (from dm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA21209; Mon, 3 Jun 1996 18:02:54 -0700
Date: Mon, 3 Jun 1996 18:02:54 -0700
Message-Id: <199606040102.SAA21209@neteng.engr.sgi.com>
From: "David S. Miller" <dm@neteng.engr.sgi.com>
To: linux@cthulhu.engr.sgi.com
Subject: more progress
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I have my ARCS firmware library code in the kernel to the point where
it can do console I/O.  Right now the kernel loads from sash and
prints the SGI ARCS library version and revision numbers then spins in
an endless loop so that it cannot cause any more trouble. ;-)

I plan on continuing the ARCS library support code, specifically the
code to probe for the physical memory layout of the machine which the
rest of the kernel startup code needs anyway, then the device tree
manipulation and probing mechanisms as well.

Next I will look into getting the kgdb code functioning.  And after
that I will most likely try to get the generic kernel init'ing such
that all the generic data structures and non-device code are setup and
the kernel attempts to mount root (which it will not be able to). ;)

In parallel I will begin to write the HPC? support, specifically the
dma interface code.  I will as well be looking into the drivers for
scsi, ethernet and graphics console at the same time, coding what I
can.

Later,
David S. Miller
dm@engr.sgi.com
