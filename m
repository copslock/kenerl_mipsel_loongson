Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id VAA138692 for <linux-archive@neteng.engr.sgi.com>; Sun, 11 Jan 1998 21:28:05 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA21522 for linux-list; Sun, 11 Jan 1998 21:23:51 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA21510 for <linux@cthulhu.engr.sgi.com>; Sun, 11 Jan 1998 21:23:49 -0800
Received: from note.orchestra.cse.unsw.EDU.AU (note.orchestra.cse.unsw.EDU.AU [129.94.242.29]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via SMTP id VAA00698
	for <linux@cthulhu.engr.sgi.com>; Sun, 11 Jan 1998 21:23:48 -0800
	env-from (conradp@cse.unsw.edu.au)
Received: From l4-00 With LocalMail ; Mon, 12 Jan 98 16:23:42 +1100 
From: "K." <conradp@cse.unsw.edu.au>
To: linux@cthulhu.engr.sgi.com
Date: Mon, 12 Jan 1998 16:23:37 +1100 (EST)
X-Sender: conradp@l4-00.orchestra.cse.unsw.EDU.AU
Subject: crtbegin.o, crtend.o
Message-ID: <Pine.GSO.3.95.980112161052.11350F-100000@l4-00.orchestra.cse.unsw.EDU.AU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


um... can anyone point out where these files can be obtained? In our
recent install, (Indy R4600) made from the root-be-0.01 root filesystem
with the recent binutils-2.8.1-2, they are missing. We hacked out dummy
object files (crtbegin has a __main() which calls main() and crtend is
empty) and we can successfully compile simple programs; but before we turn
our attention to compiling nastier pieces of code we would like to check
that we have not tainted our /usr/lib :)

thanks,

K.
--
Conrad Parker conradp@cse.unsw.edu.au
Linux Life: http://www.cse.unsw.edu.au/~conradp/linux/
