Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id OAA553299 for <linux-archive@neteng.engr.sgi.com>; Sun, 21 Sep 1997 14:54:38 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA04098 for linux-list; Sun, 21 Sep 1997 14:54:17 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA04093 for <linux@cthulhu.engr.sgi.com>; Sun, 21 Sep 1997 14:54:14 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA25525
	for <linux@cthulhu.engr.sgi.com>; Sun, 21 Sep 1997 14:54:13 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id QAA07108;
	Sun, 21 Sep 1997 16:43:18 -0500
Date: Sun, 21 Sep 1997 16:43:18 -0500
Message-Id: <199709212143.QAA07108@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux@cthulhu.engr.sgi.com
Subject: Linux/SGI: IRIX X server -- more status.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello guys,

    Thanks to Robert Tray for helping me finding the proper protocol
that has to be used with the xmap9 and 24 hours of rest, the X server
is now displaying correctly on my machine.  

    The reason the ioctl NG1_SETDISPLAYMODE was hanging my machine was
pretty easy: on the xmap9 documentation it says that the number of
entries available on the xmap9 fifo is a 3 bit number, but later on
the document, it explains that this number is actually mapped like
this:

	000	- no entries available
	001	- one entry available
	011	- two entries available
	010	- three entries available.
	
    Next time I will be more careful reading that.

    Now, I am off to test xterm and merge my code with the cvs
repository at linux.sgi.com.

Cheers,
Miguel.
