Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA41242 for <linux-archive@neteng.engr.sgi.com>; Sun, 28 Jun 1998 21:08:44 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA84328
	for linux-list;
	Sun, 28 Jun 1998 21:08:13 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA60456
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 28 Jun 1998 21:08:11 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id VAA06257
	for <linux@cthulhu.engr.sgi.com>; Sun, 28 Jun 1998 21:08:09 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id AAA25343
	for <linux@cthulhu.engr.sgi.com>; Mon, 29 Jun 1998 00:08:07 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Mon, 29 Jun 1998 00:08:07 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
Reply-To: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: The mouse issue...
Message-ID: <Pine.LNX.3.95.980628232855.24323A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Alright.  So I went through to see if I could locate anywhere in the
kernel where there might be problems with psaux.  I recompiled, stuck some
printk's in, and I got: Nothing.  Nadda.  Zip.  The whole machine hangs
(including num lock).

When I do a 'cat /dev/psaux', the printk's prove that the open works fine.
Then in the first read, it attempts to do a schedule().  So far, no
problem, the system is still up.  But it never comes out of the
schedule(), and a subsequent mouse input hangs the system (or the
keyboard, anyway).

Ideas? 

- Alex

-- 
Alex deVries, puffin on LinuxNet.
http://www.engsoc.carleton.ca/~adevries/ .
