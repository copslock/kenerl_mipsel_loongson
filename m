Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA11174; Sat, 3 May 1997 18:42:16 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA04967 for linux-list; Sat, 3 May 1997 18:39:44 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA04950 for <linux@engr.sgi.com>; Sat, 3 May 1997 18:39:24 -0700
Received: from caipfs.rutgers.edu (caipfs.rutgers.edu [128.6.19.100]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id SAA22763
	for <linux@engr.sgi.com>; Sat, 3 May 1997 18:39:21 -0700
	env-from (davem@caipfs.rutgers.edu)
Received: from jenolan.caipgeneral (jenolan.rutgers.edu [128.6.111.5])
	by caipfs.rutgers.edu (8.8.5/8.8.5) with SMTP id VAA12247;
	Sat, 3 May 1997 21:30:26 -0400 (EDT)
Received: by jenolan.caipgeneral (SMI-8.6/SMI-SVR4)
	id VAA02925; Sat, 3 May 1997 21:29:07 -0400
Date: Sat, 3 May 1997 21:29:07 -0400
Message-Id: <199705040129.VAA02925@jenolan.caipgeneral>
From: "David S. Miller" <davem@jenolan.rutgers.edu>
To: ralf@mailhost.uni-koblenz.de
CC: shaver@neon.ingenia.ca, linux@cthulhu.engr.sgi.com
In-reply-to: <199705021211.OAA13307@informatik.uni-koblenz.de> (message from
	Ralf Baechle on Fri, 2 May 1997 14:11:06 +0200 (MET DST))
Subject: Re: linux-2.1.36
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
   Date: Fri, 2 May 1997 14:11:06 +0200 (MET DST)

   David did completly reformat the WD driver to make it readable.
   Downside is that it's difficult to see what he really has changed.
   Someone should probably do that.

   David, what are the differences between your version of the WD
   driver and the stock WD driver?

If you go and diff my modified version and the stock version in that
kernel source tree (probably a 2.0.something, somewhere around there,
you can check the top level Makefile in my original tree ;-) it should
be easy to tell what I've changed and what is just reformatting.

If I recally, I placed new comments in the places where logic/code
changes, and not just reformatting.

---------------------------------------------////
Yow! 11.26 MB/s remote host TCP bandwidth & ////
199 usec remote TCP latency over 100Mb/s   ////
ethernet.  Beat that!                     ////
-----------------------------------------////__________  o
David S. Miller, davem@caip.rutgers.edu /_____________/ / // /_/ ><
