Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id UAA83104 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Sep 1997 20:33:59 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA10082 for linux-list; Wed, 17 Sep 1997 20:33:40 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA10076 for <linux@cthulhu.engr.sgi.com>; Wed, 17 Sep 1997 20:33:38 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id UAA18183; Wed, 17 Sep 1997 20:33:37 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA10071; Wed, 17 Sep 1997 20:33:36 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id UAA29246; Wed, 17 Sep 1997 20:33:33 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id WAA12615;
	Wed, 17 Sep 1997 22:23:30 -0500
Date: Wed, 17 Sep 1997 22:23:30 -0500
Message-Id: <199709180323.WAA12615@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: wje@fir.engr.sgi.com
CC: linux@fir.engr.sgi.com
In-reply-to: <199709180203.TAA17980@fir.engr.sgi.com> (wje@fir.engr.sgi.com)
Subject: Re: Linux/SGI Xsgi server: /dev/opengl ioctl NG1_SETDISPLAYMODE
X-Windows: Complex nonsolutions to simple nonproblems.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Another question regarding the Newport:

>      After waiting for the rex3 FIFO to drain, and the the xmap9 FIFO
> to not be full, it sets the xmap9 mode register for the given "wid":
> 
> 	  xmap9SetModeReg( rex3, wid, displaymode, ng1_video_timing[bd->boardnum]->cfreq ); 

If the newport registers are available to the userland application,
why the X server does not directly call those routines instead of
relying on the kernel to perform them?  Is it a convention that
applications should only touch the rex3 registers and not attempt to
program any of the other chips on the dcb?

It would make sense since the graphics context switching would not
involve the kernel peeking at the chips on the dcb what their context
is and then the pain of restoring this.  

Miguel.
