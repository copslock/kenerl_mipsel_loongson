Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA26367 for <linux-archive@neteng.engr.sgi.com>; Mon, 22 Jun 1998 08:13:17 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA81030
	for linux-list;
	Mon, 22 Jun 1998 08:12:42 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from wintermute.reading.sgi.com (wintermute.reading.sgi.com [144.253.74.171])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id IAA95779
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 22 Jun 1998 08:12:40 -0700 (PDT)
	mail_from (leon@reading.sgi.com)
Received: from localhost by wintermute.reading.sgi.com via SMTP (950413.SGI.8.6.12/911001.SGI)
	 id QAA20054; Mon, 22 Jun 1998 16:12:32 +0100
Date: Mon, 22 Jun 1998 16:12:32 +0100 (BST)
From: Leon Verrall <leon@reading.sgi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: 5.1 installation fun & games...
In-Reply-To: <m0yo7MG-000aOnC@the-village.bc.nu>
Message-ID: <Pine.SGI.3.96.980622161123.20040A-100000@wintermute.reading.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, 22 Jun 1998, Alan Cox wrote:

> > Hmmm. ALl of the dev devices were major/minor 0 0 so I've put them right
> > using the kernel device numbers list. If nfs is not passing device numbers
> > how exactly does this work (as it apparently does) or is this an SGI
> > specific NFS thing...
> 
> Linux device numbers are major<<8|minor, SGI ones are split on a 
> different boundary. NFSv2 doesnt indicate the boundary - so device
> 2,0 on linux may appear as 0,512 on Irix.

Ah, a chicken and egg thing. You can nfsroot an SG linux box as long as you
have a linux box to do it from...

Leon

-- 
Leon Verrall - 01189 307734  \ "Don't cut your losses too soon,
Secondline Software Support  / 'cos you'll only be cutting your throat.
Silicon Graphics, Forum 1,   \ And answer a call while you still care at all
Station Rd., Theale, RG7 4RA / 'cos nobody will if you wont" (6:00 - DT)
