Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id SAA1246357 for <linux-archive@neteng.engr.sgi.com>; Thu, 2 Oct 1997 18:24:45 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA13739 for linux-list; Thu, 2 Oct 1997 18:24:07 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA13719 for <linux@engr.sgi.com>; Thu, 2 Oct 1997 18:24:04 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA14828
	for <linux@engr.sgi.com>; Thu, 2 Oct 1997 16:02:50 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from erbse (ralf@erbse.uni-koblenz.de [141.26.5.44]) by informatik.uni-koblenz.de (8.8.7/8.6.9) with SMTP id BAA04831; Fri, 3 Oct 1997 01:01:08 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199710022301.BAA04831@informatik.uni-koblenz.de>
Received: by erbse (SMI-8.6/KO-2.0)
	id BAA05365; Fri, 3 Oct 1997 01:01:06 +0200
Subject: Guess it's getting stable ...
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Date: Fri, 3 Oct 1997 01:01:05 +0200 (MET DST)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

That's the best scene from the movie I'm just enjoying:

  3:44pm  up  1:02,  2 users,  load average: 137.09, 95.96, 57.83
276 processes: 188 sleeping, 86 running, 2 zombie, 0 stopped
CPU states: 52.9% user, 35.3% system, 66.5% nice, 18.2% idle
Mem:   63636K av,  62388K used,   1248K free,  72900K shrd,    440K buff
Swap: 130748K av,  95288K used,  35460K free                  4412K cached

That's compiling two kernels, glibc, gcc, binutils and CVS with make -j.
I think I forgot to run a couple of crashmes ...

  Ralf
