Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id VAA285058; Thu, 10 Jul 1997 21:29:36 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA23990 for linux-list; Thu, 10 Jul 1997 21:29:18 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA23983 for <linux@engr.sgi.com>; Thu, 10 Jul 1997 21:29:14 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id VAA02879
	for <linux@engr.sgi.com>; Thu, 10 Jul 1997 21:29:13 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id XAA24748;
	Thu, 10 Jul 1997 23:28:17 -0500
Date: Thu, 10 Jul 1997 23:28:17 -0500
Message-Id: <199707110428.XAA24748@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux@cthulhu.engr.sgi.com
Subject: Quick shmiq question.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello guys,

   I have a new question for all of you lucky STREAMS experts.  Ok,
the thing is, I am not familiar with STREAMS at all, so I am not quite
sure at what to do next.

   What is the ioctl (fd, I_STR, XXXX) thing supposed to do with a
STREAM file handle?  I just can't find any documentation on what this
is for. 

   Is this I_STR thingie done by some higher-level routine (I see
there is a getmsg and putmsg routines declared, is this the way those
routines are implemented, or I am missing the point?).

cheers,
Miguel.
