Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA30396 for <linux-archive@neteng.engr.sgi.com>; Mon, 22 Jun 1998 09:19:43 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA61723
	for linux-list;
	Mon, 22 Jun 1998 09:18:45 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from wintermute.reading.sgi.com (wintermute.reading.sgi.com [144.253.74.171])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id JAA64797
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 22 Jun 1998 09:18:42 -0700 (PDT)
	mail_from (leon@reading.sgi.com)
Received: from localhost by wintermute.reading.sgi.com via SMTP (950413.SGI.8.6.12/911001.SGI)
	 id RAA20812; Mon, 22 Jun 1998 17:18:33 +0100
Date: Mon, 22 Jun 1998 17:18:33 +0100 (BST)
From: Leon Verrall <leon@reading.sgi.com>
Reply-To: Leon Verrall <leon@reading.sgi.com>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alex deVries <adevries@engsoc.carleton.ca>
Subject: Re: 5.1 installation fun & games...
In-Reply-To: <Pine.LNX.3.95.980622112953.26734B-100000@lager.engsoc.carleton.ca>
Message-ID: <Pine.SGI.3.96.980622170727.20701A-100000@wintermute.reading.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, 22 Jun 1998, Alex deVries wrote:

> On Mon, 22 Jun 1998, Leon Verrall wrote:
> > Ah, a chicken and egg thing. You can nfsroot an SG linux box as long as you
> > have a linux box to do it from...
> 
> Assuming that people have an i386/Linux box kicking around may be an
> invalid assumption.

It is in my office :(

> The Real Solution to this is to get initrds working, so that you don't
> have to have any other machine to boot from, just a local Irix filesystem. 
> Leon, in time this will all be taken care of. 

Well Irix (6.2 at least) uses 14 bits for the major device number and 18 for
minor. This works out to be 256 for a linux major of 4 and 64 for a linux
major of 1 (I think). And *drumroll* it still didn't work... Ho hum.

Leon

-- 
Leon Verrall - 01189 307734  \ "Don't cut your losses too soon,
Secondline Software Support  / 'cos you'll only be cutting your throat.
Silicon Graphics, Forum 1,   \ And answer a call while you still care at all
Station Rd., Theale, RG7 4RA / 'cos nobody will if you wont" (6:00 - DT)
