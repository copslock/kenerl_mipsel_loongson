Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id KAA1400297; Sat, 26 Jul 1997 10:43:02 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA15958 for linux-list; Sat, 26 Jul 1997 10:42:41 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA15939 for <linux@cthulhu.engr.sgi.com>; Sat, 26 Jul 1997 10:42:37 -0700
Received: from jenolan.rutgers.edu (jenolan.rutgers.edu [128.6.111.5]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA06648
	for <linux@cthulhu.engr.sgi.com>; Sat, 26 Jul 1997 10:42:36 -0700
	env-from (davem@jenolan.rutgers.edu)
Received: (from davem@localhost)
	by jenolan.rutgers.edu (8.8.5/8.8.5) id NAA03940;
	Sat, 26 Jul 1997 13:41:29 -0400
Date: Sat, 26 Jul 1997 13:41:29 -0400
Message-Id: <199707261741.NAA03940@jenolan.rutgers.edu>
From: "David S. Miller" <davem@jenolan.rutgers.edu>
To: ralf@mailhost.uni-koblenz.de
CC: linux@cthulhu.engr.sgi.com
In-reply-to: <199707261726.TAA00825@informatik.uni-koblenz.de> (message from
	Ralf Baechle on Sat, 26 Jul 1997 19:26:55 +0200 (MET DST))
Subject: Re: Modules
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
   Date: Sat, 26 Jul 1997 19:26:55 +0200 (MET DST)

   Right now I really wonder why modules work at all on any
   architecture with split I/D caches.

On most sparc32's with split I/D, the Icache fully snoops the L2 and
even the store buffer.  On sparc64, I flush the icache when a module
mapping is made...
