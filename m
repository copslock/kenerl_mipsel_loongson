Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id UAA15674 for <linux-archive@neteng.engr.sgi.com>; Fri, 5 Feb 1999 20:02:37 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA95981
	for linux-list;
	Fri, 5 Feb 1999 20:02:00 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA95368
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 5 Feb 1999 20:01:58 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA03781
	for <linux@cthulhu.engr.sgi.com>; Fri, 5 Feb 1999 20:01:55 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id XAA02026
	for <linux@cthulhu.engr.sgi.com>; Fri, 5 Feb 1999 23:05:00 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Fri, 5 Feb 1999 23:05:00 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Graphics as a module.
Message-ID: <Pine.LNX.3.96.990205230053.26740A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



I've gotten partway through having modularized the newport graphics.  This
is in hopes of:
- one day finishing it, so you can pleasantly load and unload graphics
  modules without regard to rebooting while debugging
- giving Mike a kick in the pants to help me out wiwth the hard stuff

I know there's some weirdness; I'd strongly suggest you not build it as a
module unless you're after fixing it.  It seems to OOPS partway into
loading userland stuff.  The report inidicates it is somewher ein tcp
code, which makes no sense.

Anyway. Here goes nothing.

- Alex

-- 
Alex deVries, puffin on LinuxNet.
I know exactly what I want in life.
