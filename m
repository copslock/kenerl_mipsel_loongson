Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA07496; Tue, 8 Apr 1997 19:23:41 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA08356 for linux-list; Tue, 8 Apr 1997 19:23:04 -0700
Received: from soyuz.wellington.sgi.com (soyuz.wellington.sgi.com [134.14.64.194]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA08343 for <linux@engr.sgi.com>; Tue, 8 Apr 1997 19:23:00 -0700
Received: from windy.wellington.sgi.com by soyuz.wellington.sgi.com via ESMTP (940816.SGI.8.6.9/940406.SGI)
	 id OAA28865; Wed, 9 Apr 1997 14:22:46 +1200
Received: (alambie@localhost) by windy.wellington.sgi.com (950413.SGI.8.6.12/8.6.9) id OAA09761; Wed, 9 Apr 1997 14:22:46 +1200
From: "Alistair Lambie" <alambie@wellington.sgi.com>
Message-Id: <9704091422.ZM9856@windy.wellington.sgi.com>
Date: Wed, 9 Apr 1997 14:22:45 +0000
In-Reply-To: Mike Shaver <shaver@neon.ingenia.ca>
        "init=/bin/sh and serial devices" (Apr  9,  2:12pm)
References: <199704090209.WAA06281@neon.ingenia.ca>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: Mike Shaver <shaver@neon.ingenia.ca>
Subject: Re: init=/bin/sh and serial devices
Cc: linux@cthulhu.engr.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Apr 9,  2:12pm, Mike Shaver wrote:
> Subject: init=/bin/sh and serial devices
> Wierd stuff here.
> We've got it mountinng the NFS partition and running /bin/sh, but we
> can't type anything to it at that point.
> It's kinda weird, because we see the `#' prompt, but stuff I type to
> it isn't registering.
>
> stdin in /dev/cua1, FWIW.
>

Try 'init=/bin/sh </dev/cua1 >/dev/cua1'.  I seem to remember you need that.
Sorry all this seems to be coming piece meal, but it's been a long time since I
have run it up, and you kind of forget some of the details till you are
reminded!

Cheers, Alistair

-- 
Alistair Lambie					    alambie@wellington.sgi.com
Silicon Graphics New Zealand				  SGI Voicemail: 56791
Level 5, Walsh Wrightson Tower,				    Ph: +64-4-802 1455
94-96 Dixon St, Wellington, NZ			  	   Fax: +64-4-802 1459
