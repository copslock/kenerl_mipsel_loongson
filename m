Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id KAA1388512; Sat, 26 Jul 1997 10:27:30 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA11931 for linux-list; Sat, 26 Jul 1997 10:27:07 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA11912 for <linux@engr.sgi.com>; Sat, 26 Jul 1997 10:27:02 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA04967
	for <linux@engr.sgi.com>; Sat, 26 Jul 1997 10:27:01 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id TAA00825 for <linux@engr.sgi.com>; Sat, 26 Jul 1997 19:26:57 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199707261726.TAA00825@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id TAA07058; Sat, 26 Jul 1997 19:26:56 +0200
Subject: Modules
To: linux@cthulhu.engr.sgi.com
Date: Sat, 26 Jul 1997 19:26:55 +0200 (MET DST)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I tracked the modules bug down.  Turned out that it was an I/D cache
coherency problem; the modutils work fine as they are in the CVS on
Linus.  Right now I really wonder why modules work at all on any
architecture with split I/D caches.

I've built a Indy kernel with 40 modules configured.  Of these 35
seem to be working.  Not that I have taken myself the time to create
the test setups for testing them all ...  Those that don't work on a
Indy are psaux, sgiwd33, ipv6, msdos and binfmt_java.

I'd also use this occasion to introduce Thomas Bogendoerfer on this
list.  Thomas is currently as far as time permits _the_ Olivetti M700
hacker.  Means that he will also get live back into your Magnums :-)

  Ralf
