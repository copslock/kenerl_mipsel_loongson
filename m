Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA3537314 for <linux-archive@neteng.engr.sgi.com>; Fri, 1 May 1998 11:21:30 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA18970782
	for linux-list;
	Fri, 1 May 1998 11:20:34 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA18951031
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 1 May 1998 11:20:31 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id LAA07826
	for <linux@cthulhu.engr.sgi.com>; Fri, 1 May 1998 11:20:24 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id OAA27719
	for <linux@cthulhu.engr.sgi.com>; Fri, 1 May 1998 14:20:22 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Fri, 1 May 1998 14:20:22 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Hanging.
Message-ID: <Pine.LNX.3.95.980501141729.22853C-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


This is a bit weird.   Once every 30 minutes or so, my Indy just sits
there and hangs.  Num lock will work, it'll ping, but there'll be no error
messages, and the system's useless.  After about 10 minutes of this, it'll
wake up as if nothing had happened.

This is with 2.1.91.

Ideas? My initial suspicion is my SCSI bus, although I'm getting no kernel
errors at all. 

- Alex

-- 
Alex deVries
"romantic engsoc guy who runs marathons" - csilcock@chat.carleton.ca
http://www.engsoc.carleton.ca/~adevries/ .
