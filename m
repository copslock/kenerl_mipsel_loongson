Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA19706 for <linux-archive@neteng.engr.sgi.com>; Tue, 12 May 1998 21:38:47 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA23992709
	for linux-list;
	Tue, 12 May 1998 21:37:14 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA23987126
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 12 May 1998 21:37:11 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id VAA25848
	for <linux@cthulhu.engr.sgi.com>; Tue, 12 May 1998 21:37:10 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id AAA20572
	for <linux@cthulhu.engr.sgi.com>; Wed, 13 May 1998 00:37:08 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 13 May 1998 00:37:08 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Installer changes...
Message-ID: <Pine.LNX.3.95.980513003341.15722A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


As per Mike Shaver's suggestions, I've made some changes to root-be (now
version 0.04), which affects Linux-installer (now version 0.2).  The
changes listed are below. Tehy're all in teh GettingStarted directory.

root-be chnages include adding ftp, libncurses and /etc/protocols,
/etc/services and /etc/termcap.

There's also now a script in /etc/rc.d which creates new sd* devices if
they aren't created already.

- Alex

This is a package to install SGI/Linux from within Irix.

Changes
-------
0.2 May 13 1998
Alex deVries <adevries@engsoc.carleton.ca>
- fixed some things in root-be, including a script to create /dev/sd*
  devices on bootup
- fixed some INSTALL documentation
