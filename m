Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA00076; Mon, 14 Apr 1997 19:30:01 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA10928 for linux-list; Mon, 14 Apr 1997 19:29:09 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA10914; Mon, 14 Apr 1997 19:29:05 -0700
Received: from caipfs.rutgers.edu (caipfs.rutgers.edu [128.6.91.100]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id TAA18962; Mon, 14 Apr 1997 19:28:37 -0700
Received: from jenolan.caipgeneral (jenolan.rutgers.edu [128.6.111.5])
	by caipfs.rutgers.edu (8.8.5/8.8.5) with SMTP id WAA08847;
	Mon, 14 Apr 1997 22:10:29 -0400 (EDT)
Received: by jenolan.caipgeneral (SMI-8.6/SMI-SVR4)
	id WAA00938; Mon, 14 Apr 1997 22:09:11 -0400
Date: Mon, 14 Apr 1997 22:09:11 -0400
Message-Id: <199704150209.WAA00938@jenolan.caipgeneral>
From: "David S. Miller" <davem@jenolan.rutgers.edu>
To: wje@fir.engr.sgi.com
CC: knobi@munich.sgi.com, alambie@wellington.sgi.com, shaver@neon.ingenia.ca,
        linux@cthulhu.engr.sgi.com
In-reply-to: <199704141805.LAA10353@fir.engr.sgi.com> (wje@fir.engr.sgi.com)
Subject: Re: init=/bin/sh and serial devices
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   Date: Mon, 14 Apr 1997 11:05:52 -0700
   From: "William J. Earl" <wje@fir.engr.sgi.com>

	Does the textport driver run in color-index mode?  If so, it
   will probably work on the 8-bit card.  The cards are largely
   identical, except for the depth of the frame buffer.

If memory serves, I left the chip in the exact mode the firmware has
set it to.  So if the firmware sets up the card to use color-index
mode, then I do as well in the driver.  (I think I did this so I did
not have to deal with monitor frequencies, and resolutions, and that
sort of thing)

But my text rendering code may make assumptions about frame buffer
depth, I draw them using the various simpler raster operation commands
the Newport has, so someone who knows would have to look at my code.

---------------------------------------------////
Yow! 11.26 MB/s remote host TCP bandwidth & ////
199 usec remote TCP latency over 100Mb/s   ////
ethernet.  Beat that!                     ////
-----------------------------------------////__________  o
David S. Miller, davem@caip.rutgers.edu /_____________/ / // /_/ ><
