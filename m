Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA2509632 for <linux-archive@neteng.engr.sgi.com>; Sat, 25 Apr 1998 17:03:15 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA16312631
	for linux-list;
	Sat, 25 Apr 1998 17:01:46 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA16140598
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 25 Apr 1998 17:01:40 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id RAA12755
	for <linux@cthulhu.engr.sgi.com>; Sat, 25 Apr 1998 17:01:37 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id UAA11546
	for <linux@cthulhu.engr.sgi.com>; Sat, 25 Apr 1998 20:01:34 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Sat, 25 Apr 1998 20:01:33 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: gcc RPM missing crtbegin.o
Message-ID: <Pine.LNX.3.95.980425195431.4684A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hm. I've re-installed gcc from the RPM that's in the mustang directory on
linus (2.7.2-1, build date is Dec 4 03:23:00).  "Yipee", says I, "I can
now become an productive member of society". 

But, the gcc RPM doesn't have crtbegin.o, which is a bit odd.  It's not
the end of the world, I snarfed it from the cross compiling RPM for i386.
Was there a reason it wasn't included? 

I'm having some really wonky behaviour on my filesystem with .72; files
are disappearing off my filesystem left right and center.  For instance,
crtbegin.o has been on the system since I first got the machine last fall.
e2fsck's always come back clean. Now that I got my compiler working, I'm
running .1.91 again.

I also upgraded to the glibc 2.0.7 RPMs, which seems to have messed up
tcsh.  It'd be real nice to get gdb and/or strace working to debug things
like this.

- Alex

-- 
Alex deVries
""romantic engsoc guy who runs marathons" - csilcock@chat.carleton.ca
http://www.engsoc.carleton.ca/~adevries/ .
