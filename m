Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id KAA258728 for <linux-archive@neteng.engr.sgi.com>; Thu, 23 Oct 1997 10:08:08 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA03741 for linux-list; Thu, 23 Oct 1997 10:07:01 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA03689 for <linux@engr.sgi.com>; Thu, 23 Oct 1997 10:06:54 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA01551
	for <linux@engr.sgi.com>; Thu, 23 Oct 1997 10:06:52 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from ozzy.uni-koblenz.de (946@ozzy.uni-koblenz.de [141.26.5.8]) by informatik.uni-koblenz.de (8.8.7/8.6.9) with ESMTP id TAA24158 for <linux@engr.sgi.com>; Thu, 23 Oct 1997 19:06:49 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199710231706.TAA24158@informatik.uni-koblenz.de>
Received: by ozzy.uni-koblenz.de (8.8.5/KO-2.0)
	id TAA03674; Thu, 23 Oct 1997 19:05:11 +0200
Subject: Magnum 4000 caches
To: linux@cthulhu.engr.sgi.com
Date: Thu, 23 Oct 1997 19:05:10 +0200 (MEST)
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

maybe one of the old Mips people can answer me two questions:

 - why do the Magnum 4000PC instruction and data caches have a different
   linesize for the L1 caches, but the Magnum 4000SC not?
 - does the Magnum 4000SC use a split instruction/data L2 cache?

TIA,

  Ralf
