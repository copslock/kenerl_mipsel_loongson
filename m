Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id JAA111984; Tue, 12 Aug 1997 09:33:25 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA06650 for linux-list; Tue, 12 Aug 1997 09:32:58 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA06502 for <linux@cthulhu.engr.sgi.com>; Tue, 12 Aug 1997 09:32:40 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id JAA10577
	for <linux@cthulhu.engr.sgi.com>; Tue, 12 Aug 1997 09:32:04 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id LAA07889;
	Tue, 12 Aug 1997 11:26:43 -0500
Date: Tue, 12 Aug 1997 11:26:43 -0500
Message-Id: <199708121626.LAA07889@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: ralf@mailhost.uni-koblenz.de
CC: ralf@mailhost.uni-koblenz.de, linux@cthulhu.engr.sgi.com
In-reply-to: <199708120407.GAA03608@informatik.uni-koblenz.de> (message from
	Ralf Baechle on Tue, 12 Aug 1997 06:07:06 +0200 (MET DST))
Subject: Re: Bottom half bug
X-Lost: In case of doubt, make it sound convincing
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> I finally tracked the problem with <CTRL>-s locking up the machine down.
> It's a missing restore_flags() in the newport driver that makes the
> keyboard driver bottom half go bobo.  Also we were missing irq_enter/
> irq_leave in the Indy interrupt handler.  The patch, well, it's in my
> suit case.  Have fun with your crashing boxes :-)

Thanks for the pointers.  They are fixed in my tree now :-).

Cheers,
Miguel.
