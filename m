Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id MAA325475 for <linux-archive@neteng.engr.sgi.com>; Fri, 19 Sep 1997 12:45:00 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA20716 for linux-list; Fri, 19 Sep 1997 12:44:21 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA20703 for <linux@cthulhu.engr.sgi.com>; Fri, 19 Sep 1997 12:44:20 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id MAA15949 for <linux@fir.engr.sgi.com>; Fri, 19 Sep 1997 12:44:17 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA20682 for <linux@fir.engr.sgi.com>; Fri, 19 Sep 1997 12:44:16 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id MAA05295
	for <linux@fir.engr.sgi.com>; Fri, 19 Sep 1997 12:39:25 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id OAA30318;
	Fri, 19 Sep 1997 14:28:38 -0500
Date: Fri, 19 Sep 1997 14:28:38 -0500
Message-Id: <199709191928.OAA30318@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux@fir.engr.sgi.com
Subject: Linux/SGI: IRIX X server -- kind-of-works-now status.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello guys, 

   Well, my IRIX Xsgi server is running on Linux/SGI without aborting
now.  It displays the nice X cursor and a black background (ie, no
nice X background yet.

   This is caused -I believe- because I am not actually loading the
xmap9 modes as kindly described by Bill.  I have not yet debugged that
problem (for some reason the display control bus locks out most of the
kernel, I will look into fixing this on the afternoon).

   There are a couple of problems here and there, but at least it
seems to be working, here is my list of known bugs for the emulation
bits of IRIX Xsgi:

1. Keymaps are hossed, trivial to fix.

2. Remote clients can not connect (but then, I believe this is caused
   because of some faulty bit on query-net-devices-ioctl emulation).

3. /dev/mouse is hosed: the shmiq device is broken; trivial to fix as well.

4. psaux device is not working, I do not have any idea of how this
   works, so I have to sit down and read docs.

5. my xmap9 loading routine has problems talking to the display
   bus.  This ought to be pretty easy to fix.  Right now, I am using
   the DCB real slow protocol to talk to the xmap9, probably this is
   the culprit:

	relevant dcbmode bits: 
 	CSHOLD = 12;  CSSETUP = 12; CSWIDTH = 0

   On the xmap9.h include file, the macro that loads values into the 
   xmap9 (xmapSetModeRegs) chooses the values for CSHOLD, CSSETUP and
   CSWIDTH based on the cfreq argument.  On the sample code that Bill
   showed me, this value was passed like this (last parameter):

 xmap9SetModeReg( rex3, wid, displaymode, ng1_video_timing[bd->boardnum]->cfreq );

   I am passing a 0 there which forces the cs values I showed previously.	

6. The rrm code is not quite what an IRIX X server expects, so more
   work on this area is required.  Which brings up an interesting
   question:

	I have the impression that you need to get a rendering node
        before you get permission to do direct rendering.  My guess is
        that the context switch information should not be stored on
        the per-process task_struct but on the rendering node
        instead.  Is this the case on IRIX?  I have not really though
        very well about this.

Thanks to all of the kind people at SGI who have helped me with
explanations, documentation and helpful advise in the past for getting
the X server up and running.

best wishes and have a nice day,
Miguel
