Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA06438; Fri, 27 Jun 1997 07:32:12 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id HAA17076 for linux-list; Fri, 27 Jun 1997 07:31:53 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA17059 for <linux@engr.sgi.com>; Fri, 27 Jun 1997 07:31:51 -0700
Received: from alles.intern.julia.de (loehnberg1.core.julia.de [194.221.49.2]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id HAA28530
	for <linux@engr.sgi.com>; Fri, 27 Jun 1997 07:31:32 -0700
	env-from (ralf@Julia.DE)
Received: from kernel.panic.julia.de (kernel.panic.julia.de [194.221.49.153])
	by alles.intern.julia.de (8.8.5/8.8.5) with ESMTP id PAA06654
	for <linux@engr.sgi.com>; Fri, 27 Jun 1997 15:19:22 +0200
From: Ralf Baechle <ralf@Julia.DE>
Received: (from ralf@localhost)
          by kernel.panic.julia.de (8.8.4/8.8.4)
	  id QAA12191 for linux@engr.sgi.com; Fri, 27 Jun 1997 16:19:55 +0200
Message-Id: <199706271419.QAA12191@kernel.panic.julia.de>
Subject: Crypto software
To: linux@cthulhu.engr.sgi.com
Date: Fri, 27 Jun 1997 16:19:54 +0200 (MET DST)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

While mirroring kernel.panic to linus I noticed that I have crypto software
(mipsel-linux binaries of ssh-1.2.17) on it.  So the question is now how we
handle this.  Should we not make these binaries available at all on
linus or is adding a banner "Don't download this if ..." sufficient?

  Ralf
