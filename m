Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id GAA22234; Tue, 8 Jul 1997 06:27:39 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA01923 for linux-list; Tue, 8 Jul 1997 06:27:21 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA01918 for <linux@cthulhu.engr.sgi.com>; Tue, 8 Jul 1997 06:27:18 -0700
Received: from caipfs.rutgers.edu (caipfs.rutgers.edu [128.6.155.100]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id GAA12080
	for <linux@cthulhu.engr.sgi.com>; Tue, 8 Jul 1997 06:27:16 -0700
	env-from (davem@caipfs.rutgers.edu)
Received: from jenolan.caipgeneral (jenolan.rutgers.edu [128.6.111.5])
	by caipfs.rutgers.edu (8.8.5/8.8.5) with SMTP id JAA00160;
	Tue, 8 Jul 1997 09:27:15 -0400 (EDT)
Received: by jenolan.caipgeneral (SMI-8.6/SMI-SVR4)
	id JAA01009; Tue, 8 Jul 1997 09:25:09 -0400
Date: Tue, 8 Jul 1997 09:25:09 -0400
Message-Id: <199707081325.JAA01009@jenolan.caipgeneral>
From: "David S. Miller" <davem@jenolan.rutgers.edu>
To: ralf@mailhost.uni-koblenz.de
CC: linux@cthulhu.engr.sgi.com
In-reply-to: <199707081017.MAA21226@informatik.uni-koblenz.de> (message from
	Ralf Baechle on Tue, 8 Jul 1997 12:17:11 +0200 (MET DST))
Subject: Re: MIPS Distribution status (Was: Status ...)
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
   Date: Tue, 8 Jul 1997 12:17:11 +0200 (MET DST)

   Ok, I took a look at it.  The Emacs 19.34b does not contain the
   least bit of support for mips{el}-linux, so no wonder why it
   doesn't build.  Can you send me your patches?  I assume RMS won't
   like it if we take the Emacs snapshot from the FSF ...

Go into src/m/mips.h and grep for __linux__ it's in there.
