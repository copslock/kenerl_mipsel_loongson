Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id UAA367918 for <linux-archive@neteng.engr.sgi.com>; Wed, 10 Sep 1997 20:53:06 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA01925 for linux-list; Wed, 10 Sep 1997 20:51:36 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA01905 for <linux@engr.sgi.com>; Wed, 10 Sep 1997 20:51:33 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id UAA05114
	for <linux@engr.sgi.com>; Wed, 10 Sep 1997 20:51:27 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from grass (ralf@grass.uni-koblenz.de [141.26.4.65]) by informatik.uni-koblenz.de (8.8.6/8.6.9) with SMTP id FAA08065 for <linux@engr.sgi.com>; Thu, 11 Sep 1997 05:51:11 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199709110351.FAA08065@informatik.uni-koblenz.de>
Received: by grass (SMI-8.6/KO-2.0)
	id FAA11485; Thu, 11 Sep 1997 05:51:07 +0200
Subject: R5000 caches
To: linux@cthulhu.engr.sgi.com
Date: Thu, 11 Sep 1997 05:51:07 +0200 (MET DST)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

Can anybody give me a pointer to where the R5000 caches, especially
the cache instruction, are documented?  My two IDT R5000 manuals don't
contain the least bit of information regarding the cache instruction.
I'm primarily interested in how the indexed operations select the
cache set of the primary caches to operate on.  On the R4600 which has
16kb per cache bit 13 selects the set.  So I assume it's bit 14 on the
R5000 with it's 32kb per cache?  The code from David handles the
R5000 like a R4000 CPU but this doesn't look very credible to me as
this is a QED CPU and the other members of the R5k family like the
Nevada (which run Linux now also!) have two way primary caches.

  Ralf
