Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id VAA143797 for <linux-archive@neteng.engr.sgi.com>; Wed, 11 Feb 1998 21:03:06 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA27319 for linux-list; Wed, 11 Feb 1998 21:00:12 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA27306 for <linux@engr.sgi.com>; Wed, 11 Feb 1998 21:00:10 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id VAA02746
	for <linux@engr.sgi.com>; Wed, 11 Feb 1998 21:00:09 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-06.uni-koblenz.de [141.26.249.6])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id GAA02621
	for <linux@engr.sgi.com>; Thu, 12 Feb 1998 06:00:06 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id FAA11617;
	Thu, 12 Feb 1998 05:56:48 +0100
Message-ID: <19980212055648.54198@uni-koblenz.de>
Date: Thu, 12 Feb 1998 05:56:48 +0100
To: linux-kernel@vger.rutgers.edu, linux@cthulhu.engr.sgi.com
Subject: TLB entries > 4kb
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Some architectures can use multiple page sizes in the TLB at the same time.
This would for example allow to map memory allocations > PAGE_SIZE using just
a single TLB entry if the circumstances are just right, thereby
reducing / eleminating TLB trashing.  This should improve the performance
for huge apps quite a bit.  Some architectures could partially get rid of
the sick effects of their virtual indexed primary caches as well.  All that
is needed for this to work is to have sufficiently large physical pages with
sufficient alignment at hand.

Has anybody ever looked into implementing that?  What architectures besides
MIPS could take advantage of such a feature?

  Ralf
