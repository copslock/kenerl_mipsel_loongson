Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA22805; Mon, 16 Jun 1997 19:08:53 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA17776 for linux-list; Mon, 16 Jun 1997 19:08:29 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA17769 for <linux@cthulhu.engr.sgi.com>; Mon, 16 Jun 1997 19:08:27 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA20628 for <linux@yon.engr.sgi.com>; Mon, 16 Jun 1997 19:08:15 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA17751 for <linux@yon.engr.sgi.com>; Mon, 16 Jun 1997 19:08:14 -0700
Received: from caipfs.rutgers.edu (caipfs.rutgers.edu [128.6.155.100]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id TAA12593
	for <linux@yon.engr.sgi.com>; Mon, 16 Jun 1997 19:08:12 -0700
	env-from (davem@caipfs.rutgers.edu)
Received: from jenolan.caipgeneral (jenolan.rutgers.edu [128.6.111.5])
	by caipfs.rutgers.edu (8.8.5/8.8.5) with SMTP id WAA08488;
	Mon, 16 Jun 1997 22:03:34 -0400 (EDT)
Received: by jenolan.caipgeneral (SMI-8.6/SMI-SVR4)
	id WAA00413; Mon, 16 Jun 1997 22:01:27 -0400
Date: Mon, 16 Jun 1997 22:01:27 -0400
Message-Id: <199706170201.WAA00413@jenolan.caipgeneral>
From: "David S. Miller" <davem@jenolan.rutgers.edu>
To: ariel@sgi.com
CC: ralf@mailhost.uni-koblenz.de, linux@yon.engr.sgi.com
In-reply-to: <199706170106.SAA19946@yon.engr.sgi.com> (ariel@yon.engr.sgi.com)
Subject: Re: Good news: no more begging for HW
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   From: ariel@yon.engr.sgi.com (Ariel Faigon)
   Date: Mon, 16 Jun 1997 18:06:41 -0700 (PDT)

   I cannot promise anything since there may be some oversubscription
   to the service :-)

   I think the fairest way would be to publish all these requests on
   this forum and have the people who care (us) vote on who should get
   them.  I certainly don't want to be the fascist person who decides
   who gets what.

Before this gets out of control, I just want to express one sentiment
of high caution.

Although it may seem desirable to contribute most of the donation
hardware to kernel level hackers, this can be a mistake in the making.
At this stage in the game it is just as important to get userland/libc
developers machines.

Therefore I suggest that at least one person who knows GNU libc,
binutils, _and_ gcc internals backwards and forwards be on the top of
the donation list.  If I were asked for such a candidate, I would
recommend Richard Henderson (rth@stommel.tamu.edu) He has done the
Alpha/Linux port, he designed an ELF standard for 64-bit Alpha from
scratch with no existing standard available, he is doing the same
exact thing for 64-bit SparcLinux at the moment as well.

Not having a good libc/userland person in this port is why I lost half
my summer last year and was not able to hack the kernel as much as I
really would have liked to at all...

---------------------------------------------////
Yow! 11.26 MB/s remote host TCP bandwidth & ////
199 usec remote TCP latency over 100Mb/s   ////
ethernet.  Beat that!                     ////
-----------------------------------------////__________  o
David S. Miller, davem@caip.rutgers.edu /_____________/ / // /_/ ><
