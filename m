Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA05758 for <linux-archive@neteng.engr.sgi.com>; Thu, 3 Dec 1998 09:51:59 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA68542
	for linux-list;
	Thu, 3 Dec 1998 09:51:00 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA13735
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 3 Dec 1998 09:50:58 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA03306
	for <linux@cthulhu.engr.sgi.com>; Thu, 3 Dec 1998 09:50:54 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id MAA03053
	for <linux@cthulhu.engr.sgi.com>; Thu, 3 Dec 1998 12:56:34 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Thu, 3 Dec 1998 12:56:34 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: proper glibc source rpms.
Message-ID: <Pine.LNX.3.96.981203125302.2882A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


The GPL gods will now be a little happier with me.

The glibc source rpm distributed with Rough Cuts was actually defective,
and wouldn't let you unpack the entire source.  The actual story of how
this came about is best shared over a lot of beer.

In any case, there are replacement binary and source rpms of glibc in
ftp://ftp.linux.sgi.com/pub/test now.

- Alex

-- 
Alex deVries, puffin on LinuxNet.
I know exactly what I want in life.
