Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id MAA497299 for <linux-archive@neteng.engr.sgi.com>; Wed, 25 Feb 1998 12:57:21 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA04830 for linux-list; Wed, 25 Feb 1998 12:55:55 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA04819 for <linux@engr.sgi.com>; Wed, 25 Feb 1998 12:55:54 -0800
Received: from seaside2.varberg.se (mail.varberg.se [193.13.151.101]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id MAA25537
	for <linux@engr.sgi.com>; Wed, 25 Feb 1998 12:55:53 -0800
	env-from (grimsy@seaside.se)
Received: from calypso.saturn (grimsy@dialup178-4-45.swipnet.se [130.244.178.237]) by seaside2.varberg.se (8.8.5/8.6.9) with SMTP id VAA12103 for <linux@engr.sgi.com>; Wed, 25 Feb 1998 21:01:30 GMT
Date: Wed, 25 Feb 1998 21:57:43 +0100 (CET)
From: Ulf Carlsson <grimsy@varberg.se>
X-Sender: grimsy@calypso.saturn
To: linux@cthulhu.engr.sgi.com
Subject: installation problem.
Message-ID: <Pine.LNX.3.96.980225215717.970B-100000@calypso.saturn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hello, sorry that I'm asking.. don't know if this is a support mailing
list.
I have been trying to install linux on my indy today. First I tried to use
the ext2 partition, /dev/sdb1, with no success. THe kernel says:

sdb : sector size 0 reperted, assuming 512.
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 1  [0 MB] [0.0 GB]

I did mke2fs as the documentation told me and that one succeded. How do I
setup the partittion table?
Well. I tested NFS instead and that worked atleast better. I could mount
root filesystem over nfs. But here is some strange errors I get:

VFS: Mounted root(nfs filesystem).
Unable to handle kernel paging request at virtual address 00010005, epc ==
8804d248, ra == 8804d514
Warning: bad magic number for tty struct (04:00) in release_dev

When I press enter, I get this:

Unable to handle kernel paging request at virtual address 00000000, epc ==
880c8730, ra == 880c8700
Aiee, killing interrupt handler

And after that is the computer (ofcourse) absolutely dead.

I'm using kernel 2.1.55 (from linux.sgi.com). Are there any newer versions
of the kernel (precompiled)? Do you recommend me to download the
crosscompile package and compile 2.1.88? Or, can't someone send me a
better kernel, or tell me where to get it (support for IRIX file system
doesn't matter)?

Best regards,
Ulf Carlsson.

-----------------------------------------
-     grimsy - http://grimsy.ml.org     -
-----------------------------------------
