Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id FAA08549; Sat, 8 Jun 1996 05:19:57 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA04756 for linux-list; Sat, 8 Jun 1996 12:19:44 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id FAA04751 for <linux@cthulhu.engr.sgi.com>; Sat, 8 Jun 1996 05:19:43 -0700
Received: (from dm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id FAA08535; Sat, 8 Jun 1996 05:19:46 -0700
Date: Sat, 8 Jun 1996 05:19:46 -0700
Message-Id: <199606081219.FAA08535@neteng.engr.sgi.com>
From: "David S. Miller" <dm@neteng.engr.sgi.com>
To: linux@cthulhu.engr.sgi.com
Subject: well it is about time...
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


This port is going like a funeral procession, I apologize.

Ok, quick report:

1) Interrupts work, with a little more coding it will handle the
   setup and registering of all interrupts and handlers on the
   INDY for whatever driver requests them.

2) Timers work, I am using the r4k counter/compare register timer
   mechanism because of the bug in the i8254 Intel timer chips
   on certain INDY's.  The calibration of the compare offsets
   needs some work but the working framework is there and needs
   a little tweaking, basically my algorithm is:

	a) setup i8254 counter 0 and counter 2 such that the period
	   of counter 0 is the desired HZ value
	b) poll counter 0 waiting for a value of 1
	c) quickly set CP0_COUNTER to zero
	d) poll counter 0 for value of 1
	e) quickly read CP0_COUNTER value

   This seems to approximate the value I want in it's current form
   pretty well.  I have to add some fuzz factors into it and possibly
   write the calibration code in assembly to get the accuracy I
   want/need.

3) The kernel boots decently far.  It init's all of memory management,
   sets up the buffer cache, sets up the inode table, inits the
   networking stack, prints the linux banner and is about to fork
   off the init kernel thread.

At this point my task list looks like:

1) Clean up and finish all the krufty code I wrote tonight ;-)

2) Write console/keyboard/mouse/serial drivers as these will need to
   be done anyways.

3) Do some verification on what works at that point.

4) Look into getting kgdb working.

5) Write ethernet/scsi drivers.

6) (fingers crossed) shell prompt... we hope...

As far as I'm concerned I am severely behind schedule.  I will try to
get the pace going more quickly soon, I promise.  Sorry.  God, I'm
so slow, two weeks to get the thing to half boot, sheesh!

Later,
David S. Miller
dm@sgi.com
