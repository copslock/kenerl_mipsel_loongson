Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA18602; Tue, 17 Jun 1997 09:23:56 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA19080 for linux-list; Tue, 17 Jun 1997 09:23:46 -0700
Received: from morgaine.engr.sgi.com (morgaine.engr.sgi.com [130.62.16.64]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA19070 for <linux@cthulhu.engr.sgi.com>; Tue, 17 Jun 1997 09:23:43 -0700
Received: (from offer@localhost) by morgaine.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA15059 for linux; Tue, 17 Jun 1997 09:23:13 -0700
From: offer@sgi.com (richard offer)
Message-Id: <9706170923.ZM15068@sgi.com>
Date: Tue, 17 Jun 1997 09:23:12 -0700
In-Reply-To: "David S. Miller" <davem@jenolan.rutgers.edu>
        "Re: Good news: no more begging for HW" (Jun 16, 10:01pm)
References: <199706170201.WAA00413@jenolan.caipgeneral>
X-Signature: Automatically generated by Richards Own Mail Signer (roms)
X-Home-Page: http://reality.sgi.com/offer
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: linux@morgaine.engr.sgi.com
Subject: Re: Good news: no more begging for HW
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


* $ from davem@jenolan.rutgers.edu at "16-Jun:10:01pm" | sed "1,$s/^/* /"
*
*
*    From: ariel@yon.engr.sgi.com (Ariel Faigon)
*    Date: Mon, 16 Jun 1997 18:06:41 -0700 (PDT)
*
*    I cannot promise anything since there may be some oversubscription
*    to the service :-)
*
*    I think the fairest way would be to publish all these requests on
*    this forum and have the people who care (us) vote on who should get
*    them.  I certainly don't want to be the fascist person who decides
*    who gets what.
*
* Before this gets out of control, I just want to express one sentiment
* of high caution.
*
* Although it may seem desirable to contribute most of the donation
* hardware to kernel level hackers, this can be a mistake in the making.
* At this stage in the game it is just as important to get userland/libc
* developers machines.
*
* Therefore I suggest that at least one person who knows GNU libc,
* binutils, _and_ gcc internals backwards and forwards be on the top of
* the donation list.

We need an X server if we are ever going to get it usable by real users---or is
everyone assuming its for headles machines only. I would put an X server above
most applications in terms of priority (just below native gcc/libc).

Perhaps one ought to go to Xfree86/someone who knows our hardware (not to start
this thread all over again).

This should be very tighly focused, since an X server is a lot of work and we
need a lot of them, one per board (okay in version one we could only support
1280x1024x8, but that seems a waste of all our spiffy hardware).

I used to have a contact in Xfree86, but I haven't heard from him for a while.

If someone takes the server, I'll try and get the clients libraries done
(assuming that I can get remote access to a box).

richard.

____________________________________________________________________

A Guest Signature from Laurent Duperval <Laurent at Grafnetix.com>

  I don't understand why people break up and then get back together.
  It's like going to the fridge, taking a carton of milk that has
  gone bad, then saying: "I'll put it back and see if it's better
  tomorrow."
