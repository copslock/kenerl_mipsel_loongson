Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA3637582 for <linux-archive@neteng.engr.sgi.com>; Sat, 2 May 1998 18:20:24 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA18845438
	for linux-list;
	Sat, 2 May 1998 18:14:15 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA19688863
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 2 May 1998 18:14:14 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id SAA06688
	for <linux@cthulhu.engr.sgi.com>; Sat, 2 May 1998 18:14:13 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id VAA31341
	for <linux@cthulhu.engr.sgi.com>; Sat, 2 May 1998 21:14:11 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Sat, 2 May 1998 21:14:11 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: IDE device in defconfig...
Message-ID: <Pine.LNX.3.95.980502210755.4130F-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


The default config in the kernel is to enable IDE devices, which as I
found out the hard way breaks the bootup on my SGI.  Is this the default
for a reason? Do other non-SGI MIPS machines have IDE controllers?  If
not, I'd like to change this.

- Alex

-- 
Alex deVries
"romantic engsoc guy who runs marathons" - csilcock@chat.carleton.ca
http://www.engsoc.carleton.ca/~adevries/ .
