Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id UAA1115209 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Sep 1997 20:58:28 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA16869 for linux-list; Thu, 4 Sep 1997 20:57:57 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA16865 for <linux@cthulhu.engr.sgi.com>; Thu, 4 Sep 1997 20:57:55 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id UAA07157 for <linux@fir.engr.sgi.com>; Thu, 4 Sep 1997 20:57:53 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA16860 for <linux@fir.engr.sgi.com>; Thu, 4 Sep 1997 20:57:52 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id UAA08437
	for <linux@fir.engr.sgi.com>; Thu, 4 Sep 1997 20:57:50 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id WAA03387;
	Thu, 4 Sep 1997 22:50:43 -0500
Date: Thu, 4 Sep 1997 22:50:43 -0500
Message-Id: <199709050350.WAA03387@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux@fir.engr.sgi.com
Subject: IRIX emulation, getting there.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


This is my next show stopper:

   There is a misterious fcntl call in the IRIX Xsgi server:
it is called with the F_ALLOCSP flag, what is this flag used for in
the X server setup code?  

Cheers,
Miguel.

[
   Unsolved misteries -- update

   The magical address at 0x200000 in the IRIX executables contains
   a one zeroed-page, for now I have mapped an empty page at this
   location on every IRIX program that is ran on the system.

   Both the usinit() test and the Xsgi server can continue execution
   under this scenario now, but it is still hackish. 

]
