Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA07030; Wed, 9 Apr 1997 11:33:01 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA07945 for linux-list; Wed, 9 Apr 1997 11:31:24 -0700
Received: from ares.esd.sgi.com (fddi-ares.engr.sgi.com [192.26.80.60]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA07924 for <linux@cthulhu.engr.sgi.com>; Wed, 9 Apr 1997 11:31:19 -0700
Received: from fir.esd.sgi.com by ares.esd.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/950213.SGI.AUTOCF)
	 id LAA20788; Wed, 9 Apr 1997 11:31:04 -0700
Received: (from wje@localhost) by fir.esd.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id LAA27695; Wed, 9 Apr 1997 11:31:04 -0700
Date: Wed, 9 Apr 1997 11:31:04 -0700
Message-Id: <199704091831.LAA27695@fir.esd.sgi.com>
From: "William J. Earl" <wje@fir.esd.sgi.com>
To: Martin Knoblauch <knobi@munich.sgi.com>
Cc: Alistair Lambie <alambie@wellington.sgi.com>,
        Mike Shaver <shaver@neon.ingenia.ca>, linux@cthulhu.engr.sgi.com
Subject: Re: init=/bin/sh and serial devices
In-Reply-To: <334B3FF5.41C6@munich.sgi.com>
References: <199704090209.WAA06281@neon.ingenia.ca>
	<9704091424.ZM9048@windy.wellington.sgi.com>
	<334B3FF5.41C6@munich.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Martin Knoblauch writes:
...
 >  this brings up the question: do we already have drivers for
 > the textport? Not to speak of an X-Server? How are we (SGI)
 > going to handle this? As far as I know we never published
 > the hardware dependent parts on the X11 distribution, did we?
...

    With management authorization, I provided the technical details
for the graphics hardware (and all the other Indy hardware) to David
Miller, who I believe got a textport driver working.
