Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA81813 for <linux-archive@neteng.engr.sgi.com>; Mon, 8 Feb 1999 16:51:32 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA14175
	for linux-list;
	Mon, 8 Feb 1999 16:50:09 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA13688
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 8 Feb 1999 16:50:07 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA04230
	for <linux@cthulhu.engr.sgi.com>; Mon, 8 Feb 1999 16:50:04 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id TAA26281
	for <linux@cthulhu.engr.sgi.com>; Mon, 8 Feb 1999 19:53:27 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Mon, 8 Feb 1999 19:53:26 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: newport stuff.
Message-ID: <Pine.LNX.3.96.990208190624.11444G-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Alright.  I've read a lot of code.  Here's my current take on it.

The goal is to get /dev/graphics to work.  It seems to me that we already
have an excellent start to the newport interface in newport_cons.c, and we
need that functionality for both newport graphics and newport console.

Are there objctions to me stripping out functionality from the very
excellent newport_cons.c and putting it into newport.c so I can use it
from graphics. as well?

- A

-- 
Alex deVries, puffin on LinuxNet.
I know exactly what I want in life.
