Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA01307; Fri, 4 Jul 1997 03:45:02 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id DAA20735 for linux-list; Fri, 4 Jul 1997 03:44:39 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA20730 for <linux@engr.sgi.com>; Fri, 4 Jul 1997 03:44:36 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id DAA03941
	for <linux@engr.sgi.com>; Fri, 4 Jul 1997 03:38:55 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id MAA08613; Fri, 4 Jul 1997 12:33:23 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199707041033.MAA08613@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id MAA18563; Fri, 4 Jul 1997 12:33:21 +0200
Subject: Status ...
Date: Fri, 4 Jul 1997 12:33:20 +0200 (MET DST)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Apparently-To: <linux@cthulhu.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

with my recent bug fixes the kernel/libc becomes again stable
enough to carry a reasonable userland.  I spent last night rebuilding
alot of RPM packages from RedBat 4.2.  Many of them built fine without
changes.  Top problems which prevented rebuilding I found are

 - bugs in the new VFS layer of 2.1.43
 - patch + glibc don't seem to work too well

(These two are the most annoying)

 - We don't have yet a (reliable) port of X.  Miguel de Icaza is working
   on that, especially on a X server for the Indy.
 - Neither RedHat nor any of the other availble distributions has a
   concept of bootstrapping out on a system where almost nothing is
   installed.  So it's an annoying game to find out which packages
   to build in which order ...
 - Static linking is currently broken.  Still many people use it as part
   of some kind of safety concept not noticing that a large fraction
   of userland programs will pull in the shared libraries vi the NSS
   mechanism anyway ...
 - On some configurations we still have problems with bad UDP/IP packets.
   This though I fixed a couple of endian bugs in the checksum code
   during the last days.  Right now it seems that the Indy and M700 (using
   NE2000) are not affected by the problem, while P4032 and RM200 spit
   a good number of bad packets.  Right now I guess we've got some other
   problem, maybe memory corruption.

  Ralf
