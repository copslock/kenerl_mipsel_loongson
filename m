Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id VAA437661 for <linux-archive@neteng.engr.sgi.com>; Sat, 17 Jan 1998 21:35:21 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA13890 for linux-list; Sat, 17 Jan 1998 21:31:22 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA13883 for <linux@cthulhu.engr.sgi.com>; Sat, 17 Jan 1998 21:31:17 -0800
Received: from note.orchestra.cse.unsw.EDU.AU (note.orchestra.cse.unsw.EDU.AU [129.94.242.29]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via SMTP id VAA03800
	for <linux@cthulhu.engr.sgi.com>; Sat, 17 Jan 1998 21:31:14 -0800
	env-from (conradp@cse.unsw.edu.au)
Received: From l4-00 With LocalMail ; Sun, 18 Jan 98 16:31:08 +1100 
From: "K." <conradp@cse.unsw.edu.au>
To: linux@cthulhu.engr.sgi.com
Date: Sun, 18 Jan 1998 16:31:05 +1100 (EST)
X-Sender: conradp@l4-00.orchestra.cse.unsw.EDU.AU
Subject: cross-compiling gcc
Message-ID: <Pine.GSO.3.95.980118161833.21298K-100000@l4-00.orchestra.cse.unsw.EDU.AU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


when trying to use the gcc from the crossdev directory to cross-complie
code that (indirectly) includes <asm/sgidefs.h> , we get the warning: 
"Please update your GCC to GCC 2.7.2-3 or newer". This happens because the
symbol _MIPS_ISA is not set - consequently compilation barfs when trying
to include <asm/atomic.h> as the wrong section of the header file is used.

Does anyone have a newer version of the cross-compiler, know where we
can get one or how to make one?

K.

--
Conrad Parker conradp@cse.unsw.edu.au
Linux Life: http://www.cse.unsw.edu.au/~conradp/linux/
