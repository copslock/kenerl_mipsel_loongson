Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA20096; Wed, 9 Apr 1997 00:08:12 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id AAA15795 for linux-list; Wed, 9 Apr 1997 00:07:03 -0700
Received: from sgiger.munich.sgi.com (sgiger.munich.sgi.com [144.253.192.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA15772 for <linux@cthulhu.engr.sgi.com>; Wed, 9 Apr 1997 00:06:57 -0700
Received: from knobi.munich.sgi.com by sgiger.munich.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1502/940406.SGI)
	 id JAA03892; Wed, 9 Apr 1997 09:06:33 +0200
Received: from knobi (localhost [127.0.0.1]) by knobi.munich.sgi.com (950413.SGI.8.6.12/951220.SGI.AUTOCF.knobi) via SMTP id JAA19306; Wed, 9 Apr 1997 09:06:30 +0200
Message-ID: <334B3FF5.41C6@munich.sgi.com>
Date: Wed, 09 Apr 1997 09:06:29 +0200
From: Martin Knoblauch <knobi@munich.sgi.com>
Organization: Silicon Graphics GmbH, Am-Hochacker 3, D-85630 Grasbrunn
X-Mailer: Mozilla 3.01SGoldC-SGI (X11; I; IRIX 6.3 IP22)
MIME-Version: 1.0
To: Alistair Lambie <alambie@wellington.sgi.com>
CC: Mike Shaver <shaver@neon.ingenia.ca>, linux@cthulhu.engr.sgi.com
Subject: Re: init=/bin/sh and serial devices
References: <199704090209.WAA06281@neon.ingenia.ca> <9704091424.ZM9048@windy.wellington.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alistair Lambie wrote:
> 
> On Apr 9,  2:12pm, Mike Shaver wrote:
> > Subject: init=/bin/sh and serial devices
> > Wierd stuff here.
> > We've got it mountinng the NFS partition and running /bin/sh, but we
> > can't type anything to it at that point.
> > It's kinda weird, because we see the `#' prompt, but stuff I type to
> > it isn't registering.
> >
> > stdin in /dev/cua1, FWIW.
> >
> 
> Does your Indy not have a 'head' on it....why are you using
> the serial ports..
>

 this brings up the question: do we already have drivers for
the textport? Not to speak of an X-Server? How are we (SGI)
going to handle this? As far as I know we never published
the hardware dependent parts on the X11 distribution, did we?

Martin 
-- 
+---------------------------------+-----------------------------------+
|Martin Knoblauch                 | Silicon Graphics GmbH             |
|Manager Technical Marketing      | Am Hochacker 3 - Technopark       |
|Silicon Graphics Computer Systems| D-85630 Grasbrunn-Neukeferloh, FRG|
|---------------------------------| Phone: (+int) 89 46108-179 or -0  |
|http://reality.sgi.com/knobi     | Fax:   (+int) 89 46107-179        |
+---------------------------------+-----------------------------------+
|e-mail: <knobi@munich.sgi.com>   | VM: 6-333-8197 | M/S: IDE-3150    |
+---------------------------------------------------------------------+
