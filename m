Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA292887 for <linux-archive@neteng.engr.sgi.com>; Mon, 6 Apr 1998 12:40:14 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id MAA8065684
	for linux-list;
	Mon, 6 Apr 1998 12:37:54 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA8477750
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 6 Apr 1998 12:37:52 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id MAA15873
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Apr 1998 12:37:50 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id PAA03385
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Apr 1998 15:37:49 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Mon, 6 Apr 1998 15:37:49 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Stuff I'm looking for. 
Message-ID: <Pine.LNX.3.95.980406153705.19893Q-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Some weirdness happened to my subscription to the mailing list; here's my
mail from yesterday.

-- 
Alex deVries
http://www.engsoc.carleton.ca/~adevries/ .
EngSoc, US National Headquarters

---------- Forwarded message ----------
Date: Sun, 5 Apr 1998 18:25:37 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Stuff I'm looking for.



I'm interested in finding the following things, before I invest time in
recreating them:

1. XFree stuff.
Somewhere, somehow, I picked up a copy of /usr/X11R6/lib/libXaw.so.6.1,
but I no longer remember who compiled it for SGI/Linux. Alan, maybe? In
any case, when I try to run 'xterm' (which came in the same tarball,
IIRC), I get a:
libXaw.so.6: cannot open shared object file: No such file or directory

although the file exists.

Does anyone have source patched I could turn into an RPM, or is this all
pretty much just from the source?

2. binutils

I think my sdb has taken a bit of a crash, since I can compile properly
only at certain times of the day.  Is there a binutils RPM out there
anywhere, and if not, can people tell me a list of the required patches
and latest version?

Other notes:
- When rpm 2.5 comes out later this week (possibly today), it'll have the
problems with mipseb/mipsel sorted out.  Eventually all the RPMs on Linus
in the mipsel are going to have to be replaced with repackaged ones.  When
RedHat 5.1 comes out (my guess: early next month), I'll compile the mipseb
packages.  In any case, I'll get mipsel RPMs out when 2.5 comes out for
easy upgrading.

- I'm going to be in Raleigh-Durham for LinuxExpo May 28-30.  Is there any
chance of us having an informal get together? 

- Alex

-- 
Alex deVries
http://www.engsoc.carleton.ca/~adevries/ .
EngSoc, US National Headquarters
