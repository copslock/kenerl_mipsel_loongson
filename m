Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id NAA436882 for <linux-archive@neteng.engr.sgi.com>; Fri, 5 Dec 1997 13:26:29 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA14404 for linux-list; Fri, 5 Dec 1997 13:21:18 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA14367 for <linux@engr.sgi.com>; Fri, 5 Dec 1997 13:21:09 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA19440
	for <linux@engr.sgi.com>; Fri, 5 Dec 1997 13:21:07 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-14.uni-koblenz.de [141.26.249.14])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id WAA03116
	for <linux@engr.sgi.com>; Fri, 5 Dec 1997 22:21:05 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id WAA03655;
	Fri, 5 Dec 1997 22:14:44 +0100
Message-ID: <19971205221443.34173@uni-koblenz.de>
Date: Fri, 5 Dec 1997 22:14:43 +0100
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: Grrr...
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ok, I isolated the GCC problem I reported earlier today.  The following
little program which I extracted from binutils-2.8.1-1 will crash cc1 on
some Linux/MIPS boxes with SIGSEGV when compiled with optimization enabled:

  bfd_link_section_stabs (void)
  {
          unsigned long long i, count;

          for (i = 0; i < count; i++);
  }

It seems to be important that

 - i is unsigned long long
 - count is uninitialized

  Ralf
