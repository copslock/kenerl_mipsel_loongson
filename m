Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA162776 for <linux-archive@neteng.engr.sgi.com>; Fri, 6 Mar 1998 11:51:39 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id LAA992134 for linux-list; Fri, 6 Mar 1998 11:49:08 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA1288416 for <linux@engr.sgi.com>; Fri, 6 Mar 1998 11:49:05 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id LAA20029
	for <linux@engr.sgi.com>; Fri, 6 Mar 1998 11:49:04 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-11.uni-koblenz.de [141.26.249.11])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id UAA14660
	for <linux@engr.sgi.com>; Fri, 6 Mar 1998 20:49:02 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id UAA25048;
	Fri, 6 Mar 1998 20:45:29 +0100
Message-ID: <19980306204529.39369@uni-koblenz.de>
Date: Fri, 6 Mar 1998 20:45:29 +0100
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: More ntp ...
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Tried xntpd the Indy as well.  Xntpd doesn't crash the box but the Indy
timekeeping is that flaky that xntpd marks all timeservers as ``insane''.

  Ralf
