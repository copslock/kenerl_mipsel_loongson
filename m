Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA01001; Wed, 9 Apr 1997 19:33:00 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA20051 for linux-list; Wed, 9 Apr 1997 19:32:22 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA20038 for <linux@relay.engr.SGI.COM>; Wed, 9 Apr 1997 19:32:19 -0700
Received: from caipfs.rutgers.edu (caipfs.rutgers.edu [128.6.19.100]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id TAA21751 for <linux@relay.engr.SGI.COM>; Wed, 9 Apr 1997 19:32:03 -0700
Received: from jenolan.caipgeneral (jenolan.rutgers.edu [128.6.111.5])
	by caipfs.rutgers.edu (8.8.5/8.8.5) with SMTP id WAA02536;
	Wed, 9 Apr 1997 22:27:33 -0400 (EDT)
Received: by jenolan.caipgeneral (SMI-8.6/SMI-SVR4)
	id WAA01960; Wed, 9 Apr 1997 22:26:18 -0400
Date: Wed, 9 Apr 1997 22:26:18 -0400
Message-Id: <199704100226.WAA01960@jenolan.caipgeneral>
From: "David S. Miller" <davem@jenolan.rutgers.edu>
To: shaver@neon.ingenia.ca
CC: linux@cthulhu.engr.sgi.com
In-reply-to: <199704100211.WAA16857@neon.ingenia.ca> (message from Mike Shaver
	on Wed, 9 Apr 1997 22:11:01 -0400 (EDT))
Subject: Re: all in the family
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   From: Mike Shaver <shaver@neon.ingenia.ca>
   Date: Wed, 9 Apr 1997 22:11:01 -0400 (EDT)

   Looks like I may be getting a machine here to see if we can migrate
   some of our non-Oracle machines to Linux/SPARC.

   Anyone know if the emulation is up to hosting the Linux/Indy
   cross-compiler?

It should be straight forward, 32-bit to 32-bit crosses under gcc work
flawlessly right out of the box for everything I've ever tried.  It's
when you cross from 32-bit to 64-bit that you may hit a bug or two.

   In related news, we'll then have Linux running on 5 architectures
   in the same room (Intel, Alpha, SPARC, ELKS, Indy).  Maybe I'll
   steal the PowerMac too... =)

ELKS, that is cheating ;-)

---------------------------------------------////
Yow! 11.26 MB/s remote host TCP bandwidth & ////
199 usec remote TCP latency over 100Mb/s   ////
ethernet.  Beat that!                     ////
-----------------------------------------////__________  o
David S. Miller, davem@caip.rutgers.edu /_____________/ / // /_/ ><
