Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id VAA42446; Mon, 11 Aug 1997 21:10:22 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA26201 for linux-list; Mon, 11 Aug 1997 21:07:34 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA26137 for <linux@cthulhu.engr.sgi.com>; Mon, 11 Aug 1997 21:07:24 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id VAA25449
	for <linux@cthulhu.engr.sgi.com>; Mon, 11 Aug 1997 21:07:21 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.6/8.6.9) with SMTP id GAA03608; Tue, 12 Aug 1997 06:07:09 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199708120407.GAA03608@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id GAA23511; Tue, 12 Aug 1997 06:07:06 +0200
Subject: Re: Bottom half bug
To: miguel@nuclecu.unam.mx (Miguel de Icaza)
Date: Tue, 12 Aug 1997 06:07:06 +0200 (MET DST)
Cc: ralf@mailhost.uni-koblenz.de, linux@cthulhu.engr.sgi.com
In-Reply-To: <199708112359.SAA03734@athena.nuclecu.unam.mx> from "Miguel de Icaza" at Aug 11, 97 06:59:07 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>   Well, the major problem with getting gdb up was that init is for
> some reason setting the blocked signal mask to 0x39 (this includes
> sighup, sigtrap and a couple of others).  
> 
>   I will debug this next, right now I have this gross hack on gdb to
> reset the signal mask to zero.  Any ideas of why would init be doing this?

Well, I'll look at this when I get off the plane or so ...

I finally tracked the problem with <CTRL>-s locking up the machine down.
It's a missing restore_flags() in the newport driver that makes the
keyboard driver bottom half go bobo.  Also we were missing irq_enter/
irq_leave in the Indy interrupt handler.  The patch, well, it's in my
suit case.  Have fun with your crashing boxes :-)

California, I'm comin',

  Ralf
