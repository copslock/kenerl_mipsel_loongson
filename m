Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA05718; Wed, 9 Apr 1997 10:34:07 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA17873 for linux-list; Wed, 9 Apr 1997 10:33:16 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA17859 for <linux@relay.engr.SGI.COM>; Wed, 9 Apr 1997 10:33:13 -0700
Received: from caipfs.rutgers.edu (caipfs.rutgers.edu [128.6.19.100]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id KAA06976 for <linux@relay.engr.SGI.COM>; Wed, 9 Apr 1997 10:33:01 -0700
Received: from jenolan.caipgeneral (jenolan.rutgers.edu [128.6.111.5])
	by caipfs.rutgers.edu (8.8.5/8.8.5) with SMTP id JAA19306;
	Wed, 9 Apr 1997 09:29:36 -0400 (EDT)
Received: by jenolan.caipgeneral (SMI-8.6/SMI-SVR4)
	id JAA00813; Wed, 9 Apr 1997 09:28:20 -0400
Date: Wed, 9 Apr 1997 09:28:20 -0400
Message-Id: <199704091328.JAA00813@jenolan.caipgeneral>
From: "David S. Miller" <davem@jenolan.rutgers.edu>
To: alambie@wellington.sgi.com
CC: shaver@neon.ingenia.ca, linux@cthulhu.engr.sgi.com
In-reply-to: <9704091142.ZM9015@windy.wellington.sgi.com>
	(alambie@wellington.sgi.com)
Subject: Re: (Fwd) Re: It booooooooooots!
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   From: "Alistair Lambie" <alambie@wellington.sgi.com>
   Date: Wed, 9 Apr 1997 11:42:21 +0000

   >      This appears to be a bug.  The R5000 does have the wait instruction.

   I don't think David ever worked on an R5000.  The only platforms were R4600 &
   R4400...soooo, there may be some issues to be resolved.

Actually in this case Ralf's code for wait instruction detection
happened to work out of the box on my R4XX0 test machines back at SGI,
so it apparently does need to be looked into for the R5k.

---------------------------------------------////
Yow! 11.26 MB/s remote host TCP bandwidth & ////
199 usec remote TCP latency over 100Mb/s   ////
ethernet.  Beat that!                     ////
-----------------------------------------////__________  o
David S. Miller, davem@caip.rutgers.edu /_____________/ / // /_/ ><
