Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id XAA229702 for <linux-archive@neteng.engr.sgi.com>; Fri, 12 Sep 1997 23:45:09 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id XAA05557 for linux-list; Fri, 12 Sep 1997 23:44:56 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA05549 for <linux@engr.sgi.com>; Fri, 12 Sep 1997 23:44:54 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id XAA11718
	for <linux@engr.sgi.com>; Fri, 12 Sep 1997 23:44:50 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from zaphod (ralf@zaphod.uni-koblenz.de [141.26.4.13]) by informatik.uni-koblenz.de (8.8.6/8.6.9) with SMTP id IAA29592; Sat, 13 Sep 1997 08:44:48 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199709130644.IAA29592@informatik.uni-koblenz.de>
Received: by zaphod (SMI-8.6/KO-2.0)
	id IAA28007; Sat, 13 Sep 1997 08:44:45 +0200
Subject: Modutils 2.1.55
Date: Sat, 13 Sep 1997 08:44:45 +0200 (MET DST)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Apparently-To: <linux@cthulhu.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

I've upgraded the modutils to 2.1.55.  Since I've seen no ill effects
so far with modutils under Linux/MIPS I've sent the patches to
rth for inclusion in the standard package.  Patches are in the CVS
archive on ftp.linux.sgi.com, as well as a source and little endian
binary package.  I could not connect to fnet, so for now these files
will only be available on ftp.linux.sgi.com.

  Ralf
