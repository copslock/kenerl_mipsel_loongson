Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA12838; Wed, 25 Jun 1997 14:07:29 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA23922 for linux-list; Wed, 25 Jun 1997 14:07:13 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA23851 for <linux@engr.sgi.com>; Wed, 25 Jun 1997 14:07:02 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA26426
	for <linux@engr.sgi.com>; Wed, 25 Jun 1997 14:06:41 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id XAA06108; Wed, 25 Jun 1997 23:06:00 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199706252106.XAA06108@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id XAA24520; Wed, 25 Jun 1997 23:05:56 +0200
Subject: State of the kernel
To: linux@cthulhu.engr.sgi.com
Date: Wed, 25 Jun 1997 23:05:54 +0200 (MET DST)
Cc: tsbogend@alpha.franken.de
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

with today's commits into the CVS archive the kernel is slowly becoming
useable again after the SGI source merge.  The major remaining bug for
now is that network applications (mount -t nfs, telnet ...) still seem
not to work.  I was able to rebuild some of the standard utilities
native running Linux 2.1.43 and glibc 2.0.4 without problems, so we're
coming closer.

Aside of the mentioned networking bug next on my list is packaging a
couple of binaries so that you people out there can begin to use
Linux a little bit.

  Ralf
