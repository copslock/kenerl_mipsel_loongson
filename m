Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id JAA116173 for <linux-archive@neteng.engr.sgi.com>; Thu, 18 Sep 1997 09:21:35 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA19478 for linux-list; Thu, 18 Sep 1997 09:19:05 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA19468 for <linux@cthulhu.engr.sgi.com>; Thu, 18 Sep 1997 09:19:04 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id JAA00605; Thu, 18 Sep 1997 09:19:03 -0700
Date: Thu, 18 Sep 1997 09:19:03 -0700
Message-Id: <199709181619.JAA00605@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
Cc: linux@fir.engr.sgi.com
Subject: Re: Linux/SGI Xsgi server: /dev/opengl ioctl NG1_SETDISPLAYMODE
In-Reply-To: <199709180323.WAA12615@athena.nuclecu.unam.mx>
References: <199709180203.TAA17980@fir.engr.sgi.com>
	<199709180323.WAA12615@athena.nuclecu.unam.mx>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Miguel de Icaza writes:
 > 
 > Another question regarding the Newport:
 > 
 > >      After waiting for the rex3 FIFO to drain, and the the xmap9 FIFO
 > > to not be full, it sets the xmap9 mode register for the given "wid":
 > > 
 > > 	  xmap9SetModeReg( rex3, wid, displaymode, ng1_video_timing[bd->boardnum]->cfreq ); 
 > 
 > If the newport registers are available to the userland application,
 > why the X server does not directly call those routines instead of
 > relying on the kernel to perform them?  Is it a convention that
 > applications should only touch the rex3 registers and not attempt to
 > program any of the other chips on the dcb?
 > 
 > It would make sense since the graphics context switching would not
 > involve the kernel peeking at the chips on the dcb what their context
 > is and then the pain of restoring this.  

      I believe that making this work reasonably would require some way
of making a given user-mode primitive atomic.  This can be hacked by via various
schemes, but the current IRIX implementation does all sequences which must
be atomic in the kernel.  (For example, if I must BFIFOWAIT and then do
some stores, but I context switch after the BFIFOWAIT, there is no guarantee
that the FIFO is not full when I regain control.)  
