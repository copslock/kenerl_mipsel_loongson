Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA33153 for <linux-archive@neteng.engr.sgi.com>; Tue, 26 Jan 1999 21:11:33 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA60774
	for linux-list;
	Tue, 26 Jan 1999 21:10:53 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA58103
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 26 Jan 1999 21:10:51 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id VAA02375
	for <linux@cthulhu.engr.sgi.com>; Tue, 26 Jan 1999 21:10:50 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id AAA08059
	for <linux@cthulhu.engr.sgi.com>; Wed, 27 Jan 1999 00:12:26 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 27 Jan 1999 00:12:26 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: HAL code in the kernel...
Message-ID: <Pine.LNX.3.96.990127000802.20119E-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


So, I've merged Ulf's HAL code; I know it's not working at all yet, but
putting it into CVS is the only way to work on it jointly.

It'll build as a module or right into the kernel; it's a development
option in the new category "SGI Devices".  All the code's in
drivers/sgi/audio (no, not drivers/sgi/char).  Modules get installed in
/lib/modules/%version/misc.

I'm pretty sure Mike Shaver and Ariel could hear me screaming at CVS from
California. 

So far, the total output of the driver is:

hal2: rev: 4010
hal2: there was no device?
sgiaudio: unable to find hal2 subsystem

Clearly there's work to be done. 

- Alex


-- 
Alex deVries, puffin on LinuxNet.
I know exactly what I want in life.
