Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA21779; Tue, 9 Jul 1996 21:52:33 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id EAA10731 for linux-list; Wed, 10 Jul 1996 04:51:14 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA10724 for <linux@cthulhu.engr.sgi.com>; Tue, 9 Jul 1996 21:51:13 -0700
Received: (from dm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA21507; Tue, 9 Jul 1996 21:51:12 -0700
Date: Tue, 9 Jul 1996 21:51:12 -0700
Message-Id: <199607100451.VAA21507@neteng.engr.sgi.com>
From: "David S. Miller" <dm@neteng.engr.sgi.com>
To: linux@cthulhu.engr.sgi.com
Subject: wheee, good news....
Reply-to: dm@sgi.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I just successfully built a Linux kernel on an INDY under Linux
itself.  All of the build tools and the shell were GNU utilities, but
were IRIX binaries.  It took some hacking, and I had to type make a
few times becuase the compiler would crash here and there, but it did
work.

To test how well it went I then proceeded to boot the INDY using the
Linux kernel it had just built for itself, and it worked! ;-)

SCSI driver is next...

Later,
David S. Miller
dm@sgi.com
