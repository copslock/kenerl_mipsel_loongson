Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA914104 for <linux-archive@neteng.engr.sgi.com>; Thu, 9 Apr 1998 13:13:11 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id NAA9827357
	for linux-list;
	Thu, 9 Apr 1998 13:11:11 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA3768612
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 9 Apr 1998 13:11:09 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id NAA02249
	for <linux@cthulhu.engr.sgi.com>; Thu, 9 Apr 1998 13:11:08 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id QAA32204
	for <linux@cthulhu.engr.sgi.com>; Thu, 9 Apr 1998 16:11:06 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Thu, 9 Apr 1998 16:11:06 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Ooops!
Message-ID: <Pine.LNX.3.95.980409160950.11499F-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



I've recompiled 2.1.91 without the -N flag, and the image boots.  

Now, I get an oops on bootup, here's my handdrawn facsimile of the bootup:

...
Starting kswapd v 1.5
SGI Zilog8530 serial driver version 1.00
tty00 at 0xbfbd9838 (irq = 21) is a Zilog8530
tty01 at 0xbfbd9830 (irq = 21) is a Zilog8530
Uniform CD-ROM driver Revision: 2.12
Unable to handle kernel paging request at virtual address 0000001f6, epc
== 080d6f44, ra == 880d6f4c
Ooops: 001
$0 : 00000000 1000fc01 000001f6 000000a0
$4 : 8818f1d0 000000ec 000003f6 88148190
$8 : 8bf59e20 1000fc01 00000067 00000064
$12: 00000068 80000000 40000000 000000a1
$16: 8818f1d0 000000ec 8818f1v0 00000020
$20: 40000000 8818f2fd 80000000 1000fc01
$24: 00000040 00000008
$28: 8bf58000 8bf59d98 9fc4be80 880d6f4c 
epc   : 880d6f44
Status: 1000fc03
Cause : 8000000c

My .config and System.map files are available; please mail me if you're
interested.  Some previous mails got bumped from the list because of the
total message size. 

- Alex

-- 
Alex deVries
http://www.engsoc.carleton.ca/~adevries/ .
EngSoc, US National Headquarters
