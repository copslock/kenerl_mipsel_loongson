Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id PAA78706 for <linux-archive@neteng.engr.sgi.com>; Tue, 7 Oct 1997 15:35:53 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA22285 for linux-list; Tue, 7 Oct 1997 15:34:44 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA22271 for <linux@cthulhu.engr.sgi.com>; Tue, 7 Oct 1997 15:34:42 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id PAA22563 for <linux@fir.engr.sgi.com>; Tue, 7 Oct 1997 15:34:41 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA22259 for <linux@fir.engr.sgi.com>; Tue, 7 Oct 1997 15:34:40 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA06101
	for <linux@fir.engr.sgi.com>; Tue, 7 Oct 1997 15:34:38 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id RAA00575;
	Tue, 7 Oct 1997 17:02:04 -0500
Date: Tue, 7 Oct 1997 17:02:04 -0500
Message-Id: <199710072202.RAA00575@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux@fir.engr.sgi.com
Subject: quick status on linux/sgi
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello guys,

   Things are looking pretty nice.  The kernel that is on the CVS
repository as of now, is pretty stable.  I have used that to compile
my libc natively for the first time as well as compiling the X tree
without the X server (because, well, we don't have a X server yet, I
have some bits written, but I did not merge them into this specific tree). 

   There are a number of bugs on the dynamic linker that Ralf and I
are investigating now.  Happilly we have come up with very simple test
cases that we can reproduce, so it should take little to fix this
(one of the problems prevent Xt applications from running) and the
other bug is related to PAM.

   I have had 5 days uptimes on a loaded machine (compiling lots of
code, as well as testing the direct graphic drivers) without having
seen a single system crash so far.  I had to reboot the machine to
test a new kernel. 

   Anyways, it looks pretty good.  We now just need to port Red Hat's
Mustang distribution to the SGI.  What is the status of this port?

cheers,
Miguel.



   
