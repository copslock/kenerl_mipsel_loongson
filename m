Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id BAA18048 for <linux-archive@neteng.engr.sgi.com>; Fri, 17 Jul 1998 01:10:38 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA16231
	for linux-list;
	Fri, 17 Jul 1998 01:10:04 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA30801
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 17 Jul 1998 01:09:58 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA09460
	for <linux@cthulhu.engr.sgi.com>; Fri, 17 Jul 1998 01:09:49 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id KAA01930;
	Fri, 17 Jul 1998 10:09:45 +0200 (MET DST)
Received: from aisa.fi.muni.cz (11635@aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id KAA05788;
	Fri, 17 Jul 1998 10:09:43 +0200 (MET DST)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id KAA26176;
	Fri, 17 Jul 1998 10:09:44 +0200 (MET DST)
Message-Id: <199807170809.KAA26176@aisa.fi.muni.cz>
Subject: Mouse support in 2.1.100-2
In-Reply-To: <Pine.LNX.3.95.980717012901.5792D-100000@lager.engsoc.carleton.ca> from Alex deVries at "Jul 17, 98 01:32:29 am"
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Fri, 17 Jul 1998 10:09:43 +0200 (MET DST)
Cc: linux@cthulhu.engr.sgi.com
From: Honza Pazdziora <adelton@informatics.muni.cz>
Phone: 420 (5) 415 12345
X-Mailer: ELM [version 2.4ME+ PL39 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> > - mouse doesn't work?
> 
> In the HH install, there's a package called 'kernel-2.1.100-2'.  If you
> install this, you'll have something like /boot/vmlinux-2.1.100.  That
> kernel (2.1.100) should have mouse support in it.  you'll have to make a
> symbolic link from /dev/psaux to /dev/mouse.

I'm using the new kernel but am confused about the devices. Should I have

	psaux (10/1) and mouse -> psaux ?

Here gpm fails with

	gpm: /dev/mouse: Operation not supported by device

and the same message I get then I do cat /dev/psaux.

Or
	mouse (4/64) and psaux -> mouse ?

Here gpm starts without a problem but no running cursor on the screen.

Yours,

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
                   I can take or leave it if I please
------------------------------------------------------------------------
