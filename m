Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA06976; Fri, 21 Jun 1996 00:49:05 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id HAA27055 for linux-list; Fri, 21 Jun 1996 07:49:00 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA27050 for <linux@cthulhu.engr.sgi.com>; Fri, 21 Jun 1996 00:48:58 -0700
Received: (from dm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id AAA06968; Fri, 21 Jun 1996 00:48:58 -0700
Date: Fri, 21 Jun 1996 00:48:58 -0700
Message-Id: <199606210748.AAA06968@neteng.engr.sgi.com>
From: "David S. Miller" <dm@neteng.engr.sgi.com>
To: wje@fir.esd.sgi.com
CC: alambie@wellington.sgi.com, linux@neteng.engr.sgi.com
In-reply-to: <199606201812.LAA24532@fir.esd.sgi.com> (wje@fir.esd.sgi.com)
Subject: Re: Kernel doesn't work on 200MHz Indy
Reply-to: dm@sgi.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   Date: Thu, 20 Jun 1996 11:12:17 -0700
   From: wje@fir.esd.sgi.com (William J. Earl)

	 There is no way the kernel could work on an R4000 or R4400
   without changes to the cache routines, as well as the addition of
   certain workarounds for processor errata.  Stick to R4600 and R5000
   processors for the time being.  I asked David to start with the
   R4600, because the workarounds for the errata are far simpler, and
   because it and the R5000 are the volume processors for Indy.  It
   will not be all that hard to add R4000 and R4400 support, but there
   are several messy workarounds to implement, so it is more
   interesting to get a complete system working on an R4600 or R5000.

Heh, I go the the UK and people are trying my kernel out all over the
place.  This is good.

I will work on the issues necessary for R4[40]00 processor support
certainly.  Take note that I worked to get a shell prompt on my target
machine "by all means necessary" as quickly as possible so that I
could have an early proof of concept to show everyone.  With this
there are some hard coded items in the tree that need to be attended
to, but I should be able to get it all to work.  One notable thing is
that machines not equipped with NEWPORT graphics cards, and instead
possess an INDY with the older EXPRESS graphics card, will not be able
to get things working until I get the serial console up or I write a
driver for the EXPRESS.  Both will happen in due time.

As you can see I am back from the UK, and will try to get back on
track this weekend.

Later,
David S. Miller
dm@sgi.com
