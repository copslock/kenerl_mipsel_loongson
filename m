Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id AAA15114 for <linux-archive@neteng.engr.sgi.com>; Thu, 28 Jan 1999 00:03:52 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA22403
	for linux-list;
	Thu, 28 Jan 1999 00:03:10 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA95995
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 28 Jan 1999 00:03:06 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA02298
	for <linux@cthulhu.engr.sgi.com>; Thu, 28 Jan 1999 00:03:05 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id DAA06026
	for <linux@cthulhu.engr.sgi.com>; Thu, 28 Jan 1999 03:04:52 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Thu, 28 Jan 1999 03:04:52 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Problems modularizing newport graphics.
Message-ID: <Pine.LNX.3.96.990128025217.25641P-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



Alright.  I know this sounds a bit weird, but I'm trying to modularize
graphics.o.  Why? So we can debug newport graphics properly.

Just so people know where things are at; the drawbars in the XFree tree in
CVS doesn't do a thing; there's an issue with the ioctl handling in
drivers/sgi/char/graphics.c .

So, to avoid having to reboot every 5 minutes I'm trying to make graphics
loadable and unloadable.  This'd be good for all of you who have no
graphics.  Same with keyboard support, but that's another story.

So, the kernel now builds without graphics.o.  Not terribly difficult.

But when I try to insert the module:

[root@black char]# /sbin/insmod  /lib/modules/2.1.131/misc/graphics.o 
/lib/modules/2.1.131/misc/graphics.o: couldn't find the kernel version the
module was compiled for

I know this kernel was built for this kernel.  Using -f doesn't help.

I notice all the modules have a symbol in their nm output called
__module_kernel_version.  graphics.o does not.  How does this get added?

Please?

I'm tempted to commit my code because graphics.c wasn't working anyway.

- Alex

-- 
Alex deVries, puffin on LinuxNet.
I know exactly what I want in life.
