Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA02981; Sat, 5 Jul 1997 14:18:32 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA23570 for linux-list; Sat, 5 Jul 1997 14:09:48 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA23564 for <linux@engr.sgi.com>; Sat, 5 Jul 1997 14:09:45 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA10872
	for <linux@engr.sgi.com>; Sat, 5 Jul 1997 14:09:35 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from flake (ralf@flake.uni-koblenz.de [141.26.4.37]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id XAA12388; Sat, 5 Jul 1997 23:09:28 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199707052109.XAA12388@informatik.uni-koblenz.de>
Received: by flake (SMI-8.6/KO-2.0)
	id XAA04475; Sat, 5 Jul 1997 23:09:22 +0200
Subject: GCC bug
Date: Sat, 5 Jul 1997 23:09:21 +0200 (MET DST)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Apparently-To: <linux@cthulhu.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

the most current GCC package installs the header file assert.h although
it shouldn't.  The problem is that the GCC version of assert.h will
not include <gnu/stubs.h> but autoconf generated configure scripts
rely on that.  If you ever wondered why loading programs caused warnings
like 'the function lchown is not implemented and will always fail', this
is caused by the wrong assert.h.

Quick fix: rm <prefix>/<target>/include/assert.h, for example.
rm /usr/local/mipsel-linux/include/assert.h.  Note that this applies
to both native and crosscompilers.  None of them will install the
assert.h file in /usr/include/.

  Ralf
