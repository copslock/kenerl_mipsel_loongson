Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id EAA22755; Wed, 9 Jul 1997 04:02:30 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id EAA07942 for linux-list; Wed, 9 Jul 1997 04:01:44 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA07935 for <linux@engr.sgi.com>; Wed, 9 Jul 1997 04:01:41 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id DAA18258
	for <linux@engr.sgi.com>; Wed, 9 Jul 1997 03:59:54 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from schlegel (ralf@schlegel.uni-koblenz.de [141.26.4.59]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id MAA11503 for <linux@engr.sgi.com>; Wed, 9 Jul 1997 12:59:29 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199707091059.MAA11503@informatik.uni-koblenz.de>
Received: by schlegel (SMI-8.6/KO-2.0)
	id MAA26120; Wed, 9 Jul 1997 12:59:26 +0200
Subject: Emacs & e2fsutils
To: linux@cthulhu.engr.sgi.com
Date: Wed, 9 Jul 1997 12:59:26 +0200 (MET DST)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Yesterday I digged David's patches out of the FSF's Emacs archive.  It
builds and seems run without problems with these patches.  I just
had to hack 'em a bit to add support of little endian machines.

The problem with the e2fstutils not compiling out of the box turned
out to be a problem in the autoconf generated configure script.
Including <netinet/in.h> results in a warning and that again makes
the script assumes that we don't have <netinet/in.h> at all ...

  Ralf
