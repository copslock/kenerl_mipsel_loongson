Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id JAA80976 for <linux-archive@neteng.engr.sgi.com>; Mon, 26 Jan 1998 09:39:24 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA15514 for linux-list; Mon, 26 Jan 1998 09:36:45 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA15509; Mon, 26 Jan 1998 09:36:44 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id JAA08190; Mon, 26 Jan 1998 09:36:43 -0800
Date: Mon, 26 Jan 1998 09:36:43 -0800
Message-Id: <199801261736.JAA08190@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Boot flags in the kernel.
In-Reply-To: <Pine.LNX.3.95.980126004413.18537A-100000@lager.engsoc.carleton.ca>
References: <Pine.LNX.3.95.980126004413.18537A-100000@lager.engsoc.carleton.ca>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries writes:
 > 
 > I'm not sure if what I'm trying to do is possible. I'm trying to implement
 > the same rootflags that are passwd within the kernel image in i386 into
 > the MIPS kernel. 
 > 
 > In i386 there's a portion of the boot image reserved for these flags;
 > they're things like console type, initial filesystem, initial ramdisk
 > location, etc.  
 > 
 > It's traditionally been more important to have this feature in i386
 > because there wasn't anything nice like the PROMs on MIPS or Sparcs.
 > 
 > But, there _is a good reason to have it; for install or rescue images it's
 > nice to be able to boot with compressed initial ramdisk within the same
 > boot image without having to pass the ramdisk offset on command line
 > manually.
 > 
 > Where in the kernel would we put this data?

       I am sure where you should put it, but bear in mind that the
command line options and environment are passed to the kernel much as
if it were a user main program (as argc, argv, and envp, in $a0, $a1,
and $a2), by sash or the PROM.  You can get things like the console
variable that way (console=g means textport and console=d means
serial console). 
