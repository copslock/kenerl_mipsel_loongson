Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA26689 for <linux-archive@neteng.engr.sgi.com>; Mon, 22 Jun 1998 06:54:04 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA93221
	for linux-list;
	Mon, 22 Jun 1998 06:53:31 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from wintermute.reading.sgi.com (wintermute.reading.sgi.com [144.253.74.171])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id GAA42129
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 22 Jun 1998 06:53:28 -0700 (PDT)
	mail_from (leon@reading.sgi.com)
Received: from localhost by wintermute.reading.sgi.com via SMTP (950413.SGI.8.6.12/911001.SGI)
	 id OAA18828; Mon, 22 Jun 1998 14:53:21 +0100
Date: Mon, 22 Jun 1998 14:53:21 +0100 (BST)
From: Leon Verrall <leon@reading.sgi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: 5.1 installation fun & games...
In-Reply-To: <m0yo2x5-000aOnC@the-village.bc.nu>
Message-ID: <Pine.SGI.3.96.980622145123.18802A-100000@wintermute.reading.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, 22 Jun 1998, Alan Cox wrote:

> > Anyway, this boots the kernel, mounts the root fs and then stops with the
> > message:
> > 
> >   Warning: unable to open an initial console
> 
> You don't have a valid "/dev" inside of /scratch/linux/installfs
> 
> Tar preserves major/minor numbers which will screw you royally across
> NFS (which doesnt). 

Hmmm. ALl of the dev devices were major/minor 0 0 so I've put them right
using the kernel device numbers list. If nfs is not passing device numbers
how exactly does this work (as it apparently does) or is this an SGI
specific NFS thing...

Leon

-- 
Leon Verrall - 01189 307734  \ "Don't cut your losses too soon,
Secondline Software Support  / 'cos you'll only be cutting your throat.
Silicon Graphics, Forum 1,   \ And answer a call while you still care at all
Station Rd., Theale, RG7 4RA / 'cos nobody will if you wont" (6:00 - DT)
