Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA126308 for <linux-archive@neteng.engr.sgi.com>; Fri, 6 Mar 1998 08:50:46 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id IAA891101 for linux-list; Fri, 6 Mar 1998 08:50:06 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA1210622 for <linux@engr.sgi.com>; Fri, 6 Mar 1998 08:50:04 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id IAA06650
	for <linux@engr.sgi.com>; Fri, 6 Mar 1998 08:50:02 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-14.uni-koblenz.de [141.26.249.14])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id RAA07602
	for <linux@engr.sgi.com>; Fri, 6 Mar 1998 17:50:00 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id RAA24674;
	Fri, 6 Mar 1998 17:46:06 +0100
Message-ID: <19980306174605.00092@uni-koblenz.de>
Date: Fri, 6 Mar 1998 17:46:05 +0100
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: xntp
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Don't run xntpd; there is some bug in the MIPS stuff which locks the
machine, only the usual kernel hotkeys are still working.  I don't
know why or if all platforms are affected.  The crash happend on a
RM200.  The time code is ripe for a complete overhaul anyway ...

  Ralf
