Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA06204; Wed, 28 May 1997 22:57:30 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA02830 for linux-list; Wed, 28 May 1997 22:56:38 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA02823 for <linux@cthulhu.engr.sgi.com>; Wed, 28 May 1997 22:56:35 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA13504 for <linux@yon.engr.sgi.com>; Wed, 28 May 1997 22:56:07 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA02775 for <linux@yon.engr.sgi.com>; Wed, 28 May 1997 22:56:05 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id WAA24801
	for <linux@yon.engr.sgi.com>; Wed, 28 May 1997 22:56:05 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id AAA03659;
	Thu, 29 May 1997 00:48:30 -0500
Date: Thu, 29 May 1997 00:48:30 -0500
Message-Id: <199705290548.AAA03659@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux@yon.engr.sgi.com
Subject: Linux ext2fs goes multi-device :-)
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I was impressed by the extensive XFS feature list (from some comments
I read from this mailing list archives, and later from the Usenix
paper), so during the past days I coded a little extension to ext2fs
that allows a file system to be extended at runtime.

Say, you are running out of space in /home, you type:

	e2extend /home /dev/sdb1

(where /dev/sdb1 is a fresh disk ready to be used as an extension to
/home).  And poof!  instant extra space in /home.

This is from my limited understanding of the IRIX man pages describind
xlv and xfs.

Tonight this code just passed a lot of testing, I will clean it up and
post to linux-kernel soonish.

Cheers,
Miguel.
