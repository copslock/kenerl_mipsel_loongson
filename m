Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA48074 for <linux-archive@neteng.engr.sgi.com>; Sat, 23 Jan 1999 18:24:06 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA60026
	for linux-list;
	Sat, 23 Jan 1999 18:23:32 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA81451
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 23 Jan 1999 18:23:28 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id VAA01493
	for <linux@cthulhu.engr.sgi.com>; Sat, 23 Jan 1999 21:23:26 -0500 (EST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id VAA19550
	for <linux@cthulhu.engr.sgi.com>; Sat, 23 Jan 1999 21:24:33 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Sat, 23 Jan 1999 21:24:33 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Modutils
Message-ID: <Pine.LNX.3.96.990123212234.19494A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Okay, I've rebuilt the modutils RPM with the latest 2.1.121 source patches
in it for mips; the mipseb binary rpm is in:

ftp://linus.linux.sgi.com/pub/linux/mips/hardhat/5.2/RPMS/mipseb/modutils-2.1.121-4.mipseb.rpm

or similiar.

This'll make the modules in the precompiled binary package actually work. 
Please, use this one if for no other reason than just to test it. 

There's a lot of untested stuff in that 5.2 directory, be warned.

- Alex

-- 
Alex deVries, puffin on LinuxNet.
I know exactly what I want in life.
