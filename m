Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id LAA683456 for <linux-archive@neteng.engr.sgi.com>; Wed, 21 Jan 1998 11:02:44 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA19454 for linux-list; Wed, 21 Jan 1998 10:59:39 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA19396 for <linux@cthulhu.engr.sgi.com>; Wed, 21 Jan 1998 10:59:30 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA23469
	for <linux@cthulhu.engr.sgi.com>; Wed, 21 Jan 1998 10:59:27 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id NAA30513
	for <linux@cthulhu.engr.sgi.com>; Wed, 21 Jan 1998 13:59:21 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 21 Jan 1998 13:59:21 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: root-be-0.03.tar.gz
Message-ID: <Pine.LNX.3.95.980121135323.22712E-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I've uploaded root-be-0.03.tar.gz to the GettingStarted directory, and I
cleared the GettingStarted directory of older versions of root-be-0.02 and
00 (they're in the ../old directory).

This contains:
- fdisk
- mke2fs, swapon, swapoff, mkswap
- ld.so
- rpm version 2.4.12

This does not contain:
- gcc, binutils
- a lot of other stuff

I can already see some things that should go into 0.04..

Some things to work on:
- get a more modern version of vmlinux with efs for both scache'd and
  non-scache'd machines
- make Linux-installer-0.1c with root-be-0.03.tar.gz (with Mike's
  permission)
- document all this (damn, I wish I had another SCSI disk to practice
  installs)

- Alex

-- 
      Alex deVries          Run Linux on everything,
  System Administrator      run everything on Linux.
   The EngSoc Project       Send spam to spam@engsoc.carleton.ca.
