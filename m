Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id XAA66125 for <linux-archive@neteng.engr.sgi.com>; Thu, 2 Jul 1998 23:48:10 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id XAA45203
	for linux-list;
	Thu, 2 Jul 1998 23:47:43 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id XAA42977
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 2 Jul 1998 23:47:40 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id XAA07364
	for <linux@cthulhu.engr.sgi.com>; Thu, 2 Jul 1998 23:47:39 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id CAA26883
	for <linux@cthulhu.engr.sgi.com>; Fri, 3 Jul 1998 02:47:38 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Fri, 3 Jul 1998 02:47:38 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: initrd...
Message-ID: <Pine.LNX.3.95.980703024308.19406E-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Well, the good news is that I can now convince the kernel to load an
initrd.  The bad news is that I ended up hardcoding the ramdisk into the
kernel.  Bleah. 

It wasa bit weird to have to override the error detection mechanism that
prevents you from mounting a ramdisk that is within kernel space (so that
you can't write on top of th ekernel).

Anyway, this means that in theory we should be able to get the install to
work:
- on a machine with Irix
- on a machine without Irix, but with another machine

This also opens up the possibility of things like an FTP install. 

In my mind that expands the number of installations considerably.

As I said, this is a huge hack; this is only meant for the installer.

- Alex

-- 
Alex deVries, puffin on LinuxNet.
http://www.engsoc.carleton.ca/~adevries/ .
