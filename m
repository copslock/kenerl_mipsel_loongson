Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA3535852 for <linux-archive@neteng.engr.sgi.com>; Fri, 1 May 1998 11:45:49 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA19050570
	for linux-list;
	Fri, 1 May 1998 11:44:01 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA19117977
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 1 May 1998 11:43:57 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id LAA16804
	for <linux@cthulhu.engr.sgi.com>; Fri, 1 May 1998 11:43:31 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id OAA28291
	for <linux@cthulhu.engr.sgi.com>; Fri, 1 May 1998 14:43:08 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Fri, 1 May 1998 14:43:08 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: setting default boot image in nvram.
Message-ID: <Pine.LNX.3.95.980501143954.22853D-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


How do I set my default boot image in nvram WITH a boot disk option?

See, normally, you can just pass "root=/dev/sdb1" to the kernel on the
command line, but that's 14 chars, and the OSLoadOptions only has room for
12. 

Hm.  Perhaps we should get rdev-like stuff running.

?

-- 
Alex deVries
"romantic engsoc guy who runs marathons" - csilcock@chat.carleton.ca
http://www.engsoc.carleton.ca/~adevries/ .
