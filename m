Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA15043; Thu, 17 Apr 1997 14:04:16 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA01835 for linux-list; Thu, 17 Apr 1997 14:03:12 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA01732 for <linux@relay.engr.SGI.COM>; Thu, 17 Apr 1997 14:03:07 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id OAA11795 for <linux@relay.engr.SGI.COM>; Thu, 17 Apr 1997 14:02:59 -0700
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id PAA30895;
	Thu, 17 Apr 1997 15:46:46 -0500
Date: Thu, 17 Apr 1997 15:46:46 -0500
Message-Id: <199704172046.PAA30895@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux@cthulhu.engr.sgi.com
Subject: IRIX volume manager
X-Windows: Putting new limits on productivity.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello,

    I was reading a very nice paper on the design of XFS and found a
mention to a volume manager.  According to the illustration, it seems
like the volume manager sits between the buffer cache and the disks,
which led me to believe that it is implemented as a device driver. 

   Where can I get more information on the design of IRIX's volume
manager?  Is there any nice paper like the XFS one published?

Cheers,
Miguel.
