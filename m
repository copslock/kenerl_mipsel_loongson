Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA162164 for <linux-archive@neteng.engr.sgi.com>; Wed, 6 May 1998 04:06:47 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA21066947
	for linux-list;
	Wed, 6 May 1998 04:06:08 -0700 (PDT)
Received: from wintermute.reading.sgi.com (wintermute.reading.sgi.com [144.253.74.171])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id EAA19827451
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 6 May 1998 04:06:06 -0700 (PDT)
Received: from localhost by wintermute.reading.sgi.com via SMTP (950413.SGI.8.6.12/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id MAA03903; Wed, 6 May 1998 12:06:03 +0100
Date: Wed, 6 May 1998 12:06:03 +0100 (BST)
From: Leon Verrall <leon@reading.sgi.com>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Missing something obvious?
Message-ID: <Pine.SGI.3.96.980506115727.3785C-100000@wintermute.reading.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hi,

Apologies for launching in with nowt but a question but I'm obviously
missing something on the SGI Linux installation...

I've downloaded a built kernel, root-be-0.03.cpio and the installer prog,
built a filesystem, got the files on etc. and can boot to single user. The
question is; "Where do I go from here?". On the one hand I have the kernel
source, a gcc RPM, glibc tarball etc. and on the other a machine with a
_bare_ bones system (i.e. won't get to init 2 as no scripts on /etc/rc2.d/,
mount fails to mount /etc/fstab entries prompting rc.sysinit hacking etc...)

Before this degenrates into whine about the maintainance/recency of info on
www.linux.sgi.com [1] some info on how to get to the next step would be well
appreciated. In fact just URLS to the right places would get me started and
leave you all to the important kernel hackery :)

Cheers for any help.

Leon


[1] If you need a maintainer for this lot then I'd be willing to give it a
shot... I did wonder if the project was dead myself.

-- 
Leon Verrall - 01189 307734  \ "Don't cut your losses too soon,
Secondline Software Support  / 'cos you'll only be cutting your throat.
Silicon Graphics, Forum 1,   \ And answer a call while you still care at all
Station Rd., Theale, RG7 4RA / 'cos nobody will if you wont" (6:00 - DT)
