Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id QAA09090 for <linux-archive@neteng.engr.sgi.com>; Tue, 14 Oct 1997 16:59:18 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA14822 for linux-list; Tue, 14 Oct 1997 16:58:34 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA14810 for <linux@engr.sgi.com>; Tue, 14 Oct 1997 16:58:31 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA03601
	for <linux@engr.sgi.com>; Tue, 14 Oct 1997 16:58:29 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from erbse (ralf@erbse.uni-koblenz.de [141.26.5.44]) by informatik.uni-koblenz.de (8.8.7/8.6.9) with SMTP id BAA08226; Wed, 15 Oct 1997 01:58:21 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199710142358.BAA08226@informatik.uni-koblenz.de>
Received: by erbse (SMI-8.6/KO-2.0)
	id BAA25872; Wed, 15 Oct 1997 01:58:19 +0200
Subject: static rpm bug, dynamic linker
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Date: Wed, 15 Oct 1997 01:58:18 +0200 (MET DST)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

I spent a lot of time on fixing the dynamic linker.  The bugs Miguel
found by building native X libraries are fixed by now.  The only one
that still is still giving me a miracle to solve is the fact that
certain statically linked executables, most prominently rpm, are
failing.

I'm about to fix that one also and that long want to remind people that
static linking is a dead concept anyway.  rpm for example will load a
dynamic libc when using the nss services, so all you get is bloat while
the knowledge about the kernel interfaces embedded into the statically
linked libc makes it very difficult to improve system interfaces.

  Ralf
