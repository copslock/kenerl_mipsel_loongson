Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id BAA07574; Mon, 14 Apr 1997 01:23:19 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id BAA21196 for linux-list; Mon, 14 Apr 1997 01:22:38 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id BAA21184 for <linux@relay.engr.SGI.COM>; Mon, 14 Apr 1997 01:22:35 -0700
Received: from caipfs.rutgers.edu (caipfs.rutgers.edu [128.6.91.100]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id BAA26302 for <linux@relay.engr.SGI.COM>; Mon, 14 Apr 1997 01:22:33 -0700
Received: from jenolan.caipgeneral (jenolan.rutgers.edu [128.6.111.5])
	by caipfs.rutgers.edu (8.8.5/8.8.5) with SMTP id EAA09444;
	Mon, 14 Apr 1997 04:18:36 -0400 (EDT)
Received: by jenolan.caipgeneral (SMI-8.6/SMI-SVR4)
	id EAA00522; Mon, 14 Apr 1997 04:17:17 -0400
Date: Mon, 14 Apr 1997 04:17:17 -0400
Message-Id: <199704140817.EAA00522@jenolan.caipgeneral>
From: "David S. Miller" <davem@jenolan.rutgers.edu>
To: knobi@munich.sgi.com
CC: alambie@wellington.sgi.com, shaver@neon.ingenia.ca,
        linux@cthulhu.engr.sgi.com
In-reply-to: <334B3FF5.41C6@munich.sgi.com> (message from Martin Knoblauch on
	Wed, 09 Apr 1997 09:06:29 +0200)
Subject: Re: init=/bin/sh and serial devices
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   Date: Wed, 09 Apr 1997 09:06:29 +0200
   From: Martin Knoblauch <knobi@munich.sgi.com>

   do we already have drivers for the textport?

I wrote the text console driver for 24-bit Newport INDY frame buffers,
and it is in the SGI/Linux code.  I was never able to get around to
doing the 8-bit frame buffer card driver though, so if you've got one
of those in the INDY you are a out of luck for now.  (hinv -v from the
firmware prompt will tell you if you have the 24-bit or 8-bit card)

---------------------------------------------////
Yow! 11.26 MB/s remote host TCP bandwidth & ////
199 usec remote TCP latency over 100Mb/s   ////
ethernet.  Beat that!                     ////
-----------------------------------------////__________  o
David S. Miller, davem@caip.rutgers.edu /_____________/ / // /_/ ><
