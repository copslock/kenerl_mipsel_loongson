Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id TAA718159 for <linux-archive@neteng.engr.sgi.com>; Mon, 22 Sep 1997 19:43:58 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA22164 for linux-list; Mon, 22 Sep 1997 19:43:36 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA22156 for <linux@cthulhu.engr.sgi.com>; Mon, 22 Sep 1997 19:43:35 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id TAA26643 for <linux@fir.engr.sgi.com>; Mon, 22 Sep 1997 19:43:33 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA22148 for <linux@fir.engr.sgi.com>; Mon, 22 Sep 1997 19:43:32 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id TAA10388
	for <linux@fir.engr.sgi.com>; Mon, 22 Sep 1997 19:43:31 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id VAA16659;
	Mon, 22 Sep 1997 21:32:19 -0500
Date: Mon, 22 Sep 1997 21:32:19 -0500
Message-Id: <199709230232.VAA16659@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux-mips@fnet.fr, linux@fir.engr.sgi.com
Subject: Task list --preliminary list
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Here is a preliminary task list of things that should be done for a
complete Linux/MIPS port, right now it includes by personal favorites
and I am working on some of those bits, but some of the other can be
done now, I have a copy of this at:

	http://www.nuclecu.unam.mx/~miguel/mips-task-list.txt

Priority: 

[9]  Get more userland programs compiled in RPM form

[9]  Merging the latest GNU libc releases.

[9]  Get the X libraries compiled.

[5]  Getting SGI mouse to work.

[5]  Test the STREAMS implementation of the mouse.

[6]  Figure why init is setting the sigprocmask to a value different
     from 0.  This disables the debugger (SIGTRAP is disabled for
     all child processes).

[7]  Getting IRIX X server to accept connections.

Please, send me additions to this list.
Miguel.
